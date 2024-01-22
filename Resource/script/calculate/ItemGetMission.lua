--------------------------------------------------------------------------
--									--
--									--
--			ItemGetMission.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading ItemGetMission.lua" )


---相关判断函数
function CheckMisChaBoat ( role , ChaType )						--船只人物检测
	local Cha_Boat = GetCtrlBoat ( role )
	local ChaIsBoat = 0
	
	if Cha_Boat == nil then
		ChaIsBoat = 1
	else
		ChaIsBoat = 2
	end

	if ChaIsBoat == ChaType then
		return 1
	else
		return 0
	end
end

function CheckChaPos ( role , Cha_x_min , Cha_x_max , Cha_y_min , Cha_y_max , MapName )	--坐标检测

	local Cha_Boat = GetCtrlBoat ( role )
	local ChaIsBoat = 0
	if Cha_Boat ~= nil then
		role = Cha_Boat
	end

	local pos_x , pos_y = GetChaPos ( role )
	local map_name = GetChaMapName ( role )


	if MapName ~= -1 then 

		if map_name ~= MapName then
			return 0 
		end 
	end 

	if pos_x < Cha_x_min or pos_x > Cha_x_max then
	
		return 0
	end

	if pos_y < Cha_y_min or pos_y > Cha_y_max then
		return 0
	end

	return 1
end

function CheckChaGuildType ( role , GuildType , CheckType )				--检测公会类型
	
	local Cha_GuildID = GetChaGuildID( role )
	

	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		return 0
	end


	if CheckType == 1 then
		if ChaGuildType_Get == GuildType then
			return 1
		else
			return 0
		end
	elseif CheckType == 2 then
		if ChaGuildType_Get == GuildType then
			return 0
		else
			return 1
		end
	else
		return 0
	end

end

function MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	SystemNotice ( role , "MissionMsgCheck")
	local Have_Record	= 0
	local No_Record		= 0
	local Have_Mission	= 0
	local No_Mission	= 0
	
	
	if HasRecordID ~= -1 then
		Have_Record	= HasRecord( role , HasRecordID )
		if Have_Record ~= LUA_TRUE then
			SystemNotice ( role , HasRecordNotice )
			return 0
		end
	end


	if NoRecordID ~= -1 then
		No_Record	= NoRecord( role , NoRecordID )
		if No_Record ~= LUA_TRUE then
			SystemNotice ( role , NoRecordNotice )
			return 0
		end
	end



	if HasMissionID ~= -1 then
		Have_Mission	= HasMission( role , HasMissionID )
		if Have_Mission ~= LUA_TRUE then
			SystemNotice ( role , HasMissionNotice )
			return 0
		end
	end


	if No_MissionID ~= -1 then
		No_Mission	= HasMission( role , No_MissionID )
		if No_Mission == LUA_TRUE then
			SystemNotice ( role , NoMissionNotice )
			return 0
		end
	end
	
	return 1

end

function ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	SystemNotice ( role , "ChaMsgCheck")
	local Is_BoatOrMan = 0
	local At_Pos = 0
	local CheckGuild_Type = 0

	if ChaType ~= -1 then
		Is_BoatOrMan = CheckMisChaBoat( role , ChaType )
		if Is_BoatOrMan == 0 then
			SystemNotice ( role , CheckBoatNotice )
			return 0
		end
	end

	if Need_CheckPos == 1 then
		At_Pos = CheckChaPos ( role , Cha_x_min , Cha_x_max , Cha_y_min , Cha_y_max , MapName )
		if At_Pos == 0 then
			SystemNotice ( role , CheckPosNotice )
			return 0
		end
	end

	if GuildType ~= -1 then
		CheckGuild_Type = CheckChaGuildType ( role , GuildType , CheckType )
		if CheckGuild_Type == 0 then
			SystemNotice ( role , GuildTypeNotice )
			return 0
		end
	end
	
	return 1

end


function ItemUse_LDADYW (role) --[[鲁德安的遗物]]--

	local HasRecordID	= 270			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 4096			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 4096			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	9	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	8	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	10	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	1	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end



	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 
function ItemUse_GLDYS (role) --[[古老的钥匙]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 15			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 15			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 4096			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 4096			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000004 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000004")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000004		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	15	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	15	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	15	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_LDADYS (role) --[[鲁德安的遗书]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 16			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 16			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 4096			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 4096			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000005 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000005")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000005		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	16	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	16	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	16	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 


