--------------------------------------------------------------------------
--									--
--									--
--				ScriptSdk.lua 				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading ScriptSdk.lua" )


--脚本系统全局变量

Page       = {}				--npc对话信息全局变量定义
Exchange  = {}
ExchangeX = {}
FuncList  = {}
Trade     = {}				--npc交易信息全局变量定义
Goods	 = {}				--npc货物交易信息全局变量定义
Mission    = {}				--所有任务信息保存全局变量定义
MissionSid    = {}				--MISSION misid 对应的 MISSION id
MisLogList = {}			--所有任务日志信息保存全局变量定义
TriggerList = {}			--所有全局触发器信息保存全局变量定义
NpcMissionList  = {}		--npc携带任务信息全局变量定义
Trigger  = {}

NpcInfoList = {}			--所有npc脚本信息保存全局变量定义
NpcInfoList.count = 0	--所有npc脚本信息计数

MapList = {}				--地图服务器所有地图名称信息列表
MapList.count = 0		--地图名称计数

RandParam = {}			--随机任务的生成参数表

NpcList	= {}				--世界中所有NPC信息列表

NpcPointer = LUA_NULL	--Npc初始化指针

Profession = {} 			--角色转职职业选择限制条件信息
Category  = {}			--角色转职职业选择体形限制条件信息

BerthPortList = {}		--港口信息

ResourceList = {}		--资源信息
ResourceList.wood = {}
ResourceList.mine = {}

BoatLevelList = {}		--船只升级数据信息

talklist = {}				--随机任务前后缀信息列表

--任务奖励选项类型
--多选一
PRIZE_SELONE          = 0
--全给予
PRIZE_SELALL           = 1

--任务类型
NOMAL_MISSION		  = 0 		--普通任务
RAND_MISSION		  = 1		--随机任务
WORLD_MISSION		  = 2 	    --世界任务

--任务显示类型
ALLWAYS_SHOW		 	= 0 	--总是显示任务状态
COMPLETE_SHOW   		= 1 	--完成任务条件时才显示任务状态，（只有角色满足完成条件，角色才会看到任务）
ACCEPT_SHOW			= 2	--可以接受任务时任务才显示出来

--任务需求类型
MIS_RAND_KILL		  = 0   	--摧毁物件
MIS_RAND_GET		  = 1		--获取物品
MIS_RAND_SEND		  = 2		--送物品
MIS_RAND_CONVOY    = 3		--护送NPC
MIS_RAND_EXPLORE	  = 4		--探索地图

--护送NPC到达目标类型
MIS_CONVOY_NPC	  = 0		--护送交付NPC
MIS_CONVOY_MAP	  = 1		--护送到某个指定地点

--触发器类型
MIS_TRIGGER_NOMAL	= 0	 --普通
MIS_TRIGGER_RAND		= 1	 --随机(用于随机任务中，使用时根据传递的参数设置触发器信息)

--随机任务每个段必须完成的任务基数，才可以产生奖励物品
MIS_RAND_MAXCOMPLETE = 1

--随机任务等级类型
MIS_LEVEL_CHAR 	= 0	    --角色随机任务等级类型
MIS_LEVEL_GANG 	= 1		--公会随机任务等级类型

--随机任务奖励经验类型
MIS_EXP_NOMAL 		= 0		--奖励普通经验
MIS_EXP_SAIL			= 1		--奖励航海经验
MIS_EXP_LIFE			= 2		--奖励生活经验

--各种实体类型信息
BASE_ENTITY			= 0		--基本实体
RESOURCE_ENTITY	= 1		--资源实体
TRANSIT_ENTITY		= 2		--传送实体
BERTH_ENTITY		= 3		--停泊实体

--NPC交易方式类型
TRADE_NOMAL			= 0		--普通交易
TRADE_GOODS		= 2		--货物交易

--任务奖励物品类型
MIS_ITEM_INST_BUY	= 0	--商店买卖
MIS_ITEM_INST_MONS	= 1	--怪物掉落
MIS_ITEM_INST_COMP	= 2	--合成
MIS_ITEM_INST_TASK	= 3	--任务获得

--下面是leo的黑市商人
MoliTable ={}
NakaTable ={}
CoinTable1000 ={}
CoinTable600 ={}

MoliTable[1]=0766
MoliTable[2]=0769
MoliTable[3]=0773
MoliTable[4]=0776
MoliTable[5]=0780
MoliTable[6]=0784
MoliTable[7]=0788
MoliTable[8]=0792
MoliTable[9]=0795
MoliTable[10]=0798
MoliTable[11]=0802
MoliTable[12]=0806

NakaTable[1]=0765
NakaTable[2]=0768
NakaTable[3]=0772
NakaTable[4]=0775
NakaTable[5]=0779
NakaTable[6]=0783
NakaTable[7]=0787
NakaTable[8]=0791
NakaTable[9]=0794
NakaTable[10]=0797
NakaTable[11]=0801
NakaTable[12]=0805
NakaTable[13]=0807
NakaTable[14]=0808
NakaTable[15]=0809
NakaTable[16]=0810
NakaTable[17]=0811
NakaTable[18]=0812
NakaTable[19]=0813
NakaTable[20]=0814
NakaTable[21]=0815
NakaTable[22]=0877

CoinTable1000[1]=0764
CoinTable1000[2]=0767
CoinTable1000[3]=0771
CoinTable1000[4]=0774
CoinTable1000[5]=0778
CoinTable1000[6]=0782
CoinTable1000[7]=0786
CoinTable1000[8]=0790
CoinTable1000[9]=0793
CoinTable1000[10]=0796
CoinTable1000[11]=0800
CoinTable1000[12]=0804
CoinTable1000[13]=0764
CoinTable1000[14]=0767
CoinTable1000[15]=0771
CoinTable1000[16]=0774
CoinTable1000[17]=0778
CoinTable1000[18]=0782
CoinTable1000[19]=0786
CoinTable1000[20]=0790
CoinTable1000[21]=0793
CoinTable1000[22]=0796
CoinTable1000[23]=0800
CoinTable1000[24]=0804
CoinTable1000[25]=0764
CoinTable1000[26]=0767
CoinTable1000[27]=0771
CoinTable1000[28]=0774
CoinTable1000[29]=0778
CoinTable1000[30]=0782
CoinTable1000[31]=0786
CoinTable1000[32]=0790
CoinTable1000[33]=0793
CoinTable1000[34]=0796
CoinTable1000[35]=0800
CoinTable1000[36]=0804

CoinTable600[1]=0763
CoinTable600[2]=0770
CoinTable600[3]=0777
CoinTable600[4]=0781
CoinTable600[5]=0785
CoinTable600[6]=0789
CoinTable600[7]=0799
CoinTable600[8]=0803
CoinTable600[9]=0763
CoinTable600[10]=0770
CoinTable600[11]=0777
CoinTable600[12]=0781
CoinTable600[13]=0785
CoinTable600[14]=0789
CoinTable600[15]=0799
CoinTable600[16]=0803
CoinTable600[17]=0763
CoinTable600[18]=0770
CoinTable600[19]=0777
CoinTable600[20]=0781
CoinTable600[21]=0785
CoinTable600[22]=0789
CoinTable600[23]=0799
CoinTable600[24]=0803
CoinTable600[25]=0763
CoinTable600[26]=0770
CoinTable600[27]=0777
CoinTable600[28]=0781
CoinTable600[29]=0785
CoinTable600[30]=0789
CoinTable600[31]=0799
CoinTable600[32]=0803
CoinTable600[33]=0763
CoinTable600[34]=0770
CoinTable600[35]=0777
CoinTable600[36]=0781
CoinTable600[37]=0785
CoinTable600[38]=0789
CoinTable600[39]=0799
CoinTable600[40]=0803
CoinTable600[41]=0763
CoinTable600[42]=0770
CoinTable600[43]=0777
CoinTable600[44]=0781
CoinTable600[45]=0785
CoinTable600[46]=0789
CoinTable600[47]=0799
CoinTable600[48]=0803
CoinTable600[49]=0763
CoinTable600[50]=0770
CoinTable600[51]=0777
CoinTable600[52]=0781
CoinTable600[53]=0785
CoinTable600[54]=0789
CoinTable600[55]=0799
CoinTable600[56]=0803
----------------leo黑市商人 end
------------------------------------------------------------

--初始化服务器船只升级信息
function InitBoatLevel()
	BoatLevelList = {}
	BoatLevelList.count = 0
end

--添加船只升级数据信息
function AddBoatLevel( level, money, exp )
	BoatLevelList.count = BoatLevelList.count + 1
	BoatLevelList[level] = {}
	BoatLevelList[level].money = money
	BoatLevelList[level].exp = exp	
	LG( "boatlevel_init", "AddBoatLevel: count, level, money, exp", BoatLevelList.count, level, money, exp )
end

--初始化地图列表信息
function InitMap()
	MapList = {}
	MapList.idname = {}
	MapList.mapname = {}
	MapList.count = 0
end

--添加地图名称信息自动生成地图唯一ID
function AddMap( idname, str )
	for n = 1, MapList.count, 1 do
		if MapList.mapname[n] == nil or MapList.idname[n] == nil then
			break
		end
		if MapList.mapname[n] == str or MapList.idname[n] == idname then
			return
		end
	end
	MapList.count = MapList.count + 1
	MapList.idname[MapList.count] = idname
	MapList.mapname[MapList.count] = str
	MISSDK_SCRIPTSDK_LUA_000001 = GetResString("MISSDK_SCRIPTSDK_LUA_000001")
	MISSDK_SCRIPTSDK_LUA_000002 = GetResString("MISSDK_SCRIPTSDK_LUA_000002")
	LG( "mission", MISSDK_SCRIPTSDK_LUA_000002..MapList.mapname[MapList.count]..MISSDK_SCRIPTSDK_LUA_000001..MapList.idname[MapList.count].."ID = "..MapList.count )
	MISSDK_SCRIPTSDK_LUA_000001 = GetResString("MISSDK_SCRIPTSDK_LUA_000001")
	MISSDK_SCRIPTSDK_LUA_000002 = GetResString("MISSDK_SCRIPTSDK_LUA_000002")
	PRINT( MISSDK_SCRIPTSDK_LUA_000002..MapList.mapname[MapList.count]..MISSDK_SCRIPTSDK_LUA_000001..MapList.idname[MapList.count].."ID = "..MapList.count )
	
	local ret = SetMap( MapList.idname[MapList.count], MapList.count )
	if ret == LUA_FALSE then
		MISSDK_SCRIPTSDK_LUA_000001 = GetResString("MISSDK_SCRIPTSDK_LUA_000001")
		MISSDK_SCRIPTSDK_LUA_000003 = GetResString("MISSDK_SCRIPTSDK_LUA_000003")
		LG( "mission", MISSDK_SCRIPTSDK_LUA_000003..MapList.mapname[MapList.count]..MISSDK_SCRIPTSDK_LUA_000001..MapList.idname[MapList.count].."ID = "..MapList.count )
		MISSDK_SCRIPTSDK_LUA_000001 = GetResString("MISSDK_SCRIPTSDK_LUA_000001")
		MISSDK_SCRIPTSDK_LUA_000003 = GetResString("MISSDK_SCRIPTSDK_LUA_000003")
		PRINT( MISSDK_SCRIPTSDK_LUA_000003..MapList.mapname[MapList.count]..MISSDK_SCRIPTSDK_LUA_000001..MapList.idname[MapList.count].."ID = "..MapList.count )
	end
end

--获得指定ID的地图名称
function GetMap( mapid )
	if mapid > MapList.count or MapList.mapname[mapid] == nil then
		MISSDK_SCRIPTSDK_LUA_000004 = GetResString("MISSDK_SCRIPTSDK_LUA_000004")
		return MISSDK_SCRIPTSDK_LUA_000004
	end
	
	return MapList.mapname[mapid]
end

--初始化对话页信息
function InitPage()
	Page = {}
	Page.trade = {}
	for i = 1, 32, 1 do
		Page[i] = {}
		Page[i].count = 0
		for n = 1, 12, 1 do
			Page[i][n] = {}
		end
	end
	Page[1].ismission = 1
end

--初始化交易页信息
function InitTrade()
	Trade = {}
	Trade.tp = TRADE_NOMAL
	Trade.berth = -1
	
	--武器
	Trade[1] = {}
	Trade[1].itemtype = WEAPON
	Trade[1].count = 0;
	Trade[1].item = {}
	Trade[1].price = {}
	--防具
	Trade[2] = {}
	Trade[2].itemtype = DEFENCE
	Trade[2].count = 0;
	Trade[2].item = {}
	Trade[2].price = {}
	--杂项
	Trade[3] = {}
	Trade[3].itemtype = OTHER
	Trade[3].count = 0;
	Trade[3].item = {}
	Trade[3].price = {}
	--合成
	Trade[4] = {}
	Trade[4].itemtype = SYNTHESIS
	Trade[4].count = 0;
	Trade[4].item = {}
	Trade[4].price = {}
end

function InitTradeX( trade )
--	trade = {}
--	trade.tp = TRADE_NOMAL
--	trade.berth = -1
	
	--武器
--	trade[1] = {}
	trade[1].itemtype = WEAPON
	trade[1].count = 0;
--	trade[1].item = {}
--	trade[1].price = {}
	--防具
--	trade[2] = {}
	trade[2].itemtype = DEFENCE
	trade[2].count = 0;
--	trade[2].item = {}
--	trade[2].price = {}
	--杂项
--	trade[3] = {}
	trade[3].itemtype = OTHER
	trade[3].count = 0;
--	trade[3].item = {}
--	trade[3].price = {}
	--合成
--	trade[4] = {}
	trade[4].itemtype = SYNTHESIS
	trade[4].count = 0;
--	trade[4].item = {}
--	trade[4].price = {}
end

--初始化货物交易信息
function InitGoods( berth )
	Trade = {}
	Trade.tp = TRADE_GOODS
	Trade.berth = berth

	--武器
	Trade[1] = {}
	Trade[1].itemtype = WEAPON
	Trade[1].count = 0;
	Trade[1].item = {}
	Trade[1].price = {}
	--防具
	Trade[2] = {}
	Trade[2].itemtype = DEFENCE
	Trade[2].count = 0;
	Trade[2].item = {}
	Trade[2].price = {}
	--杂项
	Trade[3] = {}
	Trade[3].itemtype = OTHER
	Trade[3].count = 0;
	Trade[3].item = {}
	Trade[3].price = {}
	--合成
	Trade[4] = {}
	Trade[4].itemtype = SYNTHESIS
	Trade[4].count = 0;
	Trade[4].item = {}
	Trade[4].price = {}
end

--初始化npc任务列表信息
function InitNpcMission()
	NpcMissionList = {}
	NpcMissionList.count = 0
	--for n = 1, 32, 1 do
		--NpcMissionList[n] = {}
	--end	
end

--npc对话信息函数
function ResetNpcInfo( npc, name )
	InitPage()
	InitTrade()
	InitNpcMission()
	NpcPointer = npc
	MISSDK_SCRIPTSDK_LUA_000005 = GetResString("MISSDK_SCRIPTSDK_LUA_000005")
	MISSDK_SCRIPTSDK_LUA_000006 = GetResString("MISSDK_SCRIPTSDK_LUA_000006")
	local str = MISSDK_SCRIPTSDK_LUA_000006..name..MISSDK_SCRIPTSDK_LUA_000005
	PRINT( str )
	LG( "npcinit", str )
end

--获取npc对话信息和交易信息ID
function GetNpcInfo( npc, name )
	NpcInfoList.count = NpcInfoList.count + 1
	NpcInfoList[NpcInfoList.count] = {}
	NpcInfoList[NpcInfoList.count].page = Page
	NpcInfoList[NpcInfoList.count].trade = Trade
	NpcInfoList[NpcInfoList.count].eXchange = ExchangeX
	NpcInfoList[NpcInfoList.count].missionlist = NpcMissionList
	SetNpcScriptID( npc, NpcInfoList.count )
	
	NpcInfoList[NpcInfoList.count].Npc = npc;
	NpcInfoList[NpcInfoList.count].Name = name;
	if NpcMissionList.count > 0 then
		MISSDK_SCRIPTSDK_LUA_000007 = GetResString("MISSDK_SCRIPTSDK_LUA_000007")
		LG( "mission", MISSDK_SCRIPTSDK_LUA_000007 )
		SetNpcHasMission( npc, 1 )
	end
	NpcPointer = LUA_NULL
	
	MISSDK_SCRIPTSDK_LUA_000008 = GetResString("MISSDK_SCRIPTSDK_LUA_000008")
	MISSDK_SCRIPTSDK_LUA_000009 = GetResString("MISSDK_SCRIPTSDK_LUA_000009")
	local str = MISSDK_SCRIPTSDK_LUA_000009..name..MISSDK_SCRIPTSDK_LUA_000008..NpcInfoList.count
	PRINT( str )
	LG( "npcinit", str )
end

