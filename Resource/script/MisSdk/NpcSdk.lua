--------------------------------------------------------------------------
--									--
--									--
--				NpcSdk.lua 				-- 
--									--
--									--
--------------------------------------------------------------------------
print( "-------------------Server Files v2.4----------------------" )
print( "-----------------Pirates King Online II-------------------" )
print( "----------Credits to FoxLv Team for Base Files------------" )
print( " " )
print( "------------------------------------" )
print( "Loading SDK Files:" )
print( "------------------------------------" )
print( "Loading NpcSdk.lua" )


--服务器端发送命令消息协议定义
CMD_MC_BASE			= 500
CMD_MC_ROLEBASE 		= CMD_MC_BASE + 300
CMD_MC_TALKPAGE 		= CMD_MC_ROLEBASE + 1
CMD_MC_FUNCPAGE 		= CMD_MC_ROLEBASE + 2
CMD_MC_CLOSETALK 		= CMD_MC_ROLEBASE + 3
CMD_MC_HELPINFO			= CMD_MC_ROLEBASE + 4  -- 帮助信息
CMD_MC_TRADEPAGE		= CMD_MC_ROLEBASE + 5
CMD_MC_TRADERESULT		= CMD_MC_ROLEBASE + 6
CMD_MC_TRADE_DATA		= CMD_MC_ROLEBASE + 7 -- NPC交易数据信息更新
CMD_MC_TRADE_ALLDATA		= CMD_MC_ROLEBASE + 8 -- NPC交易所有数据信息更新

CMD_MC_MISSION			= CMD_MC_ROLEBASE + 22
CMD_MC_MISSIONLIST		= CMD_MC_ROLEBASE + 23
CMD_MC_MISSIONTALK		= CMD_MC_ROLEBASE + 24
CMD_MC_MISPAGE			= CMD_MC_ROLEBASE + 27 -- 任务页信息
CMD_MC_MISLOG			= CMD_MC_ROLEBASE + 28 -- 任务日志
CMD_MC_MISLOGINFO		= CMD_MC_ROLEBASE + 29 -- 单个任务详细信息
CMD_MC_BEGIN_ITEM_FORGE   	= CMD_MC_ROLEBASE + 35 -- 精练道具
CMD_MC_BEGIN_ITEM_UNITE   	= CMD_MC_ROLEBASE + 36 -- 道具合成

CMD_MC_CREATEBOAT		= CMD_MC_ROLEBASE + 38 -- 创建船只
CMD_MC_UPDATEBOAT		= CMD_MC_ROLEBASE + 39 -- 改造船只
CMD_MC_UPDATEBOAT_PART		= CMD_MC_ROLEBASE + 40 -- 改造船只的部件
CMD_MC_BERTH_LIST		= CMD_MC_ROLEBASE + 41 -- 船只停泊列表
CMD_MC_BOAT_LIST		= CMD_MC_ROLEBASE + 42 -- 同步角色拥有的所有船只属性
CMD_MC_BOAT_ADD			= CMD_MC_ROLEBASE + 43 -- 添加一艘船
CMD_MC_BOAT_CLEAR		= CMD_MC_ROLEBASE + 44 -- 清除一艘船
CMD_MC_BOATINFO			= CMD_MC_ROLEBASE + 45 -- 同步船只属性信息
CMD_MC_BOAT_BAGLIST		= CMD_MC_ROLEBASE + 46 -- 显示可以打包的船只列表

--客户端发送命令消息协议定义
CMD_CM_BASE			= 0
CMD_CM_ROLEBASE 		= CMD_CM_BASE + 300
CMD_CM_REQUESTTALK 		= CMD_CM_ROLEBASE + 1
CMD_CM_TALKPAGE			= CMD_CM_ROLEBASE + 2
CMD_CM_FUNCITEM 		= CMD_CM_ROLEBASE + 3
CMD_CM_REQESTTRADE    		= CMD_CM_ROLEBASE + 8
CMD_CM_TRADEITEM		= CMD_CM_ROLEBASE + 9
CMD_CM_REQUESTAGENCY		= CMD_CM_ROLEBASE + 10
CMD_CM_MISSION			= CMD_CM_ROLEBASE + 22
CMD_CM_MISSIONLIST		= CMD_CM_ROLEBASE + 23
CMD_CM_MISSIONTALK		= CMD_CM_ROLEBASE + 24
CMD_CM_MISLOG			= CMD_CM_ROLEBASE + 25 -- 任务日志

--黑市交易
CMD_MC_BLACKMARKET_EXCHANGEDATA		= CMD_MC_BASE + 71	-- 黑市兑换数据
CMD_MC_BLACKMARKET_EXCHANGEUPDATE 	= CMD_MC_BASE + 73	-- 黑市兑换更新
CMD_MC_BLACKMARKET_TRADEUPDATE 		= CMD_MC_BASE + 74	-- 黑市交易更新
CMD_MC_EXCHANGEDATA 			= CMD_MC_BASE + 75
CMD_CM_BLACKMARKET_EXCHANGE_REQ 	= CMD_CM_BASE + 51


--对话页命令信息
ROLE_FIRSTPAGE			= 0		-- 请求初次对话信息
ROLE_CLOSEPAGE			= -1		-- 请求关闭对话页命令

--交易宏信息定义
ROLE_MAXNUM_TRADEITEM 		= 60	--每个交易页最大摆放物品数量
ROLE_INVALID_ID			= -1		--无效的索引

--交易物品类型定义
WEAPON 						= 0		--武器类型
DEFENCE 						= 1 		--防具类型
OTHER    						= 2		--杂项类型
SYNTHESIS 					= 3		--合成物品类型

TRADE_SALE					= 0       --出售物品操作
TRADE_BUY						= 1       --购买物品操作
TRADE_GOODS				= 2 		--交易船舱货物

ROLE_TRADE_SALE				= 0	--请求出售物品
ROLE_TRADE_BUY				= 1	--请求购买物品
ROLE_TRADE_SALE_GOODS 	= 2	--请求出售货舱物品
ROLE_TRADE_BUY_GOODS		= 3	--请求购买货舱物品
ROLE_TRADE_SELECT_BOAT   = 4   --选择交易的船只

--船只显示列表类型
BERTH_TRADE_LIST				= 0	-- 交易船只列表
BERTH_LUANCH_LIST			= 1	-- 出海船只列表
BERTH_REPAIR_LIST				= 3	-- 船只修理列表
BERTH_SALVAGE_LIST			= 4	-- 船只打捞列表
BERTH_SUPPLY_LIST			= 5	-- 船只补给列表
BERTH_BOATLEVEL_LIST		= 6	-- 船只升级列表

--资源类型
RES_WOOD							= 0	--木材资源
RES_MINE							= 1	--矿石资源

--对话宏定义
ROLE_MAXNUM_PAGEITEM	= 9

--帮助信息类型
MIS_HELP_DESP				= 0		--文字帮助信息
MIS_HELP_IMAGE				= 1		--图形帮助信息
MIS_HELP_SOUND			= 2		--声音帮助信息
MIS_HELP_BICKER			= 3		--闪动字体信息

--发送对话页函数
function SendTalkPage( character, npc, pageid, desp )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_TALKPAGE );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	WriteByte( packet, pageid );
	WriteString( packet, desp );
	SendPacket( character, packet );
end

--向客户端发送兑换数据
function SendExchangeData( character, npc )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_BLACKMARKET_EXCHANGEDATA )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	
	if Exchange.count ~= nil then
		WriteWord( packet, Exchange.count )
		
		for n = 1, Exchange.count, 1 do
			WriteWord( packet, Exchange.srcid[n] )
			WriteWord( packet, Exchange.srcnum[n] )
			WriteWord( packet, Exchange.tarid[n] )
			WriteWord( packet, Exchange.tarnum[n] )
			WriteWord( packet, Exchange.timenum[n] )
		end
	else
		WriteWord( packet, 0 )
	end
	
	SendPacket( character, packet );
end

function SendExchangeXData( character, npc, exchangeData )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_EXCHANGEDATA )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	
	if exchangeData.count ~= nil then
		WriteWord( packet, exchangeData.count )
		
		for n = 1, exchangeData.count, 1 do
			WriteWord( packet, exchangeData.srcid[n] )
			WriteWord( packet, exchangeData.srcnum[n] )
			WriteWord( packet, exchangeData.tarid[n] )
			WriteWord( packet, exchangeData.tarnum[n] )
		end
	else
		WriteWord( packet, 0 )
	end
	
	SendPacket( character, packet );
end

--向客户端发送兑换更新数据
function SendExchangeUpdateData( character, npc )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_BLACKMARKET_EXCHANGEUPDATE )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	
	if Exchange.count ~= nil then
		WriteWord( packet, Exchange.count )
		
		for n = 1, Exchange.count, 1 do
			WriteWord( packet, Exchange.srcid[n] )
			WriteWord( packet, Exchange.srcnum[n] )
			WriteWord( packet, Exchange.tarid[n] )
			WriteWord( packet, Exchange.tarnum[n] )
			WriteWord( packet, Exchange.timenum[n] )
		end
	else
		WriteWord( packet, 0 )
	end
	
	SynPacket( npc, packet )
end

function SendDebugPage( character, npc, info )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_TALKPAGE );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	WriteByte( packet, ROLE_CLOSEPAGE );
	WriteString( packet, info );
	SendPacket( character, packet );
end

--发送服务器提示帮助页信息
function HelpInfo( character, tp, info )
	PRINT( "HelpInfo" )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_HELPINFO )
	WriteByte( packet, tp )

	if tp == MIS_HELP_SOUND then
		WriteWord( packet, info )
	else
		WriteString( packet, info )
	end

	SendPacket( character, packet );
end

--发送功能页函数
function SendFuncPage( character, npc, pageid, item, count )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_FUNCPAGE );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	WriteByte( packet, pageid );
	WriteByte( packet, count );
	--PRINT( "发送功能页函数，count = ", count )
	for i = 1, count, 1 do
		--PRINT( "发送功能页函数，i = ", i, item[i] )
		if item[i] ~= nil then
			WriteString( packet, item[i] )
		else
			MISSDK_NPCSDK_LUA_000001 = GetResString("MISSDK_NPCSDK_LUA_000001")
			WriteString( packet, MISSDK_NPCSDK_LUA_000001 )
		end
	end
	SendPacket( character, packet );
end

--发送页信息
function SendPage( character, npc, pageid, talk, item, count )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_FUNCPAGE );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	WriteByte( packet, pageid );
	WriteString( packet, talk );
	WriteByte( packet, count );
	--PRINT( "发送功能页函数，count = ", count )
	for i = 1, count, 1 do
		--PRINT( "发送功能页函数，i = ", i, item[i] )
		if item[i] ~= nil then
			WriteString( packet, item[i] )
		else
			MISSDK_NPCSDK_LUA_000001 = GetResString("MISSDK_NPCSDK_LUA_000001")
			WriteString( packet, MISSDK_NPCSDK_LUA_000001 )
		end
	end
	SendPacket( character, packet );
end

--发送含任务列表信息对话页
function SendMissionPage( character, npc, pageid, talk, item, count, misitem, misnum )
	PRINT( "SendMissionPage" )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_FUNCPAGE );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	WriteByte( packet, pageid );
	WriteString( packet, talk );
	WriteByte( packet, count );
	--PRINT( "发送功能页函数，count = ", count )
	for i = 1, count, 1 do
		--PRINT( "发送功能页函数，i = ", i, item[i] )
		if item[i] ~= nil then
			WriteString( packet, item[i] )
		else
			MISSDK_NPCSDK_LUA_000001 = GetResString("MISSDK_NPCSDK_LUA_000001")
			WriteString( packet, MISSDK_NPCSDK_LUA_000001 )
		end
	end
	WriteByte( packet, misnum )
	MISSDK_NPCSDK_LUA_000002 = GetResString("MISSDK_NPCSDK_LUA_000002")
	PRINT( MISSDK_NPCSDK_LUA_000002..misnum )
	for n = 1, misnum, 1 do
		MISSDK_NPCSDK_LUA_000003 = GetResString("MISSDK_NPCSDK_LUA_000003")
		PRINT( MISSDK_NPCSDK_LUA_000003, misitem[n].name, misitem[n].state )
		WriteString( packet, misitem[n].name )
		WriteByte( packet, misitem[n].state )
	end
	SendPacket( character, packet );
end

--关闭对话函数
function SendClosePage( character, npc )
	local packet = GetPacket();
	WriteCmd( packet, CMD_MC_CLOSETALK );
	local npcid = GetCharID( npc );
	WriteDword( packet, npcid );
	SendPacket( character, packet );
end

--发送任务列表信息
function SendMissionList( character, npc, missionlist, itemid, optype, listtype )
	PRINT( "SendMissionList, itemid, optype, listtype", itemid, optype, listtype )
	local npcid = GetCharID( npc )
	local ret, num = GetNumMission( character, npcid, listtype )
	if ret ~= LUA_TRUE then
		MISSDK_NPCSDK_LUA_000004 = GetResString("MISSDK_NPCSDK_LUA_000004")
		PRINT( MISSDK_NPCSDK_LUA_000004 )
		MISSDK_NPCSDK_LUA_000004 = GetResString("MISSDK_NPCSDK_LUA_000004")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000004 )
	end
	PRINT( "itemid = %d, num = %d", itemid, num )
	if itemid >= num then
		MISSDK_NPCSDK_LUA_000005 = GetResString("MISSDK_NPCSDK_LUA_000005")
		PRINT( MISSDK_NPCSDK_LUA_000005 )
		MISSDK_NPCSDK_LUA_000005 = GetResString("MISSDK_NPCSDK_LUA_000005")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000005 )
	end

	MISSDK_NPCSDK_LUA_000006 = GetResString("MISSDK_NPCSDK_LUA_000006")
	PRINT( MISSDK_NPCSDK_LUA_000006 )
	local count, previd, nextid, itemnum = 1, 0, 0, 0
	local item = {}

	--计算起始第一行索引
	if optype == MIS_NEXT then
		previd = itemid + 1
		nextid = num - itemid
	else
		if itemid <= 8 then
			previd = 1
			if num >= 8 then
				nextid = 8
			else
				nextid = num
			end
		else
			previd = itemid - 8
			nextid = itemid
		end
	end

	--计算最后一行索引
	PRINT( "SendMissionList:previd = %d, nextid = %d", previd, nextid )
	for n = previd, nextid, 1 do
		itemnum = n
		local index = n - 1
		PRINT( "index = ", index )
		local ret, id, step = GetMissionInfo( character, npcid, listtype, index )
		if ret ~= LUA_TRUE then
			break
		end
		PRINT( "SendMissionList:missionid = %d, step = %d", id, step )
		if missionlist[id] == nil or missionlist[id].name == nil then
			MISSDK_NPCSDK_LUA_000007 = GetResString("MISSDK_NPCSDK_LUA_000007")
			item[count] = MISSDK_NPCSDK_LUA_000007
		else
			item[count] = missionlist[id].name
		end
		count = count + 1
	end

	--发送列表信息
	MISSDK_NPCSDK_LUA_000008 = GetResString("MISSDK_NPCSDK_LUA_000008")
	PRINT( MISSDK_NPCSDK_LUA_000008 )
	if count < 1 then
		MISSDK_NPCSDK_LUA_000009 = GetResString("MISSDK_NPCSDK_LUA_000009")
		PRINT( MISSDK_NPCSDK_LUA_000009 )
		MISSDK_NPCSDK_LUA_000009 = GetResString("MISSDK_NPCSDK_LUA_000009")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000009 )
	end

	previd = previd - 1
	nextid = nextid - 1
	PRINT( "SendMissionList:previd = %d, nextid = %d, count = %d", previd, nextid, count )
	PRINT( "SendMissionList:sendpacket" )
	--发送报文信息
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_MISSION )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	WriteByte( packet, listtype )
	WriteByte( packet, previd )
	WriteByte( packet, nextid )

	MISSDK_NPCSDK_LUA_000010 = GetResString("MISSDK_NPCSDK_LUA_000010")
	PRINT( MISSDK_NPCSDK_LUA_000010, previd, nextid )
	--设置页
	if previd == 0 then
		MISSDK_NPCSDK_LUA_000011 = GetResString("MISSDK_NPCSDK_LUA_000011")
		PRINT( MISSDK_NPCSDK_LUA_000011 )
		WriteByte( packet, MIS_PREV_END )
	else
		MISSDK_NPCSDK_LUA_000012 = GetResString("MISSDK_NPCSDK_LUA_000012")
		PRINT( MISSDK_NPCSDK_LUA_000012 )
		WriteByte( packet, MIS_PREV )
	end
	local endid = num - 1
	if nextid == endid then
		MISSDK_NPCSDK_LUA_000013 = GetResString("MISSDK_NPCSDK_LUA_000013")
		PRINT( MISSDK_NPCSDK_LUA_000013 )
		WriteByte( packet, MIS_NEXT_END )
	else
		MISSDK_NPCSDK_LUA_000014 = GetResString("MISSDK_NPCSDK_LUA_000014")
		PRINT( MISSDK_NPCSDK_LUA_000014 )
		WriteByte( packet, MIS_NEXT )
	end

	WriteByte( packet, count - 1 )
	for i = 1, count - 1, 1 do
		PRINT( item[i] )
		WriteString( packet, item[i] )
	end
	PRINT( "SendMissionPage" )
	SendPacket( character, packet )
	SetMissionPage( character, npcid, previd, nextid, listtype )
	return LUA_TRUE
end
JParg = {}
--执行页跳转命令
roleQues={}
roleAns={}
function DealQues(name)
	roleQues[name]=nil
	roleAns[name]=0
end
function BaiChi(role,num,num1) 
	local name =GetChaDefaultName(role)
	if num<num1 then
		MISSDK_NPCSDK_LUA_000015 = GetResString("MISSDK_NPCSDK_LUA_000015")
		MISSDK_NPCSDK_LUA_000016 = GetResString("MISSDK_NPCSDK_LUA_000016")
		ScrollNotice(name..MISSDK_NPCSDK_LUA_000016..(num1-num)..MISSDK_NPCSDK_LUA_000015,1)
		MISSDK_NPCSDK_LUA_000017 = GetResString("MISSDK_NPCSDK_LUA_000017")
		MISSDK_NPCSDK_LUA_000016 = GetResString("MISSDK_NPCSDK_LUA_000016")
		Notice(name..MISSDK_NPCSDK_LUA_000016..(num1-num)..MISSDK_NPCSDK_LUA_000017)
	else
		MISSDK_NPCSDK_LUA_000018 = GetResString("MISSDK_NPCSDK_LUA_000018")
		ScrollNotice(name..MISSDK_NPCSDK_LUA_000018,1)
		MISSDK_NPCSDK_LUA_000018 = GetResString("MISSDK_NPCSDK_LUA_000018")
		Notice(name..MISSDK_NPCSDK_LUA_000018)
	end
	MISSDK_NPCSDK_LUA_000019 = GetResString("MISSDK_NPCSDK_LUA_000019")
	MISSDK_NPCSDK_LUA_000020 = GetResString("MISSDK_NPCSDK_LUA_000020")
	return MISSDK_NPCSDK_LUA_000020..num..MISSDK_NPCSDK_LUA_000019