function ItemUse_YXYSJY (role) --[[隐形药水解药]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 18			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 18			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 1845			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 1841			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 1719			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 1715			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= "magicsea"			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000006 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000006")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000006		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	18	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	18	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	18	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_RYDKL (role) --[[人鱼的骷髅]]--

	local HasRecordID	= 287			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 20			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 19			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 20			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= 1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 184500			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 184100			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 171900			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 171500			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= "magicsea"			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000008 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000008")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000008		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000007 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000007")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000007		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	20	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	20	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	20	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	1	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 




function ItemUse_SXTCQ (role) --[[水下探测器]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 29			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 381			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 29			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= 2			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= 1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 375900			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 375500			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 125000			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 124600			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= "magicsea"			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000010 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000010")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000010		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000009 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000009")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000009		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	29	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	29	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	29	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	1	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	if ItemID ~= -1 then
		local Item_CanGet = GetChaFreeBagGridNum ( role )
		
		if Item_CanGet < 1 then
			CALCULATE_ITEMGETMISSION_LUA_000002 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000002")
			SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000002)
			UseItemFailed ( role )
			return
		end
	end

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_RJDYW (role) --[[日记的译文]]--

	local HasRecordID	= 290			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 21			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 21			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000011 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000011")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000011		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	21	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	21	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	21	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_HL (role) --[[海轮]]--

	local HasRecordID	= 315			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 22			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 22			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= 2			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000013 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000013")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000013			--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000012 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000012")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000012		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	22	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	22	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	22	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_WNYDYF (role) --[[万能药的药方]]--

	local HasRecordID	= 328			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 30			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 30			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000014 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000014")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000014		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	30	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	30	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	30	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_LZL (role) --[[龙之泪]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 24			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 24			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000015 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000015")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000015		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	24	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	24	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	24	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 