--动态修改npc脚本信息
function ModifyNpcInfo( npc, name, id )
	PRINT( "ModifyNpcInfo:npc = , name = , id = ", npc, name, id )
	
	NpcInfoList[id] = {}
	NpcInfoList[id].page = Page
	NpcInfoList[id].trade = Trade
	NpcInfoList[id].eXchange = ExchangeX
	NpcInfoList[id].missionlist = NpcMissionList
	
	MISSDK_SCRIPTSDK_LUA_000010 = GetResString("MISSDK_SCRIPTSDK_LUA_000010")
	PRINT( MISSDK_SCRIPTSDK_LUA_000010, id )
	--SetNpcScriptID( npc, id )
	if NpcMissionList.count > 0 then
		MISSDK_SCRIPTSDK_LUA_000007 = GetResString("MISSDK_SCRIPTSDK_LUA_000007")
		PRINT( "mission", MISSDK_SCRIPTSDK_LUA_000007 )
		SetNpcHasMission( npc, 1 )
	else
		MISSDK_SCRIPTSDK_LUA_000011 = GetResString("MISSDK_SCRIPTSDK_LUA_000011")
		PRINT( "mission", MISSDK_SCRIPTSDK_LUA_000011 )
		SetNpcHasMission( npc, 0 )
	end
	
	NpcPointer = LUA_NULL
	
	MISSDK_SCRIPTSDK_LUA_000008 = GetResString("MISSDK_SCRIPTSDK_LUA_000008")
	MISSDK_SCRIPTSDK_LUA_000012 = GetResString("MISSDK_SCRIPTSDK_LUA_000012")
	local str = MISSDK_SCRIPTSDK_LUA_000012..name..MISSDK_SCRIPTSDK_LUA_000008..id
	PRINT( str )
	LG( "npcinit", str )
end

-- npc消息处理函数
function NpcProc( character, npc, rpk, id )
	PRINT( "NpcProc:character, npc, rpk, id",  character, npc, rpk, id )
	if NpcInfoList[id] == nil then
		MISSDK_SCRIPTSDK_LUA_000013 = GetResString("MISSDK_SCRIPTSDK_LUA_000013")
		PRINT( MISSDK_SCRIPTSDK_LUA_000013,  id )
		local npcname = GetCharName( npc )
		MISSDK_SCRIPTSDK_LUA_000014 = GetResString("MISSDK_SCRIPTSDK_LUA_000014")
		local str = npcname..MISSDK_SCRIPTSDK_LUA_000014
		SendPage( character, npc, 0, str, nil, 0 )
		return
	end
	MsgProc( character, npc, rpk, NpcInfoList[id].page, NpcInfoList[id].trade, NpcInfoList[id].missionlist, NpcInfoList[id].eXchange )
end

--npc任务状态处理函数
function NpcState( character, npcid, id )
   PRINT( "NpcState:character, npcid, NpcMissionList", character, npcid, id )
	if NpcInfoList[id] == nil or NpcInfoList[id].missionlist == nil then
		MISSDK_SCRIPTSDK_LUA_000013 = GetResString("MISSDK_SCRIPTSDK_LUA_000013")
		PRINT( MISSDK_SCRIPTSDK_LUA_000013,  id )
		MISSDK_SCRIPTSDK_LUA_000013 = GetResString("MISSDK_SCRIPTSDK_LUA_000013")
		LG( "npc_error", MISSDK_SCRIPTSDK_LUA_000013,  id )
		return LUA_FALSE
	end

   return MissionState( character, npcid, NpcInfoList[id].missionlist )
end

--重新装载npc处理信息
function NpcInfoReload( name,  func )
	PRINT( "NpcInfoReload: name, findnpc ", name, FindNpc )
	local ret, npc, id = FindNpc( name )
	if ret == LUA_FALSE or npc == nil or id == nil then
		MISSDK_SCRIPTSDK_LUA_000015 = GetResString("MISSDK_SCRIPTSDK_LUA_000015")
		MISSDK_SCRIPTSDK_LUA_000016 = GetResString("MISSDK_SCRIPTSDK_LUA_000016")
		print( MISSDK_SCRIPTSDK_LUA_000016..name..MISSDK_SCRIPTSDK_LUA_000015 )
		return
	end
	MISSDK_SCRIPTSDK_LUA_000017 = GetResString("MISSDK_SCRIPTSDK_LUA_000017")
	PRINT( MISSDK_SCRIPTSDK_LUA_000017, npc, id )
	
	print( GetCharName( npc ) )

	ResetNpcInfo( npc, name )
	PRINT( "ResetNpcInfo, npc = , name = ", npc, name )
	
	func()
	PRINT( "Func = ", func )
	
	ModifyNpcInfo( npc, name, id )
	PRINT( "ModifyNpcInfo, name = , id = ", name, id )
	MISSDK_SCRIPTSDK_LUA_000005 = GetResString("MISSDK_SCRIPTSDK_LUA_000005")
	MISSDK_SCRIPTSDK_LUA_000018 = GetResString("MISSDK_SCRIPTSDK_LUA_000018")
	print( MISSDK_SCRIPTSDK_LUA_000018..name..MISSDK_SCRIPTSDK_LUA_000005 )
end

--对话描述信息注册

function Talk( pageid, talk ,func,func1, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	Page[pageid].count = Page[pageid].count + 1
	Page[pageid][Page[pageid].count].talk = talk
	if func~= nil then
		Page[pageid][Page[pageid].count].talkfunc = func
		if func1~= nil then 
			Page[pageid][Page[pageid].count].func1 = func1
			local p ={}
				p[1]= p1
				p[2]= p2
				p[3]= p3
				p[4]= p4
				p[5]= p5
				p[6]= p6
				p[7]= p7
				p[8]= p8
				p[9]= p9
				p[10]= p10
			if p[1]~= nil then
				Page[pageid][Page[pageid].count].p ={}
				Page[pageid][Page[pageid].count].p.count = 0
				local i = 0 
				for i = 1 ,10, 1 do 
					if p[i]~= nil then 
						Page[pageid][Page[pageid].count].p[i] = p[i]
						Page[pageid][Page[pageid].count].p.count = Page[pageid][Page[pageid].count].p.count+1
					else
						break
					end
				end
			end
		end
	end
	LG( "npcinit", "Talk:pageid, count, talk", pageid, Page[pageid].count, Page[pageid][Page[pageid].count].talk )
end

--对话选项信息注册
function Text( pageid, text, func, p1, p2, p3, p4 )
	Page[pageid].count = Page[pageid].count + 1
	Page[pageid][Page[pageid].count].text = text
	Page[pageid][Page[pageid].count].func = func
	Page[pageid][Page[pageid].count].p1 = p1
	Page[pageid][Page[pageid].count].p2 = p2
	Page[pageid][Page[pageid].count].p3 = p3
	Page[pageid][Page[pageid].count].p4 = p4
	LG( "npcinit", "Text:pageid, count, text, func, p1, p2, p3, p4 ", pageid, Page[pageid].count, text, func, p1, p2, p3, p4 )
end

--设置对话页包含任务信息
function MisListPage( pageid )
	Page[pageid].ismission = 1
	LG( "npcinit", "MisListPage:"..pageid )
end

--交易信息注册
function Weapon( id )
	--武器
	Trade[1].count = Trade[1].count + 1;
	Trade[1].item[Trade[1].count] = id
	LG( "npcinit", "Weapon:count, id", Trade[1].count, id )
end
function Defence( id )
	--防具
	Trade[2].count = Trade[2].count + 1;
	Trade[2].item[Trade[2].count] = id
	LG( "npcinit", "Defence:count, id", Trade[2].count, id )
end
function Other( id )
	--杂项
	Trade[3].count = Trade[3].count + 1;
	Trade[3].item[Trade[3].count] = id
	LG( "npcinit", "Other:count, id", Trade[3].count, id )
end
function OtherX( trade, id )
	trade[3].count = trade[3].count + 1;
	trade[3].item[trade[3].count] = id
end
function Synthesis( id )
	--合成
	Trade[4].count = Trade[4].count + 1;
	Trade[4].item[Trade[4].count] = id
	LG( "npcinit", "Synthesis:count, id", Trade[4].count, id )
end

--交易货物买卖收购信息
function SaleGoodsData( level, id, num, price, pricerange )
	if level == nil or id == nil or num == nil or price == nil or pricerange == nil then
		MISSDK_SCRIPTSDK_LUA_000019 = GetResString("MISSDK_SCRIPTSDK_LUA_000019")
		LG( "npcinit_error", MISSDK_SCRIPTSDK_LUA_000019, level, id, num, price, pricerange )
		return
	end
	
	Trade[1].count = Trade[1].count + 1	
	
	--记录货物数据
	Trade[1].item[Trade[1].count] = {}
	Trade[1].item[Trade[1].count].level = level
	Trade[1].item[Trade[1].count].id = id
	Trade[1].item[Trade[1].count].count = num
	Trade[1].item[Trade[1].count].num = num
	
	--物品价格信息
	Trade[1].price[Trade[1].count] = {}
	Trade[1].price[Trade[1].count].price = price
	Trade[1].price[Trade[1].count].range = pricerange
	Trade[1].price[Trade[1].count].curprice = price + Rand( pricerange )
	LG( "npcinit_trade", "SaleGoodsData, count, level, id, num, price, range, curprice", Trade[1].count, level, id, num, price, pricerange, Trade[1].price[Trade[1].count].curprice )
end

--初始化黑市兑换信息
function InitExchange()
	Exchange = {}
	Exchange.count = 0
	Exchange.srcid = {}
	Exchange.srcnum = {}
	Exchange.tarid = {}
	Exchange.tarnum = {}
	Exchange.timenum = {}
end

function InitExchangeX()
	ExchangeX = {}
	ExchangeX.count = 0
	ExchangeX.srcid = {}
	ExchangeX.srcnum = {}
	ExchangeX.tarid = {}
	ExchangeX.tarnum = {}
end

--黑市商人兑换
function ExchangeData( srcID, srcNum, tarID, tarNum, timeNum )
	if srcID == nil or srcNum == nil or tarID == nil or tarNum == nil or timeNum == nil then
		MISSDK_SCRIPTSDK_LUA_000020 = GetResString("MISSDK_SCRIPTSDK_LUA_000020")
		LG( "npcinit_error", MISSDK_SCRIPTSDK_LUA_000020, srcID, srcNum, tarID, tarNum, timeNum )
		return
	end
	
	Exchange.count = Exchange.count + 1	
	
	--兑换数据
	Exchange.srcid[Exchange.count] = srcID
	Exchange.srcnum[Exchange.count] = srcNum
	Exchange.tarid[Exchange.count] = tarID
	Exchange.tarnum[Exchange.count] = tarNum
	Exchange.timenum[Exchange.count] = timeNum
end

function ExchangeDataX( srcID, srcNum, tarID, tarNum )
	if srcID == nil or srcNum == nil or tarID == nil or tarNum == nil then
		MISSDK_SCRIPTSDK_LUA_000021 = GetResString("MISSDK_SCRIPTSDK_LUA_000021")
		LG( "npcinit_error", MISSDK_SCRIPTSDK_LUA_000021, srcID, srcNum, tarID, tarNum )
		return
	end
	
	ExchangeX.count = ExchangeX.count + 1	
	
	--兑换数据
	ExchangeX.srcid[ExchangeX.count] = srcID
	ExchangeX.srcnum[ExchangeX.count] = srcNum
	ExchangeX.tarid[ExchangeX.count] = tarID
	ExchangeX.tarnum[ExchangeX.count] = tarNum
end

--Leo的黑市商人加强版，全随机数
function DoExchange()
	local intMoney =0
	local intGoods =0
	local intMoneyNum =0

	local intNum=0
	local intCount=0

	for intCount=1 , 8 ,1 do
		intNum = math.floor(math.random(1,4))
		if intNum == 1 then	--摩力符石2个
			intMoney = 1028
			intMoneyNum = 2
			intGoods = MoliTable[math.floor(math.random(1,12))]
		elseif intNum ==2 then	--纳卡符石1个	
			intMoney = 3457
			intMoneyNum = 1
			intGoods = NakaTable[math.floor(math.random(1,22))]
		elseif intNum ==3 then	--精灵硬币1000个
			intMoney = 855
			intMoneyNum = 1000
			intGoods = CoinTable1000[math.floor(math.random(1,36))]
		elseif intNum ==4 then	--精灵硬币600个
			intMoney = 855
			intMoneyNum = 600
			intGoods = CoinTable600[math.floor(math.random(1,56))]
		end

		ExchangeData( intMoney, intMoneyNum , intGoods, 1, 1 )
	end
end

function BuyGoodsData( level, id, num, price, pricerange )
	if level == nil or id == nil or num == nil or price == nil or pricerange == nil then
		MISSDK_SCRIPTSDK_LUA_000022 = GetResString("MISSDK_SCRIPTSDK_LUA_000022")
		LG( "npcinit_error", MISSDK_SCRIPTSDK_LUA_000022, level, id, num, price, pricerange )
		return
	end
	
	Trade[2].count = Trade[2].count + 1
	
	--记录货物数据
	Trade[2].item[Trade[2].count] = {}
	Trade[2].item[Trade[2].count].level = level
	Trade[2].item[Trade[2].count].id = id
	Trade[2].item[Trade[2].count].count = num
	Trade[2].item[Trade[2].count].num = num
	
	--物品价格信息
	Trade[2].price[Trade[2].count] = {}
	Trade[2].price[Trade[2].count].price = price
	Trade[2].price[Trade[2].count].range = pricerange
	Trade[2].price[Trade[2].count].curprice = price + Rand( pricerange )
	LG( "npcinit_trade", "BuyGoodsData, count, level, id, num, price, range, curprice", Trade[2].count, level, id, num, price, pricerange, Trade[2].price[Trade[2].count].curprice )
end

--货物交易出售物品价格数量更新
function UpdateGoodsData( tradenpc )
	PRINT( "UpdateGoodsData" )
	if tradenpc == nil then
		MISSDK_SCRIPTSDK_LUA_000023 = GetResString("MISSDK_SCRIPTSDK_LUA_000023")
		PRINT( MISSDK_SCRIPTSDK_LUA_000023 )
		MISSDK_SCRIPTSDK_LUA_000023 = GetResString("MISSDK_SCRIPTSDK_LUA_000023")
		LG( MISSDK_SCRIPTSDK_LUA_000023 )
		return LUA_ERROR
	end

	local name = GetCharName( tradenpc )
	local ret, id = GetScriptID( tradenpc )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000024 = GetResString("MISSDK_SCRIPTSDK_LUA_000024")
		MISSDK_SCRIPTSDK_LUA_000025 = GetResString("MISSDK_SCRIPTSDK_LUA_000025")
		PRINT( MISSDK_SCRIPTSDK_LUA_000025..name..MISSDK_SCRIPTSDK_LUA_000024 )
		MISSDK_SCRIPTSDK_LUA_000024 = GetResString("MISSDK_SCRIPTSDK_LUA_000024")
		MISSDK_SCRIPTSDK_LUA_000025 = GetResString("MISSDK_SCRIPTSDK_LUA_000025")
		LG( "npctrade_error", MISSDK_SCRIPTSDK_LUA_000025..name..MISSDK_SCRIPTSDK_LUA_000024 )
		return LUA_FALSE
	end

	if NpcInfoList == nil or NpcInfoList[id] == nil then		
		MISSDK_SCRIPTSDK_LUA_000026 = GetResString("MISSDK_SCRIPTSDK_LUA_000026")
		MISSDK_SCRIPTSDK_LUA_000027 = GetResString("MISSDK_SCRIPTSDK_LUA_000027")
		PRINT( MISSDK_SCRIPTSDK_LUA_000027..name..MISSDK_SCRIPTSDK_LUA_000026, NpcInfoList, id )
		MISSDK_SCRIPTSDK_LUA_000028 = GetResString("MISSDK_SCRIPTSDK_LUA_000028")
		LG( "npctrade_error", "UpdateGoodsData:npc"..name..MISSDK_SCRIPTSDK_LUA_000028, NpcInfoList, id )
		return LUA_FALSE
	end
	
	MISSDK_SCRIPTSDK_LUA_000029 = GetResString("MISSDK_SCRIPTSDK_LUA_000029")
	PRINT( name..MISSDK_SCRIPTSDK_LUA_000029 )	
	local trade = NpcInfoList[id].trade
	for n = 1, trade[1].count, 1 do
		trade[1].item[n].count = trade[1].item[n].num
		trade[1].price[n].curprice = trade[1].price[n].price + Rand( trade[1].price[n].range )
		MISSDK_SCRIPTSDK_LUA_000030 = GetResString("MISSDK_SCRIPTSDK_LUA_000030")
		PRINT( MISSDK_SCRIPTSDK_LUA_000030, trade[1].item[n].id, trade[1].item[n].count, trade[1].price[n].curprice )
	end
	
	for n = 1, trade[2].count, 1 do
		trade[2].item[n].count = trade[2].item[n].num
		trade[2].price[n].curprice = trade[2].price[n].price + Rand( trade[2].price[n].range )
		MISSDK_SCRIPTSDK_LUA_000031 = GetResString("MISSDK_SCRIPTSDK_LUA_000031")
		PRINT( MISSDK_SCRIPTSDK_LUA_000031, trade[2].item[n].id, trade[2].item[n].count, trade[2].price[n].curprice )
	end
	
	SendAllGoodsData( tradenpc, trade )
	return LUA_TRUE	
end

--定时更新出售货物种类
function UpdateGoodsKinds( tradenpc )
	PRINT( "UpdateGoodsData" )
	if tradenpc == nil then
		MISSDK_SCRIPTSDK_LUA_000023 = GetResString("MISSDK_SCRIPTSDK_LUA_000023")
		PRINT( MISSDK_SCRIPTSDK_LUA_000023 )
		MISSDK_SCRIPTSDK_LUA_000023 = GetResString("MISSDK_SCRIPTSDK_LUA_000023")
		LG( MISSDK_SCRIPTSDK_LUA_000023 )
		return LUA_ERROR
	end

	local name = GetCharName( tradenpc )
	local ret, id = GetScriptID( tradenpc )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000024 = GetResString("MISSDK_SCRIPTSDK_LUA_000024")
		MISSDK_SCRIPTSDK_LUA_000025 = GetResString("MISSDK_SCRIPTSDK_LUA_000025")
		PRINT( MISSDK_SCRIPTSDK_LUA_000025..name..MISSDK_SCRIPTSDK_LUA_000024 )
		MISSDK_SCRIPTSDK_LUA_000024 = GetResString("MISSDK_SCRIPTSDK_LUA_000024")
		MISSDK_SCRIPTSDK_LUA_000025 = GetResString("MISSDK_SCRIPTSDK_LUA_000025")
		LG( "npctrade_error", MISSDK_SCRIPTSDK_LUA_000025..name..MISSDK_SCRIPTSDK_LUA_000024 )
		return LUA_FALSE
	end

	if NpcInfoList == nil or NpcInfoList[id] == nil then		
		MISSDK_SCRIPTSDK_LUA_000026 = GetResString("MISSDK_SCRIPTSDK_LUA_000026")
		MISSDK_SCRIPTSDK_LUA_000027 = GetResString("MISSDK_SCRIPTSDK_LUA_000027")
		PRINT( MISSDK_SCRIPTSDK_LUA_000027..name..MISSDK_SCRIPTSDK_LUA_000026, NpcInfoList, id )
		MISSDK_SCRIPTSDK_LUA_000028 = GetResString("MISSDK_SCRIPTSDK_LUA_000028")
		LG( "npctrade_error", "UpdateGoodsData:npc"..name..MISSDK_SCRIPTSDK_LUA_000028, NpcInfoList, id )
		return LUA_FALSE
	end
	
	MISSDK_SCRIPTSDK_LUA_000029 = GetResString("MISSDK_SCRIPTSDK_LUA_000029")
	PRINT( name..MISSDK_SCRIPTSDK_LUA_000029 )	
	
	local trade = NpcInfoList[id].trade
	InitTradeX( trade )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	OtherX( trade, rand() )
	SendTradeUpdate( tradenpc, tradenpc, trade, TRADE_BUY, 0 )
	
	InitExchange()
	DoExchange()
	SendExchangeUpdateData( tradenpc, tradenpc )
	
	return LUA_TRUE
end

--初始化全局多函数列表
function InitFuncList()
	LG( "npcinit", "InitFuncList" )
	FuncList = {}
	FuncList.count = 0
end

--添加函数列表信息
function AddFuncList( func, p1, p2, p3, p4 )
	FuncList.count = FuncList.count + 1
	FuncList[FuncList.count] = {}
	FuncList[FuncList.count].func = func
	FuncList[FuncList.count].p1 = p1
	FuncList[FuncList.count].p2 = p2
	FuncList[FuncList.count].p3 = p3
	FuncList[FuncList.count].p4 = p4
	LG( "npcinit", "AddFuncList, func, p1, p2, p3, p4", func, p1, p2, p3, p4 )
end

--获取函数列表信息
function GetFuncList()
	return FuncList
end

function GetNumFunc()
	return FuncList.count
end

--初始化全局触发器
function InitTrigger()
	LG( "trigger", "InitTrigger" )
	Trigger = {}	
	for n = 1, 16, 1 do
		Trigger[n] = {}
		Trigger[n].tp = MIS_TRIGGER_NOMAL
		Trigger[n].conditions = {}
		Trigger[n].conditions.count = 0
		Trigger[n].actions = {}
		Trigger[n].actions.count = 0
		Trigger[n].failures = {}
		Trigger[n].failures.count = 0
		--for i = 1, 12, 1 do
			--Trigger[n].conditions[i] = {}
			--Trigger[n].actions[i] = {}
			--Trigger[n].failures[i] = {}
		--end
	end
end

--设置触发器的事件类型和启动方式
function SetTrigger( id, startup, event )	
	if Trigger[id] == nil then
		MISSDK_SCRIPTSDK_LUA_000032 = GetResString("MISSDK_SCRIPTSDK_LUA_000032")
		return LG( "trigger", MISSDK_SCRIPTSDK_LUA_000032..id )		
	end
	Trigger[id].startup = startup
	Trigger[id].event   = event 
end

--触发器类型设定
function SetTriggerType( id, tp )
	LG( "trigger", "SetTriggerType: id, tp ", id, tp )
	Trigger[id].tp = tp
end

--触发器条件函数注册
function TriggerCondition( id, func, p1, p2, p3, p4 )
	LG( "trigger", "TriggerCondition: id, func, p1, p2, p3, p4 ", id, func, p1, p2, p3, p4 )
	Trigger[id].conditions.count = Trigger[id].conditions.count + 1
	Trigger[id].conditions[Trigger[id].conditions.count] = {}
	Trigger[id].conditions[Trigger[id].conditions.count].func = func
	Trigger[id].conditions[Trigger[id].conditions.count].p1 = p1
	Trigger[id].conditions[Trigger[id].conditions.count].p2 = p2
	Trigger[id].conditions[Trigger[id].conditions.count].p3 = p3
	Trigger[id].conditions[Trigger[id].conditions.count].p4 = p4
end

--随机任务修改全局触发器动作函数参数值
function SetTriggerActionValue( id, index, p1, p2, p3, p4 )
	if id == nil or index == nil or TriggerList[id] == nil then
		MISSDK_SCRIPTSDK_LUA_000033 = GetResString("MISSDK_SCRIPTSDK_LUA_000033")
		PRINT( MISSDK_SCRIPTSDK_LUA_000033, id, index )
		MISSDK_SCRIPTSDK_LUA_000034 = GetResString("MISSDK_SCRIPTSDK_LUA_000034")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000034, id, index )
		return LUA_FALSE
	end
	
	if TriggerList[id].actions == nil or TriggerList[id].actions[index] == nil then
		MISSDK_SCRIPTSDK_LUA_000035 = GetResString("MISSDK_SCRIPTSDK_LUA_000035")
		PRINT( MISSDK_SCRIPTSDK_LUA_000035, id, index )
		MISSDK_SCRIPTSDK_LUA_000035 = GetResString("MISSDK_SCRIPTSDK_LUA_000035")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000035, id, index )
		return LUA_FALSE
	end
	TriggerList[id].actions[index].p1 = p1
	TriggerList[id].actions[index].p2 = p2
	TriggerList[id].actions[index].p3 = p3
	TriggerList[id].actions[index].p4 = p4