end
function JumpPage( character, npc, page, param )
	if page == nil or param == nil or page[param] == nil then
		MISSDK_NPCSDK_LUA_000021 = GetResString("MISSDK_NPCSDK_LUA_000021")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000021 )
	end
	if page[param][1] == nil then
		MISSDK_NPCSDK_LUA_000022 = GetResString("MISSDK_NPCSDK_LUA_000022")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000022 )
	end
	local isQues = 0
	local roleName= GetChaDefaultName(character)
	local QuesError= 1
	local QuesOtherDeal = 0
	local CurNextQues = 1
	if param == 1 then 
		if roleQues[roleName]~= nil then 
			DealQues(roleName)
		end
	end
	--提取对话信息
	local talk = ""
	local talkadd = ""
	if page[param][1] ~= nil and page[param][1].talk ~= nil then
		if page[param][1].talkfunc~= nil then
			--选择对话
			-- Talk(1,"前置对话","choose","函数标记",参数1,参数2,...,"chooseEnd","对话1","对话2",...)
			if page[param][1].talkfunc == "choose" then
				if page[param][1].func1~= nil then 
					local argcount = 0
					local i= 1 
					for i =1 , page[param][1].p.count, 1 do
						if page[param][1].p[i]~= nil then 
							if page[param][1].p[i] ~= "chooseEnd" then
								argcount = argcount+1
							else 
								i =page[param][1].p.count+1
							end
						end
					end
					local chooseType = 0
					if page[param][1].func1 == "chooseExample" then
						chooseType  = chooseExample(character,page[param][1].p[1],page[param][1].p[2])
					end
					if chooseType~=0 and chooseType+argcount<=page[param][1].p.count  then
						talkadd = page[param][1].p[1+chooseType+argcount] 
					end
				end
			--直接添加
			-- Talk(1,"前置对话","add","函数标记",参数1,参数2,...)
			elseif page[param][1].talkfunc == "add" then
				if page[param][1].func1 == "addExample" then
					talkadd  =addExample(character,page[param][1].p[1],page[param][1].p[2])
				elseif page[param][1].func1 == "CanChargeQiByAll" then
					talkadd = CanChargeQiByAll(character)
				elseif page[param][1].func1 == "CanChargeQiByOne" then
					talkadd = CanChargeQiByOne(character)
				elseif page[param][1].func1 == "GetZhanBuInfo" then
					talkadd = GetZhanBuInfo(character)				
				elseif page[param][1].func1 == "ZBChaXun" then
					talkadd = ZBChaXun(character)				
				elseif page[param][1].func1 == "CanZhanBubyRole" then
					talkadd = CanZhanBubyRole(character)				
				elseif page[param][1].func1 == "CanZhanBu" then
					talkadd = CanZhanBu(character)
				elseif page[param][1].func1 == "CheckKZRH" then
					talkadd = CheckKZRH(character)
				elseif page[param][1].func1 == "CheckCZCL" then
					talkadd = CheckCZCL(character)
				elseif page[param][1].func1 == "GetZTLCharge" then
					talkadd = GetZTLCharge(character)
				elseif page[param][1].func1 == "GetZTLMessage" then
					talkadd = GetZTLMessage(character)
				elseif page[param][1].func1 == "Box_choose1" then
					talkadd = Box_choose1(character)
				elseif page[param][1].func1 == "Box_choose2" then
					talkadd = Box_choose2(character)
				elseif page[param][1].func1 == "Box_choose3" then
					talkadd = Box_choose3(character)
				elseif page[param][1].func1 == "CanChargeAllTZXZ" then
					talkadd = CanChargeAllTZXZ(character)
				elseif page[param][1].func1 == "CanChargeTZXZ" then
					talkadd = CanChargeTZXZ(character)
				elseif page[param][1].func1 == "Box_choose4" then
					talkadd = Box_choose4(character)
				elseif page[param][1].func1 == "Box_choose5" then
					talkadd = Box_choose5(character)
				elseif page[param][1].func1 == "Box_choose6" then
					talkadd = Box_choose6(character)		
				elseif page[param][1].func1 == "Box_choose7" then
					talkadd = Box_choose7(character)
				elseif page[param][1].func1 == "CanGiveSHCool" then
					talkadd = CanGiveSHCool(character)
				elseif page[param][1].func1 == "GetNewXingZuoKaNeed" then
					talkadd = GetNewXingZuoKaNeed(character)
				elseif page[param][1].func1 == "IsGiveXZNewItem" then
					talkadd = IsGiveXZNewItem(character)
				------------------愚人节----------X1-------------
				elseif page[param][1].func1 == "Yurenjie1" then
					talkadd = Yurenjie1(character)
				elseif page[param][1].func1 == "Yurenjie2" then
					talkadd = Yurenjie2(character)
				elseif page[param][1].func1 == "Yurenjie3" then
					talkadd = Yurenjie3(character)
				else 
					talkadd = "Hello"
				end
			--添加中间变量
			-- Talk(1,"前置对话","insert","函数标记",参数1,参数2,...,"后置对话")
			elseif page[param][1].talkfunc == "insert" then
				if page[param][1].func1~= nil then 
					local insert = ""
					if page[param][1].func1 == "insertExample" then
						insert  = insertExample(character,page[param][1].p[1],page[param][1].p[2])
					end
					talkadd =  insert..page[param][1].p[page[param][1].p.count]
				end
			MISSCRIPT_NPCSCRIPT01_LUA_002552 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_002552")
			elseif page[param][1].talkfunc == MISSCRIPT_NPCSCRIPT01_LUA_002552 then
				-- LG("ques","问答开始！")
				isQues = 1 
				
				-- LG("ques","系列号为",page[param][1].func1)
				if page[param][1].func1~= nil then 
					local i = 0 
					for i = 1, QuesLab.count ,1 do 
						if page[param][1].func1 == QuesLab[i].des then
							curQues = i
							-- LG("ques","连接",i,"号问题库")
							break
						end
					end
					-- LG("ques","初始化对话")
					if roleQues[roleName] == nil then
						MISSDK_NPCSDK_LUA_000023 = GetResString("MISSDK_NPCSDK_LUA_000023")
						MISSDK_NPCSDK_LUA_000024 = GetResString("MISSDK_NPCSDK_LUA_000024")
						LG("ques",MISSDK_NPCSDK_LUA_000024,roleName,MISSDK_NPCSDK_LUA_000023)
						MISSDK_NPCSDK_LUA_000025 = GetResString("MISSDK_NPCSDK_LUA_000025")
						LG("ques",MISSDK_NPCSDK_LUA_000025,QuesLab[curQues].des)
						-- LG("ques","第一次对话")
						roleQues[roleName]={}
						roleQues[roleName].ques = page[param][1].func1
						roleQues[roleName].quesNext = 1
						roleQues[roleName].errorlist = {}
						roleQues[roleName].errorlist.count = 0
						roleQues[roleName].out= 0
						roleQues[roleName].choose={}
						roleQues[roleName].curNextQues= 0
					else
						if roleAns[roleName]<roleQues[roleName].quesNext then ---回答错误
							QuesError = 0
							-- LG("ques","回答错误")	
						end
						if roleAns.error[roleName]== 1  then 
							MISSDK_NPCSDK_LUA_000026 = GetResString("MISSDK_NPCSDK_LUA_000026")
							talkadd = MISSDK_NPCSDK_LUA_000026
						else
							MISSDK_NPCSDK_LUA_000027 = GetResString("MISSDK_NPCSDK_LUA_000027")
							talkadd = MISSDK_NPCSDK_LUA_000027
						end
						roleQues[roleName].quesNext = roleQues[roleName].quesNext+1
					end
					MISSDK_NPCSDK_LUA_000028 = GetResString("MISSDK_NPCSDK_LUA_000028")
					CALCULATE_FUNCTIONS_LUA_000503 = GetResString("CALCULATE_FUNCTIONS_LUA_000503")
					LG("ques",CALCULATE_FUNCTIONS_LUA_000503,roleQues[roleName].quesNext,MISSDK_NPCSDK_LUA_000028)
					if roleQues[roleName].quesNext<= page[param][1].p[1] then 
						if QuesLab[curQues].type_ask == 1 then
							CurNextQues = math.fmod(roleQues[roleName].quesNext-1,QuesLab[curQues].count)+1
						else
							CurNextQues= math.random(1,QuesLab[curQues].count)
						end
						-- LG("ques","连接问题库的第",curQues,"个问题的第",CurNextQues,"个问题")
						MISSDK_NPCSDK_LUA_000029 = GetResString("MISSDK_NPCSDK_LUA_000029")
						MISSDK_NPCSDK_LUA_000030 = GetResString("MISSDK_NPCSDK_LUA_000030")
						talkadd = talkadd..MISSDK_NPCSDK_LUA_000030..roleQues[roleName].quesNext..MISSDK_NPCSDK_LUA_000029..QuesLab[curQues][CurNextQues].ques
					else  ---全部问题回答之后的处理
						-- LG("ques","全部问题回答之后处理")
						if QuesLab[curQues].type_quit == 1 then
							-- LG("ques","开始处理计数退出的")
							CALCULATE_FUNCTIONS_LUA_000001 = GetResString("CALCULATE_FUNCTIONS_LUA_000001")
							if QuesLab[curQues].des== CALCULATE_FUNCTIONS_LUA_000001 then 
								talkadd = BaiChi(character,roleAns[roleName],page[param][1].p[1])
							CALCULATE_FUNCTIONS_LUA_000641 = GetResString("CALCULATE_FUNCTIONS_LUA_000641")
							elseif QuesLab[curQues].des== CALCULATE_FUNCTIONS_LUA_000641 then
								talkadd = XiaoXueBiYe(character,roleAns[roleName],page[param][1].p[1])
							CALCULATE_FUNCTIONS_LUA_000664 = GetResString("CALCULATE_FUNCTIONS_LUA_000664")
							elseif QuesLab[curQues].des== CALCULATE_FUNCTIONS_LUA_000664 then
								talkadd = ZhongXueBiYe(character,roleAns[roleName],page[param][1].p[1])
							end
						else
							-- LG("ques","开始处理直接退出的")
							CALCULATE_FUNCTIONS_LUA_000001 = GetResString("CALCULATE_FUNCTIONS_LUA_000001")
							if QuesLab[curQues].des== CALCULATE_FUNCTIONS_LUA_000001 then 
								talkadd = BaiChi(character,roleAns[roleName],page[param][1].p[1]) 
							CALCULATE_FUNCTIONS_LUA_000641 = GetResString("CALCULATE_FUNCTIONS_LUA_000641")
							elseif QuesLab[curQues].des== CALCULATE_FUNCTIONS_LUA_000641 then
								talkadd = XiaoXueBiYe(character,roleAns[roleName],page[param][1].p[1])
							end
						end
						-- LG("ques","对话结束特殊处理为:"..talkadd)
						MISSDK_NPCSDK_LUA_000027 = GetResString("MISSDK_NPCSDK_LUA_000027")
						MISSDK_NPCSDK_LUA_000026 = GetResString("MISSDK_NPCSDK_LUA_000026")
						if talkadd==MISSDK_NPCSDK_LUA_000026 or talkadd==MISSDK_NPCSDK_LUA_000027 then
							MISSDK_NPCSDK_LUA_000019 = GetResString("MISSDK_NPCSDK_LUA_000019")
							MISSDK_NPCSDK_LUA_000020 = GetResString("MISSDK_NPCSDK_LUA_000020")
							talkadd = MISSDK_NPCSDK_LUA_000020..roleAns[ret]..MISSDK_NPCSDK_LUA_000019
						end
					end
					if QuesError == 0 then  ---上一道问题回答错误的处理
						-- LG("ques","回答错误的处理")	
						if QuesLab[curQues].type_quit == 2 then
							MISSDK_NPCSDK_LUA_000031 = GetResString("MISSDK_NPCSDK_LUA_000031")
							talkadd = MISSDK_NPCSDK_LUA_000031
							QuesOtherDeal = 1
							-- LG("ques","需要处理按钮")
						end
					end
				end
				-- LG("ques","对话完毕")
			else 
				talkadd=""
			end
		end
		talk = page[param][1].talk..talkadd
	end

	--提取选择项信息
	local FuncItem = {}
	local count = 0
	PRINT( "JumpPage:page item count = ", page[param].count )
	local funcnum = 8
	if isQues== 0 then
	if page[param].count ~= nil then
		funcnum = page[param].count
	end
		local i = 0 
	for i = 1, funcnum, 1 do
		if page[param][i] == nil then
			break
			end
			if page[param][i].talk == nil then
				count = count + 1
				FuncItem[count] = page[param][i].text
				PRINT( "Jumppage:", FuncItem[count] )
			end
		end
	elseif isQues == 1 then 
		page[param][1].func = nil
		MISSDK_NPCSDK_LUA_000032 = GetResString("MISSDK_NPCSDK_LUA_000032")
		LG("ques",MISSDK_NPCSDK_LUA_000032)
		if roleQues[roleName].quesNext> page[param][1].p[1] then --回答完毕的按钮
			MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
			FuncItem[1] = MISSCRIPT_NPCSCRIPT01_LUA_000005
			page[param].count  = 1
			page[param][2].func =  CheckAns
			roleQues[roleName].out=1
			count = 1
			MISSDK_NPCSDK_LUA_000033 = GetResString("MISSDK_NPCSDK_LUA_000033")
			LG("ques",MISSDK_NPCSDK_LUA_000033)
		else
			if QuesOtherDeal == 0 then
				-- LG("ques","第",roleQues[roleName].quesNext,"次选项")
				local i = 0 
				
				local a = 0 
				for a = 1,5,1 do 
					local b = math.random(2, QuesLab[curQues][CurNextQues].choose.count)
					local temp = QuesLab[curQues][CurNextQues].choose[1]
					QuesLab[curQues][CurNextQues].choose[1]= QuesLab[curQues][CurNextQues].choose[b]
					 QuesLab[curQues][CurNextQues].choose[b] = temp
				end
				for i = 2, QuesLab[curQues][CurNextQues].choose.count+1, 1 do
			count = count + 1
					page[param].count=page[param].count+1
					page[param][i].text = QuesLab[curQues][CurNextQues].choose[i-1]
					page[param][i].func = CheckAns
					-- LG("ques","page[param]["..i.."].func为",page[param][i].func)
					roleQues[roleName].choose[i-1] = QuesLab[curQues][CurNextQues].choose[i-1] 
					LG("ques",i-1,roleQues[roleName].choose[i-1])
					roleQues[roleName].curNextQues = CurNextQues
					FuncItem[count] = page[param][i].text
					PRINT( "JumpPage:", FuncItem[count] )
				end
				-- LG("ques","第",roleQues[roleName].quesNext,"次选项结束")
			else
				if QuesLab[curQues].type_quit == 2  then
					MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
					FuncItem[1] = MISSCRIPT_NPCSCRIPT01_LUA_000005
					page[param].count  = 1
					page[param][2].func =  CheckAns
					roleQues[roleName].out=1
					count = 1
				end
			end
		end
			MISSDK_NPCSDK_LUA_000034 = GetResString("MISSDK_NPCSDK_LUA_000034")
			MISSDK_NPCSDK_LUA_000024 = GetResString("MISSDK_NPCSDK_LUA_000024")
			LG("ques",MISSDK_NPCSDK_LUA_000024,roleName,MISSDK_NPCSDK_LUA_000034)
	end
	PRINT( "JumpPage, ismission = ", page[param].ismission )
	if page[param].ismission == nil or GetNpcHasMission( npc ) ~= LUA_TRUE then
		PRINT( "JumpPage3:SendMissioniPage, pageid, talk, funcitem, count, misitem, misnum", param, talk, FuncItem, count, nil, 0 )
		return SendMissionPage( character, npc, param, talk, FuncItem, count, nil, 0 )
	end

	--提取任务列表信息
	local misnum = 0
	local MisItem = {}
	local ret, NpcInfoID = GetScriptID( npc )
	PRINT( "JumpPage:GetScriptID: ret =  , NpcInfoID = ", ret, NpcInfoID )
	if ret ~= LUA_TRUE or NpcInfoList[NpcInfoID] == nil or NpcInfoList[NpcInfoID].missionlist == nil then
		PRINT( "JumpPage1:SendMissioniPage, pageid, talk, funcitem, count, misitem, misnum", param, talk, FuncItem, count, MisItem, misnum )
		return SendMissionPage( character, npc, param, talk, FuncItem, count, MisItem, misnum )
	end

	local missionlist = NpcInfoList[NpcInfoID].missionlist
	local npcid = GetCharID( npc )
	ret, misnum = GetNumMission( character, npcid )

	--获取任务列表
	PRINT( "JumpPage:misnum = ", misnum )
	for n = 1, misnum, 1 do
		local ret, id, state = GetMissionInfo( character, npcid, n - 1 )
		PRINT( "JumpPage:missionid = %d, state = %d", id, state )
		if missionlist[id] == nil or missionlist[id].name == nil then
			MisItem[n] = {}
			MISSDK_NPCSDK_LUA_000007 = GetResString("MISSDK_NPCSDK_LUA_000007")
			MisItem[n].name = MISSDK_NPCSDK_LUA_000007
			MisItem[n].state = state
			PRINT( "JumpPage:mission name = , state = ", missionlist[id].name, state )
		else
			MisItem[n] = {}
			MisItem[n].name = missionlist[id].name
			MisItem[n].state = state
			PRINT( "JumpPage:mission name = , state = ", missionlist[id].name, state )
		end
	end

	PRINT( "JumpPage2:SendMissioniPage, pageid, talk, funcitem, count, misitem, misnum", param, talk, FuncItem, count, MisItem, misnum )
	return SendMissionPage( character, npc, param, talk, FuncItem, count, MisItem, misnum )
end
XXBYpoint={}
function XiaoXueBiYe(role,num,num1)
	local name = GetChaDefaultName(role)
	XXBYpoint[name] = math.floor(num/num1*100)
	MISSDK_NPCSDK_LUA_000035 = GetResString("MISSDK_NPCSDK_LUA_000035")
	MISSDK_NPCSDK_LUA_000036 = GetResString("MISSDK_NPCSDK_LUA_000036")
	return MISSDK_NPCSDK_LUA_000036..XXBYpoint[name]..MISSDK_NPCSDK_LUA_000035
end
ZXBYpoint={}
function ZhongXueBiYe(role,num,num1)
	local name = GetChaDefaultName(role)
	if num1 == 10 then 
		ZXBYpoint[name] = math.floor(num/num1*80)
	elseif num1 == 15 then 
		ZXBYpoint[name] = math.floor(num/num1*90)
	elseif num1 == 25 then 
		ZXBYpoint[name] = math.floor(num/num1*100)
	else 
		MISSDK_NPCSDK_LUA_000037 = GetResString("MISSDK_NPCSDK_LUA_000037")
		LG("ZhongXueBiYe_err",name,MISSDK_NPCSDK_LUA_000037)
		MISSDK_NPCSDK_LUA_000038 = GetResString("MISSDK_NPCSDK_LUA_000038")
		return MISSDK_NPCSDK_LUA_000038
	end
	MISSDK_NPCSDK_LUA_000035 = GetResString("MISSDK_NPCSDK_LUA_000035")
	MISSDK_NPCSDK_LUA_000036 = GetResString("MISSDK_NPCSDK_LUA_000036")
	return MISSDK_NPCSDK_LUA_000036..ZXBYpoint[name]..MISSDK_NPCSDK_LUA_000035
end
			 
function CheckAns(character, npc,i,page,param)
	-- LG("ques","选项执行动作开始")
	local roleName =  GetChaDefaultName(character)
	if roleQues[roleName].out==1 then 
		return SendClosePage( character, npc )
	end
	local j = 0
	local ques = 0
	for j  = 1, QuesLab.count ,1 do 
		if roleQues[roleName].ques == QuesLab[j ].des then
			ques = j 
			break
		end
	end
	
	if roleAns[roleName]== nil then 
		roleAns[roleName] = 0 
	end 
	local quesi= roleQues[roleName].curNextQues
	local choose = roleQues[roleName].choose[i-1]
	roleAns.error ={}
	roleAns.error[roleName]=0
	MISSDK_NPCSDK_LUA_000039 = GetResString("MISSDK_NPCSDK_LUA_000039")
	LG("ques",MISSDK_NPCSDK_LUA_000039,choose)
	MISSDK_NPCSDK_LUA_000040 = GetResString("MISSDK_NPCSDK_LUA_000040")
	LG("ques",MISSDK_NPCSDK_LUA_000040,QuesLab[ques][quesi].answer)
	if choose == QuesLab[ques][quesi].answer  then 
		roleAns[roleName]= roleAns[roleName]+1
		roleAns.error[roleName] = 0 
		MISSDK_NPCSDK_LUA_000041 = GetResString("MISSDK_NPCSDK_LUA_000041")
		LG("ques",MISSDK_NPCSDK_LUA_000041)
	else
		MISSDK_NPCSDK_LUA_000042 = GetResString("MISSDK_NPCSDK_LUA_000042")
		LG("ques",MISSDK_NPCSDK_LUA_000042)
		roleQues[roleName].errorlist.count = roleQues[roleName].errorlist.count+1
		MISSDK_NPCSDK_LUA_000043 = GetResString("MISSDK_NPCSDK_LUA_000043")
		MISSDK_NPCSDK_LUA_000044 = GetResString("MISSDK_NPCSDK_LUA_000044")
		LG("ques",MISSDK_NPCSDK_LUA_000044..roleQues[roleName].errorlist.count..MISSDK_NPCSDK_LUA_000043)
		roleQues[roleName].errorlist[roleQues[roleName].errorlist.count] = quesi
		MISSDK_NPCSDK_LUA_000045 = GetResString("MISSDK_NPCSDK_LUA_000045")
		LG("ques",MISSDK_NPCSDK_LUA_000045..quesi)
		roleAns.error[roleName] = 1 
	end
	JumpPage(character, npc,page,param)
	-- LG("ques","选项执行动作结束")
	return 1
end
function chooseExample(role,p1,p2)
	local now_month= tonumber(os.date("%m")	)	-------------月
 	local now_day= tonumber(os.date("%d")	)	-------------日
 	local now_hour= tonumber(os.date("%H")	)	-------------时
	local now_miniute= tonumber(os.date("%M"))	-------------分
 	local now_second=  tonumber(os.date("%S"))		-------------秒
	local Notice= ""
	local num = math.random(p1,p2)
	MISSDK_NPCSDK_LUA_000046 = GetResString("MISSDK_NPCSDK_LUA_000046")
	MISSDK_NPCSDK_LUA_000047 = GetResString("MISSDK_NPCSDK_LUA_000047")
	MISSDK_MISSIONSDK_LUA_000463 = GetResString("MISSDK_MISSIONSDK_LUA_000463")
	MISSDK_NPCSDK_LUA_000048 = GetResString("MISSDK_NPCSDK_LUA_000048")
	MISSDK_NPCSDK_LUA_000049 = GetResString("MISSDK_NPCSDK_LUA_000049")
	MISSDK_NPCSDK_LUA_000050 = GetResString("MISSDK_NPCSDK_LUA_000050")
	MISSDK_NPCSDK_LUA_000051 = GetResString("MISSDK_NPCSDK_LUA_000051")
	SystemNotice(role,MISSDK_NPCSDK_LUA_000051..now_month..MISSDK_NPCSDK_LUA_000050..now_day..MISSDK_NPCSDK_LUA_000049..now_hour..MISSDK_NPCSDK_LUA_000048..now_miniute..MISSDK_MISSIONSDK_LUA_000463..now_second..MISSDK_NPCSDK_LUA_000047..p1..","..p2..MISSDK_NPCSDK_LUA_000046..num)
	return num
end
function addExample(role,p1,p2)
	local now_month= tonumber(os.date("%m")	)	-------------月
 	local now_day= tonumber(os.date("%d")	)	-------------日
 	local now_hour= tonumber(os.date("%H")	)	-------------时
	local now_miniute= tonumber(os.date("%M"))	-------------分
 	local now_second=  tonumber(os.date("%S"))		-------------秒
	local Notice= ""
	local num = math.random(p1,p2)
	MISSDK_NPCSDK_LUA_000046 = GetResString("MISSDK_NPCSDK_LUA_000046")
	MISSDK_NPCSDK_LUA_000052 = GetResString("MISSDK_NPCSDK_LUA_000052")
	MISSDK_MISSIONSDK_LUA_000463 = GetResString("MISSDK_MISSIONSDK_LUA_000463")
	MISSDK_NPCSDK_LUA_000048 = GetResString("MISSDK_NPCSDK_LUA_000048")
	MISSDK_NPCSDK_LUA_000049 = GetResString("MISSDK_NPCSDK_LUA_000049")
	MISSDK_NPCSDK_LUA_000050 = GetResString("MISSDK_NPCSDK_LUA_000050")
	MISSDK_NPCSDK_LUA_000051 = GetResString("MISSDK_NPCSDK_LUA_000051")
	Notice = MISSDK_NPCSDK_LUA_000051..now_month..MISSDK_NPCSDK_LUA_000050..now_day..MISSDK_NPCSDK_LUA_000049..now_hour..MISSDK_NPCSDK_LUA_000048..now_miniute..MISSDK_MISSIONSDK_LUA_000463..now_second..MISSDK_NPCSDK_LUA_000052..p1..","..p2..MISSDK_NPCSDK_LUA_000046..num
	return Notice
end
function insertExample(role,p1,p2)
	local now_month= tonumber(os.date("%m")	)	-------------月
 	local now_day= tonumber(os.date("%d")	)	-------------日
 	local now_hour= tonumber(os.date("%H")	)	-------------时
	local now_miniute= tonumber(os.date("%M"))	-------------分
 	local now_second=  tonumber(os.date("%S"))		-------------秒
	local Notice= ""
	local num = math.random(p1,p2)
	MISSDK_NPCSDK_LUA_000046 = GetResString("MISSDK_NPCSDK_LUA_000046")
	MISSDK_NPCSDK_LUA_000053 = GetResString("MISSDK_NPCSDK_LUA_000053")
	MISSDK_MISSIONSDK_LUA_000463 = GetResString("MISSDK_MISSIONSDK_LUA_000463")
	MISSDK_NPCSDK_LUA_000048 = GetResString("MISSDK_NPCSDK_LUA_000048")
	MISSDK_NPCSDK_LUA_000049 = GetResString("MISSDK_NPCSDK_LUA_000049")
	MISSDK_NPCSDK_LUA_000050 = GetResString("MISSDK_NPCSDK_LUA_000050")
	MISSDK_NPCSDK_LUA_000051 = GetResString("MISSDK_NPCSDK_LUA_000051")
	Notice = MISSDK_NPCSDK_LUA_000051..now_month..MISSDK_NPCSDK_LUA_000050..now_day..MISSDK_NPCSDK_LUA_000049..now_hour..MISSDK_NPCSDK_LUA_000048..now_miniute..MISSDK_MISSIONSDK_LUA_000463..now_second..MISSDK_NPCSDK_LUA_000053..p1..","..p2..MISSDK_NPCSDK_LUA_000046..num
	return Notice
end

--发送功能页信息
function FuncPage( character, npc, page, param )
	if page == nil or param == nil or page[param] == nil or page[param][1] == nil then
		MISSDK_NPCSDK_LUA_000054 = GetResString("MISSDK_NPCSDK_LUA_000054")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000054 )
	end

	local FuncItem = {}
	local count = 0
	for i = 1, ROLE_MAXNUM_PAGEITEM, 1 do
		if page[param][i] == nil then
			break
		end
		if page[param][i].talk == nil then
			count = count + 1
			FuncItem[count] = page[param][i].text
		end
	end

	if count == 0 then
		MISSDK_NPCSDK_LUA_000055 = GetResString("MISSDK_NPCSDK_LUA_000055")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000055 )
	else
		return SendFuncPage( character, npc, param, FuncItem, count )
	end
end

--关闭本次对话
function CloseTalk( character, npc )
	return SendClosePage( character, npc )
end

--移动到制定地图坐标
function GoTo( character, xpos, ypos, mapname )
	if xpos == nil or ypos == nil or mapname == nil then
		MISSDK_NPCSDK_LUA_000056 = GetResString("MISSDK_NPCSDK_LUA_000056")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000056 )
	end
	return MoveTo( character,  xpos, ypos,  mapname )
end

--随机跳转地图
function RandToMap( character, npc, maplist, count )
	SendClosePage( character, npc )

	if maplist == nil or count == nil then
		MISSDK_NPCSDK_LUA_000057 = GetResString("MISSDK_NPCSDK_LUA_000057")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000057 )
	end

	local id = Rand( count )
	id = id + 1
	if maplist[id] == nil or maplist[id].xpos == nil or maplist[id].ypos == nil or maplist[id].mapname == nil then
		MISSDK_NPCSDK_LUA_000058 = GetResString("MISSDK_NPCSDK_LUA_000058")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000058 )
	end

	GoTo( character, maplist[id].xpos, maplist[id].ypos, maplist[id].mapname )
end

--随机检测是否已到达地图
function IsRandInMap( character, npc, rate, mapname, x, y, w, h )
	if rate == nil or mapname == nil or x == nil or y == nil then
		MISSDK_NPCSDK_LUA_000059 = GetResString("MISSDK_NPCSDK_LUA_000059")
		PRINT( MISSDK_NPCSDK_LUA_000059 )
		MISSDK_NPCSDK_LUA_000060 = GetResString("MISSDK_NPCSDK_LUA_000060")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000060, rate, mapname, x, y )
		return LUA_ERROR
	end
	if rate > Rand( 100 ) then
		return LUA_FALSE
	end

	return IsInMap( character, mapname, x, y, w, h )
end

function PopupWindow( character, npc, page, trigger, p2 )
	if trigger == nil or p2 == nil then
		MISSDK_NPCSDK_LUA_000061 = GetResString("MISSDK_NPCSDK_LUA_000061")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000061 )
	end
	
	trigger( character, npc, p2 )
end

--多个触发器功能执行
function MultiTrigger( character, npc, page, trigger, count )
	PRINT( "MultiTrigger" )
	if trigger == nil or count == nil then
		MISSDK_NPCSDK_LUA_000062 = GetResString("MISSDK_NPCSDK_LUA_000062")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000062 )
	end

	for n = 1, count, 1 do
		if trigger[n] == nil then
			break
		end
		PRINT( "MultiTrigger:ConditionsTest, n = "..n )
		local ret = ConditionsTest( character, trigger[n].conditions, nil, nil, npc )
		if ret == LUA_TRUE then
			PRINT( "MultiTrigger:success, ActionsProc, n = "..n )
			if trigger[n].actions ~= nil and trigger[n].actions.count ~= 0 then
				return ActionsProc( character, trigger[n].actions, npc, page )
			end
		else
			PRINT( "MultiTrigger:failure, ActionsProc, n = "..n )
			if trigger[n].failures ~= nil and trigger[n].failures.count ~= 0 then
				return ActionsProc( character, trigger[n].failures, npc, page )
			end
		end
	end
end
--新触发器0
function MultiTrigger_0( character, npc, page, trigger, count )
	MultiTrigger( character, npc, page, trigger, count )
	Eleven_Log_0( character )
end
--新触发器1
function MultiTrigger_1( character, npc, page, trigger, count )
	MultiTrigger( character, npc, page, trigger, count )
	Eleven_Log( character,1 )
end
--新触发器2
function MultiTrigger_2( character, npc, page, trigger, count )
	MultiTrigger( character, npc, page, trigger, count )
	Eleven_Log( character,2 )
end
--新触发器3
function MultiTrigger_3( character, npc, page, trigger, count )
	MultiTrigger( character, npc, page, trigger, count )
	Eleven_Log( character,3 )
end
--多个条件判断
function MultiConditions( character, npc, funclist, count )
	if funclist == nil or count == nil then
		MISSDK_NPCSDK_LUA_000063 = GetResString("MISSDK_NPCSDK_LUA_000063")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000063 )
	end

	return ConditionsTest( character, funclist )
end

--多个函数功能
function MultiFunc( character, npc, page, funclist, count )
	if funclist == nil or count == nil then
		MISSDK_NPCSDK_LUA_000064 = GetResString("MISSDK_NPCSDK_LUA_000064")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000064 )
	end

	for id = 1, count, 1 do
		PRINT( "MultiFunc n = "..id )
		if funclist[id].func == AddMoney then
			AddMoney( character, funclist[id].p1 )
		elseif funclist[id].func == AddExp then
			AddExp( character, funclist[id].p1, funclist[id].p2 )
		elseif funclist[id].func == GiveItem then
			Giveitem( character, funclist[id].p1, funclist[id].p2, funclist[id].p3 )
		elseif funclist[id].func == TakeItem then
			TakeItem( character, funclist[id].p1, funclist[id].p2 )
		elseif funclist[id].func == TakeMoney then
			TakeMoney( character, funclist[id].p1, funclist[id].p2 )
		elseif funclist[id].func == JumpPage then
			JumpPage( character, npc, page, funclist[id].p1 )
		elseif funclist[id].func == RandToMap then
			RandToMap( character, npc, funclist[id].p1, funclist[id].p2 )
		elseif funclist[id].func == GoTo then
			GoTo( character, funclist[id].p1, funclist[id].p2, funclist[id].p3 )
		elseif funclist[id].func == GoToDream then
			GoToDream( character, funclist[id].p1)
		elseif funclist[id].func == SetRecord then
			SetRecord( character, funclist[id].p1 )
		elseif funclist[id].func == SetFlag then
			SetFlag( character, funclist[id].p1, funclist[id].p2 )
		elseif funclist[id].func == CloseTalk then
			CloseTalk( character, npc )
		elseif funclist[id].func == RefreshMissionState then
			RefreshMissionState( character, npc )
		elseif funclist[id].func == CheckChaItem then
			CheckChaItem( character )
		elseif funclist[id].func == OpenBank then
			OpenBank( character, npc )
		elseif funclist[id].func == OpenHair then
			OpenHair( character, npc )
		elseif funclist[id].func == CreditExchange then
			CreditExchange( character, npc, funclist[id].p1 )
		elseif funclist[id].func == goto_mj1_time then
			goto_mj1_time( character)
		elseif funclist[id].func == goto_mj2_time then
			goto_mj2_time( character)
		elseif funclist[id].func == mj3sjc then
			mj3sjc( character)
		elseif funclist[id].func == ShuangBei_Time then
			ShuangBei_Time( character, funclist[id].p1 , funclist[id].p2 )
		elseif funclist[id].func == GiveItem_SetAttr then
			GiveItem_SetAttr( character, funclist[id].p1, funclist[id].p2 , funclist[id].p3 , funclist[id].p4 , funclist[id].p5 ,funclist[id].p6  )
		elseif funclist[id].func == ShuangBei_ChunChu then
			ShuangBei_ChunChu( character )
		elseif funclist[id].func == Give_Box then
			Give_Box( character)
		elseif funclist[id].func == ShuangBei_TimeChaxun then
			ShuangBei_TimeChaxun( character)
		elseif funclist[id].func == ZhanBu then
			ZhanBu( character,funclist[id].p1)
		elseif funclist[id].func == Judge_Mission_Times then
			Judge_Mission_Times( character)
		elseif funclist[id].func == Starteffect then		--Starteffect
			Starteffect( character,npc, funclist[i].p1)
		elseif funclist[id].func == JZcheck1 then
			JZcheck1( character)
		-------------------------------------圣诞----------------------------------------------	
	
		elseif funclist[id].func == GiveSDSMLW then
			GiveSDSMLW( character)
			
		-----------------------------------------------------------------------------------
		elseif funclist[id].func == JZcheck2 then
			JZcheck2( character)	
		elseif funclist[id].func == JZcheck3 then
			JZcheck3( character )
		elseif funclist[id].func == JZcheck4 then
			JZcheck4( character )
		elseif funclist[id].func == JZAction1 then
			JZAction1( character )
		elseif funclist[id].func == JZAction2 then
			JZAction2( character )
		elseif funclist[id].func == JZAction3 then
			JZAction3( character )
		elseif funclist[id].func == JZAction4 then
			JZAction4( character )
		elseif funclist[id].func == XZKcheck then               ----星座卡检查--
			XZKcheck( character )
		elseif funclist[id].func == BBXLcheck then              
			BBXLcheck( character )
		elseif funclist[id].func == BBXLChangeColor then              
			BBXLChangeColor( character )
		elseif funclist[id].func == BBXLChangeName then               
			BBXLChangeName( character )
		elseif funclist[id].func == yanhuaGive then               
			yanhuaGive( character )
			MISSDK_NPCSDK_LUA_000065 = GetResString("MISSDK_NPCSDK_LUA_000065")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000065 )

		end
	end

