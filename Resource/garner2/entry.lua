--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry,2492,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    GARNER2_ENTRY_LUA_000001 = GetResString("GARNER2_ENTRY_LUA_000001")
    GARNER2_ENTRY_LUA_000002 = GetResString("GARNER2_ENTRY_LUA_000002")
    Notice(GARNER2_ENTRY_LUA_000002..posx..","..posy..GARNER2_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_garner2(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    GARNER2_ENTRY_LUA_000003 = GetResString("GARNER2_ENTRY_LUA_000003")
    Notice(GARNER2_ENTRY_LUA_000003) 

end

function after_player_login_garner2(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    GARNER2_ENTRY_LUA_000001 = GetResString("GARNER2_ENTRY_LUA_000001")
    GARNER2_ENTRY_LUA_000002 = GetResString("GARNER2_ENTRY_LUA_000002")
    ChaNotice(player_name, GARNER2_ENTRY_LUA_000002..posx..","..posy..GARNER2_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end






function check_can_enter_garner2( role, copy_mgr )
	local FightingBook_Num = 0
	FightingBook_Num = CheckBagItem( role,3849 )
	local Team_In = IsInTeam(role)
	if Team_In == 1 then
		GARNER2_ENTRY_LUA_000004 = GetResString("GARNER2_ENTRY_LUA_000004")
		SystemNotice ( role , GARNER2_ENTRY_LUA_000004 )
		return 0
		
	end
	if FightingBook_Num <= 0 then
		GARNER2_ENTRY_LUA_000005 = GetResString("GARNER2_ENTRY_LUA_000005")
		SystemNotice ( role , GARNER2_ENTRY_LUA_000005 )
		return 0
	elseif FightingBook_Num > 1 then
		GARNER2_ENTRY_LUA_000006 = GetResString("GARNER2_ENTRY_LUA_000006")
		LG("RYZ_PK",GARNER2_ENTRY_LUA_000006)
		return 0
	end
	local role_RY = GetChaItem2 ( role , 2 , 3849 )
	local HonorPoint = GetItemAttr ( role_RY , ITEMATTR_VAL_STR)

	if HonorPoint < 20 then
		GARNER2_ENTRY_LUA_000007 = GetResString("GARNER2_ENTRY_LUA_000007")
		SystemNotice ( role , GARNER2_ENTRY_LUA_000007 )
		return 0
	end

	if HonorPoint >30000 then
		GARNER2_ENTRY_LUA_000008 = GetResString("GARNER2_ENTRY_LUA_000008")
		SystemNotice ( role , GARNER2_ENTRY_LUA_000008 )
		return 0
	end

	local Credit_Garner2 = GetCredit(role)
	 if Credit_Garner2 < 30 then 
		GARNER2_ENTRY_LUA_000009 = GetResString("GARNER2_ENTRY_LUA_000009")
		SystemNotice ( role , GARNER2_ENTRY_LUA_000009 )
		return 0
	--else
--		DelCredit(role,30)
	end

	if Lv(role) < 20 then
	GARNER2_ENTRY_LUA_000010 = GetResString("GARNER2_ENTRY_LUA_000010")
	SystemNotice(role, GARNER2_ENTRY_LUA_000010)
		return 0    
	end
	local Has_money = check_HasMoney(role)
	if Has_money == 1 then
		
		return 1
		
	else
		GARNER2_ENTRY_LUA_000011 = GetResString("GARNER2_ENTRY_LUA_000011")
		SystemNotice(role,GARNER2_ENTRY_LUA_000011)
		return 0
	end
				
end

function check_HasMoney(role)
	local lv= GetChaAttr(role, ATTR_LV)
	local Money_Need = lv*50
	local Money_Have = GetChaAttr ( role , ATTR_GD )
		if Money_Have >= Money_Need then
			return 1
		end

end


function begin_enter_garner2(role, copy_mgr) 
	local	Money_Have = GetChaAttr ( role , ATTR_GD )
	local lv= GetChaAttr(role, ATTR_LV)
	local Money_Need = lv*50
	local	Money_Now = Money_Have - Money_Need
	SetChaAttrI( role , ATTR_GD , Money_Now )
	DelCredit(role,30)
		GARNER2_ENTRY_LUA_000012 = GetResString("GARNER2_ENTRY_LUA_000012")
		GARNER2_ENTRY_LUA_000013 = GetResString("GARNER2_ENTRY_LUA_000013")
		SystemNotice(role,GARNER2_ENTRY_LUA_000013..Money_Need..GARNER2_ENTRY_LUA_000012) 
		GARNER2_ENTRY_LUA_000014 = GetResString("GARNER2_ENTRY_LUA_000014")
		MoveCity(role, GARNER2_ENTRY_LUA_000014)
Money_all = Money_all + Money_Need * 0.8
end








