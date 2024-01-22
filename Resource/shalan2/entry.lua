--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry, 193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    SHALAN2_ENTRY_LUA_000001 = GetResString("SHALAN2_ENTRY_LUA_000001")
    SHALAN2_ENTRY_LUA_000002 = GetResString("SHALAN2_ENTRY_LUA_000002")
    Notice(SHALAN2_ENTRY_LUA_000002..posx..","..posy..SHALAN2_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_shalan2(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    SHALAN2_ENTRY_LUA_000003 = GetResString("SHALAN2_ENTRY_LUA_000003")
    Notice(SHALAN2_ENTRY_LUA_000003) 

end

function after_player_login_shalan2(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    SHALAN2_ENTRY_LUA_000001 = GetResString("SHALAN2_ENTRY_LUA_000001")
    SHALAN2_ENTRY_LUA_000002 = GetResString("SHALAN2_ENTRY_LUA_000002")
    ChaNotice(player_name, SHALAN2_ENTRY_LUA_000002..posx..","..posy..SHALAN2_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end









--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_shalan2( role, copy_mgr )
	local i = IsChaStall(role)
	if i == LUA_TRUE then
		BINGLANG2_ENTRY_LUA_000004 = GetResString("BINGLANG2_ENTRY_LUA_000004")
		SystemNotice(role, BINGLANG2_ENTRY_LUA_000004)
		return 0    
	end
	if Lv(role) < 70 then
		SHALAN2_ENTRY_LUA_000004 = GetResString("SHALAN2_ENTRY_LUA_000004")
		SystemNotice(role, SHALAN2_ENTRY_LUA_000004)
		return 0    
	end
	if Lv(role) > 89 then
		SHALAN2_ENTRY_LUA_000005 = GetResString("SHALAN2_ENTRY_LUA_000005")
		SystemNotice(role, SHALAN2_ENTRY_LUA_000005)
		return 0    
	end
	
	local Num
	Num = CheckBagItem(role,2326)
	if Num < 1 then
		SHALAN2_ENTRY_LUA_000006 = GetResString("SHALAN2_ENTRY_LUA_000006")
		SystemNotice(role, SHALAN2_ENTRY_LUA_000006)	
		return 0
	end

	local Credit_Shalan2 = GetCredit(role)
	if Credit_Shalan2 < 10 then
		SHALAN2_ENTRY_LUA_000007 = GetResString("SHALAN2_ENTRY_LUA_000007")
		SystemNotice(role, SHALAN2_ENTRY_LUA_000007)
		return 0
	else
		DelCredit(role,10)
		return 1
	end
end


function begin_enter_shalan2(role, copy_mgr)

	local Cha = TurnToCha(role)	
	local Dbag = 0
	Dbag = DelBagItem(Cha, 2326, 1)
	
	if Dbag == 1 then
		SHALAN2_ENTRY_LUA_000008 = GetResString("SHALAN2_ENTRY_LUA_000008")
		SystemNotice(role,SHALAN2_ENTRY_LUA_000008) 
		BIRTH_BIRTH_CONF_LUA_000050 = GetResString("BIRTH_BIRTH_CONF_LUA_000050")
		MoveCity(role, BIRTH_BIRTH_CONF_LUA_000050)

	else
	
		SHALAN2_ENTRY_LUA_000009 = GetResString("SHALAN2_ENTRY_LUA_000009")
		SystemNotice(role, SHALAN2_ENTRY_LUA_000009)
	end
end