end

--触发器动作函数注册
function TriggerAction( id, func, p1, p2, p3, p4, p5, p6, p7, p8 )
	LG( "trigger", "TriggerAction: id, func, p1, p2, p3, p4 ", id, func, p1, p2, p3, p4 )
	Trigger[id].actions.count = Trigger[id].actions.count + 1
	Trigger[id].actions[Trigger[id].actions.count] = {}
	Trigger[id].actions[Trigger[id].actions.count].func = func
	Trigger[id].actions[Trigger[id].actions.count].p1 = p1
	Trigger[id].actions[Trigger[id].actions.count].p2 = p2
	Trigger[id].actions[Trigger[id].actions.count].p3 = p3
	Trigger[id].actions[Trigger[id].actions.count].p4 = p4
	if p5 ~= nil then
		Trigger[id].actions[Trigger[id].actions.count].p5 = p5
	else
		Trigger[id].actions[Trigger[id].actions.count].p5 = 0
	end
	if p6 ~= nil then
		Trigger[id].actions[Trigger[id].actions.count].p6 = p6
	else
		Trigger[id].actions[Trigger[id].actions.count].p6 = 0
	end
	if p7 ~= nil then
		Trigger[id].actions[Trigger[id].actions.count].p7 = p7
	else
		Trigger[id].actions[Trigger[id].actions.count].p7 = 0
	end
	if p8 ~= nil then
		Trigger[id].actions[Trigger[id].actions.count].p8 = p8
	else
		Trigger[id].actions[Trigger[id].actions.count].p8 = 0
	end	
end

function TriggerFailure( id, func, p1, p2, p3, p4, p5, p6, p7, p8 )
	LG( "trigger", "TriggerFailure: id, func, p1, p2, p3, p4 ", id, func, p1, p2, p3, p4 )
	Trigger[id].failures.count = Trigger[id].failures.count + 1
	Trigger[id].failures[Trigger[id].failures.count] = {}
	Trigger[id].failures[Trigger[id].failures.count].func = func
	Trigger[id].failures[Trigger[id].failures.count].p1 = p1
	Trigger[id].failures[Trigger[id].failures.count].p2 = p2
	Trigger[id].failures[Trigger[id].failures.count].p3 = p3
	Trigger[id].failures[Trigger[id].failures.count].p4 = p4
	if p5 ~= nil then
		Trigger[id].failures[Trigger[id].failures.count].p5 = p5
	else
		Trigger[id].failures[Trigger[id].failures.count].p5 = 0
	end
	if p6 ~= nil then	
		Trigger[id].failures[Trigger[id].failures.count].p6 = p6
	else
		Trigger[id].failures[Trigger[id].failures.count].p6 = 0
	end
	if p7 ~= nil then
		Trigger[id].failures[Trigger[id].failures.count].p7 = p7
	else
		Trigger[id].failures[Trigger[id].failures.count].p7 = 0
	end
	if p8 ~= nil then
		Trigger[id].failures[Trigger[id].failures.count].p8 = p8
	else
		Trigger[id].failures[Trigger[id].failures.count].p8 = 0
	end
end

--获取全局触发器信息
function GetTrigger( id )
	return Trigger[id]
end

function GetMultiTrigger()
	return Trigger
end

--注册当前触发器到全局触发器信息中
function RegTrigger( id, triggerid )
	if id == nil or triggerid == nil then
		MISSDK_SCRIPTSDK_LUA_000036 = GetResString("MISSDK_SCRIPTSDK_LUA_000036")
		PRINT( MISSDK_SCRIPTSDK_LUA_000036 )
	end
	if Trigger[triggerid] == nil then
		MISSDK_SCRIPTSDK_LUA_000037 = GetResString("MISSDK_SCRIPTSDK_LUA_000037")
		LG( "trigger_error", MISSDK_SCRIPTSDK_LUA_000037..triggerid )
		return
	end
	if TriggerList[id] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000038 = GetResString("MISSDK_SCRIPTSDK_LUA_000038")
		LG( "trigger_error", MISSDK_SCRIPTSDK_LUA_000038..id )
	end
	TriggerList[id] = Trigger[triggerid]
end

function RegCurTrigger( id )
	RegTrigger( id, 1 )
end

--对话开始触发器注册
function Start( trigger, count )
	LG( "trigger", "Start:trigger, count", trigger, count )
	Page.start = MultiTrigger
	Page.p1 = trigger
	Page.p2 = count
end

function Popup( trigger, p2 )
	Page.start = PopupWindow
	Page.p1 = trigger
	Page.p2 = p2
end

--手动将触发器添加到NPC身上
function SetNpcTrigger( trigger )
	PRINT( "SetNpcTrigger, trigger = , npc = ", trigger, NpcPointer )
	if trigger == nil or trigger.actions == nil then
		LG( "trigger_error", "SetNpcTrigger: trigger = nil or trigger.actions = nil" )
		PRINT( "SetNpcTrigger: trigger = nil or trigger.actions = nil" )
		return
	end
	local ret = ActionsProc( NpcPointer, trigger.actions, NpcPointer, nil, 0, nil )
	if ret ~= LUA_TRUE then
		LG( "trigger_error", "SetNpcTrigger: ActionsProc called error!" )
		PRINT( "SetNpcTrigger: ActionsProc called error!" )
	end
end

--设置当前初始化NPC为激活状态
function SetNpcActive()
	PRINT( "SetNpcActive" )
	local ret = SetActive( NpcPointer )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000039 = GetResString("MISSDK_SCRIPTSDK_LUA_000039")
		PRINT( MISSDK_SCRIPTSDK_LUA_000039..GetCharName( NpcPointer ) )
		MISSDK_SCRIPTSDK_LUA_000039 = GetResString("MISSDK_SCRIPTSDK_LUA_000039")
		LG( "npcinit_error", MISSDK_SCRIPTSDK_LUA_000039..GetCharName( NpcPointer ) )
	end
end

--任务基本信息注册
function DefineMission( id, name, misid, show, mistp )
	LG( "missionIDLOG", "ID: "..id, " Name:"..name, " MisID:"..misid )
	--设置任务基本信息
	
	MissionSid[misid]=id
	Mission[id] = {}
	Mission[id].id = misid		--任务识别ID
	Mission[id].sid = id 		--脚本任务索引ID
	Mission[id].name = name
	if mistp == nil then
		Mission[id].tp = NOMAL_MISSION
	else
		Mission[id].tp = mistp
	end
	if show == nil then
		Mission[id].show = ALWAYS_SHOW
	else
		Mission[id].show = show
	end
	--设置当前任务
	Mission.curmission = Mission[id]
	--任务需求和奖励信息
	Mission[id].need = {}
	Mission[id].need.count = 0
	Mission[id].prize = {}
	Mission[id].prize.count = 0
	--默认任务奖励方式为多选一
	Mission[id].prize.seltp = PRIZE_SELONE
	--任务开始信息
	Mission[id].begin = {}
	Mission[id].begin.talk = ""
	Mission[id].begin.conditions = {}
	Mission[id].begin.conditions.count = 0
	Mission[id].begin.actions = {}
	Mission[id].begin.actions.count = 0
	Mission[id].begin.baggrid = 0
	--任务交付信息
	Mission[id].result = {}
	Mission[id].result.talk = ""
	Mission[id].result.help = ""
	Mission[id].result.conditions = {}
	Mission[id].result.conditions.count = 0
	Mission[id].result.actions = {}
	Mission[id].result.actions.count = 0
	Mission[id].result.baggrid = 0
	--任务取消信息
	Mission[id].cancel = {}
	Mission[id].cancel.conditions = {}
	Mission[id].cancel.conditions.count = 0
	Mission[id].cancel.actions = {}
	Mission[id].cancel.actions.count = 0
end

--定义一个世界任务
function DefineWorldMission( id, name, misid )
	DefineMission( id, name, misid, nil, WORLD_MISSION )
end

--任务触发器信息注册函数
function MisBeginTalk( str )
	Mission.curmission.begin.talk = str
	LG( "mission", "MisBeginTalk:talk = "..str )
end

--任务完成需求信息
function MisNeed( needtype, p1, p2, p3, p4 )
	Mission.curmission.need.count = Mission.curmission.need.count + 1
	Mission.curmission.need[Mission.curmission.need.count] = {}
	Mission.curmission.need[Mission.curmission.need.count].tp = needtype
	Mission.curmission.need[Mission.curmission.need.count].p1 = p1
	Mission.curmission.need[Mission.curmission.need.count].p2 = p2
	Mission.curmission.need[Mission.curmission.need.count].p3 = p3
	Mission.curmission.need[Mission.curmission.need.count].p4 = p4
	LG( "mission", "MisNeed:count, type, p1, p2, p3, p4", Mission.curmission.need.count, needtype, p1, p2, p3, p4 )
end

--任务完成奖励信息
function MisPrize( prizetype, p1, p2, p3, p4 )
	Mission.curmission.prize.count = Mission.curmission.prize.count + 1
	Mission.curmission.prize[Mission.curmission.prize.count] = {}
	Mission.curmission.prize[Mission.curmission.prize.count].tp = prizetype
	Mission.curmission.prize[Mission.curmission.prize.count].p1 = p1
	Mission.curmission.prize[Mission.curmission.prize.count].p2 = p2
	Mission.curmission.prize[Mission.curmission.prize.count].p3 = p3
	Mission.curmission.prize[Mission.curmission.prize.count].p4 = p4
	LG( "mission", "MisPrize:count, type, p1, p2, p3, p4", Mission.curmission.prize.count, prizetype, p1, p2, p3, p4 )
end

--任务完成奖励类型
function MisPrizeType( seltype )
   LG( "mission", "MisPrizeType: prize select type = "..seltype )
   Mission.curmission.prize.seltp = seltype
end

function MisPrizeSelOne()
	MisPrizeType( PRIZE_SELONE )
end

function MisPrizeSelAll()
	MisPrizeType( PRIZE_SELALL )
end