end

--随机功能
function RandFunction( character, npc, page, funclist, count )
	if funclist == nil or count == nil then
		MISSDK_NPCSDK_LUA_000066 = GetResString("MISSDK_NPCSDK_LUA_000066")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000066 )
	end

	local id = Rand( count )
	id = id + 1
	if funclist[id] == nil or funclist[id].func == nil then
		MISSDK_NPCSDK_LUA_000067 = GetResString("MISSDK_NPCSDK_LUA_000067")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000067 )
	end

	if funclist[id].func == JumpPage then
		return JumpPage( character, npc, page, funclist[id].p1 )
	elseif funclist[id].func == RandToMap then
		return RandToMap( character, npc, funclist[id].p1, funclist[id].p2 )
	elseif funclist[id].func == GoTo then
		SendClosePage( character, npc )
		return GoTo( character, funclist[id].p1, funclist[id].p2, funclist[id].p3 )
	elseif funclist[id].func == GiveItem then
		PRINT( "RandFunction:GiveItem, p1, p2, p3",  funclist[id].p1, funclist[id].p2, funclist[id].p3 )
		return GiveItem( character, npc, funclist[id].p1, funclist[id].p2, funclist[id].p3 )
	elseif funclist[id].func == MultiFunc then
		PRINT( "RandFunction:MultiFunc, p1, p2 ", funclist[id].p1, funclist[id].p2 )
		return MultiFunc( character, npc, page, funclist[id].p1, funclist[id].p2 )
	else
		MISSDK_NPCSDK_LUA_000068 = GetResString("MISSDK_NPCSDK_LUA_000068")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000068 )
	end

end

--交易
function SendTradePage( character, npc, cmd, trade, tradetype, p1 )
	if cmd == nil or trade == nil or tradetype == nil then
		MISSDK_NPCSDK_LUA_000069 = GetResString("MISSDK_NPCSDK_LUA_000069")
		return SystemNotic( character, MISSDK_NPCSDK_LUA_000069 )
	end

	PRINT( "SendTradePage: send start. tradetype = ", tradetype )
	local packet = GetPacket()
	WriteCmd( packet, cmd )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	WriteByte( packet, tradetype )
	WriteDword( packet, p1 )

	local typecount = 0
	for i = 1, 4, 1 do
		if trade[i] ~= nil then
			typecount = typecount + 1
		else
			break
		end
	end
	WriteByte( packet, typecount )
	PRINT( "SendTradePage: typecount = ", typecount )

	for i = 1, typecount, 1 do
		if trade[i].itemtype ~= nil and trade[i].count ~= nil and trade[i].item ~= nil then
			if trade[i].count > 120 then
				trade[i].count = 120
			end
			PRINT( "SendTradePage: itemtype = ,  count = ", trade[i].itemtype, trade[i].count )
			WriteByte( packet, trade[i].itemtype )
			WriteByte( packet, trade[i].count )
			--写入物品ID数据
			for n = 1, trade[i].count, 1 do
				if trade[i].item[n] ~= nil then
					if tradetype == TRADE_GOODS then
						PRINT( "SendTradePage:writedword : id =, count =, price =, tradetp ", trade[i].item[n].id, trade[i].item[n].count, trade[i].price[n].curprice, tradetype )
						WriteWord( packet, trade[i].item[n].id )
						WriteWord( packet, trade[i].item[n].count )
						WriteDword( packet, trade[i].price[n].curprice )
						WriteByte( packet, trade[i].item[n].level )
					else
						WriteWord( packet, trade[i].item[n] )
					end
				else
					WriteWord( packet, ROLE_INVALID_ID )
					if tradetype == TRADE_GOODS then
						WriteDword( packet, 0 )
					end
				end
			end
		else
			MISSDK_NPCSDK_LUA_000070 = GetResString("MISSDK_NPCSDK_LUA_000070")
			EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000070, GetCharName( npc ) )
			MISSDK_NPCSDK_LUA_000071 = GetResString("MISSDK_NPCSDK_LUA_000071")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000071 )
		end
	end

	PRINT( "SendTradePage: SendPacket" )
	SendPacket( character, packet )
end

--更新交易
function SendTradeUpdate( character, npc, trade, tradetype, p1 )
	if trade == nil or tradetype == nil then
		MISSDK_NPCSDK_LUA_000072 = GetResString("MISSDK_NPCSDK_LUA_000072")
		return SystemNotic( character, MISSDK_NPCSDK_LUA_000072 )
	end

	PRINT( "SendTradeUpdate: send start. tradetype = ", tradetype )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_BLACKMARKET_TRADEUPDATE )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	WriteByte( packet, tradetype )
	WriteDword( packet, p1 )

	local typecount = 0
	for i = 1, 4, 1 do
		if trade[i] ~= nil then
			typecount = typecount + 1
		else
			break
		end
	end
	WriteByte( packet, typecount )
	PRINT( "SendTradeUpdate: typecount = ", typecount )

	for i = 1, typecount, 1 do
		if trade[i].itemtype ~= nil and trade[i].count ~= nil and trade[i].item ~= nil then
			if trade[i].count > 120 then
				trade[i].count = 120
			end
			PRINT( "SendTradeUpdate: itemtype = ,  count = ", trade[i].itemtype, trade[i].count )
			WriteByte( packet, trade[i].itemtype )
			WriteByte( packet, trade[i].count )
			--写入物品ID数据
			for n = 1, trade[i].count, 1 do
				if trade[i].item[n] ~= nil then
					if tradetype == TRADE_GOODS then
						PRINT( "SendTradeUpdate:writedword : id =, count =, price =, tradetp ", trade[i].item[n].id, trade[i].item[n].count, trade[i].price[n].curprice, tradetype )
						WriteWord( packet, trade[i].item[n].id )
						WriteWord( packet, trade[i].item[n].count )
						WriteDword( packet, trade[i].price[n].curprice )
						WriteByte( packet, trade[i].item[n].level )
					else
						WriteWord( packet, trade[i].item[n] )
					end
				else
					WriteWord( packet, ROLE_INVALID_ID )
					if tradetype == TRADE_GOODS then
						WriteDword( packet, 0 )
					end
				end
			end
		else
			MISSDK_NPCSDK_LUA_000070 = GetResString("MISSDK_NPCSDK_LUA_000070")
			EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000070, GetCharName( npc ) )
			MISSDK_NPCSDK_LUA_000071 = GetResString("MISSDK_NPCSDK_LUA_000071")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000071 )
		end
	end

	PRINT( "SendTradeUpdate: SendPacket" )
	SynPacket( npc, packet )
end

--交易
function SendUpdateTradePage( character, npc, cmd, trade, tradetype, p1 )
	if cmd == nil or trade == nil or tradetype == nil then
		MISSDK_NPCSDK_LUA_000073 = GetResString("MISSDK_NPCSDK_LUA_000073")
		return SystemNotic( character, MISSDK_NPCSDK_LUA_000073 )
	end

	PRINT( "SendUpdateTradePage: send start. tradetype = ", tradetype )
	local packet = GetPacket()
	WriteCmd( packet, cmd )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	WriteByte( packet, tradetype )
	WriteDword( packet, p1 )

	local typecount = 0
	for i = 1, 4, 1 do
		if trade[i] ~= nil then
			typecount = typecount + 1
		else
			break
		end
	end
	WriteByte( packet, typecount )
	PRINT( "SendUpdateTradePage: typecount = ", typecount )

	for i = 1, typecount, 1 do
		if trade[i].itemtype ~= nil and trade[i].count ~= nil and trade[i].item ~= nil then
			if trade[i].count > 120 then
				trade[i].count = 120
			end
			PRINT( "SendUpdateTradePage: itemtype = ,  count = ", trade[i].itemtype, trade[i].count )
			WriteByte( packet, trade[i].itemtype )
			WriteByte( packet, trade[i].count )
			--写入物品ID数据
			for n = 1, trade[i].count, 1 do
				if trade[i].item[n] ~= nil then
					if tradetype == TRADE_GOODS then
						PRINT( "SendUpdateTradePage:writedword : id =, count =, price =, tradetp ", trade[i].item[n].id, trade[i].item[n].count, trade[i].price[n].curprice, tradetype )
						WriteWord( packet, trade[i].item[n].id )
						WriteWord( packet, trade[i].item[n].count )
						WriteDword( packet, trade[i].price[n].curprice )
						WriteByte( packet, trade[i].item[n].level )
					else
						WriteWord( packet, trade[i].item[n] )
					end
				else
					WriteWord( packet, ROLE_INVALID_ID )
					if tradetype == TRADE_GOODS then
						WriteWord( packet, 0 )
						WriteDword( packet, 0 )
						WriteByte( packet, 0 )
					end
				end
			end
		else
			MISSDK_NPCSDK_LUA_000074 = GetResString("MISSDK_NPCSDK_LUA_000074")
			EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000074, GetCharName( npc ) )
			MISSDK_NPCSDK_LUA_000075 = GetResString("MISSDK_NPCSDK_LUA_000075")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000075 )
		end
	end

	PRINT( "SendUpdateTradePage: SendPacket" )
	SynPacket( character, packet )
end

function TradePage( character, npc, trade, tradetype, p1 )
	PRINT( "TradePage" )
	SendTradePage( character, npc, CMD_MC_TRADEPAGE, trade, tradetype, p1 )
end

--出售命令函数
function SalePage( character, npc, trade )
	PRINT( "Send sale page info!" )
	TradePage( character, npc, trade, TRADE_SALE, 0 )
end

--购买命令函数
function BuyPage( character, npc, trade )
	PRINT( "Send buy page info!" )
	TradePage( character, npc, trade, TRADE_BUY, 0 )
end

--播放特效
function PlayEffect( npc, id )
	PRINT( "PlayEffect" )
	ChaPlayEffect( npc, id )
end

--交易船舱货物
function TradeGoods( character, npc, trade, index )
	PRINT( "Send TradeGoods page info, trade, index", trade, index )
	local ret, boatid = GetBoatID( character, index )
	if ret ~= LUA_TRUE then
		MISSDK_NPCSDK_LUA_000076 = GetResString("MISSDK_NPCSDK_LUA_000076")
		PRINT( MISSDK_NPCSDK_LUA_000076..index )
		MISSDK_NPCSDK_LUA_000076 = GetResString("MISSDK_NPCSDK_LUA_000076")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000076..index )
		return
	end
	PRINT( "tradepage" )
	TradePage( character, npc, trade, TRADE_GOODS, boatid )
end

--角色交易停泊列表
function TradeBerthList( character, npc, berth )
	MISSDK_NPCSDK_LUA_000077 = GetResString("MISSDK_NPCSDK_LUA_000077")
	PRINT( MISSDK_NPCSDK_LUA_000077 )
	local npcid = GetCharID( npc )
	return BoatBerthList( character, npcid, BERTH_TRADE_LIST, berth, 0, 0, 0 )
end

--角色船只停泊列表
function LuanchBerthList( character, npc, berth, xpos, ypos, dir )
	MISSDK_NPCSDK_LUA_000078 = GetResString("MISSDK_NPCSDK_LUA_000078")
	PRINT( MISSDK_NPCSDK_LUA_000078 )
	local npcid = GetCharID( npc )
	--local ret1 = RemoveYS( character )
	--if ret1 ~= 1 then
	--	PRINT( "LuanchBerthList:RemoveYS 失败！" )
	--	SystemNotice( character, "LuanchBerthList:RemoveYS 失败！" )
	--	return --LUA_FALSE
	--end
	local ret = HasMission(character,1986)
	if ret == 1	then 
	local name = GetChaDefaultName(character)
		CheckShipExp[name]=1
	end
	return BoatBerthList( character, npcid, BERTH_LUANCH_LIST, berth, xpos, ypos, dir )
end

--修理船只列表
function RepairBerthList( character, npc, berth )
	MISSDK_NPCSDK_LUA_000079 = GetResString("MISSDK_NPCSDK_LUA_000079")
	PRINT( MISSDK_NPCSDK_LUA_000079 )
	local npcid = GetCharID( npc )
	return BoatBerthList( character, npcid, BERTH_REPAIR_LIST, berth, 0, 0, 0 )
end

--打捞船只列表
function SalvageBerthList( character, npc, berth )
	MISSDK_NPCSDK_LUA_000080 = GetResString("MISSDK_NPCSDK_LUA_000080")
	PRINT( MISSDK_NPCSDK_LUA_000080 )
	local npcid = GetCharID( npc )
	return BoatBerthList( character, npcid, BERTH_SALVAGE_LIST, berth, 0, 0, 0 )
end
ComplBoatSupply={}
ComplBoatLevel={}
--补给船只列表
function SupplyBerthList( character, npc, berth )
	local ret = HasMission(character,1965)
	if ret == 1	then 
		local name = GetChaDefaultName(character)
		ComplBoatSupply[name]=1
	end
	MISSDK_NPCSDK_LUA_000081 = GetResString("MISSDK_NPCSDK_LUA_000081")
	PRINT( MISSDK_NPCSDK_LUA_000081 )
	local npcid = GetCharID( npc )
	return BoatBerthList( character, npcid, BERTH_SUPPLY_LIST, berth, 0, 0, 0 )
end

--船只升级列表
function BoatLevelBerthList( character, npc, berth )
	local ret = HasMission(character,1964)
	if ret == 1	then 
		local name = GetChaDefaultName(character)
		ComplBoatLevel[name]=1
	end
	MISSDK_NPCSDK_LUA_000082 = GetResString("MISSDK_NPCSDK_LUA_000082")
	PRINT( MISSDK_NPCSDK_LUA_000082 )
	local npcid = GetCharID( npc )
	return BoatBerthList( character, npcid, BERTH_BOATLEVEL_LIST, berth, 0, 0, 0 )
end

--出售物品
function Sale( character, npc, index, count )
	PRINT( "Sale" )
	if index == nil or count == nil then
		MISSDK_NPCSDK_LUA_000083 = GetResString("MISSDK_NPCSDK_LUA_000083")
		PRINT( MISSDK_NPCSDK_LUA_000083 )
		MISSDK_NPCSDK_LUA_000083 = GetResString("MISSDK_NPCSDK_LUA_000083")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000083 )
		return LUA_FALSE
	end

	SafeSale( character, index, count )
	return LUA_TRUE
end

--购买物品
function Buy( character, npc, trade, itemtype, index1, index2, count )
	PRINT( "Buy" )
	itemtype = itemtype + 1
	index1 = index1 + 1
	if trade[itemtype] == nil or trade[itemtype].item == nil or trade[itemtype].item[index1] == nil then
		--信息错误
		MISSDK_NPCSDK_LUA_000084 = GetResString("MISSDK_NPCSDK_LUA_000084")
		PRINT( MISSDK_NPCSDK_LUA_000084 )
		MISSDK_NPCSDK_LUA_000084 = GetResString("MISSDK_NPCSDK_LUA_000084")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000084 )
		return LUA_FALSE
	end
	local itemid = trade[itemtype].item[index1]
	SafeBuy( character, itemid, index2, count )
	return LUA_TRUE
end

--出售货物
function SaleGoods( character, npc, trade, boatid, index, count )
	PRINT( "SaleGoods" )
	if boatid == nil or index == nil or count == nil or trade == nil then
		MISSDK_NPCSDK_LUA_000085 = GetResString("MISSDK_NPCSDK_LUA_000085")
		PRINT( MISSDK_NPCSDK_LUA_000085 )
		MISSDK_NPCSDK_LUA_000085 = GetResString("MISSDK_NPCSDK_LUA_000085")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000085 )
		return LUA_FALSE
	end
	
	local ret = BoatTrade( character, trade.berth )
	if ret ~= LUA_TRUE then
		return LUA_FALSE
	end
	
	local ret, itemid = GetSaleGoodsItem( character, boatid, index )
	if ret ~= LUA_TRUE then
		MISSDK_NPCSDK_LUA_000086 = GetResString("MISSDK_NPCSDK_LUA_000086")
		PRINT( MISSDK_NPCSDK_LUA_000086..index )
		MISSDK_NPCSDK_LUA_000086 = GetResString("MISSDK_NPCSDK_LUA_000086")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000086..index )
		return LUA_FALSE
	end
	PRINT( "SaleGoods: boatid = , index = , itemid = ", boatid, index, itemid )
	--校验是否npc收购该物品
	local price = 0
	for n = 1, trade[2].count, 1 do
		if trade[2].item[n].id == itemid then
			price = trade[2].price[n].curprice
			break
		end
	end
	PRINT( "SaleGoods: boatid = , index = , itemid = , count =, price = ", boatid, index, itemid, count, price )

	local ret, level, cess = GetTradeItemData( character )
	if ret ~= LUA_TRUE then
		cess = 1
	end
	PRINT( "SaleGoods:GetTradeItemData: level = , cess = ", level, cess )

	PRINT( "SaleGoods:3-1, cess, price = ", cess, price )
	if cess == 0 then
		cess = 1
	end
	local param = (math.max ( 0, 30-math.pow(cess,0.5) )+math.pow(cess , (-0.5) ) ) /100
	local cessdata = math.floor( price*param + 0.5 )
	PRINT( "SaleGoods:3-1, cessdata, price = ", cessdata, price )
	local cessprice = price - cessdata
	PRINT( "SaleGoods:3, cessprice = ", cessprice )

	local ret = SafeSaleGoods( character, boatid, index, count, cessprice )
	if ret ~= LUA_TRUE then
		MISSDK_NPCSDK_LUA_000087 = GetResString("MISSDK_NPCSDK_LUA_000087")
		PRINT( MISSDK_NPCSDK_LUA_000087, boatid, index, count, price )
		MISSDK_NPCSDK_LUA_000088 = GetResString("MISSDK_NPCSDK_LUA_000088")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000088 )
		MISSDK_NPCSDK_LUA_000087 = GetResString("MISSDK_NPCSDK_LUA_000087")
		LG( "trade_error", MISSDK_NPCSDK_LUA_000087, boatid, index, count, price )
		return LUA_FALSE
	end
	local allcessdata = cessdata*count
	MISSDK_NPCSDK_LUA_000089 = GetResString("MISSDK_NPCSDK_LUA_000089")
	MISSDK_NPCSDK_LUA_000090 = GetResString("MISSDK_NPCSDK_LUA_000090")
	MISSDK_NPCSDK_LUA_000091 = GetResString("MISSDK_NPCSDK_LUA_000091")
	SystemNotice( character, MISSDK_NPCSDK_LUA_000091..allcessdata..MISSDK_NPCSDK_LUA_000090..cessdata..MISSDK_NPCSDK_LUA_000089 )

	return LUA_TRUE
end

--购买货物
function BuyGoods( character, npc, trade, boatid, itemtype, index1, index2, count )
	PRINT( "BuyGoods" )
	itemtype = itemtype + 1
	index1 = index1 + 1
	if boatid == nil or trade[itemtype] == nil or trade[itemtype].item == nil or trade[itemtype].item[index1] == nil or trade[itemtype].price[index1] == nil then
		--信息错误
		MISSDK_NPCSDK_LUA_000092 = GetResString("MISSDK_NPCSDK_LUA_000092")
		PRINT( MISSDK_NPCSDK_LUA_000092 )
		MISSDK_NPCSDK_LUA_000092 = GetResString("MISSDK_NPCSDK_LUA_000092")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000092 )
		return LUA_FALSE
	end

	local ret = BoatTrade( character, trade.berth )
	if ret ~= LUA_TRUE then
		return LUA_FALSE
	end
	
	if trade[itemtype].item[index1].count <= 0 then
		MISSDK_NPCSDK_LUA_000093 = GetResString("MISSDK_NPCSDK_LUA_000093")
		BickerNotice( character, MISSDK_NPCSDK_LUA_000093 )
		return LUA_TRUE
	end
	PRINT( "BuyGoods:1" )

	if trade[itemtype].item[index1].level > 0 then
		local ret, level, cess = GetTradeItemData( character )
		if ret ~= LUA_TRUE then
			MISSDK_NPCSDK_LUA_000094 = GetResString("MISSDK_NPCSDK_LUA_000094")
			SystemNotice( character, MISSDK_NPCSDK_LUA_000094 )
			MISSDK_NPCSDK_LUA_000094 = GetResString("MISSDK_NPCSDK_LUA_000094")
			LG( "trade_error", MISSDK_NPCSDK_LUA_000094 )
			return LUA_FALSE
		end
		PRINT( "BuyGoods:GetTradeItemData: level = , cess = ", level, cess )
		if level < trade[itemtype].item[index1].level then
			MISSDK_NPCSDK_LUA_000095 = GetResString("MISSDK_NPCSDK_LUA_000095")
			MISSDK_NPCSDK_LUA_000096 = GetResString("MISSDK_NPCSDK_LUA_000096")
			BickerNotice( character, MISSDK_NPCSDK_LUA_000096..trade[itemtype].item[index1].level..MISSDK_NPCSDK_LUA_000095 )
			return LUA_FALSE
		end
	end

	PRINT( "BuyGoods:2" )
	--检查数量是否足够
	if trade[itemtype].item[index1].count < count then
		count = trade[itemtype].item[index1].count
	end

	local itemid = trade[itemtype].item[index1].id
	local price = trade[itemtype].price[index1].curprice
	local ret = SafeBuyGoods( character, boatid,  itemid, index2, count, price )
	if ret == LUA_TRUE then
		trade[itemtype].item[index1].count = trade[itemtype].item[index1].count - count
		PRINT( "BuyGoods:index, id, count, price", index1, itemid, trade[itemtype].item[index1].count, price )
		SendGoodsData( npc, index1 - 1, itemid, trade[itemtype].item[index1].count, price )
	end
	PRINT( "BuyGoods:4, price = ", price )
	return LUA_TRUE
end

--货物信息同步
function SendGoodsData( npc, index, id, count, price )
	if npc == nil or index == nil or id == nil or count == nil or price == nil then
		MISSDK_NPCSDK_LUA_000097 = GetResString("MISSDK_NPCSDK_LUA_000097")
		PRINT( MISSDK_NPCSDK_LUA_000097, npc, index, id, count, price )
		MISSDK_NPCSDK_LUA_000097 = GetResString("MISSDK_NPCSDK_LUA_000097")
		LG( "npctrade_error", MISSDK_NPCSDK_LUA_000097, npc, index, id, count, price  )
		return
	end

	PRINT( "SendGoodsData: npc, index, id, count, price", npc, index, id, count, price )
	local packet = GetPacket()
	WriteCmd( packet, CMD_MC_TRADE_DATA )
	local npcid = GetCharID( npc )
	WriteDword( packet, npcid )
	WriteByte( packet, 0 ) --第一页为销售物品页信息
	WriteByte( packet, index )
	WriteWord( packet, id )
	WriteWord( packet, count )
	WriteDword( packet, price )

	SynPacket( npc, packet )
	return LUA_TRUE
end

function SendAllGoodsData( npc, trade )
	if trade == nil or npc == nil then
		MISSDK_NPCSDK_LUA_000098 = GetResString("MISSDK_NPCSDK_LUA_000098")
		PRINT( MISSDK_NPCSDK_LUA_000098 )
		return LUA_ERROR
	end

	PRINT( "SendAllGoodsData:" )
	SendUpdateTradePage( npc, npc, CMD_MC_TRADE_ALLDATA, trade, TRADE_GOODS, 0 )
	return LUA_TRUE
end

