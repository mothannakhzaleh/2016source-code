--------------------------------------------------------------------------
--									--
--									--
--				exp_and_level.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Exp_And_Level.lua" )


--此处放置经验值和级别有关的计算

InTeamGetExp_RAID = 1

--创建工会的物品检测
function AskGuildItem(role,Guild_type)
	local gold = GetChaAttr(role,ATTR_GD)
	local fame = GetChaAttr(role,ATTR_FAME) 
	local attr_guild = HasGuild ( role ) 
	if attr_guild ~= 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000001 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000001")
		HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000001)
		--SystemNotice(role,0,"已有所属工会")
		return 0 
	end 
	local Lv = Lv ( role )
	if Lv < 40 then
		CALCULATE_EXP_AND_LEVEL_LUA_000002 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000002")
		SystemNotice ( role , CALCULATE_EXP_AND_LEVEL_LUA_000002 )
		return 0
	end

	if Guild_type == 1 then						--判定海盗工会
		if Guild2_ItemMax > 0 then
			for i = 1 , Guild2_ItemMax , 1 do
				local K = Check_BagItem(role,Guild2_item[i],Guild2_count[i])
				if K == 0 then
					CALCULATE_EXP_AND_LEVEL_LUA_000003 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000003")
					HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000003)
					--SystemNotice(role,0,"道具不足无法创建")
					return 0
				end
			end
		end

		if gold < Guild2_Gold then
			CALCULATE_EXP_AND_LEVEL_LUA_000004 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000004")
			HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000004)
			--SystemNotice(role,0,"金钱不足无法创建")
			return 0
		end
		if fame < Guild2_fame then
			CALCULATE_EXP_AND_LEVEL_LUA_000005 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000005")
			HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000005)
			--SystemNotice(role,0,"声望不足无法创建")
			return 0
		end
	elseif Guild_type == 0 then					--判定海军工会
		if Guild1_ItemMax > 0 then
			for i = 1 , Guild1_ItemMax , 1 do
				local K = Check_BagItem(role,Guild1_item[i],Guild1_count[i])
				if K == 0 then
					CALCULATE_EXP_AND_LEVEL_LUA_000003 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000003")
					HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000003)
					--SystemNotice(role,0,"道具不足无法创建")
					return 0
				end
			end
		end
		if gold < Guild1_Gold then
			CALCULATE_EXP_AND_LEVEL_LUA_000004 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000004")
			HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000004)
			--SystemNotice(role,0,"金钱不足无法创建")
			return 0
		end
		if fame < Guild1_fame then
			CALCULATE_EXP_AND_LEVEL_LUA_000005 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000005")
			HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000005)
			--SystemNotice(role,0,"声望不足无法创建")
			return 0
		end
	else
		--LG("checkguild","工会类型错误  Guild_type = ",Guild_type)
	end
	return 1
end 

function Check_BagItem(role,a,b)		--检查背包数量是否足够
	local a = CheckBagItem ( role , a ) 
	if a>= b then 
		return 1 
	else 
		return 0 
	end 
end 
		


--删除创建工会所需物品
function DeductGuildItem(role,Guild_type)
	local gold = GetChaAttr(role,ATTR_GD)
	local fame = GetChaAttr(role,ATTR_FAME) 
	local attr_guild = HasGuild ( role )  
--	if attr_guild ~= 0 then 
--		HelpInfo(role,0,"已有所属工会") 
		--SystemNotice(role,0,"已有所属工会") 
--		return 0 
--	end 

	if Guild_type == 1 then						--判定海盗工会
--		if Guild2_ItemMax > 0 then
--			for i = 1 ,Guild2_ItemMax,1 do
--				local K = DelBagItem(role,Guild2_item[i],Guild2_count[i])
--			end
--		end
		DelBagItem(role,1780,1)	
		gold = gold - Guild2_Gold
		fame = fame - Guild2_fame
		SetAttrChangeFlag ( role )

		SetChaAttr(role,ATTR_GD,gold)
		SetChaAttr(role,ATTR_FAME,fame)

		SyncChar( role, 4 )
	
	elseif Guild_type == 0	then					--判定海军工会
--		if Guild1_ItemMax > 0 then
--			for i = 1 ,Guild1_ItemMax,1 do
--				local K = DelBagItem(role,Guild1_item[i],Guild1_count[i])
--			end
--		end
		DelBagItem(role,1780,1)	
		gold = gold - Guild1_Gold
		fame = fame - Guild1_fame
		SetAttrChangeFlag ( role )

		SetChaAttr(role,ATTR_GD,gold)
		SetChaAttr(role,ATTR_FAME,fame)

		SyncChar( role, 4 )
	else
		--LG("checkguild","工会类型错误  Guild_type = ",Guild_type)
	end

end
	

function AskJoinGuild ( role , guild_type ) 					-- 申请加入工会判定   工会类型 0－海军，1－海盗
	local attr_guild = HasGuild ( role )  
	if attr_guild ~= 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000001 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000001")
		HelpInfo(role,0,CALCULATE_EXP_AND_LEVEL_LUA_000001) 
		--SystemNotice(role,0,"已有所属工会") 
		return 0 
	end 
--	local fame = GetChaAttr ( role , ATTR_FAME ) 
--	if guild_type == 0 then 
--		if fame < JOINGUILD_NAVY_FAME then 
--			HelpInfo(role,0,"海军名声不足") 
--			--SystemNotice(role,0,"海军名声不足") 
--			return 0 
--		end 
--	elseif guild_type == 1 then 
--		if fame > JOINGUILD_PIRATE_FAME then 
--			HelpInfo(role,0,"海盗名声不足") 
--			--SystemNotice(role,0,"海盗名声不足") 
--			return 0 
--		end 
--	end 
	return 1 
end 

			



--经验分配(包含组队经验分配)
--当有角色死亡时被调用
function GetExp_New(dead , atk  ) 
	if ValidCha(atk) == 0  then 
		LG ( "exp_atker=NIL" , "function GetExp_New : atker = nil " ) 
		return 
	end 
	local a = Check_Combat_Mod(dead , atk ) 
	if a==1 then 
		--LG("exp" , " enter  pkm mod" ) 
		
		local rolemod_atker = IsPlayer(atk) 
		local rolemod_defer = IsPlayer(dead)  --检查角色种类：0、怪物， 1、玩家
		
		local MonsterID = GetChaID(dead)
		if rolemod_atker == 1 and rolemod_defer == 0 and MonsterID == 75 then
			local Item_CanGet = GetChaFreeBagGridNum ( atk )
			if Item_CanGet < 1 then
				CALCULATE_EXP_AND_LEVEL_LUA_000006 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000006")
				SystemNotice(atk , CALCULATE_EXP_AND_LEVEL_LUA_000006)
				return 0
			end			
			
			for i=0,5,1 do
			
				local NewKey_count = CheckBagItem ( atk , NewKey_Id[i] ) --检查随机类箱子的钥匙数量
				local NewBox_count = CheckBagItem ( atk , NewBox_Id[i] ) --检查随机类箱子数量				
				if NewBox_count >= 1 and NewKey_count >= 1 then
					TakeItem( atk , 0 , NewKey_Id[i] , 1)
					TakeItem( atk , 0 , NewBox_Id[i] , 1)					
					NewBox_ItemEffect[i]( atk , Item )
					
					return 1
				end
			end	

			for i=6,NewBox_Maxcount,1 do
			
				local NewBox_count = CheckBagItem ( atk , NewBox_Id[i] ) --检查随机类箱子数量
				if NewBox_count >= 1 then
					TakeItem( atk , 0 , NewBox_Id[i] , 1)	
					NewBox_ItemEffect[i]( atk , Item )
				
					return 1
				end
			end	
		
			

			
		end

		if rolemod_atker == 1 and rolemod_defer == 0 and MonsterID == 1143 then		
			local Item_CanGet = GetChaFreeBagGridNum ( atk )
			if Item_CanGet < 1 then
				CALCULATE_EXP_AND_LEVEL_LUA_000007 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000007")
				SystemNotice(atk , CALCULATE_EXP_AND_LEVEL_LUA_000007)
				UseItemFailed ( atk )
				return
			end
			
			local lv= GetChaAttr(atk, ATTR_LV) 
			if lv <40 then
				CALCULATE_EXP_AND_LEVEL_LUA_000008 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000008")
				SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000008 )
				UseItemFailed ( atk )
				return	
			end
			
			local Has_BOXBOX = CheckBagItem ( atk , 6359 )
			if Has_BOXBOX >= 1 then
				CALCULATE_EXP_AND_LEVEL_LUA_000009 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000009")
				SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000009 )
				UseItemFailed ( atk )
				return
			end
			GiveItem ( atk , 0 , 6359 , 1 , 0 )
		end
		
		local exp1= GetChaAttr(atk,ATTR_CEXP)
		GetExp_PKM( dead , atk ) --[[player kill monster]]--
		local exp2= GetChaAttr(atk,ATTR_CEXP)
		local expaddZB=exp2-exp1
		expaddZB=ZBexpadd(atk,expaddZB)
		if expaddZB <1 then
			expaddZB=1
		end 
		XSJYCunChu(atk,expaddZB)
		local expZB= exp1+expaddZB
		GetServeNow(atk)
		DropHJJZ(dead,atk)
		SetChaAttr(atk,ATTR_CEXP,expZB)
		--GetExp_PKM( dead , atk ) --[[player kill monster]]--
		--挖宝任务怪40级以上附加经验op--by—locke.coco
		if rolemod_atker == 1 and rolemod_defer == 0 then
			if MonsterID == 1144 or MonsterID == 1145 or MonsterID == 1146 or MonsterID == 1147 or MonsterID == 1148 or MonsterID == 1149 or MonsterID == 1150 then
				getmuchexpbf (atk)
			end
		end
		--挖宝任务怪40级以上附加经验ed
		
	elseif a==2 then 
	--LG("exp" , " enter  mkp mod" ) 