function ItemUse_BLP (role) --[[玻璃瓶]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 369			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= 1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 380200			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 379800			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 55200			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 54800			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= "darkblue"			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	-1	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	-1	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	-1	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	4257	--给与道具 ( -1 为不给 )
	local ItemNum		=	1	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	1	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 


function ItemUse_SS (role) --[[圣水]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 26			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 370			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 26			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000016 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000016")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000016		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	26	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	26	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	26	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_FHSDX (role) --[[粉红色的信]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 27			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 362			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 27			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000017 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000017")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000017		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	27	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	27	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	27	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 






function ItemUse_WYJ (role) --[[望远镜]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 28			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 375			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 28			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= -1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 0			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 0			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 0			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 0			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= -1			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000018 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000018")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000018		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	28	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	28	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	28	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 





function ItemUse_LDADYW2 (role) --[[鲁德安的遗物2]]--

	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local HasRecordID_1	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 14			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local NoRecordID_1	= -1			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= 273			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local HasMissionID_1	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 14			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local No_MissionID_1	= -1			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )
	local ChaType		= -1			-- 判断是否为人或船只 ( 1 为 人 , 2 为 船 , -1 为不判断 )
	local Need_CheckPos	= 1			-- 是否判断坐标 ( 1 为 判断 , -1 为不判断 , 如果不判断则坐标和地图均填 0 )
	local Cha_x_max		= 7900			-- 判断人物ID 的 X 坐标最大值
	local Cha_x_min		= 7500			-- 判断人物ID 的 X 坐标最小值
	local Cha_y_max		= 397300			-- 判断人物ID 的 Y 坐标最大值
	local Cha_y_min		= 396900			-- 判断人物ID 的 Y 坐标最小值
	local MapName		= "garner"			-- 判断人物所在地图名
	local GuildType		= -1			-- 判断人物的公会类型 ( 1 为海军 , 2 为海盗 , 0 为没有公会 , -1 为不判断 )
	local CheckType		= 1			-- 判断人物公会类型的方式 ( 1 为是某种公会类型 , 2 为不是某种公会类型 )


	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasRecordNotice_1  = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoRecordNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 NoRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local HasMissionNotice_1 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local NoMissionNotice_1	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 NoMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local CheckBoatNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 人或船 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000001 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000001")
	local CheckPosNotice	 = CALCULATE_ITEMGETMISSION_LUA_000001		--判断 坐标 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000019 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000019")
	local GuildTypeNotice	 = CALCULATE_ITEMGETMISSION_LUA_000019		--判断 公会类型 失败提示

	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
--	Notice("CheckMissionMsg_1 = "..CheckMissionMsg_1 ) 
	local CheckMissionMsg_2	 = MissionMsgCheck ( role , HasRecordID_1 , NoRecordID_1 , HasMissionID_1 , No_MissionID_1 , HasRecordNotice_1 , NoRecordNotice_1 , HasMissionNotice_1 , NoMissionNotice_1 )
--	Notice("CheckMissionMsg_2 = "..CheckMissionMsg_2 ) 
	local CheckChaMsg	 = ChaMsgCheck ( role , ChaType , Need_CheckPos ,Cha_x_max , Cha_x_min , Cha_y_max , Cha_y_min , MapName , GuildType , CheckType , CheckBoatNotice , CheckPosNotice ,GuildTypeNotice )
--	Notice("CheckChaMsg = "..CheckChaMsg ) 

	if CheckMissionMsg_1 ~= 1 or CheckMissionMsg_2 ~= 1 or CheckChaMsg ~= 1 then
		UseItemFailed ( role )
		return
	end





	local GiveMisson_1	=	14	--海军给与任务 (-1 为不给 )
	local GiveMisson_2	=	14	--海盗给与任务 (-1 为不给 )
	local GiveMisson_0	=	14	--无公会给与任务 ( -1 为不给 )
	local ItemID		=	-1	--给与道具 ( -1 为不给 )
	local ItemNum		=	0	--给与道具数量
	local Give_Exp		= 	-1	-- 要给与的经验 ( 如果为 -1 为不给 )
	local Give_Money	= 	-1	-- 要给与的钱 ( 如果为 -1 为不给 )
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )

	local Cha_GuildID = GetChaGuildID( role )
	
	local ChaGuildType_Get = -1
	if Cha_GuildID == 0 then
		ChaGuildType_Get = 0
	elseif Cha_GuildID > 0 and Cha_GuildID <= 100 then
		ChaGuildType_Get = 1
	elseif Cha_GuildID > 100 and Cha_GuildID <= 200 then
		ChaGuildType_Get = 2
	else
		CALCULATE_ITEMGETMISSION_LUA_000003 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000003")
		SystemNotice ( role , CALCULATE_ITEMGETMISSION_LUA_000003 )
	end

	
	if ChaGuildType_Get == 1 then
		if GiveMisson_1 ~= -1 then
			GiveMission( role, GiveMisson_1 )
		end
	end

	if ChaGuildType_Get == 2 then
		if GiveMisson_2 ~= -1 then
			GiveMission( role, GiveMisson_2 )
		end
	end

	if ChaGuildType_Get == 0 then
		if GiveMisson_0 ~= -1 then
			GiveMission( role, GiveMisson_0 )
		end
	end

	if ItemID ~= -1 then
		GiveItem ( role , 0 , ItemID , ItemNum , 0 )
	end



	if Give_Money > 0 then
		AddMoney ( role , 0 , Give_Money )
	end

	if Give_Exp > 0 then
		local exp = Exp ( role )
		if Lv ( TurnToCha ( role )  )  >= 80 then 
			Give_Exp = math.floor ( exp_dif / 50  ) 
		end 
		local exp_new = exp + Give_Exp
		
		SetCharaAttr ( exp_new , role , ATTR_CEXP )
	end


	if DelItem == 0 then
		UseItemFailed ( role )
		return
	end

end 



function ItemUse_JLYANG(role)   ----精灵养成须知
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1820			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1820			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示


	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6581	
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
	else
		GiveMission (role,GiveMisson_1)
	end
	
	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		--UseItemGiveMission ( role )
		UseItemFailed ( role )
	end
end


function ItemUse_PYJSS(role)   -----捕鱼介绍书
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1824			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1824			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6582
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		--UseItemGiveMission ( role )		
		UseItemFailed ( role )
	end
end


function ItemUse_HDZN(role)   -----海盗指南针
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1826			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1826			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6583
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		UseItemFailed ( role )		
		--UseItemGiveMission ( role )	
	end
end