--货物打包到船舱
function PackBagGoods( character, boat, tp, level )
	PRINT( "PackBagGoods: character, boat, tp, level ", character, boat, tp, level )
	if character == nil or boat == nil or level == nil or tp == nil then
		MISSDK_NPCSDK_LUA_000099 = GetResString("MISSDK_NPCSDK_LUA_000099")
		PRINT( MISSDK_NPCSDK_LUA_000099, character, boat, tp, level )
		MISSDK_NPCSDK_LUA_000099 = GetResString("MISSDK_NPCSDK_LUA_000099")
		LG( "goods_error", MISSDK_NPCSDK_LUA_000099, character, boat, tp, level )
		return LUA_FALSE
	end

	--打包各种等级资源类型
	if tp == RES_WOOD	then			-- 木材资源
		if ResourceList == nil or ResourceList.wood == nil or ResourceList.wood[level] == nil then
			MISSDK_NPCSDK_LUA_000100 = GetResString("MISSDK_NPCSDK_LUA_000100")
			PRINT( MISSDK_NPCSDK_LUA_000100 )
			return LUA_FALSE
		end
		PRINT( "PackBagGoods: 1" )
		if ResourceList.wood[level].itemid == nil or ResourceList.wood[level].count == nil or ResourceList.wood[level].pileid == nil then
			MISSDK_NPCSDK_LUA_000101 = GetResString("MISSDK_NPCSDK_LUA_000101")
			PRINT( MISSDK_NPCSDK_LUA_000101, level, ResourceList.wood[level].itemid, ResourceList.wood[level].count, ResourceList.wood[level].pileid )
			MISSDK_NPCSDK_LUA_000101 = GetResString("MISSDK_NPCSDK_LUA_000101")
			LG( "goods_error", MISSDK_NPCSDK_LUA_000101, ResourceList.wood[level].itemid, ResourceList.wood[level].count, ResourceList.wood[level].pileid )
			return LUA_FALSE
		end

		PRINT( "PackBagGoods: PackBag:RES_WOOD: itemid = , count = , pileid = ", ResourceList.wood[level].itemid, ResourceList.wood[level].count, ResourceList.wood[level].pileid )
		local ret, numpack = PackBag( character, boat, ResourceList.wood[level].itemid, ResourceList.wood[level].count, ResourceList.wood[level].pileid )
		if ret ~= LUA_TRUE then
			MISSDK_NPCSDK_LUA_000102 = GetResString("MISSDK_NPCSDK_LUA_000102")
			PRINT( MISSDK_NPCSDK_LUA_000102, level, ResourceList.wood[level].itemid, ResourceList.wood[level].count, ResourceList.wood[level].pileid )
			return LUA_FALSE
		end
		MISSDK_NPCSDK_LUA_000103 = GetResString("MISSDK_NPCSDK_LUA_000103")
		MISSDK_NPCSDK_LUA_000104 = GetResString("MISSDK_NPCSDK_LUA_000104")
		MISSDK_NPCSDK_LUA_000105 = GetResString("MISSDK_NPCSDK_LUA_000105")
		PRINT( MISSDK_NPCSDK_LUA_000105..numpack..MISSDK_NPCSDK_LUA_000104..level..MISSDK_NPCSDK_LUA_000103 )
		if numpack > 0 then
			MISSDK_NPCSDK_LUA_000103 = GetResString("MISSDK_NPCSDK_LUA_000103")
			MISSDK_NPCSDK_LUA_000104 = GetResString("MISSDK_NPCSDK_LUA_000104")
			MISSDK_NPCSDK_LUA_000105 = GetResString("MISSDK_NPCSDK_LUA_000105")
			BickerNotice( character, MISSDK_NPCSDK_LUA_000105..numpack..MISSDK_NPCSDK_LUA_000104..level..MISSDK_NPCSDK_LUA_000103 )
		end
	elseif tp == RES_MINE	then		-- 矿石资源
		if ResourceList.mine[level].itemid == nil or ResourceList.mine[level].count == nil or ResourceList.mine[level].pileid == nil then
			MISSDK_NPCSDK_LUA_000106 = GetResString("MISSDK_NPCSDK_LUA_000106")
			PRINT( MISSDK_NPCSDK_LUA_000106, ResourceList.mine[level].itemid, ResourceList.mine[level].count, ResourceList.mine[level].pileid )
			MISSDK_NPCSDK_LUA_000106 = GetResString("MISSDK_NPCSDK_LUA_000106")
			LG( "goods_error", MISSDK_NPCSDK_LUA_000106, ResourceList.mine[level].itemid, ResourceList.mine[level].count, ResourceList.mine[level].pileid )
			return LUA_FALSE
		end

		PRINT( "PackBagGoods: PackBag:RES_MINE: itemid = , count = , pileid = ", ResourceList.mine[level].itemid, ResourceList.mine[level].count, ResourceList.mine[level].pileid )
		local ret, numpack = PackBag( character, boat, ResourceList.mine[level].itemid, ResourceList.mine[level].count, ResourceList.mine[level].pileid )
		if ret ~= LUA_TRUE then
			MISSDK_NPCSDK_LUA_000102 = GetResString("MISSDK_NPCSDK_LUA_000102")
			PRINT( MISSDK_NPCSDK_LUA_000102, level, ResourceList.mine[level].itemid, ResourceList.mine[level].count, ResourceList.mine[level].pileid )
			return LUA_FALSE
		end
		MISSDK_NPCSDK_LUA_000107 = GetResString("MISSDK_NPCSDK_LUA_000107")
		MISSDK_NPCSDK_LUA_000104 = GetResString("MISSDK_NPCSDK_LUA_000104")
		MISSDK_NPCSDK_LUA_000105 = GetResString("MISSDK_NPCSDK_LUA_000105")
		PRINT( MISSDK_NPCSDK_LUA_000105..numpack..MISSDK_NPCSDK_LUA_000104..level..MISSDK_NPCSDK_LUA_000107 )
		if numpack > 0 then
			MISSDK_NPCSDK_LUA_000107 = GetResString("MISSDK_NPCSDK_LUA_000107")
			MISSDK_NPCSDK_LUA_000104 = GetResString("MISSDK_NPCSDK_LUA_000104")
			MISSDK_NPCSDK_LUA_000105 = GetResString("MISSDK_NPCSDK_LUA_000105")
			BickerNotice( character, MISSDK_NPCSDK_LUA_000105..numpack..MISSDK_NPCSDK_LUA_000104..level..MISSDK_NPCSDK_LUA_000107 )
		end
	else
		MISSDK_NPCSDK_LUA_000108 = GetResString("MISSDK_NPCSDK_LUA_000108")
		PRINT( MISSDK_NPCSDK_LUA_000108, character, boat, tp, level )
		MISSDK_NPCSDK_LUA_000108 = GetResString("MISSDK_NPCSDK_LUA_000108")
		LG( "goods_error", MISSDK_NPCSDK_LUA_000108, character, boat, tp, level )
		return LUA_FALSE
	end
	PRINT( "PackBagGoods: return true" )
	return LUA_TRUE
end

--调整贸易税率
function AdjustTradeCess( character, cess, cessrange )
	if cess == nil or cessrange == nil then
		MISSDK_NPCSDK_LUA_000109 = GetResString("MISSDK_NPCSDK_LUA_000109")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000109 )
		MISSDK_NPCSDK_LUA_000109 = GetResString("MISSDK_NPCSDK_LUA_000109")
		LG( "mission_error", MISSDK_NPCSDK_LUA_000109 )
		return LUA_ERROR
	end

	local ret, level, cessdata = GetTradeItemData( character )
	if ret ~= LUA_TRUE then
		MISSDK_NPCSDK_LUA_000110 = GetResString("MISSDK_NPCSDK_LUA_000110")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000110 )
		MISSDK_NPCSDK_LUA_000110 = GetResString("MISSDK_NPCSDK_LUA_000110")
		LG( "mission_error", MISSDK_NPCSDK_LUA_000110 )
		return LUA_FALSE
	end

	--检查贸易证等级
	if level == 1 then
		return AdjustTradeItemCess( character, 200, cess + Rand( cessrange ) )
	elseif level == 2 then
		return AdjustTradeItemCess( character, 500, cess + Rand( cessrange ) )
	elseif level == 3 then
		return AdjustTradeItemCess( character, 60000, cess + Rand( cessrange ) )
	else
		MISSDK_NPCSDK_LUA_000111 = GetResString("MISSDK_NPCSDK_LUA_000111")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000111..level )
		MISSDK_NPCSDK_LUA_000112 = GetResString("MISSDK_NPCSDK_LUA_000112")
		MISSDK_NPCSDK_LUA_000113 = GetResString("MISSDK_NPCSDK_LUA_000113")
		LG( "mission_error", MISSDK_NPCSDK_LUA_000113..GetCharName( character )..MISSDK_NPCSDK_LUA_000112..level )
		return LUA_FALSE
	end

end

--荣誉值兑换道具
function CreditExchange( character, npc, tp )
	if tp == nil then
		MISSDK_NPCSDK_LUA_000114 = GetResString("MISSDK_NPCSDK_LUA_000114")
		PRINT( MISSDK_NPCSDK_LUA_000114 )
		MISSDK_NPCSDK_LUA_000114 = GetResString("MISSDK_NPCSDK_LUA_000114")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000114 )
		return LUA_ERROR	
	end
	
	PRINT( "CreditExchange, p1 = "..tp )
	CreditExchangeImpl( character, tp )
	return LUA_TRUE
end

--船只升级处理函数
function BoatLevelUp( character, boat, levelup )
	PRINT( "BoatLevelUp: levelup", levelup )
	if levelup == nil or BoatLevelList == nil  then
		MISSDK_NPCSDK_LUA_000115 = GetResString("MISSDK_NPCSDK_LUA_000115")
		PRINT( MISSDK_NPCSDK_LUA_000115 )
		MISSDK_NPCSDK_LUA_000115 = GetResString("MISSDK_NPCSDK_LUA_000115")
		SystemNotice( character, MISSDK_NPCSDK_LUA_000115 )
		return LUA_ERROR
	end

	if BoatLevelList[levelup] == nil or BoatLevelList[levelup].money == nil or BoatLevelList[levelup].exp == nil	then
		MISSDK_NPCSDK_LUA_000116 = GetResString("MISSDK_NPCSDK_LUA_000116")
		BickerNotice( character, MISSDK_NPCSDK_LUA_000116 )
		return LUA_TRUE
	end

	PRINT( "BoatLevelUp: levelup, exp, moeny", levelup, BoatLevelList[levelup].exp, BoatLevelList[levelup].money )
	--判断经验和钱升级条件是否足够
	local ret = BoatLevelUpProc( character, boat, levelup, BoatLevelList[levelup].exp, BoatLevelList[levelup].money )
	if ret == 0 then
		MISSDK_NPCSDK_LUA_000117 = GetResString("MISSDK_NPCSDK_LUA_000117")
		PRINT( MISSDK_NPCSDK_LUA_000117 )
	end

	return LUA_TRUE
end

--裁缝卷兑换爱情积分
function ChangeLovePointOne(character,npc)

	local Num = 0
	local LoveBookNum = 0	
	Num =  CheckBagItem( character,1018 )
	LoveBookNum = CheckBagItem( character,6959 )

	if LoveBookNum == 1 then
		if Num > 0 then 
			TakeItem( character , 0 , 1018 , 1 )
			LoveBook = GetChaItem2 ( character , 2 , 6959 )
			LoveBook_Energy = GetItemAttr( LoveBook , ITEMATTR_VAL_STR )
			LoveBook_Energy = LoveBook_Energy + 4
			SetItemAttr(LoveBook,ITEMATTR_VAL_STR,LoveBook_Energy)
			SynChaKitbag(character,13)
			MISSDK_NPCSDK_LUA_000118 = GetResString("MISSDK_NPCSDK_LUA_000118")
			SystemNotice ( character , MISSDK_NPCSDK_LUA_000118 )
			return 1
		else
			MISSDK_NPCSDK_LUA_000119 = GetResString("MISSDK_NPCSDK_LUA_000119")
			SystemNotice ( character , MISSDK_NPCSDK_LUA_000119 )
			return 0
		end
	else
		MISSDK_NPCSDK_LUA_000120 = GetResString("MISSDK_NPCSDK_LUA_000120")
		SystemNotice ( character , MISSDK_NPCSDK_LUA_000120 )
		return 0
	end

end 

function ChangeLovePointTen(character,npc)

	local Num = 0
	local LoveBookNum = 0	
	Num =  CheckBagItem( character,1018 )
	LoveBookNum = CheckBagItem( character,6959 )

	if LoveBookNum == 1 then
		if Num > 9 then 
			TakeItem( character , 0 , 1018 , 10 )
			LoveBook = GetChaItem2 ( character , 2 , 6959 )
			LoveBook_Energy = GetItemAttr( LoveBook , ITEMATTR_VAL_STR )
			LoveBook_Energy = LoveBook_Energy + 40
			SetItemAttr(LoveBook,ITEMATTR_VAL_STR,LoveBook_Energy)
			SynChaKitbag(character,13)
			MISSDK_NPCSDK_LUA_000121 = GetResString("MISSDK_NPCSDK_LUA_000121")
			SystemNotice ( character , MISSDK_NPCSDK_LUA_000121 )
			return 1
		else
			MISSDK_NPCSDK_LUA_000122 = GetResString("MISSDK_NPCSDK_LUA_000122")
			SystemNotice ( character , MISSDK_NPCSDK_LUA_000122 )
			return 0
		end
	else
		MISSDK_NPCSDK_LUA_000120 = GetResString("MISSDK_NPCSDK_LUA_000120")
		SystemNotice ( character , MISSDK_NPCSDK_LUA_000120 )
		return 0
	end