----------------项链扣除
		local cha = TurnToCha ( dead )
		local Cha_Num = GetChaTypeID( cha )
-------a=2--------------魔剑移除
		local mojian1 = GetEquipItemP( dead , 9 )
		local mojian1_id = GetItemID ( mojian1 )
		if  mojian1_id == 6347 then
			WaBao_MJdiaoluo( dead)
			RemoveChaItem ( dead , mojian1_id , 1 , 0 , -1, 0 , 1  )
		end		
		local mojian2 = CheckBagItem ( dead , 6347 )
			if mojian2 > 0 then
			WaBao_MJdiaoluo( dead)
			RemoveChaItem ( dead , 6347 , 1 , 2 , -1, 0 , 1  )
			end
	GetExp_MKP(dead , atk) --[[monster kill player]]--
	elseif a==3 then 
	--LG("exp" , " enter  pkp mod" ) 
-----------宙斯套装
		local CheckItem_ZHOUSI  = CheckItem_ZHOUSI ( dead )
		--local sklv = 1
---		SystemNotice(dead,"CheckItem_ZHOUSI=="..CheckItem_ZHOUSI)
		if CheckItem_ZHOUSI == 1 then
			local t = {} 
			t[0] = atk  
			t[1] = GetTeamCha(atk, 0 )  
			t[2] = GetTeamCha(atk, 1 )   
			t[3] = GetTeamCha(atk, 2 )    
			t[4] = GetTeamCha(atk, 3 )
			local i=0
			for i=0,4,1 do
				if ValidCha (t[i]) ~= 0 then 
					local cha_name = GetChaDefaultName (t[i] )
					local hp = GetChaAttr( t[i] , ATTR_HP ) 
					local sp = GetChaAttr( t[i] , ATTR_SP ) 
					local  hp_add = math.floor(hp*0.5)
					local  sp_add = math.floor(sp*0.5)
					Sp_Red (t[i], sp_add) 
					Hp_Dmg(t[i],hp_add)								
					CALCULATE_EXP_AND_LEVEL_LUA_000010 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000010")
					Notice (CALCULATE_EXP_AND_LEVEL_LUA_000010)
--					Notice(dead,"杀人者"..i.."  伤血完毕")
				end 
			end
		end
----------------项链扣除
		local cha = TurnToCha ( dead )
		local Cha_Num = GetChaTypeID( cha )
---------------戒指移除
-------a=3--------------魔剑移除
		local mojian3 = GetEquipItemP( dead , 9 )
		local mojian3_id = GetItemID ( mojian3 )
		if  mojian3_id == 6347 then
			WaBao_MJdiaoluo( dead)
			RemoveChaItem ( dead , mojian3_id , 1 , 0 , -1, 0 , 1  )
		end		
		local mojian4 = CheckBagItem ( dead , 6347 )
		if mojian4 > 0 then
		WaBao_MJdiaoluo( dead)
		RemoveChaItem ( dead , 6347 , 1 , 2 , -1, 0 , 1  )
		end
		
---------------证书移除
		local qingbao = CheckBagItem(dead,6322)
		if qingbao ~= 0 then
			RemoveChaItem( dead , 6322 , 1 , 2 , -1, 0 , 1  )
		end
---竞技场
---------竞技场死亡掉落花花草草
	GetExp_PKP(dead , atk) --[[player kill player]]--
	elseif a==4 then 
	--LG("exp" , " enter  mkm mod" ) 
	GetExp_Noexp(dead , atk) --[[monster kill monster]]--
	else 
	--LuaPrint("无法判定经验获得模式".."\n") return 
	end 
	
end 


function WaBao_MJdiaoluo( dead)------------魔剑掉落(拥有者死亡)公告
	local x, y = GetChaPos(dead)
	local name = GetChaDefaultName(dead)
	local map_role = GetChaMapName ( dead )
	local map_role_name = 0
	

		if map_role == "garner" then
			CALCULATE_EXP_AND_LEVEL_LUA_000011 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000011")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000011
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "magicsea" then	
			CALCULATE_EXP_AND_LEVEL_LUA_000016 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000016")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000016	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "darkblue" then
			CALCULATE_EXP_AND_LEVEL_LUA_000017 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000017")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000017
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "eastgoaf" then
			CALCULATE_EXP_AND_LEVEL_LUA_000018 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000018")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000018
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "lonetower" then	
			CALCULATE_EXP_AND_LEVEL_LUA_000019 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000019")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000019	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "secretgarden" then
			CALCULATE_EXP_AND_LEVEL_LUA_000020 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000020")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000020
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "darkswamp" then
			DARKSWAMP_ENTRY_LUA_000004 = GetResString("DARKSWAMP_ENTRY_LUA_000004")
			local map_role_name = DARKSWAMP_ENTRY_LUA_000004
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "abandonedcity" then	
			ABANDONEDCITY_ENTRY_LUA_000006 = GetResString("ABANDONEDCITY_ENTRY_LUA_000006")
			local map_role_name = ABANDONEDCITY_ENTRY_LUA_000006	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "abandonedcity2" then
			ABANDONEDCITY2_ENTRY_LUA_000001 = GetResString("ABANDONEDCITY2_ENTRY_LUA_000001")
			local map_role_name = ABANDONEDCITY2_ENTRY_LUA_000001
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "abandonedcity3" then
			ABANDONEDCITY3_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY3_ENTRY_LUA_000002")
			local map_role_name = ABANDONEDCITY3_ENTRY_LUA_000002
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "puzzleworld" then	
			PUZZLEWORLD_ENTRY_LUA_000007 = GetResString("PUZZLEWORLD_ENTRY_LUA_000007")
			local map_role_name = PUZZLEWORLD_ENTRY_LUA_000007	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "puzzleworld2" then
			PUZZLEWORLD2_ENTRY_LUA_000002 = GetResString("PUZZLEWORLD2_ENTRY_LUA_000002")
			local map_role_name = PUZZLEWORLD2_ENTRY_LUA_000002
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "teampk" then
			CALCULATE_EXP_AND_LEVEL_LUA_000021 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000021")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000021
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "jialebi" then	
			BIRTH_BIRTH_CONF_LUA_000048 = GetResString("BIRTH_BIRTH_CONF_LUA_000048")
			local map_role_name = BIRTH_BIRTH_CONF_LUA_000048	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "garner2" then
			GARNER2_ENTRY_LUA_000014 = GetResString("GARNER2_ENTRY_LUA_000014")
			local map_role_name = GARNER2_ENTRY_LUA_000014
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "hell" then
			CALCULATE_EXP_AND_LEVEL_LUA_000022 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000022")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000022
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
										
		elseif map_role == "hell2" then	
			CALCULATE_EXP_AND_LEVEL_LUA_000023 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000023")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000023	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "hell3" then
			CALCULATE_EXP_AND_LEVEL_LUA_000024 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000024")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000024
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "hell4" then
			CALCULATE_EXP_AND_LEVEL_LUA_000025 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000025")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000025
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "hell5" then	
			CALCULATE_EXP_AND_LEVEL_LUA_000026 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000026")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000026	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "guildwar" then
			CALCULATE_EXP_AND_LEVEL_LUA_000027 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000027")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000027
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "leiting2" then
			LEITING2_ENTRY_LUA_000008 = GetResString("LEITING2_ENTRY_LUA_000008")
			local map_role_name = LEITING2_ENTRY_LUA_000008
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "shalan2" then	
			BIRTH_BIRTH_CONF_LUA_000050 = GetResString("BIRTH_BIRTH_CONF_LUA_000050")
			local map_role_name = BIRTH_BIRTH_CONF_LUA_000050	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "binglang2" then
				BINGLANG2_ENTRY_LUA_000010 = GetResString("BINGLANG2_ENTRY_LUA_000010")
				local map_role_name = BINGLANG2_ENTRY_LUA_000010
				CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
				CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
				CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
				CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
				ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "guildwar2" then
			CALCULATE_EXP_AND_LEVEL_LUA_000028 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000028")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000028
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "yschurch" then	
			BIRTH_BIRTH_CONF_LUA_000051 = GetResString("BIRTH_BIRTH_CONF_LUA_000051")
			local map_role_name = BIRTH_BIRTH_CONF_LUA_000051	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "07xmas" then
			A07XMAS_ENTRY_LUA_000005 = GetResString("A07XMAS_ENTRY_LUA_000005")
			local map_role_name = A07XMAS_ENTRY_LUA_000005
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "sdBoss" then
			CALCULATE_EXP_AND_LEVEL_LUA_000029 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000029")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000029
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "07xmas2" then	
			A07XMAS2_ENTRY_LUA_000005 = GetResString("A07XMAS2_ENTRY_LUA_000005")
			local map_role_name = A07XMAS2_ENTRY_LUA_000005	
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
						
		elseif map_role == "prisonisland" then
			BIRTH_BIRTH_CONF_LUA_000052 = GetResString("BIRTH_BIRTH_CONF_LUA_000052")
			local map_role_name = BIRTH_BIRTH_CONF_LUA_000052
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )

		elseif map_role == "winterland" then
			BIRTH_BIRTH_CONF_LUA_000053 = GetResString("BIRTH_BIRTH_CONF_LUA_000053")
			local map_role_name = BIRTH_BIRTH_CONF_LUA_000053
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "mjing1" then
			CALCULATE_EXP_AND_LEVEL_LUA_000033 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000033")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000033
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "mjing2" then
			CALCULATE_EXP_AND_LEVEL_LUA_000034 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000034")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000034
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "mjing3" then
			CALCULATE_EXP_AND_LEVEL_LUA_000035 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000035")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000035
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
					
		elseif map_role == "mjing4" then
			CALCULATE_EXP_AND_LEVEL_LUA_000036 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000036")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000036
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
								
		elseif map_role == "mingyun" then
			CALCULATE_EXP_AND_LEVEL_LUA_000037 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000037")
			local map_role_name = CALCULATE_EXP_AND_LEVEL_LUA_000037
			CALCULATE_EXP_AND_LEVEL_LUA_000012 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000012")
			CALCULATE_EXP_AND_LEVEL_LUA_000013 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000013")
			CALCULATE_EXP_AND_LEVEL_LUA_000014 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000014")
			CALCULATE_EXP_AND_LEVEL_LUA_000015 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000015")
			ScrollNotice(CALCULATE_EXP_AND_LEVEL_LUA_000015..name..CALCULATE_EXP_AND_LEVEL_LUA_000014..map_role_name..CALCULATE_EXP_AND_LEVEL_LUA_000013..math.floor(x/100)..","..math.floor(y/100)..CALCULATE_EXP_AND_LEVEL_LUA_000012, 1 )
		end
