--------------------------------------------------------------------------
--									--
--									--
--				MissionSdk.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionSdk.lua" )


--脚本系统返回值定义
LUA_TRUE 			= 1
LUA_FALSE			= 0
LUA_ERROR			= -1
LUA_NULL			= 0

--任务系统脚本
TE_MAPINIT		= 0			--出生
TE_NPC				= 1			--npc携带
TE_KILL				= 2			--摧毁物件
TE_GAMETIME		= 3			--游戏时间
TE_CHAT			= 4			--聊天关键字
TE_GETITEM		= 5			--拾取物品
TE_EQUIPITEM	= 6			--装备物品
TE_GOTO_MAP    = 7			--到达目标点	（角色触发器存储）参数1，地图ID， 参数2，地图到达随机率，参数3，地图坐标x，参数4, 地图坐标y
TE_LEVELUP      	= 8			--升级			（角色触发器存储）参数1，是否主动关闭（触发器动作后关闭），参数2，是否每个等级都触发，参数3，指定等级触发

--触发器时间类型
TT_CYCLETIME	= 0			--时间循环
TT_MULTITIME	= 1			--循环运行n次
		
--触发器最大携带条件数量
TR_MAXNUM_CONDITIONS		= 12
TR_MAXNUM_ACTIONS			= 12

--npc任务状态信息定义
MIS_ACCEPT       = 1			--有符合条件可以接的任务
MIS_DELIVERY     = 2			--已完成可交付的任务
MIS_PENDING		= 4			--已完成可交付的任务
MIS_IGNORE		= 8			--不符合条件可以接的任务

--任务列表页操作命令
MIS_PREV			= 0			--请求发送任务列表的上一页信息
MIS_NEXT			= 1			--请求发送任务列表的下一页信息
MIS_PREV_END	= 2			--任务列表没有上一页信息
MIS_NEXT_END	= 3			--任务列表没有下一页信息
MIS_SEL				= 4			--请求选择任务列表项目
MIS_TALK			= 5			--请求任务对话信息
MIS_BTNACCEPT	= 6			--请求接受任务
MIS_BTNDELIVERY= 7			--请求交付任务
MIS_BTNPENDING	= 8			--未决任务请求（客户端禁止按钮）
MIS_LOG			= 9			--请求任务日志信息

--任务信息定义
--完成 任务需求类型定义
MIS_NEED_ITEM		= 0		--需要获取物品
MIS_NEED_KILL		= 1		--需要摧毁物件
MIS_NEED_SEND		= 2        --需要送给某人
MIS_NEED_CONVOY	= 3 		--需要护送到某的
MIS_NEED_EXPLORE = 4		--需要探索某的
MIS_NEED_DESP		= 5		--文字表述的任务目标

--完成任务奖励类型定义
MIS_PRIZE_ITEM		= 0		--奖励物品
MIS_PRIZE_MONEY	= 1		--奖励金钱
MIS_PRIZE_FAME		= 2		--奖励声望
MIS_PRIZE_CESS		= 3		--奖励贸易税率
MIS_PRIZE_PETEXP  = 4		--奖励宠物经验值

--角色职业类型
MIS_NOVICE			= 0		--新手
MIS_FENCER			= 1		--剑士
MIS_HUNTER			= 2		--猎人
MIS_EXPERIENCED	= 2		--水手
MIS_RISKER			= 4		--冒险者
MIS_DOCTOR			= 5		--医生(祈愿使)
MIS_TECHNICIAN		= 6		--技师
MIS_TRADER			= 7		--商人
MIS_LARGE_FENCER  = 8		--巨剑士
MIS_TWO_FENCER    = 9		--双剑士
MIS_SHIELD_FENCER = 10		--剑盾士
MIS_WILD_ANIMAL_TRAINER = 11 --驯兽师
MIS_GUNMAN			= 12      --狙击手
MIS_CLERGY			= 13		--圣职者
MIS_SEALER			= 14		--封印师
MIS_SHIPMASTER	= 15		--船长
MIS_VOYAGE			= 16		--航海士
MIS_ARRIVISTE		= 17		--暴发户
MIS_ENGINEER			= 18		--工程师

--公会类型
MIS_GUILD_NAVY		= 0		--海军公会
MIS_GUILD_PIRATE   = 1		--海盗公会

--永远为假
function AlwaysFailure()
	return LUA_FALSE
end

--永久为真
function AlwaysTrue()
	return LUA_TRUE
end

--没有历史标签
function NoRecord( character, record )
	if record == nil then
		MISSDK_MISSIONSDK_LUA_000001 = GetResString("MISSDK_MISSIONSDK_LUA_000001")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000001 )
		return LUA_ERROR
	end
	local ret = IsValidRecord( character, record )
	if ret == LUA_FALSE then
		MISSDK_MISSIONSDK_LUA_000002 = GetResString("MISSDK_MISSIONSDK_LUA_000002")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000002 )
		return LUA_ERROR
	end
	
	ret = IsRecord( character, record )
	if ret ~= LUA_TRUE then
		return LUA_TRUE
	end
	return LUA_FALSE
end

--检测技能状态
function HasState( character, state_id )
	if state_id == nil then
		MISSDK_MISSIONSDK_LUA_000003 = GetResString("MISSDK_MISSIONSDK_LUA_000003")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000003 )
		return LUA_ERROR
	end
	
	local ret = GetChaStateLv( character, state_id )
	if ret ~= nil then
		if ret > 0 then
			return LUA_TRUE
		end
	end
	return LUA_FALSE
end

--检测角色体型
function IsChaType( character, type_id )
	if type_id == nil then
		MISSDK_MISSIONSDK_LUA_000004 = GetResString("MISSDK_MISSIONSDK_LUA_000004")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000004 )
		return LUA_ERROR
	end
	
	local ret = GetChaBody( character )
	if ret == type_id then
		return LUA_TRUE
	end
	return LUA_FALSE
end

--检测不是角色体型
function NoChaType( character, type_id )
	if type_id == nil then
		MISSDK_MISSIONSDK_LUA_000005 = GetResString("MISSDK_MISSIONSDK_LUA_000005")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000005 )
		return LUA_ERROR
	end
	
	local ret = GetChaBody( character )
	if ret ~= type_id then
		return LUA_TRUE
	end
	return LUA_FALSE
end
--播放特效
function Starteffect( character, npc, tp )
		
	if tp == nil then
		MISSDK_MISSIONSDK_LUA_000006 = GetResString("MISSDK_MISSIONSDK_LUA_000006")
		PRINT( MISSDK_MISSIONSDK_LUA_000006 )
		MISSDK_MISSIONSDK_LUA_000006 = GetResString("MISSDK_MISSIONSDK_LUA_000006")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000006 )
		return LUA_ERROR	
	end
	
	PRINT( "Starteffect, p1 = "..tp )
	PlayEffect( npc, tp )
	return LUA_TRUE
end
--是否有历史标签
function HasRecord( character, record )
	if record == nil then
		MISSDK_MISSIONSDK_LUA_000007 = GetResString("MISSDK_MISSIONSDK_LUA_000007")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000007 )
		return LUA_ERROR
	end
	local ret = IsValidRecord( character, record )
	if ret == LUA_FALSE then
		MISSDK_MISSIONSDK_LUA_000008 = GetResString("MISSDK_MISSIONSDK_LUA_000008")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000008 )
		return LUA_ERROR
	end
	return IsRecord( character, record )
end

--没有任务记录标签
function NoFlag( character, id, flag )
	if id == nil or flag == nil then
		MISSDK_MISSIONSDK_LUA_000009 = GetResString("MISSDK_MISSIONSDK_LUA_000009")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000009 )
		return LUA_ERROR
	end	
	local ret = IsValidFlag( character, flag )
	if ret == LUA_FALSE then
		MISSDK_MISSIONSDK_LUA_000010 = GetResString("MISSDK_MISSIONSDK_LUA_000010")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000010 )
		return LUA_ERROR
	end
	ret = IsFlag( character, id, flag )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE
end

--不能有该任务护送NPC
function NoConvoyNpc( character, misid )
	if misid == nil then
		MISSDK_MISSIONSDK_LUA_000011 = GetResString("MISSDK_MISSIONSDK_LUA_000011")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000011 )
		return LUA_ERROR
	end
	
	local ret = HasConvoyNpc( character, misid )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	
	return LUA_TRUE
end

--随机任务送物件给npc时，判断是否npc已经接受过该物品
--function NoRandNpcItemFlag( character, misid, npcid )
--	if misid == nil or npcid == nil then
--		SystemNotice( character, "NoRandNpcItemFlag:函数参数错误！" )
--		return LUA_ERROR
--	end
--	
--	local ret = HasRandNpcItemFlag( character, misid, npcid )
--	if ret == LUA_TRUE then
--		return LUA_FALSE
--	end
--	return LUA_TRUE
--end

--没有任务标签
function NoMission( character, id )
	if id == nil then
		MISSDK_MISSIONSDK_LUA_000012 = GetResString("MISSDK_MISSIONSDK_LUA_000012")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000012 )
		return LUA_ERROR
	end
	local ret = HasMission( character, id )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE
end

--没有指定得随机任务
function NoRandMission( character, id )
	if id == nil then
		MISSDK_MISSIONSDK_LUA_000013 = GetResString("MISSDK_MISSIONSDK_LUA_000013")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000013 )
		return LUA_ERROR
	end
	
	local ret = HasRandMission( character, id )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE
end

--任务没有失败
function NoMisssionFailure( character, id )
	if id == nil then
		MISSDK_MISSIONSDK_LUA_000014 = GetResString("MISSDK_MISSIONSDK_LUA_000014")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000014 )
		return LUA_ERROR
	end
	
	local ret = HasMisssionFailure( character, id )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE	
end

function IsMission( character, id )
	if id == nil then
		MISSDK_MISSIONSDK_LUA_000015 = GetResString("MISSDK_MISSIONSDK_LUA_000015")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000015 )
		return LUA_ERROR
	end
	return HasMission( character, id )
end

function NoGuild( character )
	local ret = HasGuild( character )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE
end

function NoPfEqual( character, pf )
	local ret = PfEqual( character, pf )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	return LUA_TRUE
end

--添加指定的下一个任务记录标签
function AddNextFlag( character, id, startflag, count )
	if id == nil or startflag == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000016 = GetResString("MISSDK_MISSIONSDK_LUA_000016")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000016 )
	end
	local num = 0
	for i = 1, count, 1 do
		local ret = IsFlag( character, id, startflag + num )
		if ret == LUA_FALSE then
			PRINT( "AddNextFlag: flag = ", startflag + num )
			ret = SetFlag( character, id, startflag + num )
			RefreshCompleteFlag(character,MissionSid[id])
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000017 = GetResString("MISSDK_MISSIONSDK_LUA_000017")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000017 )
				return LUA_ERROR
			end
			return LUA_TRUE
		end
		num = num + 1
	end
	return LUA_TRUE
end

--设置下一个随机任务记录标签
function AddRMNextFlag( character, id, startflag, count )
	if id == nil or startflag == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000018 = GetResString("MISSDK_MISSIONSDK_LUA_000018")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000018 )
	end
	local num = 0
	for i = 1, count, 1 do
		local ret = HasFlag( character, id, startflag + num )
		if ret == LUA_FALSE then
			PRINT( "AddRMNextFlag: flag = ", startflag + num )
			ret = SetFlag( character, id, startflag + num )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000019 = GetResString("MISSDK_MISSIONSDK_LUA_000019")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000019 )
				return LUA_ERROR
			end
			return LUA_TRUE
		end
		num = num + 1
	end
	return LUA_TRUE
end
-----------船或者在这个港口或者在那个港口
-- function HasAllBoatInBerth_eitheror( character, p1, p2 )
-- 	local ret1 = HasAllBoatInBerth( character, p1 )
--	local ret2 = HasAllBoatInBerth( character, p2 )
--	if ret1 ~= LUA_TRUE and  ret2 ~= LUA_TRUE  then
--		PRINT( "ConditionsTest:HasAllBoatInBerth_eitheror = false" )
--		return LUA_FALSE
--	end
--	if ret1 == LUA_TRUE  then
--		return LUA_TRUE
--	end
--	if  ret2 == LUA_TRUE  then
--		return LUA_TRUE
--	end
-- end
--检测任务记录标签信息
function HasFlag( character, id, flag )
	if id == nil or flag == nil then
		MISSDK_MISSIONSDK_LUA_000020 = GetResString("MISSDK_MISSIONSDK_LUA_000020")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000020 )
		return LUA_ERROR
	end
	local ret = IsValidFlag( character, flag )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000021 = GetResString("MISSDK_MISSIONSDK_LUA_000021")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000021 )
		return LUA_ERROR
	end
	ret = IsFlag( character, id, flag )
	return ret
end

--检测一个序列的任务记录标签信息
function HasAllFlag( character, id, startflag, count )
	if id == nil or startflag == nil or count then
		MISSDK_MISSIONSDK_LUA_000022 = GetResString("MISSDK_MISSIONSDK_LUA_000022")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000022 )
		return LUA_ERROR
	end
	local num = 0
	for i = 1, count, 1 do
		local ret = IsFlag( character, id, startflag + num )
		if ret ~= LUA_TRUE then
			return LUA_FALSE
		end
		num = num + 1
	end
	return LUA_TRUE
end

--获取一个序列的任务标签记录数量信息
function GetNumFlag( character, id, startflag, count )
	if id == nil or startflag == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000023 = GetResString("MISSDK_MISSIONSDK_LUA_000023")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000023 )
		return 0
	end
	local num = 0
	for i = 1, count, 1 do
		local ret = IsFlag( character, id, startflag + num )
		if ret ~= LUA_TRUE then
			break
		end
		num = num + 1
	end
	return num
end

--检验值
function IsValue( id1, id2 )
	if id1 == nil or id2 == nil then
		MISSDK_MISSIONSDK_LUA_000024 = GetResString("MISSDK_MISSIONSDK_LUA_000024")
		PRINT( MISSDK_MISSIONSDK_LUA_000024 )
		MISSDK_MISSIONSDK_LUA_000024 = GetResString("MISSDK_MISSIONSDK_LUA_000024")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000024 )
		return LUA_ERROR
	end
	if id1 == id2 then
		return LUA_TRUE
	end
	return LUA_FALSE
end

--检测是否是指定的怪物类型
function IsMonster( id1, id2 )
	return IsValue( id1, id2 )
end

--检测是否指定的物品类型
function IsItem( id1, id2 )
	return IsValue( id1, id2 )
end

function NoItem( character, itemid, count )
	if itemid == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000025 = GetResString("MISSDK_MISSIONSDK_LUA_000025")
		PRINT( MISSDK_MISSIONSDK_LUA_000025 )
		return LUA_ERROR
	end
	
	local ret = HasItem( character, itemid, count )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	
	return LUA_TRUE
end

function BankNoItem( character, itemid, count )
	if itemid == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000026 = GetResString("MISSDK_MISSIONSDK_LUA_000026")
		PRINT( MISSDK_MISSIONSDK_LUA_000026 )
		return LUA_ERROR
	end
	
	local ret = BankHasItem( character, itemid, count )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	
	return LUA_TRUE
end

function EquipNoItem( character, itemid, count )
	if itemid == nil or count == nil then
		MISSDK_MISSIONSDK_LUA_000027 = GetResString("MISSDK_MISSIONSDK_LUA_000027")
		PRINT( MISSDK_MISSIONSDK_LUA_000027 )
		return LUA_ERROR
	end
	
	local ret = EquipHasItem( character, itemid, count )
	if ret == LUA_TRUE then
		return LUA_FALSE
	end
	
	return LUA_TRUE
end

----Leo的声望函数判断，判断角色声上是否有固定枝的声望
function HasCredit(character,value)
	local Role_Credit = GetCredit(character)
	if value > Role_Credit then
		return LUA_FALSE
	else
		return LUA_TRUE
	end
end


--Leo end

----Leo的声望扣除，扣除角色声上的声望
function DelRoleCredit(character,npc,value)
	DelCredit(character,value)
	return LUA_TRUE
end
--Leo end


------------------死亡证明&无谓之证----------missdk
function CheckPoint (character,value)
		--SystemNotice( character , "value=="..value)
	local i= CheckBagItem( character, value )
	if i~=1 and value == 2954 then
		MISSDK_MISSIONSDK_LUA_000028 = GetResString("MISSDK_MISSIONSDK_LUA_000028")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000028)
	return LUA_FALSE
	end
	if i~=1 and value == 5803 then
		MISSDK_MISSIONSDK_LUA_000029 = GetResString("MISSDK_MISSIONSDK_LUA_000029")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000029)
	return LUA_FALSE
	end
	local Point_dead = GetChaItem2 ( character , 2 , value )
	local Point = GetItemAttr(Point_dead, ITEMATTR_VAL_STR)
	local Point_Kill = GetItemAttr(Point_dead , ITEMATTR_VAL_AGI)
		--SystemNotice( character , "您死了"..Point.."次")
	if Point < 41 and value == 2954 then
		MISSDK_MISSIONSDK_LUA_000030 = GetResString("MISSDK_MISSIONSDK_LUA_000030")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000030)
		return LUA_FALSE		
	end
	if Point_Kill < 10 and value == 5803 then
		MISSDK_MISSIONSDK_LUA_000031 = GetResString("MISSDK_MISSIONSDK_LUA_000031")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000031)
		return LUA_FALSE		
	end
	return LUA_TRUE
end


		
--------------------判断背包内无某种道具
function HaveNoItem (character,value)
		--SystemNotice( character , "value=="..value)
	local i= CheckBagItem( character, value )
	--SystemNotice( character , "i=="..i)
	if i~=0 and value == 2954 then
		MISSDK_MISSIONSDK_LUA_000032 = GetResString("MISSDK_MISSIONSDK_LUA_000032")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000032)
		return LUA_FALSE
	end
	if i~=0 and value == 5803 then
		MISSDK_MISSIONSDK_LUA_000033 = GetResString("MISSDK_MISSIONSDK_LUA_000033")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000033)
		return LUA_FALSE
	end
	return LUA_TRUE
end
		

----给角色背包固定位置添加道具
function AddChaItem1(character,npc,value)
	--SystemNotice( character ,"value=="..value)		
	local item_number = CheckBagItem( character, value )			
	if item_number >=1 then
		MISSDK_MISSIONSDK_LUA_000034 = GetResString("MISSDK_MISSIONSDK_LUA_000034")
		SystemNotice( character ,MISSDK_MISSIONSDK_LUA_000034)
		return LUA_FALSE 
	end
	------------判断背包第一栏是否为空
	--local item1=GetItemP(character,0)
	--local itemid1=GetItemID( item1 )
	--if itemid1==0 or itemid1==nil then
	--	SystemNotice( character, "请把背包第一栏的物品移开" )
	--	return LUA_FALSE
	--end

	------------取挑战书的指针
	local r1=0
	local r2=0
		--SystemNotice( character ,"r1=="..r1)
	r1,r2 =MakeItem ( character , value  , 1 , 4 )
	local Item_new = GetChaItem ( character , 2 , r2 )

	----------记录时间
	local now_yes = os.date("%y")		-------------年
	local now_month= os.date("%m")		-------------月
	local now_day= os.date("%d")		-------------日
	local now_hour= os.date("%H")		-------------时
	local now_miniute= os.date("%M")	-------------分
	local now_scend=  os.date("%S")		-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	--local CheckDateNum = NowMonthNum * 10000 + NowDayNum * 100 + NowTimeNum
	--SystemNotice ( character , "now_yes=="..now_yes )
	--SystemNotice ( character , "now_month=="..now_month )
	--SystemNotice ( character , "now_day=="..now_day )
	--SystemNotice ( character , "now_hour=="..now_hour )
	--SystemNotice ( character , "now_miniute=="..now_miniute )
	--SystemNotice ( character , "now_scend=="..now_scend )
	SetItemAttr(Item_new, ITEMATTR_VAL_STA, now_month )		-------------月 	
	SetItemAttr(Item_new, ITEMATTR_VAL_STR, now_day )		-------------日  
	SetItemAttr(Item_new, ITEMATTR_VAL_CON, now_hour )		-------------时   
	SetItemAttr(Item_new, ITEMATTR_VAL_DEX, now_miniute )		-------------分   
	SetItemAttr(Item_new, ITEMATTR_VAL_AGI, now_scend )		-------------秒 
	SynChaKitbag(character,13)
	return LUA_TRUE
end
function AddChaItem2(character,npc,value)
	local cha = ChaIsBoat ( character ) 
	if cha ==1 then
		MISSDK_MISSIONSDK_LUA_000035 = GetResString("MISSDK_MISSIONSDK_LUA_000035")
		SystemNotice( character ,MISSDK_MISSIONSDK_LUA_000035)
		return LUA_FALSE 
	end	
	------------取挑战书的指针
	local item1=GetItemP(character,0)
	local itemid1=GetItemID( item1 )
	if itemid1~=2911 then
		MISSDK_MISSIONSDK_LUA_000036 = GetResString("MISSDK_MISSIONSDK_LUA_000036")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000036 )
		return LUA_FALSE
	end
	----------记录时间
	local now_yes = os.date("%y")			-------------年
	local now_month= os.date("%m")			-------------月
	local now_day= os.date("%d")			-------------日
	local now_hour= os.date("%H")			-------------时
	local now_miniute= os.date("%M")		-------------分
	local now_scend=  os.date("%S")			-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	--SystemNotice ( character , "now_yes=="..now_yes )
	--SystemNotice ( character , "now_month=="..now_month )
	--SystemNotice ( character , "now_day=="..now_day )
	--SystemNotice ( character , "now_hour=="..now_hour )
	--SystemNotice ( character , "now_miniute=="..now_miniute )
	--SystemNotice ( character , "now_scend=="..now_scend )

	local item_old=GetItemP(character,0)
	---------去好汉书的时间	
	local old_month = GetItemAttr(item_old, ITEMATTR_VAL_STA)		-------------月 	
	local old_day = GetItemAttr(item_old, ITEMATTR_VAL_STR)			-------------日  
	local old_hour = GetItemAttr(item_old, ITEMATTR_VAL_CON)			-------------时   
	local old_miniute = GetItemAttr(item_old, ITEMATTR_VAL_DEX)		-------------分   
	local old_scend = GetItemAttr(item_old, ITEMATTR_VAL_AGI)			-------------秒 
	--SystemNotice ( character , "old_month=="..old_month )
	--SystemNotice ( character , "old_day=="..old_day )       
	--SystemNotice ( character , "old_hour=="..old_hour )    
	--SystemNotice ( character , "old_miniute=="..old_miniute)
	--SystemNotice ( character , "old_scend=="..old_scend ) 

	---------删除挑战书
	local del_item =TakeItem( character, 0,2911, 1 )			                   
	if del_item==0  then
		MISSDK_MISSIONSDK_LUA_000037 = GetResString("MISSDK_MISSIONSDK_LUA_000037")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000037)
		return LUA_FALSE
	end


	local used_time=(now_scend - old_scend)+(now_miniute - old_miniute)*60+(now_hour - old_hour)*3600+(now_day - old_day)*86400+(JNSTime_Flag[now_month] - JNSTime_Flag[old_month] )*86400
	local cha_name = GetChaDefaultName ( character )

	if used_time>28800 or used_time<0 then
		MISSDK_MISSIONSDK_LUA_000038 = GetResString("MISSDK_MISSIONSDK_LUA_000038")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000038)
		return LUA_TRUE
	elseif used_time < 2400 and used_time>0 then
		MISSDK_MISSIONSDK_LUA_000039 = GetResString("MISSDK_MISSIONSDK_LUA_000039")
		MISSDK_MISSIONSDK_LUA_000040 = GetResString("MISSDK_MISSIONSDK_LUA_000040")
		CALCULATE_FORGE_LUA_000186 = GetResString("CALCULATE_FORGE_LUA_000186")
		Notice(CALCULATE_FORGE_LUA_000186..cha_name..MISSDK_MISSIONSDK_LUA_000040..used_time..MISSDK_MISSIONSDK_LUA_000039)
	end
	if used_time < JINISI_TIME then
		JINISI_TIME=used_time
		MISSDK_MISSIONSDK_LUA_000041 = GetResString("MISSDK_MISSIONSDK_LUA_000041")
		MISSDK_MISSIONSDK_LUA_000042 = GetResString("MISSDK_MISSIONSDK_LUA_000042")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		LG( "JiNiSiJiLu_XinXi" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000042..used_time..MISSDK_MISSIONSDK_LUA_000041 )
	end
	------------取好汉书的指针
	local r1=0
	local r2=0
	r1,r2 =MakeItem ( character , value  , 1 , 4 )
	local Item_new = GetChaItem ( character , 2 , r2 )
	GiveItem ( character , 0 , 3094  , 1 , 4 )	
	SetItemAttr(Item_new, ITEMATTR_VAL_AGI, used_time )		-------------秒  
	SynChaKitbag(character,13)
	return LUA_TRUE
end


----给角色背包添加道具
function AddChaItem3(character,npc,value)

	local item_number = CheckBagItem( character, value )			
	if item_number >=1 then
		MISSDK_MISSIONSDK_LUA_000043 = GetResString("MISSDK_MISSIONSDK_LUA_000043")
		SystemNotice( character ,MISSDK_MISSIONSDK_LUA_000043)
		return LUA_FALSE 
	end
	
	local r1=0
	local r2=0
		--SystemNotice( character ,"r1=="..r1)
	r1,r2 =MakeItem ( character , value  , 1 , 4 )
	local Item_new = GetChaItem ( character , 2 , r2 )
	


	----------记录时间
	local now_yes = os.date("%y")		-------------年
	local now_month= os.date("%m")		-------------月
	local now_day= os.date("%d")		-------------日
	local now_hour= os.date("%H")		-------------时
	local now_miniute= os.date("%M")	-------------分
	local now_scend=  os.date("%S")		-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	--local CheckDateNum = NowMonthNum * 10000 + NowDayNum * 100 + NowTimeNum
	--SystemNotice ( character , "now_yes=="..now_yes )
	--SystemNotice ( character , "now_month=="..now_month )
	--SystemNotice ( character , "now_day=="..now_day )
	--SystemNotice ( character , "now_hour=="..now_hour )
	--SystemNotice ( character , "now_miniute=="..now_miniute )
	--SystemNotice ( character , "now_scend=="..now_scend )
	SetItemAttr(Item_new, ITEMATTR_VAL_STA, now_month )		-------------月 	
	SetItemAttr(Item_new, ITEMATTR_VAL_STR, now_day )		-------------日  
	SetItemAttr(Item_new, ITEMATTR_VAL_CON, now_hour )		-------------时   
	SetItemAttr(Item_new, ITEMATTR_VAL_DEX, now_miniute )		-------------分   
	SetItemAttr(Item_new, ITEMATTR_VAL_AGI, now_scend )		-------------秒 
	SynChaKitbag(character,13)
	return LUA_TRUE
end

function AddChaItem4(character,npc,value)
	
	local i= CheckBagItem( character, value )
		--SystemNotice( character , "i=="..i)
	if i~=1 then
		MISSDK_MISSIONSDK_LUA_000044 = GetResString("MISSDK_MISSIONSDK_LUA_000044")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000044)
		return LUA_FALSE
	end
	
	
	----------记录时间
	local now_yes = os.date("%y")			-------------年
	local now_month= os.date("%m")			-------------月
	local now_day= os.date("%d")			-------------日
	local now_hour= os.date("%H")			-------------时
	local now_miniute= os.date("%M")		-------------分
	local now_scend=  os.date("%S")			-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	--SystemNotice ( character , "now_yes=="..now_yes )
	--SystemNotice ( character , "now_month=="..now_month )
	--SystemNotice ( character , "now_day=="..now_day )
	--SystemNotice ( character , "now_hour=="..now_hour )
	--SystemNotice ( character , "now_miniute=="..now_miniute )
	--SystemNotice ( character , "now_scend=="..now_scend )

	local item_old = GetChaItem2 ( character , 2 , value )--------特别行动卡
	---------取特别行动卡的时间	
	local old_month = GetItemAttr(item_old, ITEMATTR_VAL_STA)		-------------月 	
	local old_day = GetItemAttr(item_old, ITEMATTR_VAL_STR)			-------------日  
	local old_hour = GetItemAttr(item_old, ITEMATTR_VAL_CON)			-------------时   
	local old_miniute = GetItemAttr(item_old, ITEMATTR_VAL_DEX)		-------------分   
	local old_scend = GetItemAttr(item_old, ITEMATTR_VAL_AGI)			-------------秒 
	--SystemNotice ( character , "old_month=="..old_month )
	--SystemNotice ( character , "old_day=="..old_day )       
	--SystemNotice ( character , "old_hour=="..old_hour )    
	--SystemNotice ( character , "old_miniute=="..old_miniute)
	--SystemNotice ( character , "old_scend=="..old_scend ) 

	---------删除特别行动卡
	local del_item =TakeItem( character, 0,value, 1 )--------------			                   
	if del_item==0  then
		MISSDK_MISSIONSDK_LUA_000045 = GetResString("MISSDK_MISSIONSDK_LUA_000045")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000045)
		return LUA_FALSE
	end


	local used_time=(now_scend - old_scend)+(now_miniute - old_miniute)*60+(now_hour - old_hour)*3600+(now_day - old_day)*86400+(JNSTime_Flag[now_month] - JNSTime_Flag[old_month] )*86400
	local cha_name = GetChaDefaultName ( character )

	if used_time>900 or used_time<0 then
		MISSDK_MISSIONSDK_LUA_000046 = GetResString("MISSDK_MISSIONSDK_LUA_000046")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000046)
		return LUA_FALSE
	elseif used_time <= 900 and used_time>0 then
		MISSDK_MISSIONSDK_LUA_000047 = GetResString("MISSDK_MISSIONSDK_LUA_000047")
		MISSDK_MISSIONSDK_LUA_000048 = GetResString("MISSDK_MISSIONSDK_LUA_000048")
		SystemNotice(character ,MISSDK_MISSIONSDK_LUA_000048..used_time..MISSDK_MISSIONSDK_LUA_000047)
	end
	
	SynChaKitbag(character,13)
	return LUA_TRUE
end


---------------判断角色是否有某乱斗点数
function HasFightingPoint(character,value)
		--SystemNotice( character , "HasFightingPoint" )
		local i= CheckBagItem( character, 3849 )
		--SystemNotice( character , "i=="..i)
		if i~=1 then
			CALCULATE_ITEMEFFECT_LUA_000391 = GetResString("CALCULATE_ITEMEFFECT_LUA_000391")
			SystemNotice( character , CALCULATE_ITEMEFFECT_LUA_000391)
			return LUA_FALSE
		end
		local ATKER_LD = GetChaItem2 ( character , 2 , 3849 )
		local FightingPoint=GetItemAttr ( ATKER_LD , ITEMATTR_MAXENERGY)
	      --SystemNotice( character , "HasFightingPoint=="..FightingPoint )
	if value > FightingPoint then
		return LUA_FALSE
	else
		return LUA_TRUE
	end
end

---------------判断角色是否有某荣誉点数
function HasHonorPoint(character,value)
		--SystemNotice( character , "HasHonorPoint" )
		local i= CheckBagItem( character, 3849 )
		--SystemNotice( character , "i=="..i)
		if i~=1 then
			CALCULATE_ITEMEFFECT_LUA_000391 = GetResString("CALCULATE_ITEMEFFECT_LUA_000391")
			SystemNotice( character , CALCULATE_ITEMEFFECT_LUA_000391)
			return LUA_FALSE
		end
		local DEFER_RYZ1 = GetChaItem2 ( character , 2 , 3849 )
		local HonorPoint = GetItemAttr ( DEFER_RYZ1 , ITEMATTR_VAL_STR)
	if value > HonorPoint then
		return LUA_FALSE
	else
		return LUA_TRUE
	end
end

--判断好汉书时间是否小于某个值
function LessTime( character, value)
	local HHS_Num = 0
	HHS_Num = CheckBagItem( character, 2912 )
	---SystemNotice(character,""..HHS_Num)
	if HHS_Num ~= 1 then
		MISSDK_MISSIONSDK_LUA_000049 = GetResString("MISSDK_MISSIONSDK_LUA_000049")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000049)
		return 0
	end
	local role_HHS = GetChaItem2 ( character , 2 , 2912 )	
	local attr_num = GetItemAttr ( role_HHS, ITEMATTR_VAL_AGI)
	----SystemNotice(character,""..attr_num)
	if value > attr_num then
		return LUA_TRUE
	end

	return LUA_FALSE
end
----LOG---------金牛水手奖励 
function JINNiuSS(character)

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000050 = GetResString("MISSDK_MISSIONSDK_LUA_000050")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "JINNiuSS" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000050 )
	end

	------------------------------------金牛海盗奖励
function JINNiuHD ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000051 = GetResString("MISSDK_MISSIONSDK_LUA_000051")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "JINNiuHD" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000051 )
end

------------------------------------金牛船长奖励
function JINNiuCZ ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000052 = GetResString("MISSDK_MISSIONSDK_LUA_000052")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "JINNiuCZ" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000052 )
end
----LOG---------双子水手奖励 
function ShuangZiSS (character,npc)

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000050 = GetResString("MISSDK_MISSIONSDK_LUA_000050")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ShuangZiSS" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000050 )
	end

	------------------------------------双子海盗奖励
function ShuangZiHD ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000051 = GetResString("MISSDK_MISSIONSDK_LUA_000051")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ShuangZiHD" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000051 )
end

------------------------------------双子船长奖励
function ShuangZiCZ ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000052 = GetResString("MISSDK_MISSIONSDK_LUA_000052")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ShuangZiCZ" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000052 )
end

-----------------------------------开始转生
function ZSSTART ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000053 = GetResString("MISSDK_MISSIONSDK_LUA_000053")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ZSSTART" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000053 )
end

------------------------------------结束转生
function ZSSTOP ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000054 = GetResString("MISSDK_MISSIONSDK_LUA_000054")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ZSSTOP" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000054 )
end

------------------------------------结束二次转生----dina
function ZSSTOP2 ( character,npc )

	local cha_name = GetChaDefaultName ( character )
	
	MISSDK_MISSIONSDK_LUA_000055 = GetResString("MISSDK_MISSIONSDK_LUA_000055")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG( "ZSSTOP2" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000055 )
end

--判断好汉书时间是否大于某个值
function MoreTime( character, value)
	local HHS_Num = 0
	HHS_Num = CheckBagItem( character, 2912 )
	---SystemNotice(character,""..HHS_Num)
	if HHS_Num ~= 1 then
		MISSDK_MISSIONSDK_LUA_000049 = GetResString("MISSDK_MISSIONSDK_LUA_000049")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000049)
		return 0
	end
	local role_HHS = GetChaItem2 ( character , 2 , 2912 )	
	local attr_num = GetItemAttr ( role_HHS, ITEMATTR_VAL_AGI)
	----SystemNotice(character,""..attr_num)
	if value < attr_num then
		return LUA_TRUE
	end

	return LUA_FALSE
end

--判断是否穿着白羊套装
function BaiyangOn( character )
	local head = GetChaItem ( character , 1 , 0 )
	local body = GetChaItem ( character , 1 , 2 )
	local hand = GetChaItem ( character , 1 , 3 )
	local foot = GetChaItem ( character , 1 , 4 )

	local Head_ID = GetItemID ( head )
	local Body_ID = GetItemID ( body )
	local Hand_ID = GetItemID ( hand )
	local Foot_ID = GetItemID ( foot )
	local Cha_Num = GetChaTypeID( cha )

	if Body_ID ~= 5341 and Body_ID ~= 5345 and Body_ID ~= 5349 and Body_ID ~= 5353 then
		return LUA_FALSE
	end
	if Hand_ID ~= 5342 and Hand_ID ~= 5346 and Hand_ID ~= 5350 and Hand_ID ~= 5354 then
		return LUA_FALSE
	end
	if Foot_ID ~= 5343 and Foot_ID ~= 5347 and Foot_ID ~= 5351 and Foot_ID ~= 5355 then
		return LUA_FALSE
	end
	if Cha_Num == 4 then
		if Head_ID ~= 5352 then
		return LUA_FALSE
		end
	end

	return LUA_TRUE
end

---------------扣除角色身上的乱斗点数
function TakeFightingPoint(character,value)
		--SystemNotice( character , "TakeFightingPoint" )
		local i= CheckBagItem( character, 3849 )
		--SystemNotice( character , "i=="..i)
		if i~=1 then
			CALCULATE_FORGE_LUA_000259 = GetResString("CALCULATE_FORGE_LUA_000259")
			SystemNotice( character , CALCULATE_FORGE_LUA_000259)
			return LUA_FALSE
		end
		local ATKER_LD = GetChaItem2 ( character , 2 , 3849 )
		local FightingPoint=GetItemAttr ( ATKER_LD , ITEMATTR_MAXENERGY)
	      --SystemNotice( character , "HasFightingPoint=="..FightingPoint )
	if value > FightingPoint then
		return LUA_FALSE
	else
		local new_point=FightingPoint - value
		SetItemAttr ( ATKER_LD , ITEMATTR_MAXENERGY , new_point)
		return LUA_TRUE
	end
end

---------------扣除角色身上的荣誉点数
function TakeHonorPoint(character,value)
		--SystemNotice( character , "TakeHonorPoint" )
		local i= CheckBagItem( character, 3849 )
		--SystemNotice( character , "i=="..i)
		if i~=1 then
			CALCULATE_FORGE_LUA_000259 = GetResString("CALCULATE_FORGE_LUA_000259")
			SystemNotice( character , CALCULATE_FORGE_LUA_000259)
			return LUA_FALSE
		end
		local DEFER_RYZ1 = GetChaItem2 ( character , 2 , 3849 )
		local HonorPoint = GetItemAttr ( DEFER_RYZ1 , ITEMATTR_VAL_STR)
		if value > HonorPoint then
			return LUA_FALSE
		else
			local new_point=HonorPoint - value
			SetItemAttr ( DEFER_RYZ1 , ITEMATTR_VAL_STR , new_point)
			return LUA_TRUE
		end
end

--判断组队贡献度
function HasOffer( character, value )
	local ret = HasZuDuiGongXianDu( character, value )
	if ret == LUA_TRUE then
		return LUA_TRUE
	end
	
	return LUA_FALSE
end

--扣除组队贡献度
function TakeOffer( character, value )
	local ret = TakeZuDuiGongXianDu( character, value )
	if ret == LUA_TRUE then
		return LUA_TRUE
	end
	
	return LUA_FALSE
end

-------判断角色移动速度是否达到某值
function CheckSpeed( character, value)
	local Role_Speed = GetChaAttr( character, ATTR_MSPD )
	if Role_Speed < value then
		return LUA_FALSE
	end

	return LUA_TRUE

end
	
---------------------------------------------------------------金牛特别行动卡---------missionsdk

function AddChaItem5(character,npc,value)
	
	local i= CheckBagItem( character, value )
		--SystemNotice( character , "i=="..i)
	if i~=1 then
		MISSDK_MISSIONSDK_LUA_000056 = GetResString("MISSDK_MISSIONSDK_LUA_000056")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000056)
		return LUA_FALSE
	end
	
	
	----------记录时间
	local now_yes = os.date("%y")			-------------年
	local now_month= os.date("%m")			-------------月
	local now_day= os.date("%d")			-------------日
	local now_hour= os.date("%H")			-------------时
	local now_miniute= os.date("%M")		-------------分
	local now_scend=  os.date("%S")			-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	--SystemNotice ( character , "now_yes=="..now_yes )
	--SystemNotice ( character , "now_month=="..now_month )
	--SystemNotice ( character , "now_day=="..now_day )
	--SystemNotice ( character , "now_hour=="..now_hour )
	--SystemNotice ( character , "now_miniute=="..now_miniute )
	--SystemNotice ( character , "now_scend=="..now_scend )

	local item_old = GetChaItem2 ( character , 2 , value )--------金牛特别行动卡
	---------取特别行动卡的时间	
	local old_month = GetItemAttr(item_old, ITEMATTR_VAL_STA)		-------------月 	
	local old_day = GetItemAttr(item_old, ITEMATTR_VAL_STR)			-------------日  
	local old_hour = GetItemAttr(item_old, ITEMATTR_VAL_CON)			-------------时   
	local old_miniute = GetItemAttr(item_old, ITEMATTR_VAL_DEX)		-------------分   
	local old_scend = GetItemAttr(item_old, ITEMATTR_VAL_AGI)			-------------秒 
	--SystemNotice ( character , "old_month=="..old_month )
	--SystemNotice ( character , "old_day=="..old_day )       
	--SystemNotice ( character , "old_hour=="..old_hour )    
	--SystemNotice ( character , "old_miniute=="..old_miniute)
	--SystemNotice ( character , "old_scend=="..old_scend ) 

	---------删除特别行动卡
	local del_item =TakeItem( character, 0,value, 1 )--------------			                   
	if del_item==0  then
		MISSDK_MISSIONSDK_LUA_000057 = GetResString("MISSDK_MISSIONSDK_LUA_000057")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000057)
		return LUA_FALSE
	end


	local used_time=(now_scend - old_scend)+(now_miniute - old_miniute)*60+(now_hour - old_hour)*3600+(now_day - old_day)*86400+(JNSTime_Flag[now_month] - JNSTime_Flag[old_month] )*86400
	local cha_name = GetChaDefaultName ( character )

	if used_time>420 or used_time<0 then
		MISSDK_MISSIONSDK_LUA_000046 = GetResString("MISSDK_MISSIONSDK_LUA_000046")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000046)
		return LUA_FALSE
	elseif used_time <= 420 and used_time>0 then
		MISSDK_MISSIONSDK_LUA_000047 = GetResString("MISSDK_MISSIONSDK_LUA_000047")
		MISSDK_MISSIONSDK_LUA_000048 = GetResString("MISSDK_MISSIONSDK_LUA_000048")
		SystemNotice(character ,MISSDK_MISSIONSDK_LUA_000048..used_time..MISSDK_MISSIONSDK_LUA_000047)
	end
	
	SynChaKitbag(character,13)
	return LUA_TRUE
end

------------------判断是否转生过
function CheckZS( character )
	local Zs_Exp = GetChaAttr ( character , ATTR_CSAILEXP )
	if Zs_Exp < 1 then
		return LUA_FALSE
	end

	return LUA_TRUE

end

--判断荣誉值是否小于某个值
function LessCredit( character, p1, value )
	local ret = LessYongYuZhi( character, p1, value )
	if ret == LUA_TRUE then
		return LUA_TRUE
	end
	
	return LUA_FALSE
end
------------------检测道具上编号是否相同
function CheckItem( character, itemid1, itemid2 )
	if itemid1 == nil or itemid2 == nil then
		MISSDK_MISSIONSDK_LUA_000058 = GetResString("MISSDK_MISSIONSDK_LUA_000058")
		PRINT( MISSDK_MISSIONSDK_LUA_000058 )
		return LUA_ERROR
	end
	local item1=GetItemP(character,2)
	local item2=GetItemP(character,3)
	local itemida=GetItemID( item1 )
	local itemidb=GetItemID( item2 )
	local itemid1_number=GetItemAttr ( item1 , ITEMATTR_VAL_STR )
	local itemid2_number=GetItemAttr ( item2 , ITEMATTR_VAL_STR )
		
		
	if itemid1_number~=itemid2_number or itemida~=2902  or itemidb~=2903 then
	MISSDK_MISSIONSDK_LUA_000059 = GetResString("MISSDK_MISSIONSDK_LUA_000059")
	SystemNotice( character, MISSDK_MISSIONSDK_LUA_000059 )
		return LUA_FALSE	
	end
	return LUA_TRUE
end

function CheckBag( character, itemid, value1, value2)-----------value1===位置，value2===数量
	local cha = ChaIsBoat ( character ) 
	if cha ==1 then
		--SystemNotice( character ,"请您上岸接任务")
		return LUA_TRUE 
	end	
	if itemid== nil or value1== nil or value2== nil then
		MISSDK_MISSIONSDK_LUA_000060 = GetResString("MISSDK_MISSIONSDK_LUA_000060")
		PRINT( MISSDK_MISSIONSDK_LUA_000060 )
		return LUA_ERROR
	end
	local item=GetItemP(character,value1)
	local itemida=GetItemID( item )
	local i = CheckBagItem( character, itemid )			---取数量
	local item_name=GetItemName ( itemid )
	local item_pos=value1+1
	if itemid~=itemida or i~=value2 then
		CALCULATE_FORGE_LUA_000190 = GetResString("CALCULATE_FORGE_LUA_000190")
		MISSDK_MISSIONSDK_LUA_000061 = GetResString("MISSDK_MISSIONSDK_LUA_000061")
		MISSDK_MISSIONSDK_LUA_000062 = GetResString("MISSDK_MISSIONSDK_LUA_000062")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000062..item_pos..MISSDK_MISSIONSDK_LUA_000061..value2..CALCULATE_FORGE_LUA_000190..item_name )
		return LUA_FALSE	
	end
	return LUA_TRUE
end

function CheckBagEmp( character,value)-----------value===位置
	if value==nil then
		MISSDK_MISSIONSDK_LUA_000063 = GetResString("MISSDK_MISSIONSDK_LUA_000063")
		PRINT( MISSDK_MISSIONSDK_LUA_000063 )
		return LUA_ERROR
	end
	local item=GetItemP(character,value)
	local itemid=GetItemID( item )
	local item_pos=value+1
	local cha = ChaIsBoat ( character ) 
	if cha ==1 then
		MISSDK_MISSIONSDK_LUA_000064 = GetResString("MISSDK_MISSIONSDK_LUA_000064")
		MISSDK_MISSIONSDK_LUA_000065 = GetResString("MISSDK_MISSIONSDK_LUA_000065")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000065..item_pos..MISSDK_MISSIONSDK_LUA_000064)
		return LUA_FALSE 
	end	
	if itemid~=0 then
		MISSDK_MISSIONSDK_LUA_000064 = GetResString("MISSDK_MISSIONSDK_LUA_000064")
		MISSDK_MISSIONSDK_LUA_000065 = GetResString("MISSDK_MISSIONSDK_LUA_000065")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000065..item_pos..MISSDK_MISSIONSDK_LUA_000064)
		return LUA_FALSE	
	end
	return LUA_TRUE
end
--清除PK荣誉值
function AddCredit( character, value )
	local ret = AddYongYuZhi( character, value )
	if ret == LUA_TRUE then
		return LUA_TRUE
	end
	
	return LUA_FALSE
end

--检测钱不足
function NoMoney( character, money )
	PRINT( "NoMoney:HasMoney" )
	local ret = HasMoney( character, money )
	PRINT( "NoMoney:HasMoney return ret = ", ret )
	if ret ~= LUA_TRUE then
		return LUA_TRUE
	end
	return LUA_FALSE
end

--检查是否符合转职条件
function CheckConvertProfession( character, newpf )
	if newpf == nil then
		MISSDK_MISSIONSDK_LUA_000066 = GetResString("MISSDK_MISSIONSDK_LUA_000066")
		PRINT( MISSDK_MISSIONSDK_LUA_000066 )
		MISSDK_MISSIONSDK_LUA_000066 = GetResString("MISSDK_MISSIONSDK_LUA_000066")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000066 )
		return LUA_ERROR
	end
	
	--取得角色职业和类型
	local ret, cat, pf = GetCatAndPf( character )
	PRINT( "CheckConvertProfession: GetCatAndPf: ret =, pf = , newpf = , cat = , Profession = ", ret, pf, newpf, cat, Profession )
	--判断是否新手，新手没有转职限制
	if pf ~= 0 then	
		--检测是否有转职限制
		if Profession ~= nil and Profession[pf] ~= nil then
			local flag = 0
			PRINT( "CheckConvertProfession: pf count = ", Profession[pf].count )
			for n = 1, Profession[pf].count, 1 do
				PRINT( "CheckConvertProfession: n =, newpf = , pf = ", n, newpf, Profession[pf][n] )
				if Profession[pf][n] == newpf then
					--该职业允许转职
					flag = 1
					break
				end
			end
			
			--判断是否可以转职
			if flag ~= 1 then
				PRINT( "CheckConvertProfession: return false" )
				return LUA_FALSE
			end
		else
			PRINT( "CheckConvertProfession: return false fo Profession[pf] == nil " )
			return LUA_FALSE
		end
	end
	
	PRINT( "CheckConvertProfession: Category check cat =, newpf = ", cat, newpf )
	--检测是否有体形限制
	if Category ~= nil and Category[cat] ~= nil then
		local flag = 0
		for n = 1, Category[cat].count, 1 do
			PRINT( "CheckConvertProfession:n = , newpf = , catpf = ", n, newpf, Category[cat][n] )
			if Category[cat][n] == newpf then
				PRINT( "CheckConvertProfession: return false" )
				flag = 1
				break
			end
		end
		
		if flag ~= 1 then
			PRINT( "CheckConvertProfession: return false" )
			return LUA_FALSE
		end
	else
		PRINT( "CheckConvertProfession: return false fo Category[cat] == nil " )
	end
	
	PRINT( "CheckConvertProfession: return true" )
	return LUA_TRUE
end

--中断任务
function CancelMission( character, id, sid )
	PRINT( "CancelMission, sid = ", sid )
	if sid == nil or Mission[sid] == nil then
		MISSDK_MISSIONSDK_LUA_000067 = GetResString("MISSDK_MISSIONSDK_LUA_000067")
		PRINT( MISSDK_MISSIONSDK_LUA_000067..sid )
		MISSDK_MISSIONSDK_LUA_000067 = GetResString("MISSDK_MISSIONSDK_LUA_000067")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000067..sid )
		MISSDK_MISSIONSDK_LUA_000067 = GetResString("MISSDK_MISSIONSDK_LUA_000067")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000067..sid )
		local ret = ClearMission( character, id )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000068 = GetResString("MISSDK_MISSIONSDK_LUA_000068")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000068, GetCharName( character ), id, sid )
		else
			MISSDK_MISSIONSDK_LUA_000069 = GetResString("MISSDK_MISSIONSDK_LUA_000069")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000069..sid )
			MISSDK_MISSIONSDK_LUA_000070 = GetResString("MISSDK_MISSIONSDK_LUA_000070")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000070, GetCharName( character ), id, sid )
		end
		
		return LUA_FALSE
	end
	
	local mission = Mission[sid]
	
	PRINT( "CancelMission:mission.cancel", mission.cancel )
	if mission.tp == NOMAL_MISSION or mission.tp == WORLD_MISSION then
		if mission.cancel == nil then
			MISSDK_MISSIONSDK_LUA_000071 = GetResString("MISSDK_MISSIONSDK_LUA_000071")
			PRINT( MISSDK_MISSIONSDK_LUA_000071 )
			return LUA_TRUE
		end
	
		local ret = NpcCancelTrigger( character,  mission.cancel, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000072 = GetResString("MISSDK_MISSIONSDK_LUA_000072")
			PRINT( MISSDK_MISSIONSDK_LUA_000072 )
			MISSDK_MISSIONSDK_LUA_000072 = GetResString("MISSDK_MISSIONSDK_LUA_000072")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000072 )
			return LUA_FALSE
		end
		PRINT( "CancelMission: NpcTrigger, return true" ) 
	elseif mission.tp == RAND_MISSION then
		--初始化全局随机任务参数
		InitRandParam()
		
		--获取角色的随机任务配置信息
		PRINT( "CancelMission:GetRandMission, id = ", id  )
		local ret
		RandParam.id = id
		ret, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata = GetRandMission( character, id )
		if ret ~= LUA_TRUE then
			PRINT( "CancelMission:GetRandMission error." )
			SystemNotice( character, "CancelMission:GetRandMission error." )
			return LUA_FALSE
		end
		PRINT( "CancelMission:tp, level, exp, money, item, numdata",  RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
		
		local index = GetRandMissionTypeIndex( mission, RandParam.tp )
		PRINT( "CancelMission:GetRandMissionTypeIndex index = ", index )
		if index == 0  then
			MISSDK_MISSIONSDK_LUA_000073 = GetResString("MISSDK_MISSIONSDK_LUA_000073")
			PRINT( MISSDK_MISSIONSDK_LUA_000073 )
			MISSDK_MISSIONSDK_LUA_000073 = GetResString("MISSDK_MISSIONSDK_LUA_000073")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000073 )
			return LUA_FALSE
		end
	
		if mission.missionlist == nil or mission.missionlist[index] == nil then
			MISSDK_MISSIONSDK_LUA_000074 = GetResString("MISSDK_MISSIONSDK_LUA_000074")
			PRINT( MISSDK_MISSIONSDK_LUA_000074, mission.missionlist, index )
			MISSDK_MISSIONSDK_LUA_000074 = GetResString("MISSDK_MISSIONSDK_LUA_000074")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000074, mission.missionlist, index )
			return LUA_FALSE
		end
		
		if mission.missionlist[index].cancel == nil then
			MISSDK_MISSIONSDK_LUA_000071 = GetResString("MISSDK_MISSIONSDK_LUA_000071")
			PRINT( MISSDK_MISSIONSDK_LUA_000071 )
			return LUA_TRUE
		end
	
		ret = NpcCancelTrigger( character, mission.missionlist[index].cancel, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000072 = GetResString("MISSDK_MISSIONSDK_LUA_000072")
			PRINT( MISSDK_MISSIONSDK_LUA_000072 )
			MISSDK_MISSIONSDK_LUA_000072 = GetResString("MISSDK_MISSIONSDK_LUA_000072")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000072 )
			return LUA_FALSE
		end
		MISSDK_MISSIONSDK_LUA_000075 = GetResString("MISSDK_MISSIONSDK_LUA_000075")
		PRINT( MISSDK_MISSIONSDK_LUA_000075 )
	else
		MISSDK_MISSIONSDK_LUA_000076 = GetResString("MISSDK_MISSIONSDK_LUA_000076")
		PRINT( MISSDK_MISSIONSDK_LUA_000076..mission.sid )
		MISSDK_MISSIONSDK_LUA_000076 = GetResString("MISSDK_MISSIONSDK_LUA_000076")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000076..mission.sid )
		return LUA_FALSE
	end
	
	return LUA_TRUE
end

--接受任务
function AcceptMission( character, npc, missionlist, tpindex )
	PRINT( "AcceptMission" )
	local npcid = GetCharID( npc )
	local ret, id, state, tp = GetMissionTempInfo( character, npcid )
	if ret ~= LUA_TRUE then 
		MISSDK_MISSIONSDK_LUA_000077 = GetResString("MISSDK_MISSIONSDK_LUA_000077")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000077 )
		return LUA_FALSE
	end
	
	local mission
	if tp == WORLD_MISSION then
		if Mission[id] == nil then
			MISSDK_MISSIONSDK_LUA_000078 = GetResString("MISSDK_MISSIONSDK_LUA_000078")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000078..id )
			MISSDK_MISSIONSDK_LUA_000078 = GetResString("MISSDK_MISSIONSDK_LUA_000078")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000078..id )
			return LUA_FALSE
		end
		mission = Mission[id]
	else
		if missionlist[id] == nil then
			MISSDK_MISSIONSDK_LUA_000079 = GetResString("MISSDK_MISSIONSDK_LUA_000079")
			PRINT( MISSDK_MISSIONSDK_LUA_000079..id )
			MISSDK_MISSIONSDK_LUA_000079 = GetResString("MISSDK_MISSIONSDK_LUA_000079")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000079..id )
			MISSDK_MISSIONSDK_LUA_000079 = GetResString("MISSDK_MISSIONSDK_LUA_000079")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000079..id )
			return LUA_FALSE
		end
		if missionlist == nil then
			MISSDK_MISSIONSDK_LUA_000080 = GetResString("MISSDK_MISSIONSDK_LUA_000080")
			PRINT( MISSDK_MISSIONSDK_LUA_000080..missionlist )
			MISSDK_MISSIONSDK_LUA_000080 = GetResString("MISSDK_MISSIONSDK_LUA_000080")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000080..missionlist )
			MISSDK_MISSIONSDK_LUA_000080 = GetResString("MISSDK_MISSIONSDK_LUA_000080")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000080..missionlist )
			return LUA_ERROR
		end
		mission = missionlist[id]
	end
	
	if mission.begin == nil then
		MISSDK_MISSIONSDK_LUA_000081 = GetResString("MISSDK_MISSIONSDK_LUA_000081")
		PRINT( MISSDK_MISSIONSDK_LUA_000081..id )
		MISSDK_MISSIONSDK_LUA_000082 = GetResString("MISSDK_MISSIONSDK_LUA_000082")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000082 )
		MISSDK_MISSIONSDK_LUA_000081 = GetResString("MISSDK_MISSIONSDK_LUA_000081")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000081..id )
		return LUA_FALSE
	end
	
	PRINT( "AcceptMission:npcid = %d ", npcid )
	if mission.tp == NOMAL_MISSION or mission.tp == WORLD_MISSION then
		MISSDK_MISSIONSDK_LUA_000083 = GetResString("MISSDK_MISSIONSDK_LUA_000083")
		PRINT( MISSDK_MISSIONSDK_LUA_000083, mission.begin.baggrid )
		local ret = HasLeaveBagGrid( character, mission.begin.baggrid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000084 = GetResString("MISSDK_MISSIONSDK_LUA_000084")
			PRINT( MISSDK_MISSIONSDK_LUA_000084, mission.begin.baggrid )
			MISSDK_MISSIONSDK_LUA_000085 = GetResString("MISSDK_MISSIONSDK_LUA_000085")
			MISSDK_MISSIONSDK_LUA_000086 = GetResString("MISSDK_MISSIONSDK_LUA_000086")
			BickerNotice( character, MISSDK_MISSIONSDK_LUA_000086..mission.begin.baggrid..MISSDK_MISSIONSDK_LUA_000085 )
			return LUA_FALSE
		end
		
		local ret = NpcTrigger( character,  npc, mission.begin, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000087 = GetResString("MISSDK_MISSIONSDK_LUA_000087")
			PRINT( MISSDK_MISSIONSDK_LUA_000087 )
			MISSDK_MISSIONSDK_LUA_000087 = GetResString("MISSDK_MISSIONSDK_LUA_000087")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000087 )
			return LUA_FALSE
		end		
		PRINT( "AcceptMission: NpcTrigger, return true" ) 
	elseif mission.tp == RAND_MISSION then
		if mission.missionlist == nil or mission.missionlist[tpindex] == nil or mission.missionlist[tpindex].begin.baggrid == nil then
			MISSDK_MISSIONSDK_LUA_000088 = GetResString("MISSDK_MISSIONSDK_LUA_000088")
			PRINT( MISSDK_MISSIONSDK_LUA_000088, mission.missionlist, tpindex )
			MISSDK_MISSIONSDK_LUA_000088 = GetResString("MISSDK_MISSIONSDK_LUA_000088")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000088, mission.missionlist, tpindex )
			return LUA_FALSE
		end
		
		MISSDK_MISSIONSDK_LUA_000083 = GetResString("MISSDK_MISSIONSDK_LUA_000083")
		PRINT( MISSDK_MISSIONSDK_LUA_000083, mission.missionlist[tpindex].begin.baggrid )
		local numgrid = mission.missionlist[tpindex].begin.baggrid
		local ret = HasLeaveBagGrid( character, numgrid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000084 = GetResString("MISSDK_MISSIONSDK_LUA_000084")
			PRINT( MISSDK_MISSIONSDK_LUA_000084, numgrid )
			MISSDK_MISSIONSDK_LUA_000085 = GetResString("MISSDK_MISSIONSDK_LUA_000085")
			MISSDK_MISSIONSDK_LUA_000086 = GetResString("MISSDK_MISSIONSDK_LUA_000086")
			BickerNotice( character, MISSDK_MISSIONSDK_LUA_000086..numgrid..MISSDK_MISSIONSDK_LUA_000085 )
			return LUA_FALSE
		end
		
		ret = NpcTrigger( character,  npc, mission.missionlist[tpindex].begin, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000087 = GetResString("MISSDK_MISSIONSDK_LUA_000087")
			PRINT( MISSDK_MISSIONSDK_LUA_000087 )
			MISSDK_MISSIONSDK_LUA_000087 = GetResString("MISSDK_MISSIONSDK_LUA_000087")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000087 )
			return LUA_FALSE
		end
		MISSDK_MISSIONSDK_LUA_000089 = GetResString("MISSDK_MISSIONSDK_LUA_000089")
		PRINT( MISSDK_MISSIONSDK_LUA_000089 )
	else
		MISSDK_MISSIONSDK_LUA_000090 = GetResString("MISSDK_MISSIONSDK_LUA_000090")
		PRINT( MISSDK_MISSIONSDK_LUA_000090..mission.sid )
		MISSDK_MISSIONSDK_LUA_000090 = GetResString("MISSDK_MISSIONSDK_LUA_000090")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000090..mission.sid )
		return LUA_FALSE
	end

	if tp ~= WORLD_MISSION then
		ret = RefreshMissionState( character, npc )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000091 = GetResString("MISSDK_MISSIONSDK_LUA_000091")
			PRINT( MISSDK_MISSIONSDK_LUA_000091 )
			MISSDK_MISSIONSDK_LUA_000092 = GetResString("MISSDK_MISSIONSDK_LUA_000092")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000092 )
			return LUA_FALSE
		end
	end
	
	return LUA_TRUE
end

--完成任务
function CompleteMission( character, npc, missionlist, selitem, param )
	PRINT( "CompleteMission" )
	if missionlist == nil then
		MISSDK_MISSIONSDK_LUA_000093 = GetResString("MISSDK_MISSIONSDK_LUA_000093")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000093 )
		return LUA_ERROR
	end
	
	local npcid = GetCharID( npc )
	local ret, id, state, tp = GetMissionTempInfo( character, npcid )
	if ret ~= LUA_TRUE then 
		MISSDK_MISSIONSDK_LUA_000094 = GetResString("MISSDK_MISSIONSDK_LUA_000094")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000094 )
		return LUA_FALSE
	end

	local mission	
	if tp == WORLD_MISSION then
		if Mission[id] == nil then
			MISSDK_MISSIONSDK_LUA_000095 = GetResString("MISSDK_MISSIONSDK_LUA_000095")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000095..id )
			MISSDK_MISSIONSDK_LUA_000095 = GetResString("MISSDK_MISSIONSDK_LUA_000095")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000095..id )
			return LUA_FALSE
		end
		mission = Mission[id]
	else		
		if missionlist[id] == nil then
			MISSDK_MISSIONSDK_LUA_000096 = GetResString("MISSDK_MISSIONSDK_LUA_000096")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000096..id )
			MISSDK_MISSIONSDK_LUA_000096 = GetResString("MISSDK_MISSIONSDK_LUA_000096")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000096..id )
			return LUA_FALSE
		end
		mission = missionlist[id]
	end
	
	local ret = HasMisssionFailure( character, mission.id )
	if ret == LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000097 = GetResString("MISSDK_MISSIONSDK_LUA_000097")
		MISSDK_MISSIONSDK_LUA_000098 = GetResString("MISSDK_MISSIONSDK_LUA_000098")
		BickerNotice( character, MISSDK_MISSIONSDK_LUA_000098..mission.name..MISSDK_MISSIONSDK_LUA_000097 )
		return LUA_TRUE
	end
	
	if mission.tp == NOMAL_MISSION or mission.tp == WORLD_MISSION then
		MISSDK_MISSIONSDK_LUA_000099 = GetResString("MISSDK_MISSIONSDK_LUA_000099")
		PRINT( MISSDK_MISSIONSDK_LUA_000099, mission.result.baggrid )
		local ret = HasLeaveBagGrid( character, mission.result.baggrid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000100 = GetResString("MISSDK_MISSIONSDK_LUA_000100")
			PRINT( MISSDK_MISSIONSDK_LUA_000100, mission.result.baggrid )
			MISSDK_MISSIONSDK_LUA_000101 = GetResString("MISSDK_MISSIONSDK_LUA_000101")
			MISSDK_MISSIONSDK_LUA_000086 = GetResString("MISSDK_MISSIONSDK_LUA_000086")
			BickerNotice( character, MISSDK_MISSIONSDK_LUA_000086..mission.result.baggrid..MISSDK_MISSIONSDK_LUA_000101 )
			return LUA_FALSE
		end
		
		local ret = NpcTrigger( character,  npc, mission.result, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000102 = GetResString("MISSDK_MISSIONSDK_LUA_000102")
			PRINT( MISSDK_MISSIONSDK_LUA_000102 )
			MISSDK_MISSIONSDK_LUA_000102 = GetResString("MISSDK_MISSIONSDK_LUA_000102")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000102 )
			return LUA_FALSE
		end
		
		PRINT( "CompleteMission:prize count = "..mission.prize.count )
		if mission.prize.count > 0 then
			local ret = MisPrizeProc( character, npc, mission, selitem, param )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000103 = GetResString("MISSDK_MISSIONSDK_LUA_000103")
				PRINT( MISSDK_MISSIONSDK_LUA_000103 )
				MISSDK_MISSIONSDK_LUA_000103 = GetResString("MISSDK_MISSIONSDK_LUA_000103")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000103 )
			end
		end
	elseif mission.tp == RAND_MISSION then
		local ret, index, loopdata = GetCharRandMission( character, mission.id, mission )
		if ret ~= LUA_TRUE or index == 0 then
			--根据随机任务参数生成随机任务信息错误
			MISSDK_MISSIONSDK_LUA_000104 = GetResString("MISSDK_MISSIONSDK_LUA_000104")
			PRINT( MISSDK_MISSIONSDK_LUA_000104 )
			MISSDK_MISSIONSDK_LUA_000104 = GetResString("MISSDK_MISSIONSDK_LUA_000104")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000104 )
			return LUA_FALSE
		end
		
		MISSDK_MISSIONSDK_LUA_000099 = GetResString("MISSDK_MISSIONSDK_LUA_000099")
		PRINT( MISSDK_MISSIONSDK_LUA_000099, mission.missionlist[index].result.baggrid )
		local numgrid = mission.missionlist[index].result.baggrid
		local ret = HasLeaveBagGrid( character, numgrid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000105 = GetResString("MISSDK_MISSIONSDK_LUA_000105")
			PRINT( MISSDK_MISSIONSDK_LUA_000105, numgrid )
			MISSDK_MISSIONSDK_LUA_000101 = GetResString("MISSDK_MISSIONSDK_LUA_000101")
			MISSDK_MISSIONSDK_LUA_000086 = GetResString("MISSDK_MISSIONSDK_LUA_000086")
			BickerNotice( character, MISSDK_MISSIONSDK_LUA_000086..numgrid..MISSDK_MISSIONSDK_LUA_000101 )
			return LUA_FALSE
		end
		
		local ret = NpcTrigger( character,  npc, mission.missionlist[index].result, mission.id, mission.sid )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000106 = GetResString("MISSDK_MISSIONSDK_LUA_000106")
			PRINT( MISSDK_MISSIONSDK_LUA_000106 )
			MISSDK_MISSIONSDK_LUA_000106 = GetResString("MISSDK_MISSIONSDK_LUA_000106")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000106 )
			return LUA_FALSE
		end
		
		PRINT( "CompleteMission:prize count = "..mission.missionlist[index].prize.count )
		if mission.missionlist[index].prize.count > 0 then
			local ret = MisPrizeProc( character, npc, mission.missionlist[index], selitem, param )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000103 = GetResString("MISSDK_MISSIONSDK_LUA_000103")
				PRINT( MISSDK_MISSIONSDK_LUA_000103 )
				MISSDK_MISSIONSDK_LUA_000103 = GetResString("MISSDK_MISSIONSDK_LUA_000103")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000103 )
			end
		end
		
		PRINT( "CompleteMission:CompleteRandMission, id = ", mission.id )
		ret = CompleteRandMissionCount( character, mission.id )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000107 = GetResString("MISSDK_MISSIONSDK_LUA_000107")
			PRINT( MISSDK_MISSIONSDK_LUA_000107, mission.id )
			MISSDK_MISSIONSDK_LUA_000107 = GetResString("MISSDK_MISSIONSDK_LUA_000107")
			LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000107, mission.id )
		end
		
		--判断是否跑环结束
		local ret, loopnum = GetRandMissionNum( character, mission.id )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000108 = GetResString("MISSDK_MISSIONSDK_LUA_000108")
			PRINT( MISSDK_MISSIONSDK_LUA_000108, id )
			MISSDK_MISSIONSDK_LUA_000108 = GetResString("MISSDK_MISSIONSDK_LUA_000108")
			LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000108, id )
			MISSDK_MISSIONSDK_LUA_000108 = GetResString("MISSDK_MISSIONSDK_LUA_000108")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000108..id )
			--清除该角色该随机任务计数
			ResetRandMissionNum( character, mission.id )
		else
			loopnum = loopnum + 1 --转换为lua数组索引
			PRINT( "CompleteRandMission:loopnum, loopinfo", loopnum, mission.loopinfo[loopnum] )
			
			if loopdata == nil or mission.loopinfo[loopnum] == nil then
				MISSDK_MISSIONSDK_LUA_000109 = GetResString("MISSDK_MISSIONSDK_LUA_000109")
				PRINT( MISSDK_MISSIONSDK_LUA_000109..loopnum.." id = "..mission.id.." loopdata = "..loopdata )
				MISSDK_MISSIONSDK_LUA_000109 = GetResString("MISSDK_MISSIONSDK_LUA_000109")
				LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000109..loopnum.." id = "..mission.id.." loopdata = "..loopdata )
				MISSDK_MISSIONSDK_LUA_000109 = GetResString("MISSDK_MISSIONSDK_LUA_000109")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000109..loopnum.." id = "..mission.id.." loopdata = "..loopdata )
				ResetRandMissionNum( character, mission.id )
				return LUA_FALSE
			end
			
			local ret = HasRandMissionCount( character, mission.id, mission.loopinfo[loopnum].num )
			if ret == LUA_TRUE then
				--清除该环任务计数，同时环计数增加
				ret = AddRandMissionNum( character, mission.id )
				if ret ~= LUA_TRUE then
					MISSDK_MISSIONSDK_LUA_000110 = GetResString("MISSDK_MISSIONSDK_LUA_000110")
					PRINT( MISSDK_MISSIONSDK_LUA_000110, mission.id  )
					MISSDK_MISSIONSDK_LUA_000111 = GetResString("MISSDK_MISSIONSDK_LUA_000111")
					LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000111, mission.id )
					MISSDK_MISSIONSDK_LUA_000110 = GetResString("MISSDK_MISSIONSDK_LUA_000110")
					SystemNotice( character, MISSDK_MISSIONSDK_LUA_000110..mission.id )
					return LUA_FALSE
				end
				if loopdata[loopnum + 1] == nil then
					--清除该随机任务计数因为已经跑环完毕,任务计数从头开始
					MISSDK_MISSIONSDK_LUA_000112 = GetResString("MISSDK_MISSIONSDK_LUA_000112")
					PRINT( MISSDK_MISSIONSDK_LUA_000112 )
					ResetRandMissionNum( character, mission.id )
					MISSDK_MISSIONSDK_LUA_000113 = GetResString("MISSDK_MISSIONSDK_LUA_000113")
					SystemNotice( character, MISSDK_MISSIONSDK_LUA_000113 )
				end
			end
		end
		
	else
		MISSDK_MISSIONSDK_LUA_000114 = GetResString("MISSDK_MISSIONSDK_LUA_000114")
		PRINT( MISSDK_MISSIONSDK_LUA_000114 )
		MISSDK_MISSIONSDK_LUA_000114 = GetResString("MISSDK_MISSIONSDK_LUA_000114")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000114 )
		return LUA_FALSE
	end
	
	if tp ~= WORLD_MISSION then
		PRINT( "CompleteMission:ResetMissionState" )
		ret = RefreshMissionState( character, npc )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000115 = GetResString("MISSDK_MISSIONSDK_LUA_000115")
			PRINT( MISSDK_MISSIONSDK_LUA_000115 )
			MISSDK_MISSIONSDK_LUA_000116 = GetResString("MISSDK_MISSIONSDK_LUA_000116")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000116 )
			return LUA_FALSE
		end
	end
	
	PRINT( "CompleteMission: return true" )
	return LUA_TRUE
end

--选择任务列表
function SelMissionList( character, npc, selindex, missionlist )
	local npcid = GetCharID( npc )
	local ret, id, state = GetMissionInfo( character, npcid, selindex )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000117 = GetResString("MISSDK_MISSIONSDK_LUA_000117")
		PRINT( MISSDK_MISSIONSDK_LUA_000117 )
		MISSDK_MISSIONSDK_LUA_000118 = GetResString("MISSDK_MISSIONSDK_LUA_000118")
		return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000118 )
	end
	
	PRINT( "SelMissionList:id = %d, state = %d", id, state )
	if missionlist[id] == nil then
		MISSDK_MISSIONSDK_LUA_000119 = GetResString("MISSDK_MISSIONSDK_LUA_000119")
		PRINT( MISSDK_MISSIONSDK_LUA_000119 )
		MISSDK_MISSIONSDK_LUA_000120 = GetResString("MISSDK_MISSIONSDK_LUA_000120")
		return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000120 )
	end
	
	ret = SetMissionTempInfo( character, npcid, id, state, missionlist[id].tp )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000121 = GetResString("MISSDK_MISSIONSDK_LUA_000121")
		PRINT( MISSDK_MISSIONSDK_LUA_000121 )
		MISSDK_MISSIONSDK_LUA_000122 = GetResString("MISSDK_MISSIONSDK_LUA_000122")
		return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000122 )
	end
	
	if missionlist[id].tp == NOMAL_MISSION then
		PRINT( "SelMissioinList:NomalMission type" )
		--根据任务状态发送任务的不同信息
		if state == MIS_DELIVERY then
			return SendDeliveryPage( character, npcid, missionlist[id], missionlist[id].id )
		elseif state == MIS_ACCEPT then
			return SendAcceptPage( character, npcid, missionlist[id], missionlist[id].id )
		elseif state == MIS_PENDING then
			return SendPendingPage( character, npcid, missionlist[id], missionlist[id].id )
		else
			MISSDK_MISSIONSDK_LUA_000123 = GetResString("MISSDK_MISSIONSDK_LUA_000123")
			PRINT( MISSDK_MISSIONSDK_LUA_000123 )
			MISSDK_MISSIONSDK_LUA_000123 = GetResString("MISSDK_MISSIONSDK_LUA_000123")
			return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000123 )
		end
	elseif missionlist[id].tp == RAND_MISSION then
		PRINT( "SelMissioinList:RandMission type" )
		--判断是否已经接受了该随机任务，如果接受了则是来还任务得
		ret = HasRandMission( character, missionlist[id].id )
		if ret ~= LUA_TRUE then			
			--随机任务在选择时就已经产生并且玩家接受任务
			local ret = IsMissionFull( character )
			if ret == LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000124 = GetResString("MISSDK_MISSIONSDK_LUA_000124")
				return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000124 )
			end
			
			local ret = NpcTriggerCheck( character, missionlist[id].begin )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000125 = GetResString("MISSDK_MISSIONSDK_LUA_000125")
				PRINT( MISSDK_MISSIONSDK_LUA_000125 )
				MISSDK_MISSIONSDK_LUA_000125 = GetResString("MISSDK_MISSIONSDK_LUA_000125")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000125 )
				return LUA_FALSE
			end
		
			PRINT( "SelMissionList:missionlist[id] = , id = ", missionlist[id], id )
			local ret, index = CreateRandMission( character, npc, missionlist[id] )
			if ret ~= LUA_TRUE then
				if index ~= nil then
					-- 表明背包容量不足
					return LUA_TRUE
				end
				
				MISSDK_MISSIONSDK_LUA_000126 = GetResString("MISSDK_MISSIONSDK_LUA_000126")
				PRINT( MISSDK_MISSIONSDK_LUA_000126 )
				return LUA_FALSE
			end
			
			ret = AcceptMission( character, npc, missionlist, index )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000127 = GetResString("MISSDK_MISSIONSDK_LUA_000127")
				PRINT( MISSDK_MISSIONSDK_LUA_000127 )
				MISSDK_MISSIONSDK_LUA_000127 = GetResString("MISSDK_MISSIONSDK_LUA_000127")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000127 )
				return LUA_FALSE
			end
			
			--发送随机任务的交付页面信息
			local ret, randid, state = GetMissionInfo( character, npcid, selindex )
			if ret ~= LUA_TRUE or id ~= randid then
				ret, state = GetCharMission( character, npcid, id )
				if ret ~= LUA_TRUE then
					MISSDK_MISSIONSDK_LUA_000128 = GetResString("MISSDK_MISSIONSDK_LUA_000128")
					PRINT( MISSDK_MISSIONSDK_LUA_000128 )
					MISSDK_MISSIONSDK_LUA_000129 = GetResString("MISSDK_MISSIONSDK_LUA_000129")
					return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000129 )
				end
			end
			
			--if state == MIS_PENDING then
				PRINT( "SelMissionList:SendPendingPage, index =, mission = ", index, missionlist[id].missionlist[index] )
				return SendPendingPage( character, npcid, missionlist[id].missionlist[index], missionlist[id].id )
			--elseif state == MIS_DELIVERY then
				--PRINT( "SelMissionList:SendDeliveryPage, index = , mission = ", index, missionlist[id].missionlist[index] )
				--return SendDeliveryPage( character, npcid, missionlist[id].missionlist[index], missionlist[id].id )
			--else
				--PRINT( "SelMissionList:随机任务接受时应为PENDING or DELIVERY状态，但是检测出状态不对。state = "..state )
				--return SystemNotice( character, "SelMissionList:随机任务接受时应为PENDING or DELIVERY状态，但是检测出状态不对。state = "..state )
			--end
		else
			local ret, index = GetCharRandMission( character, missionlist[id].id, missionlist[id] )
			if ret ~= LUA_TRUE or index == 0 then
				--根据随机任务参数生成随机任务信息错误
				MISSDK_MISSIONSDK_LUA_000130 = GetResString("MISSDK_MISSIONSDK_LUA_000130")
				PRINT( MISSDK_MISSIONSDK_LUA_000130 )
				MISSDK_MISSIONSDK_LUA_000130 = GetResString("MISSDK_MISSIONSDK_LUA_000130")
				return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000130 )
			end
			
			if state ~= MIS_DELIVERY then
				PRINT( "SelMissionList:SendPendingPage, index =, mission = ", index, missionlist[id].missionlist[index] )
				return SendPendingPage( character, npcid, missionlist[id].missionlist[index], missionlist[id].id )
			end
			
			PRINT( "SelMissionList:SendDeliveryPage, index = , mission = ", index, missionlist[id].missionlist[index] )
			return SendDeliveryPage( character, npcid, missionlist[id].missionlist[index], missionlist[id].id )
		end
		
	else
		MISSDK_MISSIONSDK_LUA_000131 = GetResString("MISSDK_MISSIONSDK_LUA_000131")
		PRINT( MISSDK_MISSIONSDK_LUA_000131 )
		MISSDK_MISSIONSDK_LUA_000131 = GetResString("MISSDK_MISSIONSDK_LUA_000131")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000131 )
		return LUA_FALSE
	end
	
end

--任务处理
function MissionProc( character, npc, rpk, missionlist )
	if missionlist == nil then
		MISSDK_MISSIONSDK_LUA_000132 = GetResString("MISSDK_MISSIONSDK_LUA_000132")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000132 )
		return LUA_FALSE
	end
	
	local byCmd = ReadByte( rpk )
	if byCmd == MIS_SEL then
		local selindex = ReadByte( rpk )
		return SelMissionList( character, npc, selindex, missionlist )
	elseif byCmd == MIS_BTNACCEPT then
		local ret = IsMissionFull( character )
		if ret == LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000133 = GetResString("MISSDK_MISSIONSDK_LUA_000133")
			return BickerNotice( character, MISSDK_MISSIONSDK_LUA_000133 )
		end
		return AcceptMission( character, npc, missionlist )
	elseif byCmd == MIS_BTNDELIVERY then
		local byParam1 = ReadByte( rpk )
		local byParam2 = ReadByte( rpk )
		local ret = CompleteMission( character, npc, missionlist, byParam1, byParam2 )
		--if ret == LUA_TRUE then
			--完成任务后继续下一个任务
			--local npcid = GetCharID( npc )
			--local ret, index, id, state = GetNextMission( character, npcid )
			--PRINT( "MissionProc:GetNextMission: ret, index, id, state", ret, index, id, state )
			--if ret == LUA_TRUE then
				--PRINT( "MissionProc:SelMissionList" )
				--return SelMissionList( character, npc, index, missionlist )
			--end
		--end
	--elseif byCmd == MIS_BTNPENDING then
	--elseif byCmd == MIS_TALK then
	else
		MISSDK_MISSIONSDK_LUA_000134 = GetResString("MISSDK_MISSIONSDK_LUA_000134")
		PRINT( MISSDK_MISSIONSDK_LUA_000134 )
		MISSDK_MISSIONSDK_LUA_000134 = GetResString("MISSDK_MISSIONSDK_LUA_000134")
		return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000134 )
	end
end

--查询任务日志信息
function MissionLog( character, sid )
	PRINT( "MissionLog" )
	if sid == nil  or Mission[sid] == nil then
		MISSDK_MISSIONSDK_LUA_000135 = GetResString("MISSDK_MISSIONSDK_LUA_000135")
		PRINT( MISSDK_MISSIONSDK_LUA_000135..sid )		
		MISSDK_MISSIONSDK_LUA_000135 = GetResString("MISSDK_MISSIONSDK_LUA_000135")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000135..sid )
		MISSDK_MISSIONSDK_LUA_000135 = GetResString("MISSDK_MISSIONSDK_LUA_000135")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000135..sid )
		return
	end
	
	if Mission[sid].tp == NOMAL_MISSION or Mission[sid].tp == WORLD_MISSION then
		SendMissionLog( character, Mission[sid], Mission[sid].id, Mission[sid].name )
	elseif Mission[sid].tp == RAND_MISSION then
		local ret, index, loopdata = GetCharRandMission( character, Mission[sid].id, Mission[sid] )
		if ret ~= LUA_TRUE or index == 0 then
			--根据随机任务参数生成随机任务信息错误
			MISSDK_MISSIONSDK_LUA_000136 = GetResString("MISSDK_MISSIONSDK_LUA_000136")
			PRINT( MISSDK_MISSIONSDK_LUA_000136 )
			MISSDK_MISSIONSDK_LUA_000136 = GetResString("MISSDK_MISSIONSDK_LUA_000136")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000136 )
			return
		end
		
		PRINT( "MissionLog:SendMissionLog, index = , mission = ", index, Mission[sid].missionlist[index] )
		SendMissionLog( character, Mission[sid].missionlist[index], Mission[sid].id, Mission[sid].name )
	else
		MISSDK_MISSIONSDK_LUA_000137 = GetResString("MISSDK_MISSIONSDK_LUA_000137")
		PRINT( MISSDK_MISSIONSDK_LUA_000137..sid )
		MISSDK_MISSIONSDK_LUA_000138 = GetResString("MISSDK_MISSIONSDK_LUA_000138")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000138..sid )		
	end
end

--发送任务日志信息
function SendMissionLog( character, mission, id, name )
	PRINT( "SendMissionLog" )
	if id == nil or mission == nil then
		MISSDK_MISSIONSDK_LUA_000139 = GetResString("MISSDK_MISSIONSDK_LUA_000139")
		return SystemNotice( character, MISSDK_MISSIONSDK_LUA_000139..id )		
	end
	
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_MISLOGINFO )
	WriteWord( packet, id )
	
	--发送任务需求信息
	WriteString( packet, name )
	PRINT( "SendMissionLog:misname = ", name )
	WriteByte( packet, mission.need.count )
	PRINT( "SendMissionLog:need count = "..mission.need.count )
	for n = 1, mission.need.count, 1 do
		PRINT( "SendMissionLog:need n = , tp, p1, p2, p3 ", n, mission.need[n].tp, mission.need[n].p1, mission.need[n].p2, mission.need[n].p3 )
		WriteByte( packet, mission.need[n].tp )
		if mission.need[n].tp == MIS_NEED_ITEM then
			WriteWord( packet, mission.need[n].p1 )
			WriteWord( packet, mission.need[n].p2 )
			--获取任务需求完成计数
			local ret, num = GetNeedItemCount( character, id, mission.need[n].p1 )
			PRINT( "SendMissionLog:GetNeedItemCount, num = ", num )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000140 = GetResString("MISSDK_MISSIONSDK_LUA_000140")
				PRINT( MISSDK_MISSIONSDK_LUA_000140, id, mission.need[n].p1, mission.need[n].p2 )
				MISSDK_MISSIONSDK_LUA_000141 = GetResString("MISSDK_MISSIONSDK_LUA_000141")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000141 )
				MISSDK_MISSIONSDK_LUA_000140 = GetResString("MISSDK_MISSIONSDK_LUA_000140")
				LG( "mislog_error", MISSDK_MISSIONSDK_LUA_000140, id, mission.need[n].p1, mission.need[n].p2 )
				num = 0
			end
			WriteByte( packet, num )
		elseif mission.need[n].tp == MIS_NEED_KILL then
			WriteWord( packet, mission.need[n].p1 )
			WriteWord( packet, mission.need[n].p2 )
			--获取任务需求完成计数
			PRINT( "SendMissionLog:GetNumFlag:GetNumFalg, id, p1, p2", id, mission.need[n].p3, mission.need[n].p2 )
			WriteByte( packet, GetNumFlag( character, id, mission.need[n].p3, mission.need[n].p2 ) )	
		elseif mission.need[n].tp == MIS_NEED_DESP then
			WriteString( packet, mission.need[n].p1 )
		else
			MISSDK_MISSIONSDK_LUA_000142 = GetResString("MISSDK_MISSIONSDK_LUA_000142")
			PRINT( MISSDK_MISSIONSDK_LUA_000142, id )
			MISSDK_MISSIONSDK_LUA_000142 = GetResString("MISSDK_MISSIONSDK_LUA_000142")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000142, id )
			return
		end
	end
	
	--发送任务奖励信息
	WriteByte( packet, mission.prize.seltp )
	WriteByte( packet, mission.prize.count )
	PRINT( "SendMissionLog:prize count = , seltype =", mission.prize.count, mission.prize.seltp )
	for i = 1, mission.prize.count, 1 do
		PRINT( "SendMissionLog:prize i = , tp, p1, p2 ", i, mission.prize[i].tp, mission.prize[i].p1, mission.prize[i].p2 )
		WriteByte( packet, mission.prize[i].tp )
		WriteWord( packet, mission.prize[i].p1 )
		WriteWord( packet, mission.prize[i].p2 )
	end
	
	--发送任务描述信息
	PRINT( "SendMissionLog:begin talk = "..mission.begin.talk )
	WriteString( packet, mission.begin.talk )
	SendPacket( character, packet )
end

--发送任务交付页信息
function SendDeliveryPage( character, npcid, mission, id )
	PRINT( "SendDeliveryPage" )

	--发送报文信息
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_MISPAGE )
	WriteByte( packet, MIS_BTNDELIVERY )
	WriteDword( packet, npcid )	
	WriteString( packet, mission.name )
	PRINT( "SenddeliveryPage:missionname = ", mission.name )
	PRINT( "SendDeliveryPage:need = ", mission.need )
	
	--发送任务需求信息
	--完成任务页不发送任务需求消息
	WriteByte( packet, 0 )
	--WriteByte( packet, mission.need.count )
	--PRINT( "SendDeliveryPage:need count = "..mission.need.count )
	--for n = 1, mission.need.count, 1 do
		--PRINT( "SendDeliveryPage:need n = , tp, p1, p2, p3 ", n, mission.need[n].tp, mission.need[n].p1, mission.need[n].p2, mission.need[n].p3 )
		--WriteByte( packet, mission.need[n].tp )
		--if mission.need[n].tp == MIS_NEED_ITEM then
			--WriteWord( packet, mission.need[n].p1 )
			--WriteWord( packet, mission.need[n].p2 )
			----获取任务需求完成计数
			--local ret, num = GetNeedItemCount( character, id, mission.need[n].p1 )
			--PRINT( "SendDeliveryPage:GetNeedItemCount, num = ", num )
			--if ret ~= LUA_TRUE then
				--PRINT( "SendDeliveryPage:GetNeedItemCount,error。itemid = , num = ", mission.need[n].p1, mission.need[n].p2 )
				--SystemNotice( character, "SendDeliveryPage:GetNeedItemCount,error。" )
				--LG( "mislog_error", "SendDeliveryPage:GetNeedItemCount,error。itemid = , num = ", mission.need[n].p1, mission.need[n].p2 )
				--num = 0
			--end
			--WriteByte( packet, num )
		--elseif mission.need[n].tp == MIS_NEED_KILL then
			--WriteWord( packet, mission.need[n].p1 )
			--WriteWord( packet, mission.need[n].p2 )
			----获取任务需求完成计数
			--PRINT( "SendDeliveryPage:GetNumFlag:GetNumFalg, id, p1, p2", id, mission.need[n].p3, mission.need[n].p2 )
			--WriteByte( packet, GetNumFlag( character, id, mission.need[n].p3, mission.need[n].p2 ) )	
		--elseif mission.need[n].tp == MIS_NEED_DESP then
			--WriteString( packet, mission.need[n].p1 )
		--else
			--PRINT( "SendDeliveryPage:未知的任务需求类型！mission id = ", id )
			--SystemNotice( character, "SendDeliveryPage:未知的任务需求类型！mission id = ", id )
			--return
		--end
	--end
	
	--发送任务奖励信息
	WriteByte( packet, mission.prize.seltp )
	WriteByte( packet, mission.prize.count )
	PRINT( "SendDeliveryPage:prize count = , seltype =", mission.prize.count, mission.prize.seltp )
	for i = 1, mission.prize.count, 1 do
		PRINT( "SendDeliveryPage:prize i = , tp, p1, p2 ", i, mission.prize[i].tp, mission.prize[i].p1, mission.prize[i].p2 )
		WriteByte( packet, mission.prize[i].tp )
		WriteWord( packet, mission.prize[i].p1 )
		WriteWord( packet, mission.prize[i].p2 )
		--WriteWord( packet, mission.prize[i].p3 )
		--WriteWord( packet, mission.prize[i].p4 )
	end
	
	--发送任务描述信息
	PRINT( "SendDeliveryPage:result talk = "..mission.result.talk )
	WriteString( packet, mission.result.talk )
	SendPacket( character, packet )
end

--发送一个任务给角色
function GiveMission( character, id )
	if id == nil or Mission[id] == nil then
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		PRINT( MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000143..id )
		return LUA_FALSE
	end
	
	local ret, npc = GetEudemon()
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000144 = GetResString("MISSDK_MISSIONSDK_LUA_000144")
		PRINT( MISSDK_MISSIONSDK_LUA_000144 )
		MISSDK_MISSIONSDK_LUA_000144 = GetResString("MISSDK_MISSIONSDK_LUA_000144")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000144 )
		return LUA_FALSE
	end
	
	local npcid = GetCharID( npc )
	PRINT( "GiveMission: npcid, id, mistp", npcid, id, Mission[id].tp )
	ret = SetMissionTempInfo( character, npcid, id, MIS_ACCEPT, Mission[id].tp )
	if ret ~= LUA_TRUE then 
		MISSDK_MISSIONSDK_LUA_000121 = GetResString("MISSDK_MISSIONSDK_LUA_000121")
		PRINT( MISSDK_MISSIONSDK_LUA_000121 )
		MISSDK_MISSIONSDK_LUA_000122 = GetResString("MISSDK_MISSIONSDK_LUA_000122")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000122 )
		return LUA_FALSE
	end
	
	SendAcceptPage( character, npcid, Mission[id], Mission[id].id )
	return LUA_TRUE
end

--强制交付一个任务
function ObligeCompleteMission( character, id )
	if id == nil or Mission[id] == nil then
		MISSDK_MISSIONSDK_LUA_000145 = GetResString("MISSDK_MISSIONSDK_LUA_000145")
		PRINT( MISSDK_MISSIONSDK_LUA_000145..id )
		MISSDK_MISSIONSDK_LUA_000145 = GetResString("MISSDK_MISSIONSDK_LUA_000145")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000145..id )
		MISSDK_MISSIONSDK_LUA_000145 = GetResString("MISSDK_MISSIONSDK_LUA_000145")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000145..id )
		return LUA_FALSE
	end
	
	local ret, npc = GetEudemon()
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000146 = GetResString("MISSDK_MISSIONSDK_LUA_000146")
		PRINT( MISSDK_MISSIONSDK_LUA_000146 )
		MISSDK_MISSIONSDK_LUA_000146 = GetResString("MISSDK_MISSIONSDK_LUA_000146")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000146 )
		return LUA_FALSE
	end
	
	local npcid = GetCharID( npc )
	PRINT( "ObligeCompleteMission: npcid, id, mistp", npcid, id, Mission[id].tp )
	ret = SetMissionTempInfo( character, npcid, id, MIS_ACCEPT, Mission[id].tp )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000147 = GetResString("MISSDK_MISSIONSDK_LUA_000147")
		PRINT( MISSDK_MISSIONSDK_LUA_000147 )
		MISSDK_MISSIONSDK_LUA_000147 = GetResString("MISSDK_MISSIONSDK_LUA_000147")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000147 )
		return LUA_FALSE
	end
	
	ret = CompleteMission( character, npc )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000148 = GetResString("MISSDK_MISSIONSDK_LUA_000148")
		SystemNotice( MISSDK_MISSIONSDK_LUA_000148 )
		MISSDK_MISSIONSDK_LUA_000149 = GetResString("MISSDK_MISSIONSDK_LUA_000149")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000149 )
		return LUA_FALSE
	end
	
	--SendPendingPage( character, npcid, Mission[id], Mission[id].id )
	MISSDK_MISSIONSDK_LUA_000150 = GetResString("MISSDK_MISSIONSDK_LUA_000150")
	MISSDK_MISSIONSDK_LUA_000098 = GetResString("MISSDK_MISSIONSDK_LUA_000098")
	BickerNotice( character, MISSDK_MISSIONSDK_LUA_000098..Mission[id].name..MISSDK_MISSIONSDK_LUA_000150 )
	return LUA_TRUE
end

--强制接受一个任务
function ObligeAcceptMission( character, id )
	if id == nil or Mission[id] == nil then
		MISSDK_MISSIONSDK_LUA_000151 = GetResString("MISSDK_MISSIONSDK_LUA_000151")
		PRINT( MISSDK_MISSIONSDK_LUA_000151..id )
		MISSDK_MISSIONSDK_LUA_000151 = GetResString("MISSDK_MISSIONSDK_LUA_000151")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000151..id )
		MISSDK_MISSIONSDK_LUA_000151 = GetResString("MISSDK_MISSIONSDK_LUA_000151")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000151..id )
		return LUA_FALSE
	end
	
	local ret, npc = GetEudemon()
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000152 = GetResString("MISSDK_MISSIONSDK_LUA_000152")
		PRINT( MISSDK_MISSIONSDK_LUA_000152 )
		MISSDK_MISSIONSDK_LUA_000152 = GetResString("MISSDK_MISSIONSDK_LUA_000152")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000152 )
		return LUA_FALSE
	end
	
	ret = IsMissionFull( character )
	if ret == LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000153 = GetResString("MISSDK_MISSIONSDK_LUA_000153")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000153 )
		return LUA_TRUE
	end

	local npcid = GetCharID( npc )
	PRINT( "ObligeMission: npcid, id, mistp", npcid, id, Mission[id].tp )
	ret = SetMissionTempInfo( character, npcid, id, MIS_ACCEPT, Mission[id].tp )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000154 = GetResString("MISSDK_MISSIONSDK_LUA_000154")
		PRINT( MISSDK_MISSIONSDK_LUA_000154 )
		MISSDK_MISSIONSDK_LUA_000154 = GetResString("MISSDK_MISSIONSDK_LUA_000154")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000154 )
		return LUA_FALSE
	end
	
	ret = AcceptMission( character, npc )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000155 = GetResString("MISSDK_MISSIONSDK_LUA_000155")
		SystemNotice( MISSDK_MISSIONSDK_LUA_000155 )
		MISSDK_MISSIONSDK_LUA_000155 = GetResString("MISSDK_MISSIONSDK_LUA_000155")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000155 )
		return LUA_FALSE
	end
	
	SendPendingPage( character, npcid, Mission[id], Mission[id].id )
	return LUA_TRUE
end

--发送任务接受页信息
function SendAcceptPage( character, npcid, mission, id )	
	PRINT( "SendAcceptPage" )

	--发送报文信息
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_MISPAGE )
	WriteByte( packet, MIS_BTNACCEPT )
	WriteDword( packet, npcid )	
	WriteString( packet, mission.name )
	PRINT( "SendAcceptPage: name = ", mission.name )
	
	--发送任务需求信息
	WriteByte( packet, mission.need.count )
	PRINT( "SendAcceptPage:need count = "..mission.need.count )
	for n = 1, mission.need.count, 1 do
		PRINT( "SendAcceptPage:need n = , tp, p1, p2, p3 ", n, mission.need[n].tp, mission.need[n].p1, mission.need[n].p2, mission.need[n].p3 )
		WriteByte( packet, mission.need[n].tp )
		if mission.need[n].tp == MIS_NEED_ITEM or mission.need[n].tp == MIS_NEED_KILL then
			WriteWord( packet, mission.need[n].p1 )
			WriteWord( packet, mission.need[n].p2 )
			--获取任务需求完成计数
			WriteByte( packet, 0 )
		elseif mission.need[n].tp == MIS_NEED_DESP then
			WriteString( packet, mission.need[n].p1 )
		else
			MISSDK_MISSIONSDK_LUA_000156 = GetResString("MISSDK_MISSIONSDK_LUA_000156")
			PRINT( MISSDK_MISSIONSDK_LUA_000156, id )
			MISSDK_MISSIONSDK_LUA_000156 = GetResString("MISSDK_MISSIONSDK_LUA_000156")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000156, id )
			return
		end
	end
	
	--发送任务奖励信息
	WriteByte( packet, mission.prize.seltp )
	WriteByte( packet, mission.prize.count )
	PRINT( "SendAcceptPage:prize count = , seltype =", mission.prize.count, mission.prize.seltp )
	for i = 1, mission.prize.count, 1 do
		PRINT( "SendAcceptPage:prize i = , tp, p1, p2 ", i, mission.prize[i].tp, mission.prize[i].p1, mission.prize[i].p2 )
		WriteByte( packet, mission.prize[i].tp )
		WriteWord( packet, mission.prize[i].p1 )
		WriteWord( packet, mission.prize[i].p2 )
		--WriteWord( packet, mission.prize[i].p3 )
		--WriteWord( packet, mission.prize[i].p4 )
	end
	
	--发送任务描述信息
	PRINT( "SendAcceptPage:begin talk = "..mission.begin.talk )
	WriteString( packet, mission.begin.talk )
	SendPacket( character, packet )
end

--发送任务未决页信息
function SendPendingPage( character, npcid, mission, id )
	PRINT( "SendPendingPage" )
	
	--发送报文信息
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_MISPAGE )
	WriteByte( packet, MIS_BTNPENDING )
	WriteDword( packet, npcid )
	WriteString( packet, mission.name )
	PRINT( "SendPendingPage: name = ", mission.name )
	
	--发送任务需求信息
	WriteByte( packet, mission.need.count )
	PRINT( "SendPendingPage:need count = "..mission.need.count )
	for n = 1, mission.need.count, 1 do
		PRINT( "SendPendingPage:need n = , tp, p1, p2, p3 ", n, mission.need[n].tp, mission.need[n].p1, mission.need[n].p2, mission.need[n].p3 )
		WriteByte( packet, mission.need[n].tp )
		if mission.need[n].tp == MIS_NEED_ITEM then
			WriteWord( packet, mission.need[n].p1 )
			WriteWord( packet, mission.need[n].p2 )
			--获取任务需求完成计数
			local ret, num = GetNeedItemCount( character, id, mission.need[n].p1 )
			PRINT( "SendPendingPage:GetNeedItemCount, num = ", num )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000157 = GetResString("MISSDK_MISSIONSDK_LUA_000157")
				PRINT( MISSDK_MISSIONSDK_LUA_000157, mission.need[n].p1, mission.need[n].p2 )
				MISSDK_MISSIONSDK_LUA_000158 = GetResString("MISSDK_MISSIONSDK_LUA_000158")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000158 )
				num = 0
			end
			WriteByte( packet, num )
		elseif mission.need[n].tp == MIS_NEED_KILL then
			WriteWord( packet, mission.need[n].p1 )
			WriteWord( packet, mission.need[n].p2 )
			--获取任务需求完成计数
			local numflag  = GetNumFlag( character, id, mission.need[n].p3, mission.need[n].p2 )
			PRINT( "SendPendingPage:GetNumFlag, numflag = ", numflag )
			WriteByte( packet, numflag )		
		elseif mission.need[n].tp == MIS_NEED_DESP then
			WriteString( packet, mission.need[n].p1 )
		else
			MISSDK_MISSIONSDK_LUA_000159 = GetResString("MISSDK_MISSIONSDK_LUA_000159")
			PRINT( MISSDK_MISSIONSDK_LUA_000159, id )
			MISSDK_MISSIONSDK_LUA_000159 = GetResString("MISSDK_MISSIONSDK_LUA_000159")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000159..id )
			return
		end
	end
	
	--发送任务奖励信息
	WriteByte( packet, mission.prize.seltp )
	WriteByte( packet, mission.prize.count )
	PRINT( "SendPendingPage:prize count = , seltype =", mission.prize.count, mission.prize.seltp )
	for i = 1, mission.prize.count, 1 do
		PRINT( "SendPendingPage:prize i = , tp, p1, p2 ", i, mission.prize[i].tp, mission.prize[i].p1, mission.prize[i].p2 )
		WriteByte( packet, mission.prize[i].tp )
		WriteWord( packet, mission.prize[i].p1 )
		WriteWord( packet, mission.prize[i].p2 )
		--WriteWord( packet, mission.prize[i].p3 )
		--WriteWord( packet, mission.prize[i].p4 )
	end
	
	--发送任务描述信息
	PRINT( "SendPendingPage:help = ", mission.result.help )
	WriteString( packet, mission.result.help )
	SendPacket( character, packet )
end

--任务奖励操作
function MisPrizeProc( character, npc, mission, selitem, param )
	if mission == nil then
		MISSDK_MISSIONSDK_LUA_000160 = GetResString("MISSDK_MISSIONSDK_LUA_000160")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000160 )
		return LUA_FALSE
	end
	PRINT( "MisPrizeProc:prize count =, sel type = , selitem = ", mission.prize.count, mission.prize.seltp, selitem )
	if mission.prize.seltp == PRIZE_SELONE then
	--单选
		if selitem == nil then
			MISSDK_MISSIONSDK_LUA_000161 = GetResString("MISSDK_MISSIONSDK_LUA_000161")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000161 )
			return LUA_FALSE
		end
		selitem = selitem + 1
		if selitem > mission.prize.count or mission.prize == nil or mission.prize[selitem] == nil then
			MISSDK_MISSIONSDK_LUA_000162 = GetResString("MISSDK_MISSIONSDK_LUA_000162")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000162 )
			return LUA_FALSE
		end
		if mission.prize[selitem].tp == nil or mission.prize[selitem].p1 == nil or mission.prize[selitem].p2 == nil  then
			MISSDK_MISSIONSDK_LUA_000163 = GetResString("MISSDK_MISSIONSDK_LUA_000163")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000163 )
			return LUA_FALSE
		end
		return MisPrizeAction( character, npc, mission.prize[selitem].tp, mission.prize[selitem].p1, mission.prize[selitem].p2, mission.prize[selitem].p3, mission.prize[selitem].p4 )
	elseif mission.prize.seltp == PRIZE_SELALL then 
	--全选
		for n = 1, mission.prize.count, 1 do
			PRINT( "MisPrizeProc: prize n = "..n )
			if mission.prize[n].tp == nil or mission.prize[n].p1 == nil or mission.prize[n].p2 == nil  then
				MISSDK_MISSIONSDK_LUA_000163 = GetResString("MISSDK_MISSIONSDK_LUA_000163")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000163 )
				return LUA_FALSE
			end
			local ret = MisPrizeAction( character, npc, mission.prize[n].tp, mission.prize[n].p1, mission.prize[n].p2, mission.prize[n].p3, mission.prize[n].p4 )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end
		end
	else
		MISSDK_MISSIONSDK_LUA_000164 = GetResString("MISSDK_MISSIONSDK_LUA_000164")
		PRINT( MISSDK_MISSIONSDK_LUA_000164 )
		MISSDK_MISSIONSDK_LUA_000164 = GetResString("MISSDK_MISSIONSDK_LUA_000164")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000164 )
		return LUA_FALSE
	end
	return LUA_TRUE
end

function AddPetExp( character, p1, p2 )
	PRINTF( "AddPetExp: p1 = , p2 = ", p1, p2 )
	if p1 == nil or p2 == nil then
		MISSDK_MISSIONSDK_LUA_000018 = GetResString("MISSDK_MISSIONSDK_LUA_000018")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000018 )
		return LUA_FALSE
	end
	
	return Give_ElfEXP_MISSION ( character , p1 + Rand( p2 ) )
end

--任务奖励操作
function MisPrizeAction( character, npc, tp, p1, p2, p3, p4 )
	PRINT( "MisPrizeAction:tp, p1, p2, p3, p4", tp, p1, p2, p3, p4 )
	if tp == MIS_PRIZE_ITEM then
		PRINT( "MisPrizeAction:GiveItem, p1 = , p2 = ", p1, p2, p3 )
		local ret = GiveItem( character, npc, p1, p2, p3 )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000165 = GetResString("MISSDK_MISSIONSDK_LUA_000165")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000165 )
			MISSDK_MISSIONSDK_LUA_000166 = GetResString("MISSDK_MISSIONSDK_LUA_000166")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000166, GetCharName( npc ), tp, p1, p2, p3 )
			return LUA_FALSE
		end
	elseif tp == MIS_PRIZE_MONEY then
		PRINT( "MisPrizeAction:AddMoney, p1 = "..p1 )
		local ret = AddMoney( character, npc, p1 )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000167 = GetResString("MISSDK_MISSIONSDK_LUA_000167")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000167 )
			MISSDK_MISSIONSDK_LUA_000168 = GetResString("MISSDK_MISSIONSDK_LUA_000168")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000168, GetCharName( npc ), tp, p1, p2 )
			return LUA_FALSE
		end		
	elseif tp == MIS_PRIZE_FAME then
		PRINT( "MisPrizeAction:AddFame, p1 = "..p1 )
		--local ret = AddFame( character, npc, p1 )
		--if ret ~= LUA_TRUE then
			--SystemNotice( character, "MisPrizeAction:AddFame:函数调用失败！" )
			--LG( "mission_error", "MisPrizeAction:AddFame:函数调用失败！npcname = , tp = , p1 = , p2  ", GetCharName( npc ), tp, p1, p2 )
			--return LUA_FALSE
		--end
	elseif tp == MIS_PRIZE_CESS then
		PRINT( "MisPrizeAction:AdjustTradeCess" )
		local ret = AdjustTradeCess( character, p1, p2 )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000169 = GetResString("MISSDK_MISSIONSDK_LUA_000169")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000169 )
			MISSDK_MISSIONSDK_LUA_000170 = GetResString("MISSDK_MISSIONSDK_LUA_000170")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000170, GetCharName( npc ), tp, p1, p2 )
			return LUA_FALSE
		end
	elseif tp == MIS_PRIZE_PETEXP then
		PRINT( "MisPrizeAction:AddPetExp" )
		local ret = AddPetExp( character, p1, p2 )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000171 = GetResString("MISSDK_MISSIONSDK_LUA_000171")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000171 )
			MISSDK_MISSIONSDK_LUA_000172 = GetResString("MISSDK_MISSIONSDK_LUA_000172")
			LG( "mission_error", MISSDK_MISSIONSDK_LUA_000172, GetCharName( npc ), tp, p1, p2 )
			return LUA_FALSE
		end
	else
		MISSDK_MISSIONSDK_LUA_000173 = GetResString("MISSDK_MISSIONSDK_LUA_000173")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000173 )
		return LUA_FALSE
	end
	return LUA_TRUE
end

--任务NPC状态检测
function MissionState( character, npcid, missionlist )
	PRINT( "MissionState" )
	if missionlist == nil then
		MISSDK_MISSIONSDK_LUA_000174 = GetResString("MISSDK_MISSIONSDK_LUA_000174")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000174 )
		return LUA_FALSE
	end
	--检测任务状态
	for i = 1, 32, 1 do
		if missionlist[i] == nil then
			break
		end
		local mission = missionlist[i]
		if mission.name == nil or mission.id == nil then
			MISSDK_MISSIONSDK_LUA_000175 = GetResString("MISSDK_MISSIONSDK_LUA_000175")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000175 )
			return LUA_FALSE
		end
		if mission.tp == NOMAL_MISSION then
			PRINT( "MissionState:nomal mission" )
			--判断角色是否有该任务		
			PRINT( "MissionState:2, ID =", mission.id )		
			local ret = HasMission( character, mission.id )
			PRINT( "MissionState:5" )
			if ret == LUA_TRUE then
				if mission.result == nil then
					MISSDK_MISSIONSDK_LUA_000176 = GetResString("MISSDK_MISSIONSDK_LUA_000176")
					SystemNotice( character, MISSDK_MISSIONSDK_LUA_000176 )
				else
					local ret = NpcTriggerCheck( character, mission.result )
					if ret == LUA_TRUE then
						--检测到可以还任务跳出循环检测并记录数据信息
						PRINT( "MissionState:Add state = %d delivery, i = %d", MIS_DELIVERY, i )
						AddMissionState( character, npcid, i, MIS_DELIVERY )
					elseif mission.show ~= COMPLETE_SHOW then
						PRINT( "MissionState:Add state = %d pending, i = %d", MIS_PENDING, i )
						AddMissionState( character, npcid, i, MIS_PENDING )
					end
				end
			else
				PRINT( "MissionState:3" )
				if mission.begin == nil then
					MISSDK_MISSIONSDK_LUA_000177 = GetResString("MISSDK_MISSIONSDK_LUA_000177")
					SystemNotice( character, MISSDK_MISSIONSDK_LUA_000177 )
				else
					local ret = NpcTriggerCheck( character, mission.begin )
					if ret == LUA_TRUE then
						--检测到可以接任务记录数据信息
						PRINT( "MissionState:Add state = %d accept, i = %d", MIS_ACCEPT, i )
						AddMissionState( character, npcid, i, MIS_ACCEPT )
					end
				end
			end
		elseif mission.tp == RAND_MISSION then
			PRINT( "MissionState:rand mission, mission.id", mission.id )
			local ret = HasRandMission( character, mission.id )
			if ret == LUA_TRUE then
				--已经接了随机任务，查看他是否可以交付
				PRINT( "MissionState, GetCharRandMission" )
				local ret, index = GetCharRandMission( character, mission.id, mission )
				PRINT( "MissionState:GetCharRandMission, ret =, index =  ", ret, index )
				if ret == LUA_TRUE and index ~= 0 then
					PRINT( "MissionState: proc rand mission" )
					if mission.missionlist[index] == nil or mission.missionlist[index].result == nil then
						MISSDK_MISSIONSDK_LUA_000178 = GetResString("MISSDK_MISSIONSDK_LUA_000178")
						SystemNotice( character, MISSDK_MISSIONSDK_LUA_000178 )
					else
						PRINT( "MissionState: RandMission, NpcTriggerCheck" )
						ret = NpcTriggerCheck( character, mission.missionlist[index].result )
						if ret == LUA_TRUE then
							--检测到可以还任务跳出循环检测并记录数据信息		
							MISSDK_MISSIONSDK_LUA_000179 = GetResString("MISSDK_MISSIONSDK_LUA_000179")
							PRINT( MISSDK_MISSIONSDK_LUA_000179, MIS_DELIVERY, i )
							AddMissionState( character, npcid, i, MIS_DELIVERY )
						else
							MISSDK_MISSIONSDK_LUA_000180 = GetResString("MISSDK_MISSIONSDK_LUA_000180")
							PRINT( MISSDK_MISSIONSDK_LUA_000180, MIS_PENDING, i )
							AddMissionState( character, npcid, i, MIS_PENDING )
						end
					end
				end
			else
				--未接随机任务，看是否可以接
				local ret = IsRandMissionAccept( character, mission )
				if ret == LUA_TRUE then
					ret = NpcTriggerCheck( character, mission.begin )
					if ret == LUA_TRUE then
						MISSDK_MISSIONSDK_LUA_000181 = GetResString("MISSDK_MISSIONSDK_LUA_000181")
						PRINT( MISSDK_MISSIONSDK_LUA_000181, MIS_ACCEPT, i )
						AddMissionState( character, npcid, i, MIS_ACCEPT )					
					end
				end
			end
			
		else
			PRINT( "MissionState:mission tp error, mission.tp = ", mission.tp )			
		end
	end
	
	PRINT( "MissionState:return true" )
	return LUA_TRUE
end

--刷新npc任务状态标志信息
function RefreshMissionState( character, npc )
	if character == nil or npc == nil then
		MISSDK_MISSIONSDK_LUA_000182 = GetResString("MISSDK_MISSIONSDK_LUA_000182")
		PRINT( MISSDK_MISSIONSDK_LUA_000182 )
	end
	return ResetMissionState( character, npc )
end

--刷新任务完成状态
function RefreshCompleteFlag( character, sid )
	PRINT( "RefreshCompleteFlag" )
	if sid == nil or Mission[sid] == nil then
		MISSDK_MISSIONSDK_LUA_000183 = GetResString("MISSDK_MISSIONSDK_LUA_000183")
		PRINT( MISSDK_MISSIONSDK_LUA_000183..sid )
		MISSDK_MISSIONSDK_LUA_000183 = GetResString("MISSDK_MISSIONSDK_LUA_000183")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000183..sid )
		return LUA_FALSE
	end

	local mission = Mission[sid]
	if Mission[sid].tp == NOMAL_MISSION then
		mission = Mission[sid]
	elseif Mission[sid].tp == RAND_MISSION then
		--已经接了随机任务，查看他是否可以交付
		PRINT( "RefreshCompleteFlag, GetCharRandMission" )
		local ret, index = GetCharRandMission( character, Mission[sid].id, Mission[sid] )
		PRINT( "RefreshCompleteFlag:GetCharRandMission, ret =, index =  ", ret, index )
		if ret == LUA_TRUE and index ~= 0 then
			PRINT( "RefreshCompleteFlag: proc rand mission" )
			if Mission[sid].missionlist[index] == nil or Mission[sid].missionlist[index].result == nil then
				MISSDK_MISSIONSDK_LUA_000178 = GetResString("MISSDK_MISSIONSDK_LUA_000178")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000178 )
				return LUA_FALSE
			end
			mission = Mission[sid].missionlist[index]
		else
			MISSDK_MISSIONSDK_LUA_000184 = GetResString("MISSDK_MISSIONSDK_LUA_000184")
			PRINT( MISSDK_MISSIONSDK_LUA_000184 )
			return LUA_FALSE
		end
	end
	
	PRINT( "RefreshCompleteFlag:NpcTriggerCheck" )
	local ret = NpcTriggerCheck( character, mission.result )
	if ret == LUA_TRUE then
		--检测到任务完成
		MISSDK_MISSIONSDK_LUA_000185 = GetResString("MISSDK_MISSIONSDK_LUA_000185")
		PRINT( MISSDK_MISSIONSDK_LUA_000185 )
		--SystemNotice( character, "RefreshCompleteFlag:任务已经完成！" )
		ret = SetMissionComplete( character, Mission[sid].id )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000186 = GetResString("MISSDK_MISSIONSDK_LUA_000186")
			PRINT( MISSDK_MISSIONSDK_LUA_000186 )
			MISSDK_MISSIONSDK_LUA_000186 = GetResString("MISSDK_MISSIONSDK_LUA_000186")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000186 )
		end
	end
	
	PRINT( "RefreshCompleteFlag:return true" )
	return LUA_TRUE
end

--任务条件判断处理函数
function ConditionsTest( character, conditions, param1, param2, npc )
	if conditions == nil then
		MISSDK_MISSIONSDK_LUA_000187 = GetResString("MISSDK_MISSIONSDK_LUA_000187")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000187 )
		return LUA_FALSE
	end

	if conditions[1] == nil then
		MISSDK_MISSIONSDK_LUA_000188 = GetResString("MISSDK_MISSIONSDK_LUA_000188")
		PRINT( MISSDK_MISSIONSDK_LUA_000188 )
	else
		local num = TR_MAXNUM_CONDITIONS
		if conditions.count ~= nil then
			num = conditions.count
		end
		for i = 1, num, 1 do --检测触发器限制条件最多12个条件
			if conditions[i] == nil then			
				break;
			end
			if conditions[i].func == nil then
				MISSDK_MISSIONSDK_LUA_000189 = GetResString("MISSDK_MISSIONSDK_LUA_000189")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000189 )			
			end
			if conditions[i].func == NoMission then
				PRINT( "ConditionsTest:NoMission, p1 = ", conditions[i].p1 )
				local Ret = NoMission( character, conditions[i].p1 )
				if Ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: NoMission = false" )
					return LUA_FALSE
				end
				
					-------------------------------------------------------------------------------------------------------------------------------
		elseif conditions[i].func == Sdhd_check then-------------------------找相关行添加
				local ret = Sdhd_check(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
		
									
				
			elseif conditions[i].func == HasMission then
				PRINT( "ConditionsTest:HasMission, p1 = ", conditions[i].p1 )
				local ret = HasMission( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: HasMission = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasRandMission then
				PRINT( "ConditionsTest:HasRandMission, p1 = ", conditions[i].p1 )
				local ret = HasRandMission( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: HasRandMission = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasMisssionFailure then
				PRINT( "ConditionsTest:HasMisssionFailure, p1 = ", conditions[i].p1 )
				local ret = HasMisssionFailure( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: HasMisssionFailure = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoMisssionFailure then
				PRINT( "ConditionsTest:NoMisssionFailure, p1 = ", conditions[i].p1 )
				local ret = NoMisssionFailure( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: NoMisssionFailure = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoRecord then
				PRINT( "ConditionsTest:NoRecord, p1 = ", conditions[i].p1 )
				local ret = NoRecord( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: NoRecord = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasState then
				PRINT( "ConditionsTest:HasState, p1 = ", conditions[i].p1 )
				local ret = HasState( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: HasState = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsChaType then
				PRINT( "ConditionsTest:IsChaType, p1 = ", conditions[i].p1 )
				local ret = IsChaType( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: IsChaType = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoChaType then
				PRINT( "ConditionsTest:NoChaType, p1 = ", conditions[i].p1 )
				local ret = NoChaType( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: NoChaType = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasRecord then
				PRINT( "ConditionsTest:HasRecord, p1 = ", conditions[i].p1 )
				local ret = HasRecord( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest: HasRecord = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoFlag then
				PRINT( "ConditionsTest:NoFlag, p1 =, p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = NoFlag( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoFlag = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasAllFlag then
				PRINT( "ConditionsTest:HasAllFlag, p1 =, p2 = ", conditions[i].p1, conditions[i].p2, conditions[i].p3 ) 
				local ret = HasAllFlag( character, conditions[i].p1, conditions[i].p2, conditions[i].p3 ) 
				if ret ~= LUA_TRUE then 
					PRINT( "ConditionsTest: HasAllFlag = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasFlag then
				PRINT( "ConditionsTest:HasFlag, p1 =, p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = HasFlag( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasFlag = false" )
					return LUA_FALSE
				end		
			elseif conditions[i].func == HasItem then
				PRINT( "ConditionsTest: HasItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = HasItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasItem= false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoItem then
				PRINT( "ConditionsTest: NoItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = NoItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasCredit then
				PRINT( "ConditionsTest: HasCredit, p1 = ", conditions[i].p1)
				local ret = HasCredit( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasCredit = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasHonorPoint then
				PRINT( "ConditionsTest: HasHonorPoint, p1 = ", conditions[i].p1)
				local ret = HasHonorPoint( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasHonorPoint = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasFightingPoint then
				PRINT( "ConditionsTest: HasFightingPoint, p1 = ", conditions[i].p1)
				local ret = HasFightingPoint( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasFightingPoint = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckPoint then
				PRINT( "ConditionsTest: CheckPoint, p1 = ", conditions[i].p1)
				local ret = CheckPoint( character,conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckPoint = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == ItemAttrNum then
				PRINT( "ConditionsTest: ItemAttrNum, p1 = ", conditions[i].p1,conditions[i].p2,conditions[i].p3,conditions[i].p4)
				local ret = ItemAttrNum( character,conditions[i].p1,conditions[i].p2,conditions[i].p3,conditions[i].p4)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:ItemAttrNum = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckItemAttr then
				PRINT( "ConditionsTest: CheckItemAttr, p1 = ", conditions[i].p1,conditions[i].p2)
				local ret = CheckItemAttr( character,conditions[i].p1,conditions[i].p2)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckItemAttr = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HaveNoItem then
				PRINT( "ConditionsTest: HaveNoItem, p1 = ", conditions[i].p1)
				local ret = HaveNoItem( character,conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HaveNoItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == BankNoItem then
				PRINT( "ConditionsTest: BankNoItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = BankNoItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:BankNoItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == BankHasItem then
					PRINT( "ConditionsTest: BankHasItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = BankHasItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:BankHasItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckZBNowState then
					PRINT( "ConditionsTest: CheckZBNowState")
				local ret = CheckZBNowState( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckZBNowState = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == EquipNoItem then
				PRINT( "ConditionsTest: EquipNoItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = EquipNoItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:EquipNoItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckTeam1 then
				PRINT( "ConditionsTest:CheckTeam1, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = CheckTeam1( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckTeam1 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckRightNum then
				PRINT( "ConditionsTest:CheckRightNum, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = CheckRightNum( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckRightNum = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckErroNum then
				PRINT( "ConditionsTest:CheckErroNum, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = CheckErroNum( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckErroNum = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasReadExp then		--小测验时必须有经验
				local ret = HasReadExp( character )
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end
			elseif conditions[i].func == HasNoItem then
				PRINT( "ConditionsTest: HasNoItem, p1 = ", conditions[i].p1)
				local ret = HasNoItem( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasNoItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckXSZCh then
				PRINT( "ConditionsTest: CheckXSZCh, p1 = ", conditions[i].p1)
				local ret = CheckXSZCh( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckXSZCh = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Checksailexpless then
				PRINT( "ConditionsTest: Checksailexpless, p1 = ", conditions[i].p1)
				local ret = Checksailexpless( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Checksailexpless = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Checksailexpmore then
				PRINT( "ConditionsTest: Checksailexpmore, p1 = ", conditions[i].p1)
				local ret = Checksailexpmore( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Checksailexpmore = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckKJNum then
				PRINT( "ConditionsTest: CheckKJNum, p1 = ", conditions[i].p1)
				local ret = CheckKJNum( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckKJNum = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckRealNpc then
				PRINT( "ConditionsTest:CheckRealNpc, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = CheckRealNpc( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckRealNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoMoney then
				PRINT( "ConditionsTest: NoMoney, p1 = ", conditions[i].p1 )
				local ret = NoMoney( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoMoney = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasMoney then
				PRINT( "ConditionsTest: HasMoney, p1 = ", conditions[i].p1 )
				local ret = HasMoney( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasMoney = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasCancelMissionMoney then
				-- PRINT( "ConditionsTest: HasCancelMissionMoney" )
				-- local ret = HasCancelMissionMoney( character )
				-- if ret ~= LUA_TRUE then
					-- PRINT( "ConditionsTest:HasCancelMissionMoney = false" )
					-- return LUA_FALSE
				-- end				
			elseif conditions[i].func == IsMonster then
				PRINT( "ConditionsTest:IsMonster, p1 =, p2 =", conditions[i].p1, param1 )
				if param1 == nil then
					MISSDK_MISSIONSDK_LUA_000190 = GetResString("MISSDK_MISSIONSDK_LUA_000190")
					SystemNotice( MISSDK_MISSIONSDK_LUA_000190 )
					return LUA_FALSE
				end
				local ret = IsMonster( conditions[i].p1, param1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsMonster = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsItem then
				PRINT( "ConditionsTest:IsItem, p1 =, p2 =", conditions[i].p1, param1 )
				if param1 == nil then
					MISSDK_MISSIONSDK_LUA_000191 = GetResString("MISSDK_MISSIONSDK_LUA_000191")
					SystemNotice( MISSDK_MISSIONSDK_LUA_000191 )
					return LUA_FALSE
				end
				local ret = IsItem( conditions[i].p1, param1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsMapNpc then
				PRINT( "ConditionsTest:IsMapNpc, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = IsMapNpc( npc, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsMapNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsMapChar then
				PRINT( "ConditionsTest:IsMapChar, p1 =", conditions[i].p1 )
				local ret = IsMapChar( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsMapChar = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == LvCheck then
				PRINT( "ConditionsTest:LvCheck, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = LvCheck( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:LvCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == check_yourjob then
				PRINT( "ConditionsTest:LvCheck, p1 =, p2 =")
				local ret = check_yourjob( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:check_yourjob" )
					return LUA_FALSE
				end
			elseif conditions[i].func == TurnToJob then
				PRINT( "ConditionsTest:TurnToJob,p1 = ", conditions[i].p1 )
				local ret = TurnToJob( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:TurnToJob = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HpCheck then
				PRINT( "ConditionsTest:HpCheck, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = HpCheck( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HpCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == SpCheck then
				PRINT( "ConditionsTest:SpCheck, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = SpCheck( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:SpCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == PfEqual then
				PRINT( "ConditionsTest:PfEqual, p1 =", conditions[i].p1 )
				local ret = PfEqual( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:PfEqual = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoPfEqual then
				PRINT( "ConditionsTest:PfEqual, p1 =", conditions[i].p1 )
				local ret = NoPfEqual( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:PfEqual = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasFame then
				PRINT( "ConditionsTest:HasFame, p1 =", conditions[i].p1 )
				local ret = HasFame( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasFame = false" )
					return LUA_FALSE
				end				
			elseif conditions[i].func == Checkjlktime then
				PRINT( "ConditionsTest:Checkjlktime, p1 =", conditions[i].p1 )
				local ret = Checkjlktime( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Checkjlktime = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsInMap then
				PRINT( "ConditionsTest:IsInMap, p1 =, p2 =, p3 = , p4 = ", conditions[i].p1, conditions[i].p2, conditions[i].p3, conditions[i].p4 )
				local ret = IsInMap( character, conditions[i].p1, conditions[i].p2, conditions[i].p3, conditions[i].p4, 10000, 10000 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsInMap = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == AlwaysFailure then
				PRINT( "ConditionsTest:AlwaysFailure," )
				local ret = AlwaysFailure()
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:AlwaysFailure = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == AlwaysTrue then
				PRINT( "ConditionsTest:AlwaysTrue," )
				local ret = AlwaysTrue()
				--if ret ~= LUA_TRUE then
					--PRINT( "ConditionsTest:AlwaysTrue = false" )
					--return LUA_FALSE
				--end				
			elseif conditions[i].func == HasRandMissionNpc then
				PRINT( "ConditionsTest:HasRandMissionNpc,p1, p2, p3", conditions[i].p1, conditions[i].p2, conditions[i].p3 )
				local ret = HasRandMissionNpc( character, conditions[i].p1, conditions[i].p2, conditions[i].p3 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasRandMissionNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasRandNpcItemFlag then
				PRINT( "ConditionsTest:HasRandNpcItemFlag,p1, p2", conditions[i].p1, conditions[i].p2 )
				local ret = HasRandNpcItemFlag( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasRandNpcItemFlag = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoRandNpcItemFlag then
				PRINT( "ConditionsTest:NoRandNpcItemFlag,p1, p2", conditions[i].p1, conditions[i].p2 )
				local ret = NoRandNpcItemFlag( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoRandNpcItemFlag = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasConvoyNpc then
				PRINT( "ConditionsTest:HasConvoyNpc,p1 = ", conditions[i].p1 )
				local ret = HasConvoyNpc( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasConvoyNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckItem then
				PRINT( "ConditionsTest: CheckItem, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = CheckItem( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBag then
				PRINT( "ConditionsTest: CheckBag, p1 =, p2 =", conditions[i].p1, conditions[i].p2 ,conditions[i].p3)
				local ret = CheckBag( character, conditions[i].p1, conditions[i].p2 ,conditions[i].p3)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckBag = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBagEmp then
				PRINT( "ConditionsTest: CheckBagEmp, p1 =, p2 =", conditions[i].p1)
				local ret = CheckBagEmp( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckBagEmp = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoConvoyNpc then
				PRINT( "ConditionsTest:NoConvoyNpc,p1 = ", conditions[i].p1 )
				local ret = NoConvoyNpc( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoConvoyNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsConvoyNpc then
				PRINT( "ConditionsTest:IsConvoyNpc,p1 = , p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = IsConvoyNpc( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsConvoyNpc = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsCategory then
				PRINT( "ConditionsTest:IsCategory,p1 = ", conditions[i].p1 )
				local ret = IsCategory( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsCategory = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckConvertProfession then
				PRINT( "ConditionsTest:CheckConvertProfession,p1 = ", conditions[i].p1 )
				local ret = CheckConvertProfession( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckConvertProfession = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsSpawnPos then
				PRINT( "ConditionsTest:IsSpawnPos, p1 =", conditions[i].p1 )
				local ret = IsSpawnPos( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsSpawnPos = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasLeaveBagGrid then
				PRINT( "ConditionsTest:HasLeaveBagGrid, p1 =", conditions[i].p1 )
				local ret = HasLeaveBagGrid( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasLeaveBagGrid = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasLeaveBagTempGrid then
				PRINT( "ConditionsTest:HasLeaveBagTempGrid, p1 =", conditions[i].p1 )
				local ret = HasLeaveBagTempGrid( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasLeaveBagTempGrid = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsBoatFull then
				PRINT( "ConditionsTest:IsBoatFull" )
				local ret = IsBoatFull( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsBoatFull = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == BoatBuildCheck then
				PRINT( "ConditionsTest:BoatBuildCheck, p1 =", conditions[i].p1 )
				local ret = BoatBuildCheck( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:BoatBuildCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasBoatInBerth then
				PRINT( "ConditionsTest:HasBoatInBerth, p1 =", conditions[i].p1 )
				local ret = HasBoatInBerth( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasBoatInBerth = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasDeadBoatInBerth then
				PRINT( "ConditionsTest:HasDeadBoatInBerth, p1 =", conditions[i].p1 )
				local ret = HasDeadBoatInBerth( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasDeadBoatInBerth = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == XmasNotice then
				PRINT( "ConditionsTest: XmasNotice, p1 =, p2 =", conditions[i].p1, conditions[i].p2 )
				local ret = XmasNotice( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:XmasNotice = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckSpeed then
				PRINT( "ConditionsTest:CheckSpeed, p1 = ", conditions[i].p1 )
				local ret = CheckSpeed( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckSpeed = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckZS then
				PRINT( "ConditionsTest:CheckZS, p1 = ", conditions[i].p1 )
				local ret = CheckZS( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckZS = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasAllBoatInBerth then
				PRINT( "ConditionsTest:HasAllBoatInBerth, p1 =", conditions[i].p1 )
				local ret = HasAllBoatInBerth( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasAllBoatInBerth = false" )
					return LUA_FALSE
				end
			--elseif conditions[i].func == HasAllBoatInBerth_eitheror then
			--	PRINT( "ConditionsTest:HasAllBoatInBerth , p1 = , p2 = ", conditions[i].p1, conditions[i].p2 )
			--	local ret = HasAllBoatInBerth_eitheror( character, conditions[i].p1, conditions[i].p2 )
			--	if ret ~= LUA_TRUE then
			--		PRINT( "ConditionsTest:HasAllBoatInBerth_eitheror = false" )
			--		return LUA_FALSE
			--	end
			elseif conditions[i].func == HasLuanchOut then
				PRINT( "ConditionsTest:HasLuanchOut" )
				local ret = HasLuanchOut( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasLuanchOut = false" )
					return LUA_FALSE
				end				
			elseif conditions[i].func == HasGuild then
				PRINT( "ConditionsTest:HasGuild" )
				local ret = HasGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoGuild then
				PRINT( "ConditionsTest:NoGuild" )
				local ret = NoGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasPirateGuild then
				PRINT( "ConditionsTest:HasPirateGuild" )
				local ret = HasPirateGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasPirateGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoPirateGuild then
				PRINT( "ConditionsTest:NoPirateGuild" )
				local ret = NoPirateGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoPirateGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasNavyGuild then
				PRINT( "ConditionsTest:HasNavyGuild" )
				local ret = HasNavyGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasNavyGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == NoNavyGuild then
				PRINT( "ConditionsTest:NoNavyGuild" )
				local ret = NoNavyGuild( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NoNavyGuild = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == IsGuildType then
				PRINT( "ConditionsTest:IsGuildType, p1 = ", conditions[i].p1 )
				local ret = IsGuildType( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsGuildType = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == TradeItemLevelCheck then
				PRINT( "ConditionsTest:TradeItemLevelCheck, p1 = , p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = TradeItemLevelCheck( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:TradeItemLevelCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == TradeItemDataCheck then
				PRINT( "ConditionsTest:TradeItemDataCheck, p1 = , p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = TradeItemDataCheck( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:TradeItemDataCheck = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasOffer then
				PRINT( "ConditionsTest:HasOffer, p1 = ", conditions[i].p1 )
				local ret = HasOffer( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasOffer = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == LessCredit then
				PRINT( "ConditionsTest:LessCredit, p1 = , p2 = ", conditions[i].p1, conditions[i].p2 )
				local ret = LessCredit( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:LessCredit = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == LessTime then
				PRINT( "ConditionsTest:LessTime, p1 = ", conditions[i].p1 )
				local ret = LessTime( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:LessTime = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == MoreTime then
				PRINT( "ConditionsTest:MoreTime, p1 = ", conditions[i].p1 )
				local ret = MoreTime( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:MoreTime = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == BaiyangOn then
				PRINT( "ConditionsTest:BaiyangOn, p1 = ", conditions[i].p1 )
				local ret = BaiyangOn( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:BaiyangOn = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckEnergy then
				PRINT( "ConditionsTest:CheckEnergy, p1 = ", conditions[i].p1 )
				local ret = CheckEnergy( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckEnergy = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckChaItem then
				PRINT( "ConditionsTest: CheckChaItem, p1 = ")
				local ret = CheckChaItem( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckChaItem = false" )
					return LUA_FALSE
				end			
			elseif conditions[i].func == HasXmasYB then
				PRINT( "ConditionsTest:HasXmasYB,p1, p2", conditions[i].p1, conditions[i].p2 )
				local ret = HasXmasYB( character, conditions[i].p1, conditions[i].p2 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasXmasYB = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == CheckHJ then
				PRINT( "ConditionsTest:CheckHJ, p1 = ", conditions[i].p1 )
				local ret = CheckHJ( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckHJ = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasNOZSExp then
				PRINT( "ConditionsTest:HasNOZSExp, p1 = ", conditions[i].p1 )
				local ret = HasNOZSExp( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasNOZSExp = false" )
					return LUA_FALSE
				end				
			elseif conditions[i].func == HasGuildLevel then
				PRINT( "ConditionsTest:HasGuildLevel, p1 = ", conditions[i].p1 )
				local ret = HasGuildLevel( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasGuildLevel = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == crablife then
				PRINT( "ConditionsTest:crablife, p1 = ", conditions[i].p1 )
				local ret = crablife( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:crablife = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == KitbagLock then
				PRINT( "ConditionsTest:KitbagLock, p1 = ", conditions[i].p1 )
				local ret = KitbagLock( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:KitbagLock = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == ValentinesRing then
				PRINT( "ConditionsTest:ValentinesRing, p1 = ", conditions[i].p1 )
				local ret = ValentinesRing( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:ValentinesRing = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == ValentinesRingJudge then
				PRINT( "ConditionsTest:ValentinesRingJudge, p1 = ", conditions[i].p1 )
				local ret = ValentinesRingJudge( character, conditions[i].p1 )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:ValentinesRingJudge = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Winterland_MisTime then
				PRINT( "ConditionsTest:Winterland_MisTime" )
				local ret = Winterland_MisTime( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Winterland_MisTime = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission1 then
				PRINT( "ConditionsTest:Get_Day_Mission1" )
				local ret = Get_Day_Mission1( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission1 = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission2 then
				PRINT( "ConditionsTest:Get_Day_Mission2" )
				local ret = Get_Day_Mission2( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission2 = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission3 then
				PRINT( "ConditionsTest:Get_Day_Mission3" )
				local ret = Get_Day_Mission3( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission3 = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission4 then
				PRINT( "ConditionsTest:Get_Day_Mission4" )
				local ret = Get_Day_Mission4( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission4 = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission5 then
				PRINT( "ConditionsTest:Get_Day_Mission5" )
				local ret = Get_Day_Mission5( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission5 = false" )
					return LUA_FALSE
				end	
			elseif conditions[i].func == Get_Day_Mission6 then
				PRINT( "ConditionsTest:Get_Day_Mission6" )
				local ret = Get_Day_Mission6( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission6 = false" )
					return LUA_FALSE
				end		
			elseif conditions[i].func == Get_Day_Mission7 then
				PRINT( "ConditionsTest:Get_Day_Mission7" )
				local ret = Get_Day_Mission7( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission7 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_Day_Mission8 then
				PRINT( "ConditionsTest:Get_Day_Mission8" )
				local ret = Get_Day_Mission8( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission8 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_Day_Mission9 then
				PRINT( "ConditionsTest:Get_Day_Mission9" )
				local ret = Get_Day_Mission9( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission9 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_Day_Mission10 then
				PRINT( "ConditionsTest:Get_Day_Mission10" )
				local ret = Get_Day_Mission10( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission10 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_Day_Mission11 then
				PRINT( "ConditionsTest:Get_Day_Mission11" )
				local ret = Get_Day_Mission11( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission11 = false" )
					return LUA_FALSE
				end
			----------------------------------------zhangliang---------------------万圣节真正的危机--------------------
			elseif conditions[i].func == Get_Day_Mission12 then
				PRINT( "ConditionsTest:Get_Day_Mission12" )
				local ret = Get_Day_Mission12( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission12 = false" )
					return LUA_FALSE
				end
			----------------------------------------zhangliang---------------------偷吃鸡的狐狸--------------------
			elseif conditions[i].func == Get_Day_Mission13 then
				PRINT( "ConditionsTest:Get_Day_Mission13" )
				local ret = Get_Day_Mission13( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission13 = false" )
					return LUA_FALSE
				end
			
			----------------------------------------zhangliang---------------------抓捕王小虎--------------------
			elseif conditions[i].func == Get_Day_Mission14 then
				PRINT( "ConditionsTest:Get_Day_Mission14" )
				local ret = Get_Day_Mission14( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_Day_Mission14 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == checkWXHtime then
				PRINT( "conditions: checkWXHtime ")
				local ret = checkWXHtime( character)
				if ret ~= LUA_TRUE then
					PRINT( "conditions:checkWXHtime = false" )
					return LUA_FALSE
				end		
			----------------------------------------zhangliang---------------------抓捕王小虎--------------------				
			elseif conditions[i].func == JL_lv then
				PRINT( "ConditionsTest: JL_lv, p1 = ")
				local ret = JL_lv( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:JL_lv = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == HasDiamondId then
				PRINT( "ConditionsTest:HasDiamondId")
				local ret = HasDiamondId( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasDiamondId = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_ItemAttr_Join1 then
				PRINT( "ConditionsTest:Get_ItemAttr_Join1")
				local ret = Get_ItemAttr_Join1( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_ItemAttr_Join1 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == Get_ItemAttr_Join20 then
				PRINT( "ConditionsTest:Get_ItemAttr_Join20")
				local ret = Get_ItemAttr_Join20( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Get_ItemAttr_Join20 = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == JLTLZM then
				PRINT( "ConditionsTest:JLTLZM")
				local ret = JLTLZM( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:JLTLZM = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == TeamZd then
				PRINT( "ConditionsTest:TeamZd")			
				local ret = TeamZd( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:TeamZd = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == GHPD then
				PRINT( "ConditionsTest:GHPD")			
				local ret = GHPD( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:GHPD = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func == ShuangBei_Time then
				PRINT( "ConditionsTest:ShuangBei_Time, p1 =, p2 = ", conditions[i].p1, conditions[i].p2 ) 
				local ret = ShuangBei_Time( character, conditions[i].p1, conditions[i].p2 ) 
				if ret ~= LUA_TRUE then 
					PRINT( "ConditionsTest: ShuangBei_Time = false" )
						return LUA_FALSE
				end
			elseif conditions[i].func == Judge_Mission_Times then
				PRINT( "ConditionsTest:Judge_Mission_Times")			
				local ret = Judge_Mission_Times( character)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Judge_Mission_Times = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==InXZJT then
				PRINT( "ConditionsTest: InXZJT")
				local ret = InXZJT( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:InXZJT = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==IsGiveXZItem then
				PRINT( "ConditionsTest: IsGiveXZItem")
				local ret = IsGiveXZItem( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:IsGiveXZItem = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasYiZuHua then
				PRINT( "ConditionsTest: HasYiZuHua")
				local ret = HasYiZuHua( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:HasYiZuHua = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==Ismm then
				PRINT( "ConditionsTest: Ismm")
				local ret = Ismm( character )
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Ismm = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==XingZuoKaHuoDong then
				PRINT( "ConditionsTest: XingZuoKaHuoDong")
				local ret = XingZuoKaHuoDong(character, conditions[i].p1, conditions[i].p2 ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:XingZuoKaHuoDong = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==NSDXIsFull then
				PRINT( "ConditionsTest: NSDXIsFull")
				local ret = NSDXIsFull(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:NSDXIsFull = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==goto_mj1_time then
				PRINT( "ConditionsTest: goto_mj1_time")
				local ret = goto_mj1_time(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:goto_mj1_time = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==goto_mj2_time then
				PRINT( "ConditionsTest: goto_mj2_time")
				local ret = goto_mj2_time(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:goto_mj2_time = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckZsExp then
				PRINT( "ConditionsTest: CheckZsExp")
				local ret = CheckZsExp(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckZsExp = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==buling then
				PRINT( "ConditionsTest: buling")
				local ret = buling(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:buling = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanbulingSB then
				PRINT( "ConditionsTest: CanbulingSB")
				local ret = CanbulingSB(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CanbulingSB = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanbulingBL then
				PRINT( "ConditionsTest: CanbulingBL")
				local ret = CanbulingBL(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CanbulingBL = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==Check_KSS then
				PRINT( "ConditionsTest: Check_KSS")
				local ret = Check_KSS(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Check_KSS = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanChargeQiByOne then
				PRINT( "ConditionsTest: CanChargeQiByOne")
				local ret = CanChargeQiByOne(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CanChargeQiByOne = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanChargeQiByAll then
				local ret = CanChargeQiByAll(character ) 
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanZhanBubyRole then
				local ret = CanZhanBubyRole(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanZhanBu then
				local ret = CanZhanBu(character,conditions[i].p1 ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func == XZKcheck then
				local ret = XZKcheck( character )
				if ret ~= LUA_TRUE then
				return LUA_FALSE
				end
			elseif conditions[i].func == JZcheck1 then
				local ret = JZcheck1( character )
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end	
			elseif conditions[i].func == JZcheck2 then
				local ret = JZcheck2( character )
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end		
			elseif conditions[i].func == JZcheck3 then
				local ret = JZcheck3( character )
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end		
			elseif conditions[i].func == JZcheck4 then
				local ret = JZcheck4( character )
				if ret ~= LUA_TRUE then
					return LUA_FALSE
				end			
			elseif conditions[i].func == Jiu_Check then
				local ret = Jiu_Check( character )
				if ret ~= LUA_TRUE then
				return LUA_FALSE
			end					
			elseif conditions[i].func ==Check_KSS then
				PRINT( "ConditionsTest: Check_KSS")
				local ret = Check_KSS(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:Check_KSS = false" )
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanZhanBubyRole then
				local ret = CanZhanBubyRole(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanZhanBu then
				local ret = CanZhanBu(character,conditions[i].p1 ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckJobIsNew then
				local ret = CheckJobIsNew(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end	
			elseif conditions[i].func ==CheckSHSkill then
				local ret = CheckSHSkill(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end	
			elseif conditions[i].func ==CheckAttrRole then
				local ret = CheckAttrRole(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end	
			elseif conditions[i].func ==CheckFirstSkill then
				local ret = CheckFirstSkill(character ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckChaTypeID then
				local ret = CheckChaTypeID(character, conditions[i].p1) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasItemShouTao then
				local ret = HasItemShouTao(character, conditions[i].p1) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasBagJieZhi then
				local ret = HasBagJieZhi(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end	
			elseif conditions[i].func ==CheckZXBYPoint then
				local ret = CheckZXBYPoint(character,conditions[i].p1,conditions[i].p2) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckXXBYPoint then
				local ret = CheckXXBYPoint(character,conditions[i].p1,conditions[i].p2) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==PfEqual1 then
				local ret = PfEqual1(character,conditions[i].p1) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckRoleLearnedForge then
				local ret = CheckRoleLearnedForge(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasCleckLevel then
				local ret = HasCleckLevel(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasCleckSupply then
				local ret = HasCleckSupply(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckRecordRand then
				local ret = CheckRecordRand(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBaoShiLV then
				local ret = CheckBaoShiLV(character,conditions[i].p1) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBankItemOrLv then
				local ret = CheckBankItemOrLv(character,conditions[i].p1,conditions[i].p2) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckKZRH then
				local ret = CheckKZRH(character,conditions[i].p1) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanBuyZTL then
				local ret = CanBuyZTL(character,npc) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanZTLCharge then
				local ret = CanZTLCharge(character,npc) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckCZCL then
				local ret = CheckCZCL(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBoatSkill then
				local ret = CheckBoatSkill(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose1 then
				local ret = Box_choose1(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBagJL then
				local ret = CheckBagJL(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==JL_lv3 then
				local ret = JL_lv3(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose2 then
				local ret = Box_choose2(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckBaoShiLV2 then
				local ret = CheckBaoShiLV2(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasCleckFusion then
				local ret = HasCleckFusion(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==HasCleckUnite then
				local ret = HasCleckUnite(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CheckEquipPurify then
				local ret = CheckEquipPurify(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end			
			elseif conditions[i].func ==CheckNoNewJob then
				local ret = CheckNoNewJob(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose3 then
				local ret = Box_choose3(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose4 then
				local ret = Box_choose4(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose5 then
				local ret = Box_choose5(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose6 then
				local ret = Box_choose6(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==Box_choose7 then
				local ret = Box_choose7(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanChargeTZXZ then
				local ret = CanChargeTZXZ(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==CanChargeAllTZXZ then
				local ret = CanChargeAllTZXZ(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==BBXLcheck then
				local ret = BBXLcheck(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end	
			elseif conditions[i].func == CheckBookTo then
				PRINT( "ConditionsTest: CheckBookTo, p1 = ", conditions[i].p1)
				local ret = CheckBookTo( character, conditions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:CheckBookTo = false" )
					return LUA_FALSE
				end					
			elseif conditions[i].func == IsGiveXZNewItem then
				local ret = IsGiveXZNewItem(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func == CanEnterXLZD then
				local ret = CanEnterXLZD(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func == CanSpEnterXLZD then
				local ret = CanSpEnterXLZD(character) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			elseif conditions[i].func ==SQMooncake_Count_Minus then
				local ret = SQMooncake_Count_Minus(character,conditions[i].p1 ) 
				if ret ~= LUA_TRUE then	
					return LUA_FALSE
				end
			else
				MISSDK_MISSIONSDK_LUA_000192 = GetResString("MISSDK_MISSIONSDK_LUA_000192")
				PRINT( MISSDK_MISSIONSDK_LUA_000192, i )
				MISSDK_MISSIONSDK_LUA_000193 = GetResString("MISSDK_MISSIONSDK_LUA_000193")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000193 )
				return LUA_ERROR
			end
		end
	end
	
	PRINT( "ConditionsTest: return true" )
	return LUA_TRUE
end

--任务动作处理函数
function ActionsProc( character, actions, npc, page, misid, scriptid, param1, param2 )
	PRINT( "ActionProc: actions proc" )
	if actions == nil then
		MISSDK_MISSIONSDK_LUA_000194 = GetResString("MISSDK_MISSIONSDK_LUA_000194")
		PRINT( MISSDK_MISSIONSDK_LUA_000194 )
		MISSDK_MISSIONSDK_LUA_000194 = GetResString("MISSDK_MISSIONSDK_LUA_000194")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000194 )
		return LUA_ERROR
	end
	CurNpc=npc
	--触发器符合条件动作
	local num = TR_MAXNUM_ACTIONS
	if actions.count ~= nil then
		num = actions.count
	end
	PRINT( "ActionsProc:Actions num = ", num )
	for i = 1, num, 1 do
		PRINT( "ActionProc23: actions i = ", i, actions[i] )
		if actions[i] == nil then
			PRINT( "ActionProc23: break" )
			break
		end
		PRINT( "ActionProc: actions i = ", i )
		if actions[i].func == JumpPage then
			PRINT( "ActionProc:JumpPage, page =, p1 = ", page, actions[i].p1 )
			JumpPage( character, npc, page, actions[i].p1 )
		elseif actions[i].func == CloseTalk then
			PRINT( "ActionProc:CloseTalk" )
			CloseTalk( character, npc )
		----------------------------------------------------------------------------圣诞活动添加注册	
	   elseif actions[i].func == jsq then
			local ret = jsq(character )
			if ret ~= LUA_TRUE then
				--SystemNotice( character, "ActionsProc:EnterXLZD 失败！" )
				return LUA_FALSE
			end
			
		elseif actions[i].func == wcjsq then
			local ret = wcjsq(character )
			if ret ~= LUA_TRUE then
				--SystemNotice( character, "ActionsProc:EnterXLZD 失败！" )
				return LUA_FALSE
			end
			---------------------------------------------------------------------------------------------
		elseif actions[i].func == AddMission then
			PRINT( "ActionProc: AddMission actions[i].p1 = , scriptid = ", actions[i].p1, scriptid )
			local ret = AddMission( character, actions[i].p1, scriptid )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000195 = GetResString("MISSDK_MISSIONSDK_LUA_000195")
				PRINT( MISSDK_MISSIONSDK_LUA_000195 )
				MISSDK_MISSIONSDK_LUA_000196 = GetResString("MISSDK_MISSIONSDK_LUA_000196")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000196 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddTrigger then
			PRINT( "ActionProc: AddTrigger, misid, p1 = , p2 = , p3 = , p4 = , p5 = , p6 = , p7 = , p8 = ", misid, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5, actions[i].p6, actions[i].p7, actions[i].p8 )
			local ret = AddTrigger( character, misid, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5, actions[i].p6, actions[i].p7, actions[i].p8 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000197 = GetResString("MISSDK_MISSIONSDK_LUA_000197")
				PRINT( MISSDK_MISSIONSDK_LUA_000197 )
				MISSDK_MISSIONSDK_LUA_000198 = GetResString("MISSDK_MISSIONSDK_LUA_000198")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000198 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddNpcTrigger then
			PRINT( "ActionProc: AddNpcTrigger, p1 = , p2 = , p3 = , p4 = , p5 = , p6 = ", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5, actions[i].p6 )
			local ret = AddNpcTrigger( character, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5, actions[i].p6 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000199 = GetResString("MISSDK_MISSIONSDK_LUA_000199")
				PRINT( MISSDK_MISSIONSDK_LUA_000199 )
				MISSDK_MISSIONSDK_LUA_000200 = GetResString("MISSDK_MISSIONSDK_LUA_000200")
				LG( "trigger_error", MISSDK_MISSIONSDK_LUA_000200..GetCharName( character ) )
				return LUA_FALSE
			end
		elseif actions[i].func == AddNextFlag then
			PRINT( "ActionProc:AddNextFlag, p1, p2, p3", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = AddNextFlag( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000201 = GetResString("MISSDK_MISSIONSDK_LUA_000201")
				PRINT( MISSDK_MISSIONSDK_LUA_000201 )
				MISSDK_MISSIONSDK_LUA_000202 = GetResString("MISSDK_MISSIONSDK_LUA_000202")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000202 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddRMNextFlag then
			PRINT( "ActionProc:AddRMNextFlag, p1, p2, p3", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = AddRMNextFlag( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000203 = GetResString("MISSDK_MISSIONSDK_LUA_000203")
				PRINT( MISSDK_MISSIONSDK_LUA_000203 )
				MISSDK_MISSIONSDK_LUA_000204 = GetResString("MISSDK_MISSIONSDK_LUA_000204")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000204 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetFlag then
			PRINT( "ActionProc:SetFlag, p1, p2 ", actions[i].p1, actions[i].p2 )
			local ret = SetFlag( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000205 = GetResString("MISSDK_MISSIONSDK_LUA_000205")
				PRINT( MISSDK_MISSIONSDK_LUA_000205 )
				MISSDK_MISSIONSDK_LUA_000206 = GetResString("MISSDK_MISSIONSDK_LUA_000206")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000206 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetRecord then
			PRINT( "ActionProc:SetRecord, p1 = ", actions[i].p1 )
			local ret = SetRecord( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000207 = GetResString("MISSDK_MISSIONSDK_LUA_000207")
				PRINT( MISSDK_MISSIONSDK_LUA_000207 )
				MISSDK_MISSIONSDK_LUA_000208 = GetResString("MISSDK_MISSIONSDK_LUA_000208")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000208 )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveNSDX then
			PRINT( "ActionProc: GiveNSDX, p1 = ", actions[i].p1)
			local ret = GiveNSDX( character,npc, actions[i].p1)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:GiveNSDX = false" )
				return LUA_FALSE
			end
		elseif actions[i].func == JINNiuSS then
			PRINT( "ActionProc:JINNiuSS, p1 = " )
			local ret = JINNiuSS( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000209 = GetResString("MISSDK_MISSIONSDK_LUA_000209")
				PRINT( MISSDK_MISSIONSDK_LUA_000209 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == JINNiuHD then
			PRINT( "ActionProc:JINNiuHD, p1 = " )
			local ret = JINNiuHD( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000210 = GetResString("MISSDK_MISSIONSDK_LUA_000210")
				PRINT( MISSDK_MISSIONSDK_LUA_000210 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == JINNiuCZ then
			PRINT( "ActionProc:JINNiuCZ, p1 = " )
			local ret = JINNiuCZ( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000211 = GetResString("MISSDK_MISSIONSDK_LUA_000211")
				PRINT( MISSDK_MISSIONSDK_LUA_000211 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end

		elseif actions[i].func == ShuangZiSS then
			PRINT( "ActionProc:ShuangZiSS, p1 = " )
			local ret = ShuangZiSS( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000212 = GetResString("MISSDK_MISSIONSDK_LUA_000212")
				PRINT( MISSDK_MISSIONSDK_LUA_000212 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == ShuangZiHD then
			PRINT( "ActionProc:ShuangZiHD, p1 = " )
			local ret = ShuangZiHD( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000213 = GetResString("MISSDK_MISSIONSDK_LUA_000213")
				PRINT( MISSDK_MISSIONSDK_LUA_000213 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == ShuangZiCZ then
			PRINT( "ActionProc:ShuangZiCZ, p1 = " )
			local ret = ShuangZiCZ( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000214 = GetResString("MISSDK_MISSIONSDK_LUA_000214")
				PRINT( MISSDK_MISSIONSDK_LUA_000214 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == AddReadingBook then
			PRINT( "ActionProc:AddReadingBook, p1 = ", actions[i].p1 )
			local ret = AddReadingBook( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000215 = GetResString("MISSDK_MISSIONSDK_LUA_000215")
				PRINT( MISSDK_MISSIONSDK_LUA_000215 )
				MISSDK_MISSIONSDK_LUA_000216 = GetResString("MISSDK_MISSIONSDK_LUA_000216")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000216 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddExpPer then
			PRINT( "ActionProc:AddExpPer, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AddExpPer( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000217 = GetResString("MISSDK_MISSIONSDK_LUA_000217")
				PRINT( MISSDK_MISSIONSDK_LUA_000217 )
				MISSDK_MISSIONSDK_LUA_000218 = GetResString("MISSDK_MISSIONSDK_LUA_000218")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000218 )
				return LUA_FALSE
			end
		elseif actions[i].func == ZSSTART then
			PRINT( "ActionProc:ZSSTART, p1 = " )
			local ret = ZSSTART( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000219 = GetResString("MISSDK_MISSIONSDK_LUA_000219")
				PRINT( MISSDK_MISSIONSDK_LUA_000219 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end

		elseif actions[i].func == AddChaHJ then
			PRINT( "ActionProc: AddChaHJ, p1 = ", actions[i].p1)
			local ret = AddChaHJ( character,npc, actions[i].p1)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddChaHJ = false" )
				return LUA_FALSE
			end

		elseif actions[i].func == AddExpNextLv1 then
			PRINT( "ActionProc:AddExpNextLv1, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AddExpNextLv1( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000220 = GetResString("MISSDK_MISSIONSDK_LUA_000220")
				PRINT( MISSDK_MISSIONSDK_LUA_000220 )
				MISSDK_MISSIONSDK_LUA_000221 = GetResString("MISSDK_MISSIONSDK_LUA_000221")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000221 )
				return LUA_FALSE
			end

		elseif actions[i].func == AddExpNextLv2 then
			PRINT( "ActionProc:AddExpNextLv2, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AddExpNextLv2( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000222 = GetResString("MISSDK_MISSIONSDK_LUA_000222")
				PRINT( MISSDK_MISSIONSDK_LUA_000222 )
				MISSDK_MISSIONSDK_LUA_000223 = GetResString("MISSDK_MISSIONSDK_LUA_000223")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000223 )
				return LUA_FALSE
			end
		elseif actions[i].func == ZSSTOP then
			PRINT( "ActionProc:ZSSTOP, p1 = " )
			local ret = ZSSTOP( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000224 = GetResString("MISSDK_MISSIONSDK_LUA_000224")
				PRINT( MISSDK_MISSIONSDK_LUA_000224 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == ZSSTOP2 then
			PRINT( "ActionProc:ZSSTOP2, p1 = " )
			local ret = ZSSTOP2( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000225 = GetResString("MISSDK_MISSIONSDK_LUA_000225")
				PRINT( MISSDK_MISSIONSDK_LUA_000225 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == AddExp then
			PRINT( "ActionProc:AddExp, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local retExpState = GetExpState(character)
--			Notice("做任务奖励经验的防沉迷返还系数为"..retExpState)
			
			actions[i].p1 = actions[i].p1  *GetExpState(character) /100
			actions[i].p2 = actions[i].p2  *GetExpState(character) /100
			local ret = AddExp( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000226 = GetResString("MISSDK_MISSIONSDK_LUA_000226")
				PRINT( MISSDK_MISSIONSDK_LUA_000226 )
				MISSDK_MISSIONSDK_LUA_000227 = GetResString("MISSDK_MISSIONSDK_LUA_000227")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000227 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddSailExp then
			PRINT( "ActionProc:AddSailExp, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AddSailExp( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000228 = GetResString("MISSDK_MISSIONSDK_LUA_000228")
				PRINT( MISSDK_MISSIONSDK_LUA_000228 )
				MISSDK_MISSIONSDK_LUA_000229 = GetResString("MISSDK_MISSIONSDK_LUA_000229")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000229 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddLifeExp then
			PRINT( "ActionProc:AddLifeExp, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AddLifeExp( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000230 = GetResString("MISSDK_MISSIONSDK_LUA_000230")
				PRINT( MISSDK_MISSIONSDK_LUA_000230 )
				MISSDK_MISSIONSDK_LUA_000231 = GetResString("MISSDK_MISSIONSDK_LUA_000231")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000231 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddChaItem7 then
			PRINT( "ActionsProc:AddChaItem7, p1 = ", actions[i].p1 )
			local ret = AddChaItem7( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000232 = GetResString("MISSDK_MISSIONSDK_LUA_000232")
				PRINT( MISSDK_MISSIONSDK_LUA_000232 )
				MISSDK_MISSIONSDK_LUA_000232 = GetResString("MISSDK_MISSIONSDK_LUA_000232")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000232 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddChaItem8 then
			PRINT( "ActionsProc:AddChaItem8, p1 = ", actions[i].p1 )
			local ret = AddChaItem8( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000233 = GetResString("MISSDK_MISSIONSDK_LUA_000233")
				PRINT( MISSDK_MISSIONSDK_LUA_000233 )
				MISSDK_MISSIONSDK_LUA_000233 = GetResString("MISSDK_MISSIONSDK_LUA_000233")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000233 )
				return LUA_FALSE
			end
		elseif actions[i].func == checkcytime then
			PRINT( "ActionsProc:checkcytime, p1 = ", actions[i].p1 )
			local ret = checkcytime( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000234 = GetResString("MISSDK_MISSIONSDK_LUA_000234")
				PRINT( MISSDK_MISSIONSDK_LUA_000234 )
				MISSDK_MISSIONSDK_LUA_000234 = GetResString("MISSDK_MISSIONSDK_LUA_000234")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000234 )
				return LUA_FALSE
			end
		elseif actions[i].func == checksjtime then
			PRINT( "ActionsProc:checksjtime, p1 = ", actions[i].p1 )
			local ret = checksjtime( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000235 = GetResString("MISSDK_MISSIONSDK_LUA_000235")
				PRINT( MISSDK_MISSIONSDK_LUA_000235 )
				MISSDK_MISSIONSDK_LUA_000235 = GetResString("MISSDK_MISSIONSDK_LUA_000235")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000235 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddExpAndType then
			PRINT( "ActionProc:AddExpAndType, p1 = , p2 = , p3 = ", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = AddExpAndType( character, npc, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000236 = GetResString("MISSDK_MISSIONSDK_LUA_000236")
				PRINT( MISSDK_MISSIONSDK_LUA_000236 )
				MISSDK_MISSIONSDK_LUA_000237 = GetResString("MISSDK_MISSIONSDK_LUA_000237")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000237 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddMoney then
			PRINT( "ActionProc:AddMoney, p1 =", actions[i].p1 )
			local ret = AddMoney( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000238 = GetResString("MISSDK_MISSIONSDK_LUA_000238")
				PRINT( MISSDK_MISSIONSDK_LUA_000238, actions[i].p1 )
				MISSDK_MISSIONSDK_LUA_000239 = GetResString("MISSDK_MISSIONSDK_LUA_000239")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000239 )
				return LUA_FALSE
			end
		elseif actions[i].func == Addsafe_exp then
			PRINT( "ActionProc:AddMoney, p1 =", actions[i].p1 )
			local ret = Addsafe_exp( character, actions[i].p1,actions[i].p2,actions[i].p3 )
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc: Addsafe_exp failed！param1 = %d", actions[i].p1 )
				SystemNotice( character, "ActionProc: Addsafe_exp failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeCredit then
				PRINT( "ActionProc: TakeCredit, p1 = ", actions[i].p1)
				local ret = DelRoleCredit( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:TakeCredit = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == TakeFightingPoint then
				PRINT( "ActionProc: TakeFightingPoint, p1 = ", actions[i].p1)
				local ret = TakeFightingPoint( character,actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:DelRoleFightingPoint = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == Leaveprison then
				PRINT( "ActionProc: Leaveprison, p1 = ", actions[i].p1)
				local ret = Leaveprison( character, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:Leaveprison = false" )
					return LUA_FALSE
				end	
		elseif actions[i].func == Givejiluka then
				PRINT( "ActionProc: Givejiluka, p1 = ", actions[i].p1)
				local ret = Givejiluka( character, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:Givejiluka = false" )
					return LUA_FALSE
				end

		elseif actions[i].func == TakeHonorPoint then
				PRINT( "ActionProc: TakeHonorPoint, p1 = ", actions[i].p1)
				local ret = TakeHonorPoint( character, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:TakeHonorPoint = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == Starteffect then
				PRINT( "ActionProc: Starteffect, p1 = ", actions[i].p1)
				local ret = Starteffect( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:Starteffect = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == AddChaItem1 then
				PRINT( "ActionProc: AddChaItem1, p1 = ", actions[i].p1)
				local ret = AddChaItem1( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:AddChaItem1 = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == AddChaItem2 then
				PRINT( "ActionProc: AddChaItem2, p1 = ", actions[i].p1)
				local ret = AddChaItem2( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:AddChaItem2 = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == AddChaItem3 then
				PRINT( "ActionProc: AddChaItem1, p1 = ", actions[i].p1)
				local ret = AddChaItem3( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:AddChaItem1 = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == AddChaItem5 then
				PRINT( "ActionProc: AddChaItem2, p1 = ", actions[i].p1)
				local ret = AddChaItem5( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:AddChaItem2 = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == AddChaItem4 then
				PRINT( "ActionProc: AddChaItem2, p1 = ", actions[i].p1)
				local ret = AddChaItem4( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:AddChaItem2 = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == DelRoleCredit then
				PRINT( "ActionProc: DelRoleCredit, p1 = ", actions[i].p1)
				local ret = DelRoleCredit( character,npc, actions[i].p1)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:DelRoleCredit = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == TakeMoney then
			PRINT( "ActionProc:TakeMoney, p1 = ", actions[i].p1 )
			local ret = TakeMoney( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000240 = GetResString("MISSDK_MISSIONSDK_LUA_000240")
				PRINT( MISSDK_MISSIONSDK_LUA_000240, actions[i].p1 )
				MISSDK_MISSIONSDK_LUA_000241 = GetResString("MISSDK_MISSIONSDK_LUA_000241")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000241 )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeCancelMissionMoney then
			-- PRINT( "ActionProc:TakeMoney" )
			-- local ret = TakeCancelMissionMoney( character, npc )
			-- if ret ~= LUA_TRUE then
				-- PRINT( "ActionProc: TakeCancelMissionMoney 失败！param1 = %d", actions[i].p1 )
				-- SystemNotice( character, "ActionProc: TakeCancelMissionMoney 失败！" )
				-- return LUA_FALSE
			-- end
		elseif actions[i].func == GiveItem then
			PRINT( "ActionProc:GiveItem, p1 = , p2 = , p3 = ", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = GiveItem( character, npc, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000242 = GetResString("MISSDK_MISSIONSDK_LUA_000242")
				PRINT( MISSDK_MISSIONSDK_LUA_000242 )
				MISSDK_MISSIONSDK_LUA_000243 = GetResString("MISSDK_MISSIONSDK_LUA_000243")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000243 )
				return LUA_FALSE
			end		
		elseif actions[i].func == TakeItem then
			PRINT( "ActionProc:TakeItem, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = TakeItem( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000244 = GetResString("MISSDK_MISSIONSDK_LUA_000244")
				PRINT( MISSDK_MISSIONSDK_LUA_000244 )
				MISSDK_MISSIONSDK_LUA_000245 = GetResString("MISSDK_MISSIONSDK_LUA_000245")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000245 )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveXinZhuangBei then
			PRINT( "ActionProc:TakeItem, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = GiveXinZhuangBei( character, actions[i].p1)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc: GiveXinZhuangBei failed！" )
				SystemNotice( character, "ActionProc: GiveXinZhuangBei failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeRandNpcItem then
			PRINT( "ActionProc:TakeRandNpcItem, p1 = , p2 = , p3 = ", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = TakeRandNpcItem( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000246 = GetResString("MISSDK_MISSIONSDK_LUA_000246")
				PRINT( MISSDK_MISSIONSDK_LUA_000246 )
				MISSDK_MISSIONSDK_LUA_000247 = GetResString("MISSDK_MISSIONSDK_LUA_000247")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000247 )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeAllRandItem then
			PRINT( "ActionProc:TakeAllRandItem, p1 = ", actions[i].p1 )
			local ret = TakeAllRandItem( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000248 = GetResString("MISSDK_MISSIONSDK_LUA_000248")
				PRINT( MISSDK_MISSIONSDK_LUA_000248 )
				MISSDK_MISSIONSDK_LUA_000249 = GetResString("MISSDK_MISSIONSDK_LUA_000249")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000249 )
				return LUA_FALSE
			end			
		elseif actions[i].func == ClearMission then
			PRINT( "ActionProc:ClearMission, p1 = ", actions[i].p1 )
			local ret = ClearMission( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000250 = GetResString("MISSDK_MISSIONSDK_LUA_000250")
				PRINT( MISSDK_MISSIONSDK_LUA_000250 )
				MISSDK_MISSIONSDK_LUA_000251 = GetResString("MISSDK_MISSIONSDK_LUA_000251")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000251 )
				return LUA_FALSE
			end
		elseif actions[i].func == ClearTrigger then
			PRINT( "ActionProc:ClearTrigger, p1 = ", actions[i].p1 )
			local ret = ClearTrigger( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000252 = GetResString("MISSDK_MISSIONSDK_LUA_000252")
				PRINT( MISSDK_MISSIONSDK_LUA_000252 )
				MISSDK_MISSIONSDK_LUA_000253 = GetResString("MISSDK_MISSIONSDK_LUA_000253")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000253 )
				return LUA_FALSE
			end
		elseif actions[i].func == DeleteTrigger then
			PRINT( "ActionProc:DeleteTrigger, p1 = ", actions[i].p1 )
			local ret = DeleteTrigger( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000254 = GetResString("MISSDK_MISSIONSDK_LUA_000254")
				PRINT( MISSDK_MISSIONSDK_LUA_000254 )
				MISSDK_MISSIONSDK_LUA_000255 = GetResString("MISSDK_MISSIONSDK_LUA_000255")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000255 )
				return LUA_FALSE
			end
		elseif actions[i].func == ClearFlag then
			PRINT( "ActionProc:ClearFlag, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = ClearFlag( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000256 = GetResString("MISSDK_MISSIONSDK_LUA_000256")
				PRINT( MISSDK_MISSIONSDK_LUA_000256 )
				MISSDK_MISSIONSDK_LUA_000257 = GetResString("MISSDK_MISSIONSDK_LUA_000257")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000257 )
				return LUA_FALSE
			end
		elseif actions[i].func == ClearRecord then
			PRINT( "ActionProc:ClearRecord, p1 = ", actions[i].p1 )
			local ret = ClearRecord( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000258 = GetResString("MISSDK_MISSIONSDK_LUA_000258")
				PRINT( MISSDK_MISSIONSDK_LUA_000258 )
				MISSDK_MISSIONSDK_LUA_000259 = GetResString("MISSDK_MISSIONSDK_LUA_000259")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000259 )
				return LUA_FALSE
			end
		elseif actions[i].func == RefreshCompleteFlag then
			PRINT( "ActionProc:RefreshCompleteFlag, p1 = ", actions[i].p1 )
			local ret = RefreshCompleteFlag( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000260 = GetResString("MISSDK_MISSIONSDK_LUA_000260")
				PRINT( MISSDK_MISSIONSDK_LUA_000260 )
				MISSDK_MISSIONSDK_LUA_000261 = GetResString("MISSDK_MISSIONSDK_LUA_000261")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000261 )
				return LUA_FALSE
			end
		elseif actions[i].func == ReAll then
			PRINT( "ActionProc:ReAll" )
			ReAll( character )
		elseif actions[i].func == ReAllHp then
			PRINT( "ActionProc:ReAllHp" )
			ReAllHp( character )
		elseif actions[i].func == ReAllSp then
			PRINT( "ActionProc:ReAllSp" )
			ReAllSp( character )
		elseif actions[i].func == ReHp then
			PRINT( "ActionProc:ReHp, p1 = ", actions[i].p1 )
			ReHp( character, actions[i].p1 )
		elseif actions[i].func == ReSp then
			PRINT( "ActionProc:ReSp, p1 = ", actions[i].p1 )
			ReSp( character, actions[i].p1 )
		elseif actions[i].func == SystemNotice then
			PRINT( "ActionProc:SystemNotice, p1 = ", actions[i].p1 )
			SystemNotice( character, actions[i].p1 )
		elseif actions[i].func == BickerNotice then
			PRINT( "ActionProc:BickerNotice, p1 = ", actions[i].p1 )
			BickerNotice( character, actions[i].p1 )			
		elseif actions[i].func == HelpInfo then
			PRINT( "ActionProc:HelpInfo, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			HelpInfo( character, actions[i].p1, actions[i].p2 )
		elseif actions[i].func == Show then
			PRINT( "ActionProc:Show" )
			Show( character )
		elseif actions[i].func == Hide then
			PRINT( "ActionProc:Hide" )
			Hide( character )
		elseif actions[i].func == UpdateGoodsData then
			PRINT( "ActionProc:UpdateGoodsData" )
			UpdateGoodsData( character )
		elseif actions[i].func == UpdateGoodsKinds then
			PRINT( "ActionProc:UpdateGoodsKinds" )
			UpdateGoodsKinds( character )
		elseif actions[i].func == GiveMission then
			PRINT( "ActionsProc:GiveMission, p1 = ", actions[i].p1 )
			local ret = GiveMission( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000262 = GetResString("MISSDK_MISSIONSDK_LUA_000262")
				PRINT( MISSDK_MISSIONSDK_LUA_000262 )
				MISSDK_MISSIONSDK_LUA_000263 = GetResString("MISSDK_MISSIONSDK_LUA_000263")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000263 )
				return LUA_FALSE
			end
		elseif actions[i].func == ObligeAcceptMission then
			PRINT( "ActionsProc:ObligeAcceptMission, p1 = ", actions[i].p1 )
			local ret = ObligeAcceptMission( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000264 = GetResString("MISSDK_MISSIONSDK_LUA_000264")
				PRINT( MISSDK_MISSIONSDK_LUA_000264 )
				MISSDK_MISSIONSDK_LUA_000265 = GetResString("MISSDK_MISSIONSDK_LUA_000265")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000265 )
				return LUA_FALSE
			end
		elseif actions[i].func == ObligeCompleteMission then
			PRINT( "ActionsProc:ObligeCompleteMission, p1 = ", actions[i].p1 )
			local ret = ObligeCompleteMission( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000266 = GetResString("MISSDK_MISSIONSDK_LUA_000266")
				PRINT( MISSDK_MISSIONSDK_LUA_000266 )
				MISSDK_MISSIONSDK_LUA_000267 = GetResString("MISSDK_MISSIONSDK_LUA_000267")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000267 )
				return LUA_FALSE
			end
		elseif actions[i].func == SummonNpc then
			PRINT( "ActionsProc:SummonNpc, p1, p2, p3, p4", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			local ret = SummonNpc( actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000268 = GetResString("MISSDK_MISSIONSDK_LUA_000268")
				PRINT( MISSDK_MISSIONSDK_LUA_000268 )
				MISSDK_MISSIONSDK_LUA_000268 = GetResString("MISSDK_MISSIONSDK_LUA_000268")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000268 )
				return LUA_FALSE
			end
		elseif actions[i].func == ConvoyNpc then
			PRINT( "ActionsProc:ConvoyNpc, p1, p2, p3, p4", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			local ret = ConvoyNpc( character, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000269 = GetResString("MISSDK_MISSIONSDK_LUA_000269")
				PRINT( MISSDK_MISSIONSDK_LUA_000269 )
				MISSDK_MISSIONSDK_LUA_000269 = GetResString("MISSDK_MISSIONSDK_LUA_000269")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000269 )
				return LUA_FALSE
			end
		elseif actions[i].func == ClearConvoyNpc then
			PRINT( "ActionsProc:ClearConvoyNpc, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = ClearConvoyNpc( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000270 = GetResString("MISSDK_MISSIONSDK_LUA_000270")
				PRINT( MISSDK_MISSIONSDK_LUA_000270 )
				MISSDK_MISSIONSDK_LUA_000270 = GetResString("MISSDK_MISSIONSDK_LUA_000270")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000270 )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeXmasYB then
			PRINT( "ActionProc:TakeXmasYB, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = TakeXmasYB( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000271 = GetResString("MISSDK_MISSIONSDK_LUA_000271")
				PRINT( MISSDK_MISSIONSDK_LUA_000271 )
				MISSDK_MISSIONSDK_LUA_000272 = GetResString("MISSDK_MISSIONSDK_LUA_000272")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000272 )
				return LUA_FALSE
			end
		elseif actions[i].func == CpHuojiNum then
			PRINT( "ActionsProc:CpHuojiNum, p1 = ", actions[i].p1 )
			local ret = CpHuojiNum( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000273 = GetResString("MISSDK_MISSIONSDK_LUA_000273")
				PRINT( MISSDK_MISSIONSDK_LUA_000273 )
				MISSDK_MISSIONSDK_LUA_000273 = GetResString("MISSDK_MISSIONSDK_LUA_000273")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000273 )
				return LUA_FALSE
			end
		elseif actions[i].func == CpMiluNum then
			PRINT( "ActionsProc:CpMiluNum, p1 = ", actions[i].p1 )
			local ret = CpMiluNum( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000274 = GetResString("MISSDK_MISSIONSDK_LUA_000274")
				PRINT( MISSDK_MISSIONSDK_LUA_000274 )
				MISSDK_MISSIONSDK_LUA_000274 = GetResString("MISSDK_MISSIONSDK_LUA_000274")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000274 )
				return LUA_FALSE
			end
		elseif actions[i].func == CpXuerenNum then
			PRINT( "ActionsProc:CpXuerenNum, p1 = ", actions[i].p1 )
			local ret = CpXuerenNum( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000275 = GetResString("MISSDK_MISSIONSDK_LUA_000275")
				PRINT( MISSDK_MISSIONSDK_LUA_000275 )
				MISSDK_MISSIONSDK_LUA_000275 = GetResString("MISSDK_MISSIONSDK_LUA_000275")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000275 )
				return LUA_FALSE
			end
		elseif actions[i].func == ClearAllConvoyNpc then
			PRINT( "ActionsProc:ClearAllConvoyNpc, p1 = ", actions[i].p1 )
			local ret = ClearAllConvoyNpc( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000276 = GetResString("MISSDK_MISSIONSDK_LUA_000276")
				PRINT( MISSDK_MISSIONSDK_LUA_000276 )
				MISSDK_MISSIONSDK_LUA_000276 = GetResString("MISSDK_MISSIONSDK_LUA_000276")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000276 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetMissionFailure then
			PRINT( "ActionsProc:SetMissionFailure, p1 = ", actions[i].p1 )
			local ret = SetMissionFailure( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000277 = GetResString("MISSDK_MISSIONSDK_LUA_000277")
				PRINT( MISSDK_MISSIONSDK_LUA_000277 )
				MISSDK_MISSIONSDK_LUA_000277 = GetResString("MISSDK_MISSIONSDK_LUA_000277")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000277 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetMissionComplete then
			PRINT( "ActionsProc:SetMissionComplete, p1 = ", actions[i].p1 )
			local ret = SetMissionComplete( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000278 = GetResString("MISSDK_MISSIONSDK_LUA_000278")
				PRINT( MISSDK_MISSIONSDK_LUA_000278 )
				MISSDK_MISSIONSDK_LUA_000278 = GetResString("MISSDK_MISSIONSDK_LUA_000278")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000278 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetTestTime then
			PRINT( "ActionProc:SetTestTime, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = SetTestTime( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000279 = GetResString("MISSDK_MISSIONSDK_LUA_000279")
				PRINT( MISSDK_MISSIONSDK_LUA_000279 )
				MISSDK_MISSIONSDK_LUA_000280 = GetResString("MISSDK_MISSIONSDK_LUA_000280")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000280 )
				return LUA_FALSE
			end
		elseif actions[i].func == RenewTestTime1 then
			PRINT( "ActionProc:RenewTestTime1, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = RenewTestTime1( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000281 = GetResString("MISSDK_MISSIONSDK_LUA_000281")
				PRINT( MISSDK_MISSIONSDK_LUA_000281 )
				MISSDK_MISSIONSDK_LUA_000282 = GetResString("MISSDK_MISSIONSDK_LUA_000282")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000282 )
				return LUA_FALSE
			end
		elseif actions[i].func == RenewTestTime2 then
			PRINT( "ActionProc:RenewTestTime2, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = RenewTestTime2( character, npc, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000283 = GetResString("MISSDK_MISSIONSDK_LUA_000283")
				PRINT( MISSDK_MISSIONSDK_LUA_000283 )
				MISSDK_MISSIONSDK_LUA_000284 = GetResString("MISSDK_MISSIONSDK_LUA_000284")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000284 )
				return LUA_FALSE
			end
		elseif actions[i].func == FailureRandMissionCount then
			PRINT( "ActionsProc:FailureRandMissionCount, p1 = ", actions[i].p1 )
			local ret = FailureRandMissionCount( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000285 = GetResString("MISSDK_MISSIONSDK_LUA_000285")
				PRINT( MISSDK_MISSIONSDK_LUA_000285 )
				MISSDK_MISSIONSDK_LUA_000285 = GetResString("MISSDK_MISSIONSDK_LUA_000285")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000285 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetSpawnPos then
			PRINT( "ActionsProc:SetSpawnPos, p1 = ", actions[i].p1 )
			local ret = SetSpawnPos( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000286 = GetResString("MISSDK_MISSIONSDK_LUA_000286")
				PRINT( MISSDK_MISSIONSDK_LUA_000286 )
				MISSDK_MISSIONSDK_LUA_000286 = GetResString("MISSDK_MISSIONSDK_LUA_000286")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000286 )
				return LUA_FALSE
			end
			-------------------------------------------------------------------------
		elseif actions[i].func == GiveSDItem_SetAttr then-------------------------圣诞相关行添加
			PRINT( "ActionProc:GiveSDItem_SetAttr " )
			local ret = GiveSDItem_SetAttr( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:GiveSDItem_SetAttr" )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveSDSMLW then-------------------------圣诞相关行添加
			PRINT( "ActionProc:GiveSDItem_SetAttr " )
			local ret = GiveSDSMLW( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:GiveSDSMLW" )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end

			--------------------------------------------------------------------------------
		elseif actions[i].func == SetProfession then
			PRINT( "ActionsProc:SetProfession, p1 = ", actions[i].p1 )
			local ret = SetProfession( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000287 = GetResString("MISSDK_MISSIONSDK_LUA_000287")
				PRINT( MISSDK_MISSIONSDK_LUA_000287 )
				MISSDK_MISSIONSDK_LUA_000287 = GetResString("MISSDK_MISSIONSDK_LUA_000287")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000287 )
				return LUA_FALSE
			end
		elseif actions[i].func == GoTo then
			PRINT( "ActionsProc:GoTo, p1 = , p2 = , p3 = ", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = GoTo( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			PRINT( "Goto: ret = ", ret )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000288 = GetResString("MISSDK_MISSIONSDK_LUA_000288")
				PRINT( MISSDK_MISSIONSDK_LUA_000288 )
				MISSDK_MISSIONSDK_LUA_000288 = GetResString("MISSDK_MISSIONSDK_LUA_000288")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000288 )
				return LUA_FALSE
			end
		elseif actions[i].func == GoToDream then
			local ret = GoToDream( character, actions[i].p1)
			if ret ~= LUA_TRUE then
				PRINT( "ActionsProc:GoToDream failed！" )
				SystemNotice( character, "ActionsProc:GoToDream failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func == MultiTrigger then
			PRINT( "ActionsProc:MultiTrigger, p1, p2 ", actions[i].p1, actions[i].p2 )
			local ret = MultiTrigger( character, npc, page, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000289 = GetResString("MISSDK_MISSIONSDK_LUA_000289")
				PRINT( MISSDK_MISSIONSDK_LUA_000289 )
				MISSDK_MISSIONSDK_LUA_000289 = GetResString("MISSDK_MISSIONSDK_LUA_000289")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000289 )
				return LUA_FALSE
			end
		elseif actions[i].func == SaveMissionData then
			PRINT( "ActionsProc:SaveMissionData" )
			local ret = SaveMissionData( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000290 = GetResString("MISSDK_MISSIONSDK_LUA_000290")
				PRINT( MISSDK_MISSIONSDK_LUA_000290 )
				MISSDK_MISSIONSDK_LUA_000290 = GetResString("MISSDK_MISSIONSDK_LUA_000290")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000290 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetPkState then
			PRINT( "ActionsProc:SetPkState, p1 = ", actions[i].p1 )
			local ret = SetPkState( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000291 = GetResString("MISSDK_MISSIONSDK_LUA_000291")
				PRINT( MISSDK_MISSIONSDK_LUA_000291 )
				MISSDK_MISSIONSDK_LUA_000291 = GetResString("MISSDK_MISSIONSDK_LUA_000291")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000291 )
				return LUA_FALSE
			end
		elseif actions[i].func == MoveCity then
			PRINT( "ActionsProc:MoveCity, p1 = ", actions[i].p1 )
			local ret = MoveCity( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000292 = GetResString("MISSDK_MISSIONSDK_LUA_000292")
				PRINT( MISSDK_MISSIONSDK_LUA_000292 )
				MISSDK_MISSIONSDK_LUA_000292 = GetResString("MISSDK_MISSIONSDK_LUA_000292")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000292 )
				return LUA_FALSE
			end
		elseif actions[i].func == CreateGuild then
			PRINT( "ActionsProc:CreateGuild, p1 = ", actions[i].p1 )
			local ret = CreateGuild( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000293 = GetResString("MISSDK_MISSIONSDK_LUA_000293")
				PRINT( MISSDK_MISSIONSDK_LUA_000293 )
				MISSDK_MISSIONSDK_LUA_000293 = GetResString("MISSDK_MISSIONSDK_LUA_000293")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000293 )
				return LUA_FALSE
			end
		elseif actions[i].func == ListAllGuild then
			PRINT( "ActionsProc:ListAllGuild, p1 = ", actions[i].p1 )
			local ret = ListAllGuild( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000294 = GetResString("MISSDK_MISSIONSDK_LUA_000294")
				PRINT( MISSDK_MISSIONSDK_LUA_000294 )
				MISSDK_MISSIONSDK_LUA_000294 = GetResString("MISSDK_MISSIONSDK_LUA_000294")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000294 )
				return LUA_FALSE
			end
		elseif actions[i].func == RepairBoat then
			PRINT( "ActionsProc:RepairBoat" )
			local ret = RepairBoat( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000295 = GetResString("MISSDK_MISSIONSDK_LUA_000295")
				PRINT( MISSDK_MISSIONSDK_LUA_000295 )
				MISSDK_MISSIONSDK_LUA_000295 = GetResString("MISSDK_MISSIONSDK_LUA_000295")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000295 )
				return LUA_FALSE
			end
		elseif actions[i].func == SupplyBoat then
			PRINT( "ActionsProc:SupplyBoat" )
			local ret = SupplyBoat( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000296 = GetResString("MISSDK_MISSIONSDK_LUA_000296")
				PRINT( MISSDK_MISSIONSDK_LUA_000296 )
				MISSDK_MISSIONSDK_LUA_000296 = GetResString("MISSDK_MISSIONSDK_LUA_000296")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000296 )
				return LUA_FALSE
			end
		elseif actions[i].func == CreateBoat then
			PRINT( "ActionsProc:CreateBoat, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = CreateBoat( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000297 = GetResString("MISSDK_MISSIONSDK_LUA_000297")
				PRINT( MISSDK_MISSIONSDK_LUA_000297 )
				--SystemNotice( character, "ActionsProc:CreateBoat 失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == BoatLuanchOut then
			PRINT( "ActionsProc:BoatLuanchOut, p1 = , p2 = , p3 = , p4 = , p5 = ", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5 )
			local ret = BoatLuanchOut( character, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000298 = GetResString("MISSDK_MISSIONSDK_LUA_000298")
				PRINT( MISSDK_MISSIONSDK_LUA_000298 )
				MISSDK_MISSIONSDK_LUA_000298 = GetResString("MISSDK_MISSIONSDK_LUA_000298")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000298 )
				return LUA_FALSE
			end			
		elseif actions[i].func == LuanchBerthList then
			--PRINT( "ActionsProc:RemoveYS" )
			PRINT( "ActionsProc:BoatBerthList, p1 = , p2 = , p3 = , p4 = ", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			local ret = LuanchBerthList( character, npc, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			--local ret1 = RemoveYS( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000299 = GetResString("MISSDK_MISSIONSDK_LUA_000299")
				PRINT( MISSDK_MISSIONSDK_LUA_000299 )
				MISSDK_MISSIONSDK_LUA_000299 = GetResString("MISSDK_MISSIONSDK_LUA_000299")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000299 )
				return LUA_FALSE
			end
			--if ret1 ~= 1 then
			--	PRINT( "ActionsProc:RemoveYS 失败！" )
			--	SystemNotice( character, "ActionsProc:RemoveYS 失败！" )
			--	return LUA_FALSE
			--end
		elseif actions[i].func == TradeBerthList then
			PRINT( "ActionsProc:TradeBerthList, p1 = ", actions[i].p1 )
			local ret = TradeBerthList( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000300 = GetResString("MISSDK_MISSIONSDK_LUA_000300")
				PRINT( MISSDK_MISSIONSDK_LUA_000300 )
				MISSDK_MISSIONSDK_LUA_000300 = GetResString("MISSDK_MISSIONSDK_LUA_000300")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000300 )
				return LUA_FALSE
			end
		elseif actions[i].func == CreatBBBB then
			local ret = CreatBBBB( character, actions[i].p1)
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end
		elseif actions[i].func == CheckBBBB then
			local ret = CheckBBBB( character )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end	
		elseif actions[i].func == killBBBB then
			local ret = killBBBB( character )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end	
		elseif actions[i].func == RepairBerthList then
			PRINT( "ActionsProc:RepairBerthList, p1 = ", actions[i].p1 )
			local ret = RepairBerthList( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000301 = GetResString("MISSDK_MISSIONSDK_LUA_000301")
				PRINT( MISSDK_MISSIONSDK_LUA_000301 )
				MISSDK_MISSIONSDK_LUA_000301 = GetResString("MISSDK_MISSIONSDK_LUA_000301")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000301 )
				return LUA_FALSE
			end
		elseif actions[i].func == SalvageBerthList then
			PRINT( "ActionsProc:SalvageBerthList, p1 = ", actions[i].p1 )
			local ret = SalvageBerthList( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000302 = GetResString("MISSDK_MISSIONSDK_LUA_000302")
				PRINT( MISSDK_MISSIONSDK_LUA_000302 )
				MISSDK_MISSIONSDK_LUA_000302 = GetResString("MISSDK_MISSIONSDK_LUA_000302")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000302 )
				return LUA_FALSE
			end
		elseif actions[i].func == SupplyBerthList then
			PRINT( "ActionsProc:SupplyBerthList, p1 = ", actions[i].p1 )
			local ret = SupplyBerthList( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000303 = GetResString("MISSDK_MISSIONSDK_LUA_000303")
				PRINT( MISSDK_MISSIONSDK_LUA_000303 )
				MISSDK_MISSIONSDK_LUA_000303 = GetResString("MISSDK_MISSIONSDK_LUA_000303")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000303 )
				return LUA_FALSE
			end
		elseif actions[i].func == BoatLevelBerthList then
			PRINT( "ActionsProc:BoatLevelBerthList, p1 = ", actions[i].p1 )
			local ret = BoatLevelBerthList( character, npc, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000304 = GetResString("MISSDK_MISSIONSDK_LUA_000304")
				PRINT( MISSDK_MISSIONSDK_LUA_000304 )
				MISSDK_MISSIONSDK_LUA_000304 = GetResString("MISSDK_MISSIONSDK_LUA_000304")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000304 )
				return LUA_FALSE
			end
		elseif actions[i].func == BoatBerth then
			PRINT( "ActionsProc:BoatBerth, p1 = , p2 = , p3 = , p4 = ", actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			local ret = BoatBerth( character, actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000305 = GetResString("MISSDK_MISSIONSDK_LUA_000305")
				PRINT( MISSDK_MISSIONSDK_LUA_000305 )
				MISSDK_MISSIONSDK_LUA_000305 = GetResString("MISSDK_MISSIONSDK_LUA_000305")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000305 )
				return LUA_FALSE
			end
		elseif actions[i].func == PackBagList then
			PRINT( "ActionsProc:PackBagList, p1 = , p2 = , p3 = ", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = PackBagList( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000306 = GetResString("MISSDK_MISSIONSDK_LUA_000306")
				PRINT( MISSDK_MISSIONSDK_LUA_000306 )
				MISSDK_MISSIONSDK_LUA_000306 = GetResString("MISSDK_MISSIONSDK_LUA_000306")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000306 )
				return LUA_FALSE
			end
		elseif actions[i].func == SetTradeItemLevel then
			PRINT( "ActionsProc:SetTradeItemLevel, p1 = ", actions[i].p1 )
			local ret = SetTradeItemLevel( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000307 = GetResString("MISSDK_MISSIONSDK_LUA_000307")
				PRINT( MISSDK_MISSIONSDK_LUA_000307 )
				MISSDK_MISSIONSDK_LUA_000307 = GetResString("MISSDK_MISSIONSDK_LUA_000307")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000307 )
				return LUA_FALSE
			end
		elseif actions[i].func == AdjustTradeCess then
			PRINT( "ActionsProc:AdjustTradeCess, p1 = , p2 = ", actions[i].p1, actions[i].p2 )
			local ret = AdjustTradeCess( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000308 = GetResString("MISSDK_MISSIONSDK_LUA_000308")
				PRINT( MISSDK_MISSIONSDK_LUA_000308 )
				MISSDK_MISSIONSDK_LUA_000308 = GetResString("MISSDK_MISSIONSDK_LUA_000308")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000308 )
				return LUA_FALSE
			end
		elseif actions[i].func == OpenBank then
			PRINT( "ActionsProc:OpenBank" )
			local ret = OpenBank( character, npc )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000309 = GetResString("MISSDK_MISSIONSDK_LUA_000309")
				PRINT( MISSDK_MISSIONSDK_LUA_000309 )
				MISSDK_MISSIONSDK_LUA_000309 = GetResString("MISSDK_MISSIONSDK_LUA_000309")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000309 )
				return LUA_FALSE
			end
		elseif actions[i].func == OpenHair then
			PRINT( "ActionsProc:OpenHair" )
			local ret = OpenHair( character, npc )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000310 = GetResString("MISSDK_MISSIONSDK_LUA_000310")
				PRINT( MISSDK_MISSIONSDK_LUA_000310 )
				MISSDK_MISSIONSDK_LUA_000310 = GetResString("MISSDK_MISSIONSDK_LUA_000310")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000310 )
				return LUA_FALSE
			end
		elseif actions[i].func == CheckChaItem then
				PRINT( "ActionProc: CheckChaItem, p1 = ", actions[i].p1)
				local ret = CheckChaItem( character)
				if ret ~= LUA_TRUE then
					PRINT( "ActionProc:CheckChaItem = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == OpenRepair then
			PRINT( "ActionsProc:OpenRepair" )
			local ret = OpenRepair( character, npc )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000311 = GetResString("MISSDK_MISSIONSDK_LUA_000311")
				PRINT( MISSDK_MISSIONSDK_LUA_000311 )
				MISSDK_MISSIONSDK_LUA_000311 = GetResString("MISSDK_MISSIONSDK_LUA_000311")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000311 )
				return LUA_FALSE
			end
		elseif actions[i].func == RandFunction then
			PRINT( "ActionsProc:RandFunction, page = , p1 = , p2 = ", page, actions[i].p1, actions[i].p2 )
			local ret = RandFunction( character, npc, page, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000312 = GetResString("MISSDK_MISSIONSDK_LUA_000312")
				PRINT( MISSDK_MISSIONSDK_LUA_000312 )
				MISSDK_MISSIONSDK_LUA_000312 = GetResString("MISSDK_MISSIONSDK_LUA_000312")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000312 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddCredit then
			PRINT( "ActionsProc:AddCredit, p1 = ", actions[i].p1 )
			local ret = AddCredit( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000313 = GetResString("MISSDK_MISSIONSDK_LUA_000313")
				PRINT( MISSDK_MISSIONSDK_LUA_000313 )
				MISSDK_MISSIONSDK_LUA_000313 = GetResString("MISSDK_MISSIONSDK_LUA_000313")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000313 )
				return LUA_FALSE
			end
		elseif actions[i].func == Givecrab then
			PRINT( "ActionProc: Givecrab, p1 = ", actions[i].p1)
			local ret = Givecrab( character,npc, actions[i].p1)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:Givecrab = false" )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeOffer then
			PRINT( "ActionsProc:TakeOffer, p1 = ", actions[i].p1 )
			local ret = TakeOffer( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000314 = GetResString("MISSDK_MISSIONSDK_LUA_000314")
				PRINT( MISSDK_MISSIONSDK_LUA_000314 )
				MISSDK_MISSIONSDK_LUA_000314 = GetResString("MISSDK_MISSIONSDK_LUA_000314")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000314 )
				return LUA_FALSE
			end
		elseif actions[i].func == ValentinesRing then
			PRINT( "ActionsProc:ValentinesRing, p1 = ", actions[i].p1 )
			local ret = ValentinesRing( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000315 = GetResString("MISSDK_MISSIONSDK_LUA_000315")
				PRINT( MISSDK_MISSIONSDK_LUA_000315 )
				MISSDK_MISSIONSDK_LUA_000315 = GetResString("MISSDK_MISSIONSDK_LUA_000315")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000315 )
				return LUA_FALSE
			end
		elseif actions[i].func == Take_THSJ_Record then     ---清除任务记录
			local ret = Take_THSJ_Record( character )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end
		elseif actions[i].func == ClearItemNum2 then
			PRINT( "ActionProc:ClearItemNum2, p1, p2, p3", actions[i].p1, actions[i].p2, actions[i].p3 )
			local ret = ClearItemNum2( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000316 = GetResString("MISSDK_MISSIONSDK_LUA_000316")
				PRINT( MISSDK_MISSIONSDK_LUA_000316 )
				SystemNotice( character, "ActionProc: ClearItemNum2" )
				return LUA_FALSE
		end		
		elseif actions[i].func == Winterland_SetMisTime then
			PRINT( "ActionProc: Winterland_SetMisTime ")
			local ret = Winterland_SetMisTime( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:Winterland_SetMisTime = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission1 then
			PRINT( "ActionProc: AddItem_Mission1 ")
			local ret = AddItem_Mission1( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission1 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission2 then
			PRINT( "ActionProc: AddItem_Mission2 ")
			local ret = AddItem_Mission2( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission2 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission3 then
			PRINT( "ActionProc: AddItem_Mission3 ")
			local ret = AddItem_Mission3( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission3 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission4 then
			PRINT( "ActionProc: AddItem_Mission4 ")
			local ret = AddItem_Mission4( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission4 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission5 then
			PRINT( "ActionProc: AddItem_Mission5 ")
			local ret = AddItem_Mission5( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission5 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission6 then
			PRINT( "ActionProc: AddItem_Mission6 ")
			local ret = AddItem_Mission6( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission6 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission7 then
			PRINT( "ActionProc: AddItem_Mission7 ")
			local ret = AddItem_Mission7( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission7 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission8 then
			PRINT( "ActionProc: AddItem_Mission8 ")
			local ret = AddItem_Mission8( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission8 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission9 then
			PRINT( "ActionProc: AddItem_Mission9 ")
			local ret = AddItem_Mission9( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission9 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission10 then
			PRINT( "ActionProc: AddItem_Mission10 ")
			local ret = AddItem_Mission10( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission10 = false" )
				return LUA_FALSE
		end
		elseif actions[i].func == AddItem_Mission11 then
			PRINT( "ActionProc: AddItem_Mission11 ")
			local ret = AddItem_Mission11( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission11 = false" )
				return LUA_FALSE
		end
		-----------------------------zhangliang-----------------万圣节真正的危机-------
		elseif actions[i].func == AddItem_Mission12 then
			PRINT( "ActionProc: AddItem_Mission12 ")
			local ret = AddItem_Mission12( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission12 = false" )
				return LUA_FALSE
		end
		-----------------------------zhangliang-----------------偷吃鸡的狐狸-------
		elseif actions[i].func == AddItem_Mission13 then
			PRINT( "ActionProc: AddItem_Mission13 ")
			local ret = AddItem_Mission13( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission13 = false" )
				return LUA_FALSE
		end		
			
		-----------------------------zhangliang-----------------抓捕王小虎-------
		elseif actions[i].func == AddItem_Mission14 then
			PRINT( "ActionProc: AddItem_Mission14 ")
			local ret = AddItem_Mission14( character)
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc:AddItem_Mission14 = false" )
				return LUA_FALSE
		end	
			
		elseif actions[i].func == AddExp_10persent then   
			local  ret = AddExp_10persent (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end		
		elseif actions[i].func == AddExp_5persent then   
			local  ret = AddExp_5persent (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end
		elseif actions[i].func == AddExp_3persent then   
			local  ret = AddExp_3persent (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end
		elseif actions[i].func == AddExp_05persent then   
			local  ret = AddExp_05persent (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end			
		elseif actions[i].func == AddExp1 then   
			local  ret = AddExp1 (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end	
		elseif actions[i].func == TeamZdJl then     ---清除任务记录
			local ret = TeamZdJl( character )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end
		elseif actions[i].func == Give_Box then
			PRINT( "ActionProc:Give_Box, p1 = " )
			local ret = Give_Box( character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000317 = GetResString("MISSDK_MISSIONSDK_LUA_000317")
				PRINT( MISSDK_MISSIONSDK_LUA_000317 )
				--SystemNotice( character, "ActionProc:设置历史记录标签失败！" )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveItem_SetAttr then     ---清除任务记录
			local ret = GiveItem_SetAttr( character ,actions[i].p1, actions[i].p2, actions[i].p3, actions[i].p4, actions[i].p5, actions[i].p6 )
			if ret ~= LUA_TRUE then
				return LUA_FALSE
			end
		elseif actions[i].func == ShuangBei_ChunChu then
				PRINT( "actionsTest:ShuangBei_ChunChu ", actions[i].p1 ) 
				local ret = ShuangBei_ChunChu( character, actions[i].p1 ) 
				if ret ~= LUA_TRUE then 
					PRINT( "actionsTest: ShuangBei_ChunChu = false" )
					return LUA_FALSE
				end
		elseif actions[i].func == ShuangBei_TimeChaxun then
			local  ret = ShuangBei_TimeChaxun (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end	
		elseif actions[i].func == GiveSB then
			local  ret = GiveSB (character)
			if ret ~= LUA_TRUE then
					return LUA_FALSE
			end	
		elseif actions[i].func == ZhanBu then
			PRINT( "actionsTest:ZhanBu ", actions[i].p1 ) 
			local ret = ZhanBu( character, actions[i].p1 ) 
			if ret ~= LUA_TRUE then 
				PRINT( "actionsTest: ZhanBu = false" )
				return LUA_FALSE
			end	
		elseif actions[i].func == GiveNpcMission then
			PRINT( "ActionsProc:GiveNpcMission, p1 = ", actions[i].p1 )
			local ret = GiveNpcMission( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000318 = GetResString("MISSDK_MISSIONSDK_LUA_000318")
				PRINT( MISSDK_MISSIONSDK_LUA_000318 )
				MISSDK_MISSIONSDK_LUA_000319 = GetResString("MISSDK_MISSIONSDK_LUA_000319")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000319 )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveXZItem then
			PRINT( "ActionsProc:GiveXZItem" )
			local ret = GiveXZItem( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000326 = GetResString("MISSDK_MISSIONSDK_LUA_000326")
				PRINT( MISSDK_MISSIONSDK_LUA_000326 )
				MISSDK_MISSIONSDK_LUA_000326 = GetResString("MISSDK_MISSIONSDK_LUA_000326")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000326 )
				return LUA_FALSE
			end
		elseif actions[i].func == YBHS then   
			local  ret = YBHS (character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000327 = GetResString("MISSDK_MISSIONSDK_LUA_000327")
				PRINT( MISSDK_MISSIONSDK_LUA_000327 )
				MISSDK_MISSIONSDK_LUA_000327 = GetResString("MISSDK_MISSIONSDK_LUA_000327")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000327 )
					return LUA_FALSE
			end	
		elseif actions[i].func == GiveMGHZ then
			PRINT( "ActionsProc:GiveMGHZ" )
			local ret = GiveMGHZ( character, actions[i].p1, actions[i].p2, actions[i].p3 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000328 = GetResString("MISSDK_MISSIONSDK_LUA_000328")
				PRINT( MISSDK_MISSIONSDK_LUA_000328 )
				MISSDK_MISSIONSDK_LUA_000328 = GetResString("MISSDK_MISSIONSDK_LUA_000328")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000328 )
				return LUA_FALSE
			end
		elseif actions[i].func == RemoveHua then
			PRINT( "ActionsProc:RemoveHua" )
			local ret = RemoveHua( character , actions[i].p1)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000329 = GetResString("MISSDK_MISSIONSDK_LUA_000329")
				PRINT( MISSDK_MISSIONSDK_LUA_000329 )
				MISSDK_MISSIONSDK_LUA_000329 = GetResString("MISSDK_MISSIONSDK_LUA_000329")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000329 )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeAndGiveItem then
			PRINT( "ActionsProc:TakeAndGiveItem" )
			local ret = TakeAndGiveItem( character , actions[i].p1,actions[i].p2,actions[i].p3,actions[i].p4)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000330 = GetResString("MISSDK_MISSIONSDK_LUA_000330")
				PRINT( MISSDK_MISSIONSDK_LUA_000330 )
				MISSDK_MISSIONSDK_LUA_000330 = GetResString("MISSDK_MISSIONSDK_LUA_000330")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000330 )
				return LUA_FALSE
			end
		elseif actions[i].func == XZKHDJianLiN then
			PRINT( "ActionsProc:XZKHDJianLiN" )
			local ret = XZKHDJianLiN( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000331 = GetResString("MISSDK_MISSIONSDK_LUA_000331")
				PRINT( MISSDK_MISSIONSDK_LUA_000331 )
				MISSDK_MISSIONSDK_LUA_000331 = GetResString("MISSDK_MISSIONSDK_LUA_000331")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000331 )
				return LUA_FALSE
			end
		elseif actions[i].func == XZKHDBuZhou then
			PRINT( "ActionsProc:XZKHDBuZhou" )
			local ret = XZKHDBuZhou( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000332 = GetResString("MISSDK_MISSIONSDK_LUA_000332")
				PRINT( MISSDK_MISSIONSDK_LUA_000332 )
				MISSDK_MISSIONSDK_LUA_000332 = GetResString("MISSDK_MISSIONSDK_LUA_000332")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000332 )
				return LUA_FALSE
			end
		elseif actions[i].func == zhuanzts then
			PRINT( "ActionsProc:zhuanzts" )
			local ret = zhuanzts( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000333 = GetResString("MISSDK_MISSIONSDK_LUA_000333")
				PRINT( MISSDK_MISSIONSDK_LUA_000333 )
				MISSDK_MISSIONSDK_LUA_000333 = GetResString("MISSDK_MISSIONSDK_LUA_000333")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000333 )
				return LUA_FALSE
			end
		elseif actions[i].func ==mj3sjc then
				PRINT( "mj3sjc: mj3sjc")
				local ret = mj3sjc(character ) 
				if ret ~= LUA_TRUE then
					PRINT( "ConditionsTest:mj3sjc = false" )
					return LUA_FALSE
				end
		elseif actions[i].func ==DuiHuanJQHMG then
			DuiHuanJQHMG(character )
		elseif actions[i].func == bulingSB then
			PRINT( "ActionsProc:bulingSB" )
			local ret = bulingSB( character )				
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000334 = GetResString("MISSDK_MISSIONSDK_LUA_000334")
				PRINT( MISSDK_MISSIONSDK_LUA_000334 )
				MISSDK_MISSIONSDK_LUA_000334 = GetResString("MISSDK_MISSIONSDK_LUA_000334")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000334 )
				return LUA_FALSE
			end
		elseif actions[i].func == bulingBL then
			PRINT( "ActionsProc:bulingBL" )
			local ret = bulingBL( character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000335 = GetResString("MISSDK_MISSIONSDK_LUA_000335")
				PRINT( MISSDK_MISSIONSDK_LUA_000335 )
				MISSDK_MISSIONSDK_LUA_000335 = GetResString("MISSDK_MISSIONSDK_LUA_000335")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000335 )
				return LUA_FALSE
			end
		elseif actions[i].func == ChargeQiByAll then
			PRINT( "ActionsProc:ChargeQiByAll" )
			local ret = ChargeQiByAll(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000336 = GetResString("MISSDK_MISSIONSDK_LUA_000336")
				PRINT( MISSDK_MISSIONSDK_LUA_000336 )
				MISSDK_MISSIONSDK_LUA_000336 = GetResString("MISSDK_MISSIONSDK_LUA_000336")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000336 )
				return LUA_FALSE
			end
		elseif actions[i].func == ChargeQiByOne then
			local ret = ChargeQiByOne(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000337 = GetResString("MISSDK_MISSIONSDK_LUA_000337")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000337 )
				return LUA_FALSE
			end	
		elseif actions[i].func == InitFalse then
			PRINT( "ActionsProc:InitFalse" )
			local ret = InitFalse()
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000338 = GetResString("MISSDK_MISSIONSDK_LUA_000338")
				PRINT( MISSDK_MISSIONSDK_LUA_000338 )
				MISSDK_MISSIONSDK_LUA_000338 = GetResString("MISSDK_MISSIONSDK_LUA_000338")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000338 )
				return LUA_FALSE
			end
		elseif actions[i].func == ZhanBubyRole then
			local ret = ZhanBubyRole(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000345 = GetResString("MISSDK_MISSIONSDK_LUA_000345")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000345 )
				return LUA_FALSE
			end
		elseif actions[i].func == GiveItem95BBZB then
			PRINT( "ActionsProc:GiveItem95BBZB" )
			local ret = GiveItem95BBZB( character, actions[i].p1, actions[i].p2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000346 = GetResString("MISSDK_MISSIONSDK_LUA_000346")
				PRINT( MISSDK_MISSIONSDK_LUA_000346 )
				MISSDK_MISSIONSDK_LUA_000346 = GetResString("MISSDK_MISSIONSDK_LUA_000346")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000346 )
				return LUA_FALSE
			end
		elseif actions[i].func == JZAction1 then
			local ret = JZAction1(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000347 = GetResString("MISSDK_MISSIONSDK_LUA_000347")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000347 )
				return LUA_FALSE
			end
		elseif actions[i].func == JZAction2 then
			local ret = JZAction2(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000348 = GetResString("MISSDK_MISSIONSDK_LUA_000348")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000348 )
				return LUA_FALSE
			end
		elseif actions[i].func == JZAction3 then
			local ret = JZAction3(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000349 = GetResString("MISSDK_MISSIONSDK_LUA_000349")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000349 )
				return LUA_FALSE
			end
		elseif actions[i].func == JZAction4 then
			local ret = JZAction4(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000350 = GetResString("MISSDK_MISSIONSDK_LUA_000350")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000350 )
				return LUA_FALSE
			end
		elseif actions[i].func == Jiu_Action then
			local ret = Jiu_Action(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000351 = GetResString("MISSDK_MISSIONSDK_LUA_000351")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000351 )
				return LUA_FALSE
			end		
		elseif actions[i].func == GiveNpcMissionbyFunc then
			local ret = GiveNpcMissionbyFunc (character, npc,actions[i].p1, actions[i].p2, actions[i].p3,actions[i].p4,actions[i].p5)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000352 = GetResString("MISSDK_MISSIONSDK_LUA_000352")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000352 )
				return LUA_FALSE
			end	
		elseif actions[i].func == GiveNpcMission1 then
			local ret = GiveNpcMission1( character, npc,actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000352 = GetResString("MISSDK_MISSIONSDK_LUA_000352")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000352 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddExpRealPer2 then
			local ret = AddExpRealPer2(character,actions[i].p1, actions[i].p2)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000353 = GetResString("MISSDK_MISSIONSDK_LUA_000353")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000353 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddExpRealPer then
			local ret = AddExpRealPer(character,actions[i].p1, actions[i].p2)
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc:AddExpRealPer2 failed！" )
				return LUA_FALSE
			end	
		elseif actions[i].func == GiveXXBYRewards then
			local ret = GiveXXBYRewards(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000354 = GetResString("MISSDK_MISSIONSDK_LUA_000354")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000354 )
				return LUA_FALSE
			end
		elseif actions[i].func == BaBuPrize then
			local ret = BaBuPrize(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000355 = GetResString("MISSDK_MISSIONSDK_LUA_000355")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000355 )
				return LUA_FALSE
			end
		elseif actions[i].func == ALBSPrize then
			local ret = ALBSPrize(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000356 = GetResString("MISSDK_MISSIONSDK_LUA_000356")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000356 )
				return LUA_FALSE
			end
		elseif actions[i].func == BLGLPrize then
			local ret = BLGLPrize(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000357 = GetResString("MISSDK_MISSIONSDK_LUA_000357")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000357 )
				return LUA_FALSE
			end	
		elseif actions[i].func == GiveZXBYRewards then
			local ret = GiveZXBYRewards(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000358 = GetResString("MISSDK_MISSIONSDK_LUA_000358")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000358 )
				return LUA_FALSE
			end
		elseif actions[i].func == ZTLCharge then
			local ret = ZTLCharge(character,npc)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000359 = GetResString("MISSDK_MISSIONSDK_LUA_000359")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000359 )
				return LUA_FALSE
			end
		elseif actions[i].func == BuyZTL then
			local ret = BuyZTL(character,npc)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000360 = GetResString("MISSDK_MISSIONSDK_LUA_000360")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000360 )
				return LUA_FALSE
			end
		elseif actions[i].func == TakeCZCL then
			local ret = TakeCZCL(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000361 = GetResString("MISSDK_MISSIONSDK_LUA_000361")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000361 )
				return LUA_FALSE
			end	
		elseif actions[i].func == GiveFHItem then
			local ret = GiveFHItem(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000362 = GetResString("MISSDK_MISSIONSDK_LUA_000362")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000362 )
				return LUA_FALSE
			end	
		elseif actions[i].func == BBXLChangeColor then
			local ret = BBXLChangeColor(character)
			if ret ~= LUA_TRUE then
				--SystemNotice( character, "ActionsProc:BBXLChangeColor 失败！" )
				return LUA_FALSE
			end		
		elseif actions[i].func == BBXLChangeName then
			local ret = BBXLChangeName(character)
			if ret ~= LUA_TRUE then
				--SystemNotice( character, "ActionsProc:BBXLChangeName 失败！" )
				return LUA_FALSE
			end	
		elseif actions[i].func == yanhuaGive then
			local ret = yanhuaGive(character)
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000363 = GetResString("MISSDK_MISSIONSDK_LUA_000363")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000363 )
				return LUA_FALSE
			end	
		elseif actions[i].func == LoveRingTo then
			PRINT( "ActionProc:LoveRingTo, p1 = ", actions[i].p1 )
			local ret = LoveRingTo( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000364 = GetResString("MISSDK_MISSIONSDK_LUA_000364")
				PRINT( MISSDK_MISSIONSDK_LUA_000364 )
				MISSDK_MISSIONSDK_LUA_000365 = GetResString("MISSDK_MISSIONSDK_LUA_000365")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000365 )
				return LUA_FALSE
			end
		elseif actions[i].func == AddLovePoint then
			PRINT( "ActionProc:AddLovePoint, p1 = ", actions[i].p1 )
			local ret = AddLovePoint( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000366 = GetResString("MISSDK_MISSIONSDK_LUA_000366")
				PRINT( MISSDK_MISSIONSDK_LUA_000366 )
				MISSDK_MISSIONSDK_LUA_000367 = GetResString("MISSDK_MISSIONSDK_LUA_000367")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000367 )
				return LUA_FALSE
			end
		elseif actions[i].func == Nangua then
			PRINT( "ActionProc:Nangua, p1 = ", actions[i].p1 )
			local ret = Nangua( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc: Nangua failed！" )
				SystemNotice( character, "ActionProc: Nangua:万圣南瓜计数失败！" )
				return LUA_FALSE
			end			
		elseif actions[i].func == GiveXZNewItem then
			local ret = GiveXZNewItem(character )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000368 = GetResString("MISSDK_MISSIONSDK_LUA_000368")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000368 )
				return LUA_FALSE
			end
		elseif actions[i].func == XiqueNum_99 then
			local ret = XiqueNum_99(character )
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc:XiqueNum_99 failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func == SpEnterXLZD then
			local ret = SpEnterXLZD(character )
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc:SpEnterXLZD failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func == EnterXLZD then
			local ret = EnterXLZD(character )
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc:EnterXLZD failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func ==  ShuangErMMAddExp then
			local ret =  ShuangErMMAddExp(character,actions[i].p1 )
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc: ShuangErMMAddExp failed！" )
				return LUA_FALSE
			end
		elseif actions[i].func ==  WanShengDaLi then
			local ret =  WanShengDaLi(character )
			if ret ~= LUA_TRUE then
				SystemNotice( character, "ActionsProc: WanShengDaLi failed！" )
				return LUA_FALSE
			end
		
		-------------------------------------------------------------zhangliang----------------------------------------------------------
		elseif actions[i].func == CheckFuShenItem then
			PRINT( "ActionProc:CheckFuShenItem, p1 = ", actions[i].p1 )
			local ret = CheckFuShenItem( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc: AddLovePoint failed！" )
				SystemNotice( character, "ActionProc: AddLovePoint:添加爱情积分失败！" )
				return LUA_FALSE
			end				
		elseif actions[i].func == GivePointsAndMoney then
			PRINT( "ActionProc:GivePointsAndMoney, p1 = ", actions[i].p1 )
			local ret = GivePointsAndMoney( character, actions[i].p1 )
			if ret ~= LUA_TRUE then
				PRINT( "ActionProc: GivePointsAndMoney 失败！" )
				SystemNotice( character, "ActionProc: GivePointsAndMoney:添加爱情积分失败！" )
				return LUA_FALSE
			end	
		-------------------------------------------------------------zhangliang----------------------------------------------------------
		else
			MISSDK_MISSIONSDK_LUA_000369 = GetResString("MISSDK_MISSIONSDK_LUA_000369")
			PRINT( MISSDK_MISSIONSDK_LUA_000369 )
			MISSDK_MISSIONSDK_LUA_000370 = GetResString("MISSDK_MISSIONSDK_LUA_000370")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000370 )
			return LUA_FALSE
		end		
	end
	
	PRINT( "ActionProc: return true" )
	return LUA_TRUE
end

--NPC触发器条件检查函数
function NpcTriggerCheck( character, trigger )
	PRINT( "NpcTriggerCheck" )
	if trigger == nil or trigger.conditions == nil then
		MISSDK_MISSIONSDK_LUA_000371 = GetResString("MISSDK_MISSIONSDK_LUA_000371")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000371 )
		return LUA_ERROR
	end
	PRINT( "NpcTriggerCheck: ConditionsTest" )
	return ConditionsTest( character, trigger.conditions )
end

function Take_THSJ_Record(role)     --清除任务记录
	for checknum = 1 , 7 , 1 do
		local value = 1280 + checknum
		local Ishave = HasRecord( role , value )
		if Ishave == LUA_TRUE then
			ClearRecord( role , value )
		end
	end
	return LUA_TRUE
end

--是否任务已经完成
function NpcTriggerResult( character, trigger )
	PRINT( "NpcTriggerResult" )
	if trigger == nil then
		MISSDK_MISSIONSDK_LUA_000372 = GetResString("MISSDK_MISSIONSDK_LUA_000372")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000372 )
		return LUA_ERROR
	end
	
	--默认如果触发器没有结果条件则为永远不符合条件
	if trigger.restul == nil or trigger.result[1] == nil then
		MISSDK_MISSIONSDK_LUA_000373 = GetResString("MISSDK_MISSIONSDK_LUA_000373")
		PRINT( MISSDK_MISSIONSDK_LUA_000373 )
		return LUA_FALSE
	end
	
	PRINT( "NpcTriggerResult: ConditionsTest" )
	return ConditionsTest( character, trigger.result )
end

--取消一个任务
function NpcCancelTrigger( character, trigger, misid, scriptid )
	PRINT( "NpcCancelTrigger" )
	if trigger == nil or trigger.actions == nil then
		MISSDK_MISSIONSDK_LUA_000374 = GetResString("MISSDK_MISSIONSDK_LUA_000374")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000374 )
		return LUA_ERROR
	end
	
	--检测触发器限制条件
	PRINT( "NpcCancelTrigger:conditions test" )
	if trigger.conditions ~= nil and trigger.conditions[1] ~= nil then
		local ret = ConditionsTest( character, trigger.conditions )
		if ret ~= LUA_TRUE then
			PRINT( "NpcCancelTrigger: conditions return false, return false" )
			return LUA_FALSE
		end
	end
	
	PRINT( "NpcCancelTrigger:actions proc" )
	if trigger.actions.count ~= nil then
		local actions = {}
		actions[1] = {}
		actions.count = 1
		for n = 1, trigger.actions.count, 1 do
			actions[1].func = trigger.actions[n].func
			actions[1].p1 = trigger.actions[n].p1
			actions[1].p2 = trigger.actions[n].p2
			actions[1].p3 = trigger.actions[n].p3
			actions[1].p4 = trigger.actions[n].p4
			actions[1].p5 = trigger.actions[n].p5
			actions[1].p6 = trigger.actions[n].p6
			actions[1].p7 = trigger.actions[n].p7
			actions[1].p8 = trigger.actions[n].p8
			PRINT( "NpcCancelTrigger:actions proc, func, p1, p2, p3, p4, p5, p6", trigger.actions[n].func, trigger.actions[n].p1, trigger.actions[n].p2, trigger.actions[n].p3, trigger.actions[n].p4 )
			local ret = ActionsProc( character, actions, nil, nil, misid, scriptid )
			if ret ~= LUA_TRUE then
				PRINT( "NpcCancelTrigger: actions return false, return false" )
			end
		end
	end
	
	PRINT( "NpcCancelTrigger: return true" )
	return LUA_TRUE
end

function NpcTrigger( character, npc, trigger, misid, scriptid )
	PRINT( "NpcTrigger" )
	if trigger == nil or trigger.actions == nil then
		MISSDK_MISSIONSDK_LUA_000375 = GetResString("MISSDK_MISSIONSDK_LUA_000375")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000375 )
		return LUA_ERROR
	end
	
	--检测触发器限制条件
	PRINT( "NpcTrigger:conditions test" )
	if trigger.conditions ~= nil and trigger.conditions[1] ~= nil then
		local ret = ConditionsTest( character, trigger.conditions )
		if ret ~= LUA_TRUE then
			PRINT( "NpcTrigger: conditions return false, return false" )
			return LUA_FALSE
		end
	end
	
	PRINT( "NpcTrigger:actions proc" )
	if trigger.actions ~= nil and trigger.actions[1] ~= nil then
		local ret = ActionsProc( character, trigger.actions, npc, nil, misid, scriptid )
		if ret ~= LUA_TRUE then
			PRINT( "NpcTrigger: actions return false, return false" )
		end
	end
	
	PRINT( "NpcTrigger: return true" )
	return LUA_TRUE
end

function TriggerProc( character, id, param1, param2, param3, param4 )
	PRINT( "TriggerProc:2 ID = , Trigger = , p1 = , p2 = , p3 = , p4 = ", id, TriggerList[id], param1, param2, param3, param4 )	
	if id == nil or TriggerList[id] == nil or TriggerList[id].actions == nil or param1 == nil or param2 == nil then
		MISSDK_MISSIONSDK_LUA_000376 = GetResString("MISSDK_MISSIONSDK_LUA_000376")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000376..id )
		return LUA_ERROR
	end
	
	PRINT( "TriggerProc: conditions proc!" )
	local trigger = TriggerList[id]
	if trigger.tp == MIS_TRIGGER_NOMAL then
		--检测触发器限制条件
		if trigger.conditions ~= nil and trigger.conditions[1] ~= nil then
			local ret = ConditionsTest( character, trigger.conditions, param1, param2 )
			if ret ~= LUA_TRUE then
				PRINT( "TriggerProc: conditions return false, return false" )
				return LUA_FALSE
			end
		end
		
		--处理触发器动作
		PRINT( "TriggerProc:actions proc" )
		if trigger.actions ~= nil and trigger.actions[1] ~= nil then
			local ret = ActionsProc( character, trigger.actions, nil, nil, 0, 0, param1, param2 )
			if ret ~= LUA_TRUE then
				PRINT( "TriggerProc: actions return false, return false" )
				SystemNotice( character, "TriggerProc: actions return false, return false" )
				return LUA_FALSE
			end
		end
	
	elseif trigger.tp == MIS_TRIGGER_RAND then
		MISSDK_MISSIONSDK_LUA_000377 = GetResString("MISSDK_MISSIONSDK_LUA_000377")
		PRINT( MISSDK_MISSIONSDK_LUA_000377, param3, param4 )
		if trigger.actions[1].func == AddRMNextFlag then
			if param3 == nil or param4 == nil then
				MISSDK_MISSIONSDK_LUA_000378 = GetResString("MISSDK_MISSIONSDK_LUA_000378")
				PRINT( MISSDK_MISSIONSDK_LUA_000378 )
				MISSDK_MISSIONSDK_LUA_000378 = GetResString("MISSDK_MISSIONSDK_LUA_000378")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000378 )
				MISSDK_MISSIONSDK_LUA_000379 = GetResString("MISSDK_MISSIONSDK_LUA_000379")
				LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000379, id )
				return LUA_FALSE
			end
			
			trigger.actions[1].p2 = param3
			trigger.actions[1].p3 = param4
		end
		
		--检测触发器限制条件
		if trigger.conditions ~= nil and trigger.conditions[1] ~= nil then
			local ret = ConditionsTest( character, trigger.conditions, param1, param2 )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000380 = GetResString("MISSDK_MISSIONSDK_LUA_000380")
				PRINT( MISSDK_MISSIONSDK_LUA_000380 )
				return LUA_FALSE
			end
		end
		
		--处理触发器动作
		MISSDK_MISSIONSDK_LUA_000381 = GetResString("MISSDK_MISSIONSDK_LUA_000381")
		PRINT( MISSDK_MISSIONSDK_LUA_000381 )
		if trigger.actions ~= nil and trigger.actions[1] ~= nil then
			local ret = ActionsProc( character, trigger.actions )
			if ret ~= LUA_TRUE then
				MISSDK_MISSIONSDK_LUA_000382 = GetResString("MISSDK_MISSIONSDK_LUA_000382")
				PRINT( MISSDK_MISSIONSDK_LUA_000382 )
				MISSDK_MISSIONSDK_LUA_000382 = GetResString("MISSDK_MISSIONSDK_LUA_000382")
				SystemNotice( character, MISSDK_MISSIONSDK_LUA_000382 )
				return LUA_FALSE
			end
		end
		--reset rand mission trigger actions's value
		trigger.actions[1].p2 = 0
		trigger.actions[1].p3 = 0
	else
		MISSDK_MISSIONSDK_LUA_000383 = GetResString("MISSDK_MISSIONSDK_LUA_000383")
		PRINT( MISSDK_MISSIONSDK_LUA_000383, id )
		MISSDK_MISSIONSDK_LUA_000383 = GetResString("MISSDK_MISSIONSDK_LUA_000383")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000383..id )
		return LUA_FALSE
	end
	
	PRINT( "TriggerProc: return true." )
	return LUA_TRUE
end

function TriggerResult( character, id, param1, param2 )
	PRINT( "TriggerResult" )	
	if id == nil or TriggerList[id] == nil or param1 == nil or param2 == nil then
		MISSDK_MISSIONSDK_LUA_000384 = GetResString("MISSDK_MISSIONSDK_LUA_000384")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000384 )
		return LUA_ERROR
	end
	
	PRINT( "TriggerResult: conditions proc!" )
	local trigger = TriggerList[id]
	
	--处理触发器结束动作
	PRINT( "TriggerProc:failures proc" )
	if trigger.failures ~= nil and trigger.failures[1] ~= nil then
		local ret = ActionsProc( character, trigger.failures )
		if ret ~= LUA_TRUE then
			PRINT( "TriggerProc: failures return false, return false" )
		end
	end
	
	PRINT( "TriggerResult: return true" )
	return LUA_TRUE
end 

--获取角色的适合的随机任务生成信息段
function GetRandMissionLevel( character, sid, leveltp )
	if leveltp == MIS_LEVEL_CHAR then	    --角色随机任务等级类型
		local level = GetCharMissionLevel( character )
		if level == nil then
			return 10000
		end
		return level --1 + GetSection( level, 5 )
	elseif leveltp == MIS_LEVEL_GANG then	--公会随机任务等级类型
		local level = GetCharGangLevel( character )
		return level
	else
		MISSDK_MISSIONSDK_LUA_000385 = GetResString("MISSDK_MISSIONSDK_LUA_000385")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000385..sid )
		MISSDK_MISSIONSDK_LUA_000385 = GetResString("MISSDK_MISSIONSDK_LUA_000385")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000385..sid )
		return 10000
	end
	return 10000
end

--根据随机任务送物件库中随机生成一个物件，给玩家送到NPC处
function GetRandMissionSendItem( itemlist )
	PRINT( "GetRandMissionSendItem:itemlist = , itemlist.count = ", itemlist, itemlist.count )
	local id = Rand( itemlist.count ) + 1
	PRINT( "GetRandMissionSendItem:rand value = , item id = ", id, itemlist[id] )
	return itemlist[id]
end

--根据角色完成的随机任务次数随机产生一个高级物品，作为任务奖励
function GetRandMissionPrize( character, misname, id, loopinfo, loopdata )
	PRINT( "GetRandMissionPrize" )
	if loopinfo == nil or loopdata == nil or id == nil or misname == nil then
		PRINT( "GetRandMissionPrize: id = , loopdata = ", id, loopdata )
		MISSDK_MISSIONSDK_LUA_000386 = GetResString("MISSDK_MISSIONSDK_LUA_000386")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000386..id )
		MISSDK_MISSIONSDK_LUA_000387 = GetResString("MISSDK_MISSIONSDK_LUA_000387")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000387 )
		return 0, 0
	end
	
	local ret, loopnum = GetRandMissionNum( character, id )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000388 = GetResString("MISSDK_MISSIONSDK_LUA_000388")
		PRINT( MISSDK_MISSIONSDK_LUA_000388, id )
		MISSDK_MISSIONSDK_LUA_000388 = GetResString("MISSDK_MISSIONSDK_LUA_000388")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000388, id )
		MISSDK_MISSIONSDK_LUA_000388 = GetResString("MISSDK_MISSIONSDK_LUA_000388")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000388..id )
		--清除该角色该随机任务计数
		ResetRandMissionNum( character, id )
		return 0, 0
	else		
		loopnum = loopnum + 1 --转换为lua数组索引
		PRINT( "GetRandMissionPrize:GetRandMissionNum: return loopnum = ", loopnum )
		PRINT( "loopdata, loopdata", loopdata, loopdata[loopnum] )
		if loopinfo[loopnum] == nil or loopdata[loopnum] == nil or loopdata[loopnum].Prize == nil then
			MISSDK_MISSIONSDK_LUA_000389 = GetResString("MISSDK_MISSIONSDK_LUA_000389")
			PRINT( MISSDK_MISSIONSDK_LUA_000389, id, loopnum )
			MISSDK_MISSIONSDK_LUA_000390 = GetResString("MISSDK_MISSIONSDK_LUA_000390")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000390..id.." loopnum = "..loopnum )
			--清除该角色该随机任务计数
			ResetRandMissionNum( character, id )
			return 0, 0
		end
		
		local ret, miscount = GetRandMissionCount( character, id )
		miscount = miscount + 1
		MISSDK_MISSIONSDK_LUA_000391 = GetResString("MISSDK_MISSIONSDK_LUA_000391")
		MISSDK_MISSIONSDK_LUA_000392 = GetResString("MISSDK_MISSIONSDK_LUA_000392")
		MISSDK_MISSIONSDK_LUA_000393 = GetResString("MISSDK_MISSIONSDK_LUA_000393")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000393..misname..MISSDK_MISSIONSDK_LUA_000392..miscount..MISSDK_MISSIONSDK_LUA_000391 )
		
		PRINT( "GetRandMissionPrize:HasRandMissionCount, id = , num = ", loopinfo[loopnum].num )
		local ret = HasRandMissionCount( character, id, loopinfo[loopnum].num - 1 )
		if ret == LUA_TRUE then
			--清除该环任务计数，同时环计数增加
			--ret = AddRandMissionNum( character, id )
			--if ret ~= LUA_TRUE then
				--PRINT( "GetRandMissionPrizeItem:AddRandMissionNum重设任务环计数失败！id = ", id  )
				--LG( "randmission_error", "GetRandMissionPrizeItem:AddRandMissionNum重设任务环计数失败！id ", id )
				--SystemNotice( character, "GetRandMissionPrizeItem:AddRandMissionNum重设任务环计数失败！id = "..id )
				--return 0, 0
			--end
			
			PRINT( "GetRandMissionPrize:Prize", loopdata[loopnum].Prize )
			--角色不同段位作随机任务获得高级物品的几率将会随段位增加而下降
			local prizelist = loopdata[loopnum].Prize
			local value = Rand( 100 )
			PRINT( "GetRandMissionPrize: prize rand value = , odds = ", value, loopinfo[loopnum].odds )
			if value >= loopinfo[loopnum].odds then
				return 0, 0
			end
			
			if prizelist.tp == MIS_PRIZE_ITEM then
				--计算高级物品奖励随机率
				local randdata = 0
				for n = 1, prizelist.count, 1 do
					randdata = randdata + prizelist[n].p2
					PRINT( "GetRandMissionPrize: n = , randdata = , p2 = ", n, randdata, prizelist[n].p2 )
				end
				local prizevalue = Rand( randdata )
				local tempdata = 0
				for n = 1, prizelist.count, 1 do
					if prizevalue >= tempdata and prizevalue < tempdata + prizelist[n].p2 then
						PRINT( "GetRandMissionPrize: return n = , prizevalue = , prizetp = , p1 = ", n, prizevalue, prizelist[n].tp, prizelist[n].p1 )
						return prizelist[n].tp, prizelist[n].p1
					end
					tempdata = tempdata + prizelist[n].p2
				end
			else
				local index = Rand( prizelist.count ) + 1
				PRINT( "GetRandMissionPrize:prizetp = , p1 = , p2 = index = ", prizelist[index].tp, prizelist[index].p1, prizelist[index].p2, index )		
				if prizelist[index] == nil then
					MISSDK_MISSIONSDK_LUA_000394 = GetResString("MISSDK_MISSIONSDK_LUA_000394")
					SystemNotice( character, MISSDK_MISSIONSDK_LUA_000394..id.."prize index = "..index )
					MISSDK_MISSIONSDK_LUA_000394 = GetResString("MISSDK_MISSIONSDK_LUA_000394")
					LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000394..id.." prize index = "..index )
					return 0
				end
				
				--local charname = GetCharName( character )
				--local str = "GetRandMissionPrizeItem, 分配给了角色一个高等级随机任务装备！name = 《"
				--str = str..charname.."》 item id = "..prizelist[index].."misid = "..id.."loopnum = "..loopnum
				--LG( "randmission_info", str )
				
				PRINT( "GetRandMissionPrize: return prizetp = , p1 = ", prizelist[index].tp, prizelist[index].p1 )
				return prizelist[index].tp, prizelist[index].p1
			end
		end
	end
	
	PRINT( "GetRandMissionPrize: return 0" )
	return 0, 0
end

--判断该随机任务是否可以被该角色接受
function IsRandMissionAccept( character, mission )
	PRINT( "IsRandMissionAccept:character, mission", character, mission )
	if mission == nil or mission.tp ~= RAND_MISSION then
		MISSDK_MISSIONSDK_LUA_000395 = GetResString("MISSDK_MISSIONSDK_LUA_000395")
		PRINT( MISSDK_MISSIONSDK_LUA_000395 )
		MISSDK_MISSIONSDK_LUA_000395 = GetResString("MISSDK_MISSIONSDK_LUA_000395")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000395 )		
		return LUA_FALSE
	end
	
	--获取该角色随机任务数据段值
	local level = GetRandMissionLevel( character, mission.sid, mission.leveltp )
	PRINT( "IsRandMissionAccept:GetRandMissionLevel : level = ", level )
	if mission.RandInfo == nil or mission.RandInfo[level] == nil then
		PRINT( "IsRandMissionAccept: no level info and return false " )
		return LUA_FALSE
	end
	
	PRINT( "IsRandMissionAccept:GetRandMissionLevel : return true " )
	return LUA_TRUE
end
	
--测试计算随机任务公式
function GetRandMissionExp( loopnum, miscount, exp )
	--X*(350+Z*550)*0.0001*((10+Y*15)*0.001+INT(Y*0.1)*0.075)
	--x=总经验
	--y=小环数
	--z=大环数 
	
	if loopnum == nil or miscount == nil or exp == nil then
		MISSDK_MISSIONSDK_LUA_000396 = GetResString("MISSDK_MISSIONSDK_LUA_000396")
		PRINT( MISSDK_MISSIONSDK_LUA_000396, loopnum, miscount, exp )
		MISSDK_MISSIONSDK_LUA_000397 = GetResString("MISSDK_MISSIONSDK_LUA_000397")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000397 )
		return 0
	end
	
	local newexp=0
	
	local value = 0
	if miscount <= 30 then
		value = exp*((20 + miscount)*0.002 + ToDword(miscount*0.1)*0.05)
	
	elseif miscount > 30 and miscount <= 40 then
		value = exp*(0.25 + math.pow(miscount - 30,2)/400)

	elseif miscount > 40 and miscount <= 50 then
		value = exp*(0.5 + math.pow(miscount - 40,2)/200)
	
	end
	newexp = ToDword( value )
	PRINT( "GetRandMissionExp:newexp = ", newexp )
	--local value = exp*(350 + loopnum*550)*0.0001*((10 + miscount*15)*0.001 + (miscount*0.1)*0.075)
	
	if newexp == nil then
		return 0
	end
	PRINT( "GetRandMissionExp:loopnum, miscount, exp, newexp", loopnum, miscount, exp, newexp )
	return newexp
end

function GetRandMissionMoney( loopnum, miscount, money )
	if loopnum == nil or miscount == nil or money == nil then
		MISSDK_MISSIONSDK_LUA_000398 = GetResString("MISSDK_MISSIONSDK_LUA_000398")
		PRINT( MISSDK_MISSIONSDK_LUA_000398, loopnum, miscount, money )
		MISSDK_MISSIONSDK_LUA_000399 = GetResString("MISSDK_MISSIONSDK_LUA_000399")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000399 )
		return 0
	end
	
	--local value = money*(350 + loopnum*550)*0.0001*((10 + miscount*15)*0.001 + (miscount*0.1)*0.075)
	local value = money*((20 + miscount*5)*0.002 + ToDword(miscount*0.1)*0.05)
	local newmoney = ToDword( value )
	PRINT( "GetRandMissionExp:newmoney = ", newmoney )
	if newmoney == nil then
		return 0
	end
	
	return newmoney
end

--根据角色的信息生成一个随机任务
function CreateRandMission( character, npc, mission )
	PRINT( "CreateRandMission:character, npc, mission", character, npc, mission )
	if mission == nil or mission.tp ~= RAND_MISSION then
		MISSDK_MISSIONSDK_LUA_000400 = GetResString("MISSDK_MISSIONSDK_LUA_000400")
		PRINT( MISSDK_MISSIONSDK_LUA_000400 )
		MISSDK_MISSIONSDK_LUA_000400 = GetResString("MISSDK_MISSIONSDK_LUA_000400")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000400 )		
		return LUA_FALSE
	end
				
	--初始化全局随机任务参数
	InitRandParam()
	RandParam.id = mission.id
	RandParam.sid = mission.sid
	RandParam.bounty = mission.bounty
	RandParam.npcname = mission.npcname
	RandParam.npcarea  = mission.npcarea	
	PRINT( "CreateRandMission:RandParam.id = , RandParam.sid = ,  bounty = , name = , area = ", RandParam.id, RandParam.sid, RandParam.bounty, RandParam.npcname, RandParam.npcarea )
	
	--获取该角色随机任务数据段值
	RandParam.level = GetRandMissionLevel( character, mission.sid, mission.leveltp )
	PRINT( "CreateRandMission:RandParam.level =, mission.RandInfo =, mission.RandInfo[level] = ", RandParam.level, mission.RandInfo, mission.RandInfo[RandParam.level] )
	if mission.RandInfo == nil or mission.RandInfo[RandParam.level] == nil then
		MISSDK_MISSIONSDK_LUA_000401 = GetResString("MISSDK_MISSIONSDK_LUA_000401")
		PRINT( MISSDK_MISSIONSDK_LUA_000401..RandParam.level )
		local desp = GetCharName( npc )
		MISSDK_MISSIONSDK_LUA_000402 = GetResString("MISSDK_MISSIONSDK_LUA_000402")
		desp = desp..MISSDK_MISSIONSDK_LUA_000402
		HelpInfo( character, MIS_HELP_DESP, desp )
		return LUA_FALSE
	end
	
	PRINT( "CreateRandMission: rand type count = ", mission.RandInfo[RandParam.level].tpinfo.count )
	--随机一个任务类型
	--local tpinfoid = Rand( mission.RandInfo[RandParam.level].tpinfo.count ) + 1
	local tpinfoid = GetRandTpinfoIndex( mission.RandInfo[RandParam.level].tpinfo )
	
	PRINT( "CreateRandMission:Rand mission info, tpinfoid =, type = ", tpinfoid, mission.RandInfo[RandParam.level].tpinfo[tpinfoid].tp )
	if mission.RandInfo[RandParam.level].tpinfo[tpinfoid] == nil or mission.RandInfo[RandParam.level].tpinfo[tpinfoid].tp == nil then
		MISSDK_MISSIONSDK_LUA_000403 = GetResString("MISSDK_MISSIONSDK_LUA_000403")
		PRINT( MISSDK_MISSIONSDK_LUA_000403, RandParam.level, tpinfoid )
		MISSDK_MISSIONSDK_LUA_000404 = GetResString("MISSDK_MISSIONSDK_LUA_000404")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000404, RandParam.level, tpinfoid )
		MISSDK_MISSIONSDK_LUA_000404 = GetResString("MISSDK_MISSIONSDK_LUA_000404")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000404..RandParam.level..tpinfoid )
		return LUA_FALSE
	end
	
	--随机取一个任务数据
	RandParam.tp = mission.RandInfo[RandParam.level].tpinfo[tpinfoid].tp
	local tpindex = GetRandMissionTypeIndex( mission, RandParam.tp )
	PRINT( "CreateRandMission:tpindex = ", tpindex )
	if tpindex == 0 then
		LG( "randmission_error", "CreateRandMission:GetRandMissionTypeIndex:id, tp, level, exp, money, item, numdata", RandParam.id, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
		MISSDK_MISSIONSDK_LUA_000405 = GetResString("MISSDK_MISSIONSDK_LUA_000405")
		PRINT( MISSDK_MISSIONSDK_LUA_000405 )
		MISSDK_MISSIONSDK_LUA_000405 = GetResString("MISSDK_MISSIONSDK_LUA_000405")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000405 )
		return LUA_FALSE
	end
	
	local randnum = mission.missionlist[tpindex].randnum
	if randnum == nil or randnum < 1 or randnum > 4 then
		MISSDK_MISSIONSDK_LUA_000406 = GetResString("MISSDK_MISSIONSDK_LUA_000406")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000406..randnum )
		MISSDK_MISSIONSDK_LUA_000406 = GetResString("MISSDK_MISSIONSDK_LUA_000406")
		PRINT( MISSDK_MISSIONSDK_LUA_000406..randnum )
		MISSDK_MISSIONSDK_LUA_000406 = GetResString("MISSDK_MISSIONSDK_LUA_000406")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000406..randnum )
		return LUA_FALSE
	end
	PRINT( "CreateRandMission:randnum = , val = ", mission.missionlist[tpindex].randnum, randnum )
	
	--获取随机任务的计数
	local ret, miscount = GetRandMissionCount( character, mission.id )
	--if miscount == 0 then
		--miscount = 1
	--end
	miscount = miscount + 1
	
	local ret, misloopnum = GetRandMissionNum( character, mission.id )
	--if misloopnum == 0 then
		--misloopnum = 1
	--end
	misloopnum = misloopnum + 1
	
	--X*(350+Z*550)*0.0001*((10+Y*15)*0.001+INT(Y*0.1)*0.075)
	--x=总经验
	--y=小环数
	--z=大环数 

	if RandParam.tp == MIS_RAND_KILL then					--猎杀怪物
		--随机最大4个怪物类型
		RandParam.numdata = Rand( randnum ) + 1
		PRINT( "CreateRandMission:rand numdata = ", RandParam.numdata )
		if RandParam.numdata > mission.RandInfo[RandParam.level].KillInfo.count then
			RandParam.numdata = mission.RandInfo[RandParam.level].KillInfo.count
		end
		PRINT( "CreateRandMission:rand numdata = ", RandParam.numdata )
		if RandParam.numdata <= 0 then
			MISSDK_MISSIONSDK_LUA_000407 = GetResString("MISSDK_MISSIONSDK_LUA_000407")
			PRINT( MISSDK_MISSIONSDK_LUA_000407, RandParam.level )
			MISSDK_MISSIONSDK_LUA_000407 = GetResString("MISSDK_MISSIONSDK_LUA_000407")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000407..RandParam.level )
			return LUA_FALSE
		end
		
		for n = 1, RandParam.numdata, 1 do
			local flag = 1
			local infoid = Rand( mission.RandInfo[RandParam.level].KillInfo.count ) + 1
			PRINT( "CreateRandMission:rand infoid = ", infoid )
			--检查是否有重复的数据索引信息
			for i = 1, n - 1, 1 do
				if RandParam.data[i].id == infoid then
					PRINT( "CreateRandMission:3" )
					n = n - 1
					flag = 0
					break
				end
				PRINT( "CreateRandMission:2" )
			end
			PRINT( "CreateRandMission:4" )
			if flag == 1 then
				--保存数据
				PRINT( "CreateRandMission:5" )
				RandParam.data[n].id = infoid
				RandParam.data[n].p1 = mission.RandInfo[RandParam.level].KillInfo[infoid].p1
				RandParam.data[n].p2 = mission.RandInfo[RandParam.level].KillInfo[infoid].p2 + Rand(mission.RandInfo[RandParam.level].KillInfo[infoid].p3)
				PRINT( "CreateRandMission:6" )
				RandParam.data[n].p3 = 0
				RandParam.data[n].p4 = 0
				RandParam.data[n].p5 = 0
				RandParam.data[n].p6 = 0
				RandParam.data[n].p7 = 0
				RandParam.data[n].p8 = 0
				--RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].KillInfo[infoid].p4 * RandParam.data[n].p2 )
				RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].KillInfo[infoid].p4 )
				PRINT( "CreateRandMission:7" )
				--RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].KillInfo[infoid].p5 * RandParam.data[n].p2 )
				RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].KillInfo[infoid].p5 )
				PRINT( "CreateRandMission:rand data info: id, p1, p2, p3, p4", RandParam.data[n].id, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4 )
			end
		end
		
	elseif RandParam.tp == MIS_RAND_GET then			--获取物品
		--随机最大4个怪物类型
		RandParam.numdata = Rand( randnum ) + 1
		if RandParam.numdata > mission.RandInfo[RandParam.level].GetInfo.count then
			RandParam.numdata = mission.RandInfo[RandParam.level].GetInfo.count
		end
		if RandParam.numdata <= 0 then
			MISSDK_MISSIONSDK_LUA_000408 = GetResString("MISSDK_MISSIONSDK_LUA_000408")
			PRINT( MISSDK_MISSIONSDK_LUA_000408, RandParam.level )
			MISSDK_MISSIONSDK_LUA_000408 = GetResString("MISSDK_MISSIONSDK_LUA_000408")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000408..RandParam.level )
			return LUA_FALSE
		end
		
		for n = 1, RandParam.numdata, 1 do
			local flag = 1
			local infoid = Rand( mission.RandInfo[RandParam.level].GetInfo.count ) + 1
			PRINT( "CreateRandMission:rand infoid = ", infoid )
			--检查是否有重复的数据索引信息
			for i = 1, n - 1, 1 do
				if RandParam.data[i].id == infoid then
					n = n - 1
					flag = 0
					break
				end
			end
			
			if flag == 1 then
			--保存数据
				RandParam.data[n].id = infoid
				RandParam.data[n].p1 = mission.RandInfo[RandParam.level].GetInfo[infoid].p1
				RandParam.data[n].p2 = mission.RandInfo[RandParam.level].GetInfo[infoid].p2 + Rand(mission.RandInfo[RandParam.level].GetInfo[infoid].p3)
				RandParam.data[n].p3 = 0
				RandParam.data[n].p4 = 0
				RandParam.data[n].p5 = 0
				RandParam.data[n].p6 = 0
				RandParam.data[n].p7 = 0
				RandParam.data[n].p8 = 0
				--RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].GetInfo[infoid].p4 * RandParam.data[n].p2 )
				RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].GetInfo[infoid].p4 )
				--RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].GetInfo[infoid].p5 * RandParam.data[n].p2 )
				RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].GetInfo[infoid].p5 )
				PRINT( "CreateRandMission:rand data info: id, p1, p2, p3, p4", RandParam.data[n].id, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4 )
			end
		end
		
	elseif RandParam.tp == MIS_RAND_SEND then			--送给物品
		--随机选择一定类型数量的NPC
		PRINT( "Rand send" )
		local npcinfoid = nil --GetNpcInfoID( npc ) --获取当前NPC的infoid，避免有自己发信自己收信的情况出现
		RandParam.numdata = Rand( randnum ) + 1
		PRINT( "CreateRandMission1: numdata = , randnum = , RandParam.level = , infocount = , itemcount = ", RandParam.numdata, randnum, RandParam.level, mission.RandInfo[RandParam.level].SendInfo.count, mission.RandInfo[RandParam.level].SendItem.count )
		if RandParam.numdata > mission.RandInfo[RandParam.level].SendInfo.count then
			RandParam.numdata = mission.RandInfo[RandParam.level].SendInfo.count
		end
		if RandParam.numdata > mission.RandInfo[RandParam.level].SendItem.count then
			RandParam.numdata = mission.RandInfo[RandParam.level].SendItem.count
		end
		if RandParam.numdata <= 0 then
			MISSDK_MISSIONSDK_LUA_000409 = GetResString("MISSDK_MISSIONSDK_LUA_000409")
			PRINT( MISSDK_MISSIONSDK_LUA_000409, RandParam.level )
			MISSDK_MISSIONSDK_LUA_000409 = GetResString("MISSDK_MISSIONSDK_LUA_000409")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000409..RandParam.level )
			return LUA_FALSE
		end
		
		PRINT( "CreateRandMission2: numdata = , randnum = ", RandParam.numdata, randnum )
		for n = 1, RandParam.numdata, 1 do
			local flag = 1
			local infoid = Rand( mission.RandInfo[RandParam.level].SendInfo.count ) + 1
			local itemid = GetRandMissionSendItem( mission.RandInfo[RandParam.level].SendItem )
			PRINT( "CreateRandMission:rand infoid = , itemid = ", infoid, itemid )
			--检查是否有重复的数据索引信息
			if mission.RandInfo[RandParam.level].SendInfo[infoid].p1 == npcinfoid then
				n = n - 1
				flag = 0
			else
				for i = 1, n - 1, 1 do
					if RandParam.data[i].id == infoid or RandParam.data[i].p2 == itemid then
						PRINT( "CreateRandMission:send item ,rand value repeat" )
						n = n - 1
						flag = 0
						break
					end
				end
			end
			
			if flag == 1 then
				--保存数据
				RandParam.data[n].id = infoid
				RandParam.data[n].p1 = mission.RandInfo[RandParam.level].SendInfo[infoid].p1 --npc info id
				RandParam.data[n].p2 = itemid --item id
				RandParam.data[n].p3 = mission.RandInfo[RandParam.level].SendInfo[infoid].p2 --area id
				RandParam.data[n].p4 = 0
				RandParam.data[n].p5 = 0
				RandParam.data[n].p6 = 0
				RandParam.data[n].p7 = 0
				RandParam.data[n].p8 = 0
				RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].SendInfo[infoid].p4 )
				RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].SendInfo[infoid].p5 )
				PRINT( "CreateRandMission:rand data info: id, p1, p2, p3, p4", RandParam.data[n].id, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4 )
			end
		end
		
	elseif RandParam.tp == MIS_RAND_CONVOY then		--护送NPC
		PRINT( "Convoy npc" )
		--随机选择一个护送NPC目标		
		RandParam.numdata = 1 --护送任务暂时只支持护送一个NPC，但是程序支持护送多个NPC
		if RandParam.numdata > mission.RandInfo[RandParam.level].ConvoyInfo.count then
			RandParam.numdata = mission.RandInfo[RandParam.level].ConvoyInfo.count
		end
		if RandParam.numdata <= 0 then
			MISSDK_MISSIONSDK_LUA_000410 = GetResString("MISSDK_MISSIONSDK_LUA_000410")
			PRINT( MISSDK_MISSIONSDK_LUA_000410, RandParam.level )
			MISSDK_MISSIONSDK_LUA_000410 = GetResString("MISSDK_MISSIONSDK_LUA_000410")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000410..RandParam.level )
			return LUA_FALSE
		end
		
		for n = 1, RandParam.numdata, 1 do
			local flag = 1
			local infoid = Rand( mission.RandInfo[RandParam.level].ConvoyInfo.count ) + 1
			--检查是否有重复的数据索引信息
			for i = 1, n - 1, 1 do
				if RandParam.data[i].id == infoid then
					PRINT( "CreateRandMission:convoy npc ,rand value repeat" )
					n = n - 1
					flag = 0
					break
				end
			end
			
			if flag == 1 then
				--保存数据
				RandParam.data[n].id = infoid
				RandParam.data[n].p1 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p1 --char info id
				RandParam.data[n].p2 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p2 --map id
				RandParam.data[n].p3 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p3 --areaid
				RandParam.data[n].p4 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p4 --x
				RandParam.data[n].p5 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p5 --y
				RandParam.data[n].p6 = mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p6 --scope
				RandParam.data[n].p7 = 0
				RandParam.data[n].p8 = 0
				RandParam.exp = GetRandMissionExp( misloopnum, miscount, RandParam.exp + mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p7 )
				RandParam.money = GetRandMissionMoney( misloopnum, miscount, RandParam.money + mission.RandInfo[RandParam.level].ConvoyInfo[infoid].p8 )
				PRINT( "CreateRandMission:rand data info: id, p1, p2, p3, p4, p5, p6", RandParam.data[n].id, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4, RandParam.data[n].p5, RandParam.data[n].p6 )
			end
		end
		
	elseif RandParam.tp == MIS_RAND_EXPLORE then		--探索地图
		
	else
		MISSDK_MISSIONSDK_LUA_000411 = GetResString("MISSDK_MISSIONSDK_LUA_000411")
		PRINT( MISSDK_MISSIONSDK_LUA_000411..RandParam.tp )
		MISSDK_MISSIONSDK_LUA_000411 = GetResString("MISSDK_MISSIONSDK_LUA_000411")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000411..RandParam.tp )
		MISSDK_MISSIONSDK_LUA_000411 = GetResString("MISSDK_MISSIONSDK_LUA_000411")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000411..RandParam.tp )
		return LUA_FALSE
	end
	
	PRINT( "CreateRandMission: name, id, level, loopinfo, loopdata", mission.name, RandParam.id, mission.loopinfo, mission.RandInfo[RandParam.level].LoopData )
	RandParam.prizetp, RandParam.prizedata = GetRandMissionPrize( character, mission.name, RandParam.id, mission.loopinfo, mission.RandInfo[RandParam.level].LoopData )

	--设置随机任务的经验类型
	if mission.missionlist[tpindex].exptp == nil then
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[tpindex].exptp ) 
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		PRINT( MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[tpindex].exptp )
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[tpindex].exptp )
		return LUA_FALSE
	end
	RandParam.exptp = mission.missionlist[tpindex].exptp
	PRINT( "CreateRandMission:exptp = ", RandParam.exptp )
	
	--根据参数生成随机任务信息
	local ret = RandMission( mission.missionlist[tpindex], RandParam )
	if ret ~= LUA_TRUE then
		LG( "randmission_error", "CreateRandMission:RandMission:id, sid, tp, level, exp, money, item, numdata", RandParam.id, RandParam.sid, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
		MISSDK_MISSIONSDK_LUA_000413 = GetResString("MISSDK_MISSIONSDK_LUA_000413")
		PRINT( MISSDK_MISSIONSDK_LUA_000413 )
		MISSDK_MISSIONSDK_LUA_000413 = GetResString("MISSDK_MISSIONSDK_LUA_000413")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000413 )
		return LUA_FALSE
	end
	
	--检测随机任务背包需求
	MISSDK_MISSIONSDK_LUA_000414 = GetResString("MISSDK_MISSIONSDK_LUA_000414")
	PRINT( MISSDK_MISSIONSDK_LUA_000414, mission.missionlist[tpindex].begin.baggrid )
	local numgrid = mission.missionlist[tpindex].begin.baggrid
	local ret = HasLeaveBagGrid( character, numgrid )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000415 = GetResString("MISSDK_MISSIONSDK_LUA_000415")
		PRINT( MISSDK_MISSIONSDK_LUA_000415, numgrid )
		MISSDK_MISSIONSDK_LUA_000085 = GetResString("MISSDK_MISSIONSDK_LUA_000085")
		MISSDK_MISSIONSDK_LUA_000086 = GetResString("MISSDK_MISSIONSDK_LUA_000086")
		BickerNotice( character, MISSDK_MISSIONSDK_LUA_000086..numgrid..MISSDK_MISSIONSDK_LUA_000085 )
		return LUA_FALSE, 0
	end
		
	--存储生成的数据到角色中	
	PRINT( "CreateRandMission:AddRandMission:id, sid, tp, level, exp, money, prizedata, prizetp, numdata", RandParam.id, RandParam.sid, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
	local ret = AddRandMission( character, RandParam.id, RandParam.sid, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
	if ret ~= LUA_TRUE then 
		LG( "randmission_error", "AddRandMission:id, sid, tp, level, exp, money, prizedata, prizetp, numdata", RandParam.id, RandParam.sid, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
		MISSDK_MISSIONSDK_LUA_000416 = GetResString("MISSDK_MISSIONSDK_LUA_000416")
		PRINT( MISSDK_MISSIONSDK_LUA_000416 )
		MISSDK_MISSIONSDK_LUA_000416 = GetResString("MISSDK_MISSIONSDK_LUA_000416")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000416 )
		return LUA_FALSE
	end
	
	for n = 1, RandParam.numdata, 1 do
		PRINT( "CreateRandMission:SetRandMissionData:id, index, p1, p2, p3, p4, p5, p6", RandParam.id, n - 1, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4, RandParam.data[n].p5, RandParam.data[n].p6 )
		ret = SetRandMissionData( character, RandParam.id, n - 1, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4, RandParam.data[n].p5, RandParam.data[n].p6 )
		if ret ~= LUA_TRUE then
			MISSDK_MISSIONSDK_LUA_000417 = GetResString("MISSDK_MISSIONSDK_LUA_000417")
			PRINT( MISSDK_MISSIONSDK_LUA_000417, n )
			MISSDK_MISSIONSDK_LUA_000418 = GetResString("MISSDK_MISSIONSDK_LUA_000418")
			SystemNotice( character, MISSDK_MISSIONSDK_LUA_000418..n )
			return LUA_FALSE
		end
	end
	MISSDK_MISSIONSDK_LUA_000419 = GetResString("MISSDK_MISSIONSDK_LUA_000419")
	local str = MISSDK_MISSIONSDK_LUA_000419
	local name = GetCharName( npc )
	MISSDK_MISSIONSDK_LUA_000420 = GetResString("MISSDK_MISSIONSDK_LUA_000420")
	str = str..name..MISSDK_MISSIONSDK_LUA_000420
	SystemNotice( character, str )
	
	return LUA_TRUE, tpindex
end

--获取随机任务的匹配类型索引
function GetRandMissionTypeIndex( mission, tp )
	if mission == nil or tp == nil then
		MISSDK_MISSIONSDK_LUA_000421 = GetResString("MISSDK_MISSIONSDK_LUA_000421")
		PRINT( MISSDK_MISSIONSDK_LUA_000421 )
		MISSDK_MISSIONSDK_LUA_000421 = GetResString("MISSDK_MISSIONSDK_LUA_000421")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000421 )
		return 0
	end
	PRINT( "GetRandMissionTypeIndex:mission, tp, mission.missionlist.count", mission, tp, mission.missionlist.count )
	for i = 1, mission.missionlist.count, 1 do
		PRINT( "GetRandMissionTypeIndex,mission.missionlist[i].tp = ", mission.missionlist[i].tp )
		if tp == mission.missionlist[i].tp then
			return i
		end
	end
	
	return 0
end

--获取随机任务信息随机数
function GetRandTpinfoIndex( tpinfo )
	local randdata = 0
	for n = 1, tpinfo.count, 1 do					
		randdata = randdata + tpinfo[n].tprand
		PRINT( "GetRandTpinfoIndex: n = , randdata = , tprand = ", n, randdata, tpinfo[n].tprand )
	end
	local randvalue = Rand( randdata )
	local tempdata = 0
	for n = 1, tpinfo.count, 1 do
		if randvalue >= tempdata and randvalue < tempdata + tpinfo[n].tprand then
			PRINT( "GetRandTpinfoIndex: return n = , tprandvalue = , tprand = ", n, randvalue, tpinfo[n].tprand )
			return n
		end
		tempdata = tempdata + tpinfo[n].tprand
	end
	return 0
end

--根据角色的保存的随机生成任务配置信息重构任务
function GetCharRandMission( character, id, mission )
	PRINT( "GetRandMission:character", character )
	
	--判断角色是否有随机任务配置信息
	if HasRandMission( character, id ) ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000422 = GetResString("MISSDK_MISSIONSDK_LUA_000422")
		PRINT( MISSDK_MISSIONSDK_LUA_000422..id )
		MISSDK_MISSIONSDK_LUA_000423 = GetResString("MISSDK_MISSIONSDK_LUA_000423")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000423..id )
		return LUA_TRUE, 0
	end
	
	--初始化全局随机任务参数
	InitRandParam()
	
	--获取角色的随机任务配置信息
	PRINT( "GetCharRandMission:GetRandMission, id = ", id  )
	local ret
	RandParam.id = id
	RandParam.bounty = mission.bounty
	RandParam.npcname = mission.npcname
	RandParam.npcarea  = mission.npcarea	
	PRINT( "CreateRandMission:RandParam.id = , RandParam.sid = ,  bounty = , name = , area = ", RandParam.id, RandParam.sid, RandParam.bounty, RandParam.npcname, RandParam.npcarea )
	
	ret, RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata = GetRandMission( character, id )
	if ret ~= LUA_TRUE then
		PRINT( "GetCharRandMission:GetRandMission error." )
		SystemNotice( character, "GetCharRandMission:GetRandMission error." )
		return LUA_FALSE
	end
	PRINT( "GetCharRandMission:tp, level, exp, money, prizedata, prizetp, numdata",  RandParam.tp, RandParam.level, RandParam.exp, RandParam.money, RandParam.prizedata, RandParam.prizetp, RandParam.numdata )
	--获取配置信息列表
	for n = 1, RandParam.numdata, 1 do
		ret, RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4, RandParam.data[n].p5, RandParam.data[n].p6 = GetRandMissionData( character, id, n - 1 )
		PRINT( "GetRandMissionData: p1, p2, p3, p4, p5, p6 ", RandParam.data[n].p1, RandParam.data[n].p2, RandParam.data[n].p3, RandParam.data[n].p4, RandParam.data[n].p5, RandParam.data[n].p6 )
		if ret ~= LUA_TRUE then
			PRINT( "GetCharRandMission:GetRandMissionData error." )
			SystemNotice( character, "GetCharRandMission:GetRandMissionData error." )
			return LUA_FALSE
		end
	end
	
	local index = GetRandMissionTypeIndex( mission, RandParam.tp )
	PRINT( "GetCharRandMission:GetRandMissionTypeIndex index = ", index )
	if index == 0  then
		MISSDK_MISSIONSDK_LUA_000424 = GetResString("MISSDK_MISSIONSDK_LUA_000424")
		PRINT( MISSDK_MISSIONSDK_LUA_000424 )
		MISSDK_MISSIONSDK_LUA_000424 = GetResString("MISSDK_MISSIONSDK_LUA_000424")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000424 )
		return LUA_FALSE
	end

	--设置随机任务的经验类型
	if mission.missionlist[index].exptp == nil then
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		LG( "randmission_error", MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[index].exptp ) 
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		PRINT( MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[index].exptp )
		MISSDK_MISSIONSDK_LUA_000412 = GetResString("MISSDK_MISSIONSDK_LUA_000412")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000412, mission.missionlist[index].exptp )
		return LUA_FALSE
	end
	RandParam.exptp = mission.missionlist[index].exptp
	PRINT( "CreateRandMission:exptp = ", RandParam.exptp )
	
	local ret = RandMission( mission.missionlist[index], RandParam )
	if ret ~= LUA_TRUE then
		MISSDK_MISSIONSDK_LUA_000425 = GetResString("MISSDK_MISSIONSDK_LUA_000425")
		PRINT( MISSDK_MISSIONSDK_LUA_000425 )
		MISSDK_MISSIONSDK_LUA_000425 = GetResString("MISSDK_MISSIONSDK_LUA_000425")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000425 )
		return LUA_FALSE
	end
	
	PRINT( "GetRandMission: return true, index = ", index )
	return LUA_TRUE, index, mission.RandInfo[RandParam.level].LoopData
end

--随机生成一个任务
function RandMission( mission, param )
	PRINT( "RandMission" )
	if mission == nil or param == nil or param.tp ~= mission.tp then
		PRINT( "RandMission:mission = nil or param = nil or param.tp ~= mission.tp" )
		return LUA_FALSE
	end
	
	--初始化角色任务背包容量需求
	mission.begin.baggrid = 0
	mission.result.baggrid = 0
	
	PRINT( "RandMission, mission.tp = , param.tp", mission.tp, param.tp )	
	--根据随机任务的类型和参数生成一个新任务
	if mission.tp == MIS_RAND_KILL then				--摧毁物件
		--猎杀的怪物类型数量
		local num = 0
		mission.begin.actions.count = param.numdata
		mission.result.conditions.count = param.numdata
		mission.need.count = param.numdata + 1
		MISSDK_MISSIONSDK_LUA_000426 = GetResString("MISSDK_MISSIONSDK_LUA_000426")
		MISSDK_MISSIONSDK_LUA_000427 = GetResString("MISSDK_MISSIONSDK_LUA_000427")
		mission.need[1].p1 = "  <b"..param.npcarea..MISSDK_MISSIONSDK_LUA_000427..param.npcname..MISSDK_MISSIONSDK_LUA_000426

		--mission.begin.talk = "<t>嗨，朋友。有兴趣挣个小钱吗？我这里刚好有个捕猎任务，只要捕到"
		--mission.result.help = "<t>嗨，朋友，你要时刻记得答应我的事情哦，只要捕到"
		
		PRINT( mission.begin.talkstart, mission.result.talkstart, mission.result.helpstart )
		PRINT( mission.begin.talkend, mission.result.talkend, mission.result.helpend )
		mission.begin.talk = mission.begin.talkstart
		mission.result.talk = mission.result.talkstart
		mission.result.help = mission.result.helpstart
		PRINT( "RandMission,1" )
		for n = 1, param.numdata, 1 do
			--更新任务需求
			mission.need[n+1].p1 = param.data[n].p1 	--怪物类型ID
			mission.need[n+1].p2 = param.data[n].p2 	--怪物数量
			mission.need[n+1].p3 = num						--开始记录标签位置
			
			--更新任务开始触发器动作信息(AddTrigger)
			mission.begin.actions[n].p3 = param.data[n].p1 --怪物类型ID
			mission.begin.actions[n].p4 = param.data[n].p2 --怪物数量
			mission.begin.actions[n].p5 = num --开始记录标签位置
			mission.begin.actions[n].p6 = 0
			
			--更新任务完成条件信息
			num = num + param.data[n].p2
			mission.result.conditions[n].p2 = num - 1 --杀死怪物触发器记录的标记
			
			--任务开始描述信息
			PRINT( "RandMission, 2" )
		    local monstername = GetMonsterName( param.data[n].p1 )
			PRINT( "RandMission, 3, count, talk, need[count].p2, monstername", n, mission.begin.talk, mission.need[n].p2, monstername )			
			local nummonster = 0
			if mission.need[n+1].p2 ~= nil then
				nummonster = mission.need[n+1].p2
			end
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000429 = GetResString("MISSDK_MISSIONSDK_LUA_000429")
			mission.begin.talk = mission.begin.talk.."<r"..nummonster..MISSDK_MISSIONSDK_LUA_000429..monstername..MISSDK_MISSIONSDK_LUA_000428
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000429 = GetResString("MISSDK_MISSIONSDK_LUA_000429")
			mission.result.help = mission.result.help.."<r"..nummonster..MISSDK_MISSIONSDK_LUA_000429..monstername..MISSDK_MISSIONSDK_LUA_000428
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000429 = GetResString("MISSDK_MISSIONSDK_LUA_000429")
			mission.need[1].p1 = mission.need[1].p1.."<r"..nummonster..MISSDK_MISSIONSDK_LUA_000429..monstername..MISSDK_MISSIONSDK_LUA_000428
			if n < param.numdata then
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.begin.talk = mission.begin.talk..MISSDK_MISSIONSDK_LUA_000430
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.result.help = mission.result.help..MISSDK_MISSIONSDK_LUA_000430
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.need[1].p1 = mission.need[1].p1..MISSDK_MISSIONSDK_LUA_000430
			end
		end

		--任务结束动作(AddExpAndType)	
		mission.result.actions[2].p1 = param.exptp
		mission.result.actions[2].p2 = param.exp
		mission.result.actions[2].p3 = param.exp
		PRINT( "RandMission:AddExpAndType, exp = ", mission.result.actions[2].p1 )
		
		--任务描述信息
		--mission.begin.talk = mission.begin.talk.."。"
		--mission.result.talk = "<t>嗯，看起来你蛮具备赏金猎人的能力的嘛，喏，这是给你奖励，希望我们下次再合作。"
		--mission.result.help = mission.result.help.."。"

		mission.begin.talk = mission.begin.talk..mission.begin.talkend
		mission.result.talk = mission.result.talk..mission.result.talkend
		mission.result.help = mission.result.help..mission.result.helpend
		CALCULATE_FORGE_LUA_000290 = GetResString("CALCULATE_FORGE_LUA_000290")
		mission.need[1].p1 = mission.need[1].p1..CALCULATE_FORGE_LUA_000290
		
		PRINT( "RandMission,4 " )
		--随机任务奖励
		mission.prize[1].p1 = param.money
		if param.prizedata ~= 0 then
			PRINT( "RandMission,5, prizetp, prizedata", param.prizetp, param.prizedata )
			mission.prize[2].tp = param.prizetp
			mission.prize[2].p1 = param.prizedata
			mission.prize.count = 2
			if param.prizetp == MIS_PRIZE_ITEM then
				mission.prize[2].p2 = 1
				mission.prize[2].p3 = param.bounty
				mission.result.baggrid = 1
			elseif param.prizetp == MIS_PRIZE_CESS then
				mission.prize[2].p2 = 0
			elseif param.prizetp == MIS_PRIZE_FAME then
				mission.prize[2].p2 = 0
			else
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				PRINT( MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				LG( "mission_error", MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				mission.prize[2].tp = 0
				mission.prize[2].p1 = 0
				mission.prize.count = 1
			end
		else
			PRINT( "RandMission,6" )
			mission.prize.count = 1
		end
		PRINT( "RandMission,7" )
	elseif mission.tp == MIS_RAND_GET then		--获取物品
		--获取的物品类型数量
		PRINT( "RandMission:tp = MIS_RAND_GET:param.numdata = ", param.numdata ) 
		local num = 0
		mission.begin.actions.count = param.numdata
		mission.result.conditions.count = param.numdata * 2
		mission.result.actions.count = 2 + param.numdata
		mission.need.count = param.numdata + 1
		MISSDK_MISSIONSDK_LUA_000432 = GetResString("MISSDK_MISSIONSDK_LUA_000432")
		MISSDK_MISSIONSDK_LUA_000427 = GetResString("MISSDK_MISSIONSDK_LUA_000427")
		mission.need[1].p1 = "  <b"..param.npcarea..MISSDK_MISSIONSDK_LUA_000427..param.npcname..MISSDK_MISSIONSDK_LUA_000432
		MISSDK_MISSIONSDK_LUA_000433 = GetResString("MISSDK_MISSIONSDK_LUA_000433")
		mission.need[1].p1 = mission.need[1].p1..param.numdata..MISSDK_MISSIONSDK_LUA_000433
		
		--mission.begin.talk = "<t>你好，朋友。我这里急需"
		--mission.begin.talk = mission.begin.talk.."<r"..param.numdata..">样东西，请你帮我收集到："
		--mission.result.help = "hmm，你有帮我收集我要的东西么？你不会忘记了吧？我需要"
		--mission.result.help = mission.result.help.."<r"..param.numdata..">样东西，"
		PRINT( mission.begin.talkstart, mission.result.talkstart, mission.result.helpstart )
		PRINT( mission.begin.talkend, mission.result.talkend, mission.result.helpend )
		mission.begin.talk = mission.begin.talkstart
		mission.result.talk = mission.result.talkstart
		mission.result.help = mission.result.helpstart
		
		for n = 1, param.numdata, 1 do
			--更新任务需求
			mission.need[n+1].p1 = param.data[n].p1   	--物品类型ID
			mission.need[n+1].p2 = param.data[n].p2 	--物品数量
			mission.need[n+1].p3 = num						--开始记录标签位置
			
			--更新任务开始触发器动作信息(AddTrigger)
			mission.begin.actions[n].p3 = param.data[n].p1	 --物品类型ID
			mission.begin.actions[n].p4 = param.data[n].p2  --物品数量
			mission.begin.actions[n].p5 = num --开始记录标签位置
			mission.begin.actions[n].p6 = 0
			
			--任务结束动作(TakeItem)
			mission.result.actions[n+2].p1 = param.data[n].p1
			mission.result.actions[n+2].p2 = param.data[n].p2
			PRINT( "RandMission:TakeItem, item = , num = ", mission.result.actions[n+2].p1, mission.result.actions[n+2].p2 )
			
			--更新任务完成条件信息
			num = num + param.data[n].p2
			--设置HasFlag 函数参数
			mission.result.conditions[1 + (n - 1)*2].p2 = num - 1 --获取物品触发器记录的标记
			--设置HasItem 函数参数
			mission.result.conditions[2 + (n - 1)*2].p1 = param.data[n].p1 --获取物品类型ID
			mission.result.conditions[2 + (n - 1)*2].p2 = param.data[n].p2 --获取物品数量
			
			--任务开始描述信息
			local itemname = GetItemName( param.data[n].p1 )
			CALCULATE_FORGE_LUA_000190 = GetResString("CALCULATE_FORGE_LUA_000190")
			mission.begin.talk = mission.begin.talk..mission.need[n+1].p2..CALCULATE_FORGE_LUA_000190..itemname
			CALCULATE_FORGE_LUA_000190 = GetResString("CALCULATE_FORGE_LUA_000190")
			mission.result.help = mission.result.help..mission.need[n+1].p2..CALCULATE_FORGE_LUA_000190..itemname
			CALCULATE_FORGE_LUA_000190 = GetResString("CALCULATE_FORGE_LUA_000190")
			mission.need[1].p1 = mission.need[1].p1..mission.need[n+1].p2..CALCULATE_FORGE_LUA_000190..itemname
			if n < param.numdata then
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.begin.talk = mission.begin.talk..MISSDK_MISSIONSDK_LUA_000430
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.result.help = mission.result.help..MISSDK_MISSIONSDK_LUA_000430
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.need[1].p1 = mission.need[1].p1..MISSDK_MISSIONSDK_LUA_000430
			end
		end
		
		--任务结束动作(AddExpAndType)	
		mission.result.actions[2].p1 = param.exptp
		mission.result.actions[2].p2 = param.exp
		mission.result.actions[2].p3 = param.exp
		PRINT( "RandMission:AddExpAndType, exp = ", mission.result.actions[2].p1 )
		
		--任务描述信息
		--mission.begin.talk = mission.begin.talk.."。"
		--mission.result.help = mission.begin.talk.."记好了，少一个都不行！"
		--mission.result.talk = "<t>啊哈，幸好有你帮忙，这次我的收藏品更加丰富了，这是给你的奖励，如果你有兴趣再来找我。"
		CALCULATE_FORGE_LUA_000290 = GetResString("CALCULATE_FORGE_LUA_000290")
		mission.need[1].p1 = mission.need[1].p1..CALCULATE_FORGE_LUA_000290

		mission.begin.talk = mission.begin.talk..mission.begin.talkend
		mission.result.talk = mission.result.talk..mission.result.talkend
		mission.result.help = mission.result.help..mission.result.helpend
		
		--随机任务奖励
		mission.prize[1].p1 = param.money
		if param.prizedata ~= 0 then
			PRINT( "RandMission,5, prizetp, prizedata", param.prizetp, param.prizedata )
			mission.prize[2].tp = param.prizetp
			mission.prize[2].p1 = param.prizedata
			mission.prize.count = 2
			if param.prizetp == MIS_PRIZE_ITEM then
				mission.prize[2].p2 = 1
				mission.prize[2].p3 = param.bounty
				mission.result.baggrid = 1
			elseif param.prizetp == MIS_PRIZE_CESS then
				mission.prize[2].p2 = 0
			elseif param.prizetp == MIS_PRIZE_FAME then
				mission.prize[2].p2 = 0
			else
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				PRINT( MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				LG( "mission_error", MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				mission.prize[2].tp = 0
				mission.prize[2].p1 = 0
				mission.prize.count = 1
			end
		else
			PRINT( "RandMission,6" )
			mission.prize.count = 1
		end
		
	elseif mission.tp == MIS_RAND_SEND then			--送物品
		--送的物品类型数量
		local num = 0
		mission.begin.actions.count = param.numdata
		mission.result.conditions.count = param.numdata
		mission.need.count = param.numdata + 1 --需要以后添加新的任务目标类型
		MISSDK_MISSIONSDK_LUA_000434 = GetResString("MISSDK_MISSIONSDK_LUA_000434")
		MISSDK_MISSIONSDK_LUA_000427 = GetResString("MISSDK_MISSIONSDK_LUA_000427")
		mission.need[1].p1 = "  <b"..param.npcarea..MISSDK_MISSIONSDK_LUA_000427..param.npcname..MISSDK_MISSIONSDK_LUA_000434

		--mission.begin.talk = "<t>你好，朋友。我这里有"
		--mission.begin.talk = mission.begin.talk.."<r"..param.numdata..">样东西，请把"
		--mission.result.help = "<t>嗨，朋友，我托你送的"
		--mission.result.help = mission.result.help.."<r"..param.numdata..">样东西都送到了没有哦？把"
				
		PRINT( mission.begin.talkstart, mission.result.talkstart, mission.result.helpstart )
		PRINT( mission.begin.talkend, mission.result.talkend, mission.result.helpend )
		mission.begin.talk = mission.begin.talkstart
		mission.result.talk = mission.result.talkstart
		mission.result.help = mission.result.helpstart
		
		for n = 1, param.numdata, 1 do
			--更新任务开始触发器动作信息(GiveItem)
			mission.begin.actions[n].p1 = param.data[n].p2	 --物品ID
			mission.begin.actions[n].p2 = 1
			PRINT( "RandMission: GiveItem item = , count = ", mission.begin.actions[n].p2, 1 )
			
			--更新任务完成条件信息(HasRandItemFlag)
			mission.result.conditions[n].p2 = param.data[n].p1 --检测是否有NPC收到物件的标记
			
			--任务开始描述信息
			local npcname = GetNpcName( param.data[n].p1 )
			PRINT( "RandMission, npcname = ", npcname )
			local areaname = GetAreaName( param.data[n].p3 )
			PRINT( "RandMission, areaname = ", areaname )
			local itemname = GetItemName( param.data[n].p2 )
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000435 = GetResString("MISSDK_MISSIONSDK_LUA_000435")
			MISSDK_MISSIONSDK_LUA_000436 = GetResString("MISSDK_MISSIONSDK_LUA_000436")
			MISSDK_MISSIONSDK_LUA_000437 = GetResString("MISSDK_MISSIONSDK_LUA_000437")
			mission.begin.talk = mission.begin.talk..MISSDK_MISSIONSDK_LUA_000437..itemname..MISSDK_MISSIONSDK_LUA_000436..areaname..MISSDK_MISSIONSDK_LUA_000435..npcname..MISSDK_MISSIONSDK_LUA_000428
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000435 = GetResString("MISSDK_MISSIONSDK_LUA_000435")
			MISSDK_MISSIONSDK_LUA_000436 = GetResString("MISSDK_MISSIONSDK_LUA_000436")
			MISSDK_MISSIONSDK_LUA_000437 = GetResString("MISSDK_MISSIONSDK_LUA_000437")
			mission.result.help = mission.result.help..MISSDK_MISSIONSDK_LUA_000437..itemname..MISSDK_MISSIONSDK_LUA_000436..areaname..MISSDK_MISSIONSDK_LUA_000435..npcname..MISSDK_MISSIONSDK_LUA_000428
			if n < param.numdata then				
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.begin.talk = mission.begin.talk..MISSDK_MISSIONSDK_LUA_000430
				MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
				mission.result.help = mission.result.help..MISSDK_MISSIONSDK_LUA_000430
			end
			PRINT( "RandMission, talk = ", mission.begin.talk )
			
			--更新任务需求
			MISSDK_MISSIONSDK_LUA_000428 = GetResString("MISSDK_MISSIONSDK_LUA_000428")
			MISSDK_MISSIONSDK_LUA_000435 = GetResString("MISSDK_MISSIONSDK_LUA_000435")
			MISSDK_MISSIONSDK_LUA_000438 = GetResString("MISSDK_MISSIONSDK_LUA_000438")
			MISSDK_MISSIONSDK_LUA_000439 = GetResString("MISSDK_MISSIONSDK_LUA_000439")
			mission.need[n+1].p1 = n..MISSDK_MISSIONSDK_LUA_000439..itemname..MISSDK_MISSIONSDK_LUA_000438..areaname..MISSDK_MISSIONSDK_LUA_000435..npcname..MISSDK_MISSIONSDK_LUA_000428   --任务目标			
			PRINT( "RandMission: need.p1 = ", mission.need[n+1].p1 )
		end
		
		--任务结束动作(AddExpAndType)	
		mission.result.actions[2].p1 = param.exptp
		mission.result.actions[2].p2 = param.exp
		mission.result.actions[2].p3 = param.exp
		PRINT( "RandMission:AddExpAndType, exp = ", mission.result.actions[2].p1 )		
		
		--任务描述信息
		mission.begin.baggrid = param.numdata
		--mission.begin.talk = mission.begin.talk.."。"		
		--mission.result.help = mission.result.help.."。"
		--mission.result.talk = "<t>哇，你的速度好快嘛，就已经把东西送到了哦，谢谢你朋友，这是你的劳动所得，下次有空再来哦。"
		
		mission.begin.talk = mission.begin.talk..mission.begin.talkend
		mission.result.talk = mission.result.talk..mission.result.talkend
		mission.result.help = mission.result.help..mission.result.helpend
		
		--随机任务奖励
		mission.prize[1].p1 = param.money
		if param.prizedata ~= 0 then
			PRINT( "RandMission,5, prizetp, prizedata", param.prizetp, param.prizedata )
			mission.prize[2].tp = param.prizetp
			mission.prize[2].p1 = param.prizedata
			mission.prize.count = 2
			if param.prizetp == MIS_PRIZE_ITEM then
				mission.prize[2].p2 = 1
				mission.prize[2].p3 = param.bounty
				mission.result.baggrid = 1
			elseif param.prizetp == MIS_PRIZE_CESS then
				mission.prize[2].p2 = 0
			elseif param.prizetp == MIS_PRIZE_FAME then
				mission.prize[2].p2 = 0
			else
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				PRINT( MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				LG( "mission_error", MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				mission.prize[2].tp = 0
				mission.prize[2].p1 = 0
				mission.prize.count = 1
			end
		else
			PRINT( "RandMission,6" )
			mission.prize.count = 1
		end
		
	elseif mission.tp == MIS_RAND_CONVOY then		--护送NPC
		--护送的NPC
		local num = 0
		mission.begin.actions.count = 1 + param.numdata*2
		mission.result.conditions.count = param.numdata
		mission.need.count = param.numdata + 1 --需要以后添加新的任务目标类型
		MISSDK_MISSIONSDK_LUA_000440 = GetResString("MISSDK_MISSIONSDK_LUA_000440")
		MISSDK_MISSIONSDK_LUA_000427 = GetResString("MISSDK_MISSIONSDK_LUA_000427")
		mission.need[1].p1 = "  <b"..param.npcarea..MISSDK_MISSIONSDK_LUA_000427..param.npcname..MISSDK_MISSIONSDK_LUA_000440
		
		--mission.begin.talk = "<t>你好，朋友。你愿意"
		
		PRINT( mission.begin.talkstart, mission.result.talkstart, mission.result.helpstart )
		PRINT( mission.begin.talkend, mission.result.talkend, mission.result.helpend )		
		mission.begin.talk = mission.begin.talkstart
		mission.result.talk = mission.result.talkstart
		mission.result.help = mission.result.helpstart
		
		for n = 1, param.numdata, 1 do
			--更新任务开始触发器动作信息(AddTrigger)
			mission.begin.actions[2 + (n - 1)*2].p3 = param.data[n].p2	 --map ID
			mission.begin.actions[2 + (n - 1)*2].p4 = param.data[n].p4  --x
			mission.begin.actions[2 + (n - 1)*2].p5 = param.data[n].p5  --y
			mission.begin.actions[2 + (n - 1)*2].p6 = param.data[n].p6  --scope
			
			--ConvoyNpc
			mission.begin.actions[3 + (n - 1)*2].p2 = n - 1	 --convoy index npc
			mission.begin.actions[3 + (n - 1)*2].p3 = param.data[n].p1	 -- charid
			
			PRINT( "RandMission: Convoy npcid =  to map = , x = , y = , scope = ", mission.begin.actions[3 + (n - 1)*2].p3, mission.begin.actions[2 + (n - 1)*2].p3, mission.begin.actions[2 + (n - 1)*2].p4, mission.begin.actions[2 + (n - 1)*2].p5, mission.begin.actions[2 + (n - 1)*2].p6 )

			--更新任务完成条件信息(HasFlag)
			
			--任务开始描述信息
			local npcname = GetMonsterName( param.data[n].p1 ) --charinfo name
			PRINT( "RandMission, npcname = ", npcname )
			local areaname = GetAreaName( param.data[n].p3 )
			PRINT( "RandMission, areaname = ", areaname )
			
			MISSDK_MISSIONSDK_LUA_000441 = GetResString("MISSDK_MISSIONSDK_LUA_000441")
			MISSDK_MISSIONSDK_LUA_000430 = GetResString("MISSDK_MISSIONSDK_LUA_000430")
			MISSDK_MISSIONSDK_LUA_000442 = GetResString("MISSDK_MISSIONSDK_LUA_000442")
			MISSDK_MISSIONSDK_LUA_000443 = GetResString("MISSDK_MISSIONSDK_LUA_000443")
			MISSDK_MISSIONSDK_LUA_000444 = GetResString("MISSDK_MISSIONSDK_LUA_000444")
			mission.begin.talk = mission.begin.talk..MISSDK_MISSIONSDK_LUA_000444..npcname..MISSDK_MISSIONSDK_LUA_000443..areaname..MISSDK_MISSIONSDK_LUA_000442..param.data[n].p4..MISSDK_MISSIONSDK_LUA_000430..param.data[n].p5..MISSDK_MISSIONSDK_LUA_000441
			PRINT( "RandMission, talk = ", mission.begin.talk )
			
			--更新任务需求
			MISSDK_MISSIONSDK_LUA_000443 = GetResString("MISSDK_MISSIONSDK_LUA_000443")
			MISSDK_MISSIONSDK_LUA_000445 = GetResString("MISSDK_MISSIONSDK_LUA_000445")
			mission.need[n+1].p1 = n..MISSDK_MISSIONSDK_LUA_000445..npcname..MISSDK_MISSIONSDK_LUA_000443..areaname..">"   --任务目标
			PRINT( "RandMission: need.p1 = ", mission.need[n+1].p1 )
		end

		--任务结束动作(AddExpAndType)	
		mission.result.actions[2].p1 = param.exptp
		mission.result.actions[2].p2 = param.exp
		mission.result.actions[2].p3 = param.exp
		PRINT( "RandMission:AddExpAndType, exp = ", mission.result.actions[2].p1 )
		
		--任务描述信息
		--mission.begin.talk = mission.begin.talk.."你要在<r一个小时>以内办妥这件事。"
		--mission.result.talk = mission.begin.talk
		--mission.result.help = mission.begin.talk
		
		mission.begin.talk = mission.begin.talk..mission.begin.talkend
		mission.result.talk = mission.result.talk..mission.result.talkend
		mission.result.help = mission.result.help..mission.result.helpend
		
		--随机任务奖励
		mission.prize[1].p1 = param.money
		if param.prizedata ~= 0 then
			PRINT( "RandMission,5, prizetp, prizedata", param.prizetp, param.prizedata )
			mission.prize[2].tp = param.prizetp
			mission.prize[2].p1 = param.prizedata
			mission.prize.count = 2
			if param.prizetp == MIS_PRIZE_ITEM then
				mission.prize[2].p2 = 1
				mission.prize[2].p3 = param.bounty
				mission.result.baggrid = 1
			elseif param.prizetp == MIS_PRIZE_CESS then
				mission.prize[2].p2 = 0
			elseif param.prizetp == MIS_PRIZE_FAME then
				mission.prize[2].p2 = 0
			else
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				PRINT( MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				MISSDK_MISSIONSDK_LUA_000431 = GetResString("MISSDK_MISSIONSDK_LUA_000431")
				LG( "mission_error", MISSDK_MISSIONSDK_LUA_000431, param.id, param.prizetp, param.prizedata )
				mission.prize[2].tp = 0
				mission.prize[2].p1 = 0
				mission.prize.count = 1
			end
		else
			PRINT( "RandMission,6" )
			mission.prize.count = 1
		end
		
	elseif mission.tp == MIS_RAND_EXPLORE then		--探索地图
		
	end
	
	return LUA_TRUE
end

------------给予0能量的女神雕像
function GiveNSDX ( character , npc , value )
	local r1=0
	local r2=0
	r1,r2 =MakeItem ( character , value , 1 , 4 )
	local Item_NSDX = GetChaItem2 ( character , 2 , r2 )
	local NUM_NOW = 0
	local Item_NSDX_NOW = GetChaItem2 ( character , 2 , 3010 )
	SetItemAttr( Item_NSDX_NOW , ITEMATTR_ENERGY , NUM_NOW )
	RefreshCha( character )
end

-----------判断女神雕像能量是否达到999
function CheckEnergy ( character )
	local NSDX_Num = CheckBagItem( character, 3010 )
	---SystemNotice(character,""..HHS_Num)
	if NSDX_Num ~= 1 then
		return 0
	end
	local role_NSDX = GetChaItem2 ( character , 2 , 3010 )	
	local attr_energy = GetItemAttr ( role_NSDX, ITEMATTR_ENERGY)
	if attr_energy ~= 999 then
		return LUA_FALSE
	end

	return LUA_TRUE
end

-----------------------判断角色没有转生经验
function HasNOZSExp ( character )
	local attr_zsexp = GetChaAttr ( character , ATTR_CSAILEXP )
	if attr_zsexp == 0 then
		return LUA_TRUE
	end

	return LUA_FALSE
end

------------------------判断身上没有某种道具
function HasNoItem( character ,value )
	local item_number = CheckBagItem( character, value )			
	if item_number >= 1 then
		return LUA_FALSE
	end
	return LUA_TRUE
end
function AddChaItem7(character)        
	------------取升级考卷的指针
	local r1=0
	local r2=0
	r1,r2 =MakeItem ( character , 3280  , 1 , 4 )
	local Item_new = GetChaItem ( character , 2 , r2 )

	----------记录时间
	local now_yes = os.date("%y")		-------------年
	local now_month= os.date("%m")		-------------月
	local now_day= os.date("%d")		-------------日
	local now_hour= os.date("%H")		-------------时
	local now_miniute= os.date("%M")	-------------分
	local now_scend=  os.date("%S")		-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     
	SetItemAttr(Item_new, ITEMATTR_VAL_STA, now_month )		-------------月 	
	SetItemAttr(Item_new, ITEMATTR_VAL_STR, now_day )		-------------日  
	SetItemAttr(Item_new, ITEMATTR_VAL_CON, now_hour )		-------------时   
	SetItemAttr(Item_new, ITEMATTR_VAL_DEX, now_miniute )		-------------分   
	SetItemAttr(Item_new, ITEMATTR_VAL_AGI, now_scend )		-------------秒 
	SynChaKitbag(character,13)
	return LUA_TRUE
end

function CheckKJNum ( character )
	local num_kj=CheckBagItem( character , 3280 )
	if num_kj == 1 then
		return LUA_TRUE
	end
end	
function AddChaItem8(character)
	------------取升级考卷的指针
	local role_kj=GetChaItem2( character , 2 , 3280 )
	----------记录时间
	local now_yes = os.date("%y")			-------------年
	local now_month= os.date("%m")			-------------月
	local now_day= os.date("%d")			-------------日
	local now_hour= os.date("%H")			-------------时
	local now_miniute= os.date("%M")		-------------分
	local now_scend=  os.date("%S")			-------------秒
	now_yes = tonumber(now_yes)			-------------年     
	now_month= tonumber(now_month)		-------------月     
	now_day= tonumber(now_day)			-------------日     
	now_hour= tonumber(now_hour)			-------------时     
	now_miniute= tonumber(now_miniute)	 	-------------分     
	now_scend= tonumber(now_scend)		-------------秒     

	---------取升级考卷的时间	
	local old_month = GetItemAttr(role_kj, ITEMATTR_VAL_STA)		-------------月 	
	local old_day = GetItemAttr(role_kj, ITEMATTR_VAL_STR)			-------------日  
	local old_hour = GetItemAttr(role_kj, ITEMATTR_VAL_CON)			-------------时   
	local old_miniute = GetItemAttr(role_kj, ITEMATTR_VAL_DEX)		-------------分   
	local old_scend = GetItemAttr(role_kj, ITEMATTR_VAL_AGI)			-------------秒 
	---------删除升级考卷
	local del_item =TakeItem( character, 0,3280, 1 )			                   
	if del_item==0  then
		MISSDK_MISSIONSDK_LUA_000446 = GetResString("MISSDK_MISSIONSDK_LUA_000446")
		SystemNotice ( character ,MISSDK_MISSIONSDK_LUA_000446)
	end

	local used_time=(now_scend - old_scend)+(now_miniute - old_miniute)*60+(now_hour - old_hour)*3600+(now_day - old_day)*86400+(JNSTime_Flag[now_month] - JNSTime_Flag[old_month] )*86400
	------------取升级成绩单的指针
	local r1=0
	local r2=0
	r1,r2 =MakeItem ( character , 3281  , 1 , 4 )
	local Item_new = GetChaItem ( character , 2 , r2 )
	SetItemAttr(Item_new, ITEMATTR_VAL_AGI, used_time )		-------------秒  
	SynChaKitbag(character,13)
	return LUA_TRUE
end


----------测验判断成绩单时间               
function checkcytime( character , npc )
	local role_xsz = GetChaItem2 ( character , 2 , 3289 )
	local exp_xsz = GetItemAttr ( role_xsz , ITEMATTR_ENERGY )		-----取学生证当前经验
	local mexp_xsz = GetItemAttr ( role_xsz , ITEMATTR_MAXENERGY )		-----取学生证最大经验
	local newexp_xsz = exp_xsz * 1000
	local ch_xsz = GetItemAttr ( role_xsz , ITEMATTR_URE )		-----取学生证当前学分
	local mch_xsz = GetItemAttr ( role_xsz, ITEMATTR_MAXURE )	-----取学生证最大学分
	local role_cjd = GetChaItem2 ( character , 2 , 3279 )
	local cha_name = GetChaDefaultName ( character )
	local newch_xsz = ch_xsz + math.floor(50*(exp_xsz/mexp_xsz))
	if newch_xsz <= mch_xsz then
		MISSDK_MISSIONSDK_LUA_000447 = GetResString("MISSDK_MISSIONSDK_LUA_000447")
		SystemNotice ( character , MISSDK_MISSIONSDK_LUA_000447)
		SetItemAttr ( role_xsz , ITEMATTR_URE , newch_xsz )	------设置学生证新的学分
		AddExp ( character , npc , newexp_xsz , newexp_xsz )
		SetItemAttr ( role_xsz, ITEMATTR_ENERGY, 0 )
		RefreshCha( character )
	else
		MISSDK_MISSIONSDK_LUA_000448 = GetResString("MISSDK_MISSIONSDK_LUA_000448")
		SystemNotice( character , MISSDK_MISSIONSDK_LUA_000448)
		AddExp ( character , npc, newexp_xsz , newexp_xsz )
		SetItemAttr ( role_xsz , ITEMATTR_URE , mch_xsz )	------设置学生证新的学分
		SetItemAttr ( role_xsz, ITEMATTR_ENERGY, 0 )
		RefreshCha( character )
	end
	local del_item =TakeItem( character, 0,3279, 1 )
	if del_item == 0 then
		MISSDK_MISSIONSDK_LUA_000449 = GetResString("MISSDK_MISSIONSDK_LUA_000449")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000449)
	end
	return LUA_TRUE
end

----------升级考试判断成绩单时间
function checksjtime( character ,npc )
	local role_xsz = GetChaItem2 ( character , 2 , 3289 )
	local lv_ch = GetItemAttr ( role_xsz , ITEMATTR_FORGE )		----取学生证当前学历
	local role_cjd = GetChaItem2 ( character , 2 , 3281 )
	local time_cjd = GetItemAttr ( role_cjd , ITEMATTR_VAL_AGI )
	local cha_name = GetChaDefaultName ( character )
	if time_cjd > 0 and time_cjd <= 1800 then
		MISSDK_MISSIONSDK_LUA_000450 = GetResString("MISSDK_MISSIONSDK_LUA_000450")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		LG(CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000450)
		lv_ch = lv_ch + 1
		SetItemAttr( role_xsz , ITEMATTR_FORGE , lv_ch )	----设置学生证新的学历
		SetItemAttr( role_xsz , ITEMATTR_URE , 0 )		----学分清零
		local new_mch = Reading_Credit[lv_ch]
		local new_mexp = Reading_EXP[lv_ch]
		SetItemAttr( role_xsz , ITEMATTR_MAXURE , new_mch )	----设置学生证新的最大学分
		SetItemAttr( role_xsz , ITEMATTR_MAXENERGY , new_mexp )	----设置学生证新的最大经验
		RefreshCha( character )
	elseif time_cjd > 1800 then
		MISSDK_MISSIONSDK_LUA_000451 = GetResString("MISSDK_MISSIONSDK_LUA_000451")
		CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
		LG(CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name..MISSDK_MISSIONSDK_LUA_000451)
	end
	local del_item =TakeItem( character, 0,3281, 1 )
	if del_item == 0 then
		MISSDK_MISSIONSDK_LUA_000452 = GetResString("MISSDK_MISSIONSDK_LUA_000452")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000452)
	end
	return LUA_TRUE
end
------------------addexp经验瓶处理包壳
--function AddExp2 ( role , npc, p1, p2 )
--	local lv = GetChaAttr(role, ATTR_LV)
--	if lv == 100 then
--		local i = CheckBagItem ( role, 171 )
--		if i == 1 then
--			local role_jyp = GetChaItem2 ( role, 2, 171)
--			local exp_store = GetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1 )
--			local exp_add = (p1+p2)/2
--			exp_store = exp_store+exp_add
--			SetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1, exp_store)
--			SystemNotice( role, "你的经验瓶中的积分增加了"..exp_add)
--		else
--			AddExp ( role , npc , p1 , p2 )
--		end
--	else
--		AddExp ( role , npc , p1 , p2 )
--	end
--	return LUA_TRUE
--end

function HasXmasYB ( role, value )				-------------判断是否有足够硬币
	local num_wyyb = CheckBagItem( role, 2962 )
	local num_bwyb = CheckBagItem( role, 2963 )
	local money = num_wyyb + num_bwyb * 100
	if money >= value then
		return LUA_TRUE
	end
end

function TakeXmasYB ( role, value )				-------------提取硬币
	local num_bwyb = math.floor( value/100 )
	local num_wyyb = math.fmod ( value , 100 )
	local bag_bwyb = CheckBagItem( role, 2963 )
	local bag_wyyb = CheckBagItem( role, 2962 )
	if bag_wyyb < num_wyyb then
		num_bwyb = num_bwyb +1
		zhaoling = num_bwyb * 100 - value
		num_wyyb = 0
		GiveItem ( role , 0, 2962, zhaoling, 4)
	elseif bag_bwyb < num_bwyb then
		num_bwyb = bag_bwyb
		num_wyyb = value - ( num_bwyb * 100 )
	end
	if num_wyyb ~= 0 then
		local ret1 = TakeItem ( role, 0, 2962, num_wyyb)
	end
	if num_bwyb ~= 0 then
		local ret2 = TakeItem ( role, 0, 2963, num_bwyb)
	end
	return LUA_TRUE
end

function CpHuojiNum ( role )					-----------------计算被杀火鸡数量
	XmasMonsterNum1 = XmasMonsterNum1 + 100
	XmasMonsterNum4 = XmasMonsterNum4 + 100
	XmasMonsterNum5 = XmasMonsterNum5 + 100
	return LUA_TRUE
end

function CpMiluNum ( role )					------------------计算被杀麋鹿数量			
	XmasMonsterNum2 = XmasMonsterNum2 + 100
	XmasMonsterNum4 = XmasMonsterNum4 + 100
	XmasMonsterNum5 = XmasMonsterNum5 + 100
	return LUA_TRUE
end

function CpXuerenNum ( role )					------------------计算被杀雪人数量
	XmasMonsterNum3 = XmasMonsterNum3 + 100
	XmasMonsterNum5 = XmasMonsterNum5 + 100
	return LUA_TRUE
end

function XmasNotice ( role, value )				------------------圣诞村自动提示
	local cha_name = GetChaDefaultName ( role ) 
	local message={}
	MISSDK_MISSIONSDK_LUA_000453 = GetResString("MISSDK_MISSIONSDK_LUA_000453")
	MISSDK_MISSIONSDK_LUA_000454 = GetResString("MISSDK_MISSIONSDK_LUA_000454")
	message[1]=MISSDK_MISSIONSDK_LUA_000454..cha_name..MISSDK_MISSIONSDK_LUA_000453
	MISSDK_MISSIONSDK_LUA_000455 = GetResString("MISSDK_MISSIONSDK_LUA_000455")
	MISSDK_MISSIONSDK_LUA_000456 = GetResString("MISSDK_MISSIONSDK_LUA_000456")
	message[2]=MISSDK_MISSIONSDK_LUA_000456..cha_name..MISSDK_MISSIONSDK_LUA_000455
	MISSDK_MISSIONSDK_LUA_000457 = GetResString("MISSDK_MISSIONSDK_LUA_000457")
	MISSDK_MISSIONSDK_LUA_000458 = GetResString("MISSDK_MISSIONSDK_LUA_000458")
	message[3]=MISSDK_MISSIONSDK_LUA_000458..cha_name..MISSDK_MISSIONSDK_LUA_000457
	MISSDK_MISSIONSDK_LUA_000459 = GetResString("MISSDK_MISSIONSDK_LUA_000459")
	MISSDK_MISSIONSDK_LUA_000460 = GetResString("MISSDK_MISSIONSDK_LUA_000460")
	message[4]=MISSDK_MISSIONSDK_LUA_000460..cha_name..MISSDK_MISSIONSDK_LUA_000459
	SystemNotice( role , message[value] )
	return LUA_TRUE
end



--发送一个NPC任务给角色
function GiveNpcMission( character, id, name, npcmissionid )
	if id == nil or Mission[id] == nil then
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		PRINT( MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000143..id )
		return LUA_FALSE
	end
	
	local npc = GetNpc(character, name)
	--local ret, npc = GetEudemon()
	--SystemNotice( character, name )
	local npcid = GetCharID( npc )
	--SystemNotice( character, "npcid"..npcid )
	PRINT( "GiveMission: npcid, id, mistp", npcid, id, Mission[id].tp )
	--ret = SetMissionTempInfo( character, npcid, id, MIS_ACCEPT, Mission[id].tp )
	ret = SetMissionTempInfo( character, npcid, npcmissionid, MIS_ACCEPT, Mission[id].tp )
	if ret ~= LUA_TRUE then 
		MISSDK_MISSIONSDK_LUA_000121 = GetResString("MISSDK_MISSIONSDK_LUA_000121")
		PRINT( MISSDK_MISSIONSDK_LUA_000121 )
		MISSDK_MISSIONSDK_LUA_000122 = GetResString("MISSDK_MISSIONSDK_LUA_000122")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000122 )
		return LUA_FALSE
	end
	
	SendAcceptPage( character, npcid, Mission[id], Mission[id].id )
	return LUA_TRUE
end

--------------------------------------日常任务**海港指挥的聚会
function AddItem_Mission1 ( Role )
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000087
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission1 ( Role )								
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000087
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**生化危机
function AddItem_Mission2 ( Role )
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000093")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000093
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission2 ( Role )								
	MISSCRIPT_MISSIONSCRIPT06_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000093")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000093
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**维尔傀儡娃娃
function AddItem_Mission3 ( Role )
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000137")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000137
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission3 ( Role )								
	MISSCRIPT_MISSIONSCRIPT06_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000137")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000137
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**卡拉傀儡娃娃
function AddItem_Mission4 ( Role )
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000142")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000142
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission4 ( Role )								
	MISSCRIPT_MISSIONSCRIPT06_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000142")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000142
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**黑龙情报员
function AddItem_Mission5 ( Role )
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000146")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000146
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission5 ( Role )								
	MISSCRIPT_MISSIONSCRIPT06_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000146")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT06_LUA_000146
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**废灵日常任务
function AddItem_Mission6 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001596 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001596")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001596
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	
	--SystemNotice(Role,"Index"..Index)
	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	--SystemNotice(Role,"完成废灵日常，来个标记")
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission6 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001596 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001596")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001596
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end


--------------------------------------日常任务**沼泽日常任务
function AddItem_Mission7 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001600 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001600")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001600
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission7 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001600 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001600")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001600
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end


--------------------------------------日常任务**小圣战日常任务
function AddItem_Mission8 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001603 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001603")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001603
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission8 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001603 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001603")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001603
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end

--------------------------------------日常任务**大圣战日常任务
function AddItem_Mission9 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001606 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001606")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001606
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission9 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001606 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001606")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001606
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end


--------------------------------------日常任务**魔方日常任务
function AddItem_Mission10 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001609 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001609")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001609
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission10 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001609 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001609")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001609
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end


--------------------------------------日常任务**地狱日常任务
function AddItem_Mission11 ( Role )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001612 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001612")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001612
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
		return LUA_FALSE
	end
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	MISSDK_MISSIONSDK_LUA_000461 = GetResString("MISSDK_MISSIONSDK_LUA_000461")
	SystemNotice(Role,MISSDK_MISSIONSDK_LUA_000461)
	return LUA_TRUE
end

function  Get_Day_Mission11 ( Role )								
	MISSCRIPT_MISSIONSCRIPT07_LUA_001612 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001612")
	local Event_Name = MISSCRIPT_MISSIONSCRIPT07_LUA_001612
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()

	if Index == 0 then			--没找到该角色信息

		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息

		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了

			return LUA_FALSE

		end
	end
	
	return LUA_TRUE
end
--------------------------------------zhangliang--------------------------万圣节真正的危机------------
function AddItem_Mission12 ( Role )
	
	local Event_Name = "万圣节真正的危机"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	SystemNotice(Role,"该任务已完成，不过明天还可以继续接哦~")
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission12 ( Role )								
	local Event_Name = "万圣节真正的危机"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end
-----------------------------------------zhangliang--------------------------万圣节真正的危机------------------------------------

--------------------------------------zhangliang--------------------------偷吃鸡的狐狸------------
function AddItem_Mission13 ( Role )
	
	local Event_Name = "偷吃鸡的狐狸"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	SystemNotice(Role,"该任务已完成，不过明天还可以继续接哦~")
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission13 ( Role )								
	local Event_Name = "偷吃鸡的狐狸"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end
-----------------------------------------zhangliang--------------------------偷吃鸡的狐狸------------------------------------

--------------------------------------zhangliang--------------------------抓捕王小虎------------
function AddItem_Mission14 ( Role )
	
	local Event_Name = "Capture the fearsome Wang Xiao Hu"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--从取一次INDEX
	if Index == 0 then			--没找到该角色信息
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息	
		Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )
	end
	SystemNotice(Role,"The quest has been completed. You can receive a new one tomorrow")
	Player_Can_Do[Index].Value.Has_Record = true			--标识为已完成
	return LUA_TRUE
end

function  Get_Day_Mission14 ( Role )								
	local Event_Name = "Capture the fearsome Wang Xiao Hu"
	local Index = Get_Index_By_Event_And_PlayerName( Event_Name , Role )		--找寻角色档案
	local Has_Record = false
	local Do_Day = Day_Mission_Time()
	if Index == 0 then			--没找到该角色信息
		--SystemNotice (Role , "Index =======  0 ")
		Add_Player_Event_Value( Event_Name , Role , Do_Day , Has_Record )		--添加一个角色信息
		return LUA_TRUE
	end
	if Index ~= 0 then 															--找到了角色信息
		if Player_Can_Do[ Index ].Value.Has_Record ==true then			--但是已经完成过了
			-- SystemNotice(Role , "2222222222222222")
			return LUA_FALSE
		-- elseif Player_Can_Do[ Index ].Value.Has_Record ==true and Player_Can_Do[ Index ].Value.Do_Day < Do_Day then
			-- SystemNotice (Role , "TMMD")
			-- table.remove (Event_Name,Index)
			-- Get_Day_Mission1(Role)
			-- return LUA_TRUE
		end
	end
	
	return LUA_TRUE
end
-----------------------------------------zhangliang--------------------------抓捕王小虎------------------------------------



function AddExp_10persent ( role)	------------------添加10%经验
--	SystemNotice( role , "value1="..value1.."value2="..value2.."type="..type)
	local exp_now = GetChaAttr ( role, ATTR_CEXP )
	--SystemNotice(role,"exp_now"..exp_now)
	local lv = GetChaAttr ( role , ATTR_LV )
	local lv_next = lv + 1
	local exp_up = GetExp[lv_next] - GetExp[lv]
	--SystemNotice(role,"exp_up"..exp_up)
	local exp_add = math.floor( exp_up * 0.1 )
	if exp_add >= GetExp[lv_next] - exp_now then
		exp_add = GetExp[lv_next] - exp_now
	end	
	exp_new = exp_now + exp_add
	SetChaAttrI( role , ATTR_CEXP , exp_new )
	RefreshCha( role )
	--SystemNotice(role,"exp_new"..exp_new)
	return LUA_TRUE

end

function AddExp_5persent ( role)	------------------添加5%经验
--	SystemNotice( role , "value1="..value1.."value2="..value2.."type="..type)
	local exp_now = GetChaAttr ( role, ATTR_CEXP )
	local lv = GetChaAttr ( role , ATTR_LV )
	local lv_next = lv + 1
	local exp_up = GetExp[lv_next] - GetExp[lv]
	local exp_add = math.floor( exp_up * 0.05 )
	if exp_add >= GetExp[lv_next] - exp_now then
		exp_add = GetExp[lv_next] - exp_now
	end	
	exp_new = exp_now + exp_add
	SetChaAttrI( role , ATTR_CEXP , exp_new )
	RefreshCha( role )
	return LUA_TRUE
end

function AddExp_3persent ( role)	------------------添加3%经验
--	SystemNotice( role , "value1="..value1.."value2="..value2.."type="..type)
	local exp_now = GetChaAttr ( role, ATTR_CEXP )
	local lv = GetChaAttr ( role , ATTR_LV )
	local lv_next = lv + 1
	local exp_up = GetExp[lv_next] - GetExp[lv]
	local exp_add = math.floor( exp_up * 0.03 )
	if exp_add >= GetExp[lv_next] - exp_now then
		exp_add = GetExp[lv_next] - exp_now
	end	
	exp_new = exp_now + exp_add
	SetChaAttrI( role , ATTR_CEXP , exp_new )
	RefreshCha( role )
	return LUA_TRUE
end

function AddExp_05persent ( role)	------------------添加0.5%经验
--	SystemNotice( role , "value1="..value1.."value2="..value2.."type="..type)
	local exp_now = GetChaAttr ( role, ATTR_CEXP )
	local lv = GetChaAttr ( role , ATTR_LV )
	local lv_next = lv + 1
	local exp_up = GetExp[lv_next] - GetExp[lv]
	local exp_add = math.floor( exp_up * 0.005 )
	if exp_add >= GetExp[lv_next] - exp_now then
		exp_add = GetExp[lv_next] - exp_now
	end	
	exp_new = exp_now + exp_add
	SetChaAttrI( role , ATTR_CEXP , exp_new )
	RefreshCha( role )
	return LUA_TRUE
end

function Check_KSS ( role )
	local cha_type = GetChaTypeID ( role )
	if cha_type == 2 then
		return LUA_TRUE
	else
		return LUA_FALSE
	end
end 
function CanChargeQiByOne(role)
	local item = GetChaItem(role ,2 ,0 )
	local bagNum = GetChaFreeBagGridNum ( role )
	if ValidCha(item)== 0 then 
		MISSDK_MISSIONSDK_LUA_000477 = GetResString("MISSDK_MISSIONSDK_LUA_000477")
		return MISSDK_MISSIONSDK_LUA_000477
	end
	local itemID = GetItemID(item)
	if itemID >6553 or  itemID< 6542 then
		MISSDK_MISSIONSDK_LUA_000477 = GetResString("MISSDK_MISSIONSDK_LUA_000477")
		return MISSDK_MISSIONSDK_LUA_000477
	end
	if bagNum<1 then 
		MISSDK_MISSIONSDK_LUA_000478 = GetResString("MISSDK_MISSIONSDK_LUA_000478")
		return MISSDK_MISSIONSDK_LUA_000478
	end
	return LUA_TRUE
end 
function ChargeQiByOne(role)
	local item = GetChaItem(role ,2 ,0 )
	local itemID = GetItemID(item)
	RemoveChaItem(role , itemID, 0,2,0,2,1)
	local r1,r2 = MakeItem(role ,  itemID+12, 1,4)
	local itemQi = GetChaItem(role , 2, r2 )
	SetItemHole(itemQi,3)
	GiveItem(role , 0,itemID+26,1,4)
	return LUA_TRUE
end
function CanChargeQiByAll(role)
	local bagNum = GetChaFreeBagGridNum ( role )
	local needBag=0
	local i = 0 
	for i = 6542,6553,1 do 
		local itemNum= CheckBagItem(role,i)
		if itemNum~= 0 then 
			needBag= needBag+itemNum
		end
	end
	if needBag == 0 then 
		MISSDK_MISSIONSDK_LUA_000479 = GetResString("MISSDK_MISSIONSDK_LUA_000479")
		return MISSDK_MISSIONSDK_LUA_000479
	end
	if needBag> bagNum then 
		MISSDK_MISSIONSDK_LUA_000480 = GetResString("MISSDK_MISSIONSDK_LUA_000480")
		MISSDK_MISSIONSDK_LUA_000481 = GetResString("MISSDK_MISSIONSDK_LUA_000481")
		return MISSDK_MISSIONSDK_LUA_000481..needBag..MISSDK_MISSIONSDK_LUA_000480
	end
	return LUA_TRUE
end 
function ChargeQiByAll(role)
	local i = 0 
	for i = 6542,6553,1 do 
		local itemNum= CheckBagItem(role,i)
		if itemNum~= 0 then 
			local j = 0 
			for j = 1, itemNum ,1 do
				DelBagItem(role , i , 1)
				local r1,r2 = MakeItem(role , i+12 , 1,4)
				local itemQi = GetChaItem(role , 2, r2 )
				SetItemHole(itemQi,3)
				GiveItem(role , 0,i+26,1,4)
			end
		end
	end
	return LUA_TRUE
end
function SetItemHole ( item, Hole_Num)
	local Num = GetItemForgeParam ( item , 1 )
	Num = TansferNum ( Num )
	if Hole_Num > 4 then
		CALCULATE_FORGE_LUA_000077 = GetResString("CALCULATE_FORGE_LUA_000077")
		SystemNotice ( role , CALCULATE_FORGE_LUA_000077 )
		Hole_Num = 4
	end
	Num = SetNum_Part1 ( Num , Hole_Num )
	i = SetItemForgeParam ( item , 1 , Num )
end

function GiveItem95BBZB ( role , value , p1 )   -------   value为部件 p1 为职业 	
	job = {}
	job[1] = 8
	job[2] = 9
	job[3] = 12
	job[4] = 13
	job[5] = 14
	job[6] = 16
	if value == 1 then		------身体
	i = 0
		for i = 1,6,1 do
			if p1 == job[i] then
			ItemID = {}
			ItemID[1] = 6182
			ItemID[2] = 6178
			ItemID[3] = 6174
			ItemID[4] = 6190
			ItemID[5] = 6194
			ItemID[6] = 6186
			GiveItem( role , 0 , ItemID[i] , 1 ,4 )
			end
		end
	elseif value == 2 then		------手套
		for i = 1,6,1 do
			if p1 == job[i] then
			ItemID1 = {}
			ItemID1[1] = 6183
			ItemID1[2] = 6179
			ItemID1[3] = 6175
			ItemID1[4] = 6191
			ItemID1[5] = 6195
			ItemID1[6] = 6187
			GiveItem( role , 0 , ItemID1[i] , 1 ,4 )
			end
		end
	elseif value == 3 then		-----靴子
		for i = 1,6,1 do
			if p1 == job[i] then
			ItemID2 = {}
			ItemID2[1] = 6184
			ItemID2[2] = 6180
			ItemID2[3] = 6176
			ItemID2[4] = 6192
			ItemID2[5] = 6196
			ItemID2[6] = 6188
			GiveItem( role , 0 , ItemID2[i] , 1 ,4 )
			end
		end
	elseif value == 4 then		-----头部
		for i = 1,6,1 do
			if p1 == job[i] then
			ItemID3 = {}
			ItemID3[1] = 6181
			ItemID3[2] = 6177
			ItemID3[3] = 6173
			ItemID3[4] = 6189
			ItemID3[5] = 6193
			ItemID3[6] = 6185
			GiveItem( role , 0 , ItemID3[i] , 1 ,4 )
			end
		end
	end
	return LUA_TRUE
end 
function FindMissbyNPC(npc,id)	
	local i = 0 
	local missionID = 0
	local j = 0
	for j = 1 ,NpcInfoList.count ,1 do
		if  NpcInfoList[j].Npc ==npc then 
			missionID = j
			break
		end
	end
	for i = 1 ,NpcInfoList[missionID].missionlist.count ,1 do
		if NpcInfoList[missionID].missionlist[i] == Mission[id] then	
			return i
		end
	end
	return 0
end


-- 药师：6746
-- 冒险者：6743
-- 猎人：6740
-- 剑士：6737
function ZhiYeFenZhi1(role)
	local job = GetChaAttr(role,ATTR_JOB)
	local cha_type = GetChaTypeID ( role ) 
	if job == 1 or job == 8 or job == 9 then
		return 6737
	elseif job == 2 or job == 12 then 
		return 6740
	elseif job == 4 or job == 16 then 
			return 6754
	elseif job == 5 or job == 13 or job == 14  then 
		return 6746
	else
		return 0 
	end
end

function ZhiYeFenZhi2(role)
	local job = GetChaAttr(role,ATTR_JOB)
	local cha_type = GetChaTypeID ( role ) 
	if (job == 5 or job == 14 or job == 13) and cha_type == 3 then
		return 6748
	elseif (job == 5 or job == 14 or job == 13 ) and cha_type == 4 then
		return 6757
	else
		return 0
	end
end

function ZhiYeFenZhi3(role)
	local job = GetChaAttr(role,ATTR_JOB)
	local cha_type = GetChaTypeID ( role ) 
	if job == 1 or job == 8 or job == 9 then
		return 6763
	elseif job == 2 or job == 12 then 
		return 6764
	elseif job == 5 or job == 13 or job == 14 then 
		return 6766
	elseif job == 4 or job == 16 then 
		return 6765
	else
		return 0 
	end
end

function ZhiYeFenZhi4(role)
	local Lv=GetChaAttr( role , ATTR_LV )
	if Lv >= 30 then 
		return 6783
	end
local job = GetChaAttr(role,ATTR_JOB)
	if job == 1 or job == 8 or job == 9 then
		return 6780
	elseif job == 2 or job == 12 then 
		return 6782
	elseif job == 5 or job == 13 or job == 14 then 
		return 6780
	elseif job == 4 or job == 16 then 
		return 6781
	else
		return 0 
	end

end

function ZhiYeFenZhi5(role,p1)			------------1  古利咯里  2  巴布 	3阿兰比斯
	local Lv=GetChaAttr( role , ATTR_LV )
	if Lv >= 30 then 
		return 6783
	end
	if p1 == 1 then
		return 6782
	elseif p1 == 2 then
		return 6780
	elseif p1 == 3 then
		return 6781
	else
		return 0
	end	
end

function TiXingFenZhi1( role )
	local job = GetChaAttr(role,ATTR_JOB)
	local cha_type = GetChaTypeID ( role ) 
	if (job == 4 or job == 16 ) and cha_type == 3 then 
		return 6756
	elseif (job == 4 or job ==16 ) and cha_type == 1 then
		return 6756
	elseif (job == 4 or job == 16 ) and cha_type == 4 then
		return 6803
	end		
end 
function  GiveNpcMissionbyFunc (character, npc,func,p1,p2,p3,p4)
	local id = 0
	MISSCRIPT_MISSIONSCRIPT05_LUA_001049 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001049")
	if func==MISSCRIPT_MISSIONSCRIPT05_LUA_001049 then
		id = ZhiYeFenZhi1(character)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001075 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001075")
	elseif func == MISSCRIPT_MISSIONSCRIPT05_LUA_001075 then
		id = ZhiYeFenZhi2(character)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001108 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001108")
	elseif func == MISSCRIPT_MISSIONSCRIPT05_LUA_001108 then
		id = ZhiYeFenZhi3(character)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001165 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001165")
	elseif func == MISSCRIPT_MISSIONSCRIPT05_LUA_001165 then
		id = ZhiYeFenZhi4(character)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001171")
	elseif func == MISSCRIPT_MISSIONSCRIPT05_LUA_001171 then
		id = ZhiYeFenZhi5(character,p1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001069 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001069")
	elseif func == MISSCRIPT_MISSIONSCRIPT05_LUA_001069 then
		id = TiXingFenZhi1(character)
	end
	if ValidCha(id) == 0 then
		MISSDK_MISSIONSDK_LUA_000482 = GetResString("MISSDK_MISSIONSDK_LUA_000482")
		SystemNotice(character,MISSDK_MISSIONSDK_LUA_000482)
	end
	GiveNpcMission1( character, npc,id)
	return 1
end
function GiveNpcMission1( character, npc,id)
	if id == nil or Mission[id] == nil then
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		PRINT( MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		LG( "mission_error", MISSDK_MISSIONSDK_LUA_000143..id )
		MISSDK_MISSIONSDK_LUA_000143 = GetResString("MISSDK_MISSIONSDK_LUA_000143")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000143..id )
		return LUA_FALSE
	end
	local npcid = GetCharID( npc )
	local npcmissionid = FindMissbyNPC(npc,id)
	if npcmissionid== 0 then 
		MISSDK_MISSIONSDK_LUA_000483 = GetResString("MISSDK_MISSIONSDK_LUA_000483")
		SystemNotice(character,id..MISSDK_MISSIONSDK_LUA_000483)
	end
	--SystemNotice( character, "npcid"..npcid )
	PRINT( "GiveMission: npcid, id, mistp", npcid, id, Mission[id].tp )
	--ret = SetMissionTempInfo( character, npcid, id, MIS_ACCEPT, Mission[id].tp )
	ret = SetMissionTempInfo( character, npcid, npcmissionid, MIS_ACCEPT, Mission[id].tp )
	if ret ~= LUA_TRUE then 
		MISSDK_MISSIONSDK_LUA_000121 = GetResString("MISSDK_MISSIONSDK_LUA_000121")
		PRINT( MISSDK_MISSIONSDK_LUA_000121 )
		MISSDK_MISSIONSDK_LUA_000122 = GetResString("MISSDK_MISSIONSDK_LUA_000122")
		SystemNotice( character, MISSDK_MISSIONSDK_LUA_000122 )
		return LUA_FALSE
	end
	
	SendAcceptPage( character, npcid, Mission[id], Mission[id].id )
	return LUA_TRUE
end


function CheckChaTypeID(role,p1)
	local type = GetChaTypeID ( role ) 
	if type == p1 then
		return 1
	else 
		return 0
	end
end 


function HasItemShouTao( role , ItemID )
	local ShouTao = CheckBagItem ( role , ItemID )
	if ShouTao ~= 0 then
		return 1
	end
	local Item_Use = GetChaItem ( role , 1 , 3 )			----取手上装备的道具
	if Item_Use == nil then
		return 0
	end
	local ItemID_Use = GetItemID ( Item_Use )			----取ID
	if ItemID_Use == ItemID then
		return 1
	end
	return 0
end 
function HasBagJieZhi ( role )
	JieZhiID = {4611,4612,4613,4614,4615,4616,4617,4618,4619,4620}
	i = 0
	for i = 1,9,1 do
	local JieZhi = CheckBagItem ( role , JieZhiID[i] )
		if JieZhi ~= 0 then
			return 1
		end	
	end
	for i = 1,9,1 do
	local Item_Use = GetChaItem ( role , 1 , 7 )			
	local Item_Use1 = GetChaItem ( role , 1 , 8 )			
		if Item_Use == nil and Item_Use1 == nil then
			return 0
		end
		local ItemID_Use = GetItemID ( Item_Use )			----取ID
		local ItemID_Use1 = GetItemID ( Item_Use1 )			----取ID
		if ItemID_Use == JieZhiID[i] or ItemID_Use1 == JieZhiID[i] then
			return 1
		end
	end
	return 0
end 


function CheckZBNowState( role )
	local ZBZT = ZBNowState( role )
	if ZBZT ~= "no" then
		return 1
	else
		return 0
	end
end 


function PfEqual1 (role,p1)
	local job = GetChaAttr(role, ATTR_JOB)
	if p1 == 1 then
		if job == 1 or job == 8 or job == 9 then
			return 1
		else
			return 0
		end
	elseif p1 == 2 then 
		if job == 2 or job == 12 then
			return 1
		else
			return 0
		end
	elseif p1 == 4 then
		if job == 4 or job == 16 then
			return 1
		else
			return 0
		end
	elseif p1 == 5 then
		if job == 5 or job == 13 or job == 14  then
			return 1
		else
			return 0
		end
	end
	return 0
end 

function CheckRecordRand ( role )
	local record1 = HasRecord( role, 57 )
	local record2 = HasRecord( role, 89 )
	local record3 = HasRecord( role, 97 )
	if record1 == 1 or record2 == 1 or record3 == 1 then
		return 1
	else
		return 0
	end
end 


function CheckBaoShiLV(role,ItemID)
	local Diamond = 0
	local Item_Diamond = CheckBagItem( role , ItemID)
	if Item_Diamond == 0 then
		return 0
	end
	local LV_Diamond = GetChaItem2(role,2,ItemID)
	local forge_lv = GetItemAttr ( LV_Diamond , ITEMATTR_VAL_BaoshiLV )
	if forge_lv >= 2 then
		return 1
	else
		return 0
	end
end 

function CheckBankItemOrLv ( role , ItemID , Count )
	local ret = BankHasItem( role, ItemID, Count )
	if ret == 1 or Lv( role ) >= 20 then
		return 1
	else
		return 0
	end
end


function CheckKZRH ( role , ItemID )
	if ItemID == nil then
		ItemID = JParg[1] 
	end
	JParg[1]= ItemID

	local item = CheckBagItem( role, ItemID )	
	if item == 0 or item ~= 1 then
		MISSDK_MISSIONSDK_LUA_000484 = GetResString("MISSDK_MISSIONSDK_LUA_000484")
		return MISSDK_MISSIONSDK_LUA_000484
	else
		local Item_bg = GetChaItem2 (role , 2, ItemID )
		local def = GetItemAttr ( Item_bg, ITEMATTR_VAL_DEF)
		if def == 0 then
			return 1
		elseif def ~= 0 then
			MISSDK_MISSIONSDK_LUA_000485 = GetResString("MISSDK_MISSIONSDK_LUA_000485")
			return MISSDK_MISSIONSDK_LUA_000485
		end
	end
end 
function CheckCZCL (role)
	local ret = HasRecord(role,1983)
	if ret == 1 then
		MISSDK_MISSIONSDK_LUA_000486 = GetResString("MISSDK_MISSIONSDK_LUA_000486")
		return MISSDK_MISSIONSDK_LUA_000486
	end	
	local Item_CanGet = GetChaFreeBagGridNum ( role )	
	if Item_CanGet < 1 then
		MISSDK_MISSIONSDK_LUA_000487 = GetResString("MISSDK_MISSIONSDK_LUA_000487")
		return MISSDK_MISSIONSDK_LUA_000487
	end		
	local Item_ID1 = CheckBagItem( role , 1672 )		---奇异金属
	local Item_ID2 = CheckBagItem( role , 1783 )		---地金
	local Item_ID3 = CheckBagItem( role , 3992 )		---比比铁苏
	local Item_ID4 = CheckBagItem( role , 3991 )		---象牙酥
	if Item_ID1 < 20 then
		MISSDK_MISSIONSDK_LUA_000488 = GetResString("MISSDK_MISSIONSDK_LUA_000488")
		return MISSDK_MISSIONSDK_LUA_000488
	end
	if Item_ID2 < 20 then
		MISSDK_MISSIONSDK_LUA_000488 = GetResString("MISSDK_MISSIONSDK_LUA_000488")
		return MISSDK_MISSIONSDK_LUA_000488
	end
	if Item_ID3 < 10 then
		MISSDK_MISSIONSDK_LUA_000488 = GetResString("MISSDK_MISSIONSDK_LUA_000488")
		return MISSDK_MISSIONSDK_LUA_000488
	end
	if Item_ID4 < 10 then
		MISSDK_MISSIONSDK_LUA_000488 = GetResString("MISSDK_MISSIONSDK_LUA_000488")
		return MISSDK_MISSIONSDK_LUA_000488
	end


	return 1
end

function TakeCZCL ( role )
	a = TakeItem ( role , 0 , 1672 , 20)
	b = TakeItem ( role , 0 , 1783 , 20)
	c = TakeItem ( role , 0 , 3992 , 10)
	d = TakeItem ( role , 0 , 3991 , 10)
	if a == 0 or b ==0 or c == 0 or d == 0 then
		MISSDK_MISSIONSDK_LUA_000489 = GetResString("MISSDK_MISSIONSDK_LUA_000489")
		SystemNotice (role , MISSDK_MISSIONSDK_LUA_000489)
		return
	end
	GiveItem (role , 0 , 6897 , 1 , 4 )
	return 1
end 	

function GiveFHItem ( role )
	local cha_type = GetChaTypeID ( role )
	if cha_type == 1 or cha_type == 2 then
		GiveItem (role , 0 , 6896 , 1 , 4 )
	else
		GiveItem ( role , 0 , 6895 , 1 , 4 )
	end 
	return 1
end 
function CheckBoatSkill ( role)  
	local name = GetChaDefaultName(role)
	if CheckShipExp[name] == nil then 
		return 0
	end

	return 1
end 
function CheckBagJL (role)
	local elf = GetChaItem ( role , 2 , 1  )
	local elf_type = GetItemType ( elf )
	if elf_type ~= 59 then
		return 0 
	else
		return 1
	end
end  


function JL_lv3 (role)
	local Item_bg = GetChaItem ( role , 2 , 1  ) --取角色背包第二栏的指针
	local Get_Item_Type = GetItemType ( Item_bg )
	if  Get_Item_Type ~= 59 then
		return LUA_FALSE	
	else
		local str_Traget = GetItemAttr( Item_bg ,ITEMATTR_VAL_STR )		 --力量
		local con_Traget = GetItemAttr( Item_bg ,ITEMATTR_VAL_CON )		--体质
		local agi_Traget = GetItemAttr( Item_bg ,ITEMATTR_VAL_AGI )		--专注
		local dex_Traget = GetItemAttr( Item_bg ,ITEMATTR_VAL_DEX )		--敏捷
		local sta_Traget = GetItemAttr( Item_bg ,ITEMATTR_VAL_STA )		--精神
		local lv_Traget = str_Traget + con_Traget + agi_Traget + dex_Traget + sta_Traget  ----一个精灵的等级
		if lv_Traget >=3 then
			return LUA_TRUE
		else
			return LUA_FALSE
		end
	end
end


function CheckBaoShiLV2(role)
	local Item_Diamond = CheckBagItem( role , 6717)
	local Item_Diamond2 = CheckBagItem( role , 6718)
	if Item_Diamond == 0 then
		if Item_Diamond2 == 0 then
			return 0
		else
			local LV_Diamond2 = GetChaItem2(role,2,6718)
			local forge_lv2 = GetItemAttr ( LV_Diamond2 , ITEMATTR_VAL_BaoshiLV )
			if forge_lv2 >= 2 then
				return 1
			else
				return 0
			end
		end
	else
		local LV_Diamond = GetChaItem2(role,2,6717)
		local forge_lv = GetItemAttr ( LV_Diamond , ITEMATTR_VAL_BaoshiLV )
		if forge_lv >= 2 then
			return 1
		else
			return 0
		end
	end
end 


function HasCleckFusion(role)
	local name = GetChaDefaultName(role)
	if Checkfusion[name] ==nil then 
		return 0 
	end
	return 1
end 


function HasCleckUnite(role)
	local name = GetChaDefaultName(role)
	if Checkunite[name] ==nil then 
		return 0 
	end
	return 1
end 


function CheckEquipPurify ( role )
	for i = 0,9,1 do
		local Item = GetChaItem ( role , 1 , i)
		local Num = GetItemForgeParam ( Item , 1 )
		Item_Stone1 = GetNum_Part2 ( Num )
		Item_Stone2 = GetNum_Part4 ( Num )
		Item_Stone3 = GetNum_Part6 ( Num )
		Item_Stone4 = Item_Stone1 + Item_Stone2 + Item_Stone3 
		if Item_Stone4 >=3 then
			return 1
		end
	end
	return 0
end 


function CheckNoNewJob (role)
	local rolejob = GetChaAttr( role, ATTR_JOB)
	if rolejob == 0 or rolejob == 1 or rolejob == 2 or rolejob == 4 or job == 5 then
		return 0
	end
	return 1

end 

function Sdhd_check(role)------------------------检查可以使用的次数----------------需要注册
	local now_day= os.date("%d")		-------------日
	local now_day_num= tonumber(now_day)
	local sd_day=GetChaAttr(role, ATTR_EXTEND10)-----------------查询圣诞节活动的时间记录
	if sd_day~=nil then
		sd_day=math.floor(sd_day/10)
	end
	if now_day_num ~= sd_day or sd_day==nil then
		SetChaAttr(role, ATTR_EXTEND10,now_day_num*10)
	end
	local sdcs = GetChaAttr(role, ATTR_EXTEND10)-------------------调用圣诞节活动当天已经进行过的次数
	local jles=CheckBagItem ( role , 7721 )
	local bankHasitem=BankNoItem(role,7721,1)
	sdcs=math.fmod(sdcs,10)
	if sdcs >= 3 then
		SystemNotice ( role , "The cycle quests you can get are used out today, please come to get it tomorrow.")
		return LUA_FALSE
	elseif jles > 0 then
		SystemNotice(role ,"Please plant the Xmas Tree by the planting tool.")
		return LUA_FALSE
	elseif bankHasitem == 0 then
		SystemNotice(role ,"Please discard the letter of last Xmas Quest from your warhouse and get the new chance!")
		return LUA_FALSE
	end
	return LUA_TRUE
end 

function GiveSDItem_SetAttr(role)--------------------------给予圣诞活动道具并记录坐标点，这句写在NPC对话ACTION里----------NPCSDK注册
	local sdcs=GetChaAttr(role, ATTR_EXTEND10)------------------调用圣诞节活动当天已经进行过的次数
	SetChaAttr(role, ATTR_EXTEND10,sdcs+1)
	return LUA_TRUE
end 

--随机Give圣诞神秘礼物

function GiveSDSMLW (role)
	local zhzbx = math.random ( 1, 6 )
	if zhzbx==1 then
	GiveItem ( role , 0 , 2801  , 1 , 4 )
	elseif zhzbx==2 then
	GiveItem ( role , 0 , 3909  , 10 , 4 )
	elseif zhzbx==3 then
	GiveItem ( role , 0 , 1101  , 1 , 4 )
	elseif zhzbx==4 then
	GiveItem ( role , 0 , 4312  , 1 , 4 )
	elseif zhzbx==5 then
	GiveItem ( role , 0 , 6918  , 1 , 4 )
	else
	GiveItem ( role , 0 , 5644 , 1 , 4 )
	end
	return LUA_TRUE
end 
