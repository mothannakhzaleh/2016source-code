--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨


function config_entry(entry) 

end 

function after_create_entry(entry) 
    TEAMPK_ENTRY_LUA_000001 = GetResString("TEAMPK_ENTRY_LUA_000001")
    Notice(TEAMPK_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_teampk(entry)
    TEAMPK_ENTRY_LUA_000002 = GetResString("TEAMPK_ENTRY_LUA_000002")
    Notice(TEAMPK_ENTRY_LUA_000002) 

end

function after_player_login_teampk(entry, player_name)
    TEAMPK_ENTRY_LUA_000003 = GetResString("TEAMPK_ENTRY_LUA_000003")
    ChaNotice(player_name, TEAMPK_ENTRY_LUA_000003) 

end

--主程序在玩家申请副本成功后调用此函数
--copy，副本对象。player1，邀请方。player2，受邀方。type，邀请类型（1，队伍。2，单体。3，公会）
function after_get_map_copy_teampk(copy_mgr, player1, player2, type) 
    SetMapCopyParam(copy_mgr, 1, type) --在第一个位置存入分边类型
    SetMapCopyParam(copy_mgr, 2, 2) --在第二个位置存入分边数
    if type == 1 then 
        SetMapCopyParam(copy_mgr, 3, GetPlayerTeamID(player1)) 
        SetMapCopyParam(copy_mgr, 4, GetPlayerTeamID(player2)) 
    elseif type == 2 then 
        SetMapCopyParam(copy_mgr, 3, GetPlayerID(player1)) 
        SetMapCopyParam(copy_mgr, 4, GetPlayerID(player2)) 
    end
    SetMapCopyParam(copy_mgr, 5, -1) --在第五个位置设定胜利队伍初值
					--第六个位置为地图关闭延时
    SetMapCopyParam(copy_mgr, 7, 3) --在第七个位置设定地图开启延时初值
    SetMapCopyParam(copy_mgr, 8, 0) --在第八个位置设定地图首次标记
    SetMapCopyParam(copy_mgr, 9, 0) --在第九个位置设定队伍1平均等级初值
    SetMapCopyParam(copy_mgr, 10,0) --在第十个位置设定队伍2平均等级初值
    SetMapCopyParam(copy_mgr, 11,0) --在第十一个位置设定队伍1人数初值
    SetMapCopyParam(copy_mgr, 12,0) --在第十二个位置设定队伍2人数初值

end 

--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_teampk( role, copy_mgr )
	local RYZ_Num = 0
	RYZ_Num = CheckBagItem( role,3849 )

	if RYZ_Num <= 0 then
		TEAMPK_ENTRY_LUA_000004 = GetResString("TEAMPK_ENTRY_LUA_000004")
		SystemNotice ( role , TEAMPK_ENTRY_LUA_000004 )
		return 0
	elseif RYZ_Num > 1 then
		TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
		LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
		return 0
	else
		local role_RYZ = GetChaItem2 ( role , 2 , 3849 )
		local attrtype = ITEMATTR_VAL_STR
		local attr_num = GetItemAttr ( role_RYZ , attrtype )
		local Rongy_xianzhi = RYZ_Rongyu_Min
		local Rongy_xianzhi0 = RYZ_Rongyu_Max

		
		if attr_num < Rongy_xianzhi then
			TEAMPK_ENTRY_LUA_000005 = GetResString("TEAMPK_ENTRY_LUA_000005")
			SystemNotice ( role , TEAMPK_ENTRY_LUA_000005 )
			return 0
		end

		if attr_num > Rongy_xianzhi0 then
			TEAMPK_ENTRY_LUA_000006 = GetResString("TEAMPK_ENTRY_LUA_000006")
			SystemNotice ( role , TEAMPK_ENTRY_LUA_000006 )
			return 0
		end
		
	end
	return 1


end

function begin_enter_teampk(role, copy_mgr) 
	local type = GetMapCopyParam(copy_mgr, 1) 
	local side1 = GetMapCopyParam(copy_mgr, 3) 
	local side2 = GetMapCopyParam(copy_mgr, 4) 
	local copy_id = GetMapCopyID(copy_mgr) 

	if type == 1 then --比较队伍编号
		local team_id1 = GetChaTeamID(role) 
		if team_id1 == side1 then 
		    BIRTH_BIRTH_CONF_LUA_000040 = GetResString("BIRTH_BIRTH_CONF_LUA_000040")
		    MoveCity(role, BIRTH_BIRTH_CONF_LUA_000040, copy_id) 
		else 
		    BIRTH_BIRTH_CONF_LUA_000041 = GetResString("BIRTH_BIRTH_CONF_LUA_000041")
		    MoveCity(role, BIRTH_BIRTH_CONF_LUA_000041, copy_id)
		end 
	elseif type == 2 then --比较玩家编号
		local player = GetChaPlayer(role) 
		local ply_id1 = GetPlayerID(player) 
		if ply_id1 == side1 then 
		    BIRTH_BIRTH_CONF_LUA_000040 = GetResString("BIRTH_BIRTH_CONF_LUA_000040")
		    MoveCity(role, BIRTH_BIRTH_CONF_LUA_000040, copy_id) 
		else 
		    BIRTH_BIRTH_CONF_LUA_000041 = GetResString("BIRTH_BIRTH_CONF_LUA_000041")
		    MoveCity(role, BIRTH_BIRTH_CONF_LUA_000041, copy_id)
		end 
	end

	
end 