end



function Check_Combat_Mod(dead , atk) --[[判定经验奖惩方式]]-- 
	--LuaPrint("Enter function Check_Combat_Mod () --[[判定经验奖惩方式]]-- ") 
	local rolemod_atker = IsPlayer(atk) 
	--LG("exp" , " atker role = " ,  rolemod_atker ) 
	local rolemod_defer = IsPlayer(dead)  --检查角色种类：0、怪物， 1、玩家
	--LG("exp" , " defer role = " ,  rolemod_defer ) 
	if (rolemod_atker==0) and (rolemod_defer==0) then 
		return 4 
	elseif rolemod_atker==0 and rolemod_defer==1 then 
		return 2 
	elseif rolemod_atker==1 and rolemod_defer==0 then 
		return 1 
	elseif rolemod_atker==1 and rolemod_defer==1 then 
		return 3 
	else 
		--LuaPrint("错误的角色类型值".."\n") 
		return 
	end 
	--LuaPrint("Out function Check_Combat_Mod () --[[判定经验奖惩方式]]-- ") 
end 




function GetExp_PKM( dead , atk  ) --[[player kill monster 经验值获得公式 所得exp＝exp(d)/math.floor(|lv(a)-lv(b)|*0.1+1)]]--
--	SystemNotice ( atk , "GetExp_PKM")
--	LG ( "exp" , " enter getexp " ) 
	--SystemNotice ( atk , "进入GetExp_PKM")
--	local EXP_RAID_STATE = 1
--	local StateLv = GetChaStateLv ( atk , STATE_SBJYGZ )


--	if StateLv >= 0 and StateLv <= 10 then
--			EXP_RAID_STATE = StateLv + 1
--	end

	local dead_lv = GetChaAttrI( dead , ATTR_LV ) --获得死者的等级   
	local dead_exp = GetChaAttrI( dead , ATTR_CEXP ) * EXP_RAID
	LG("exp" , "deadlv = " , dead_lv ) 
	LG("exp" , "dead_exp = " , dead_exp ) 
	local k = {} 
	local kdmg = {} 
	local k_exp = {} 

	k[0] , kdmg[0] = GetChaHarmByNo ( dead , 0 ) 
--	if ValidCha ( k[0] ) == 0 then 
--		SystemNotice ( atk , "伤害列表首位为空" ) 
--	end 
	--SystemNotice ( atk , "攻击伤害排位0号") 
	--SystemNotice ( atk , "攻击伤害为"..kdmg[0]) 

	k[1] , kdmg[1] = GetChaHarmByNo ( dead , 1 ) 
--	if ValidCha ( k[1] ) == 0 then 
--		SystemNotice ( atk , "伤害列表2位为空" ) 
--	end 
	--SystemNotice ( atk , "攻击伤害排位1号") 
	--SystemNotice ( atk , "攻击伤害为"..kdmg[1]) 

	k[2] , kdmg[2] = GetChaHarmByNo ( dead , 2 ) 
--	if ValidCha ( k[2] ) == 0 then 
--		SystemNotice ( atk , "伤害列表3位为空" ) 
--	end 
	--SystemNotice ( atk , "攻击伤害排位2号") 
	--SystemNotice ( atk , "攻击伤害为"..kdmg[2]) 

	k[3] , kdmg[3] = GetChaHarmByNo ( dead , 3 ) 
--	if ValidCha ( k[3] ) == 0 then 
--		SystemNotice ( atk , "伤害列表4位为空" ) 
--	end 
	--SystemNotice ( atk , "攻击伤害排位3号") 
	--SystemNotice ( atk , "攻击伤害为"..kdmg[3]) 

	k[4] , kdmg[4] = GetChaHarmByNo ( dead , 4 ) 
--	if ValidCha ( k[4] ) == 0 then 
--		SystemNotice ( atk , "伤害列表5位为空" ) 
--	end 
	--SystemNotice ( atk , "攻击伤害排位4号") 
	--SystemNotice ( atk , "攻击伤害为"..kdmg[4]) 
	local first_atker = GetFirstAtker ( dead ) 
	
	local Gen_dmg = 0 

	for i = 0 , 4 , 1 do 
		if k[i] ~= 0 then 
			Gen_dmg = Gen_dmg + kdmg[i] 
			--SystemNotice ( atk , "攻击伤害指针不为0的排位"..i) 
			--SystemNotice ( atk , "攻击伤害为"..kdmg[i]) 
		end 
	end 
	--SystemNotice ( atk , "总攻击伤害为"..Gen_dmg) 
	for i = 0 , 4 , 1 do 
		k_exp[i] = 0 

		if ValidCha( k[i] )== 1 then 
			if kdmg[i] > 0 then 
				if k[i] == first_atker then 
					k_exp[i] = dead_exp * ( 0.7 * kdmg[i] / Gen_dmg + 0.3 )		--第一位攻击者优先获得30％的怪物总经验
				else
					k_exp[i] =  dead_exp * 0.7 * kdmg[i] / Gen_dmg 
				end
				--SystemNotice ( atk , "攻击伤害排位"..i) 
				--SystemNotice ( atk , "分配到exp"..k_exp[i]) 
				ShareTeamExp ( dead , k[i] , k_exp[i] ,atk ) 
			end 
		end 
	end 
	local item_host = 0 
	local exp_max = k_exp[0] 
	--SystemNotice ( atk , "道具初始归属排位"..0) 
	for i = 1 , 4 , 1 do 
		--SystemNotice ( atk , "道具归属判定"..i) 
		--SystemNotice ( atk , "经验份额"..k_exp[i])

		if k_exp [i] > exp_max  then 
			exp_max = k_exp[i] 
			item_host = i 
			--SystemNotice ( atk , "道具更改归属排位"..i) 
		end 
	end 
	if ChaIsBoat (k[item_host] ) == 1 then 

		local ship_lv = GetChaAttr ( k[item_host] , ATTR_LV ) 
		local shipowner_lv  = GetChaAttr ( TurnToCha ( k[item_host] ) , ATTR_LV )  
		local ship_exp = GetChaAttr ( k[item_host] , ATTR_CEXP ) 
		local ship_expadd = math.floor ( math.min ( 7 , ( dead_lv / 10 + 2 ) ) ) 
		local lv_limit = math.min ( ship_lv , shipowner_lv ) - 10 
		if dead_lv >= lv_limit then 
			ship_exp = ship_exp + ship_expadd 
			SetCharaAttr (  ship_exp , k[item_host] ,ATTR_CEXP ) 
--			SystemNotice ( k[item_host] , "增加船只熟练"..ship_expadd ) 

		end 
	end 
	SetItemHost ( dead , k[item_host] ) 

end 


function ValidCha(ter)
  if ter==nil or ter==0 then 
	return 0 
  end
  return 1
end

function ShareTeamExp ( dead , team_atker , dead_exp , The_Killer) 
	local cha_name1100 = GetChaDefaultName (team_atker )	
	local star111=GetChaAttr (  team_atker , ATTR_CEXP )----------当前等级经验
	CALCULATE_EXP_AND_LEVEL_LUA_000038 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000038")
	CALCULATE_EXP_AND_LEVEL_LUA_000039 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000039")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG("star_exp" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name1100..CALCULATE_EXP_AND_LEVEL_LUA_000039..star111..CALCULATE_EXP_AND_LEVEL_LUA_000038 ) 
	local atker_role = ChaIsBoat ( team_atker ) 
	local monster_location = IsChaInLand ( dead ) 
	if atker_role == 1 and monster_location == 1 then 
		dead_exp = math.floor ( dead_exp / 5 + 1 ) 
	end 

	--SystemNotice ( team_atker , "进入ShareTeamExp")

	local dead_lv = GetChaAttrI( dead , ATTR_LV )			--获得死者的等级   
	--local team_atker = TurnToCha ( team_atker )				--转成人指针
	local t = {} 
	t[0] = team_atker  
	if ValidCha (team_atker) == 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000041 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000041")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000041 ) 
		return 
	end 
	t[1] = GetTeamCha(team_atker, 0 )  
	t[2] = GetTeamCha(team_atker, 1 )   
	t[3] = GetTeamCha(team_atker, 2 )    
	t[4] = GetTeamCha(team_atker, 3 )
    
    --SystemNotice ( team_atker , "aaaa")