end 
--对话命令消息处理
function MsgProc( character, npc, rpk, page, trade, missionlist, exchangeData )
	if character == nil or npc == nil or rpk == nil then
		MISSDK_NPCSDK_LUA_000123 = GetResString("MISSDK_NPCSDK_LUA_000123")
		PRINT( MISSDK_NPCSDK_LUA_000123 )
		MISSDK_NPCSDK_LUA_000123 = GetResString("MISSDK_NPCSDK_LUA_000123")
		EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000123 )
		return
	end
	PRINT( "MsgProc:Net message process." )
	local usCmd = ReadWord( rpk );
	if usCmd == CMD_CM_TALKPAGE then	--对话页命令信息处理
		local byTalkID = ReadByte( rpk ) --读取页指令索引信息

		if byTalkID == ROLE_FIRSTPAGE then	--和npc第一次交流对话
			RefreshMissionState( character, npc )
			if page.start == MultiTrigger then
				PRINT( "MsgProc:MultiTrigger, page, p1, p2", page, page.p1, page.p2 )
				return MultiTrigger( character, npc, page, page.p1, page.p2 )
			end
			if page.start == PopupWindow then
				PRINT( "MsgProc:PopupWindow, page, p1, p2", page, page.p1, page.p2 )
				return PopupWindow( character, npc, page, page.p1, page.p2 )
			end
			return JumpPage( character, npc, page, 1 ) --发送第一页对话信息
		elseif byTalkID == ROLE_CLOSEPAGE then
			return SendClosePage( character, npc ) --关闭对话
		elseif page[byTalkID] == nil or page[byTalkID][1] == nil then --错误的页数据，报警
			MISSDK_NPCSDK_LUA_000124 = GetResString("MISSDK_NPCSDK_LUA_000124")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000124 )
		else
			local talkpage = page[byTalkID][1]
			local funcpage = page[byTalkID][2]

			--执行页链接功能指令
			if talkpage.func == JumpPage then
				return JumpPage( character, npc, page, talkpage.p1 )
			elseif talkpage.func == FuncPage then
				return FuncPage( character, npc, page, talkpage.p1 )
			elseif talkpage.func == CloseTalk then
				return CloseTalk( character, npc )
			elseif talkpage.func == HasRecord then
			local ret = HasRecord( character, talkpage.p1 )
				if ret == LUA_TRUE then
					return JumpPage( character, npc, page, talkpage.p2 )
				else
					return JumpPage( character, npc, page, talkpage.p3 )
				end
			elseif funcpage ~= nil then	--判断是否有功能信息
				return FuncPage( character, npc, page, byTalkID )
			else --跳转到下一页
				local PageID = byTalkID + 1

				if page[PageID] == nil then
					MISSDK_NPCSDK_LUA_000125 = GetResString("MISSDK_NPCSDK_LUA_000125")
					EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000125, GetCharName( npc ), PageID )
					MISSDK_NPCSDK_LUA_000126 = GetResString("MISSDK_NPCSDK_LUA_000126")
					return SystemNotice( character, MISSDK_NPCSDK_LUA_000126 )
				end
				return JumpPage( character, npc, page, PageID )
			end
		end
		return
	elseif usCmd == CMD_CM_FUNCITEM then --功能页选项命令信息处理
		-- LG("ques","开始读取选项功能")
		local byPage = ReadByte( rpk );	--读取功能页索引信息
		local byItem = ReadByte( rpk ); --读取功能选项索引信息
		MISSDK_NPCSDK_LUA_000127 = GetResString("MISSDK_NPCSDK_LUA_000127")
		LG("ques",MISSDK_NPCSDK_LUA_000127..byPage.."byItem"..byItem)
		PRINT( "MsgProc: pageid = , itemid = ", byPage, byItem )
		if page[byPage] == nil or page[byPage][1] == nil then
			MISSDK_NPCSDK_LUA_000128 = GetResString("MISSDK_NPCSDK_LUA_000128")
			EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000128, GetCharName( npc ), byPage, byItem )
			MISSDK_NPCSDK_LUA_000129 = GetResString("MISSDK_NPCSDK_LUA_000129")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000129 )
		end
		LG("ques","page[byPage][1].talk ",page[byPage][1].talk )
		if page[byPage][1].talk ~= nil then --是否既有对话页信息也有功能页信息
			if page[byPage][1].func ~= nil then
				LG("ques","page[byPage][1].func ",page[byPage][1].func )
				PRINT( "MultiTrigger" )
				byItem = 1                           --如果对话信息有执行函数则优先执行
			else
				LG("ques","page[byPage][1].func ",page[byPage][1].func )
				byItem = byItem + 2			 --跳到选择项功能函数执行
			end
		elseif page[byPage][1].text ~= nil then
			LG("ques","page[byPage][1].text ",page[byPage][1].text )
			byItem = byItem + 1
		end
		-- LG("ques","开始处理功能")
		--处理功能项目选择命令
		local item = page[byPage][byItem]
		MISSDK_NPCSDK_LUA_000130 = GetResString("MISSDK_NPCSDK_LUA_000130")
		LG("ques",MISSDK_NPCSDK_LUA_000130..byPage.."byItem"..byItem)
		if item == nil or item.func == nil then
			MISSDK_NPCSDK_LUA_000131 = GetResString("MISSDK_NPCSDK_LUA_000131")
			EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000131, GetCharName( npc ), byPage, byItem )
			MISSDK_NPCSDK_LUA_000132 = GetResString("MISSDK_NPCSDK_LUA_000132")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000132 )
		end
		if item.func == JumpPage then
			return JumpPage( character, npc, page, item.p1 )
		elseif item.func == FuncPage then
			return FuncPage( character, npc, page, item.p1 )
		elseif item.func == CloseTalk then
			return CloseTalk( character, npc )
		elseif item.func == GoTo then
			return GoTo( character, item.p1, item.p2, item.p3 )
		elseif item.func == GoToDream then
			return GoToDream( character, item.p1 )
		elseif item.func == RandToMap then
			return RandToMap( character, npc, item.p1, item.p2 )
		elseif item.func == RandFunction then
			return RandFunction( character, npc, page, item.p1, item.p2 )
		elseif item.func == MultiFunc then
			return MultiFunc( character, npc, page, item.p1, item.p2 )
		elseif item.func == SalePage then
			return SalePage( character, npc, trade )
		elseif item.func == BuyPage then
			return BuyPage( character, npc, trade )
		elseif item.func == ListAuction then
			return ListAuction( character, npc )
		elseif item.func == ChangeItem then
			return ChangeItem(character,npc)
		elseif item.func == TradeGoods then
			return TradeGoods( character, npc, trade, item.p1 )
		elseif item.func == MultiTrigger then
			return MultiTrigger( character, npc, page, item.p1, item.p2 )
		elseif item.func == MultiTrigger_0 then
			return MultiTrigger_0( character, npc, page, item.p1, item.p2 )
		elseif item.func == MultiTrigger_1 then
			return MultiTrigger_1( character, npc, page, item.p1, item.p2 )
		elseif item.func == MultiTrigger_2 then
			return MultiTrigger_2( character, npc, page, item.p1, item.p2 )
		elseif item.func == MultiTrigger_3 then
			return MultiTrigger_3( character, npc, page, item.p1, item.p2 )
		elseif item.func == OpenForge then
			return OpenForge( character, npc )
		elseif item.func == OpenUnite then
			return OpenUnite( character, npc )
		elseif item.func == OpenMilling then
			return OpenMilling( character, npc )
		elseif item.func == OpenHair then
			return OpenHair( character, npc )
		elseif item.func == OpenRepair then
			return OpenRepair( character, npc )
		elseif item.func == OpenFusion then
			return OpenFusion( character, npc )
		elseif item.func == OpenUpgrade then
			return OpenUpgrade( character, npc )
		elseif item.func == OpenEidolonMetempsychosis then
			return OpenEidolonMetempsychosis( character, npc )
		elseif item.func == OpenItemTiChun then
			return OpenItemTiChun( character, npc )
		elseif item.func == OpenItemEnergy then
			return OpenItemEnergy( character, npc )
		elseif item.func == OpenGMSend then
			return OpenGMSend( character, npc )
		elseif item.func == OpenGMRecv then
			return OpenGMRecv( character, npc )
		elseif item.func == OpenItemFix then
			return OpenItemFix( character, npc )
		elseif item.func == OpenGetStone then
			return OpenGetStone( character, npc )
		elseif item.func == OpenTiger then
			return OpenTiger( character, npc )
		elseif item.func == GoTosdBoss then
			return GoTosdBoss(character,item.p1)
		elseif item.func == SetSpawnPos then
			return SetSpawnPos( character, item.p1 )
		elseif item.func == TransferDiamond then
			return TransferDiamond( character, item.p1 )
		elseif item.func == ListChallenge then
			return ListChallenge( character, npc )
		--elseif item.func == ListAuction then
			--return ListAuction( character, npc )
		elseif item.func == SendExchangeData then
			return SendExchangeData( character, npc )
		elseif item.func == SendExchangeXData then
			return SendExchangeXData( character, npc, exchangeData )
		elseif item.func == Garner2GetWiner then 
			return Garner2GetWiner(character,npc)
		elseif item.func == Change_FightingBook then
			return Change_FightingBook (character,npc)
		elseif item.func == Garner2RequestReorder then
			return Garner2RequestReorder (character,npc)
		elseif item.func == Transfer_TeamStar then
			return Transfer_TeamStar( character, item.p1 )
		elseif item.func == LifeSkillBegin then
			return LifeSkillBegin(character,npc,item.p1)
		elseif item.func == Change_shanyao then
			return Change_shanyao(character,npc)
		elseif item.func == Change_rongyao then
			return Change_rongyao(character,npc)
		elseif item.func == Change_huihuang then
			return Change_huihuang(character,npc)
		elseif item.func == ItemAttrNum then
			return ItemAttrNum( character, npc,item.p1,item.p2,item.p3,item.p4)		
		elseif item.func == CheckItemAttr then
			return CheckItemAttr( character, npc,item.p1,item.p2)
		elseif item.func == GetChaName_0 then
			return GetChaName_0(character,npc )
		elseif item.func == GetChaName_1 then
			return GetChaName_1(character,npc )
		elseif item.func == GetChaName_2 then
			return GetChaName_2(character,npc )
		elseif item.func == GetChaName_3 then
			return GetChaName_3(character,npc )
		elseif item.func == GetChaName_4 then
			return GetChaName_4(character,npc )
		elseif item.func == GetChaName_5 then
			return GetChaName_5(character,npc )
		elseif item.func == GetChaName_6 then
			return GetChaName_6(character,npc )
		elseif item.func == GetChaName_7 then
			return GetChaName_7(character,npc )
		elseif item.func == GetChaName_8 then
			return GetChaName_8(character,npc )
		elseif item.func == GetChaName_9 then
			return GetChaName_9(character,npc )
		elseif item.func == GetChaName_10 then
			return GetChaName_10(character,npc )
		elseif item.func == GetChaName_11 then
			return GetChaName_11(character,npc )
		elseif item.func == GetChaName_12 then
			return GetChaName_12(character,npc )
		elseif item.func == GetChaName_13 then
			return GetChaName_13(character,npc )
		elseif item.func == GetChaName_14 then
			return GetChaName_14(character,npc )
		elseif item.func == GetChaName_15 then
			return GetChaName_15(character,npc )
		elseif item.func == GetChaName_16 then
			return GetChaName_16(character,npc )
		elseif item.func == GetChaName_17 then
			return GetChaName_17(character,npc )
		elseif item.func == GetChaName_18 then
			return GetChaName_18(character,npc )
		elseif item.func == GetChaName_19 then
			return GetChaName_19(character,npc )
		elseif item.func == GetChaName_20 then
			return GetChaName_20(character,npc )
		elseif item.func == GetChaName_21 then
			return GetChaName_21(character,npc )
		elseif item.func == GetChaName_22 then
			return GetChaName_22(character,npc )
		elseif item.func == GetChaName_23 then
			return GetChaName_23(character,npc )
		elseif item.func == GetChaName_24 then
			return GetChaName_24(character,npc )
		elseif item.func == GetChaName_25 then
			return GetChaName_25(character,npc )
		elseif item.func == GetChaName_26 then
			return GetChaName_26(character,npc )
		elseif item.func == GetChaName_27 then
			return GetChaName_27(character,npc )
		elseif item.func == GetChaName_28 then
			return GetChaName_28(character,npc )
		elseif item.func == GetChaName1_born then
			return GetChaName1_born(character,npc )
		elseif item.func == GetChaName2_born then
			return GetChaName2_born(character,npc )
		elseif item.func == GetChaName3_born then
			return GetChaName3_born(character,npc )
		elseif item.func == GetChaName4_born then
			return GetChaName4_born(character,npc )
		elseif item.func == GetChaName5_born then
			return GetChaName5_born(character,npc )
		elseif item.func == GetChaName6_born then
			return GetChaName6_born(character,npc )
		elseif item.func == GetChaName1_born2 then
			return GetChaName1_born2(character,npc )
		elseif item.func == GetChaName2_born2 then
			return GetChaName2_born2(character,npc )
		elseif item.func == GetChaName3_born2 then
			return GetChaName3_born2(character,npc )
		elseif item.func == GetChaName4_born2 then
			return GetChaName4_born2(character,npc )
		elseif item.func == GetChaName5_born2 then
			return GetChaName5_born2(character,npc )
		elseif item.func == GetChaName6_born2 then
			return GetChaName6_born2(character,npc )
		elseif item.func == GiveHoe then
			return GiveHoe(character,npc)
		elseif item.func == CheckMetal then
			return CheckMetal(character,npc )
		elseif item.func == ChangeRingLv60Agi then
			return ChangeRingLv60Agi(character,npc )
		elseif item.func == ChangeRingLv60Str then
			return ChangeRingLv60Str(character,npc )
		elseif item.func == ChangeRingLv60Dex then
			return ChangeRingLv60Dex(character,npc )
		elseif item.func == ChangeRingLv60Con then
			return ChangeRingLv60Con(character,npc )
		elseif item.func == ChangeRingLv60Sta then
			return ChangeRingLv60Sta(character,npc )
		elseif item.func == ChangeRingLv65Str_Con then
			return ChangeRingLv65Str_Con(character,npc )			
		elseif item.func == ChangeRingLv65Str_Agi then
			return ChangeRingLv65Str_Agi(character,npc )
		elseif item.func == ChangeRingLv65Str_Sta then
			return ChangeRingLv65Str_Sta(character,npc )
		elseif item.func == ChangeRingLv65Str_Dex then
			return ChangeRingLv65Str_Dex(character,npc )
		elseif item.func == ChangeRingLv65Con_Agi then
			return ChangeRingLv65Con_Agi(character,npc )
		elseif item.func == ChangeRingLv65Con_Str then
			return ChangeRingLv65Con_Str(character,npc )
		elseif item.func == ChangeRingLv65Con_Sta then
			return ChangeRingLv65Con_Sta(character,npc )
		elseif item.func == ChangeRingLv65Con_Dex then
			return ChangeRingLv65Con_Dex(character,npc )
		elseif item.func == ChangeRingLv65Sta_Con then
			return ChangeRingLv65Sta_Con(character,npc )			
		elseif item.func == ChangeRingLv65Sta_Agi then
			return ChangeRingLv65Sta_Agi(character,npc )
		elseif item.func == ChangeRingLv65Sta_Str then
			return ChangeRingLv65Sta_Str(character,npc )
		elseif item.func == ChangeRingLv65Sta_Dex then
			return ChangeRingLv65Sta_Dex(character,npc )
		elseif item.func == ChangeRingLv65Agi_Con then
			return ChangeRingLv65Agi_Con(character,npc )
		elseif item.func == ChangeRingLv65Agi_Str then
			return ChangeRingLv65Agi_Str(character,npc )
		elseif item.func == ChangeRingLv65Agi_Sta then
			return ChangeRingLv65Agi_Sta(character,npc )
		elseif item.func == ChangeRingLv65Agi_Dex then
			return ChangeRingLv65Agi_Dex(character,npc )
		elseif item.func == ChangeRingLv65Dex_Con then
			return ChangeRingLv65Dex_Con(character,npc )			
		elseif item.func == ChangeRingLv65Dex_Str then
			return ChangeRingLv65Dex_Str(character,npc )
		elseif item.func == ChangeRingLv65Dex_Agi then
			return ChangeRingLv65Dex_Agi(character,npc )
		elseif item.func == ChangeRingLv65Dex_Sta then
			return ChangeRingLv65Dex_Sta(character,npc )		
		elseif item.func == ChangeRingLv70Agi then
			return ChangeRingLv70Agi(character,npc )
		elseif item.func == ChangeRingLv70Str then
			return ChangeRingLv70Str(character,npc )
		elseif item.func == ChangeRingLv70Dex then
			return ChangeRingLv70Dex(character,npc )
		elseif item.func == ChangeRingLv70Con then
			return ChangeRingLv70Con(character,npc )
		elseif item.func == ChangeRingLv70Sta then
			return ChangeRingLv70Sta(character,npc )
		elseif item.func == ChangeRingLv75Str_Con then
			return ChangeRingLv75Str_Con(character,npc )			
		elseif item.func == ChangeRingLv75Str_Agi then
			return ChangeRingLv75Str_Agi(character,npc )
		elseif item.func == ChangeRingLv75Str_Sta then
			return ChangeRingLv75Str_Sta(character,npc )
		elseif item.func == ChangeRingLv75Str_Dex then
			return ChangeRingLv75Str_Dex(character,npc )
		elseif item.func == ChangeRingLv75Con_Agi then
			return ChangeRingLv75Con_Agi(character,npc )
		elseif item.func == ChangeRingLv75Con_Str then
			return ChangeRingLv75Con_Str(character,npc )
		elseif item.func == ChangeRingLv75Con_Sta then
			return ChangeRingLv75Con_Sta(character,npc )
		elseif item.func == ChangeRingLv75Con_Dex then
			return ChangeRingLv75Con_Dex(character,npc )
		elseif item.func == ChangeRingLv75Sta_Con then
			return ChangeRingLv75Sta_Con(character,npc )			
		elseif item.func == ChangeRingLv75Sta_Agi then
			return ChangeRingLv75Sta_Agi(character,npc )
		elseif item.func == ChangeRingLv75Sta_Str then
			return ChangeRingLv75Sta_Str(character,npc )
		elseif item.func == ChangeRingLv75Sta_Dex then
			return ChangeRingLv75Sta_Dex(character,npc )
		elseif item.func == ChangeRingLv75Agi_Con then
			return ChangeRingLv75Agi_Con(character,npc )
		elseif item.func == ChangeRingLv75Agi_Str then
			return ChangeRingLv75Agi_Str(character,npc )
		elseif item.func == ChangeRingLv75Agi_Sta then
			return ChangeRingLv75Agi_Sta(character,npc )
		elseif item.func == ChangeRingLv75Agi_Dex then
			return ChangeRingLv75Agi_Dex(character,npc )
		elseif item.func == ChangeRingLv75Dex_Con then
			return ChangeRingLv75Dex_Con(character,npc )			
		elseif item.func == ChangeRingLv75Dex_Str then
			return ChangeRingLv75Dex_Str(character,npc )
		elseif item.func == ChangeRingLv75Dex_Agi then
			return ChangeRingLv75Dex_Agi(character,npc )
		elseif item.func == ChangeRingLv75Dex_Sta then
			return ChangeRingLv75Dex_Sta(character,npc )
		elseif item.func == ChangeRingLv80Agi then
			return ChangeRingLv80Agi(character,npc )
		elseif item.func == ChangeRingLv80Str then
			return ChangeRingLv80Str(character,npc )
		elseif item.func == ChangeRingLv80Dex then
			return ChangeRingLv80Dex(character,npc )
		elseif item.func == ChangeRingLv80Con then
			return ChangeRingLv80Con(character,npc )
		elseif item.func == ChangeRingLv80Sta then
			return ChangeRingLv80Sta(character,npc )
		elseif item.func == DownRingLv65Str_Con then
			return DownRingLv65Str_Con(character,npc )			
		elseif item.func == DownRingLv65Str_Agi then
			return DownRingLv65Str_Agi(character,npc )
		elseif item.func == DownRingLv65Str_Sta then
			return DownRingLv65Str_Sta(character,npc )
		elseif item.func == DownRingLv65Str_Dex then
			return DownRingLv65Str_Dex(character,npc )
		elseif item.func == DownRingLv65Con_Agi then
			return DownRingLv65Con_Agi(character,npc )
		elseif item.func == DownRingLv65Con_Str then
			return DownRingLv65Con_Str(character,npc )
		elseif item.func == DownRingLv65Con_Sta then
			return DownRingLv65Con_Sta(character,npc )
		elseif item.func == DownRingLv65Con_Dex then
			return DownRingLv65Con_Dex(character,npc )
		elseif item.func == DownRingLv65Sta_Con then
			return DownRingLv65Sta_Con(character,npc )			
		elseif item.func == DownRingLv65Sta_Agi then
			return DownRingLv65Sta_Agi(character,npc )
		elseif item.func == DownRingLv65Sta_Str then
			return DownRingLv65Sta_Str(character,npc )
		elseif item.func == DownRingLv65Sta_Dex then
			return DownRingLv65Sta_Dex(character,npc )
		elseif item.func == DownRingLv65Agi_Con then
			return DownRingLv65Agi_Con(character,npc )
		elseif item.func == DownRingLv65Agi_Str then
			return DownRingLv65Agi_Str(character,npc )
		elseif item.func == DownRingLv65Agi_Sta then
			return DownRingLv65Agi_Sta(character,npc )
		elseif item.func == DownRingLv65Agi_Dex then
			return DownRingLv65Agi_Dex(character,npc )
		elseif item.func == DownRingLv65Dex_Con then
			return DownRingLv65Dex_Con(character,npc )			
		elseif item.func == DownRingLv65Dex_Str then
			return DownRingLv65Dex_Str(character,npc )
		elseif item.func == DownRingLv65Dex_Agi then
			return DownRingLv65Dex_Agi(character,npc )
		elseif item.func == DownRingLv65Dex_Sta then
			return DownRingLv65Dex_Sta(character,npc )
		elseif item.func == DownRingLv70Agi then
			return DownRingLv70Agi(character,npc )
		elseif item.func == DownRingLv70Str then
			return DownRingLv70Str(character,npc )
		elseif item.func == DownRingLv70Dex then
			return DownRingLv70Dex(character,npc )
		elseif item.func == DownRingLv70Con then
			return DownRingLv70Con(character,npc )
		elseif item.func == DownRingLv70Sta then
			return DownRingLv70Sta(character,npc )
		elseif item.func == DownRingLv75Str_Con then
			return DownRingLv75Str_Con(character,npc )			
		elseif item.func == DownRingLv75Str_Agi then
			return DownRingLv75Str_Agi(character,npc )
		elseif item.func == DownRingLv75Str_Sta then
			return DownRingLv75Str_Sta(character,npc )
		elseif item.func == DownRingLv75Str_Dex then
			return DownRingLv75Str_Dex(character,npc )
		elseif item.func == DownRingLv75Con_Agi then
			return DownRingLv75Con_Agi(character,npc )
		elseif item.func == DownRingLv75Con_Str then
			return DownRingLv75Con_Str(character,npc )
		elseif item.func == DownRingLv75Con_Sta then
			return DownRingLv75Con_Sta(character,npc )
		elseif item.func == DownRingLv75Con_Dex then
			return DownRingLv75Con_Dex(character,npc )
		elseif item.func == DownRingLv75Sta_Con then
			return DownRingLv75Sta_Con(character,npc )			
		elseif item.func == DownRingLv75Sta_Agi then
			return DownRingLv75Sta_Agi(character,npc )
		elseif item.func == DownRingLv75Sta_Str then
			return DownRingLv75Sta_Str(character,npc )
		elseif item.func == DownRingLv75Sta_Dex then
			return DownRingLv75Sta_Dex(character,npc )
		elseif item.func == DownRingLv75Agi_Con then
			return DownRingLv75Agi_Con(character,npc )
		elseif item.func == DownRingLv75Agi_Str then
			return DownRingLv75Agi_Str(character,npc )
		elseif item.func == DownRingLv75Agi_Sta then
			return DownRingLv75Agi_Sta(character,npc )
		elseif item.func == DownRingLv75Agi_Dex then
			return DownRingLv75Agi_Dex(character,npc )
		elseif item.func == DownRingLv75Dex_Con then
			return DownRingLv75Dex_Con(character,npc )			
		elseif item.func == DownRingLv75Dex_Str then
			return DownRingLv75Dex_Str(character,npc )
		elseif item.func == DownRingLv75Dex_Agi then
			return DownRingLv75Dex_Agi(character,npc )
		elseif item.func == DownRingLv75Dex_Sta then
			return DownRingLv75Dex_Sta(character,npc )
		elseif item.func == DownRingLv80Agi then
			return DownRingLv80Agi(character,npc )
		elseif item.func == DownRingLv80Str then
			return DownRingLv80Str(character,npc )
		elseif item.func == DownRingLv80Dex then
			return DownRingLv80Dex(character,npc )
		elseif item.func == DownRingLv80Con then
			return DownRingLv80Con(character,npc )
		elseif item.func == DownRingLv80Sta then
			return DownRingLv80Sta(character,npc )
		elseif item.func == DownRingLv90Agi then
			return DownRingLv90Agi(character,npc )
		elseif item.func == DownRingLv90Str then
			return DownRingLv90Str(character,npc )
		elseif item.func == DownRingLv90Dex then
			return DownRingLv90Dex(character,npc )
		elseif item.func == DownRingLv90Con then
			return DownRingLv90Con(character,npc )
		elseif item.func == DownRingLv90Sta then
			return DownRingLv90Sta(character,npc )
		elseif item.func == Fool_choose1 then
			return Fool_choose1(character,npc )			
		elseif item.func == Fool_choose2 then
			return Fool_choose2(character,npc )				
		elseif item.func == Fool_choose3 then
			return Fool_choose3(character,npc )			
		elseif item.func == Fool_choose4 then
			return Fool_choose4(character,npc )
		elseif item.func == Fool_choose5 then
			return Fool_choose5(character,npc )			
		elseif item.func == Fool_choose6 then
			return Fool_choose6(character,npc )				
		elseif item.func == Fool_choose7 then
			return Fool_choose7(character,npc )			
		elseif item.func == Fool_choose8 then
			return Fool_choose8(character,npc )			
		elseif item.func == PKPointToZero then
			return PKPointToZero(character,npc)
		elseif item.func == PlayEffect then
			return PlayEffect( npc, 361 )
		elseif item.func == GetChaName1_guildwar then
			return GetChaName1_guildwar(character,npc )
		elseif item.func == GetChaName2_guildwar then
			return GetChaName2_guildwar(character,npc )
		elseif item.func == GetChaName3_guildwar then
			return GetChaName3_guildwar(character,npc )
		elseif item.func == GetChaName4_guildwar then
			return GetChaName4_guildwar(character,npc )
		elseif item.func == GetChaName5_guildwar then
			return GetChaName5_guildwar(character)
		elseif item.func == GetChaName6_guildwar then
			return GetChaName6_guildwar(character)
		elseif item.func == GetChaName7_guildwar then
			return GetChaName7_guildwar(character)
		elseif item.func == GetChaName8_guildwar then
			return GetChaName8_guildwar(character)
		elseif item.func == GetChaName9_guildwar then
			return GetChaName9_guildwar(character)
		elseif item.func == GetChaName10_guildwar then
			return GetChaName10_guildwar(character)
		elseif item.func == GetChaName11_guildwar then
			return GetChaName11_guildwar(character)
		elseif item.func == GetChaName12_guildwar then
			return GetChaName12_guildwar(character)
		elseif item.func == GetChaName13_guildwar then
			return GetChaName13_guildwar(character)
		elseif item.func == GetChaName14_guildwar then
			return GetChaName14_guildwar(character)
		elseif item.func == GetChaName15_guildwar then
			return GetChaName15_guildwar(character)
		elseif item.func == GetChaName16_guildwar then
			return GetChaName16_guildwar(character)
		elseif item.func == GetChaName17_guildwar then
			return GetChaName17_guildwar(character)
		elseif item.func == GetChaName18_guildwar then
			return GetChaName18_guildwar(character)
		elseif item.func == GetChaName19_guildwar then
			return GetChaName19_guildwar(character)
		elseif item.func == GetChaName20_guildwar then
			return GetChaName20_guildwar(character)
		elseif item.func == GetChaName21_guildwar then
			return GetChaName21_guildwar(character)
		elseif item.func == GetChaName22_guildwar then
			return GetChaName22_guildwar(character)
		elseif item.func == GetChaName23_guildwar then
			return GetChaName23_guildwar(character)
		elseif item.func == GetChaName24_guildwar then
			return GetChaName24_guildwar(character)
		elseif item.func == GetChaName25_guildwar then
			return GetChaName25_guildwar(character)
		elseif item.func == GetChaName26_guildwar then
			return GetChaName26_guildwar(character)
		elseif item.func == GetChaName27_guildwar then
			return GetChaName27_guildwar(character)
		elseif item.func == GetChaName28_guildwar then
			return GetChaName28_guildwar(character)
		elseif item.func == GetChaName29_guildwar then
			return GetChaName29_guildwar(character)
		elseif item.func == GetChaName30_guildwar then
			return GetChaName30_guildwar(character)
		elseif item.func == GetChaName31_guildwar then
			return GetChaName31_guildwar(character)
		elseif item.func == GetChaName32_guildwar then
			return GetChaName32_guildwar(character)
		elseif item.func == GetChaName33_guildwar then
			return GetChaName33_guildwar(character)
		elseif item.func == GetChaName34_guildwar then
			return GetChaName34_guildwar(character)
		elseif item.func == GetChaName35_guildwar then
			return GetChaName35_guildwar(character)
		elseif item.func == GetChaName36_guildwar then
			return GetChaName36_guildwar(character)
		elseif item.func == GetChaName37_guildwar then
			return GetChaName37_guildwar(character)
		elseif item.func == GetChaName38_guildwar then
			return GetChaName38_guildwar(character)
		elseif item.func == GetChaName39_guildwar then
			return GetChaName39_guildwar(character)
		elseif item.func == GetChaName40_guildwar then
			return GetChaName40_guildwar(character)
		elseif item.func == GetChaName41_guildwar then
			return GetChaName41_guildwar(character)
		elseif item.func == GetChaName42_guildwar then
			return GetChaName42_guildwar(character)
		elseif item.func == GetChaName43_guildwar then
			return GetChaName43_guildwar(character)
		elseif item.func == GetChaName44_guildwar then
			return GetChaName44_guildwar(character)
		elseif item.func == GetChaName45_guildwar then
			return GetChaName45_guildwar(character)
		elseif item.func == ChangeItem then
			return ChangeItem(character,npc)
		elseif item.func == Zhuanzts then
			return Zhuanzts(character,npc )
		elseif item.func == ZBChaXun then
			return ZBChaXun(character,npc )
		elseif item.func == CheckAns then
			return CheckAns(character,npc ,byItem,page,byPage)
		elseif item.func == ChargeZZMoney then
			return ChargeZZMoney( character, npc )
		elseif item.func == ChargeZZExp then
			return ChargeZZExp( character, npc )
		elseif item.func == ChangeLovePointOne then
			return ChangeLovePointOne( character, npc )
		elseif item.func == ChangeLovePointTen then
			return ChangeLovePointTen( character, npc )	
		else
			MISSDK_NPCSDK_LUA_000133 = GetResString("MISSDK_NPCSDK_LUA_000133")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000133 )
		end
	elseif usCmd == CMD_CM_BLACKMARKET_EXCHANGE_REQ then --黑市兑换
		local timeNum = ReadWord( rpk )
		local srcID = ReadWord( rpk )
		local srcNum = ReadWord( rpk )
		local tarID = ReadWord( rpk )
		local tarNum = ReadWord( rpk )
		local byIndex = ReadWord( rpk )
		
		local ret = KitbagLock( character, 0 )
		if ret ~= LUA_TRUE then
			CALCULATE_FORGE_LUA_000053 = GetResString("CALCULATE_FORGE_LUA_000053")
			SystemNotice( character, CALCULATE_FORGE_LUA_000053 )
			return
		end
		
		local retbag = HasLeaveBagGrid( character, 1)
		if retbag ~= LUA_TRUE then
			CALCULATE_FORGE_LUA_000055 = GetResString("CALCULATE_FORGE_LUA_000055")
			SystemNotice(character,CALCULATE_FORGE_LUA_000055)
			return 
		end
		
		ExchangeReq( character, npc, srcID, srcNum, tarID, tarNum, timeNum )
	elseif usCmd == CMD_CM_TRADEITEM then --请求交易处理
		local tradetype = ReadByte( rpk )
		if tradetype == ROLE_TRADE_SALE then	--请求出售物品
			if trade.tp ~= TRADE_NOMAL then
				MISSDK_NPCSDK_LUA_000134 = GetResString("MISSDK_NPCSDK_LUA_000134")
				SystemNotice( character, MISSDK_NPCSDK_LUA_000134, trade.tp )
				MISSDK_NPCSDK_LUA_000135 = GetResString("MISSDK_NPCSDK_LUA_000135")
				PRINT( MISSDK_NPCSDK_LUA_000135, trade.tp, ROLE_TRADE_SALE )
				return
			end

			local index = ReadByte( rpk )
			local count = ReadByte( rpk )
			if count == 0 then
				return
			end
			PRINT( "MsgProc:Sale index = %d, count = %d", index, count )
			Sale( character, npc, index, count )
		elseif tradetype == ROLE_TRADE_BUY then	--请求购买物品
			if trade.tp ~= TRADE_NOMAL then
				MISSDK_NPCSDK_LUA_000134 = GetResString("MISSDK_NPCSDK_LUA_000134")
				SystemNotice( character, MISSDK_NPCSDK_LUA_000134, trade.tp )
				MISSDK_NPCSDK_LUA_000135 = GetResString("MISSDK_NPCSDK_LUA_000135")
				PRINT( MISSDK_NPCSDK_LUA_000135, trade.tp, ROLE_TRADE_BUY )
				return
			end

			local itemtype = ReadByte( rpk )
			local index1 = ReadByte( rpk )
			local index2 = ReadByte( rpk )
			local count = ReadByte( rpk )
			if count == 0 then
				return
			end
			PRINT( "MsgProc:Buy itemtype = %d, index1 = %d, index2 = %d, count = %d", itemtype, index1, index2, count )
			Buy( character, npc, trade, itemtype, index1, index2, count )
		elseif tradetype == ROLE_TRADE_SALE_GOODS then	--请求出售货舱物品
			if trade.tp ~= TRADE_GOODS then
				MISSDK_NPCSDK_LUA_000134 = GetResString("MISSDK_NPCSDK_LUA_000134")
				SystemNotice( character, MISSDK_NPCSDK_LUA_000134, trade.tp )
				MISSDK_NPCSDK_LUA_000135 = GetResString("MISSDK_NPCSDK_LUA_000135")
				PRINT( MISSDK_NPCSDK_LUA_000135, trade.tp, ROLE_TRADE_SALE_GOODS )
				return
			end

			local boatid = ReadDword( rpk )
			local index = ReadByte( rpk )
			local count = ReadByte( rpk )
			if count == 0 then
				return
			end
			PRINT( "MsgProc:Sale boatid = ,index =, count =", boatid, index, count )
			SaleGoods( character, npc, trade, boatid, index, count )
		elseif tradetype == ROLE_TRADE_BUY_GOODS then 	--请求购买货舱物品
			if trade.tp ~= TRADE_GOODS then
				MISSDK_NPCSDK_LUA_000134 = GetResString("MISSDK_NPCSDK_LUA_000134")
				SystemNotice( character, MISSDK_NPCSDK_LUA_000134, trade.tp )
				MISSDK_NPCSDK_LUA_000135 = GetResString("MISSDK_NPCSDK_LUA_000135")
				PRINT( MISSDK_NPCSDK_LUA_000135, trade.tp, ROLE_TRADE_BUY_GOODS )
				return
			end

			local boatid = ReadDword( rpk )
			local itemtype = ReadByte( rpk )
			local index1 = ReadByte( rpk )
			local index2 = ReadByte( rpk )
			local count = ReadByte( rpk )

			if count == 0 then
				return
			end
			PRINT( "MsgProc:Buy goods boatid =, itemtype = , index1 = , index2 =, count = ", boatid, itemtype, index1, index2, count )
			BuyGoods( character, npc, trade, boatid, itemtype, index1, index2, count )
		elseif tradetype == ROLE_TRADE_SELECT_BOAT then --选择交易船只
			local index = ReadByte( rpk )
			PRINT( "MsgProc:index = ", index )
			TradeGoods( character, npc, trade, index )
		else
			MISSDK_NPCSDK_LUA_000136 = GetResString("MISSDK_NPCSDK_LUA_000136")
			return SystemNotice( character, MISSDK_NPCSDK_LUA_000136 )
		end
	elseif usCmd == CMD_CM_MISSION then --任务处理
		return MissionProc( character, npc, rpk, missionlist )
	else
		MISSDK_NPCSDK_LUA_000137 = GetResString("MISSDK_NPCSDK_LUA_000137")
		EXLG( "NpcSdk_error", MISSDK_NPCSDK_LUA_000137, usCmd )
		MISSDK_NPCSDK_LUA_000138 = GetResString("MISSDK_NPCSDK_LUA_000138")
		return SystemNotice( character, MISSDK_NPCSDK_LUA_000138 )
	end
end


function GiveHoe(role,npc)
	local r1 = 0
	local r2 = 0
	r1, r2 = MakeItem ( role , 3908  , 1 , 4 )		
	local Itemnew = GetChaItem ( role , 2 , r2 )
	
	SetItemAttr(Itemnew, ITEMATTR_URE, 10 )--当前存储经验
	SetItemAttr(Itemnew, ITEMATTR_MAXURE, 10 )--最高存储经验
	RefreshCha(role)
end

function CheckMetal(role,npc)
	local hoe_Count = CheckBagItem ( role , 3908 ) --检查锄头数量
	local hoe_temp = GetChaItem2 ( role , 2 , 3908 ) --取锄头对象
	local hoe_maxUre = GetItemAttr ( hoe_temp , ITEMATTR_MAXURE)
	
	if  hoe_Count ==1 then
		if hoe_maxUre <50 then
			SetItemAttr(hoe_temp,ITEMATTR_MAXURE,5000)
			SetItemAttr(hoe_temp,ITEMATTR_URE,5000)
			MISSDK_NPCSDK_LUA_000139 = GetResString("MISSDK_NPCSDK_LUA_000139")
			SystemNotice(role,MISSDK_NPCSDK_LUA_000139)
		else
			MISSDK_NPCSDK_LUA_000140 = GetResString("MISSDK_NPCSDK_LUA_000140")
			SystemNotice(role,MISSDK_NPCSDK_LUA_000140)
		end
	else
		MISSDK_NPCSDK_LUA_000141 = GetResString("MISSDK_NPCSDK_LUA_000141")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000141)
	end
	RefreshCha(role)
end

function PKPointToZero(role,npc)
	local PK_Count =  CheckBagItem ( role , 3849 ) --检查有没有荣誉之证
	local PK_Book = GetChaItem2 ( role , 2 , 3849 ) --取得荣誉之证对象
	
	if PK_Count >= 1 then
		SetItemAttr(PK_Book , ITEMATTR_MAXENERGY,0)
		MISSDK_NPCSDK_LUA_000142 = GetResString("MISSDK_NPCSDK_LUA_000142")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000142)
	else
		MISSDK_NPCSDK_LUA_000143 = GetResString("MISSDK_NPCSDK_LUA_000143")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000143)
	end
	RefreshCha(role)
end

function GoTosdBoss ( role, value )
	local br_x = {}
	local br_y = {}
	br_x[1] = {}
	br_x[2] = {}
	br_x[3] = {}
	br_x[4] = {}
	br_x[5] = {}
	br_y[1] = {}
	br_y[2] = {}
	br_y[3] = {}
	br_y[4] = {}
	br_y[5] = {}
	br_x[1][1] = 21
	br_x[1][2] = 98
	br_x[1][3] = 98
	br_x[1][4] = 21
	br_x[2][1] = 453
	br_x[2][2] = 530
	br_x[2][3] = 530
	br_x[2][4] = 453
	br_x[3][1] = 884
	br_x[3][2] = 961
	br_x[3][3] = 961
	br_x[3][4] = 884
	br_x[4][1] = 21
	br_x[4][2] = 98
	br_x[4][3] = 98
	br_x[4][4] = 21
	br_x[5][1] = 453
	br_x[5][2] = 530
	br_x[5][3] = 530
	br_x[5][4] = 453
	br_y[1][1] = 21
	br_y[1][2] = 21
	br_y[1][3] = 93
	br_y[1][4] = 93
	br_y[2][1] = 21
	br_y[2][2] = 21
	br_y[2][3] = 93
	br_y[2][4] = 93
	br_y[3][1] = 21
	br_y[3][2] = 21
	br_y[3][3] = 93
	br_y[3][4] = 93
	br_y[4][1] = 396
	br_y[4][2] = 396
	br_y[4][3] = 468
	br_y[4][4] = 468
	br_y[5][1] = 396
	br_y[5][2] = 396
	br_y[5][3] = 468
	br_y[5][4] = 468
	local n = math.random( 1 , 4 )
	GoTo( role, br_x[value][n] , br_y[value][n] , "sdBoss")
	return LUA_TRUE
end

QuesLab = {}
QuesLab.count = 0

function AddQues(des,type_ask,type_quit)
	QuesLab.count = QuesLab.count+1
	QuesLab[QuesLab.count] ={}
	QuesLab[QuesLab.count].count = 0
	QuesLab[QuesLab.count].des= des
	QuesLab[QuesLab.count].type_ask= type_ask
	QuesLab[QuesLab.count].type_quit= type_quit
end
function AddNextQues()
	QuesLab[QuesLab.count].count = QuesLab[QuesLab.count].count+1
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count]={}
end
function Ques(ques)
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].ques =ques
end
function InitChoose()
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose={}
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose.count = 0
end
function choose (choose)
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose.count = QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose.count+1
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose[QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose.count]= choose
end
function answer(answer)
	QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].answer = answer
	local i = 0
	local ret = 0
	for i = 1, QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose.count,1 do 
		if QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].answer ==QuesLab[QuesLab.count][QuesLab[QuesLab.count].count].choose[i] then 
			ret = 1 
			break
		end
	end
	if ret ~= 1 then 
		MISSDK_NPCSDK_LUA_000144 = GetResString("MISSDK_NPCSDK_LUA_000144")
		MISSDK_NPCSDK_LUA_000145 = GetResString("MISSDK_NPCSDK_LUA_000145")
		CALCULATE_FUNCTIONS_LUA_000503 = GetResString("CALCULATE_FUNCTIONS_LUA_000503")
		print(CALCULATE_FUNCTIONS_LUA_000503..QuesLab.count..MISSDK_NPCSDK_LUA_000145..QuesLab[QuesLab.count].count..MISSDK_NPCSDK_LUA_000144)
	end