--任务开始条件信息注册
function MisBeginCondition( func, p1, p2, p3, p4 )
	Mission.curmission.begin.conditions.count = Mission.curmission.begin.conditions.count + 1
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count] = {}
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count].func = func
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count].p1 = p1
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count].p2 = p2
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count].p3 = p3	
	Mission.curmission.begin.conditions[Mission.curmission.begin.conditions.count].p4 = p4
	LG( "mission", "MisBeginCondition:count, func, p1, p2, p3, p4", Mission.curmission.begin.conditions.count, func, p1, p2, p3, p4 )
end

--任务开始动作信息注册
function MisBeginAction( func, p1, p2, p3, p4, p5, p6, p7, p8 )
	Mission.curmission.begin.actions.count = Mission.curmission.begin.actions.count + 1
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count] = {}
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].func = func
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p1 = p1
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p2 = p2
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p3 = p3	
	Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p4 = p4	
	if p5 ~= nil then
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p5 = p5
	else
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p5 = 0
	end
	if p6 ~= nil then
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p6 = p6
	else
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p6 = 0
	end
	if p7 ~= nil then
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p7 = p7
	else
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p7 = 0
	end
	if p8 ~= nil then
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p8 = p8
	else
		Mission.curmission.begin.actions[Mission.curmission.begin.actions.count].p8 = 0
	end
	
	LG( "mission", "MisBeginAction:count, func, p1, p2, p3, p4, p5, p6, p7, p8", Mission.curmission.begin.actions.count, func, p1, p2, p3, p4, p5, p6, p7, p8 )
end

--任务开始角色背包容量需求
function MisBeginBagNeed( num )
	Mission.curmission.begin.baggrid = num
end

--任务交付完成对话信息注册
function MisResultTalk( str )
	Mission.curmission.result.talk = str
	LG( "mission", "MisCompleteTalk:talk = "..str )
end

--任务交付帮助对话信息注册
function MisHelpTalk( str )
	Mission.curmission.result.help = str
	LG( "mission", "MisHelpTalk:help = "..str )
end

--任务完成条件信息注册
function MisResultCondition( func, p1, p2, p3, p4 )
	Mission.curmission.result.conditions.count = Mission.curmission.result.conditions.count + 1
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count] = {}
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count].func = func
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count].p1 = p1
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count].p2 = p2
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count].p3 = p3
	Mission.curmission.result.conditions[Mission.curmission.result.conditions.count].p4 = p4
	LG( "mission", "MisResultCondition:count, func, p1, p2, p3, p4", Mission.curmission.result.conditions.count, func, p1, p2, p3, p4 )
end

--任务完成动作信息注册
function MisResultAction( func, p1, p2, p3, p4, p5, p6, p7, p8 )
	Mission.curmission.result.actions.count = Mission.curmission.result.actions.count + 1
	Mission.curmission.result.actions[Mission.curmission.result.actions.count] = {}
	Mission.curmission.result.actions[Mission.curmission.result.actions.count].func = func
	Mission.curmission.result.actions[Mission.curmission.result.actions.count].p1 = p1
	Mission.curmission.result.actions[Mission.curmission.result.actions.count].p2 = p2
	Mission.curmission.result.actions[Mission.curmission.result.actions.count].p3 = p3
	Mission.curmission.result.actions[Mission.curmission.result.actions.count].p4 = p4
	if p5 ~= nil then
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p5 = p5
	else
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p5 = 0
	end
	if p6 ~= nil then
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p6 = p6
	else
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p6 = 0
	end
	if p7 ~= nil then
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p7 = p7
	else
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p7 = 0
	end
	if p8 ~= nil then
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p8 = p8
	else
		Mission.curmission.result.actions[Mission.curmission.result.actions.count].p8 = 0
	end	
	LG( "mission", "MisResultAction:count, func, p1, p2, p3, p4, p5, p6, p7, p8", Mission.curmission.result.actions.count, func, p1, p2, p3, p4, p5, p6, p7, p8 )
end

--任务完成时背包容量需求
function MisResultBagNeed( num )
	Mission.curmission.result.baggrid = num
end

--任务取消条件信息注册
function MisCancelCondition( func, p1, p2, p3, p4 )
	Mission.curmission.cancel.conditions.count = Mission.curmission.cancel.conditions.count + 1
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count] = {}
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count].func = func
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count].p1 = p1
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count].p2 = p2
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count].p3 = p3
	Mission.curmission.cancel.conditions[Mission.curmission.cancel.conditions.count].p4 = p4
	LG( "mission", "MisCancelCondition:count, func, p1, p2, p3, p4", Mission.curmission.cancel.conditions.count, func, p1, p2, p3, p4 )
end

--任务取消动作信息注册
function MisCancelAction( func, p1, p2, p3, p4, p5, p6, p7, p8 )
	Mission.curmission.cancel.actions.count = Mission.curmission.cancel.actions.count + 1
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count] = {}
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].func = func
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p1 = p1
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p2 = p2
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p3 = p3
	Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p4 = p4
	if p5 ~= nil then
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p5 = p5
	else
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p5 = 0
	end
	if p6 ~= nil then
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p6 = p6
	else
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p6 = 0
	end
	if p7 ~= nil then
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p7 = p7
	else
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p7 = 0
	end
	if p8 ~= nil then
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p8 = p8
	else
		Mission.curmission.cancel.actions[Mission.curmission.cancel.actions.count].p8 = 0
	end	
	LG( "mission", "MisCancelAction:count, func, p1, p2, p3, p4, p5, p6, p7, p8", Mission.curmission.cancel.actions.count, func, p1, p2, p3, p4, p5, p6, p7, p8 )
end

--将任务注册到npc身上
function AddNpcMission( id )
	NpcMissionList.count = NpcMissionList.count + 1
	NpcMissionList[NpcMissionList.count ] = {}
	NpcMissionList[NpcMissionList.count ] = Mission[id]
	MISSDK_SCRIPTSDK_LUA_000040 = GetResString("MISSDK_SCRIPTSDK_LUA_000040")
	MISSDK_SCRIPTSDK_LUA_000041 = GetResString("MISSDK_SCRIPTSDK_LUA_000041")
	MISSDK_SCRIPTSDK_LUA_000042 = GetResString("MISSDK_SCRIPTSDK_LUA_000042")
	MISSDK_SCRIPTSDK_LUA_000043 = GetResString("MISSDK_SCRIPTSDK_LUA_000043")
	PRINT( MISSDK_SCRIPTSDK_LUA_000043..NpcMissionList.count..MISSDK_SCRIPTSDK_LUA_000042..id..MISSDK_SCRIPTSDK_LUA_000041..Mission[id].name..MISSDK_SCRIPTSDK_LUA_000040 )
	MISSDK_SCRIPTSDK_LUA_000040 = GetResString("MISSDK_SCRIPTSDK_LUA_000040")
	MISSDK_SCRIPTSDK_LUA_000041 = GetResString("MISSDK_SCRIPTSDK_LUA_000041")
	MISSDK_SCRIPTSDK_LUA_000042 = GetResString("MISSDK_SCRIPTSDK_LUA_000042")
	MISSDK_SCRIPTSDK_LUA_000043 = GetResString("MISSDK_SCRIPTSDK_LUA_000043")
	LG( "missioninit", MISSDK_SCRIPTSDK_LUA_000043..NpcMissionList.count..MISSDK_SCRIPTSDK_LUA_000042..id..MISSDK_SCRIPTSDK_LUA_000041..Mission[id].name..MISSDK_SCRIPTSDK_LUA_000040 )
end

--初始化随机任务参数表结构
function InitRandParam()
	RandParam = {}
	RandParam.id = 0
	RandParam.sid = 0
	RandParam.tp = 0
	RandParam.bounty = 0
	RandParam.exptp = MIS_EXP_NOMAL
	RandParam.level = 0
	RandParam.numdata = 0
	RandParam.money = 0
	RandParam.exp = 0
	RandParam.prizetp = 0
	RandParam.prizedata = 0
	RandParam.p1 = 0
	RandParam.p2 = 0
	RandParam.npcname = ""
	RandParam.npcarea = ""
	RandParam.data = {}
	for n = 1, 4, 1 do
		RandParam.data[n] = {}
		RandParam.data[n].p1 = 0
		RandParam.data[n].p2 = 0
		RandParam.data[n].p3 = 0
		RandParam.data[n].p4 = 0
	end
end

--随机任务信息脚本生成函数接口
function DefineRandMission( id, name, misid, bounty, npcname, npcarea, leveltp )
	LG( "randmission_init", "ID: "..id, " Name:"..name, " MisID:"..misid, "Bounty:"..bounty )
	--设置任务基本信息
	Mission[id] = {}
	Mission[id].id = misid		--任务识别ID
	Mission[id].sid = id 		--脚本任务索引ID
	Mission[id].name = name
	Mission[id].tp = RAND_MISSION
	Mission[id].bounty = bounty --任务给予物品奖励度
	if leveltp == nil then
		Mission[id].leveltp = MIS_LEVEL_CHAR
	else
		Mission[id].leveltp = leveltp
	end
	Mission[id].show = ALWAYS_SHOW
	Mission[id].missionlist = {}
	Mission[id].missionlist.count = 0
	Mission[id].loopinfo = {}
	Mission[id].loopinfo.count = 0
	
	if npcname ~= nil and npcarea ~= nil then
		Mission[id].npcname = npcname
		Mission[id].npcarea  = npcarea
	else
		MISSDK_SCRIPTSDK_LUA_000044 = GetResString("MISSDK_SCRIPTSDK_LUA_000044")
		Mission[id].npcname = MISSDK_SCRIPTSDK_LUA_000044
		MISSDK_SCRIPTSDK_LUA_000045 = GetResString("MISSDK_SCRIPTSDK_LUA_000045")
		Mission[id].npcarea  = MISSDK_SCRIPTSDK_LUA_000045
	end	
	
	--设置当前任务
	Mission.curmission = Mission[id]
	--任务开始信息
	Mission[id].begin = {}
	Mission[id].begin.talk = ""
	Mission[id].begin.conditions = {}
	Mission[id].begin.conditions.count = 0
	Mission[id].begin.actions = {}
	Mission[id].begin.actions.count = 0
	Mission[id].begin.baggrid = 0
	--任务交付信息
	Mission[id].result = {}
	Mission[id].result.talk = ""
	Mission[id].result.help = ""
	Mission[id].result.conditions = {}
	Mission[id].result.conditions.count = 0
	Mission[id].result.actions = {}
	Mission[id].result.actions.count = 0
	Mission[id].result.baggrid = 0
	--任务取消信息
	Mission[id].cancel = {}
	Mission[id].cancel.conditions = {}
	Mission[id].cancel.conditions.count = 0
	Mission[id].cancel.actions = {}
	Mission[id].cancel.actions.count = 0
end

--初始化随机任务前后缀信息列表
function InitTalkList()
	MISSDK_SCRIPTSDK_LUA_000046 = GetResString("MISSDK_SCRIPTSDK_LUA_000046")
	talklist.btalkstart = MISSDK_SCRIPTSDK_LUA_000046
	MISSDK_SCRIPTSDK_LUA_000047 = GetResString("MISSDK_SCRIPTSDK_LUA_000047")
	talklist.btalkend = MISSDK_SCRIPTSDK_LUA_000047
	MISSDK_SCRIPTSDK_LUA_000048 = GetResString("MISSDK_SCRIPTSDK_LUA_000048")
	talklist.rtalkstart = MISSDK_SCRIPTSDK_LUA_000048
	MISSDK_SCRIPTSDK_LUA_000049 = GetResString("MISSDK_SCRIPTSDK_LUA_000049")
	talklist.rtalkend = MISSDK_SCRIPTSDK_LUA_000049
	MISSDK_SCRIPTSDK_LUA_000050 = GetResString("MISSDK_SCRIPTSDK_LUA_000050")
	talklist.helpstart = MISSDK_SCRIPTSDK_LUA_000050
	MISSDK_SCRIPTSDK_LUA_000051 = GetResString("MISSDK_SCRIPTSDK_LUA_000051")
	talklist.helpend = MISSDK_SCRIPTSDK_LUA_000051
end

--添加随机任务描述信息前缀后缀
function AddRandMissionBeginTalk( talkstart, talkend )
	if talkstart == nil or talkend  == nil then
		LG( "randmission_inittalk_error", "AddRandMissionBeginTalk: misid = , ", Mission.curmission.sid )
		return
	end
	
	LG( "randmission_init", "AddRandMissionBeginTalk: talkstart = ", talkstart )
	LG( "randmission_init", "AddRandMissionBeginTalk: talkend = ", talkend )
	talklist.btalkstart = talkstart
	talklist.btalkend = talkend
end

function AddRandMissionResultTalk( talkstart, talkend )
	if talkstart == nil or talkend  == nil then
		LG( "randmission_inittalk_error", "AddRandMissionBeginTalk: misid = , ", Mission.curmission.sid )
		return
	end

	LG( "randmission_init", "AddRandMissionResultTalk: talkstart = ", talkstart )
	LG( "randmission_init", "AddRandMissionResultTalk: talkend = ", talkend )	
	talklist.rtalkstart = talkstart
	talklist.rtalkend = talkend
end

function AddRandMissionHelpTalk( talkstart, talkend )
	if talkstart == nil or talkend  == nil then
		LG( "randmission_inittalk_error", "AddRandMissionBeginTalk: misid = , ", Mission.curmission.sid )
		return
	end
	
	LG( "randmission_init", "AddRandMissionHelpTalk: talkstart = ", talkstart )
	LG( "randmission_init", "AddRandMissionHelpTalk: talkend = ", talkend )	
	talklist.helpstart = talkstart
	talklist.helpend = talkend
end

--获取随机任务描述前后缀信息列表
function GetRandMissionTalk()
	return talklist
end