--	LG("harm", "t[0] = ", t[0]," t[1] = ", t[1], "t[2] = ", t[2])
--	LG("harm", "\n")
    --local notice = "t[1]="..t[1].." t[2]="..t[2].." t[3]="..t[3].." t[4]="..t[4]
    ----SystemNotice ( team_atker , notice)
    --SystemNotice ( team_atker , "bbbb")
	
    
	local count = 0 
	local NewPlayer_CanGet = 0
	local NewPlayer_Lv = 0
	local NewPlayer_Lv_dif = -100
	local Check_Killer = 0
	if t[0] == The_Killer then
		Check_Killer = 1
	end
	for i = 0 , 4 , 1 do	
		if ValidCha( t[i] )== 1  then					--被加入组队经验分配的角色必须存在，且对队伍经验的加成和分享也仅由有效成员数起作用
			--SystemNotice(team_atker, "开始调用CheckExpShare")
			a = CheckExpShare ( t[i] , team_atker ) 
			--SystemNotice(team_atker, "结束调用CheckExpShare, 返回值="..a)
			if a == 1 then 
				count = count + 1 
				NewPlayer_Lv = Lv( TurnToCha(t[i]) )
				NewPlayer_Lv_dif = dead_lv - NewPlayer_Lv
				if NewPlayer_Lv <=30 and NewPlayer_Lv >= 10 and NewPlayer_Lv_dif >= -5 then
					NewPlayer_CanGet = NewPlayer_CanGet + 1
				end
			end 
		end 
        end 
	if count == 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000042 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000042")
		LG ("luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000042 )
		return 
	end 
	local TeamExp_Increas = 0.25 * TeamExp_RAID

	--SystemNotice ( team_atker , "被计入经验共享队员数count="..count)
	LG("exp" , "deadlv = " , dead_lv ) 
	LG("exp" , "dead_exp = " , dead_exp ) 
	LG("exp" , "teamer_count = " , count ) 
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
	local exp_add = math.floor( dead_exp * ( 1 + (count -1 )* TeamExp_Increas ) ) --总经验
	local exp_increase = math.floor ( dead_exp * (count -1 )* TeamExp_Increas ) --附加经验

---BB调整

	LG("exp" , "exp_add = " , exp_add ) 

	if count >=2 then
		exp_add = exp_add * InTeamGetExp_RAID
	end

	local exp_up

    --SystemNotice ( team_atker , "开始为队员分配经验")
	for i = 0 , 4 , 1 do	
		if ValidCha(t[i])==1 then			--角色不为空
			local a = 1							--初始化角色在开始时是否分配经验的监测系数
			local b = 1							--初始化角色在开始时分配经验的倍数系数
			LG("exp" , "loop = " , i ) 

			if i >= 1 then 
--				t[i] = TurnToCha ( t[i] )			            --转成人指针
				a = CheckExpShare ( t[i] , team_atker ) 		--经验分配检测 
				CALCULATE_EXP_AND_LEVEL_LUA_000043 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000043")
				LG("exp" , CALCULATE_EXP_AND_LEVEL_LUA_000043 , a ) 
				exp_up = math.max (1,  math.floor ( exp_add/count ) )  * a 
				LG("exp" , "exp_up1  =  " , exp_up ) 
			else 
				exp_up = math.max ( 1, math.floor ( exp_add/count ) )  
				LG("exp" , "exp_up1  =  " , exp_up ) 
				--对直接杀怪者做特殊处理 
			end 

			t_lv = GetChaAttrI ( TurnToCha(t[i]) , ATTR_LV ) 

			lv_dis =  t_lv - dead_lv 	--与怪物等级差对经验获取倍数的判断
			LG ( "exp" , " t_lv = " , t_lv , "  dead_lv = " , dead_lv , "  lv_dis = " , lv_dis ) 
			if lv_dis >= 4 then 
				b = math.min ( 10 , 1 + ( math.abs ( lv_dis - 4 ) * 0.4 ) )  --与怪物等级差距过大，无法获得全额经验
			elseif lv_dis <= -1 * 10 then 
				b = math.min ( 4 , 1 + math.abs ( lv_dis - 10)  * 0.1 )      --与怪物等级差距过大，无法获得全额经验 
			end 
			LG ( "exp" , "exp_up2 =  " , exp_up , " b = " , b , " a = ", a ) 

			exp_up = math.floor ( math.max ( 1 , exp_up / b ) ) * a 

			LG ( "exp" , "exp_up3 =  " , exp_up) 
			
			if count >=3 and NewPlayer_CanGet <= 0 and Check_Killer == 1 then				---判断获得组队贡献点数
				if lv_dis <=3 then
					Add_RYZ_TeamPoint ( TurnToCha(t[i]) , count , 1)
				end
			end
			if t_lv >= 50 and NewPlayer_CanGet > 0 and Check_Killer == 1 then
				Add_RYZ_TeamPoint ( TurnToCha(t[i]) , 6 , NewPlayer_CanGet)
			end

			exp = GetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP ) 
			LG("exp" , "exp_original = " , exp ) 
			local EXP_RAID_STATE = 1
			local StateLv = GetChaStateLv ( t[i] , STATE_SBJYGZ )
			EXP_RAID_STATE=SBStateBS[StateLv]

			local Item_ZHONGSHEN = CheckItem_ZHONGSHEN(TurnToCha(t[i]))
			if SBStateYXJxinyun[StateLv]~=0 or Item_ZHONGSHEN==1 then
				local CheckLucky = 0
				CheckLucky = CheckLuckyFinish ( StateLv )
				if CheckLucky == 1 then
					EXP_RAID_STATE = EXP_RAID_STATE * 2
					CALCULATE_EXP_AND_LEVEL_LUA_000044 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000044")
					SystemNotice ( TurnToCha(t[i]) , CALCULATE_EXP_AND_LEVEL_LUA_000044 )
				end
				if CheckLucky == 2 then
					EXP_RAID_STATE = 10
					CALCULATE_EXP_AND_LEVEL_LUA_000045 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000045")
					SystemNotice ( TurnToCha(t[i]) , CALCULATE_EXP_AND_LEVEL_LUA_000045 )
				end
			end
---------------------众神的庇护			
			if exp_up == 0 then 
				CALCULATE_EXP_AND_LEVEL_LUA_000046 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000046")
				LG ( "exp" , CALCULATE_EXP_AND_LEVEL_LUA_000046 ) 
				return 
			end
			EXP_RAID_STATE=ZB8Debuff(TurnToCha(t[i]),EXP_RAID_STATE)
			exp_up = exp_up * EXP_RAID_STATE
			

---------------------------------------精灵加经验状态判断
			--local Check_star = {}
			--	Check_star[0] = t[i]  
			--	Check_star[1] = GetTeamCha( t[i] , 0 )  
			--	Check_star[2] = GetTeamCha( t[i] , 1 )   
			--	Check_star[3] = GetTeamCha( t[i] , 2 )    
			--	Check_star[4] = GetTeamCha( t[i] , 3 )
			--for m = 0 , 4 , 1 do	
			--	if ValidCha( Check_star[m] )== 1  then					--被加入组队经验分配的角色必须存在
					local Item_bg = GetChaItem ( t[i] , 2 , 1  ) --取角色背包第二栏的指针
					local Get_Item_Type = GetItemType ( Item_bg ) --调用程序接口获得Item道具类型
					if Get_Item_Type==59 then --------判断是否为精灵
						local  Item_ID = GetItemID ( Item_bg )	--取ID
						local str = GetItemAttr( Item_bg ,ITEMATTR_VAL_STR )			--力量 
						local con = GetItemAttr( Item_bg ,ITEMATTR_VAL_CON )		 ---体质 
						local agi = GetItemAttr( Item_bg ,ITEMATTR_VAL_AGI )			--敏捷 
						local dex = GetItemAttr( Item_bg ,ITEMATTR_VAL_DEX )		 --专注 
						local sta = GetItemAttr( Item_bg ,ITEMATTR_VAL_STA )			 --精神 
						local URE = GetItemAttr( Item_bg ,ITEMATTR_URE )			--体力 
						local MAXURE = GetItemAttr( Item_bg ,ITEMATTR_MAXURE )		 --最大体力
						local lv_JL = str + con + agi + dex + sta	----一个精灵的等级
						local Num_JL = GetItemForgeParam ( Item_bg , 1 )
						local Part1 = GetNum_Part1 ( Num_JL )	--Get Num Part 1 到 Part 7
						local Part2 = GetNum_Part2 ( Num_JL )	
						local Part3 = GetNum_Part3 ( Num_JL )
						local StateLv1 = GetChaStateLv (t[i] , STATE_JLFT7 )
						local StateLv2 = GetChaStateLv (t[i] , STATE_JLFT8 )
						local flag=0
						if Item_ID==237 and StateLv1~=0 then
							flag=1
						end
						if Item_ID==681 and StateLv2~=0 then
							flag=1
						end
						if lv_JL > 63 then
							flag = 0
						end
						if flag==1  then ----有id为237或是681号的精灵并且精灵附体技能存在
							--if StateLv1 == 1 or StateLv2 == 1 then ---初级
							--	exp_up = exp_up*(0.005*lv_JL*0.1+1)
							--end
							--if StateLv1 == 2 or StateLv2 == 2 then ---中级
							--	exp_up = exp_up*(0.0125*lv_JL*0.1+1)
							--end
							--if StateLv1 == 3 or StateLv2 == 3 then ---高级
							--	exp_up = exp_up*(0.025*lv_JL*0.1+1)
							--end
							if StateLv1 ~= 0 or StateLv2 ~= 0 then 
								exp_up = exp_up*(lv_JL*0.02+1)
							end
						--	URE=URE-4500
						end
						SetItemAttr ( Item_bg , ITEMATTR_URE , URE ) 	
					end
			--	end
			--end