end
function ChangeRingLv60Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 414 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )	
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 414 , 1)
			TakeItem( role , 0 , 6865 , 1)			
			GiveItem( role , 0 , 6618  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000147 = GetResString("MISSDK_NPCSDK_LUA_000147")
			Notice(name..MISSDK_NPCSDK_LUA_000147)
			MISSDK_NPCSDK_LUA_000148 = GetResString("MISSDK_NPCSDK_LUA_000148")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000148)
		elseif rand <= 6 then
			TakeItem( role , 0 , 414 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6625  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000150 = GetResString("MISSDK_NPCSDK_LUA_000150")
			Notice(name..MISSDK_NPCSDK_LUA_000150)
			MISSDK_NPCSDK_LUA_000151 = GetResString("MISSDK_NPCSDK_LUA_000151")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000151)
		elseif rand <= 46 then
			TakeItem( role , 0 , 414 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000152 = GetResString("MISSDK_NPCSDK_LUA_000152")
			Notice(name..MISSDK_NPCSDK_LUA_000152)
			MISSDK_NPCSDK_LUA_000153 = GetResString("MISSDK_NPCSDK_LUA_000153")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000153)
		elseif rand <= 76 then
			TakeItem( role , 0 , 414 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000154 = GetResString("MISSDK_NPCSDK_LUA_000154")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000154)
			MISSDK_NPCSDK_LUA_000155 = GetResString("MISSDK_NPCSDK_LUA_000155")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000155)
		else
			TakeItem( role , 0 , 414 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000156 = GetResString("MISSDK_NPCSDK_LUA_000156")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000156)
			MISSDK_NPCSDK_LUA_000157 = GetResString("MISSDK_NPCSDK_LUA_000157")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000157)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv60Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 387 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )	
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 387 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6618  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000147 = GetResString("MISSDK_NPCSDK_LUA_000147")
			Notice(name..MISSDK_NPCSDK_LUA_000147)
			MISSDK_NPCSDK_LUA_000159 = GetResString("MISSDK_NPCSDK_LUA_000159")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000159)
		elseif rand <= 55 then
			TakeItem( role , 0 , 387 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6625  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000150 = GetResString("MISSDK_NPCSDK_LUA_000150")
			Notice(name..MISSDK_NPCSDK_LUA_000150)
			MISSDK_NPCSDK_LUA_000160 = GetResString("MISSDK_NPCSDK_LUA_000160")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000160)
		elseif rand <= 75 then
			TakeItem( role , 0 , 387 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000152 = GetResString("MISSDK_NPCSDK_LUA_000152")
			Notice(name..MISSDK_NPCSDK_LUA_000152)
			MISSDK_NPCSDK_LUA_000161 = GetResString("MISSDK_NPCSDK_LUA_000161")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000161)
		elseif rand <= 90 then
			TakeItem( role , 0 , 387 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000154 = GetResString("MISSDK_NPCSDK_LUA_000154")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000154)
			MISSDK_NPCSDK_LUA_000162 = GetResString("MISSDK_NPCSDK_LUA_000162")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000162)
		else
			TakeItem( role , 0 , 387 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000156 = GetResString("MISSDK_NPCSDK_LUA_000156")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000156)
			MISSDK_NPCSDK_LUA_000163 = GetResString("MISSDK_NPCSDK_LUA_000163")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000163)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv60Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 415 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 415 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6618  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000147 = GetResString("MISSDK_NPCSDK_LUA_000147")
			Notice(name..MISSDK_NPCSDK_LUA_000147)
			MISSDK_NPCSDK_LUA_000164 = GetResString("MISSDK_NPCSDK_LUA_000164")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000164)
		elseif rand <= 5 then
			TakeItem( role , 0 , 415 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6625  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000150 = GetResString("MISSDK_NPCSDK_LUA_000150")
			Notice(name..MISSDK_NPCSDK_LUA_000150)
			MISSDK_NPCSDK_LUA_000165 = GetResString("MISSDK_NPCSDK_LUA_000165")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000165)
		elseif rand <= 40 then
			TakeItem( role , 0 , 415 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000152 = GetResString("MISSDK_NPCSDK_LUA_000152")
			Notice(name..MISSDK_NPCSDK_LUA_000152)
			MISSDK_NPCSDK_LUA_000166 = GetResString("MISSDK_NPCSDK_LUA_000166")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000166)
		elseif rand <= 70 then
			TakeItem( role , 0 , 415 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000154 = GetResString("MISSDK_NPCSDK_LUA_000154")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000154)
			MISSDK_NPCSDK_LUA_000167 = GetResString("MISSDK_NPCSDK_LUA_000167")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000167)
		else
			TakeItem( role , 0 , 415 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000156 = GetResString("MISSDK_NPCSDK_LUA_000156")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000156)
			MISSDK_NPCSDK_LUA_000168 = GetResString("MISSDK_NPCSDK_LUA_000168")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000168)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv60Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 416 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 416 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6618  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000147 = GetResString("MISSDK_NPCSDK_LUA_000147")
			Notice(name..MISSDK_NPCSDK_LUA_000147)
			MISSDK_NPCSDK_LUA_000169 = GetResString("MISSDK_NPCSDK_LUA_000169")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000169)
		elseif rand <= 40 then
			TakeItem( role , 0 , 416 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6625  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000150 = GetResString("MISSDK_NPCSDK_LUA_000150")
			Notice(name..MISSDK_NPCSDK_LUA_000150)
			MISSDK_NPCSDK_LUA_000170 = GetResString("MISSDK_NPCSDK_LUA_000170")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000170)
		elseif rand <= 70 then
			TakeItem( role , 0 , 416 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000152 = GetResString("MISSDK_NPCSDK_LUA_000152")
			Notice(name..MISSDK_NPCSDK_LUA_000152)
			MISSDK_NPCSDK_LUA_000171 = GetResString("MISSDK_NPCSDK_LUA_000171")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000171)
		elseif rand <= 90 then
			TakeItem( role , 0 , 416 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000154 = GetResString("MISSDK_NPCSDK_LUA_000154")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000154)
			MISSDK_NPCSDK_LUA_000172 = GetResString("MISSDK_NPCSDK_LUA_000172")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000172)
		else
			TakeItem( role , 0 , 416 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000156 = GetResString("MISSDK_NPCSDK_LUA_000156")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000156)
			MISSDK_NPCSDK_LUA_000173 = GetResString("MISSDK_NPCSDK_LUA_000173")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000173)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv60Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 417 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 417 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6618  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000147 = GetResString("MISSDK_NPCSDK_LUA_000147")
			Notice(name..MISSDK_NPCSDK_LUA_000147)
			MISSDK_NPCSDK_LUA_000174 = GetResString("MISSDK_NPCSDK_LUA_000174")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000174)
		elseif rand <= 15 then
			TakeItem( role , 0 , 417 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6625  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000150 = GetResString("MISSDK_NPCSDK_LUA_000150")
			Notice(name..MISSDK_NPCSDK_LUA_000150)
			MISSDK_NPCSDK_LUA_000175 = GetResString("MISSDK_NPCSDK_LUA_000175")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000175)
		elseif rand <= 65 then
			TakeItem( role , 0 , 417 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000152 = GetResString("MISSDK_NPCSDK_LUA_000152")
			Notice(name..MISSDK_NPCSDK_LUA_000152)
			MISSDK_NPCSDK_LUA_000176 = GetResString("MISSDK_NPCSDK_LUA_000176")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000176)
		elseif rand <= 85 then
			TakeItem( role , 0 , 417 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000154 = GetResString("MISSDK_NPCSDK_LUA_000154")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000154)
			MISSDK_NPCSDK_LUA_000177 = GetResString("MISSDK_NPCSDK_LUA_000177")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000177)
		else
			TakeItem( role , 0 , 417 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000156 = GetResString("MISSDK_NPCSDK_LUA_000156")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000156)
			MISSDK_NPCSDK_LUA_000178 = GetResString("MISSDK_NPCSDK_LUA_000178")
			MISSDK_NPCSDK_LUA_000149 = GetResString("MISSDK_NPCSDK_LUA_000149")
			LG(MISSDK_NPCSDK_LUA_000149,name..MISSDK_NPCSDK_LUA_000178)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv65Str_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6618 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )	
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6618 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000180 = GetResString("MISSDK_NPCSDK_LUA_000180")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000180)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6618 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000183 = GetResString("MISSDK_NPCSDK_LUA_000183")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000183)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6618 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000185 = GetResString("MISSDK_NPCSDK_LUA_000185")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000185)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6618 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000187 = GetResString("MISSDK_NPCSDK_LUA_000187")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000187)
		else
			TakeItem( role , 0 , 6618 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000189 = GetResString("MISSDK_NPCSDK_LUA_000189")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000189)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Str_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6621 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6621 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000190 = GetResString("MISSDK_NPCSDK_LUA_000190")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000190)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6621 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000191 = GetResString("MISSDK_NPCSDK_LUA_000191")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000191)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6621 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000192 = GetResString("MISSDK_NPCSDK_LUA_000192")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000192)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6621 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000193 = GetResString("MISSDK_NPCSDK_LUA_000193")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000193)
		else
			TakeItem( role , 0 , 6621 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000194 = GetResString("MISSDK_NPCSDK_LUA_000194")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000194)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv65Str_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6619 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6619 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000195 = GetResString("MISSDK_NPCSDK_LUA_000195")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000195)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6619 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000196 = GetResString("MISSDK_NPCSDK_LUA_000196")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000196)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6619 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000197 = GetResString("MISSDK_NPCSDK_LUA_000197")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000197)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6619 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000198 = GetResString("MISSDK_NPCSDK_LUA_000198")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000198)
		else
			TakeItem( role , 0 , 6619 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000199 = GetResString("MISSDK_NPCSDK_LUA_000199")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000199)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Str_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6620 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6620 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000200 = GetResString("MISSDK_NPCSDK_LUA_000200")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000200)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6620 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000201 = GetResString("MISSDK_NPCSDK_LUA_000201")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000201)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6620 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000202 = GetResString("MISSDK_NPCSDK_LUA_000202")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000202)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6620 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000203 = GetResString("MISSDK_NPCSDK_LUA_000203")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000203)
		else
			TakeItem( role , 0 , 6620 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000204 = GetResString("MISSDK_NPCSDK_LUA_000204")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000204)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Con_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6622 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6622 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000205 = GetResString("MISSDK_NPCSDK_LUA_000205")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000205)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6622 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000206 = GetResString("MISSDK_NPCSDK_LUA_000206")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000206)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6622 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000207 = GetResString("MISSDK_NPCSDK_LUA_000207")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000207)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6622 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000208 = GetResString("MISSDK_NPCSDK_LUA_000208")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000208)
		else
			TakeItem( role , 0 , 6622 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000209 = GetResString("MISSDK_NPCSDK_LUA_000209")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000209)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Con_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6623 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6623 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000210 = GetResString("MISSDK_NPCSDK_LUA_000210")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000210)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6623 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000211 = GetResString("MISSDK_NPCSDK_LUA_000211")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000211)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6623 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000212 = GetResString("MISSDK_NPCSDK_LUA_000212")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000212)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6623 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000213 = GetResString("MISSDK_NPCSDK_LUA_000213")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000213)
		else
			TakeItem( role , 0 , 6623 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000214 = GetResString("MISSDK_NPCSDK_LUA_000214")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000214)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Con_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6624 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6624 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000215 = GetResString("MISSDK_NPCSDK_LUA_000215")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000215)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6624 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000216 = GetResString("MISSDK_NPCSDK_LUA_000216")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000216)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6624 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000217 = GetResString("MISSDK_NPCSDK_LUA_000217")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000217)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6624 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000218 = GetResString("MISSDK_NPCSDK_LUA_000218")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000218)
		else
			TakeItem( role , 0 , 6624 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000219 = GetResString("MISSDK_NPCSDK_LUA_000219")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000219)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Con_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6625 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6625 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000220 = GetResString("MISSDK_NPCSDK_LUA_000220")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000220)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6625 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000221 = GetResString("MISSDK_NPCSDK_LUA_000221")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000221)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6625 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000222 = GetResString("MISSDK_NPCSDK_LUA_000222")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000222)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6625 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000223 = GetResString("MISSDK_NPCSDK_LUA_000223")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000223)
		else
			TakeItem( role , 0 , 6625 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000224 = GetResString("MISSDK_NPCSDK_LUA_000224")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000224)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Sta_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6630 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6630 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000225 = GetResString("MISSDK_NPCSDK_LUA_000225")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000225)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6630 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000226 = GetResString("MISSDK_NPCSDK_LUA_000226")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000226)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6630 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000227 = GetResString("MISSDK_NPCSDK_LUA_000227")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000227)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6630 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000228 = GetResString("MISSDK_NPCSDK_LUA_000228")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000228)
		else
			TakeItem( role , 0 , 6630 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000229 = GetResString("MISSDK_NPCSDK_LUA_000229")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000229)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Sta_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6631 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6631 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000230 = GetResString("MISSDK_NPCSDK_LUA_000230")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000230)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6631 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000231 = GetResString("MISSDK_NPCSDK_LUA_000231")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000231)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6631 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000232 = GetResString("MISSDK_NPCSDK_LUA_000232")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000232)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6631 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000233 = GetResString("MISSDK_NPCSDK_LUA_000233")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000233)
		else
			TakeItem( role , 0 , 6631 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000234 = GetResString("MISSDK_NPCSDK_LUA_000234")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000234)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Sta_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6632 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6632 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000235 = GetResString("MISSDK_NPCSDK_LUA_000235")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000235)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6632 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000236 = GetResString("MISSDK_NPCSDK_LUA_000236")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000236)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6632 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000237 = GetResString("MISSDK_NPCSDK_LUA_000237")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000237)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6632 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000238 = GetResString("MISSDK_NPCSDK_LUA_000238")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000238)
		else
			TakeItem( role , 0 , 6632 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000239 = GetResString("MISSDK_NPCSDK_LUA_000239")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000239)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Sta_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6633 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6633 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000240 = GetResString("MISSDK_NPCSDK_LUA_000240")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000240)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6633 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000241 = GetResString("MISSDK_NPCSDK_LUA_000241")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000241)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6633 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000242 = GetResString("MISSDK_NPCSDK_LUA_000242")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000242)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6633 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000243 = GetResString("MISSDK_NPCSDK_LUA_000243")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000243)
		else
			TakeItem( role , 0 , 6633 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000244 = GetResString("MISSDK_NPCSDK_LUA_000244")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000244)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Agi_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6626 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6626 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000245 = GetResString("MISSDK_NPCSDK_LUA_000245")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000245)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6626 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000246 = GetResString("MISSDK_NPCSDK_LUA_000246")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000246)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6626 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000247 = GetResString("MISSDK_NPCSDK_LUA_000247")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000247)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6626 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000248 = GetResString("MISSDK_NPCSDK_LUA_000248")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000248)
		else
			TakeItem( role , 0 , 6626 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000249 = GetResString("MISSDK_NPCSDK_LUA_000249")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000249)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Agi_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6627 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6627 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000250 = GetResString("MISSDK_NPCSDK_LUA_000250")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000250)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6627 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000251 = GetResString("MISSDK_NPCSDK_LUA_000251")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000251)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6627 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000252 = GetResString("MISSDK_NPCSDK_LUA_000252")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000252)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6627 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000253 = GetResString("MISSDK_NPCSDK_LUA_000253")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000253)
		else
			TakeItem( role , 0 , 6627 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000254 = GetResString("MISSDK_NPCSDK_LUA_000254")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000254)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Agi_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6628 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )	
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6628 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000255 = GetResString("MISSDK_NPCSDK_LUA_000255")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000255)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6628 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000256 = GetResString("MISSDK_NPCSDK_LUA_000256")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000256)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6628 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000257 = GetResString("MISSDK_NPCSDK_LUA_000257")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000257)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6628 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000258 = GetResString("MISSDK_NPCSDK_LUA_000258")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000258)
		else
			TakeItem( role , 0 , 6628 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000259 = GetResString("MISSDK_NPCSDK_LUA_000259")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000259)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Agi_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6629 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6629 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000260 = GetResString("MISSDK_NPCSDK_LUA_000260")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000260)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6629 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000261 = GetResString("MISSDK_NPCSDK_LUA_000261")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000261)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6629 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000262 = GetResString("MISSDK_NPCSDK_LUA_000262")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000262)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6629 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000263 = GetResString("MISSDK_NPCSDK_LUA_000263")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000263)
		else
			TakeItem( role , 0 , 6629 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000264 = GetResString("MISSDK_NPCSDK_LUA_000264")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000264)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Dex_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6634 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6634 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000265 = GetResString("MISSDK_NPCSDK_LUA_000265")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000265)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6634 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000266 = GetResString("MISSDK_NPCSDK_LUA_000266")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000266)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6634 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000267 = GetResString("MISSDK_NPCSDK_LUA_000267")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000267)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6634 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000268 = GetResString("MISSDK_NPCSDK_LUA_000268")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000268)
		else
			TakeItem( role , 0 , 6634 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000269 = GetResString("MISSDK_NPCSDK_LUA_000269")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000269)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Dex_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6635 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6635 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000270 = GetResString("MISSDK_NPCSDK_LUA_000270")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000270)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6635 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000271 = GetResString("MISSDK_NPCSDK_LUA_000271")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000271)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6635 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000272 = GetResString("MISSDK_NPCSDK_LUA_000272")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000272)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6635 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000273 = GetResString("MISSDK_NPCSDK_LUA_000273")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000273)
		else
			TakeItem( role , 0 , 6635 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000274 = GetResString("MISSDK_NPCSDK_LUA_000274")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000274)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Dex_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6636 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6636 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000275 = GetResString("MISSDK_NPCSDK_LUA_000275")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000275)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6636 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000276 = GetResString("MISSDK_NPCSDK_LUA_000276")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000276)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6636 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000277 = GetResString("MISSDK_NPCSDK_LUA_000277")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000277)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6636 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000278 = GetResString("MISSDK_NPCSDK_LUA_000278")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000278)
		else
			TakeItem( role , 0 , 6636 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000279 = GetResString("MISSDK_NPCSDK_LUA_000279")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000279)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv65Dex_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6637 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6637 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1112  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000179 = GetResString("MISSDK_NPCSDK_LUA_000179")
			Notice(name..MISSDK_NPCSDK_LUA_000179)
			MISSDK_NPCSDK_LUA_000280 = GetResString("MISSDK_NPCSDK_LUA_000280")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000280)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6637 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1862  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000182 = GetResString("MISSDK_NPCSDK_LUA_000182")
			Notice(name..MISSDK_NPCSDK_LUA_000182)
			MISSDK_NPCSDK_LUA_000281 = GetResString("MISSDK_NPCSDK_LUA_000281")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000281)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6637 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000184 = GetResString("MISSDK_NPCSDK_LUA_000184")
			Notice(name..MISSDK_NPCSDK_LUA_000184)
			MISSDK_NPCSDK_LUA_000282 = GetResString("MISSDK_NPCSDK_LUA_000282")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000282)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6637 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000186 = GetResString("MISSDK_NPCSDK_LUA_000186")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000186)
			MISSDK_NPCSDK_LUA_000283 = GetResString("MISSDK_NPCSDK_LUA_000283")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000283)
		else
			TakeItem( role , 0 , 6637 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000188 = GetResString("MISSDK_NPCSDK_LUA_000188")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000188)
			MISSDK_NPCSDK_LUA_000284 = GetResString("MISSDK_NPCSDK_LUA_000284")
			MISSDK_NPCSDK_LUA_000181 = GetResString("MISSDK_NPCSDK_LUA_000181")
			LG(MISSDK_NPCSDK_LUA_000181,name..MISSDK_NPCSDK_LUA_000284)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv70Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 1114 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1114 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6638  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000285 = GetResString("MISSDK_NPCSDK_LUA_000285")
			Notice(name..MISSDK_NPCSDK_LUA_000285)
			MISSDK_NPCSDK_LUA_000286 = GetResString("MISSDK_NPCSDK_LUA_000286")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000286)
		elseif rand <= 5 then
			TakeItem( role , 0 , 1114 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6646  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000288 = GetResString("MISSDK_NPCSDK_LUA_000288")
			Notice(name..MISSDK_NPCSDK_LUA_000288)
			MISSDK_NPCSDK_LUA_000289 = GetResString("MISSDK_NPCSDK_LUA_000289")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000289)
		elseif rand <= 40 then
			TakeItem( role , 0 , 1114 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000290 = GetResString("MISSDK_NPCSDK_LUA_000290")
			Notice(name..MISSDK_NPCSDK_LUA_000290)
			MISSDK_NPCSDK_LUA_000291 = GetResString("MISSDK_NPCSDK_LUA_000291")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000291)
		elseif rand <= 70 then
			TakeItem( role , 0 , 1114 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000292 = GetResString("MISSDK_NPCSDK_LUA_000292")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000292)
			MISSDK_NPCSDK_LUA_000293 = GetResString("MISSDK_NPCSDK_LUA_000293")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000293)
		else
			TakeItem( role , 0 , 1114 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000294 = GetResString("MISSDK_NPCSDK_LUA_000294")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000294)
			MISSDK_NPCSDK_LUA_000295 = GetResString("MISSDK_NPCSDK_LUA_000295")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000295)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv70Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 1112 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 1112 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6638  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000285 = GetResString("MISSDK_NPCSDK_LUA_000285")
			Notice(name..MISSDK_NPCSDK_LUA_000285)
			MISSDK_NPCSDK_LUA_000296 = GetResString("MISSDK_NPCSDK_LUA_000296")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000296)
		elseif rand <= 55 then
			TakeItem( role , 0 , 1112 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6646  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000288 = GetResString("MISSDK_NPCSDK_LUA_000288")
			Notice(name..MISSDK_NPCSDK_LUA_000288)
			MISSDK_NPCSDK_LUA_000297 = GetResString("MISSDK_NPCSDK_LUA_000297")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000297)
		elseif rand <= 75 then
			TakeItem( role , 0 , 1112 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000290 = GetResString("MISSDK_NPCSDK_LUA_000290")
			Notice(name..MISSDK_NPCSDK_LUA_000290)
			MISSDK_NPCSDK_LUA_000298 = GetResString("MISSDK_NPCSDK_LUA_000298")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000298)
		elseif rand <= 90 then
			TakeItem( role , 0 , 1112 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000292 = GetResString("MISSDK_NPCSDK_LUA_000292")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000292)
			MISSDK_NPCSDK_LUA_000299 = GetResString("MISSDK_NPCSDK_LUA_000299")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000299)
		else
			TakeItem( role , 0 , 1112 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000294 = GetResString("MISSDK_NPCSDK_LUA_000294")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000294)
			MISSDK_NPCSDK_LUA_000300 = GetResString("MISSDK_NPCSDK_LUA_000300")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000300)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv70Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 1113 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1113 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6638  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000285 = GetResString("MISSDK_NPCSDK_LUA_000285")
			Notice(name..MISSDK_NPCSDK_LUA_000285)
			MISSDK_NPCSDK_LUA_000301 = GetResString("MISSDK_NPCSDK_LUA_000301")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000301)
		elseif rand <= 6 then
			TakeItem( role , 0 , 1113 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6646  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000288 = GetResString("MISSDK_NPCSDK_LUA_000288")
			Notice(name..MISSDK_NPCSDK_LUA_000288)
			MISSDK_NPCSDK_LUA_000302 = GetResString("MISSDK_NPCSDK_LUA_000302")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000302)
		elseif rand <= 46 then
			TakeItem( role , 0 , 1113 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000290 = GetResString("MISSDK_NPCSDK_LUA_000290")
			Notice(name..MISSDK_NPCSDK_LUA_000290)
			MISSDK_NPCSDK_LUA_000303 = GetResString("MISSDK_NPCSDK_LUA_000303")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000303)
		elseif rand <= 76 then
			TakeItem( role , 0 , 1113 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000292 = GetResString("MISSDK_NPCSDK_LUA_000292")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000292)
			MISSDK_NPCSDK_LUA_000304 = GetResString("MISSDK_NPCSDK_LUA_000304")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000304)
		else
			TakeItem( role , 0 , 1113 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000294 = GetResString("MISSDK_NPCSDK_LUA_000294")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000294)
			MISSDK_NPCSDK_LUA_000305 = GetResString("MISSDK_NPCSDK_LUA_000305")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000305)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv70Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 1862 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 1862 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6638  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000285 = GetResString("MISSDK_NPCSDK_LUA_000285")
			Notice(name..MISSDK_NPCSDK_LUA_000285)
			MISSDK_NPCSDK_LUA_000306 = GetResString("MISSDK_NPCSDK_LUA_000306")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000306)
		elseif rand <= 40 then
			TakeItem( role , 0 , 1862 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6646  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000288 = GetResString("MISSDK_NPCSDK_LUA_000288")
			Notice(name..MISSDK_NPCSDK_LUA_000288)
			MISSDK_NPCSDK_LUA_000307 = GetResString("MISSDK_NPCSDK_LUA_000307")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000307)
		elseif rand <= 70 then
			TakeItem( role , 0 , 1862 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000290 = GetResString("MISSDK_NPCSDK_LUA_000290")
			Notice(name..MISSDK_NPCSDK_LUA_000290)
			MISSDK_NPCSDK_LUA_000308 = GetResString("MISSDK_NPCSDK_LUA_000308")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000308)
		elseif rand <= 90 then
			TakeItem( role , 0 , 1862 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000292 = GetResString("MISSDK_NPCSDK_LUA_000292")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000292)
			MISSDK_NPCSDK_LUA_000309 = GetResString("MISSDK_NPCSDK_LUA_000309")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000309)
		else
			TakeItem( role , 0 , 1862 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000294 = GetResString("MISSDK_NPCSDK_LUA_000294")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000294)
			MISSDK_NPCSDK_LUA_000310 = GetResString("MISSDK_NPCSDK_LUA_000310")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000310)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv70Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 2209 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 2209 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6638  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000285 = GetResString("MISSDK_NPCSDK_LUA_000285")
			Notice(name..MISSDK_NPCSDK_LUA_000285)
			MISSDK_NPCSDK_LUA_000311 = GetResString("MISSDK_NPCSDK_LUA_000311")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000311)
		elseif rand <= 15 then
			TakeItem( role , 0 , 2209 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6646  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000288 = GetResString("MISSDK_NPCSDK_LUA_000288")
			Notice(name..MISSDK_NPCSDK_LUA_000288)
			MISSDK_NPCSDK_LUA_000312 = GetResString("MISSDK_NPCSDK_LUA_000312")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000312)
		elseif rand <= 65 then
			TakeItem( role , 0 , 2209 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000290 = GetResString("MISSDK_NPCSDK_LUA_000290")
			Notice(name..MISSDK_NPCSDK_LUA_000290)
			MISSDK_NPCSDK_LUA_000313 = GetResString("MISSDK_NPCSDK_LUA_000313")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000313)
		elseif rand <= 85 then
			TakeItem( role , 0 , 2209 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000292 = GetResString("MISSDK_NPCSDK_LUA_000292")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000292)
			MISSDK_NPCSDK_LUA_000314 = GetResString("MISSDK_NPCSDK_LUA_000314")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000314)
		else
			TakeItem( role , 0 , 2209 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000294 = GetResString("MISSDK_NPCSDK_LUA_000294")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000294)
			MISSDK_NPCSDK_LUA_000315 = GetResString("MISSDK_NPCSDK_LUA_000315")
			MISSDK_NPCSDK_LUA_000287 = GetResString("MISSDK_NPCSDK_LUA_000287")
			LG(MISSDK_NPCSDK_LUA_000287,name..MISSDK_NPCSDK_LUA_000315)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv75Str_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6638 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6638 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000317 = GetResString("MISSDK_NPCSDK_LUA_000317")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000317)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6638 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000320 = GetResString("MISSDK_NPCSDK_LUA_000320")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000320)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6638 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000322 = GetResString("MISSDK_NPCSDK_LUA_000322")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000322)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6638 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000324 = GetResString("MISSDK_NPCSDK_LUA_000324")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000324)
		else
			TakeItem( role , 0 , 6638 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000326 = GetResString("MISSDK_NPCSDK_LUA_000326")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000326)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Str_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6641 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6641 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000327 = GetResString("MISSDK_NPCSDK_LUA_000327")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000327)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6641 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000328 = GetResString("MISSDK_NPCSDK_LUA_000328")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000328)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6641 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000329 = GetResString("MISSDK_NPCSDK_LUA_000329")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000329)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6641 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000330 = GetResString("MISSDK_NPCSDK_LUA_000330")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000330)
		else
			TakeItem( role , 0 , 6641 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000331 = GetResString("MISSDK_NPCSDK_LUA_000331")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000331)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv75Str_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6639 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6639 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000332 = GetResString("MISSDK_NPCSDK_LUA_000332")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000332)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6639 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000333 = GetResString("MISSDK_NPCSDK_LUA_000333")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000333)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6639 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000334 = GetResString("MISSDK_NPCSDK_LUA_000334")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000334)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6639 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000335 = GetResString("MISSDK_NPCSDK_LUA_000335")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000335)
		else
			TakeItem( role , 0 , 6639 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000336 = GetResString("MISSDK_NPCSDK_LUA_000336")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000336)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Str_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6640 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 6640 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000337 = GetResString("MISSDK_NPCSDK_LUA_000337")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000337)
		elseif rand <= 55 then
			TakeItem( role , 0 , 6640 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000338 = GetResString("MISSDK_NPCSDK_LUA_000338")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000338)
		elseif rand <= 75 then
			TakeItem( role , 0 , 6640 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000339 = GetResString("MISSDK_NPCSDK_LUA_000339")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000339)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6640 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000340 = GetResString("MISSDK_NPCSDK_LUA_000340")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000340)
		else
			TakeItem( role , 0 , 6640 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000341 = GetResString("MISSDK_NPCSDK_LUA_000341")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000341)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Con_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6643 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6643 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000342 = GetResString("MISSDK_NPCSDK_LUA_000342")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000342)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6643 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000343 = GetResString("MISSDK_NPCSDK_LUA_000343")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000343)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6643 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000344 = GetResString("MISSDK_NPCSDK_LUA_000344")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000344)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6643 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000345 = GetResString("MISSDK_NPCSDK_LUA_000345")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000345)
		else
			TakeItem( role , 0 , 6643 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000346 = GetResString("MISSDK_NPCSDK_LUA_000346")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000346)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Con_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6644 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6644 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000347 = GetResString("MISSDK_NPCSDK_LUA_000347")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000347)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6644 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000348 = GetResString("MISSDK_NPCSDK_LUA_000348")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000348)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6644 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000349 = GetResString("MISSDK_NPCSDK_LUA_000349")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000349)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6644 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000350 = GetResString("MISSDK_NPCSDK_LUA_000350")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000350)
		else
			TakeItem( role , 0 , 6644 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000351 = GetResString("MISSDK_NPCSDK_LUA_000351")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000351)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Con_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6645 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6645 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000352 = GetResString("MISSDK_NPCSDK_LUA_000352")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000352)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6645 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000353 = GetResString("MISSDK_NPCSDK_LUA_000353")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000353)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6645 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000354 = GetResString("MISSDK_NPCSDK_LUA_000354")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000354)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6645 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000355 = GetResString("MISSDK_NPCSDK_LUA_000355")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000355)
		else
			TakeItem( role , 0 , 6645 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000356 = GetResString("MISSDK_NPCSDK_LUA_000356")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000356)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Con_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6646 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 6646 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000357 = GetResString("MISSDK_NPCSDK_LUA_000357")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000357)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6646 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000358 = GetResString("MISSDK_NPCSDK_LUA_000358")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000358)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6646 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000359 = GetResString("MISSDK_NPCSDK_LUA_000359")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000359)
		elseif rand <= 90 then
			TakeItem( role , 0 , 6646 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000360 = GetResString("MISSDK_NPCSDK_LUA_000360")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000360)
		else
			TakeItem( role , 0 , 6646 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000361 = GetResString("MISSDK_NPCSDK_LUA_000361")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000361)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Sta_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6653 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6653 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000362 = GetResString("MISSDK_NPCSDK_LUA_000362")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000362)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6653 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000363 = GetResString("MISSDK_NPCSDK_LUA_000363")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000363)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6653 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000364 = GetResString("MISSDK_NPCSDK_LUA_000364")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000364)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6653 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000365 = GetResString("MISSDK_NPCSDK_LUA_000365")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000365)
		else
			TakeItem( role , 0 , 6653 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000366 = GetResString("MISSDK_NPCSDK_LUA_000366")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000366)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Sta_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6654 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6654 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000367 = GetResString("MISSDK_NPCSDK_LUA_000367")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000367)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6654 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000368 = GetResString("MISSDK_NPCSDK_LUA_000368")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000368)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6654 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000369 = GetResString("MISSDK_NPCSDK_LUA_000369")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000369)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6654 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000370 = GetResString("MISSDK_NPCSDK_LUA_000370")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000370)
		else
			TakeItem( role , 0 , 6654 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000371 = GetResString("MISSDK_NPCSDK_LUA_000371")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000371)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Sta_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6655 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6655 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000372 = GetResString("MISSDK_NPCSDK_LUA_000372")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000372)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6655 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000373 = GetResString("MISSDK_NPCSDK_LUA_000373")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000373)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6655 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000374 = GetResString("MISSDK_NPCSDK_LUA_000374")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000374)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6655 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000375 = GetResString("MISSDK_NPCSDK_LUA_000375")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000375)
		else
			TakeItem( role , 0 , 6655 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000376 = GetResString("MISSDK_NPCSDK_LUA_000376")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000376)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Sta_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6656 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 6656 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000377 = GetResString("MISSDK_NPCSDK_LUA_000377")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000377)
		elseif rand <= 15 then
			TakeItem( role , 0 , 6656 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000378 = GetResString("MISSDK_NPCSDK_LUA_000378")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000378)
		elseif rand <= 65 then
			TakeItem( role , 0 , 6656 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000379 = GetResString("MISSDK_NPCSDK_LUA_000379")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000379)
		elseif rand <= 85 then
			TakeItem( role , 0 , 6656 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000380 = GetResString("MISSDK_NPCSDK_LUA_000380")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000380)
		else
			TakeItem( role , 0 , 6656 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000381 = GetResString("MISSDK_NPCSDK_LUA_000381")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000381)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Agi_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6648 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6648 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000382 = GetResString("MISSDK_NPCSDK_LUA_000382")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000382)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6648 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000383 = GetResString("MISSDK_NPCSDK_LUA_000383")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000383)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6648 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000384 = GetResString("MISSDK_NPCSDK_LUA_000384")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000384)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6648 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000385 = GetResString("MISSDK_NPCSDK_LUA_000385")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000385)
		else
			TakeItem( role , 0 , 6648 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000386 = GetResString("MISSDK_NPCSDK_LUA_000386")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000386)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Agi_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6649 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6649 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000387 = GetResString("MISSDK_NPCSDK_LUA_000387")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000387)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6649 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000388 = GetResString("MISSDK_NPCSDK_LUA_000388")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000388)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6649 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000389 = GetResString("MISSDK_NPCSDK_LUA_000389")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000389)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6649 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000390 = GetResString("MISSDK_NPCSDK_LUA_000390")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000390)
		else
			TakeItem( role , 0 , 6649 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000391 = GetResString("MISSDK_NPCSDK_LUA_000391")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000391)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Agi_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6650 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6650 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000392 = GetResString("MISSDK_NPCSDK_LUA_000392")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000392)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6650 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000393 = GetResString("MISSDK_NPCSDK_LUA_000393")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000393)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6650 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000394 = GetResString("MISSDK_NPCSDK_LUA_000394")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000394)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6650 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000395 = GetResString("MISSDK_NPCSDK_LUA_000395")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000395)
		else
			TakeItem( role , 0 , 6650 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000396 = GetResString("MISSDK_NPCSDK_LUA_000396")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000396)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Agi_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6651 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6651 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000397 = GetResString("MISSDK_NPCSDK_LUA_000397")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000397)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6651 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000398 = GetResString("MISSDK_NPCSDK_LUA_000398")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000398)
		elseif rand <= 40 then
			TakeItem( role , 0 , 6651 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000399 = GetResString("MISSDK_NPCSDK_LUA_000399")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000399)
		elseif rand <= 70 then
			TakeItem( role , 0 , 6651 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000400 = GetResString("MISSDK_NPCSDK_LUA_000400")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000400)
		else
			TakeItem( role , 0 , 6651 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000401 = GetResString("MISSDK_NPCSDK_LUA_000401")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000401)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Dex_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6658 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6658 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000402 = GetResString("MISSDK_NPCSDK_LUA_000402")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000402)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6658 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000403 = GetResString("MISSDK_NPCSDK_LUA_000403")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000403)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6658 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000404 = GetResString("MISSDK_NPCSDK_LUA_000404")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000404)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6658 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000405 = GetResString("MISSDK_NPCSDK_LUA_000405")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000405)
		else
			TakeItem( role , 0 , 6658 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000406 = GetResString("MISSDK_NPCSDK_LUA_000406")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000406)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Dex_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6659 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6659 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000407 = GetResString("MISSDK_NPCSDK_LUA_000407")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000407)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6659 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000408 = GetResString("MISSDK_NPCSDK_LUA_000408")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000408)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6659 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000409 = GetResString("MISSDK_NPCSDK_LUA_000409")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000409)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6659 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000410 = GetResString("MISSDK_NPCSDK_LUA_000410")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000410)
		else
			TakeItem( role , 0 , 6659 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000411 = GetResString("MISSDK_NPCSDK_LUA_000411")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000411)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Dex_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6660 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6660 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000412 = GetResString("MISSDK_NPCSDK_LUA_000412")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000412)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6660 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000413 = GetResString("MISSDK_NPCSDK_LUA_000413")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000413)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6660 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000414 = GetResString("MISSDK_NPCSDK_LUA_000414")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000414)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6660 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000415 = GetResString("MISSDK_NPCSDK_LUA_000415")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000415)
		else
			TakeItem( role , 0 , 6660 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000416 = GetResString("MISSDK_NPCSDK_LUA_000416")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000416)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv75Dex_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6661 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6661 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2317  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000316 = GetResString("MISSDK_NPCSDK_LUA_000316")
			Notice(name..MISSDK_NPCSDK_LUA_000316)
			MISSDK_NPCSDK_LUA_000417 = GetResString("MISSDK_NPCSDK_LUA_000417")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000417)
		elseif rand <= 6 then
			TakeItem( role , 0 , 6661 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2320  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000319 = GetResString("MISSDK_NPCSDK_LUA_000319")
			Notice(name..MISSDK_NPCSDK_LUA_000319)
			MISSDK_NPCSDK_LUA_000418 = GetResString("MISSDK_NPCSDK_LUA_000418")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000418)
		elseif rand <= 46 then
			TakeItem( role , 0 , 6661 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000321 = GetResString("MISSDK_NPCSDK_LUA_000321")
			Notice(name..MISSDK_NPCSDK_LUA_000321)
			MISSDK_NPCSDK_LUA_000419 = GetResString("MISSDK_NPCSDK_LUA_000419")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000419)
		elseif rand <= 76 then
			TakeItem( role , 0 , 6661 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000323 = GetResString("MISSDK_NPCSDK_LUA_000323")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000323)
			MISSDK_NPCSDK_LUA_000420 = GetResString("MISSDK_NPCSDK_LUA_000420")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000420)
		else
			TakeItem( role , 0 , 6661 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000325 = GetResString("MISSDK_NPCSDK_LUA_000325")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000325)
			MISSDK_NPCSDK_LUA_000421 = GetResString("MISSDK_NPCSDK_LUA_000421")
			MISSDK_NPCSDK_LUA_000318 = GetResString("MISSDK_NPCSDK_LUA_000318")
			LG(MISSDK_NPCSDK_LUA_000318,name..MISSDK_NPCSDK_LUA_000421)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function ChangeRingLv80Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 2319 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2319 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2398  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000422 = GetResString("MISSDK_NPCSDK_LUA_000422")
			Notice(name..MISSDK_NPCSDK_LUA_000422)
			MISSDK_NPCSDK_LUA_000423 = GetResString("MISSDK_NPCSDK_LUA_000423")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000423)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2319 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2401  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000425 = GetResString("MISSDK_NPCSDK_LUA_000425")
			Notice(name..MISSDK_NPCSDK_LUA_000425)
			MISSDK_NPCSDK_LUA_000426 = GetResString("MISSDK_NPCSDK_LUA_000426")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000426)
		elseif rand <= 40 then
			TakeItem( role , 0 , 2319 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2402  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000427 = GetResString("MISSDK_NPCSDK_LUA_000427")
			Notice(name..MISSDK_NPCSDK_LUA_000427)
			MISSDK_NPCSDK_LUA_000428 = GetResString("MISSDK_NPCSDK_LUA_000428")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000428)
		elseif rand <= 70 then
			TakeItem( role , 0 , 2319 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2399  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000429 = GetResString("MISSDK_NPCSDK_LUA_000429")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000429)
			MISSDK_NPCSDK_LUA_000430 = GetResString("MISSDK_NPCSDK_LUA_000430")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000430)
		else
			TakeItem( role , 0 , 2319 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2400  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000431 = GetResString("MISSDK_NPCSDK_LUA_000431")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000431)
			MISSDK_NPCSDK_LUA_000432 = GetResString("MISSDK_NPCSDK_LUA_000432")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000432)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv80Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 2317 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 30 then
			TakeItem( role , 0 , 2317 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2398  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000422 = GetResString("MISSDK_NPCSDK_LUA_000422")
			Notice(name..MISSDK_NPCSDK_LUA_000422)
			MISSDK_NPCSDK_LUA_000433 = GetResString("MISSDK_NPCSDK_LUA_000433")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000433)
		elseif rand <= 55 then
			TakeItem( role , 0 , 2317 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2401  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000425 = GetResString("MISSDK_NPCSDK_LUA_000425")
			Notice(name..MISSDK_NPCSDK_LUA_000425)
			MISSDK_NPCSDK_LUA_000434 = GetResString("MISSDK_NPCSDK_LUA_000434")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000434)
		elseif rand <= 75 then
			TakeItem( role , 0 , 2317 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2402  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000427 = GetResString("MISSDK_NPCSDK_LUA_000427")
			Notice(name..MISSDK_NPCSDK_LUA_000427)
			MISSDK_NPCSDK_LUA_000435 = GetResString("MISSDK_NPCSDK_LUA_000435")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000435)
		elseif rand <= 90 then
			TakeItem( role , 0 , 2317 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2399  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000429 = GetResString("MISSDK_NPCSDK_LUA_000429")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000429)
			MISSDK_NPCSDK_LUA_000436 = GetResString("MISSDK_NPCSDK_LUA_000436")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000436)
		else
			TakeItem( role , 0 , 2317 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2400  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000431 = GetResString("MISSDK_NPCSDK_LUA_000431")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000431)
			MISSDK_NPCSDK_LUA_000437 = GetResString("MISSDK_NPCSDK_LUA_000437")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000437)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv80Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 2318 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2318 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2398  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000422 = GetResString("MISSDK_NPCSDK_LUA_000422")
			Notice(name..MISSDK_NPCSDK_LUA_000422)
			MISSDK_NPCSDK_LUA_000438 = GetResString("MISSDK_NPCSDK_LUA_000438")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000438)
		elseif rand <= 6 then
			TakeItem( role , 0 , 2318 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2401  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000425 = GetResString("MISSDK_NPCSDK_LUA_000425")
			Notice(name..MISSDK_NPCSDK_LUA_000425)
			MISSDK_NPCSDK_LUA_000439 = GetResString("MISSDK_NPCSDK_LUA_000439")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000439)
		elseif rand <= 46 then
			TakeItem( role , 0 , 2318 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2402  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000427 = GetResString("MISSDK_NPCSDK_LUA_000427")
			Notice(name..MISSDK_NPCSDK_LUA_000427)
			MISSDK_NPCSDK_LUA_000440 = GetResString("MISSDK_NPCSDK_LUA_000440")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000440)
		elseif rand <= 76 then
			TakeItem( role , 0 , 2318 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2399  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000429 = GetResString("MISSDK_NPCSDK_LUA_000429")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000429)
			MISSDK_NPCSDK_LUA_000441 = GetResString("MISSDK_NPCSDK_LUA_000441")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000441)
		else
			TakeItem( role , 0 , 2318 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2400  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000431 = GetResString("MISSDK_NPCSDK_LUA_000431")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000431)
			MISSDK_NPCSDK_LUA_000442 = GetResString("MISSDK_NPCSDK_LUA_000442")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000442)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv80Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 2320 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 10 then
			TakeItem( role , 0 , 2320 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2398  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000422 = GetResString("MISSDK_NPCSDK_LUA_000422")
			Notice(name..MISSDK_NPCSDK_LUA_000422)
			MISSDK_NPCSDK_LUA_000443 = GetResString("MISSDK_NPCSDK_LUA_000443")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000443)
		elseif rand <= 40 then
			TakeItem( role , 0 , 2320 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2401  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000425 = GetResString("MISSDK_NPCSDK_LUA_000425")
			Notice(name..MISSDK_NPCSDK_LUA_000425)
			MISSDK_NPCSDK_LUA_000444 = GetResString("MISSDK_NPCSDK_LUA_000444")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000444)
		elseif rand <= 70 then
			TakeItem( role , 0 , 2320 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2402  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000427 = GetResString("MISSDK_NPCSDK_LUA_000427")
			Notice(name..MISSDK_NPCSDK_LUA_000427)
			MISSDK_NPCSDK_LUA_000445 = GetResString("MISSDK_NPCSDK_LUA_000445")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000445)
		elseif rand <= 90 then
			TakeItem( role , 0 , 2320 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2399  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000429 = GetResString("MISSDK_NPCSDK_LUA_000429")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000429)
			MISSDK_NPCSDK_LUA_000446 = GetResString("MISSDK_NPCSDK_LUA_000446")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000446)
		else
			TakeItem( role , 0 , 2320 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2400  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000431 = GetResString("MISSDK_NPCSDK_LUA_000431")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000431)
			MISSDK_NPCSDK_LUA_000447 = GetResString("MISSDK_NPCSDK_LUA_000447")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000447)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function ChangeRingLv80Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 2321 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 100 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end
	local Xukezheng_Count = CheckBagItem ( role , 6865 ) --检查饰品加工许可证数量
	if Xukezheng_Count == 0 then
		MISSDK_NPCSDK_LUA_000146 = GetResString("MISSDK_NPCSDK_LUA_000146")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000146)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 5 then
			TakeItem( role , 0 , 2321 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2398  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000422 = GetResString("MISSDK_NPCSDK_LUA_000422")
			Notice(name..MISSDK_NPCSDK_LUA_000422)
			MISSDK_NPCSDK_LUA_000448 = GetResString("MISSDK_NPCSDK_LUA_000448")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000448)
		elseif rand <= 15 then
			TakeItem( role , 0 , 2321 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2401  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000425 = GetResString("MISSDK_NPCSDK_LUA_000425")
			Notice(name..MISSDK_NPCSDK_LUA_000425)
			MISSDK_NPCSDK_LUA_000449 = GetResString("MISSDK_NPCSDK_LUA_000449")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000449)
		elseif rand <= 65 then
			TakeItem( role , 0 , 2321 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2402  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000427 = GetResString("MISSDK_NPCSDK_LUA_000427")
			Notice(name..MISSDK_NPCSDK_LUA_000427)
			MISSDK_NPCSDK_LUA_000450 = GetResString("MISSDK_NPCSDK_LUA_000450")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000450)
		elseif rand <= 85 then
			TakeItem( role , 0 , 2321 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2399  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000429 = GetResString("MISSDK_NPCSDK_LUA_000429")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000429)
			MISSDK_NPCSDK_LUA_000451 = GetResString("MISSDK_NPCSDK_LUA_000451")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000451)
		else
			TakeItem( role , 0 , 2321 , 1)
			TakeItem( role , 0 , 6865 , 1)
			GiveItem( role , 0 , 2400  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000431 = GetResString("MISSDK_NPCSDK_LUA_000431")
			SystemNotice(role,name..MISSDK_NPCSDK_LUA_000431)
			MISSDK_NPCSDK_LUA_000452 = GetResString("MISSDK_NPCSDK_LUA_000452")
			MISSDK_NPCSDK_LUA_000424 = GetResString("MISSDK_NPCSDK_LUA_000424")
			LG(MISSDK_NPCSDK_LUA_000424,name..MISSDK_NPCSDK_LUA_000452)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Str_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6618 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6618 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000453 = GetResString("MISSDK_NPCSDK_LUA_000453")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000453)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6618 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000455 = GetResString("MISSDK_NPCSDK_LUA_000455")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000455)
		else
			TakeItem( role , 0 , 6618 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000456 = GetResString("MISSDK_NPCSDK_LUA_000456")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000456)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Str_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6621 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6621 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000457 = GetResString("MISSDK_NPCSDK_LUA_000457")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000457)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6621 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000458 = GetResString("MISSDK_NPCSDK_LUA_000458")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000458)
		else
			TakeItem( role , 0 , 6621 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000459 = GetResString("MISSDK_NPCSDK_LUA_000459")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000459)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Str_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6619 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6619 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000460 = GetResString("MISSDK_NPCSDK_LUA_000460")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000460)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6619 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000461 = GetResString("MISSDK_NPCSDK_LUA_000461")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000461)
		else
			TakeItem( role , 0 , 6619 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000462 = GetResString("MISSDK_NPCSDK_LUA_000462")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000462)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Str_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6620 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )	
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6620 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000463 = GetResString("MISSDK_NPCSDK_LUA_000463")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000463)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6620 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000464 = GetResString("MISSDK_NPCSDK_LUA_000464")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000464)
		else
			TakeItem( role , 0 , 6620 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000465 = GetResString("MISSDK_NPCSDK_LUA_000465")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000465)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Con_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6622 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6622 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000466 = GetResString("MISSDK_NPCSDK_LUA_000466")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000466)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6622 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000467 = GetResString("MISSDK_NPCSDK_LUA_000467")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000467)
		else
			TakeItem( role , 0 , 6622 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000468 = GetResString("MISSDK_NPCSDK_LUA_000468")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000468)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Con_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6623 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6623 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000469 = GetResString("MISSDK_NPCSDK_LUA_000469")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000469)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6623 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000470 = GetResString("MISSDK_NPCSDK_LUA_000470")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000470)
		else
			TakeItem( role , 0 , 6623 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000471 = GetResString("MISSDK_NPCSDK_LUA_000471")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000471)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Con_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6624 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6624 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000472 = GetResString("MISSDK_NPCSDK_LUA_000472")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000472)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6624 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000473 = GetResString("MISSDK_NPCSDK_LUA_000473")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000473)
		else
			TakeItem( role , 0 , 6624 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000474 = GetResString("MISSDK_NPCSDK_LUA_000474")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000474)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Con_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6625 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6625 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000475 = GetResString("MISSDK_NPCSDK_LUA_000475")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000475)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6625 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000476 = GetResString("MISSDK_NPCSDK_LUA_000476")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000476)
		else
			TakeItem( role , 0 , 6625 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000477 = GetResString("MISSDK_NPCSDK_LUA_000477")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000477)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Sta_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6630 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6630 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000478 = GetResString("MISSDK_NPCSDK_LUA_000478")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000478)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6630 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000479 = GetResString("MISSDK_NPCSDK_LUA_000479")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000479)
		else
			TakeItem( role , 0 , 6630 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000480 = GetResString("MISSDK_NPCSDK_LUA_000480")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000480)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Sta_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6631 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6631 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000481 = GetResString("MISSDK_NPCSDK_LUA_000481")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000481)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6631 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000482 = GetResString("MISSDK_NPCSDK_LUA_000482")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000482)
		else
			TakeItem( role , 0 , 6631 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000483 = GetResString("MISSDK_NPCSDK_LUA_000483")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000483)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Sta_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6632 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6632 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000484 = GetResString("MISSDK_NPCSDK_LUA_000484")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000484)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6632 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000485 = GetResString("MISSDK_NPCSDK_LUA_000485")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000485)
		else
			TakeItem( role , 0 , 6632 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000486 = GetResString("MISSDK_NPCSDK_LUA_000486")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000486)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Sta_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6633 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6633 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000487 = GetResString("MISSDK_NPCSDK_LUA_000487")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000487)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6633 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000488 = GetResString("MISSDK_NPCSDK_LUA_000488")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000488)
		else
			TakeItem( role , 0 , 6633 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000489 = GetResString("MISSDK_NPCSDK_LUA_000489")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000489)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Agi_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6626 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6626 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000490 = GetResString("MISSDK_NPCSDK_LUA_000490")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000490)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6626 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000491 = GetResString("MISSDK_NPCSDK_LUA_000491")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000491)
		else
			TakeItem( role , 0 , 6626 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000492 = GetResString("MISSDK_NPCSDK_LUA_000492")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000492)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Agi_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6629 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6629 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000493 = GetResString("MISSDK_NPCSDK_LUA_000493")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000493)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6629 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000494 = GetResString("MISSDK_NPCSDK_LUA_000494")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000494)
		else
			TakeItem( role , 0 , 6629 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000495 = GetResString("MISSDK_NPCSDK_LUA_000495")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000495)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Agi_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6627 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6627 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000496 = GetResString("MISSDK_NPCSDK_LUA_000496")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000496)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6627 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000497 = GetResString("MISSDK_NPCSDK_LUA_000497")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000497)
		else
			TakeItem( role , 0 , 6627 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000498 = GetResString("MISSDK_NPCSDK_LUA_000498")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000498)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Agi_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6628 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6628 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000499 = GetResString("MISSDK_NPCSDK_LUA_000499")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000499)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6628 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000500 = GetResString("MISSDK_NPCSDK_LUA_000500")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000500)
		else
			TakeItem( role , 0 , 6628 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000501 = GetResString("MISSDK_NPCSDK_LUA_000501")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000501)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Dex_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6634 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6634 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000502 = GetResString("MISSDK_NPCSDK_LUA_000502")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000502)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6634 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000503 = GetResString("MISSDK_NPCSDK_LUA_000503")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000503)
		else
			TakeItem( role , 0 , 6634 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000504 = GetResString("MISSDK_NPCSDK_LUA_000504")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000504)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Dex_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6635 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6635 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000505 = GetResString("MISSDK_NPCSDK_LUA_000505")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000505)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6635 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000506 = GetResString("MISSDK_NPCSDK_LUA_000506")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000506)
		else
			TakeItem( role , 0 , 6635 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000507 = GetResString("MISSDK_NPCSDK_LUA_000507")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000507)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Dex_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6636 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6636 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000508 = GetResString("MISSDK_NPCSDK_LUA_000508")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000508)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6636 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000509 = GetResString("MISSDK_NPCSDK_LUA_000509")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000509)
		else
			TakeItem( role , 0 , 6636 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000510 = GetResString("MISSDK_NPCSDK_LUA_000510")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000510)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv65Dex_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6637 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6637 , 1)
			GiveItem( role , 0 , 414  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000511 = GetResString("MISSDK_NPCSDK_LUA_000511")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000511)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6637 , 1)
			GiveItem( role , 0 , 415  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000512 = GetResString("MISSDK_NPCSDK_LUA_000512")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000512)
		else
			TakeItem( role , 0 , 6637 , 1)
			GiveItem( role , 0 , 417  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000513 = GetResString("MISSDK_NPCSDK_LUA_000513")
			MISSDK_NPCSDK_LUA_000454 = GetResString("MISSDK_NPCSDK_LUA_000454")
			LG(MISSDK_NPCSDK_LUA_000454,name..MISSDK_NPCSDK_LUA_000513)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv70Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 1112 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1112 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000514 = GetResString("MISSDK_NPCSDK_LUA_000514")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000514)
		elseif rand <= 5 then
			TakeItem( role , 0 , 1112 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000516 = GetResString("MISSDK_NPCSDK_LUA_000516")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000516)
		else
			TakeItem( role , 0 , 1112 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000517 = GetResString("MISSDK_NPCSDK_LUA_000517")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000517)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv70Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 1862 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1862 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000518 = GetResString("MISSDK_NPCSDK_LUA_000518")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000518)
		elseif rand <= 5 then
			TakeItem( role , 0 , 1862 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000519 = GetResString("MISSDK_NPCSDK_LUA_000519")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000519)
		else
			TakeItem( role , 0 , 1862 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000520 = GetResString("MISSDK_NPCSDK_LUA_000520")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000520)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv70Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 2209 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2209 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000521 = GetResString("MISSDK_NPCSDK_LUA_000521")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000521)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2209 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000522 = GetResString("MISSDK_NPCSDK_LUA_000522")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000522)
		else
			TakeItem( role , 0 , 2209 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000523 = GetResString("MISSDK_NPCSDK_LUA_000523")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000523)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv70Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 1114 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1114 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000524 = GetResString("MISSDK_NPCSDK_LUA_000524")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000524)
		elseif rand <= 5 then
			TakeItem( role , 0 , 1114 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000525 = GetResString("MISSDK_NPCSDK_LUA_000525")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000525)
		else
			TakeItem( role , 0 , 1114 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000526 = GetResString("MISSDK_NPCSDK_LUA_000526")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000526)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv70Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 1113 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 1113 , 1)
			GiveItem( role , 0 , 6629  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000527 = GetResString("MISSDK_NPCSDK_LUA_000527")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000527)
		elseif rand <= 5 then
			TakeItem( role , 0 , 1113 , 1)
			GiveItem( role , 0 , 6634  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000528 = GetResString("MISSDK_NPCSDK_LUA_000528")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000528)
		else
			TakeItem( role , 0 , 1113 , 1)
			GiveItem( role , 0 , 6630  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000529 = GetResString("MISSDK_NPCSDK_LUA_000529")
			MISSDK_NPCSDK_LUA_000515 = GetResString("MISSDK_NPCSDK_LUA_000515")
			LG(MISSDK_NPCSDK_LUA_000515,name..MISSDK_NPCSDK_LUA_000529)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Str_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6638 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6638 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000530 = GetResString("MISSDK_NPCSDK_LUA_000530")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000530)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6638 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000532 = GetResString("MISSDK_NPCSDK_LUA_000532")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000532)
		else
			TakeItem( role , 0 , 6638 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000533 = GetResString("MISSDK_NPCSDK_LUA_000533")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000533)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Str_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6641 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6641 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000534 = GetResString("MISSDK_NPCSDK_LUA_000534")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000534)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6641 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000535 = GetResString("MISSDK_NPCSDK_LUA_000535")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000535)
		else
			TakeItem( role , 0 , 6641 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000536 = GetResString("MISSDK_NPCSDK_LUA_000536")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000536)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Str_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6639 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6639 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000537 = GetResString("MISSDK_NPCSDK_LUA_000537")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000537)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6639 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000538 = GetResString("MISSDK_NPCSDK_LUA_000538")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000538)
		else
			TakeItem( role , 0 , 6639 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000539 = GetResString("MISSDK_NPCSDK_LUA_000539")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000539)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Str_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6640 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6640 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000540 = GetResString("MISSDK_NPCSDK_LUA_000540")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000540)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6640 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000541 = GetResString("MISSDK_NPCSDK_LUA_000541")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000541)
		else
			TakeItem( role , 0 , 6640 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000542 = GetResString("MISSDK_NPCSDK_LUA_000542")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000542)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Con_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6643 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6643 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000543 = GetResString("MISSDK_NPCSDK_LUA_000543")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000543)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6643 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000544 = GetResString("MISSDK_NPCSDK_LUA_000544")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000544)
		else
			TakeItem( role , 0 , 6643 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000545 = GetResString("MISSDK_NPCSDK_LUA_000545")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000545)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Con_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6644 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6644 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000546 = GetResString("MISSDK_NPCSDK_LUA_000546")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000546)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6644 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000547 = GetResString("MISSDK_NPCSDK_LUA_000547")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000547)
		else
			TakeItem( role , 0 , 6644 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000548 = GetResString("MISSDK_NPCSDK_LUA_000548")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000548)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Con_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6645 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6645 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000549 = GetResString("MISSDK_NPCSDK_LUA_000549")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000549)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6645 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000550 = GetResString("MISSDK_NPCSDK_LUA_000550")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000550)
		else
			TakeItem( role , 0 , 6645 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000551 = GetResString("MISSDK_NPCSDK_LUA_000551")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000551)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Con_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6646 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6646 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000552 = GetResString("MISSDK_NPCSDK_LUA_000552")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000552)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6646 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000553 = GetResString("MISSDK_NPCSDK_LUA_000553")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000553)
		else
			TakeItem( role , 0 , 6646 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000554 = GetResString("MISSDK_NPCSDK_LUA_000554")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000554)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Sta_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6653 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6653 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000555 = GetResString("MISSDK_NPCSDK_LUA_000555")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000555)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6653 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000556 = GetResString("MISSDK_NPCSDK_LUA_000556")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000556)
		else
			TakeItem( role , 0 , 6653 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000557 = GetResString("MISSDK_NPCSDK_LUA_000557")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000557)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Sta_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6654 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6654 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000558 = GetResString("MISSDK_NPCSDK_LUA_000558")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000558)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6654 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000559 = GetResString("MISSDK_NPCSDK_LUA_000559")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000559)
		else
			TakeItem( role , 0 , 6654 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000560 = GetResString("MISSDK_NPCSDK_LUA_000560")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000560)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Sta_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6655 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6655 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000561 = GetResString("MISSDK_NPCSDK_LUA_000561")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000561)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6655 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000562 = GetResString("MISSDK_NPCSDK_LUA_000562")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000562)
		else
			TakeItem( role , 0 , 6655 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000563 = GetResString("MISSDK_NPCSDK_LUA_000563")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000563)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Sta_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6656 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6656 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000564 = GetResString("MISSDK_NPCSDK_LUA_000564")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000564)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6656 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000565 = GetResString("MISSDK_NPCSDK_LUA_000565")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000565)
		else
			TakeItem( role , 0 , 6656 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000566 = GetResString("MISSDK_NPCSDK_LUA_000566")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000566)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Agi_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6648 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6648 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000567 = GetResString("MISSDK_NPCSDK_LUA_000567")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000567)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6648 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000568 = GetResString("MISSDK_NPCSDK_LUA_000568")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000568)
		else
			TakeItem( role , 0 , 6648 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000569 = GetResString("MISSDK_NPCSDK_LUA_000569")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000569)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Agi_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6651 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6651 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000570 = GetResString("MISSDK_NPCSDK_LUA_000570")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000570)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6651 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000571 = GetResString("MISSDK_NPCSDK_LUA_000571")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000571)
		else
			TakeItem( role , 0 , 6651 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000572 = GetResString("MISSDK_NPCSDK_LUA_000572")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000572)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Agi_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6649 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6649 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000573 = GetResString("MISSDK_NPCSDK_LUA_000573")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000573)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6649 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000574 = GetResString("MISSDK_NPCSDK_LUA_000574")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000574)
		else
			TakeItem( role , 0 , 6649 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000575 = GetResString("MISSDK_NPCSDK_LUA_000575")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000575)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Agi_Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 6650 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6650 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000576 = GetResString("MISSDK_NPCSDK_LUA_000576")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000576)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6650 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000577 = GetResString("MISSDK_NPCSDK_LUA_000577")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000577)
		else
			TakeItem( role , 0 , 6650 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000578 = GetResString("MISSDK_NPCSDK_LUA_000578")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000578)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Dex_Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 6658 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6658 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000579 = GetResString("MISSDK_NPCSDK_LUA_000579")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000579)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6658 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000580 = GetResString("MISSDK_NPCSDK_LUA_000580")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000580)
		else
			TakeItem( role , 0 , 6658 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000581 = GetResString("MISSDK_NPCSDK_LUA_000581")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000581)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Dex_Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 6659 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6659 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000582 = GetResString("MISSDK_NPCSDK_LUA_000582")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000582)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6659 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000583 = GetResString("MISSDK_NPCSDK_LUA_000583")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000583)
		else
			TakeItem( role , 0 , 6659 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000584 = GetResString("MISSDK_NPCSDK_LUA_000584")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000584)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Dex_Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 6660 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6660 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000585 = GetResString("MISSDK_NPCSDK_LUA_000585")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000585)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6660 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000586 = GetResString("MISSDK_NPCSDK_LUA_000586")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000586)
		else
			TakeItem( role , 0 , 6660 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000587 = GetResString("MISSDK_NPCSDK_LUA_000587")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000587)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv75Dex_Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 6661 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 6661 , 1)
			GiveItem( role , 0 , 1114  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000588 = GetResString("MISSDK_NPCSDK_LUA_000588")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000588)
		elseif rand <= 5 then
			TakeItem( role , 0 , 6661 , 1)
			GiveItem( role , 0 , 1113  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000589 = GetResString("MISSDK_NPCSDK_LUA_000589")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000589)
		else
			TakeItem( role , 0 , 6661 , 1)
			GiveItem( role , 0 , 2209  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000590 = GetResString("MISSDK_NPCSDK_LUA_000590")
			MISSDK_NPCSDK_LUA_000531 = GetResString("MISSDK_NPCSDK_LUA_000531")
			LG(MISSDK_NPCSDK_LUA_000531,name..MISSDK_NPCSDK_LUA_000590)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv80Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 2317 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2317 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000591 = GetResString("MISSDK_NPCSDK_LUA_000591")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000591)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2317 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000593 = GetResString("MISSDK_NPCSDK_LUA_000593")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000593)
		else
			TakeItem( role , 0 , 2317 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000594 = GetResString("MISSDK_NPCSDK_LUA_000594")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000594)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv80Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 2320 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2320 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000595 = GetResString("MISSDK_NPCSDK_LUA_000595")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000595)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2320 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000596 = GetResString("MISSDK_NPCSDK_LUA_000596")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000596)
		else
			TakeItem( role , 0 , 2320 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000597 = GetResString("MISSDK_NPCSDK_LUA_000597")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000597)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv80Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 2321 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2321 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000598 = GetResString("MISSDK_NPCSDK_LUA_000598")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000598)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2321 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000599 = GetResString("MISSDK_NPCSDK_LUA_000599")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000599)
		else
			TakeItem( role , 0 , 2321 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000600 = GetResString("MISSDK_NPCSDK_LUA_000600")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000600)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv80Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 2319 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2319 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000601 = GetResString("MISSDK_NPCSDK_LUA_000601")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000601)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2319 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000602 = GetResString("MISSDK_NPCSDK_LUA_000602")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000602)
		else
			TakeItem( role , 0 , 2319 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000603 = GetResString("MISSDK_NPCSDK_LUA_000603")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000603)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv80Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 2318 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2318 , 1)
			GiveItem( role , 0 , 6651  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000604 = GetResString("MISSDK_NPCSDK_LUA_000604")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000604)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2318 , 1)
			GiveItem( role , 0 , 6658  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000605 = GetResString("MISSDK_NPCSDK_LUA_000605")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000605)
		else
			TakeItem( role , 0 , 2318 , 1)
			GiveItem( role , 0 , 6653  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000606 = GetResString("MISSDK_NPCSDK_LUA_000606")
			MISSDK_NPCSDK_LUA_000592 = GetResString("MISSDK_NPCSDK_LUA_000592")
			LG(MISSDK_NPCSDK_LUA_000592,name..MISSDK_NPCSDK_LUA_000606)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv90Str(role,npc)
	local hoe_Count = CheckBagItem ( role , 2398 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2398 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000607 = GetResString("MISSDK_NPCSDK_LUA_000607")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000607)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2398 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000609 = GetResString("MISSDK_NPCSDK_LUA_000609")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000609)
		else
			TakeItem( role , 0 , 2398 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000610 = GetResString("MISSDK_NPCSDK_LUA_000610")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000610)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv90Con(role,npc)
	local hoe_Count = CheckBagItem ( role , 2401 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2401 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000611 = GetResString("MISSDK_NPCSDK_LUA_000611")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000611)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2401 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000612 = GetResString("MISSDK_NPCSDK_LUA_000612")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000612)
		else
			TakeItem( role , 0 , 2401 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000613 = GetResString("MISSDK_NPCSDK_LUA_000613")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000613)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function DownRingLv90Sta(role,npc)
	local hoe_Count = CheckBagItem ( role , 2402 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2402 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000614 = GetResString("MISSDK_NPCSDK_LUA_000614")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000614)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2402 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000615 = GetResString("MISSDK_NPCSDK_LUA_000615")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000615)
		else
			TakeItem( role , 0 , 2402 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000616 = GetResString("MISSDK_NPCSDK_LUA_000616")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000616)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv90Agi(role,npc)
	local hoe_Count = CheckBagItem ( role , 2400 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2400 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000617 = GetResString("MISSDK_NPCSDK_LUA_000617")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000617)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2400 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000618 = GetResString("MISSDK_NPCSDK_LUA_000618")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000618)
		else
			TakeItem( role , 0 , 2400 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000619 = GetResString("MISSDK_NPCSDK_LUA_000619")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000619)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end