--添加当前随机任务的类型信息
function AddRandMissionType( tp, tprand, talklist, exptp, randnum, p1, p2, p3, p4, p5, p6 )
	if Mission.curmission == nil or tp == nil or tprand == nil or exptp == nil or randnum == nil then
		PRINT( "AddRandMissionType:Mission[id] = nil or tp = nil, exptp = nil or id = "..Mission.curmission.sid..",tp = "..tp )
		return
	end
   
	LG( "randmission_init", "AddRandMissionType:Add rand mission id["..Mission.curmission.sid.."], tp = "..tp )
	
	--检测类型信息
	for n = 1, Mission.curmission.missionlist.count, 1 do
		if Mission.curmission.missionlist[n].tp == tp then
			MISSDK_SCRIPTSDK_LUA_000052 = GetResString("MISSDK_SCRIPTSDK_LUA_000052")
			PRINT( MISSDK_SCRIPTSDK_LUA_000052..tp )
			return
		end
	end
	
	--新增类型信息
	Mission.curmission.missionlist.count = Mission.curmission.missionlist.count + 1
	Mission.curmission.missionlist[Mission.curmission.missionlist.count] = {}
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].tp = tp
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].exptp = exptp
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].randnum = randnum

	--任务数据初始化
	local begin = {}
	local result = {}
	local cancel = {}
	local need = {}
	local prize = {}

	begin.conditions = {}
	begin.conditions.count = 0
	begin.actions = {}
	begin.actions.count = 0
	begin.baggrid = 0
	result.conditions = {}
	result.conditions.count = 0
	result.actions = {}
	result.actions.count = 0
	result.baggrid = 0
	cancel.conditions = {}
	cancel.conditions.count = 0
	cancel.actions = {}
	cancel.actions.count = 0
	need.count = 0
	prize.count = 0
	--默认任务奖励方式为全选	
	prize.seltp = PRIZE_SELALL
	--默认任务描述信息为空
	begin.talk = ""
	begin.talkstart = talklist.btalkstart
	begin.talkend = talklist.btalkend
	result.talk = ""
	result.talkstart = talklist.rtalkstart
	result.talkend = talklist.rtalkend
	result.help = ""
	result.helpstart = talklist.helpstart
	result.helpend = talklist.helpend
	
	if tp == MIS_RAND_KILL then
		--随机任务奖励和需求
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = ""
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_KILL
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_KILL
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_KILL
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_KILL
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		prize.count = prize.count + 1
		prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_MONEY
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		prize.count = prize.count + 1
        prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_ITEM
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		--任务开始
		--begin.conditions.count = begin.conditions.count + 1
		--begin.conditions[begin.conditions.count] = {}
		--begin.conditions[begin.conditions.count].func = NoRandMission
		--begin.conditions[begin.conditions.count].p1 = Mission.curmission.id
		
		--begin.actions.count = begin.actions.count + 1
		--begin.actions[begin.actions.count] = {}
		--begin.actions[begin.actions.count].func = AddRandMission
		--begin.actions[begin.actions.count].p1 = Mission.curmission.id
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p1
		begin.actions[begin.actions.count].p2 = TE_KILL
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p2
		begin.actions[begin.actions.count].p2 = TE_KILL
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
        begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p3
		begin.actions[begin.actions.count].p2 = TE_KILL
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p4
		begin.actions[begin.actions.count].p2 = TE_KILL
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		--任务结束条件
		--result.conditions.count = result.conditions.count + 1
		--result.conditions[result.conditions.count] = {}
		--result.conditions[result.conditions.count].func = HasRandMission
		--result.conditions[result.conditions.count].p1 = Mission.curmission.id
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		--任务结束动作
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = ClearMission
		result.actions[result.actions.count].p1 = Mission.curmission.id
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = AddExpAndType	--AddExp
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		result.actions[result.actions.count].p3 = 0
		
		--任务取消动作
		InitTrigger()
		TriggerCondition( 1, HasCancelMissionMoney )
		TriggerAction( 1, TakeCancelMissionMoney )
		TriggerAction( 1, ClearMission, Mission.curmission.id )
		TriggerAction( 1, FailureRandMissionCount, Mission.curmission.id )
		
		MISSDK_SCRIPTSDK_LUA_000053 = GetResString("MISSDK_SCRIPTSDK_LUA_000053")
		TriggerAction( 2, SystemNotice, MISSDK_SCRIPTSDK_LUA_000053 )

		cancel.actions.count = cancel.actions.count + 1
		cancel.actions[cancel.actions.count] = {}
		cancel.actions[cancel.actions.count].func = MultiTrigger
		cancel.actions[cancel.actions.count].p1 = GetMultiTrigger()
		cancel.actions[cancel.actions.count].p2 = 2
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = ClearMission
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = FailureRandMissionCount
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
				
		--建立最大4个全局触发器用于随机任务
		InitTrigger()
		SetTriggerType( 1, MIS_TRIGGER_RAND )
		--TriggerCondition( 1, IsMonster, 0 )
		TriggerAction( 1, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p1, 1 )
		
		SetTriggerType( 2, MIS_TRIGGER_RAND )
		--TriggerCondition( 2, IsMonster, 0 )
		TriggerAction( 2, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 2, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p2, 2 )
		
		SetTriggerType( 3, MIS_TRIGGER_RAND )
		--TriggerCondition( 3, IsMonster, 0 )
		TriggerAction( 3, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 3, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p3, 3 )
		
		SetTriggerType( 4, MIS_TRIGGER_RAND )
		--TriggerCondition( 4, IsMonster, 0 )
		TriggerAction( 4, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 4, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p4, 4 )
		
	elseif tp == MIS_RAND_GET then
		--随机任务奖励和需求
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = ""
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_ITEM
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
        need[need.count].tp = MIS_NEED_ITEM
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_ITEM
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_ITEM
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		prize.count = prize.count + 1
		prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_MONEY
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		prize.count = prize.count + 1
        prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_ITEM
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		--任务开始
		--begin.conditions.count = begin.conditions.count + 1
		--begin.conditions[begin.conditions.count] = {}
		--begin.conditions[begin.conditions.count].func = NoRandMission
		--begin.conditions[begin.conditions.count].p1 = Mission.curmission.id
		
		--begin.actions.count = begin.actions.count + 1
		--begin.actions[begin.actions.count] = {}
		--begin.actions[begin.actions.count].func = AddRandMission
		--begin.actions[begin.actions.count].p1 = Mission.curmission.id
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p1
		begin.actions[begin.actions.count].p2 = TE_GETITEM
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p2
		begin.actions[begin.actions.count].p2 = TE_GETITEM
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p3
		begin.actions[begin.actions.count].p2 = TE_GETITEM
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p4
		begin.actions[begin.actions.count].p2 = TE_GETITEM
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		--任务结束条件
		--result.conditions.count = result.conditions.count + 1
		--result.conditions[result.conditions.count] = {}
		--result.conditions[result.conditions.count].func = HasRandMission
		--result.conditions[result.conditions.count].p1 = Mission.curmission.id
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = AlwaysTrue--HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasItem
		result.conditions[result.conditions.count].p1 = 0
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = AlwaysTrue--HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0

		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasItem
		result.conditions[result.conditions.count].p1 = 0
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = AlwaysTrue--HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0

		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasItem
		result.conditions[result.conditions.count].p1 = 0
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = AlwaysTrue--HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0

		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasItem
		result.conditions[result.conditions.count].p1 = 0
		result.conditions[result.conditions.count].p2 = 0
		
		--任务结束动作
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = ClearMission
		result.actions[result.actions.count].p1 = Mission.curmission.id
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = AddExpAndType	--AddExp
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		result.actions[result.actions.count].p3 = 0
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = TakeItem
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = TakeItem
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = TakeItem
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = TakeItem
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		
		--任务取消动作
		InitTrigger()
		TriggerCondition( 1, HasCancelMissionMoney )
		TriggerAction( 1, TakeCancelMissionMoney )
		TriggerAction( 1, ClearMission, Mission.curmission.id )
		TriggerAction( 1, FailureRandMissionCount, Mission.curmission.id )
		
		MISSDK_SCRIPTSDK_LUA_000053 = GetResString("MISSDK_SCRIPTSDK_LUA_000053")
		TriggerAction( 2, SystemNotice, MISSDK_SCRIPTSDK_LUA_000053 )

		cancel.actions.count = cancel.actions.count + 1
		cancel.actions[cancel.actions.count] = {}
		cancel.actions[cancel.actions.count].func = MultiTrigger
		cancel.actions[cancel.actions.count].p1 = GetMultiTrigger()
		cancel.actions[cancel.actions.count].p2 = 2
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = ClearMission
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id

		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = FailureRandMissionCount
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--建立最大4个全局触发器用于随机任务
		InitTrigger()
		SetTriggerType( 1, MIS_TRIGGER_RAND )
		--TriggerCondition( 1, IsItem, 0 )
		TriggerAction( 1, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p1, 1 )
		
		SetTriggerType( 2, MIS_TRIGGER_RAND )
		--TriggerCondition( 2, IsItem, 0 )
		TriggerAction( 2, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 2, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p2, 2 )
		
		SetTriggerType( 3, MIS_TRIGGER_RAND )
		--TriggerCondition( 3, IsItem, 0 )
		TriggerAction( 3, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 3, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p3, 3 )
		
		SetTriggerType( 4, MIS_TRIGGER_RAND )
		--TriggerCondition( 4, IsItem, 0 )
		TriggerAction( 4, AddRMNextFlag, Mission.curmission.id, 0, 0 )
		TriggerAction( 4, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p4, 4 )
		
	elseif tp == MIS_RAND_SEND then
		--随机任务奖励和需求
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = ""
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		prize.count = prize.count + 1
		prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_MONEY
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		prize.count = prize.count + 1
		prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_ITEM
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		--任务开始
		--begin.conditions.count = begin.conditions.count + 1
		--begin.conditions[begin.conditions.count] = {}
		--begin.conditions[begin.conditions.count].func = NoMission
		--begin.conditions[begin.conditions.count].p1 = Mission.curmission.id
		
		--begin.actions.count = begin.actions.count + 1
		--begin.actions[begin.actions.count] = {}
		--begin.actions[begin.actions.count].func = AddMission
		--begin.actions[begin.actions.count].p1 = Mission.curmission.id
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = GiveItem
		begin.actions[begin.actions.count].p1 = 0
		begin.actions[begin.actions.count].p2 = 0
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = GiveItem
		begin.actions[begin.actions.count].p1 = 0
		begin.actions[begin.actions.count].p2 = 0
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = GiveItem
		begin.actions[begin.actions.count].p1 = 0
		begin.actions[begin.actions.count].p2 = 0
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = GiveItem
		begin.actions[begin.actions.count].p1 = 0
		begin.actions[begin.actions.count].p2 = 0
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		--任务结束条件
		--result.conditions.count = result.conditions.count + 1
		--result.conditions[result.conditions.count] = {}
		--result.conditions[result.conditions.count].func = HasMission
		--result.conditions[result.conditions.count].p1 = Mission.curmission.id
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasRandNpcItemFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasRandNpcItemFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasRandNpcItemFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasRandNpcItemFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		--任务结束动作
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = ClearMission
		result.actions[result.actions.count].p1 = Mission.curmission.id
		
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = AddExpAndType	--AddExp
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		result.actions[result.actions.count].p3 = 0

		--任务取消动作
		InitTrigger()
		TriggerCondition( 1, HasCancelMissionMoney )
		TriggerAction( 1, TakeCancelMissionMoney )
		TriggerAction( 1, TakeAllRandItem, Mission.curmission.id )
		TriggerAction( 1, ClearMission, Mission.curmission.id )
		TriggerAction( 1, FailureRandMissionCount, Mission.curmission.id )
		
		MISSDK_SCRIPTSDK_LUA_000053 = GetResString("MISSDK_SCRIPTSDK_LUA_000053")
		TriggerAction( 2, SystemNotice, MISSDK_SCRIPTSDK_LUA_000053 )

		cancel.actions.count = cancel.actions.count + 1
		cancel.actions[cancel.actions.count] = {}
		cancel.actions[cancel.actions.count].func = MultiTrigger
		cancel.actions[cancel.actions.count].p1 = GetMultiTrigger()
		cancel.actions[cancel.actions.count].p2 = 2
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = TakeAllRandItem
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = ClearMission
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = FailureRandMissionCount
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
	elseif tp == MIS_RAND_CONVOY then
		--随机任务奖励和需求
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = ""
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
		need[need.count] = {}
        need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		need.count = need.count + 1
        need[need.count] = {}
		need[need.count].tp = MIS_NEED_DESP
		need[need.count].p1 = 0
		need[need.count].p2 = 0
		need[need.count].p3 = 0
		need[need.count].p4 = 0
		
		prize.count = prize.count + 1
		prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_MONEY
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		prize.count = prize.count + 1
        prize[prize.count] = {}
		prize[prize.count].tp = MIS_PRIZE_ITEM
		prize[prize.count].p1 = 0
		prize[prize.count].p2 = 0
		prize[prize.count].p3 = 0
		prize[prize.count].p4 = 0
		
		--任务开始
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p1
		begin.actions[begin.actions.count].p2 = TE_GAMETIME
		begin.actions[begin.actions.count].p3 = TT_MULTITIME
		begin.actions[begin.actions.count].p4 = 1
		begin.actions[begin.actions.count].p5 = 1
		begin.actions[begin.actions.count].p6 = 1
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p2
		begin.actions[begin.actions.count].p2 = TE_GOTO_MAP
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 1
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = ConvoyNpc
		begin.actions[begin.actions.count].p1 = Mission.curmission.id
		begin.actions[begin.actions.count].p2 = 0
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 8
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p3
		begin.actions[begin.actions.count].p2 = TE_GOTO_MAP
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 1
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = ConvoyNpc
		begin.actions[begin.actions.count].p1 = Mission.curmission.id
		begin.actions[begin.actions.count].p2 = 1
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 8
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p4
		begin.actions[begin.actions.count].p2 = TE_GOTO_MAP
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 1
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = ConvoyNpc
		begin.actions[begin.actions.count].p1 = Mission.curmission.id
		begin.actions[begin.actions.count].p2 = 2
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 8
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
        begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = AddTrigger
		begin.actions[begin.actions.count].p1 = p5
		begin.actions[begin.actions.count].p2 = TE_GOTO_MAP
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 0
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0
		begin.actions[begin.actions.count].p7 = 1
		begin.actions[begin.actions.count].p8 = 0
		
		begin.actions.count = begin.actions.count + 1
		begin.actions[begin.actions.count] = {}
		begin.actions[begin.actions.count].func = ConvoyNpc
		begin.actions[begin.actions.count].p1 = Mission.curmission.id
		begin.actions[begin.actions.count].p2 = 3
		begin.actions[begin.actions.count].p3 = 0
		begin.actions[begin.actions.count].p4 = 8
		begin.actions[begin.actions.count].p5 = 0
		begin.actions[begin.actions.count].p6 = 0		
		begin.actions[begin.actions.count].p7 = 0
		begin.actions[begin.actions.count].p8 = 0
		
		--任务结束条件		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 0
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 1
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 2
		
		result.conditions.count = result.conditions.count + 1
		result.conditions[result.conditions.count] = {}
		result.conditions[result.conditions.count].func = HasFlag
		result.conditions[result.conditions.count].p1 = Mission.curmission.id
		result.conditions[result.conditions.count].p2 = 3
		
		--任务结束动作
		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = ClearMission
		result.actions[result.actions.count].p1 = Mission.curmission.id

		result.actions.count = result.actions.count + 1
		result.actions[result.actions.count] = {}
		result.actions[result.actions.count].func = AddExpAndType	--AddExp
		result.actions[result.actions.count].p1 = 0
		result.actions[result.actions.count].p2 = 0
		result.actions[result.actions.count].p3 = 0

		--任务取消动作
		InitTrigger()
		TriggerCondition( 1, HasCancelMissionMoney )
		TriggerAction( 1, TakeCancelMissionMoney )
		TriggerAction( 1, ClearAllConvoyNpc, Mission.curmission.id )
		TriggerAction( 1, ClearMission, Mission.curmission.id )
		TriggerAction( 1, FailureRandMissionCount, Mission.curmission.id )
		
		MISSDK_SCRIPTSDK_LUA_000053 = GetResString("MISSDK_SCRIPTSDK_LUA_000053")
		TriggerAction( 2, SystemNotice, MISSDK_SCRIPTSDK_LUA_000053 )

		cancel.actions.count = cancel.actions.count + 1
		cancel.actions[cancel.actions.count] = {}
		cancel.actions[cancel.actions.count].func = MultiTrigger
		cancel.actions[cancel.actions.count].p1 = GetMultiTrigger()
		cancel.actions[cancel.actions.count].p2 = 2
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = ClearAllConvoyNpc
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = ClearMission
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--cancel.actions.count = cancel.actions.count + 1
		--cancel.actions[cancel.actions.count] = {}
		--cancel.actions[cancel.actions.count].func = FailureRandMissionCount
		--cancel.actions[cancel.actions.count].p1 = Mission.curmission.id
		
		--建立最大4个全局触发器用于随机任务
		InitTrigger()
		--SetTriggerType( 1, MIS_TRIGGER_RAND )
		TriggerAction( 1, ClearConvoyNpc, Mission.curmission.id, 0 )
		TriggerAction( 1, SetFlag, Mission.curmission.id, 0 )
		MISSDK_SCRIPTSDK_LUA_000054 = GetResString("MISSDK_SCRIPTSDK_LUA_000054")
		TriggerAction( 1, HelpInfo, MIS_HELP_DESP, MISSDK_SCRIPTSDK_LUA_000054 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p2, 1 )
		
		--SetTriggerType( 2, MIS_TRIGGER_RAND )
		TriggerAction( 2, ClearConvoyNpc, Mission.curmission.id, 1 )
		TriggerAction( 2, SetFlag, Mission.curmission.id, 1 )
		MISSDK_SCRIPTSDK_LUA_000054 = GetResString("MISSDK_SCRIPTSDK_LUA_000054")
		TriggerAction( 2, HelpInfo, MIS_HELP_DESP, MISSDK_SCRIPTSDK_LUA_000054 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p3, 2 )
		
		--SetTriggerType( 3, MIS_TRIGGER_RAND )
		TriggerAction( 3, ClearConvoyNpc, Mission.curmission.id, 2 )
		TriggerAction( 3, SetFlag, Mission.curmission.id, 2 )
		MISSDK_SCRIPTSDK_LUA_000054 = GetResString("MISSDK_SCRIPTSDK_LUA_000054")
		TriggerAction( 3, HelpInfo, MIS_HELP_DESP, MISSDK_SCRIPTSDK_LUA_000054 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p4, 3 )
		
		--SetTriggerType( 4, MIS_TRIGGER_RAND )
		TriggerAction( 4, ClearConvoyNpc, Mission.curmission.id, 3 )
		TriggerAction( 4, SetFlag, Mission.curmission.id, 3 )
		MISSDK_SCRIPTSDK_LUA_000054 = GetResString("MISSDK_SCRIPTSDK_LUA_000054")
		TriggerAction( 4, HelpInfo, MIS_HELP_DESP, MISSDK_SCRIPTSDK_LUA_000054 )
		TriggerAction( 1, RefreshCompleteFlag, Mission.curmission.sid )
		RegTrigger( p5, 4 )

		--SetTriggerType( 1, MIS_TRIGGER_RAND )
		MISSDK_SCRIPTSDK_LUA_000055 = GetResString("MISSDK_SCRIPTSDK_LUA_000055")
		local help = MISSDK_SCRIPTSDK_LUA_000055
		MISSDK_SCRIPTSDK_LUA_000056 = GetResString("MISSDK_SCRIPTSDK_LUA_000056")
		help = help..Mission.curmission.name..MISSDK_SCRIPTSDK_LUA_000056
		TriggerAction( 5, ClearAllConvoyNpc, Mission.curmission.id )
		TriggerAction( 5, HelpInfo, MIS_HELP_DESP, help )
		TriggerAction( 5, FailureRandMissionCount, Mission.curmission.id )
		TriggerAction( 5, SetMissionFailure, Mission.curmission.id )
		RegTrigger( p1, 5 )
		
	elseif tp == MIS_RAND_EXPLORE then
	
	end
	
	--预生成随机任务数据格式，加速程序
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].begin = begin
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].result = result
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].cancel = cancel
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].need  = need
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].prize  = prize
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].name = Mission.curmission.name
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].t1 = p1
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].t2 = p2
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].t3 = p3
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].t4 = p4
	Mission.curmission.missionlist[Mission.curmission.missionlist.count].tprand = tprand