-------------------------------------------
-------------------------------------------
			local Check = {}
				Check[0] = t[i]  
				Check[1] = GetTeamCha( t[i] , 0 )  
				Check[2] = GetTeamCha( t[i] , 1 )   
				Check[3] = GetTeamCha( t[i] , 2 )    
				Check[4] = GetTeamCha( t[i] , 3 )
	
			for j = 0 , 4 , 1 do	
				if ValidCha( Check[j] )== 1  then					--被加入组队经验分配的角色必须存在
					local star = IsTeamLeader( Check[j] )
					if	star==1 then -------------判断队长			
						local StateLv = GetChaStateLv ( Check[j] , STATE_ZDSBJYGZ )
						local	Isshare = CheckExpShare ( t[i] , Check[j])
						--SystemNotice ( TurnToCha(t[i]) , "Isshare" )
						if StateLv == 1 and Isshare == 1 then
							exp_up = 1.5*exp_up
						end
					end
				end
			end


----------------------------------------------
----------------------------------------------圣战打精灵草随机属性
     --Notice("come here")
     local map_name_atk = GetChaMapName ( The_Killer )
     local map_name_def = GetChaMapName ( dead )
     if map_name_atk == "guildwar" or map_name_def == "guildwar" then
       local normal_monster =  GetChaID(dead)
	  --Notice("normal_monster=="..normal_monster)
       if normal_monster == 220 then  ---紫色
	   --AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
	   AddState ( The_Killer , The_Killer , STATE_HFZQ , 10 , 10 )
       end
       if normal_monster == 219 then  -----蓝色
           AddState ( The_Killer , The_Killer , STATE_QINGZ , 10 , 300 )
       end
       if normal_monster == 217 then  -----红色
           AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
       end
       if normal_monster == 218 then -----黄色
           AddState ( The_Killer , The_Killer , STATE_YS , 10 , 300 )
       end
      elseif map_name_atk == "guildwar2" or map_name_def == "guildwar2" then
       local normal_monster =  GetChaID(dead)
	  --Notice("normal_monster=="..normal_monster)
       if normal_monster == 220 then  ---紫色
	   --AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
	   AddState ( The_Killer , The_Killer , STATE_HFZQ , 10 , 10 )
       end
       if normal_monster == 219 then  -----蓝色
           AddState ( The_Killer , The_Killer , STATE_QINGZ , 10 , 300 )
       end
       if normal_monster == 217 then  -----红色
           AddState ( The_Killer , The_Killer , STATE_JRQKL , 10 , 180 )
       end
       if normal_monster == 218 then -----黄色
           AddState ( The_Killer , The_Killer , STATE_YS , 10 , 300 )
       end
     end


----------------------------------------
-----------------------------------------团队之星处理
		local expGetNow = exp_up		--当前角色正常打怪可可获得的经验
		local expCanGive = 0
		t[i] = TurnToCha ( t[i]  )-- 海洋处理
		local ptnItem = GetEquipItemP( t[i] , 8)--取到道具指针	pointer		
		local IdItem = GetItemID ( ptnItem )	
		local lvPerson = GetChaAttr(t[i] , ATTR_LV)
		--Notice ( "进行到这里" )
		if IdItem==1034 and lvPerson < 41 then
			local expItemNow = GetItemAttr( ptnItem , ITEMATTR_URE)*10   --100初始值
			local expItemMax = GetItemAttr ( ptnItem , ITEMATTR_MAXURE)*10
			local retIsInTeam = IsInTeam(t[i] )
			if retIsInTeam ~= LUA_TRUE then			--触发石头经验储存机制
				expItemNow = expItemNow + expGetNow
				if expItemNow >= expItemMax then
					expItemNow = expItemMax
				end
			else						--组队了
				if HasTeammate(t[i] ,0, 5) == LUA_TRUE then---没有比自己小5级的队友
					local ptnLowLvPlayer = returnLowLVPlayer( t[i], t[0], t[1], t[2], t[3], t[4]) --返回队伍中比自己等级小5的人物指
					if ValidCha(ptnLowLvPlayer) == 1 then      --人没死的处理
					
						local expCanUse = expItemNow - 1000				--经验返还处理
							if expGetNow * 2>= expCanUse then
								expCanGive = expCanUse
								expItemNow = 1000
							else
								expItemNow = expItemNow - expGetNow*2
								expCanGive = expGetNow * 2
							end
							if expItemNow <= 1000 then
								expItemNow = 1000
							end
						exp_up = exp_up + expCanGive
					else																	--死了的处理				
						expCanGive = 0
						exp_up = exp_up + expCanGive
					end
					
					local expCanUse = expItemNow - 1000

			
				end
			end
			expItemNow= math.floor(expItemNow/10)
			SetItemAttr ( ptnItem ,ITEMATTR_URE , expItemNow )
		end
---------------------------------
---------------------------------
-----------------------------------------				
			if exp_up > 20000 then
				local cha_name = GetChaDefaultName ( TurnToCha(t[i]) )
				local Monster_name = GetChaDefaultName ( dead )
				CALCULATE_EXP_AND_LEVEL_LUA_000047 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000047")
				CALCULATE_EXP_AND_LEVEL_LUA_000048 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000048")
				CALCULATE_EXP_AND_LEVEL_LUA_000049 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000049")
				CALCULATE_ATTRCALCULATE_LUA_000012 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000012")
				LG ( "Big_exp" ,CALCULATE_ATTRCALCULATE_LUA_000012..cha_name..CALCULATE_EXP_AND_LEVEL_LUA_000049..Monster_name..CALCULATE_EXP_AND_LEVEL_LUA_000048..exp_up..CALCULATE_EXP_AND_LEVEL_LUA_000047 )
			end
			--SystemNotice ( team_atker , "经验为"..exp)
			--SystemNotice ( team_atker , "获得经验为"..exp_up)
			--SystemNotice ( TurnToCha(t[i]) , "exp = "..exp )
			if exp<DEXP[80] and (exp+exp_up)>DEXP[80] then
				--SystemNotice ( TurnToCha(t[i]) , "DEXP[80] = "..DEXP[80] )
				--SystemNotice ( TurnToCha(t[i]) , "exp_up前 = "..exp_up)
				exp_up =math.floor((DEXP[80]-exp) +(exp_up-(DEXP[80]-exp))/50)
				--SystemNotice ( TurnToCha(t[i]) , "exp_up后 = "..exp_up)
			end                                                                                  -------------避免79级到80级之后，拿到超出额度的经验 Jack

			if Lv ( TurnToCha(t[i]) ) >= 80 then 
				exp_up = math.floor ( exp_up / 50 ) 
			end 
			--防沉迷系数  
			local retExpState = GetExpState(t[i])

			if exp_up == 0 and retExpState ~= 0 then 
				CALCULATE_EXP_AND_LEVEL_LUA_000050 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000050")
				SystemNotice ( TurnToCha(t[i]) , CALCULATE_EXP_AND_LEVEL_LUA_000050 )
			end 


			--Notice("打怪获取经验的防沉迷系数为"..retExpState)
			--Notice("防沉迷之前的exp"..exp_up)
			
			exp_up =exp_up *GetExpState(t[i])/100
			--Notice("防沉迷之后的exp"..exp_up)

			--SystemNotice ( TurnToCha(t[i]) , "没做加成前的得到的exp_up = "..exp_up)

			local expraid = LV_EXP[Lv ( TurnToCha(t[i]) )]
			exp_up=math.floor(exp_up*expraid)

			--SystemNotice ( TurnToCha(t[i]) , "经过各种计算后得到的exp_up = "..exp_up)

			exp = exp + exp_up  
			

