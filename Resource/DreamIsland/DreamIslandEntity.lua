------------------------------------------------------------
--EventEntity.lua Created by knight 2005.5.16.
--
--定义各个地图上的事件实体
print( "loading EventEntity.lua" )
-------------------------------------------------------------

--初始化加纳大陆的事件实体信息
function InitDreamIslandEntity()

	--创建加纳大陆港口实体
	-- CreateBerthEntity( "入港", 455, 2, 225065, 281984, 0, 1, 2231, 2827, 0 )
	-- CreateBerthEntity( "入港", 455, 2, 326048, 330919,-10, 5, 3260,3280, 0 )
	-- CreateBerthEntity( "入港", 455, 2, 230572, 112347,-10, 6, 2273,1122, 0 )
	-- CreateBerthEntity( "入港", 455, 2, 363213, 74776,-10, 7, 3590,755, 0 )
	-- CreateBerthEntity( "入港", 455, 2, 105831, 133151,-10, 2, 1058,1323, 0 )
	
	--创建箱子实体
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 159319, 275344, 129, 3973, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 163363, 265076, 69, 3973, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 161248, 271701, 84, 3973, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 457, 3, 154428, 270697, 99, 3974, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 457, 3, 154428, 270697, 99, 3974, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 457, 3, 153274, 274001, 144, 3974, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 163737, 277868, 189, 3975, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 157172, 267995, 204, 3975, 1, 180 )
	-- CreateResourceEntity( "丢失的工具箱", 456, 3, 154788, 264604, 159, 3975, 1, 180 )
	-- CreateResourceEntity( "不明的木桶", 457, 3, 221750, 254779, 144, 3977, 1, 180 )
	-- CreateResourceEntity( "恐龟巢穴", 458, 3, 97144, 266563, 144, 4073, 1, 180 )
	-- CreateResourceEntity( "恐龟巢穴", 458, 3, 91154, 263547, 99, 4073, 1, 180 )
	-- CreateResourceEntity( "恐龟巢穴", 458, 3, 90400, 266712, 84, 4073, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 114500, 314300, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 117200, 315300, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 121400, 315100, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 122800, 310700, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 115500, 308700, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "草原龟巢穴", 458, 3, 120500, 305000, 84, 4089, 1, 180 )
	-- CreateResourceEntity( "祈运魔法石", 468, 3, 109800, 257200, 84, 4092, 1, 180 )
	-- CreateResourceEntity( "祈运魔法石", 468, 3, 107800, 260200, 84, 4092, 1, 180 )
	-- CreateResourceEntity( "祈运魔法石", 468, 3, 112800, 257000, 84, 4092, 1, 180 )
	-- CreateResourceEntity( "猫头鹰巢穴", 463, 3, 126372, 296071, 114, 4086, 1, 180 )
	-- CreateResourceEntity( "猫头鹰巢穴", 463, 3, 124400, 293900, 114, 4086, 1, 180 )
	-- CreateResourceEntity( "猫头鹰巢穴", 463, 3, 126825, 306083, 144, 4086, 1, 180 )
	-- CreateResourceEntity( "野蛮蜂蜂巢", 466, 3, 154462, 313471, 96, 4085, 1, 180 )
	-- CreateResourceEntity( "野蛮蜂蜂巢", 466, 3, 156862, 318303, 174, 4085, 1, 180 )
	-- CreateResourceEntity( "野蛮蜂蜂巢", 466, 3, 161567, 315811, -34, 4085, 1, 180 )
	-- CreateResourceEntity( "遗弃的恐龟巢穴", 458, 3, 88300, 257200, 99, 4093, 1, 180 )
	-- CreateResourceEntity( "遗弃的恐龟巢穴", 458, 3, 99100, 265200, 99, 4093, 1, 180 )
	-- CreateResourceEntity( "遗弃的恐龟巢穴", 458, 3, 102400, 251600, 99, 4093, 1, 180 )
	-- CreateResourceEntity( "山贼的钱箱", 456, 3, 102584, 306100, 144, 4087, 1, 180 )
	-- CreateResourceEntity( "珍贵的药草", 220, 3, 132343, 264215, 249, 4090, 1, 180 )
	-- CreateResourceEntity( "珍贵的药草", 220, 3, 126478, 266233, -154, 4090, 1, 180 )
	-- CreateResourceEntity( "珍贵的药草", 220, 3, 120307, 262026, 294, 4090, 1, 180 )
	-- CreateResourceEntity( "蜥蜴巢穴", 458, 3, 68592, 263459, 39, 4094, 1, 180 )
	-- CreateResourceEntity( "蜥蜴巢穴", 458, 3, 68303, 270607, 9, 4094, 1, 180 )
	-- CreateResourceEntity( "蜥蜴巢穴", 458, 3, 73415, 268141, 144, 4094, 1, 180 )
--徐瑾-----start
	-- CreateResourceEntity( "丢失的秘匙", 457, 3, 89300, 102300, 150, 7196, 1, 180 )
--徐瑾--end


end

InitDreamIslandEntity()