function DownRingLv90Dex(role,npc)
	local hoe_Count = CheckBagItem ( role , 2399 ) --检查指定戒指数量
	local name =GetChaDefaultName(role)
	local rand = math.random ( 1, 10 )
	local NocLock =	KitbagLock( role, 0 )
	if NocLock == LUA_FALSE then
		CALCULATE_FUNCTIONS_LUA_000144 = GetResString("CALCULATE_FUNCTIONS_LUA_000144")
		SystemNotice( role , CALCULATE_FUNCTIONS_LUA_000144)
		return 0
	end	
	if  hoe_Count > 0 then
		if rand <= 2 then
			TakeItem( role , 0 , 2399 , 1)
			GiveItem( role , 0 , 2319  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000620 = GetResString("MISSDK_NPCSDK_LUA_000620")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000620)
		elseif rand <= 5 then
			TakeItem( role , 0 , 2399 , 1)
			GiveItem( role , 0 , 2318  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000621 = GetResString("MISSDK_NPCSDK_LUA_000621")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000621)
		else
			TakeItem( role , 0 , 2399 , 1)
			GiveItem( role , 0 , 2321  , 1 , 22 )
			MISSDK_NPCSDK_LUA_000622 = GetResString("MISSDK_NPCSDK_LUA_000622")
			MISSDK_NPCSDK_LUA_000608 = GetResString("MISSDK_NPCSDK_LUA_000608")
			LG(MISSDK_NPCSDK_LUA_000608,name..MISSDK_NPCSDK_LUA_000622)
		end
	else
		MISSDK_NPCSDK_LUA_000158 = GetResString("MISSDK_NPCSDK_LUA_000158")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000158)
	end
	RefreshCha(role)