end

--添加随机任务生成信息
function AddRandMissionInfo( id, level, tp, p1, p2, p3, p4, p5, p6, p7, p8 )	
	if Mission[id] == nil then
		LG( "randmission_init", "AddRandMissionInfo:Mission[id] = nil, id = "..id )
		PRINT( "AddRandMissionInfo:Mission[id] = nil, id = "..id )
		return LUA_FALSE
	end

	if Mission[id].RandInfo == nil then
		Mission[id].RandInfo = {}
	end
	
	--判断该类型是否已打开
	local flag = 0
	for n = 1, Mission.curmission.missionlist.count, 1 do
		if Mission.curmission.missionlist[n].tp == tp then
			flag = 1
		end
	end
	if flag == 0 then
		MISSDK_SCRIPTSDK_LUA_000057 = GetResString("MISSDK_SCRIPTSDK_LUA_000057")
		PRINT( MISSDK_SCRIPTSDK_LUA_000057, id, level, tp, p1, p2, p3, p4, p5, p6 )
		MISSDK_SCRIPTSDK_LUA_000058 = GetResString("MISSDK_SCRIPTSDK_LUA_000058")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000058, tp )
	end
	
	if Mission[id].RandInfo[level] == nil then
		Mission[id].RandInfo[level] = {}
		Mission[id].RandInfo[level].KillInfo = {}
		Mission[id].RandInfo[level].KillInfo.count = 0
		Mission[id].RandInfo[level].GetInfo = {}
		Mission[id].RandInfo[level].GetInfo.count = 0
		Mission[id].RandInfo[level].SendInfo = {}
		Mission[id].RandInfo[level].SendInfo.count = 0
		Mission[id].RandInfo[level].SendItem = {}
		Mission[id].RandInfo[level].SendItem.count = 0
		Mission[id].RandInfo[level].ConvoyInfo = {}
		Mission[id].RandInfo[level].ConvoyInfo.count = 0
		Mission[id].RandInfo[level].ExploreInfo = {}
		Mission[id].RandInfo[level].ExploreInfo.count = 0
		Mission[id].RandInfo[level].LoopData = {}
		Mission[id].RandInfo[level].LoopData.count = 0
		
		Mission[id].RandInfo[level].PrizeItem = {}
		Mission[id].RandInfo[level].PrizeItem.count = 0
		Mission[id].RandInfo[level].PrizeItem.odds = 0
		Mission[id].RandInfo[level].PrizeItem.num = 0
		--随机任务产生快捷信息
		Mission[id].RandInfo[level].tpinfo = {}
		Mission[id].RandInfo[level].tpinfo.count = 0
	end

	LG( "randmission_init", "mission = , mission.RandInfo = , mission.RandInfo[level] = ", Mission[id], Mission[id].RandInfo, Mission[id].RandInfo[level] )
	
	if tp == MIS_RAND_KILL then					--猎杀怪物
		Mission[id].RandInfo[level].KillInfo.count = Mission[id].RandInfo[level].KillInfo.count + 1
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count] = {}
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p1 = p1
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p2 = p2
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p3 = p3
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p4 = p4
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p5 = p5
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p6 = p6
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p7 = p7
		Mission[id].RandInfo[level].KillInfo[Mission[id].RandInfo[level].KillInfo.count].p8 = p8
	elseif tp == MIS_RAND_GET then			--获取物品
		Mission[id].RandInfo[level].GetInfo.count = Mission[id].RandInfo[level].GetInfo.count + 1
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count] = {}
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p1 = p1
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p2 = p2
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p3 = p3
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p4 = p4
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p5 = p5
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p6 = p6
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p7 = p7
		Mission[id].RandInfo[level].GetInfo[Mission[id].RandInfo[level].GetInfo.count].p8 = p8
	elseif tp == MIS_RAND_SEND then			--送给物品
		Mission[id].RandInfo[level].SendInfo.count = Mission[id].RandInfo[level].SendInfo.count + 1
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count] = {}
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p1 = p1
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p2 = p2
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p3 = p3
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p4 = p4
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p5 = p5
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p6 = p6
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p7 = p7
		Mission[id].RandInfo[level].SendInfo[Mission[id].RandInfo[level].SendInfo.count].p8 = p8
	elseif tp == MIS_RAND_CONVOY then		--护送NPC
		Mission[id].RandInfo[level].ConvoyInfo.count = Mission[id].RandInfo[level].ConvoyInfo.count + 1
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count] = {}
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p1 = p1
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p2 = p2
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p3 = p3
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p4 = p4
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p5 = p5
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p6 = p6
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p7 = p7
		Mission[id].RandInfo[level].ConvoyInfo[Mission[id].RandInfo[level].ConvoyInfo.count].p8 = p8
	elseif tp == MIS_RAND_EXPLORE then	--探索地图
		Mission[id].RandInfo[level].ExploreInfo.count = Mission[id].RandInfo[level].ExploreInfo.count + 1
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count] = {}
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p1 = p1
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p2 = p2
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p3 = p3
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p4 = p4
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p5 = p5
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p6 = p6
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p7 = p7
		Mission[id].RandInfo[level].ExploreInfo[Mission[id].RandInfo[level].ExploreInfo.count].p8 = p8
	else
		MISSDK_SCRIPTSDK_LUA_000059 = GetResString("MISSDK_SCRIPTSDK_LUA_000059")
		PRINT( MISSDK_SCRIPTSDK_LUA_000059..tp )
		MISSDK_SCRIPTSDK_LUA_000059 = GetResString("MISSDK_SCRIPTSDK_LUA_000059")
		LG( "randmission_init",  MISSDK_SCRIPTSDK_LUA_000059..tp )
		return LUA_FALSE
	end

	--判断该类型数据信息索引是否已加入
	local count = 0
	for n = 1, Mission[id].RandInfo[level].tpinfo.count, 1 do
		if Mission[id].RandInfo[level].tpinfo[n].tp == tp then
			count = 1
			break
		end
	end
	if count == 0 then
		local tprand = 1
		for n = 1, Mission.curmission.missionlist.count, 1 do
			if Mission.curmission.missionlist[n].tp == tp and Mission.curmission.missionlist[n].tprand ~= nil then
				tprand = Mission.curmission.missionlist[n].tprand
				break
			end
		end
		Mission[id].RandInfo[level].tpinfo.count = Mission[id].RandInfo[level].tpinfo.count + 1
		Mission[id].RandInfo[level].tpinfo[Mission[id].RandInfo[level].tpinfo.count] = {}
		Mission[id].RandInfo[level].tpinfo[Mission[id].RandInfo[level].tpinfo.count].tp = tp
		Mission[id].RandInfo[level].tpinfo[Mission[id].RandInfo[level].tpinfo.count].tprand = tprand
	end
	LG( "randmission_init", "mission = , mission.RandInfo = , mission.RandInfo[level] = ", Mission[id], Mission[id].RandInfo, Mission[id].RandInfo[level] )
	LG( "randmission_init",  "AddRandMissionInfo:id = , level = , tp = , tprand = , p1 =, p2 =, p3 =, p4 =, p5 =, p6 =, p7 =, p8 =", id, level, tp, tprand, p1, p2, p3, p4, p5, p6, p7, p8 )
	return LUA_TRUE
end

--添加摧毁物件类型得随机库信息
function AddRandKillInfo( level, monsterid, randvalue, randscope, exp, money )
	if Mission.curmission == nil or Mission.curmission.sid == nil then
		MISSDK_SCRIPTSDK_LUA_000060 = GetResString("MISSDK_SCRIPTSDK_LUA_000060")
		PRINT( MISSDK_SCRIPTSDK_LUA_000060, level, monsterid, randvalue, randscope, exp, money )
		MISSDK_SCRIPTSDK_LUA_000060 = GetResString("MISSDK_SCRIPTSDK_LUA_000060")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000060, level, monsterid, randvalue, randscope, exp, money )
		return
	end
	
	local ret = AddRandMissionInfo( Mission.curmission.sid, level, MIS_RAND_KILL, monsterid, randvalue, randscope, exp, money )
	if ret ~= LUA_TRUE then
			MISSDK_SCRIPTSDK_LUA_000061 = GetResString("MISSDK_SCRIPTSDK_LUA_000061")
			PRINT( MISSDK_SCRIPTSDK_LUA_000061, level, monsterid, randvalue, randscope, exp, money )
			MISSDK_SCRIPTSDK_LUA_000061 = GetResString("MISSDK_SCRIPTSDK_LUA_000061")
			LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000061, level, monsterid, randvalue, randscope, exp, money )
			return
	end	
	LG( "randmission_init", "AddRandKillInfo:level, monsterid, randvalue, randscope, exp, money", level, monsterid, randvalue, randscope, exp, money )
end

--添加获取物品类型随机库信息
function AddRandGetItem( level, itemid, randvalue, randscope, exp, money )
	if Mission.curmission == nil or Mission.curmission.sid == nil then
		MISSDK_SCRIPTSDK_LUA_000062 = GetResString("MISSDK_SCRIPTSDK_LUA_000062")
		PRINT( MISSDK_SCRIPTSDK_LUA_000062, level, itemid, randvalue, randscope, exp, money )
		MISSDK_SCRIPTSDK_LUA_000062 = GetResString("MISSDK_SCRIPTSDK_LUA_000062")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000062, level, itemid, randvalue, randscope, exp, money )
		return
	end
	
	local ret = AddRandMissionInfo( Mission.curmission.sid, level, MIS_RAND_GET, itemid, randvalue, randscope, exp, money )
	if ret ~= LUA_TRUE then
			MISSDK_SCRIPTSDK_LUA_000063 = GetResString("MISSDK_SCRIPTSDK_LUA_000063")
			PRINT( MISSDK_SCRIPTSDK_LUA_000063, level, itemid, randvalue, randscope, exp, money )
			MISSDK_SCRIPTSDK_LUA_000064 = GetResString("MISSDK_SCRIPTSDK_LUA_000064")
			LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000064, level, itemid, randvalue, randscope, exp, money )
			return
	end
	LG( "randmission_init", "AddRandGetItem:level, itemid, randvalue, randscope, exp, money", level, itemid, randvalue, randscope, exp, money )
end

--添加送物件类型随机库信息
function AddRandSendInfo( level, npcid, exp, money )
	if Mission.curmission == nil or Mission.curmission.sid == nil then
		MISSDK_SCRIPTSDK_LUA_000065 = GetResString("MISSDK_SCRIPTSDK_LUA_000065")
		PRINT( MISSDK_SCRIPTSDK_LUA_000065, level, npcid, exp, money )
		MISSDK_SCRIPTSDK_LUA_000065 = GetResString("MISSDK_SCRIPTSDK_LUA_000065")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000065, level, npcid, exp, money )
		return
	end
	
	if npcid == nil or NpcList[npcid] == nil or NpcList[npcid].mapid == nil or NpcList[npcid].areaid == nil then
		MISSDK_SCRIPTSDK_LUA_000066 = GetResString("MISSDK_SCRIPTSDK_LUA_000066")
		PRINT( MISSDK_SCRIPTSDK_LUA_000066, npcid )
		MISSDK_SCRIPTSDK_LUA_000066 = GetResString("MISSDK_SCRIPTSDK_LUA_000066")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000066, npcid )
		return
	end
	
	local ret = AddRandMissionInfo( Mission.curmission.sid, level, MIS_RAND_SEND, npcid, NpcList[npcid].areaid, NpcList[npcid].mapid, exp, money )
	if ret ~= LUA_TRUE then
			MISSDK_SCRIPTSDK_LUA_000067 = GetResString("MISSDK_SCRIPTSDK_LUA_000067")
			PRINT( MISSDK_SCRIPTSDK_LUA_000067, level, npcid, NpcList[npcid].areaid, NpcList[npcid].mapid, exp, money )
			MISSDK_SCRIPTSDK_LUA_000068 = GetResString("MISSDK_SCRIPTSDK_LUA_000068")
			LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000068, level, npcid, NpcList[npcid].areaid, NpcList[npcid].mapid, exp, money )
			return
	end
	LG( "randmission_init", "AddRandSendInfo:level, npcid, mapid, areaid, exp, money", level, npcid, NpcList[npcid].areaid, NpcList[npcid].mapid, exp, money )
end

--添加送物件类型随机库可选物件信息
function AddRandSendItem( level, item )
	if Mission.curmission.RandInfo[level] == nil then
		MISSDK_SCRIPTSDK_LUA_000069 = GetResString("MISSDK_SCRIPTSDK_LUA_000069")
		PRINT( MISSDK_SCRIPTSDK_LUA_000069, level )
		MISSDK_SCRIPTSDK_LUA_000069 = GetResString("MISSDK_SCRIPTSDK_LUA_000069")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000069, level )
		return
	end
	Mission.curmission.RandInfo[level].SendItem.count = Mission.curmission.RandInfo[level].SendItem.count + 1
	Mission.curmission.RandInfo[level].SendItem[Mission.curmission.RandInfo[level].SendItem.count] = item
	LG( "randmission_init", "AddRandSendItem:misid, level, item", Mission.curmission.sid, level, item )
end

--添加护送类型随机库信息
function AddRandConvoyInfo( level, charid, mapid, areaid, x, y, scope, exp, money )
	if Mission.curmission == nil or Mission.curmission.sid == nil then
		MISSDK_SCRIPTSDK_LUA_000070 = GetResString("MISSDK_SCRIPTSDK_LUA_000070")
		PRINT( MISSDK_SCRIPTSDK_LUA_000070, level, areaid, mapid, exp, money )
		MISSDK_SCRIPTSDK_LUA_000070 = GetResString("MISSDK_SCRIPTSDK_LUA_000070")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000070, level, areaid, mapid, exp, money )
		return
	end

	local ret = AddRandMissionInfo( Mission.curmission.sid, level, MIS_RAND_CONVOY, charid, mapid, areaid, x, y, scope, exp, money )
	if ret ~= LUA_TRUE then
			MISSDK_SCRIPTSDK_LUA_000071 = GetResString("MISSDK_SCRIPTSDK_LUA_000071")
			PRINT( MISSDK_SCRIPTSDK_LUA_000071, level, charid, mapid, areaid, x, y, scope, exp, money )
			MISSDK_SCRIPTSDK_LUA_000072 = GetResString("MISSDK_SCRIPTSDK_LUA_000072")
			LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000072, level, charid, mapid, areaid, x, y, scope, exp, money )
			return
	end
	LG( "randmission_init", "AddRandConvoyInfo:level, charid, mapid, areaid, x, y, scope, exp, money", level, charid, mapid, areaid, x, y, scope, exp, money )
end

--添加探索类型随机库信息
function AddRandExploreInfo( level, mapid, areaid, x, y, exp, money )
end

--添加随机任务完成次数后随机高级装备奖励
--随机任务贸易税点奖励
function AddRandPriceCess( level, cess, cessrange )
	LG( "randmission_init", "AddRandPrizeItem:misid, level, cess, cessrange", Mission.curmission.sid, level, cess, cessrange )
	if Mission.curmission.RandInfo[level] == nil then
		LG( "randmission_prize_error", "AddRandPriceCess, level data error.", level )
		return
	end
	
	Mission.curmission.RandInfo[level].LoopData.count = Mission.curmission.RandInfo[level].LoopData.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = 0
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.tp = MIS_PRIZE_CESS
	
	local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_CESS
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = cess
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = cessrange
end

--随机任务角色声望奖励
function AddRandPriceFrame( level, frame, framerange )
	LG( "randmission_init", "AddRandPrizeItem:misid, level, frame, framerange" )
	if Mission.curmission.RandInfo[level] == nil then
		LG( "randmission_prize_error", "AddRandPriceFrame, level data error.", level )
		return
	end
	
	Mission.curmission.RandInfo[level].LoopData.count = Mission.curmission.RandInfo[level].LoopData.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = 0
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.tp = MIS_PRIZE_FAME
	
	local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_FAME
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = frame
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = framerange
end

--随即任务角色宠物经验奖励
function AddRandPricePetExp( level, exp, exprange )
	LG( "randmission_init", "AddRandPricePetExp:misid, level, exp, exprange" )
	if Mission.curmission.RandInfo[level] == nil then
		LG( "randmission_prize_error", "AddRandPricePetExp, level data error.", level )
		return
	end
	
	Mission.curmission.RandInfo[level].LoopData.count = Mission.curmission.RandInfo[level].LoopData.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = 0
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.tp = MIS_PRIZE_PETEXP
	
	local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_PETEXP
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = exp
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = exprange
end

--开始添加随机任务高级奖励
function SetRandPrizeItem( level )
	LG( "randmission_init2", "SetRandPrizeItem:misid, level", Mission.curmission.sid, level )
	if Mission.curmission.RandInfo[level] == nil then
		LG( "randmission_prize_error", "SetRandPrizeItem, level data error.", level )
		return
	end
	
	Mission.curmission.RandInfo[level].LoopData.count = Mission.curmission.RandInfo[level].LoopData.count + 1
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count] = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize = {}
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = 0
	Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.tp = MIS_PRIZE_ITEM