--			local lv = GetChaAttr(TurnToCha(t[i]), ATTR_LV)
--			if lv == 100 then
--				local a = CheckBagItem ( TurnToCha(t[i]), 171 )
--				--SystemNotice( TurnToCha(t[i]), "数目="..a)
--				if a == 1 then
--					local role_jyp = GetChaItem2 ( TurnToCha(t[i]), 2, 171)
--					local exp_store = GetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1 )
--					--SystemNotice( TurnToCha(t[i]), "原NUM="..exp_store)
--					exp_store = exp_store+exp_up
--					--SystemNotice( TurnToCha(t[i]), "现NUM="..exp_store)
--					SetItemAttr ( role_jyp, ITEMATTR_VAL_PARAM1, exp_store)
--					SystemNotice( TurnToCha(t[i]), "你的经验瓶中的积分增加了"..exp_up)
--				else
--				SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp )
--				end
--			else
--			SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp )
--			LG("exp" , "exp_now = " , exp ) 
--			end
			SetChaAttrI ( TurnToCha(t[i]) , ATTR_CEXP, exp ) 
			LG("exp" , "exp_now = " , exp ) 
		else 
	        --SystemNotice ( team_atker , "队员排位["..i.."]的值为空")
		end 
	end 
	local star112=GetChaAttr (  team_atker , ATTR_CEXP )----------当前等级经验
	CALCULATE_EXP_AND_LEVEL_LUA_000051 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000051")
	CALCULATE_EXP_AND_LEVEL_LUA_000039 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000039")
	CALCULATE_EXP_AND_LEVEL_LUA_000040 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000040")
	LG("star_exp" , CALCULATE_EXP_AND_LEVEL_LUA_000040..cha_name1100..CALCULATE_EXP_AND_LEVEL_LUA_000039..star112..CALCULATE_EXP_AND_LEVEL_LUA_000051 ) 
	LG("exp" , "end getexp " )
end 

function returnLowLVPlayer(PlayerNow,Player1,Player2,Player3,Player4,Player5)    --返回队伍中比自己等级小5级的玩家指针
	local lvPlayerNow = GetChaAttr(PlayerNow, ATTR_LV)
	PlayerNow = TurnToCha(PlayerNow)
	Player1 = TurnToCha(Player1)
	Player2 = TurnToCha(Player2)
	Player3 = TurnToCha(Player3)
	Player4 = TurnToCha(Player4)
	Player5 = TurnToCha(Player5)
	
	if ValidCha(Player1) == 1 then
		local lvPlayer1 = GetChaAttr(Player1, ATTR_LV)
		if lvPlayerNow > lvPlayer1 + 5 then
			return Player1
		end
	end
	
	if ValidCha(Player2) == 1 then
		local lvPlayer2 = GetChaAttr(Player2, ATTR_LV)
		if lvPlayerNow > lvPlayer2 + 5 then
			return Player2
		end
	end
	
	if ValidCha(Player3) == 1 then
		local lvPlayer3 = GetChaAttr(Player3, ATTR_LV)
		if lvPlayerNow > lvPlayer3 + 5 then
			return Player3
		end
	end
	
	if ValidCha(Player4) == 1 then
		local lvPlayer4 = GetChaAttr(Player4, ATTR_LV)
		if lvPlayerNow > lvPlayer4 + 5 then
			return Player4
		end
	end
	
	if ValidCha(Player5) == 1 then
		local lvPlayer5 = GetChaAttr(Player5, ATTR_LV)
		if lvPlayerNow > lvPlayer5 + 5 then
			return Player5
		end
	end
	
	return 0
end

function CheckExpShare ( ti , atk ) --ti如果atk相等那就有问题了
	if ValidCha(ti)==0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000052 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000052")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000052 ) 
		return 0
	end 

	if IsInSameMap ( atk , ti ) == 0   then 
		--SystemNotice( atk , "由于所在地图不同，您无法与某些队友分享战斗经验") 
		return 0 
	end 

	local pos_ti_x , pos_ti_y = GetChaPos ( ti ) 
	if ValidCha( atk ) == 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000053 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000053")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000053 ) 
		return 0
	end 

		
	local pos_atk_x , pos_atk_y = GetChaPos ( atk ) 
	local distance = Dis ( pos_ti_x , pos_ti_y , pos_atk_x , pos_atk_y ) 
	if distance >= 4000 then 
--		HelpInfo(ti,0,"由于相隔太远，您无法与您的某些队友分享战斗经验") 
		return 0 
	end 
	if IsChaInRegion ( ti , AREA_SAFE ) == 1 then 
--		HelpInfo(ti,0,"由于处于安去区，您无法与您的队友分享战斗经验") 
		return 0 
	end 
	return 1 
end 


function Dead_Punish ( dead , atk ) --死亡惩罚

	local dead_lv=GetChaAttr(dead, ATTR_LV)							--100级人物状态死亡不扣经验	
	if dead_lv>=100 then
		CALCULATE_EXP_AND_LEVEL_LUA_000054 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000054")
		SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000054 )
		return
	end	

	local Cha_Boat = GetCtrlBoat ( dead )									--100级船只状态死亡不扣经验
	if Cha_Boat ~= nil then
		CALCULATE_EXP_AND_LEVEL_LUA_000055 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000055")
		SystemNotice( dead , CALCULATE_EXP_AND_LEVEL_LUA_000055 )
		return
	end
	
	--SystemNotice ( atk , "Dead_Punish")
	local	item_num=0
	local	item=0
	item_num = CheckBagItem(  atk , 5803  )		--检查背包内5803号道具的数量
	--SystemNotice ( atk , "item_num=="..item_num)
	if item_num==1 then
	--	SystemNotice ( atk , "come here")
		item=GetChaItem2 (  atk , 2 , 5803 )		---取5803号道具指针
		local kill_num=0
		kill_num=GetItemAttr(item,ITEMATTR_VAL_STR)
		kill_num=kill_num+1
		SetItemAttr ( item ,ITEMATTR_VAL_STR , kill_num )
	end

----------圣诞
	local Role_ID = GetRoleID(dead)
	 BBBB[ Role_ID ] = 0
------------------
	local map_name = GetChaMapName ( dead )
	if map_name == "leiting2" or map_name == "binglang2" or map_name == "shalan2" or map_name == "guildwar" or map_name == "guildwar2" then
		return
	end

	
	local map_name = GetChaMapName ( dead )
	if map_name == "garner2" then
	SetCharaAttr(0, dead, ATTR_SP)
		return
	end
	dead = TurnToCha ( dead ) 
	local lv = GetChaAttr( dead, ATTR_LV ) 
	local check_pirate=CheckItem_pirate(dead)
	local check_death=CheckItem_Death(dead)
	local Check_ZHONGSHEN = CheckItem_ZHONGSHEN ( dead )
	local Time = os.date("%H")
	local TimeNum = tonumber(Time)

	if lv<=10 then
		return 
	end --[[判定大于10级扣除经验]]--
	if lv >= 70 and check_pirate ==1 then
		if TimeNum<=6 or TimeNum >=18 then
			CALCULATE_EXP_AND_LEVEL_LUA_000056 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000056")
			SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000056 ) 
			return
		end
	end
	if lv >= 75 and check_death ==1 then
		if TimeNum<=6 or TimeNum >=18 then
			CALCULATE_EXP_AND_LEVEL_LUA_000057 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000057")
			SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000057 ) 
			return
		end
	end
	if lv >= 95 and Check_ZHONGSHEN ==1 then
		CALCULATE_EXP_AND_LEVEL_LUA_000058 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000058")
		SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000058 ) 
		return
	end
	local exp_red 
	local exp = Exp(dead) 
	local nlexp = GetChaAttrI ( dead , ATTR_NLEXP ) 
	local clexp = GetChaAttrI ( dead , ATTR_CLEXP ) 
	if  exp <= clexp then 
		exp_red = 0 
	else 
		exp_red = math.min ( math.floor ( math.abs( nlexp - clexp ) * 0.02 ) , math.max ( exp - clexp , 0 ) ) 
	end 
	SetCharaAttr(0, dead, ATTR_SP) 
	local i1 = CheckBagItem( dead,3846 )
	local i2 = CheckBagItem( dead,3047 )
	local i3 = CheckBagItem( dead,5609 )---------------------------------替身令牌kokora
	local i4 = CheckBagItem( dead,6396 )---------------------------------替身令牌（女生专区）

	if map_name == "secretgarden" or map_name == "teampk" then
	SetCharaAttr(0, dead, ATTR_SP)
		return
	end
	
	local i= CheckBagItem( dead, 2954 )-------死亡证明
	--SystemNotice( dead , "i=="..i)
	if i==1 then
		local Dead_BK = GetChaItem2 ( dead , 2 , 2954 )
		local DeadPoint=GetItemAttr ( Dead_BK , ITEMATTR_VAL_STR)
			--SystemNotice( dead , "DeadPoint之前为=="..DeadPoint)

		local DeadPoint=DeadPoint+1
			SetItemAttr( Dead_BK , ITEMATTR_VAL_STR , DeadPoint )
				local DeadPoint1=GetItemAttr ( Dead_BK , ITEMATTR_VAL_STR)
				--SystemNotice( dead , "DeadPoint现在为=="..DeadPoint1)

		if DeadPoint>=100 then
		end
	end
	-------------------女生专区--------------替身令牌
	if i4 ~= 0 then
		local j2 = TakeItem( dead,0,6396,1)
		if j2 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000059 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000059")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000059 )
			CALCULATE_EXP_AND_LEVEL_LUA_000059 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000059")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000059 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000061 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000061")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000061 )
			return
		end
	end
	
	if i1 <= 0 and i2 <= 0 and  i3 <= 0 then ---没娃娃没宝宝没替身令牌kokora
		exp = Exp(dead) - exp_red 
		if Lv ( dead ) >= 80 then 
			exp_red_80 = exp_red * 50 
			CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
			SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
		else 
			CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
			SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
		end 
		SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
		if lv > 20 then
			Dead_Punish_ItemURE ( dead )
		end
	
	elseif i1~=0 and i2==0 and  i3==0 then --有娃娃没宝宝没替身令牌kokora
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000063 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000063")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000063 )
		end
	elseif i2~=0 and  i1==0 and i3==0  then --有宝宝没娃娃没替身令牌kokora
		local j2 = TakeItem( dead,0,3047,1)
		if j2 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000064 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000064")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000064 )
			CALCULATE_EXP_AND_LEVEL_LUA_000064 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000064")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000064 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000065 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000065")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000065 )
		end
	elseif i3~=0 and i1==0 and  i2==0  then --有替身令牌没娃娃没宝宝kokora
		local j2 = TakeItem( dead,0,5609,1)
		if j2 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000059 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000059")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000059 )
			CALCULATE_EXP_AND_LEVEL_LUA_000059 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000059")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000059 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000061 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000061")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000061 )
		end
	elseif i1~=0 and i2~=0 and  i3==0 then --有娃娃有宝宝没替身令牌kokora 先删除娃娃
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000063 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000063")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000063 )
		end
	elseif i2~=0 and  i3~=0 and i1==0  then --有宝宝有替身令牌没娃娃kokora先删除宝宝
		local j2 = TakeItem( dead,0,3047,1)
		if j2 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000064 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000064")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000064 )
			CALCULATE_EXP_AND_LEVEL_LUA_000064 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000064")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000064 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000065 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000065")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000065 )
		end
	elseif i1~=0 and i3~=0 and  i2==0 then --有娃娃有替身令牌没宝宝kokora 先删除娃娃
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000063 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000063")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000063 )
		end
	elseif i1~=0 and i2~=0 and  i3~=0 then --有娃娃有替身令牌有宝宝kokora 先删除娃娃
		local j1 = TakeItem( dead,0,3846,1)
		if j1 == 0  then
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			LG ( "NewItem" , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			CALCULATE_EXP_AND_LEVEL_LUA_000062 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000062")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000062 )
			exp = Exp(dead) - exp_red 
			if Lv ( dead ) >= 80 then 
				exp_red_80 = exp_red * 50 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red_80 ) 
			else 
				CALCULATE_EXP_AND_LEVEL_LUA_000060 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000060")
				SystemNotice (dead , CALCULATE_EXP_AND_LEVEL_LUA_000060..exp_red ) 
			end 
			SetChaAttrI( dead , ATTR_CEXP , exp ) --[[扣除死亡玩家所在级别经验的2％]]--
			if lv > 20 then
				Dead_Punish_ItemURE ( dead )
			end
		else
			CALCULATE_EXP_AND_LEVEL_LUA_000063 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000063")
			SystemNotice ( dead , CALCULATE_EXP_AND_LEVEL_LUA_000063 )
		end
	end
	
	local name = GetChaDefaultName ( dead )
	local exp_new = ( exp - clexp ) / ( nlexp - clexp )
	CALCULATE_EXP_AND_LEVEL_LUA_000066 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000066")
	CALCULATE_EXP_AND_LEVEL_LUA_000067 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000067")
	CALCULATE_EXP_AND_LEVEL_LUA_000068 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000068")
	CALCULATE_EXP_AND_LEVEL_LUA_000069 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000069")
	LG ( "die_exp" , CALCULATE_EXP_AND_LEVEL_LUA_000069 , name , CALCULATE_EXP_AND_LEVEL_LUA_000068, lv , CALCULATE_EXP_AND_LEVEL_LUA_000067 , exp_red , CALCULATE_EXP_AND_LEVEL_LUA_000066 , exp_new )

	local mars = 0
	for mars = 0 , 4 , 1 do
		if name == CheckDmgChaNameTest [mars] then
			CALCULATE_EXP_AND_LEVEL_LUA_000070 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000070")
			LG ( "whydie" , name..CALCULATE_EXP_AND_LEVEL_LUA_000070 )
		end
	end