end


function Fool_choose1(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1980)
	if ret == 1 then
		local statelv = 1
		local statetime = 2			
		AddState ( role , role , STATE_LEIPI , statelv , statetime )
		CALCULATE_FUNCTIONS_LUA_000375 = GetResString("CALCULATE_FUNCTIONS_LUA_000375")
		SystemNotice(role,CALCULATE_FUNCTIONS_LUA_000375)
		SetRecord(role,1980)
		GiveItem ( role , 0 , 2953  , 1  , 4  )
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end 



function Fool_choose2(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1980)
	if ret == 1 then
		CALCULATE_FUNCTIONS_LUA_000372 = GetResString("CALCULATE_FUNCTIONS_LUA_000372")
		SystemNotice(role,CALCULATE_FUNCTIONS_LUA_000372)
		local statelv = 1
		local statetime = 25
		AddState ( role , role , STATE_XIANRENJIAO , statelv , statetime )
		AddState ( role , role , STATE_XY , statelv , statetime )
		SetRecord(role,1980)
		GiveItem ( role , 0 , 2953  , 1  , 4  )
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

function Fool_choose3(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1980)
	if ret == 1 then
		CALCULATE_FUNCTIONS_LUA_000374 = GetResString("CALCULATE_FUNCTIONS_LUA_000374")
		SystemNotice(role,CALCULATE_FUNCTIONS_LUA_000374)
		local statelv = 1
		local statetime = 30
		AddState ( role , role , STATE_BIW , statelv , statetime )
		SetRecord(role,1980)
		GiveItem ( role , 0 , 2953  , 1  , 4  )
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

function Fool_choose4(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1980)
	if ret == 1 then
		local statelv = 10
		local statetime = 2			
		AddState ( role , role , STATE_CUSI , statelv , statetime )
		RemoveState ( role , STATE_CUSI ) 
		MISSDK_NPCSDK_LUA_000625 = GetResString("MISSDK_NPCSDK_LUA_000625")
		SystemNotice ( role , MISSDK_NPCSDK_LUA_000625 )
		SetRecord(role,1980)
		GiveItem ( role , 0 , 2953  , 1  , 4  )		
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end 

function Fool_choose5(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1981)
	if ret == 1 then
		MISSDK_NPCSDK_LUA_000626 = GetResString("MISSDK_NPCSDK_LUA_000626")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000626)
		local statelv = 1
		local statetime = 30
		AddState ( role , role , STATE_NT , statelv , statetime )
		SetRecord(role,1981)
		GiveItem ( role , 0 , 6872  , 1  , 4  )		
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

function Fool_choose6(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1981)
	if ret == 1 then
		MISSDK_NPCSDK_LUA_000627 = GetResString("MISSDK_NPCSDK_LUA_000627")
		SystemNotice(role,MISSDK_NPCSDK_LUA_000627)
		local statelv = 1
		local statetime = 30
		AddState ( role , role , STATE_HYMH , statelv , statetime )
		SetRecord(role,1981)
		GiveItem ( role , 0 , 6872  , 1  , 4  )		
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

function Fool_choose7(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1981)
	if ret == 1 then
		CALCULATE_FUNCTIONS_LUA_000370 = GetResString("CALCULATE_FUNCTIONS_LUA_000370")
		SystemNotice(role,CALCULATE_FUNCTIONS_LUA_000370)
		local statelv = 1
		local statetime = 30
		AddState ( role , role , STATE_GANMAO , statelv , statetime )
		SetRecord(role,1981)
		GiveItem ( role , 0 , 6872  , 1  , 4  )		
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

function Fool_choose8(role,npc)
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then 
		MISSDK_NPCSDK_LUA_000623 = GetResString("MISSDK_NPCSDK_LUA_000623")
		SystemNotice (role , MISSDK_NPCSDK_LUA_000623)
		return
	end
	local ret = NoRecord(role,1981)
	if ret == 1 then
		CALCULATE_FUNCTIONS_LUA_000373 = GetResString("CALCULATE_FUNCTIONS_LUA_000373")
		SystemNotice(role,CALCULATE_FUNCTIONS_LUA_000373)
		local statelv = 1
		local statetime = 30
		AddState ( role , role , STATE_JF , statelv , statetime )
		SetRecord(role,1981)
		GiveItem ( role , 0 , 6872  , 1  , 4  )
	else
		MISSDK_NPCSDK_LUA_000624 = GetResString("MISSDK_NPCSDK_LUA_000624")
		SystemNotice( role , MISSDK_NPCSDK_LUA_000624)
		return 0
	end	

end

-- function Box_choose1 ( role  )
	-- local Item_CanGet = GetChaFreeBagGridNum ( role )
	-- if Item_CanGet < 1 then
		-- SystemNotice(role ,"身上没有1格的剩余空间，宝箱开启失败～")
		-- UseItemFailed ( role )
		-- return
	-- end
	-- local Card_Count = CheckBagItem ( role , 6931 )
	-- local Box_Count = CheckBagItem ( role , 6919 ) 
	-- if Card_Count < 2 then
		-- return "背包中没有足够的勤劳鉴定卡片！"
	-- elseif Box_Count < 1 then 
		-- return "背包中没有初级鉴定宝箱！"
	-- end
	-- TakeItem( role , 0 , 6931 , 2)
	-- TakeItem( role , 0 , 6919 , 1)	
	-- GiveItem ( role , 0 , 6920 ,1 , 4 )
	-- return 1
-- end 



function Box_choose2 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6919 ) 
	if Card_Count < 2 then
		MISSDK_NPCSDK_LUA_000629 = GetResString("MISSDK_NPCSDK_LUA_000629")
		return MISSDK_NPCSDK_LUA_000629
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000630 = GetResString("MISSDK_NPCSDK_LUA_000630")
		return MISSDK_NPCSDK_LUA_000630
	end
	TakeItem( role , 0 , 6931 , 2)
	TakeItem( role , 0 , 6919 , 1)
	sc = math.random (1,10)
	if sc > 0 and sc <= 3 then
		GiveItem ( role , 0 , 6922 ,1 , 4 )
	elseif sc > 3 and sc <= 6 then
		GiveItem ( role , 0 , 6923 ,1 , 4 )
	elseif sc > 6 and sc <= 8 then
		GiveItem ( role , 0 , 6924 ,1 , 4 )
	else
		GiveItem ( role , 0 , 6925 ,1 , 4 )
	end
	return 1
end 




function Box_choose3 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6918 ) 
	if Card_Count < 1 then
		MISSDK_NPCSDK_LUA_000629 = GetResString("MISSDK_NPCSDK_LUA_000629")
		return MISSDK_NPCSDK_LUA_000629
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000631 = GetResString("MISSDK_NPCSDK_LUA_000631")
		return MISSDK_NPCSDK_LUA_000631
	end
	TakeItem( role , 0 , 6931 , 1)
	TakeItem( role , 0 , 6918 , 1)
	GiveItem ( role , 0 , 6919 ,1 , 4 )
	return 1
end 



function Box_choose4 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6922 ) 
	if Card_Count < 3 then
		MISSDK_NPCSDK_LUA_000629 = GetResString("MISSDK_NPCSDK_LUA_000629")
		return MISSDK_NPCSDK_LUA_000629
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000632 = GetResString("MISSDK_NPCSDK_LUA_000632")
		return MISSDK_NPCSDK_LUA_000632
	end
	TakeItem( role , 0 , 6931 , 3)
	TakeItem( role , 0 , 6922 , 1)
	Item_BoxID = {}
	Item_BoxID[1]=6932
	Item_BoxID[2]=6933
	Item_BoxID[3]=6934
	i = math.random (1,3)
	GiveItem ( role , 0 , Item_BoxID[i] ,1 , 4 )
	return 1
end 



function Box_choose5 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6923 ) 
	if Card_Count < 3 then
		MISSDK_NPCSDK_LUA_000633 = GetResString("MISSDK_NPCSDK_LUA_000633")
		return MISSDK_NPCSDK_LUA_000633
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000634 = GetResString("MISSDK_NPCSDK_LUA_000634")
		return MISSDK_NPCSDK_LUA_000634
	end
	TakeItem( role , 0 , 6931 , 3)
	TakeItem( role , 0 , 6923 , 1)
	Item_BoxID = {}
	Item_BoxID[1]=6935
	Item_BoxID[2]=6936
	Item_BoxID[3]=6937
	i = math.random (1,3)
	GiveItem ( role , 0 , Item_BoxID[i] ,1 , 4 )
	return 1
end 



function Box_choose6 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6924 ) 
	if Card_Count < 3 then
		MISSDK_NPCSDK_LUA_000633 = GetResString("MISSDK_NPCSDK_LUA_000633")
		return MISSDK_NPCSDK_LUA_000633
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000635 = GetResString("MISSDK_NPCSDK_LUA_000635")
		return MISSDK_NPCSDK_LUA_000635
	end
	TakeItem( role , 0 , 6931 , 3)
	TakeItem( role , 0 , 6924 , 1)
	Item_BoxID = {}
	Item_BoxID[1]=6938
	Item_BoxID[2]=6939
	Item_BoxID[3]=6940
	i = math.random (1,3)
	GiveItem ( role , 0 , Item_BoxID[i] ,1 , 4 )
	return 1
end 


function Box_choose7 ( role  )
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 1 then
		MISSDK_NPCSDK_LUA_000628 = GetResString("MISSDK_NPCSDK_LUA_000628")
		return MISSDK_NPCSDK_LUA_000628
	end
	local Card_Count = CheckBagItem ( role , 6931 )
	local Box_Count = CheckBagItem ( role , 6925 ) 
	if Card_Count < 3 then
		MISSDK_NPCSDK_LUA_000633 = GetResString("MISSDK_NPCSDK_LUA_000633")
		return MISSDK_NPCSDK_LUA_000633
	elseif Box_Count < 1 then 
		MISSDK_NPCSDK_LUA_000636 = GetResString("MISSDK_NPCSDK_LUA_000636")
		return MISSDK_NPCSDK_LUA_000636
	end
	TakeItem( role , 0 , 6931 , 3)
	TakeItem( role , 0 , 6925 , 1)
	Item_BoxID = {}
	Item_BoxID[1]=6941
	Item_BoxID[2]=6942
	Item_BoxID[3]=6943
	i = math.random (1,3)
	GiveItem ( role , 0 , Item_BoxID[i] ,1 , 4 )
	return 1
end 
function GoToDream( character, mapname )
    local a =  math.random(1,15)
	if a < 6 then
	   return MoveTo( character,  387, 591,  mapname )
	elseif a>=6 and a<=10 then 
	   return MoveTo( character,  424,587,  mapname )
	elseif a>10 then 
	   return MoveTo( character,  420,531,  mapname )
    end
end