end

--随机任务高级物品奖励
function AddRandPrizeItem( level, item1, itemdata1, item2, itemdata2, item3, itemdata3, item4, itemdata4 )	
	if Mission.curmission.RandInfo[level] == nil then
		LG( "randmission_prize_error", "AddRandPrizeItem, level data error.", level )
		return
	end
	
	if Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count] == nil or Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize == nil then
		MISSDK_SCRIPTSDK_LUA_000073 = GetResString("MISSDK_SCRIPTSDK_LUA_000073")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000073, Mission.curmission.sid, level )
		return
	end
	LG( "randmission_init2", "AddRandPrizeItem:misid, level, item1, itemdata1, item2, itemdata2, item3, itemdata3, item4, itemdata4", Mission.curmission.sid, level, item1, itemdata1, item2, itemdata2, item3, itemdata3, item4, itemdata4 )
	
	if item1 ~= nil then
		local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_ITEM
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = item1
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = itemdata1
	else
		return
	end
	
	if item2 ~= nil then
		local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_ITEM
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = item2
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = itemdata2
	else
		return
	end

	if item3 ~= nil then
		local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_ITEM
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = item3
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = itemdata3
	else
		return
	end

	if item4 ~= nil then
		local count = Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count + 1
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize.count = count
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count] = {}
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].tp = MIS_PRIZE_ITEM
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p1 = item4
		Mission.curmission.RandInfo[level].LoopData[Mission.curmission.RandInfo[level].LoopData.count].Prize[count].p2 = itemdata4
	else
		return
	end

end

--设置随机任务段完成高等级装备奖励的随机率和需要完成最大数量
function SetRandPrizeOdds( loopnum, odds, completenum )
	--Mission.curmission.RandInfo[level].PrizeItem.odds = odds
	--Mission.curmission.RandInfo[level].PrizeItem.num  = completenum
	--LG( "randmission_init", "AddRandPrizeItem:Add item, level, odds, completenum", level, odds, completenum )
	
	LG( "randmission_init", "SetRandPrizeOdds:loopnum, odds, completenum", loopnum, odds, completenum )
	if Mission.curmission.loopinfo[loopnum] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000074 = GetResString("MISSDK_SCRIPTSDK_LUA_000074")
		PRINT( MISSDK_SCRIPTSDK_LUA_000074, loopnum, Mission.curmission.loopinfo[loopnum].odds, Mission.curmission.loopinfo[loopnum].completenum )
		MISSDK_SCRIPTSDK_LUA_000074 = GetResString("MISSDK_SCRIPTSDK_LUA_000074")
		LG( "randmission_error", MISSDK_SCRIPTSDK_LUA_000074, loopnum, Mission.curmission.loopinfo[loopnum].odds, Mission.curmission.loopinfo[loopnum].completenum )
	end
	
	Mission.curmission.loopinfo[loopnum] = {}
	Mission.curmission.loopinfo[loopnum].odds = odds
	Mission.curmission.loopinfo[loopnum].num = completenum
end

--初始化世界NPC信息列表
function InitNpcList()
	NpcList = {}
	NpcList.count = 0
end

--添加NPC信息
function AddNpcInfo( npcid, name, mapid, areaid )
	MISSDK_SCRIPTSDK_LUA_000075 = GetResString("MISSDK_SCRIPTSDK_LUA_000075")
	MISSDK_SCRIPTSDK_LUA_000076 = GetResString("MISSDK_SCRIPTSDK_LUA_000076")
	MISSDK_SCRIPTSDK_LUA_000077 = GetResString("MISSDK_SCRIPTSDK_LUA_000077")
	PRINT( MISSDK_SCRIPTSDK_LUA_000077..npcid..MISSDK_SCRIPTSDK_LUA_000076..name..MISSDK_SCRIPTSDK_LUA_000075..mapid.."AreaID = "..areaid )
	LG( "npcinfo", "AddNpcInfo:npcid = "..npcid.."name = "..name.."mapid = "..mapid.."areaid = "..areaid )
	if NpcList[npcid] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000078 = GetResString("MISSDK_SCRIPTSDK_LUA_000078")
		LG( "npcinfo", MISSDK_SCRIPTSDK_LUA_000078..npcid.."name = "..NpcList[npcid].name )
		MISSDK_SCRIPTSDK_LUA_000078 = GetResString("MISSDK_SCRIPTSDK_LUA_000078")
		PRINT( MISSDK_SCRIPTSDK_LUA_000078..npcid.."name = "..NpcList[npcid].name )
	end
	NpcList[npcid] = {}
	NpcList[npcid].name = name
	NpcList[npcid].mapid = mapid
	NpcList[npcid].areaid = areaid
end

function GetNpcName( npcid )
	if npcid == nil or NpcList[npcid] == nil or NpcList[npcid].name == nil then
		MISSDK_SCRIPTSDK_LUA_000044 = GetResString("MISSDK_SCRIPTSDK_LUA_000044")
		return MISSDK_SCRIPTSDK_LUA_000044..npcid
	end
	return NpcList[npcid].name
end

--初始化资源信息列表
function InitResource()
	ResourceList = {}		--资源信息
	ResourceList.wood = {}
	ResourceList.mine = {}
end

--添加资源信息
function SetWoodResource( level, itemid, count, pileid )
	if level == nil or itemid == nil or count == nil or pileid == nil then
		MISSDK_SCRIPTSDK_LUA_000079 = GetResString("MISSDK_SCRIPTSDK_LUA_000079")
		PRINT( MISSDK_SCRIPTSDK_LUA_000079, level, itemid, count, pileid )
		MISSDK_SCRIPTSDK_LUA_000079 = GetResString("MISSDK_SCRIPTSDK_LUA_000079")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000079, level, itemid, count, pileid )
		return LUA_FALSE
	end
	
	if ResourceList == nil or ResourceList.wood == nil then
		MISSDK_SCRIPTSDK_LUA_000080 = GetResString("MISSDK_SCRIPTSDK_LUA_000080")
		PRINT( MISSDK_SCRIPTSDK_LUA_000080 )
		MISSDK_SCRIPTSDK_LUA_000080 = GetResString("MISSDK_SCRIPTSDK_LUA_000080")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000080 )
		return LAU_FALSE
	end
	
	if ResourceList.wood[level] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000081 = GetResString("MISSDK_SCRIPTSDK_LUA_000081")
		PRINT( MISSDK_SCRIPTSDK_LUA_000081, level, itemid, count, pileid )
		MISSDK_SCRIPTSDK_LUA_000081 = GetResString("MISSDK_SCRIPTSDK_LUA_000081")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000081, level, itemid, count, pileid )
	end
	
	ResourceList.wood[level] = {}
	ResourceList.wood[level].itemid = itemid
	ResourceList.wood[level].count = count
	ResourceList.wood[level].pileid  = pileid
	MISSDK_SCRIPTSDK_LUA_000082 = GetResString("MISSDK_SCRIPTSDK_LUA_000082")
	PRINT( MISSDK_SCRIPTSDK_LUA_000082, level, itemid, count, pileid )
	MISSDK_SCRIPTSDK_LUA_000082 = GetResString("MISSDK_SCRIPTSDK_LUA_000082")
	LG( "packbag_init", MISSDK_SCRIPTSDK_LUA_000082, level, itemid, count, pileid )
	return LUA_TRUE
end

function SetMineResource( level, itemid, count, pileid )
	if level == nil or itemid == nil or count == nil or pileid == nil then
		MISSDK_SCRIPTSDK_LUA_000083 = GetResString("MISSDK_SCRIPTSDK_LUA_000083")
		PRINT( MISSDK_SCRIPTSDK_LUA_000083, level, itemid, count, pileid )
		MISSDK_SCRIPTSDK_LUA_000083 = GetResString("MISSDK_SCRIPTSDK_LUA_000083")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000083, level, itemid, count, pileid )
		return LUA_FALSE
	end
	
	if ResourceList == nil or ResourceList.mine == nil then
		MISSDK_SCRIPTSDK_LUA_000084 = GetResString("MISSDK_SCRIPTSDK_LUA_000084")
		PRINT( MISSDK_SCRIPTSDK_LUA_000084 )
		MISSDK_SCRIPTSDK_LUA_000084 = GetResString("MISSDK_SCRIPTSDK_LUA_000084")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000084 )
		return LAU_FALSE
	end
	
	if ResourceList.mine[level] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000085 = GetResString("MISSDK_SCRIPTSDK_LUA_000085")
		PRINT( MISSDK_SCRIPTSDK_LUA_000085, level, itemid, count, pileid )
		MISSDK_SCRIPTSDK_LUA_000085 = GetResString("MISSDK_SCRIPTSDK_LUA_000085")
		LG( "goods_error", MISSDK_SCRIPTSDK_LUA_000085, level, itemid, count, pileid )
	end
	
	ResourceList.mine[level] = {}
	ResourceList.mine[level].itemid = itemid
	ResourceList.mine[level].count = count
	ResourceList.mine[level].pileid  = pileid
	MISSDK_SCRIPTSDK_LUA_000086 = GetResString("MISSDK_SCRIPTSDK_LUA_000086")
	PRINT( MISSDK_SCRIPTSDK_LUA_000086, level, itemid, count, pileid )
	MISSDK_SCRIPTSDK_LUA_000086 = GetResString("MISSDK_SCRIPTSDK_LUA_000086")
	LG( "packbag_init", MISSDK_SCRIPTSDK_LUA_000086, level, itemid, count, pileid )
	return LUA_TRUE
end

--添加港口信息
function AddBerthPort( id, name )
	MISSDK_SCRIPTSDK_LUA_000040 = GetResString("MISSDK_SCRIPTSDK_LUA_000040")
	MISSDK_SCRIPTSDK_LUA_000087 = GetResString("MISSDK_SCRIPTSDK_LUA_000087")
	MISSDK_SCRIPTSDK_LUA_000088 = GetResString("MISSDK_SCRIPTSDK_LUA_000088")
	PRINT( MISSDK_SCRIPTSDK_LUA_000088..id..MISSDK_SCRIPTSDK_LUA_000087..name..MISSDK_SCRIPTSDK_LUA_000040 )
	MISSDK_SCRIPTSDK_LUA_000040 = GetResString("MISSDK_SCRIPTSDK_LUA_000040")
	MISSDK_SCRIPTSDK_LUA_000087 = GetResString("MISSDK_SCRIPTSDK_LUA_000087")
	MISSDK_SCRIPTSDK_LUA_000088 = GetResString("MISSDK_SCRIPTSDK_LUA_000088")
	LG( "boat_init", MISSDK_SCRIPTSDK_LUA_000088..id..MISSDK_SCRIPTSDK_LUA_000087..name..MISSDK_SCRIPTSDK_LUA_000040 )
	if BerthPortList[id] ~= nil then
		MISSDK_SCRIPTSDK_LUA_000089 = GetResString("MISSDK_SCRIPTSDK_LUA_000089")
		LG( "boat_error", MISSDK_SCRIPTSDK_LUA_000089..id.."name = "..BerthPortList[id].name )
		MISSDK_SCRIPTSDK_LUA_000089 = GetResString("MISSDK_SCRIPTSDK_LUA_000089")
		PRINT( MISSDK_SCRIPTSDK_LUA_000089..id.."name = "..BerthPortList[id].name )
	end
	
	BerthPortList[id] = {}
	BerthPortList[id].name = name
end

--获取港口信息
function GetBerthData( id )
	if id == nil or BerthPortList[id] == nil or BerthPortList[id].name == nil then		
		MISSDK_SCRIPTSDK_LUA_000090 = GetResString("MISSDK_SCRIPTSDK_LUA_000090")
		return MISSDK_SCRIPTSDK_LUA_000090..id
	end
	return BerthPortList[id].name
end

--创建事件实体
function CreateBerthEntity( name, cid, infoid, xpos1, ypos1, dir1, berth, xpos2, ypos2, dir2 )
	MISSDK_SCRIPTSDK_LUA_000091 = GetResString("MISSDK_SCRIPTSDK_LUA_000091")
	PRINT( MISSDK_SCRIPTSDK_LUA_000091, name, cid, infoid, xpos1, ypos1, dir1, berth, xpos2, ypos2, dir2 )
	if name == nil or cid == nil or infoid == nil or xpos1 == nil or ypos1 == nil or dir1 == nil or berth == nil or xpos2 == nil or ypos2 == nil or dir2 == nil then
		MISSDK_SCRIPTSDK_LUA_000092 = GetResString("MISSDK_SCRIPTSDK_LUA_000092")
		PRINT( MISSDK_SCRIPTSDK_LUA_000092 )
		MISSDK_SCRIPTSDK_LUA_000092 = GetResString("MISSDK_SCRIPTSDK_LUA_000092")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000092 )
		return
	end
	LG( "entity_init", "CreateBerthEntity:name, cid, infoid, xpos1, ypos1, dir1, berth, xpos2, ypos2, dir2", name, cid, infoid, xpos1, ypos1, dir1, berth, xpos2, ypos2, dir2 )	
	
	local ret, submap = GetCurSubmap()
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000093 = GetResString("MISSDK_SCRIPTSDK_LUA_000093")
		PRINT( MISSDK_SCRIPTSDK_LUA_000093 )
		MISSDK_SCRIPTSDK_LUA_000093 = GetResString("MISSDK_SCRIPTSDK_LUA_000093")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000093 )
		return
	end
	local ret, e = CreateEventEntity( BERTH_ENTITY, submap, name, cid, infoid, xpos1, ypos1, dir1 )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000094 = GetResString("MISSDK_SCRIPTSDK_LUA_000094")
		PRINT( MISSDK_SCRIPTSDK_LUA_000094, BERTH_ENTITY, submap, name, cid, infoid, xpos1, ypos1, dir1 )
		MISSDK_SCRIPTSDK_LUA_000095 = GetResString("MISSDK_SCRIPTSDK_LUA_000095")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000095, BERTH_ENTITY, submap, name, cid, infoid, xpos1, ypos1, dir1 )
		return
	end
	ret = SetEntityData( e, berth, xpos2, ypos2, dir2 )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000096 = GetResString("MISSDK_SCRIPTSDK_LUA_000096")
		PRINT( MISSDK_SCRIPTSDK_LUA_000096, e, berth, xpos2, ypos2, dir2 )
		LG( "entity_error", "CreateBerthEntity:e, berth, xpos2, ypos2, dir2", e, berth, xpos2, ypos2, dir2 )
		return
	end
end

--创建资源实体
function CreateResourceEntity( name, cid, infoid, xpos, ypos, dir, itemid, count, time )
	MISSDK_SCRIPTSDK_LUA_000097 = GetResString("MISSDK_SCRIPTSDK_LUA_000097")
	PRINT( MISSDK_SCRIPTSDK_LUA_000097, name, cid, infoid, xpos, ypos, dir, itemid, count, time )
	if name == nil or cid == nil or infoid == nil or xpos == nil or ypos == nil or dir == nil or itemid == nil or count == nil or time == nil then
		MISSDK_SCRIPTSDK_LUA_000098 = GetResString("MISSDK_SCRIPTSDK_LUA_000098")
		PRINT( MISSDK_SCRIPTSDK_LUA_000098 )
		MISSDK_SCRIPTSDK_LUA_000098 = GetResString("MISSDK_SCRIPTSDK_LUA_000098")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000098 )
		return
	end
	LG( "entity_init", "CreateResourceEntity:name, cid, infoid, xpos, ypos, dir, itemid, count, time", name, cid, infoid, xpos, ypos, dir, itemid, count, time )	
	
	local ret, submap = GetCurSubmap()
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000099 = GetResString("MISSDK_SCRIPTSDK_LUA_000099")
		PRINT( MISSDK_SCRIPTSDK_LUA_000099 )
		MISSDK_SCRIPTSDK_LUA_000099 = GetResString("MISSDK_SCRIPTSDK_LUA_000099")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000099 )
		return
	end
	local ret, e = CreateEventEntity( RESOURCE_ENTITY, submap, name, cid, infoid, xpos, ypos, dir )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000100 = GetResString("MISSDK_SCRIPTSDK_LUA_000100")
		PRINT( MISSDK_SCRIPTSDK_LUA_000100, RESOURCE_ENTITY, submap, name, cid, infoid, xpos, ypos, dir )
		MISSDK_SCRIPTSDK_LUA_000101 = GetResString("MISSDK_SCRIPTSDK_LUA_000101")
		LG( "entity_error", MISSDK_SCRIPTSDK_LUA_000101, RESOURCE_ENTITY, submap, name, cid, infoid, xpos, ypos, dir )
		return
	end
	ret = SetEntityData( e, itemid, count, time )
	if ret ~= LUA_TRUE then
		MISSDK_SCRIPTSDK_LUA_000102 = GetResString("MISSDK_SCRIPTSDK_LUA_000102")
		PRINT( MISSDK_SCRIPTSDK_LUA_000102, e, itemid, count, time )
		LG( "entity_error", "CreateResourceEntity:e, itemid, count, time", e, itemid, count, time )
		return
	end