end 


function GetExp_MKP(dead , atk) --[[player kill monster 经验值改变公式]]-- 
	--LuaPrint("Enter function GetExp_MKP() --[[player kill monster 经验值改变公式]]--") 
	local ZBMain= GetChaAttr(dead,ATTR_EXTEND0)
	local ZBNType= math.floor(ZBMain/10)      ---第几次占卜
	local ZBNMain= math.fmod(ZBMain,10 )			---BUFF OR DEBUFF
	local ZBday = GetChaAttr(dead,ATTR_EXTEND2)		--占卜天数
	local ZBstate=GetChaAttr(dead, ATTR_EXTEND1)	--
	local ZBstate1=math.floor(ZBstate/10)			--占卜效果注册
	local ZBstate2=math.fmod(ZBstate,10)				--占卜类型
	local now_day=os.date("%d")
	now_day=tonumber(now_day)
	if now_day==ZBday and ZBstate2==0 and ZBstate1~=0 then
		CALCULATE_EXP_AND_LEVEL_LUA_000071 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000071")
		SystemNotice(dead,CALCULATE_EXP_AND_LEVEL_LUA_000071)
		return
	end
	Dead_Punish( dead , atk) 
	--LuaPrint("Out function GetExp_MKP() --[[player kill monster 经验值改变公式]]--") 
end 

function GetExp_PKP(dead , atk) --[[player kill player 经验值改变公式]]-- 
	--LuaPrint("Enter function GetExp_MKP() --[[player kill monster 经验值改变公式]]--") 
--	Dead_Punish( dead , atk) 
	--LuaPrint("Out function GetExp_MKP() --[[player kill monster 经验值改变公式]]--") 
end 

function GetExp_Noexp(dead , atk) --[[无奖惩经验值改变公式]]-- 
	--LuaPrint("Enter function GetExp_Noexp() --[[无奖惩经验值改变公式]]-- ".."\n" ) 
	--LuaPrint("Out function GetExp_Noexp() --[[无奖惩经验值改变公式]]-- ".."\n" ) 
end 





--角色非技能性复活脚本————————————————————————————————————————————

function Relive ( role )							
	local mxhp = GetChaAttr ( role , ATTR_MXHP ) 
	local mxsp = GetChaAttr ( role , ATTR_MXSP ) 
	local hp = math.max ( 1, math.floor(  ( mxhp * 0.01 ) + 0.5 ) ) 
	local sp = math.max ( 1, math.floor(  ( mxsp * 0.01 ) + 0.5 ) ) 
	SetCharaAttr ( hp , role , ATTR_HP ) 
	SetCharaAttr ( sp , role , ATTR_SP ) 
end 

--角色技能性复活脚本————————————————————————————————————————————

function Relive_now ( role , sklv ) 
	local cha_role = TurnToCha ( role ) 
	local hp = math.max ( 1 , math.floor ( 0.05 * sklv * Mxhp ( cha_role ) ) ) 
	local sp = math.max ( 1 , math.floor ( 0.05 * sklv * Mxsp ( cha_role ) ) ) 
	SetCharaAttr ( hp , cha_role , ATTR_HP ) 
	SetCharaAttr ( sp , cha_role , ATTR_SP ) 
end 




--船只死亡最大耐久减少——————————————————————————————————————————————————————————————

function   Ship_ShipDieAttr ( role ) 
	local bmxhp = GetChaAttr ( role , ATTR_BMXHP ) 
	local dead_count = GetChaAttr ( role , ATTR_BOAT_DIECOUNT ) 
	LG ( "shipmxhp" , "___a new dead ship_____________________________________________________" ) 
	LG ( "shipmxhp" , "role = " , role ,  "dead_count = " , dead_count , "form_mxhp = " , bmxhp ) 
	bmxhp = bmxhp * math.max ( 0 , ( 1 - 0.02 - dead_count * 0.01 )  ) 
	LG ( "shipmxhp" , "role = " , role ,   "now_mxhp = " , bmxhp ) 
	SetCharaAttr ( bmxhp , role , ATTR_BMXHP ) 
end  


function BoatLevelUpProc ( cha, boat, levelup, exp, money ) 
	if ValidCha( cha ) == 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000072 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000072")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000072 ) 
		return 0 
	end 
	if ValidCha( boat ) == 0 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000073 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000073")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000073 ) 
		return 0 
	end 
	PRINT( "BoatLevelUpProc: levelup = , exp = , money = ", levelup, exp, money )
	local lv_up	= levelup 
	local req_exp	= exp 
	local req_gold	= money 
	local boat_lv = GetChaAttr ( boat , ATTR_LV ) 
	if boat_lv ~= lv_up - 1 then 
		CALCULATE_EXP_AND_LEVEL_LUA_000074 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000074")
		PRINT( CALCULATE_EXP_AND_LEVEL_LUA_000074 )
		CALCULATE_EXP_AND_LEVEL_LUA_000075 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000075")
		LG ( "luascript_err" , CALCULATE_EXP_AND_LEVEL_LUA_000075 )
		return 0 
	end 

	local boat_exp = GetChaAttr ( boat , ATTR_CEXP ) 
	if boat_exp < req_exp then 
		CALCULATE_EXP_AND_LEVEL_LUA_000076 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000076")
		SystemNotice ( cha , CALCULATE_EXP_AND_LEVEL_LUA_000076) 
		return 0 
	end 

	local cha_money = GetChaAttr ( cha , ATTR_GD ) 
	if cha_money < req_gold then 
		CALCULATE_EXP_AND_LEVEL_LUA_000077 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000077")
		SystemNotice ( cha , CALCULATE_EXP_AND_LEVEL_LUA_000077) 
		return 0 
	end 
	PRINT( "BoatLevelUpProc: boat_exp, req_exp, cha_money, req_gold", boat_exp, req_exp, cha_money, req_gold )
	SetAttrChangeFlag( boat)	
	SetAttrChangeFlag( cha)	

	boat_exp = boat_exp - req_exp 
	SetCharaAttr ( boat_exp , boat , ATTR_CEXP ) 
	cha_money = cha_money - req_gold 	
	SetCharaAttr ( cha_money , cha , ATTR_GD ) 
	SetCharaAttr ( lv_up , boat , ATTR_LV ) 
	ALLExAttrSet ( boat ) 
	CALCULATE_EXP_AND_LEVEL_LUA_000078 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000078")
	SystemNotice ( cha , CALCULATE_EXP_AND_LEVEL_LUA_000078) 
	CALCULATE_EXP_AND_LEVEL_LUA_000079 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000079")
	SystemNotice ( cha , CALCULATE_EXP_AND_LEVEL_LUA_000079..req_gold) 
	CALCULATE_EXP_AND_LEVEL_LUA_000080 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000080")
	SystemNotice ( cha , CALCULATE_EXP_AND_LEVEL_LUA_000080..req_exp) 
	SyncBoat ( boat, 4 )
	SyncChar ( cha, 4 )
	PRINT( "BoarLevelUpProc: return 1" )
	return 1 