function ItemUse_PKZYZ(role)  ---------PK指引证
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1835			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1835			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6584
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		UseItemFailed ( role )		
		--UseItemGiveMission ( role )	
	end
end



function ItemUse_FLMGZY(role)  ------废灵迷宫指引
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1838			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1838			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6585
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		UseItemFailed ( role )	
		--UseItemGiveMission ( role )			
	end
end


function ItemUse_HDWHZZY(role)  --------海盗王混战指引
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1839			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1839			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6586
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem		=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		UseItemFailed ( role )
	
		--UseItemGiveMission ( role )			
	end
end


function ItemUse_SZZYT(role) ------海盗王圣战指引
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1841			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1841			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )



	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000020 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000020")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000020		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000021 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000021")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000021		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	local GiveMisson_1	=	6587
	
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,GiveMisson_1)
	end

	local DelItem	=	0	--是否在使用后删除道具( 1 删, 0 不删 )
	
	if DelItem == 0 then
		UseItemFailed ( role )
	end
end




----------收徒帖--------------
function ItemUse_TD( role , Item )
	local Cha_Boat = 0
	Cha_Boat = GetCtrlBoat ( role )
	if Cha_Boat ~= nil then 
		CALCULATE_ITEMEFFECT_LUA_000044 = GetResString("CALCULATE_ITEMEFFECT_LUA_000044")
		SystemNotice( role , CALCULATE_ITEMEFFECT_LUA_000044 ) 
		UseItemFailed ( role ) 
		return 
	end
	local Item_CanGet = GetChaFreeBagGridNum ( role )
	if Item_CanGet < 2 then
		CALCULATE_ITEMGETMISSION_LUA_000022 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000022")
		SystemNotice(role ,CALCULATE_ITEMGETMISSION_LUA_000022)
		UseItemFailed ( role )
		return
	end		
	local ret = HasMaster(role)
	local lv = GetChaAttr(role, ATTR_LV)
		if ret == LUA_TRUE and lv <= 40 then
		GiveItem( role , 0 , 6049 , 1 , 4 )
		--GiveItem(role , 0 , 6017 , 5 , 4 )
		AddExpAll(role,10000,10000,1)
		elseif ret == LUA_TRUE and lv > 40 then 
			CALCULATE_ITEMGETMISSION_LUA_000023 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000023")
			SystemNotice(role, CALCULATE_ITEMGETMISSION_LUA_000023)
			UseItemFailed ( role)
		elseif ret == LUA_FALSE then
			CALCULATE_ITEMGETMISSION_LUA_000023 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000023")
			SystemNotice(role, CALCULATE_ITEMGETMISSION_LUA_000023)
			UseItemFailed ( role)
		end

end


function ItemUse_STJSHAO (role)   ---海盗拜师说明书
	local HasRecordID	= -1			-- 判断是否带有某记录 ( 填要判断的记录 ID , -1 为不判断 )
	local NoRecordID	= 1825			-- 判断是否不带有某记录 ( 填要判断的记录 ID , -1为不判断 )
	local HasMissionID	= -1			-- 判断是否带有某任务 ( 填要判断的任务 ID , -1 为不判断 )
	local No_MissionID	= 1825			-- 判断没有带某任务 ( 填要判断的任务 ID ,-1 为不判断 )

	local HasRecordNotice	 = ""		--判断 HasRecord 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000024 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000024")
	local NoRecordNotice	 = CALCULATE_ITEMGETMISSION_LUA_000024		--判断 NoRecord 失败提示
	local HasMissionNotice	 = ""		--判断 HasMission 失败提示
	CALCULATE_ITEMGETMISSION_LUA_000025 = GetResString("CALCULATE_ITEMGETMISSION_LUA_000025")
	local NoMissionNotice	 = CALCULATE_ITEMGETMISSION_LUA_000025		--判断 NoMission 失败提示
	
	local CheckMissionMsg_1  = MissionMsgCheck ( role , HasRecordID , NoRecordID , HasMissionID , No_MissionID , HasRecordNotice , NoRecordNotice , HasMissionNotice , NoMissionNotice )
	if CheckMissionMsg_1 ~= 1  then
		UseItemFailed ( role )
		else
		GiveMission (role,6589)
		--UseItemGiveMission ( role )	
		UseItemFailed ( role)
	end
end 