end

--设置角色转职职业类别和角色类型限定条件判断信息，
function AddPfTable( curpf, uppf )
	if Profession[curpf] == nil then
		Profession[curpf] = {}
		Profession[curpf].count = 0
	end
	
	for n = 1, Profession[curpf].count, 1 do
		if Profession[curpf][n] == uppf then
			MISSDK_SCRIPTSDK_LUA_000103 = GetResString("MISSDK_SCRIPTSDK_LUA_000103")
			PRINT( MISSDK_SCRIPTSDK_LUA_000103, curpf, uppf )
			MISSDK_SCRIPTSDK_LUA_000104 = GetResString("MISSDK_SCRIPTSDK_LUA_000104")
			LG( "PfTable_error", MISSDK_SCRIPTSDK_LUA_000104 )
			return
		end
	end
	
	Profession[curpf].count = Profession[curpf].count + 1
	Profession[curpf][Profession[curpf].count] = uppf
	
	LG( "PfTable", "AddPfTable, curpf, uppf, count", curpf, uppf, Profession[curpf].count )
end

function AddCatTable( cat, pf )
	if Category[cat] == nil then
		Category[cat] = {}
		Category[cat].count = 0
	end
	
	for n = 1, Category[cat].count, 1 do
		if Category[cat][n] == pf then
			MISSDK_SCRIPTSDK_LUA_000105 = GetResString("MISSDK_SCRIPTSDK_LUA_000105")
			PRINT( MISSDK_SCRIPTSDK_LUA_000105, cat, pf )
			MISSDK_SCRIPTSDK_LUA_000106 = GetResString("MISSDK_SCRIPTSDK_LUA_000106")
			LG( "PfTable_error", MISSDK_SCRIPTSDK_LUA_000106 )
			return
		end
	end
	
	Category[cat].count = Category[cat].count + 1
	Category[cat][Category[cat].count] = pf
	
	LG( "PfTable", "AddCatTable, cat, pf, count ", cat, pf, Category[cat].count )
end

------------------------------------------------------------
--测试代码
function TestDefPage()
	--第一页
	MISSDK_SCRIPTSDK_LUA_000107 = GetResString("MISSDK_SCRIPTSDK_LUA_000107")
	Talk( 1, MISSDK_SCRIPTSDK_LUA_000107 )
	MISSDK_SCRIPTSDK_LUA_000108 = GetResString("MISSDK_SCRIPTSDK_LUA_000108")
	Text( 1, MISSDK_SCRIPTSDK_LUA_000108, amp, 2 )
	Text( 1, "bye", ct, 2 )

	--第二页
	MISSDK_SCRIPTSDK_LUA_000109 = GetResString("MISSDK_SCRIPTSDK_LUA_000109")
	Talk( 2, MISSDK_SCRIPTSDK_LUA_000109 )

	--第三页
	MISSDK_SCRIPTSDK_LUA_000110 = GetResString("MISSDK_SCRIPTSDK_LUA_000110")
	Talk( 3, MISSDK_SCRIPTSDK_LUA_000110 )
	MISSDK_SCRIPTSDK_LUA_000111 = GetResString("MISSDK_SCRIPTSDK_LUA_000111")
	Text( 3, MISSDK_SCRIPTSDK_LUA_000111, ct )

	--初始化MultiTrigger
	InitTrigger()

	--第一个触发器
	TriggerCondition( 1, HasMission, 12 )
	TriggerCondition( 1, NoRecord, 145 )
	TriggerAction( 1, GiveItem, 789 )

	--第二个触发器
	TriggerCondition( 2, HasMission, 12 )
	TriggerCondition( 2, NoRecord, 145 )
	TriggerAction( 2, GiveItem, 789 )

	--初始化多函数列表
	InitFuncList()
	
	--添加函数到函数列表中
	AddFuncList( CreditExchange, 0 ) --要钱
	AddFuncList( CreditExchange, 1 ) --要物
	--以上两者取其一
	
	--第四页
	MISSDK_SCRIPTSDK_LUA_000112 = GetResString("MISSDK_SCRIPTSDK_LUA_000112")
	Talk( 4, MISSDK_SCRIPTSDK_LUA_000112 )
	MISSCRIPT_NPCSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000190")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_000190, MultiTrigger, GetMultiTrigger(), 2 )
	
	--初始化多函数列表
	InitFuncList()
	
	--添加函数到函数列表中
	AddFuncList( CreditExchange, 0 ) --要钱
	MISSDK_SCRIPTSDK_LUA_000113 = GetResString("MISSDK_SCRIPTSDK_LUA_000113")
	Test( 4, MISSDK_SCRIPTSDK_LUA_000113, MultiFunc, GetFuncList(), GetNumFunc() )
	
	--初始化多函数列表
	InitFuncList()
	
	--添加函数到函数列表中
	AddFuncList( CreditExchange, 1 ) --要物	
	MISSDK_SCRIPTSDK_LUA_000114 = GetResString("MISSDK_SCRIPTSDK_LUA_000114")
	Test( 4, MISSDK_SCRIPTSDK_LUA_000114, MultiFunc, GetFuncList(), GetNumFunc() )
	
	--定义交易信息
	InitTrade()

	--武器
	Weapon( 1721 )
	Weapon( 1722 )
	Weapon( 1723 )

	--防具
	Defence( 1001 )

	--其他
	Other( 1991 )

	--初始化MultiTrigger
	InitTrigger()

	--第一个触发器
	TriggerCondition( 1, HasMission, 12 )
	TriggerCondition( 1, NoRecord, 145 )
	TriggerAction( 1, jp, 1 )

	--第二个触发器
	TriggerCondition( 2, HasMission, 13 )
	TriggerCondition( 2, NoRecord, 146 )
	TriggerAction( 2, jp, 2 )

	--页开始触发器
	Start( GetMultiTrigger(), 2 )
end

--测试对话页函数
--ResetNpcInfo( "TestNpc" )
--TestDefPage()

--随机任务接受送信NPC任务信息定义
function TestDefMission( id, name, misid, scriptid, npcid, areaid )
	DefineMission( id, name, misid, COMPLETE_SHOW )
	
	MisPrize( MIS_PRIZE_MONEY, 300, 1 )
	MisPrizeSelAll() --全部给予
	
	MISSCRIPT_SENDMISSION_LUA_000001 = GetResString("MISSCRIPT_SENDMISSION_LUA_000001")
	MisBeginTalk( MISSCRIPT_SENDMISSION_LUA_000001 )
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_SENDMISSION_LUA_000001 = GetResString("MISSCRIPT_SENDMISSION_LUA_000001")
	MisReultTalk( MISSCRIPT_SENDMISSION_LUA_000001 )
	MISSDK_SCRIPTSDK_LUA_000115 = GetResString("MISSDK_SCRIPTSDK_LUA_000115")
	MisHelpTalk( MISSDK_SCRIPTSDK_LUA_000115 )
	
	MisResultCondition( HasRandMissionNpc, misid, npcid, areaid )
	MisResultCondition( NoRandNpcItemFlag, misid, npcid )
	
	MisResultAction( TakeRandNpcItem, misid, npcid, GetNpcName( npcid ) )
	MisResultAction( AddExp, 100, 1000 )
	MisResultAction( RefreshCompleteFlag, scriptid )
end

--TestDefMission( 1, "比特的包裹", 8, 3, 1 )
--AddNpcInfo( 3, "比特", 1, 1 ) --添加该NPC到信息库中

--TestDefMission( 2, "沙岚传送使的包裹", 8, 4, 1 )
--AddNpcInfo( 4, "沙岚传送使", 1, 1 )

function TestRegNpcMission()
	AddNpcMission( 2 )
end

--定义一个随机任务
function TestRandMission()
	PRINT( "TestRandMission" )
   --初始化随机任务基本信息
   MISSDK_SCRIPTSDK_LUA_000116 = GetResString("MISSDK_SCRIPTSDK_LUA_000116")
   DefineRandMission( 10, MISSDK_SCRIPTSDK_LUA_000116, 8 )

   --设置随机任务类型
   --AddRandMissionType( MIS_RAND_KILL, 1, 2, 3, 4 )
   --AddRandMissionType( MIS_RAND_GET, 5, 6, 7, 8 )
   --AddRandMissionType( MIS_RAND_SEND, 9, 10, 11, 12 )
   AddRandMissionType( MIS_RAND_CONVOY, 1, 2, 3, 4, 5 )
   --AddRandMissionType( MIS_RAND_EXPLORE )
   PRINT( "AddRandMissionType" )
   
   --设置摧毁数据库信息
   --AddRandKillInfo( 1, 69, 1, 8, 100, 50 )
   --AddRandKillInfo( 2, 69, 1, 4, 200, 100 )
   --AddRandKillInfo( 2, 70, 1, 4, 400, 200 )
   
   --
   --AddRandGetItem( 2, 1721, 1, 4, 18, 80 )
   --AddRandGetItem( 2, 1715, 5, 4, 80, 800 )
   
   --
   --AddRandSendInfo( 2, 3, 190, 290 )
   --AddRandSendInfo( 2, 4, 390, 890 )

   --2级随机可送的物品信息添加
   --AddRandSendItem( 2, 1721 )
   --AddRandSendItem( 2, 1722 )
   --AddRandSendItem( 2, 1723 )
   --AddRandSendItem( 2, 1715 )
   
   --
   AddRandConvoyInfo( 2, 1, 1, 1, 2198, 2780, 10, 60, 120 )
   
   --   AddRandPrizeItem( 2, 2 )
   AddRandPrizeItem( 2, 3 )
   AddRandPrizeItem( 2, 4 )
   AddRandPrizeItem( 2, 5 )
   AddRandPrizeItem( 2, 6 )
   
   SetRandPrizeOdds( 2, 50, 5 )

end

--TestRandMission()

--测试任务信息注册函数
--ResetNpcInfo( "TestNpc" )
--TestDefMission()
--TestRegNpcMission()

--测试出生
function TestBorn()
	PRINT( "TestBorn" )
	InitTrigger()
	--TriggerAction( 1, AddTrigger, 24, TE_LEVELUP, 15, 1 )
	--TriggerAction( 1, AddTrigger, 25, TE_GOTO_MAP, 1, 2198, 2780, 10 )
	--TriggerAction( 1, AddTrigger, 26, TE_GAMETIME, TT_MULTITIME, 1, 1 )
	--TriggerAction( 1, AddTrigger, 27, TE_GAMETIME, TT_CYCLETIME, 1, 0 )
	--TriggerAction( 1, AddTrigger, 28, TE_GAMETIME, TT_MULTITIME, 1, 10 )
	--TriggerAction( 1, AddTrigger, 29, TE_KILL, 69, 2 )
	--TriggerAction( 1, AddTrigger, 30, TE_GETITEM, 1721, 2 )
	RegTrigger( 88888, 1 )
	
	--define trigger 24
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Level up 15! trigger action!" )
	RegTrigger( 24, 1 )
	
	--define trigger 25
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Goto map, 2197, 2780, 10 m!" )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	TriggerAction( 1, SummonNpc, 1, 1, MISSCRIPT_MISSIONSCRIPT01_LUA_000190, 4 )
	RegTrigger( 25, 1 )
	
	--define trigger 26
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Time single per 1 minute trig" )
	MISSDK_SCRIPTSDK_LUA_000117 = GetResString("MISSDK_SCRIPTSDK_LUA_000117")
	TriggerAction( 1, SystemNotice, MISSDK_SCRIPTSDK_LUA_000117 )
	RegTrigger( 26, 1 )
	
	--define trigger 27
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Time cycle per 1 minute" )
	MISSDK_SCRIPTSDK_LUA_000118 = GetResString("MISSDK_SCRIPTSDK_LUA_000118")
	TriggerAction( 1, HelpInfo, MIS_HELP_DESP, MISSDK_SCRIPTSDK_LUA_000118 )
	MISSDK_SCRIPTSDK_LUA_000119 = GetResString("MISSDK_SCRIPTSDK_LUA_000119")
	TriggerAction( 1, HelpInfo, MIS_HELP_IMAGE, MISSDK_SCRIPTSDK_LUA_000119 )
	TriggerAction( 1, HelpInfo, MIS_HELP_SOUNT, 18 )
	RegTrigger( 27, 1 )
	
	--define trigger 28
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Time multitime per 1 minute 10 count" )
	RegTrigger( 28, 1 )
	
	--define trigger 29
	InitTrigger()
	TriggerAction( 1, SystemNotice, "kill 69 monster" )
	RegTrigger( 29, 1 )
	
	--define trigger 30
	InitTrigger()
	TriggerAction( 1, SystemNotice, "Getitem 1721" )
	RegTrigger( 30, 1 )	
	
end
--TestBorn()


--设置转职限制信息
function TestConvertProfession()
	--新手无转职限制 
	
	--剑士转职
	AddPfTable( 1, 8 )		--转职为巨剑士
	AddPfTable( 1, 9 )		--转职为双剑士
	AddPfTable( 1, 10 )		--转职为剑盾士
	
	--猎人转职
	AddPfTable( 2, 11 )		--转职为训兽师
	AddPfTable( 2, 12 )		--转职为狙击手
	
	--水手转职
	AddPfTable( 3, 15 )		--转职为船长
	
	--冒险者转职
	AddPfTable( 4, 16 ) 	--转职为航海士
	
	--祈愿使转职
	AddPfTable( 5, 13 )		--转职为圣职者
	AddPfTable( 5, 14 )		--转职为封印师
	
	--技师转职
	AddPfTable( 6, 18 )		--转职为工程师
	
	--商人转职
	AddPfTable( 7, 17 )		--转职为商人
	
	--角色体形限制
	--长发男转职
	AddCatTable( 1, 1 )		--转职为剑士
	AddCatTable( 1, 2 )		--转职为猎人
	AddCatTable( 1, 4 )		--转职为冒险者
	AddCatTable( 1, 7 )		--转职为商人
	AddCatTable( 1, 9 )		--转职为双剑士
	AddCatTable( 1, 10 )	--转职为剑盾士
	AddCatTable( 1, 11 )	--转职为驯兽师
	AddCatTable( 1, 12 )	--转职为狙击手
	AddCatTable( 1, 16 )	--转职为航海士
	AddCatTable( 1, 17 )	--转职为爆发户
	
	--魁梧男转职
	AddCatTable( 2, 1 )		--转职为剑士
	AddCatTable( 2, 3 )		--转职为水手
	AddCatTable( 2, 6 )		--转职为技师
	AddCatTable( 2, 7 )		--转职为商人
	AddCatTable( 2, 8 )		--转职为巨剑士
	AddCatTable( 2, 10 )	--转职为剑盾士
	AddCatTable( 2, 17 )	--转职为爆发户
	
	--女主角一转职
	AddCatTable( 3, 1 )		--转职为剑士
	AddCatTable( 3, 2 )		--转职为猎人
	AddCatTable( 3, 3 )		--转职为水手
	AddCatTable( 3, 5 )		--转职为祈愿使
	AddCatTable( 3, 7 )		--转职为商人
	AddCatTable( 3, 9 )		--转职为双剑士
	AddCatTable( 3, 11 )	--转职为训兽师
	AddCatTable( 3, 12 )	--转职为狙击手
	AddCatTable( 3, 13 )	--转职为圣职者
	AddCatTable( 3, 14 )	--转职为封印师
	AddCatTable( 3, 15 )	--转职为船长
	AddCatTable( 3, 17 )	--转职为暴发户
	
	--女主角二转职
	AddCatTable( 4, 4 )		--转职为冒险者
	AddCatTable( 4, 5 )		--转职为祈愿使
	AddCatTable( 4, 6 )		--转职为技师
	AddCatTable( 4, 7 )		--转职为商人
	AddCatTable( 4, 13 )	--转职为圣职者
	AddCatTable( 4, 14 )	--转职为封印师
	AddCatTable( 4, 16 )	--转职为航海士
	AddCatTable( 4, 17 )	--转职为暴发户
	AddCatTable( 4, 18 )	--转职为工程师
end

--TestConvertProfession()

--测试打包
--SetWoodResource( 1, 3989, 10, 3999 )
--SetMineResource( 1, 1, 1, 2 )

--船只升级数据测试
--InitBoatLevel()
--AddBoatLevel( 1, 10, 0)
--AddBoatLevel( 2, 10, 0)
--AddBoatLevel( 3, 10, 0)
--AddBoatLevel( 4, 10, 0)
--AddBoatLevel( 5, 10, 0)
--AddBoatLevel( 6, 10, 0)
--AddBoatLevel( 7, 10, 0)


function GetNpc(character, name)

	--SystemNotice( character, "NpcInfoList.count"..NpcInfoList.count )
	
	for n = 1, NpcInfoList.count, 1 do
		if NpcInfoList[n].Name == name then
			--SystemNotice( character, "NpcInfoList[NpcInfoList.count].Name"..NpcInfoList[n].Name )
			return NpcInfoList[n].Npc
		end
	end
	
	return nil
end