end 




function Ship_Tran (  buyer , boat ) 
	local ship_lv = GetChaAttr ( boat , ATTR_LV ) 
	local ship_exp = GetChaAttr ( boat , ATTR_CEXP ) 
--	if ValidCha ( seller ) == 0 then 
--		LG ( "luascript_err"  , "function Ship_Tran : seller 为空"  ) 
--		return 
--	end 
--	if ValidCha ( buyer ) == 0 then 
--		LG ( "luascript_err"  , "function Ship_Tran : buyer 为空"  ) 
--		return 
--	end 
	SetAttrChangeFlag( boat)	

	ship_lv = math.max ( 1 , math.max (math.floor ( ship_lv /2 ), ship_lv - 10 ) )  
	ship_exp = 0 
	SetCharaAttr ( ship_exp , boat , ATTR_CEXP ) 
	SetCharaAttr ( ship_lv , boat , ATTR_LV ) 
	CALCULATE_EXP_AND_LEVEL_LUA_000081 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000081")
	SystemNotice ( buyer , CALCULATE_EXP_AND_LEVEL_LUA_000081..ship_lv )	
	CALCULATE_EXP_AND_LEVEL_LUA_000082 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000082")
	SystemNotice ( buyer , CALCULATE_EXP_AND_LEVEL_LUA_000082..ship_exp )	 

	SyncBoat ( boat, 4 )
end 


--幸运一击
-- function CheckLuckyFinish ( StateLv )
	-- if StateLv == 4 then
		-- local Huge_Lucky = Percentage_Random ( 0.01 )
		-- if Huge_Lucky == 1 then
			-- return 2
		-- end
	-- end
	
	-- local a = 0.1
	-- local b = Percentage_Random ( a )
	-- return b
-- end

function ZBexpadd(atk,expaddZB)
	local ZBMain= GetChaAttr(atk,ATTR_EXTEND0)
	local ZBNType= math.floor(ZBMain/10)      ---第几次占卜
	local ZBNMain= math.fmod(ZBMain,10 )			---BUFF OR DEBUFF
	local ZBday = GetChaAttr(atk,ATTR_EXTEND2)		--占卜天数
	local ZBstate=GetChaAttr(atk, ATTR_EXTEND1)	--
	local ZBstate1=math.floor(ZBstate/10)			--占卜效果注册
	local ZBstate2=math.fmod(ZBstate,10)				--占卜类型
	local now_day=os.date("%d")
	now_day=tonumber(now_day)
	local ZBStateLV = {}
		ZBStateLV[0]={}
		ZBStateLV[0][0] =0 
		ZBStateLV[1] = {}
		ZBStateLV[1][1] = 2												
		ZBStateLV[1][2] = 4												
		ZBStateLV[1][3] = 6												
		ZBStateLV[1][4] = 8												
		ZBStateLV[1][5] = 10
	if now_day==ZBday and ZBstate2==1 then
		expaddZB=math.floor(expaddZB*(1+ZBStateLV[ZBstate2][ZBstate1]/100))
	end	
	return expaddZB
end
function ZB8Debuff(role,expraid)
	local zbState=ZBNowState(role)
	local expraid1=expraid
	if zbState==-81 then 
		expraid1 =expraid*0.9
	end
	if zbState==-82 then 
		local ZBtime=GetChaAttr(role,ATTR_EXTEND7)
		local Zbexpper=math.fmod( ZBtime,60)
		if Zbexpper>40 then
			expraid1=expraid*(1-0.1*(60-Zbexpper)/20)
		elseif Zbexpper<=40 then
			expraid1=expraid*(0.5-Zbexpper*Zbexpper/3000+Zbexpper/50+Zbexpper/300)
		end
	end
	if zbState==-83 then 
		expraid1=1.2
	end
	return expraid1
end
function CheckLuckyFinish ( StateLv )
	if SBStateYXJxinyun[StateLv] == 2 then
		local Huge_Lucky = Percentage_Random ( 0.01 )
		if Huge_Lucky == 1 then
			return 2
		end
	end
	
	local a = 0.1
	local b = Percentage_Random ( a )
	return b
end	
---------------------------------------
----挖宝巨额经验—by lucke.coco----
---------------------------------------
function getmuchexpbf (atk)	--挖宝给予巨额经验玩家判断
	local lv= GetChaAttr(atk, ATTR_LV) 
	if lv <=40 then
	-- SystemNotice ( atk , "40级" )
		return
	elseif lv > 40 and lv <= 45 then
	-- SystemNotice ( atk , "40——45级" )	
		local has_expbf = GetChaAttr ( atk , ATTR_CEXP )
		local new_expbf = has_expbf + 20000
		SetChaAttr ( atk , ATTR_CEXP , new_expbf )
		CALCULATE_EXP_AND_LEVEL_LUA_000083 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000083")
		SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000083 )
		return
	elseif lv > 45 and lv <= 50 then
	-- SystemNotice ( atk , "45——50级" )	
		local has_expbf = GetChaAttr ( atk , ATTR_CEXP )
		local new_expbf = has_expbf + 40000
		SetChaAttr ( atk , ATTR_CEXP , new_expbf )
		CALCULATE_EXP_AND_LEVEL_LUA_000084 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000084")
		SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000084 )
		return
	elseif lv > 50 and lv <= 55 then
	-- SystemNotice ( atk , "50——55级" )	
		local has_expbf = GetChaAttr ( atk , ATTR_CEXP )
		local new_expbf = has_expbf + 60000
		SetChaAttr ( atk , ATTR_CEXP , new_expbf )
		CALCULATE_EXP_AND_LEVEL_LUA_000085 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000085")
		SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000085 )
		return		
	elseif lv > 55 and lv <= 60 then
	-- SystemNotice ( atk , "55——60级" )	
		local has_expbf = GetChaAttr ( atk , ATTR_CEXP )	
		local new_expbf = has_expbf + 80000
		SetChaAttr ( atk , ATTR_CEXP , new_expbf )
		CALCULATE_EXP_AND_LEVEL_LUA_000086 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000086")
		SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000086 )
		return		
	elseif lv > 60 and lv < 80 then
	-- SystemNotice ( atk , "60级以上" )	
		local has_expbf = GetChaAttr ( atk , ATTR_CEXP )	
		local new_expbf = has_expbf + 100000
		SetChaAttr ( atk , ATTR_CEXP , new_expbf )
		CALCULATE_EXP_AND_LEVEL_LUA_000087 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000087")
		SystemNotice ( atk , CALCULATE_EXP_AND_LEVEL_LUA_000087 )
		return	
	else
		return
	end
end

function DropHJJZ(dead,atk)
	local MonsterID = GetChaID(dead)
	if MonsterID == 725 then
		local Now_Day = os.date("%d")
		local Now_Month = os.date("%m")
		local Now_Time = os.date("%H")
		local NowTimeNum = tonumber(Now_Time)
		local NowDayNum = tonumber(Now_Day)
		local NowMonthNum = tonumber(Now_Month)
		local CheckDateNum = NowMonthNum * 100 + NowDayNum
		local CheckDateNum2 = GetServeNow(atk)
		local diff_time = CheckDateNum - CheckDateNum2
		if diff_time < 2 then
			if KopHonor == 0 then
				local Item_CanGet = GetChaFreeBagGridNum ( atk )
					if Item_CanGet >1 then
						sc = math.random (1,100)
						if sc == 1 then   ----0.5的机率
							local cha_name = GetChaDefaultName ( atk ) 
							GiveItem (atk,0,6902,1,4)
							KopHonor = 1
							CALCULATE_EXP_AND_LEVEL_LUA_000094 = GetResString("CALCULATE_EXP_AND_LEVEL_LUA_000094")
							ScrollNotice ( cha_name..CALCULATE_EXP_AND_LEVEL_LUA_000094,1)
						end
					else
						return
					end
			end
		else
			ServerTime = 0
			KopHonor = 0
		end
	else
		return
	end
end 



function GetServeNow(role)
	if ServerTime == 0 then
		local Now_Day = os.date("%d")
		local Now_Month = os.date("%m")
		local Now_Time = os.date("%H")
		local NowTimeNum = tonumber(Now_Time)
		local NowDayNum = tonumber(Now_Day)
		local NowMonthNum = tonumber(Now_Month)
		local CheckDateNum = NowMonthNum * 100 + NowDayNum	
		ServerTime = CheckDateNum
	end
	return ServerTime
end 
