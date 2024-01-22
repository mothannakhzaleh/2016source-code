--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    MapCanGuild(map,0)--设置是否可以退出公会
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    --MapCopyStartType(map, 1) --设置地图立即开始
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 5 )
    RepatriateDie(map,0)---地图内复活
    SetMapGuildWar(map,1)
    MapCanStall(map , 0)

end


function get_map_entry_pos_guildwar2()   --设置入口的位置的坐标（坐标（米））

	local POS_X=1450
	local POS_Y=612
	return POS_X , POS_Y


end

function init_entry(map)
    SetMapEntryMapName(map, "darkblue") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2005/8/30/19/00", "0/4/0", "0/3/0", "0/3/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。
    
end



function after_enter_guildwar2( role , map_copy )
      

--      local Num_SSL= CheckBagItem(role,2382)
--
--	if Num_SSL >= 1 then
--	   SystemNotice(role, "您身上有<生死令>")	
--	else
--	   GiveItem ( role , 0 , 2382  , 1 , 4 )
--	end
--    local map_copy = GetChaMapCopy(role)
--    local RedSide_GuildID, BlueSide_GuildID
--    RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
--    BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )


    --local Cha = TurnToCha(role)
    
    if GetChaGuildID(role) <= 100 and GetChaGuildID(role) > 0 then
        SetChaSideID(role, 1)-----------------------------------海军编号
       
     
    end

    if GetChaGuildID(role) > 100 and GetChaGuildID(role) <= 200 then
        SetChaSideID(role, 2)-----------------------------------海盗编号
	
      
    end

    --Notice("GetChaGuildID(Cha)=="..GetChaGuildID(Cha))
   
    
--    local haidaoSide_GuildID, haijunSide_GuildID
--    haidaoSide_GuildID = GetMapCopyParam2(map_copy, 3 )
--    haijunSide_GuildID = GetMapCopyParam2(map_copy, 4 )
--    Notice("haidaoSide_GuildID="..haidaoSide_GuildID)
    
	--if haidaoSide_GuildID == GetChaGuildID( role ) then
		--SetChaSideID(role, 2)
		--Notice("SetChaSideID=="..SetChaSideID)
	--end
	--if haijunSide_GuildID == GetChaGuildID( role ) then
			--SetChaSideID(role, 1)
	--end
end

function before_leave_guildwar2 ( role )


local Cha = TurnToCha(role) 
	local i = 0
	local j = 0
	for i = 0 , SZ_BagItemDelCheckNum ,1 do
	
	        local j = RemoveChaItem ( Cha ,SZ_BagItemDelCheck_ID[i],0,0,-1,2,1 )
		
		if j == 0 then 
		GUILDWAR_CTRL_LUA_000001 = GetResString("GUILDWAR_CTRL_LUA_000001")
		LG("RemoveChaItem",GUILDWAR_CTRL_LUA_000001)
		end
        end

  RemoveState( role , STATE_HFZQ )
  RemoveState( role , STATE_QINGZ )
  RemoveState( role , STATE_JRQKL )
  RemoveState( role , STATE_YS )

  local map_copy =  GetChaMapCopy(role)

     if check_need_show == 1 then
         return 

         else

         if GetChaGuildID(role) <= 100 and GetChaGuildID(role) > 0 then
        
            count_haijun = count_haijun - 1
	    GUILDWAR_CTRL_LUA_000002 = GetResString("GUILDWAR_CTRL_LUA_000002")
	    MapCopyNotice ( map_copy , GUILDWAR_CTRL_LUA_000002 )

         elseif GetChaGuildID(role) > 100 and GetChaGuildID(role) <= 200 then
            count_haidao = count_haidao - 1
	    GUILDWAR_CTRL_LUA_000003 = GetResString("GUILDWAR_CTRL_LUA_000003")
	    MapCopyNotice ( map_copy , GUILDWAR_CTRL_LUA_000003 )
        end
    end


 

	
end
  

function map_copy_first_run_guildwar2( map_copy )


        
        

end

function map_copy_run_guildwar2( map_copy )



      local closetime = GUILDWARCLOSETIME2
		for i = 1 , GUILDNOTICE2 , 1 do
			if closetime ==GUILDCLOSESHOW2[i] then
				GUILDWAR2_CTRL_LUA_000001 = GetResString("GUILDWAR2_CTRL_LUA_000001")
				GUILDWAR_CTRL_LUA_000005 = GetResString("GUILDWAR_CTRL_LUA_000005")
				local Notice_all = GUILDWAR_CTRL_LUA_000005..closetime..GUILDWAR2_CTRL_LUA_000001
				MapCopyNotice ( map_copy ,Notice_all )
			end
		end
		GUILDWARCLOSETIME2 = GUILDWARCLOSETIME2 - 1
 
 local hp_hd = GetChaAttr( di_haidaoSide_BaseRole , ATTR_HP ) -----------------海盗刷BOSS
	local mxhp_hd = GetChaAttr( di_haidaoSide_BaseRole , ATTR_MXHP )
	local percent_hd = hp_hd/mxhp_hd
	if percent_hd < 0.3 and create_boss_hd2 == 0 then
		local x, y = GetChaPos( di_haidaoSide_BaseRole )
		      x = x+500
		      y = y+500
                local Monster_hdboss = CreateChaEx(1033, 30800, 52400, 145, 1300,map_copy)
		SetChaLifeTime(Monster_hdboss,1200000) 
		
                SetChaSideID(Monster_hdboss, 2)
		GUILDWAR_CTRL_LUA_000006 = GetResString("GUILDWAR_CTRL_LUA_000006")
		MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000006)
		create_boss_hd2 = 1  --关闭
		
	end


 local hp_hj = GetChaAttr( di_haijunSide_BaseRole , ATTR_HP ) -----------------海军刷BOSS
	local mxhp_hj = GetChaAttr( di_haijunSide_BaseRole , ATTR_MXHP )
	local percent_hj = hp_hj/mxhp_hj
	if percent_hj < 0.3 and create_boss_hj2 == 0 then
		local x, y = GetChaPos( di_haijunSide_BaseRole )
		      x = x+500
		      y = y+500
                local Monster_hjboss = CreateChaEx(1032, 30600, 10200, 145, 1300,map_copy)
		SetChaLifeTime(Monster_hjboss,1200000) 
		
		SetChaSideID(Monster_hjboss, 1)
		
                
		GUILDWAR_CTRL_LUA_000007 = GetResString("GUILDWAR_CTRL_LUA_000007")
		MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000007)
		create_boss_hj2 = 1  --关闭
		
	end

 if SZ_Win_CountNum2 == 60 then
--		local RedSide_GuildID, BlueSide_GuildID
--		RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
--		BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )
--
--		local GuildName_Red = GetGuildName( RedSide_GuildID )
--		local GuildName_Blue = GetGuildName ( BlueSide_GuildID )
             
		if CheckMonsterDead ( di_haijunSide_BaseRole ) == 1 then
		   if di_haidaoSide_JDNotice == 0 then

			five_seconds2 = 1
			--local Notice_all = "小圣战战场中的海盗阵营获得了胜利！"
			--Notice ( Notice_all )
			SZ_Win_CountNum2 = SZ_Win_CountNum2 - 1
			--PK_JJHY_Winner = "海军阵营"
			--PK_JJHY_Loser =  "海盗阵营"
			--SetMapCopyParam2(map_copy, 5, 1) --海盗胜利
			di_haidaoSide_JDNotice = 1
                        CloseMapEntry ( "guildwar2" )
                        check_need_show2 = 1 ---不用显示退出提示

                        local player_num_1 = GetMapPlayer(map_copy)
			local pn_1 = player_num_1 * 3
			for i=1, pn_1, 1 do
				if player_num_1 > 0 then
					DealAllPlayerInMap(map_copy,"HJ_Goto2")
					DealAllPlayerInMap(map_copy,"noside_Goto2")
					--Notice("踢海军循环。。。")
				end
			end
			--DealAllActivePlayerInMap(map_copy,"HJ_Goto2")
			--DealAllActivePlayerInMap(map_copy,"noside_Goto2")
			DealAllActivePlayerInMap(map_copy,"Give_Three_QiYue2")
			GUILDWAR2_CTRL_LUA_000002 = GetResString("GUILDWAR2_CTRL_LUA_000002")
			local Notice_all = GUILDWAR2_CTRL_LUA_000002
			Notice ( Notice_all )
			
	            end

		end

		if CheckMonsterDead ( di_haidaoSide_BaseRole ) == 1 then
		    if di_haijunSide_JDNotice == 0 then
		        five_seconds2 = 1

			--local Notice_all = "小圣战战场中的海军阵营获得了胜利！"
			--Notice ( Notice_all )
			SZ_Win_CountNum2 = SZ_Win_CountNum2 - 1
			--PK_JJHY_Winner = "海盗阵营"
			--PK_JJHY_Loser = "海军阵营"
			--SetMapCopyParam2(map_copy, 5, 2) --海军胜利
			di_haijunSide_JDNotice = 1
                        CloseMapEntry ( "guildwar2" )
			check_need_show2 = 1

                        local player_num_2 = GetMapPlayer(map_copy)
			local pn_2 = player_num_2 * 3
			for i=1, pn_2, 1 do
				if player_num_2 > 0 then
					DealAllPlayerInMap(map_copy,"HD_Goto2")
					DealAllPlayerInMap(map_copy,"noside_Goto2")
					--Notice("踢海盗循环。。。")
				end
			end
			--DealAllActivePlayerInMap(map_copy,"HD_Goto2")
			--DealAllActivePlayerInMap(map_copy,"noside_Goto2")
			DealAllActivePlayerInMap(map_copy,"Give_Three_QiYue2")
			GUILDWAR2_CTRL_LUA_000003 = GetResString("GUILDWAR2_CTRL_LUA_000003")
			local Notice_all = GUILDWAR2_CTRL_LUA_000003
			Notice ( Notice_all )
			

	            end
		end
		
		if CheckMonsterDead ( di_haijunSide_LCRole ) == 1 then
			if di_haijunSide_LCNotice == 0 then
				GUILDWAR_CTRL_LUA_000010 = GetResString("GUILDWAR_CTRL_LUA_000010")
				MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000010)
				AddState( di_haijunSide_BaseRole , di_haijunSide_BaseRole , STATE_PKLC, 10 , 10800 )
				AddState( di_haijunSide_JTRole_1 , di_haijunSide_JTRole_1 , STATE_PKLC, 10 , 10800 )
				AddState( di_haijunSide_JTRole_2 , di_haijunSide_JTRole_2 , STATE_PKLC, 10 , 10800 )
				di_haijunSide_LCNotice = 1
				--create_boss_hj2 = 1  --关闭
			end
		end
		
		if CheckMonsterDead ( di_haidaoSide_LCRole ) == 1 then
			if di_haidaoSide_LCNotice == 0 then
				GUILDWAR_CTRL_LUA_000011 = GetResString("GUILDWAR_CTRL_LUA_000011")
				MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000011)
				AddState( di_haidaoSide_BaseRole , di_haidaoSide_BaseRole , STATE_PKLC, 10 , 10800 )
				AddState( di_haidaoSide_JTRole_1 , di_haidaoSide_JTRole_1 , STATE_PKLC, 10 , 10800 )
				AddState( di_haidaoSide_JTRole_2 , di_haidaoSide_JTRole_2 , STATE_PKLC, 10 , 10800 )
				di_haidaoSide_LCNotice = 1
				--create_boss_hd2 = 1  --关闭
			end
			
		end

		if CheckMonsterDead ( di_haijunSide_DYKRole ) == 1 then
			if di_haijunSide_DYKNotice == 0 then 
				GUILDWAR_CTRL_LUA_000012 = GetResString("GUILDWAR_CTRL_LUA_000012")
				MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000012)
				AddState( di_haijunSide_JTRole_1 , di_haijunSide_JTRole_1 , STATE_JHKML, 10 , 10800 )
				AddState( di_haijunSide_JTRole_2 , di_haijunSide_JTRole_2 , STATE_JHKML, 10 , 10800 )
				di_haijunSide_DYKNotice = 1
				--create_boss_hj2 = 1  --关闭
			end
		end

		if CheckMonsterDead ( di_haidaoSide_DYKRole ) == 1 then
			if di_haidaoSide_DYKNotice == 0 then
				GUILDWAR_CTRL_LUA_000013 = GetResString("GUILDWAR_CTRL_LUA_000013")
				MapCopyNotice ( map_copy ,GUILDWAR_CTRL_LUA_000013)
				AddState( di_haidaoSide_JTRole_1 , di_haidaoSide_JTRole_1 , STATE_JHKML, 10 , 10800 )
				AddState( di_haidaoSide_JTRole_2 , di_haidaoSide_JTRole_2 , STATE_JHKML, 10 , 10800 )
				di_haidaoSide_DYKNotice = 1
				--create_boss_hd2 = 1  --关闭
			end		
		end
	else
	     
	        
		
                
              if time_can_setmonster2 == 0 then
		time_can_setnvsheng2 = time_can_setnvsheng2 + 1
	      end

		local Count = SZ_Win_CountNum2 / 10
		if Count == math.floor ( Count ) then
                   --Notice ( Notice_all )
			--MapCopyNotice ( map_copy , Notice_all )
		 
			GUILDWAR2_CTRL_LUA_000004 = GetResString("GUILDWAR2_CTRL_LUA_000004")
			GUILDWAR2_CTRL_LUA_000005 = GetResString("GUILDWAR2_CTRL_LUA_000005")
			local Notice_map = GUILDWAR2_CTRL_LUA_000005..SZ_Win_CountNum2..GUILDWAR2_CTRL_LUA_000004
			MapCopyNotice ( map_copy , Notice_map )
		end
		SZ_Win_CountNum2 = SZ_Win_CountNum2 - 1
		if SZ_Win_CountNum2 == 0 then
				SZ_Win_CountNum2 = 60
				
				
		end   
		  -- Notice("time_can_setnvsheng"..time_can_setnvsheng)	
	        if time_can_setnvsheng2 == 59 then
		
		GUILDWAR2_CTRL_LUA_000006 = GetResString("GUILDWAR2_CTRL_LUA_000006")
		MapCopyNotice ( map_copy ,GUILDWAR2_CTRL_LUA_000006)
		
		local Monster2 = CreateChaEx(1027, 21526, 49419, 145, 1000,map_copy)
		local Monster3 = CreateChaEx(1027, 41559, 11793, 145, 1000,map_copy)
		local Monster4 = CreateChaEx(1027, 13667, 40891, 145, 1000,map_copy)
		local Monster5 = CreateChaEx(1027, 12478, 21656, 145, 1000,map_copy)
		local Monster6 = CreateChaEx(1027, 12416, 49142, 145, 1000,map_copy)
		local Monster7 = CreateChaEx(1027, 52406, 49110, 145, 1000,map_copy)
		local Monster8 = CreateChaEx(1027, 51472, 13326, 145, 1000,map_copy)
		local Monster9 = CreateChaEx(1027, 12405, 8742, 205, 1000,map_copy)
		--local Monster10 = CreateChaEx(859, 36446, 51416, 145, 60,map_copy)
		--local Monster11 = CreateChaEx(859, 36763, 48082, 145, 60,map_copy)
		--local Monster12 = CreateChaEx(859, 53312, 42794, 145, 60,map_copy)
		--local Monster13 = CreateChaEx(859, 53014, 31149, 145, 60,map_copy)
		--local Monster14 = CreateChaEx(859, 53156, 21219, 145, 60,map_copy)
		--local Monster15 = CreateChaEx(859, 52532, 12262, 145, 60,map_copy)
		--local Monster16 = CreateChaEx(859, 8992, 10590, 145, 60,map_copy)
		--local Monster17 = CreateChaEx(859, 13465, 10237, 145, 60,map_copy)
		SetChaLifeTime(Monster2,900000)
		SetChaLifeTime(Monster3,900000)
		SetChaLifeTime(Monster4,900000)
		SetChaLifeTime(Monster5,900000)
		SetChaLifeTime(Monster6,900000)
		SetChaLifeTime(Monster7,900000)
		SetChaLifeTime(Monster8,900000)
		SetChaLifeTime(Monster9,900000)
		--SetChaLifeTime(Monster10,299450)
		--SetChaLifeTime(Monster11,299500)
		--SetChaLifeTime(Monster12,299550)
		--SetChaLifeTime(Monster13,299600)
		--SetChaLifeTime(Monster14,299650)
		--SetChaLifeTime(Monster15,299700)
		--SetChaLifeTime(Monster16,299700)
		--SetChaLifeTime(Monster17,299700)
               
	       time_can_setmonster2 = 1
               time_can_setnvsheng2 = 1

	      
				
		end
	end
end

--每5分钟执行1次
function map_copy_run_special_guildwar2( map_copy ) 
        local random_hezi = math.random(1,10)
	
	if random_hezi == 1 then -- 第一批令盒
		local Monster1 = CreateChaEx(1013, 21620, 25990, 145, 60,map_copy)
		local Monster2 = CreateChaEx(1013, 13505, 26914, 145, 60,map_copy)
		local Monster3 = CreateChaEx(1013, 51545, 12982, 145, 60,map_copy)
		local Monster4 = CreateChaEx(1013, 49464, 21582, 145, 60,map_copy)
		local Monster5 = CreateChaEx(1013, 52142, 27057, 145, 60,map_copy)
		local Monster6 = CreateChaEx(1013, 41027, 24583, 145, 60,map_copy)
		local Monster7 = CreateChaEx(1013, 39696, 32709, 145, 60,map_copy)
		local Monster8 = CreateChaEx(1013, 31214, 33352, 145, 60,map_copy)
		local Monster9 = CreateChaEx(1013, 30322, 27936, 145, 60,map_copy)
		local Monster10 = CreateChaEx(1013, 12275, 8838, 145, 60,map_copy)

--		local Monster12 = CreateChaEx(859, 14373, 7541, 145, 60,map_copy)
--		local Monster13 = CreateChaEx(859, 10186, 6273, 145, 60,map_copy)
--		local Monster14 = CreateChaEx(859, 10043, 9649, 145, 60,map_copy)
--		local Monster15 = CreateChaEx(859, 17186, 3343, 145, 60,map_copy)

                local Monster11 = CreateChaEx(1014, 13441, 49302, 237, 60,map_copy)
		local Monster12 = CreateChaEx(1014, 49505, 53814, 145, 60,map_copy)
		local Monster13 = CreateChaEx(1014, 52191, 48734, 145, 60,map_copy)
		local Monster14 = CreateChaEx(1014, 49514, 36624, 145, 60,map_copy)
		local Monster15 = CreateChaEx(1014, 52322, 40969, 145, 60,map_copy)
		local Monster16 = CreateChaEx(1014, 39167, 43477, 145, 60,map_copy)
		local Monster17 = CreateChaEx(1014, 32042, 44194, 145, 60,map_copy)
		local Monster18 = CreateChaEx(1014, 30494, 38172, 145, 60,map_copy)
		local Monster19 = CreateChaEx(1014, 22644, 43566, 145, 60,map_copy)
		local Monster20 = CreateChaEx(1014, 13309, 37477, 145, 60,map_copy)

                SetChaLifeTime(Monster1,299050)
		SetChaLifeTime(Monster2,299050)
		SetChaLifeTime(Monster3,299100)
		SetChaLifeTime(Monster4,299150)
		SetChaLifeTime(Monster5,299200)
		SetChaLifeTime(Monster6,299250)
		SetChaLifeTime(Monster7,299300)
		SetChaLifeTime(Monster8,299350)
		SetChaLifeTime(Monster9,299400)
		SetChaLifeTime(Monster10,299450)
		

--		SetChaLifeTime(Monster12,299550)
                SetChaLifeTime(Monster11,299050)
                SetChaLifeTime(Monster12,299050)
		SetChaLifeTime(Monster13,299100)
		SetChaLifeTime(Monster14,299150)
		SetChaLifeTime(Monster15,299200)
		SetChaLifeTime(Monster16,299250)
		SetChaLifeTime(Monster17,299300)
		SetChaLifeTime(Monster18,299350)
		SetChaLifeTime(Monster19,299400)
		SetChaLifeTime(Monster20,299450)
		
--		SetChaLifeTime(Monster13,299600)
--		SetChaLifeTime(Monster14,299650)
--		SetChaLifeTime(Monster15,299700)
        
	end
	if random_hezi == 2 then -- 第二批令盒
		local Monster21 = CreateChaEx(1013, 13280, 20327, 145, 60,map_copy)
		local Monster22 = CreateChaEx(1013, 11494, 22938, 145, 60,map_copy)
		local Monster23 = CreateChaEx(1013, 8620, 25754, 145, 60,map_copy)
		local Monster24 = CreateChaEx(1013, 13434, 27171, 145, 60,map_copy)
		local Monster25 = CreateChaEx(1013, 22082, 29060, 145, 60,map_copy)
		local Monster26 = CreateChaEx(1013, 22328, 26854, 145, 60,map_copy)
		local Monster27 = CreateChaEx(1013, 22300, 23715, 145, 60,map_copy)
		local Monster28 = CreateChaEx(1013, 23025, 16585, 145, 60,map_copy)
		local Monster29 = CreateChaEx(1013, 20613, 15337, 145, 60,map_copy)
		local Monster30 = CreateChaEx(1013, 12830, 12465, 145, 60,map_copy)

                local Monster31 = CreateChaEx(1014, 21213, 39440, 46, 60,map_copy)
		local Monster32 = CreateChaEx(1014, 10730, 49579, 46, 60,map_copy)
		local Monster33 = CreateChaEx(1014, 21988, 34742, 46, 60,map_copy)
		local Monster34 = CreateChaEx(1014, 22985, 36209, 46, 60,map_copy)
		local Monster35 = CreateChaEx(1014, 22883, 48223, 46, 60,map_copy)
		local Monster36 = CreateChaEx(1014, 21350, 45700, 46, 60,map_copy)
		local Monster37 = CreateChaEx(1014, 23070, 40910, 46, 60,map_copy)
		local Monster38 = CreateChaEx(1014, 13719, 34813, 46, 60,map_copy)
		local Monster39 = CreateChaEx(1014, 12202, 39254, 250, 60,map_copy)
		local Monster40 = CreateChaEx(1014, 8017, 43392, 145, 60,map_copy)
                

                SetChaLifeTime(Monster21, 299050)
		SetChaLifeTime(Monster22, 299100)
		SetChaLifeTime(Monster23, 299150)
		SetChaLifeTime(Monster24, 299200)
		SetChaLifeTime(Monster25, 299250)
		SetChaLifeTime(Monster26, 299300)
		SetChaLifeTime(Monster27, 299350)
		SetChaLifeTime(Monster28, 299350)
		SetChaLifeTime(Monster29, 299350)
		SetChaLifeTime(Monster30, 299350)

		SetChaLifeTime(Monster31, 299050)
		SetChaLifeTime(Monster32, 299050)
		SetChaLifeTime(Monster33, 299050)
		SetChaLifeTime(Monster34, 299050)
		SetChaLifeTime(Monster35, 299050)
		SetChaLifeTime(Monster36, 299050)
		SetChaLifeTime(Monster37, 299050)
		SetChaLifeTime(Monster38, 299050)
		SetChaLifeTime(Monster39, 299050)
		SetChaLifeTime(Monster40, 299050)
         
	end
	if random_hezi == 3 then -- 第三批令盒
--		local Monster23 = CreateChaEx(861, 12167, 25665, 145, 60,map_copy)
--		local Monster24 = CreateChaEx(861, 13564, 23189, 145, 60,map_copy)
--		local Monster25 = CreateChaEx(861, 18274, 13329, 145, 60,map_copy)
--		local Monster26 = CreateChaEx(861, 19167, 9778, 145, 60,map_copy)
--		local Monster27 = CreateChaEx(861, 14915, 14352, 145, 60,map_copy)
--		local Monster28 = CreateChaEx(861, 13881, 9818, 145, 60,map_copy)
--		local Monster29 = CreateChaEx(861, 10854, 11740, 145, 60,map_copy)
		local Monster41 = CreateChaEx(1014, 39318, 32214, 293, 60,map_copy)
		local Monster42 = CreateChaEx(1014, 31069, 43192, 293, 60,map_copy)
		local Monster43 = CreateChaEx(1014, 39177, 52654, 293, 60,map_copy)
		local Monster44 = CreateChaEx(1014, 35124, 52286, 293, 60,map_copy)
		local Monster45 = CreateChaEx(1014, 36068, 51210, 293, 60,map_copy)
		local Monster46 = CreateChaEx(1014, 48444, 48486, 293, 60,map_copy)
		local Monster47 = CreateChaEx(1014, 40042, 47521, 293, 60,map_copy)
		local Monster48 = CreateChaEx(1014, 40223, 41496, 182, 60,map_copy)
		local Monster49 = CreateChaEx(1014, 38767, 38552, 145, 60,map_copy)
		local Monster50 = CreateChaEx(1014, 40167, 36772, 145, 60,map_copy)
		local Monster51 = CreateChaEx(1013, 38002, 20903, 209, 60,map_copy)
		local Monster52 = CreateChaEx(1013, 39240, 19177, 279, 60,map_copy)
		local Monster53 = CreateChaEx(1013, 39645, 30047, 279, 60,map_copy)
		local Monster54 = CreateChaEx(1013, 39791, 27655, 279, 60,map_copy)
		local Monster55 = CreateChaEx(1013, 52163, 27539, 279, 60,map_copy)
		local Monster56 = CreateChaEx(1013, 50094, 20494, 279, 60,map_copy)
		local Monster57 = CreateChaEx(1013, 49301, 13882, 279, 60,map_copy)
		local Monster58 = CreateChaEx(1013, 37727, 14455, 306, 60,map_copy)
		local Monster59 = CreateChaEx(1013, 39731, 13703, 246, 60,map_copy)
		local Monster60 = CreateChaEx(1013, 41555, 15069, 145, 60,map_copy)
		SetChaLifeTime(Monster41, 299050)
		SetChaLifeTime(Monster42, 299050)
		SetChaLifeTime(Monster43, 299050)
		SetChaLifeTime(Monster44, 299050)
		SetChaLifeTime(Monster45, 299050)
		SetChaLifeTime(Monster46, 299050)
		SetChaLifeTime(Monster47, 299050)
		SetChaLifeTime(Monster48, 299050)
		SetChaLifeTime(Monster49, 299050)
		SetChaLifeTime(Monster50, 299050)
		SetChaLifeTime(Monster51, 299050)
		SetChaLifeTime(Monster52, 299050)
		SetChaLifeTime(Monster53, 299050)
		SetChaLifeTime(Monster54, 299050)
		SetChaLifeTime(Monster55, 299050)
		SetChaLifeTime(Monster56, 299050)
		SetChaLifeTime(Monster57, 299050)
		SetChaLifeTime(Monster58, 299050)
		SetChaLifeTime(Monster59, 299050)
		SetChaLifeTime(Monster60, 299050)

	end
	if random_hezi == 4 then -- 第四批令盒
		local Monster61 = CreateChaEx(1014, 32934, 48220, 145, 60,map_copy)
		local Monster62 = CreateChaEx(1014, 31123, 47392, 145, 60,map_copy)
		local Monster63 = CreateChaEx(1014, 29539, 45307, 145, 60,map_copy)
		local Monster64 = CreateChaEx(1014, 31953, 39794, 145, 60,map_copy)
		local Monster65 = CreateChaEx(1014, 30420, 39552, 145, 60,map_copy)
		local Monster66 = CreateChaEx(1014, 29168, 39497, 145, 60,map_copy)
		local Monster67 = CreateChaEx(1014, 32033, 34808, 145, 60,map_copy)
		local Monster68 = CreateChaEx(1014, 30246, 34860, 145, 60,map_copy)
		local Monster69 = CreateChaEx(1014, 29028, 34853, 145, 60,map_copy)
		local Monster70 = CreateChaEx(1014, 30913, 32317, 145, 60,map_copy)
		local Monster71 = CreateChaEx(1013, 31027, 27601, 145, 60,map_copy)
		local Monster72 = CreateChaEx(1013, 32306, 14507, 145, 60,map_copy)
		local Monster73 = CreateChaEx(1013, 30652, 14544, 145, 60,map_copy)
		local Monster74 = CreateChaEx(1013, 29230, 14685, 145, 60,map_copy)
		local Monster75 = CreateChaEx(1013, 31893, 25509, 145, 60,map_copy)
		local Monster76 = CreateChaEx(1013, 30293, 25526, 145, 60,map_copy)
		local Monster77 = CreateChaEx(1013, 29360, 25536, 145, 60,map_copy)
		local Monster78 = CreateChaEx(1013, 31895, 20636, 145, 60,map_copy)
		local Monster79 = CreateChaEx(1013, 30197, 20647, 145, 60,map_copy)
		local Monster80 = CreateChaEx(1013, 29223, 20629, 145, 60,map_copy)

		SetChaLifeTime(Monster61,298050)
		SetChaLifeTime(Monster62,298100)
		SetChaLifeTime(Monster63,298150)
		SetChaLifeTime(Monster64,298200)
		SetChaLifeTime(Monster65,298250)
		SetChaLifeTime(Monster66,298300)
		SetChaLifeTime(Monster67,298350)
		SetChaLifeTime(Monster68,298400)
		SetChaLifeTime(Monster69,298450)
		SetChaLifeTime(Monster70,298500)
		SetChaLifeTime(Monster71,298550)
		SetChaLifeTime(Monster72,298600)
		SetChaLifeTime(Monster73,298650)
		SetChaLifeTime(Monster74,298700)
		SetChaLifeTime(Monster75,298750)
		SetChaLifeTime(Monster76,298800)
		SetChaLifeTime(Monster77,298850)
		SetChaLifeTime(Monster78,298900)
		SetChaLifeTime(Monster79,298950)
		SetChaLifeTime(Monster80,299000)
		

	end
	if random_hezi == 5 then -- 第五批令盒

	        local Monster81 = CreateChaEx(1014, 23820, 13953, 201, 60,map_copy)
		local Monster82 = CreateChaEx(1014, 21199, 13676, 201, 60,map_copy)
		local Monster83 = CreateChaEx(1014, 21773, 26290, 201, 60,map_copy)
		local Monster84 = CreateChaEx(1014, 40766, 10069, 201, 60,map_copy)
		local Monster85 = CreateChaEx(1014, 21986, 23641, 201, 60,map_copy)
		local Monster86 = CreateChaEx(1014, 28509, 14375, 201, 60,map_copy)
		local Monster87 = CreateChaEx(1014, 31358, 16347, 201, 60,map_copy)
		local Monster88 = CreateChaEx(1014, 29375, 17571, 201, 60,map_copy)
		local Monster89 = CreateChaEx(1014, 30700, 22325, 201, 60,map_copy)
		local Monster90 = CreateChaEx(1014, 39386, 20026, 201, 60,map_copy)
		local Monster91 = CreateChaEx(1014, 39446, 14220, 201, 60,map_copy)
		local Monster92 = CreateChaEx(1014, 38707, 16452, 50, 60,map_copy)
		local Monster93 = CreateChaEx(1014, 51077, 31945, 50, 60,map_copy)
		local Monster94 = CreateChaEx(1014, 47667, 22749, 50, 60,map_copy)
		local Monster95 = CreateChaEx(1014, 50310, 20050, 145, 60,map_copy)
		local Monster96 = CreateChaEx(1013, 38310, 36356, 69, 60,map_copy)
		local Monster97 = CreateChaEx(1013, 40341, 37923, 69, 60,map_copy)
		local Monster98 = CreateChaEx(1013, 39346, 43117, 69, 60,map_copy)
		local Monster99 = CreateChaEx(1013, 42280, 47669, 124, 60,map_copy)
		local Monster100 = CreateChaEx(1013, 41768, 52403, 168, 60,map_copy)
		local Monster101 = CreateChaEx(1013, 38234, 53225, 72, 60,map_copy)
		local Monster102 = CreateChaEx(1013, 37512, 49433, 145, 60,map_copy)
		local Monster103 = CreateChaEx(1013, 31652, 48510, 145, 60,map_copy)
		local Monster104 = CreateChaEx(1013, 19855, 51667, 145, 60,map_copy)
		local Monster105 = CreateChaEx(1013, 23905, 47757, 145, 60,map_copy)
		local Monster106 = CreateChaEx(1013, 22665, 43745, 145, 60,map_copy)
		local Monster107 = CreateChaEx(1013, 21576, 40936, 145, 60,map_copy)
		local Monster108 = CreateChaEx(1013, 12251, 37484, 145, 60,map_copy)
		local Monster109 = CreateChaEx(1013, 8066, 40856, 145, 60,map_copy)
		local Monster110 = CreateChaEx(1013, 14042, 41339, 145, 60,map_copy)


	
			SetChaLifeTime(Monster81,297050)
			SetChaLifeTime(Monster82,297100)
			SetChaLifeTime(Monster83,297150)
			SetChaLifeTime(Monster84,297200)
			SetChaLifeTime(Monster85,297250)
			SetChaLifeTime(Monster86,297300)
			SetChaLifeTime(Monster87,297350)
			SetChaLifeTime(Monster88,297400)
			SetChaLifeTime(Monster89,297450)
			SetChaLifeTime(Monster90,297500)
			SetChaLifeTime(Monster91,297550)
			SetChaLifeTime(Monster92,297600)
			SetChaLifeTime(Monster93,297650)
			SetChaLifeTime(Monster94,297700)
			SetChaLifeTime(Monster95,297750)
			SetChaLifeTime(Monster96,297800)
			SetChaLifeTime(Monster97,297850)
			SetChaLifeTime(Monster98,297900)
			SetChaLifeTime(Monster99,297950)
			SetChaLifeTime(Monster100,298000)
			SetChaLifeTime(Monster101,298050)
			SetChaLifeTime(Monster102,298100)
			SetChaLifeTime(Monster103,298150)
			SetChaLifeTime(Monster104,298200)
			SetChaLifeTime(Monster105,298250)
			SetChaLifeTime(Monster106,298300)
			SetChaLifeTime(Monster107,298350)
			SetChaLifeTime(Monster108,298400)
			SetChaLifeTime(Monster109,298450)
			SetChaLifeTime(Monster110,298500)
		

	end
	if random_hezi == 6 then -- 第六批令盒
	        local Monster111 = CreateChaEx(1014, 10912, 29307, 44, 60,map_copy)
		local Monster112 = CreateChaEx(1014, 7947, 34591, 44, 60,map_copy)
		local Monster113 = CreateChaEx(1014, 9241, 33020, 49, 60,map_copy)
		local Monster114 = CreateChaEx(1014, 11626, 36543, 49, 60,map_copy)
		local Monster115 = CreateChaEx(1014, 10168, 35723, 49, 60,map_copy)
		local Monster116 = CreateChaEx(1014, 11964, 34517, 49, 60,map_copy)
		local Monster117 = CreateChaEx(1014, 13343, 34211, 145, 60,map_copy)
		local Monster118 = CreateChaEx(1014, 13128, 32578, 145, 60,map_copy)
		local Monster119 = CreateChaEx(1014, 13361, 26732, 145, 60,map_copy)
		local Monster120 = CreateChaEx(1014, 9384, 28155, 145, 60,map_copy)
		local Monster121 = CreateChaEx(1013, 10697, 29063, 145, 60,map_copy)
		local Monster122 = CreateChaEx(1013, 8976, 27353, 145, 60,map_copy)
		local Monster123 = CreateChaEx(1013, 13971, 34757, 145, 60,map_copy)
		local Monster124 = CreateChaEx(1013, 10973, 34523, 145, 60,map_copy)
		local Monster125 = CreateChaEx(1013, 12464, 32075, 145, 60,map_copy)
		local Monster126 = CreateChaEx(1013, 9470, 31601, 145, 60,map_copy)
		local Monster127 = CreateChaEx(1013, 12686, 28099, 145, 60,map_copy)
		local Monster128 = CreateChaEx(1013, 13816, 26277, 145, 60,map_copy)
		local Monster129 = CreateChaEx(1013, 11954, 26364, 145, 60,map_copy)
		local Monster130 = CreateChaEx(1013, 10516, 25686, 145, 60,map_copy)
		local Monster131 = CreateChaEx(1014, 50055, 37809, 109, 60,map_copy)
		local Monster132 = CreateChaEx(1014, 51149, 34800, 109, 60,map_copy)
		local Monster133 = CreateChaEx(1014, 51507, 33319, 109, 60,map_copy)
		local Monster134 = CreateChaEx(1014, 52022, 35132, 109, 60,map_copy)
		local Monster135 = CreateChaEx(1014, 48821, 32731, 109, 60,map_copy)
		local Monster136 = CreateChaEx(1014, 49950, 32246, 131, 60,map_copy)
		local Monster137 = CreateChaEx(1014, 52506, 32960, 131, 60,map_copy)
		local Monster138 = CreateChaEx(1014, 50867, 35699, 131, 60,map_copy)
		local Monster139 = CreateChaEx(1014, 50149, 38936, 134, 60,map_copy)
		local Monster140 = CreateChaEx(1014, 51813, 38899, 145, 60,map_copy)
		local Monster141 = CreateChaEx(1013, 49451, 35944, 359, 60,map_copy)
		local Monster142 = CreateChaEx(1013, 52574, 29142, 293, 60,map_copy)
		local Monster143 = CreateChaEx(1013, 52631, 34629, 145, 60,map_copy)
		local Monster144 = CreateChaEx(1013, 49156, 34409, 145, 60,map_copy)
		local Monster145 = CreateChaEx(1013, 50884, 33572, 145, 60,map_copy)
		local Monster146 = CreateChaEx(1013, 52109, 31771, 145, 60,map_copy)
		local Monster147 = CreateChaEx(1013, 50173, 31771, 145, 60,map_copy)
		local Monster148 = CreateChaEx(1013, 47947, 31101, 145, 60,map_copy)
		local Monster149 = CreateChaEx(1013, 49155, 30447, 145, 60,map_copy)
		local Monster150 = CreateChaEx(1013, 48686, 29665, 145, 60,map_copy)


			SetChaLifeTime(Monster111,296050)
			SetChaLifeTime(Monster112,296100)
			SetChaLifeTime(Monster113,296150)
			SetChaLifeTime(Monster114,296200)
			SetChaLifeTime(Monster115,296250)
			SetChaLifeTime(Monster116,296300)
			SetChaLifeTime(Monster117,296350)
			SetChaLifeTime(Monster118,296400)
			SetChaLifeTime(Monster119,296450)
			SetChaLifeTime(Monster120,296500)
			SetChaLifeTime(Monster121,296550)
			SetChaLifeTime(Monster122,296600)
			SetChaLifeTime(Monster123,296650)
			SetChaLifeTime(Monster124,296700)
			SetChaLifeTime(Monster125,296750)
			SetChaLifeTime(Monster126,296800)
			SetChaLifeTime(Monster127,296850)
			SetChaLifeTime(Monster128,296900)
			SetChaLifeTime(Monster129,296950)
			SetChaLifeTime(Monster130,297000)
			SetChaLifeTime(Monster131,297050)
			SetChaLifeTime(Monster132,297100)
			SetChaLifeTime(Monster133,297150)
			SetChaLifeTime(Monster134,297200)
			SetChaLifeTime(Monster135,297250)
			SetChaLifeTime(Monster136,297300)
			SetChaLifeTime(Monster137,297350)
			SetChaLifeTime(Monster138,297400)
			SetChaLifeTime(Monster139,297450)
			SetChaLifeTime(Monster140,297500)
			SetChaLifeTime(Monster141,297550)
			SetChaLifeTime(Monster142,297600)
			SetChaLifeTime(Monster143,297650)
			SetChaLifeTime(Monster144,297700)
			SetChaLifeTime(Monster145,297750)
			SetChaLifeTime(Monster146,297800)
			SetChaLifeTime(Monster147,297850)
			SetChaLifeTime(Monster148,297900)
			SetChaLifeTime(Monster149,297950)
			SetChaLifeTime(Monster150,298000)
	     end
	  if random_hezi >= 7 then 
	     --Notice("没刷出来")
	     return
	  end
end




--每5秒执行一次的
function map_run_guildwar2( map )

--if create_two_side_lose2 == 0 then
-- local cha2=CreateChaEx(1025, 49533, 11381, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 52777, 12540, 175, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 52882, 9847, 175, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 49834, 9023, 175, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1030, 50920, 10472, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1031, 52023, 10362, 145, 20000,map_copy)--海军吸魔
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 51498, 11119, 190, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	--local cha2=CreateChaEx(48, 51495, 10602, 175, 60)
--
--	local cha2=CreateChaEx(1030, 50624, 12932, 190, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1030, 49551, 12846, 160, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 51087, 13433, 205, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 49047, 13460, 175, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1026, 10074, 53194, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 12053, 53488, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 13446, 50438, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 8834, 50818, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1016, 12109, 51752, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1015, 11139, 51872, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 11641, 51235, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(68, 11618, 51702, 355, 60)
--
--	local cha2=CreateChaEx(1016, 11952, 49639, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1016, 10800, 49803, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 10333, 48831, 25, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 12073, 48614, 295, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 52679, 48777, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 54063, 51357, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 51387, 54045, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 48948, 51791, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(50, 51739, 51899, 310, 60)
--
--	local cha2=CreateChaEx(1016, 51712, 51187, 325, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 50946, 51846, 325, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 49360, 48345, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1015, 49715, 49062, 325, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 48730, 48907, 10, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1025, 30971, 20145, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	--local cha2=CreateChaEx(35, 11137, 11078, 145, 60)
--	local cha2=CreateChaEx(1030, 11727, 12980, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1031, 10850, 11515, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 11676, 11142, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 12492, 13848, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 14086, 12177, 34, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 12644, 13457, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 9316, 13664, 34, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 12069, 13786, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 12111, 9059, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 8728, 9972, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	--local cha2=CreateChaEx(954, 30778, 9602, 175, 60)
--
--	local cha2=CreateChaEx(1030, 30998, 19282, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 31940, 19807, 190, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 29973, 19854, 190, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1031, 30119, 22057, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 30884, 26292, 175, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 29580, 22038, 175, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1031, 31372, 22100, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 30725, 22373, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 31813, 22044, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	--local cha2=CreateChaEx(1029, 30117, 52848, 355, 20000)--海盗高级
--	--SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(1029, 31576, 52807, 355, 20000)--海盗高级
--	--SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(65, 30842, 53224, 355, 60)
--
--	local cha2=CreateChaEx(1015, 31084, 49087, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 32140, 48759, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 31371, 48066, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 30282, 48891, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1016, 31203, 50515, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 30045, 50434, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 31228, 49602, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 32214, 50479, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 29599, 51863, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 30777, 51736, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 31944, 51773, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 30463, 52373, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 31307, 52296, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 22542, 46002, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 22842, 40322, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 22425, 35416, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1028, 22136, 24793, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 22339, 20450, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 22653, 17130, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 25491, 12659, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 37790, 11813, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 39105, 20455, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 39366, 25155, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 39316, 16689, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1029, 39541, 35432, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 39326, 39649, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 39636, 46013, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(1028, 29924, 9911, 145, 20000)--高级
--	--SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1029, 26453, 48379, 310, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 34946, 47830, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 36367, 47877, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	--local cha2=CreateChaEx(1028, 31413, 9925, 145, 20000)--高级
--	--SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 29931, 10698, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 30630, 11220, 197, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 31338, 10572, 197, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 29804, 12096, 197, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 31395, 12150, 197, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1030, 30527, 12269, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1031, 30450, 14196, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 31131, 14589, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 29722, 14559, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 30473, 15437, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 25622, 15420, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 26494, 15358, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 34273, 14783, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 35426, 14748, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 26425, 13830, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 24804, 11407, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 25626, 11098, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 26114, 11621, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 26771, 12247, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 34353, 12512, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 35481, 11480, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1025, 36359, 10475, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 36518, 12642, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1028, 35287, 13572, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1029, 26191, 51235, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 24719, 50298, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 23510, 49731, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 22810, 50114, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 23798, 50981, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 25409, 51497, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 38703, 48578, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 37529, 49192, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 36312, 50224, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 35999, 49941, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 37126, 48890, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 38355, 48209, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1028, 42118, 13718, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1029, 41995, 50676, 85, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 20052, 49216, 235, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1028, 20290, 10940, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1023, 26171, 20331, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1023, 26135, 25139, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1023, 34908, 20323, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1023, 34935, 25171, 145, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1024, 34923, 35539, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1024, 34931, 40336, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1024, 26113, 40342, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1024, 26145, 35526, 145, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1025, 30526, 12996, 145, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1029, 30773, 34564, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 31966, 38371, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 30041, 41467, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1015, 30387, 38429, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 31728, 41471, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1016, 30935, 42286, 10, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 29621, 38427, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1015, 31169, 38416, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 30770, 37773, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1030, 30846, 24456, 190, 20000,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1016, 30712, 36395, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1029, 25184, 48167, 355, 20000,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1026, 31025, 40986, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--	local cha2=CreateChaEx(1025, 30868, 25458, 175, 600,map_copy)
--	SetChaSideID(cha2, 1)
--	local cha2=CreateChaEx(1026, 30762, 35501, 145, 600,map_copy)
--	SetChaSideID(cha2, 2)
--
--
--	----海军雕像
--	di_haijunSide_BaseRole = CreateChaEx(954, 30726, 9792, 180, 20000,map_copy)
--	di_haijunSide_JDNotice = 0
--	SetChaSideID(di_haijunSide_BaseRole, 1)
--
--	----海军粮仓
--	di_haijunSide_LCRole = CreateChaEx(1019, 11137, 11078, 145, 20000,map_copy)
--	di_haijunSide_LCNotice = 0
--	SetChaSideID( di_haijunSide_LCRole, 1)
--
--
--	-----海军军火库
--	di_haijunSide_DYKRole =CreateChaEx(1021, 51495, 10602, 175, 20000,map_copy)
--	di_haijunSide_DYKNotice =0
--	SetChaSideID(di_haijunSide_DYKRole, 1)
--
--
--	-----海盗雕像
--	di_haidaoSide_BaseRole = CreateChaEx(955, 30869, 52799, 355, 20000,map_copy)
--	di_haidaoSide_JDNotice = 0
--	SetChaSideID(di_haidaoSide_BaseRole, 2)
--
--
--	-----海盗粮仓
--	di_haidaoSide_LCRole=CreateChaEx(1020, 51739, 51899, 310, 20000,map_copy)
--	di_haidaoSide_LCNotice = 0
--	SetChaSideID(di_haidaoSide_LCRole, 2)
--
--
--
--	-----海盗军火库
--	di_haidaoSide_DYKRole=CreateChaEx(1022, 11618, 51702, 355, 20000,map_copy)
--	di_haidaoSide_DYKNotice= 0
--	SetChaSideID(di_haidaoSide_DYKRole, 2)
--
--
--	-----海军高级箭塔
--	di_haijunSide_JTRole_1=CreateChaEx(1034, 29924, 9911, 145, 20000,map_copy)
--	SetChaSideID(di_haijunSide_JTRole_1, 1)
--
--	di_haijunSide_JTRole_2=CreateChaEx(1034, 31413, 9925, 145, 20000,map_copy)
--	SetChaSideID(di_haijunSide_JTRole_2, 1)
--
--
--	-----海盗高级箭塔
--	di_haidaoSide_JTRole_1=CreateChaEx(1035, 30117, 52848, 355, 20000,map_copy)
--	SetChaSideID(di_haidaoSide_JTRole_1, 2)
--
--	di_haidaoSide_JTRole_2=CreateChaEx(1035, 31576, 52807, 355, 20000,map_copy)
--	SetChaSideID(di_haidaoSide_JTRole_2, 2)
--
--	create_two_side_lose2 = 1
--end


 
   if five_seconds2 == 1 then
     second_five_seconds2 = second_five_seconds2 + 1
   end

   if second_five_seconds == 60 then
   GUILDWAR2_CTRL_LUA_000007 = GetResString("GUILDWAR2_CTRL_LUA_000007")
   Notice(GUILDWAR2_CTRL_LUA_000007)
   end
   if second_five_seconds == 120 then
   GUILDWAR2_CTRL_LUA_000008 = GetResString("GUILDWAR2_CTRL_LUA_000008")
   Notice(GUILDWAR2_CTRL_LUA_000008)
   end
   if second_five_seconds == 144 then
   GUILDWAR2_CTRL_LUA_000009 = GetResString("GUILDWAR2_CTRL_LUA_000009")
   Notice(GUILDWAR2_CTRL_LUA_000009)
   end
   if second_five_seconds == 168 then
   GUILDWAR2_CTRL_LUA_000010 = GetResString("GUILDWAR2_CTRL_LUA_000010")
   Notice(GUILDWAR2_CTRL_LUA_000010)
   end

   if second_five_seconds2 == 180
   then
   CloseMapCopy ( "guildwar2" )
   end

 
--	local GuildLevel = 0
--	GuildLevel = GetFightGuildLevel ( )
--	if GuildLevel > 0 and GuildLevel < 4 then
--		if GuildLevel ~= ReadyToFight then
--			EndGuildBid ( GuildLevel )
--			ReadyToFight = GuildLevel
--		end
--	end
end

--地图关闭前执行
function map_copy_before_close_guildwar2( map_copy )

--local winner = GetMapCopyParam2( map_copy, 5 )
--	--local HaiJunSide = GetMapCopyParam2(map_copy, 3 )
--	--local HaiDaoSide = GetMapCopyParam2(map_copy, 4 )
--	--local GuildName_Red = GetGuildName( RedSide_GuildID )
--	--local GuildName_Blue = GetGuildName ( BlueSide_GuildID )
--	--local GuildName_Red = GetGuildName( RedSide_GuildID )
----	
----
--	if winner == 1 then
--		--EndGuildChallenge ( RedSide_GuildID , BlueSide_GuildID , 1 )
--		--LG( "PK_JJHY","擂主胜利" )
--		local Notice_all = "海盗阵营获得了胜利！"
--		Notice ( Notice_all )
--
--	elseif winner == 2 then
--		--EndGuildChallenge ( RedSide_GuildID , BlueSide_GuildID , 1 )
--		--LG( "PK_JJHY","擂主胜利" )
--		local Notice_all = "海军阵营获得了胜利！"
--		Notice ( Notice_all )
--	else
--		local Notice_all = "双方激战3小时未分胜负，请大家下一轮再接再厉！"
--		Notice ( Notice_all )
--	end
	--How_Many_Active2 = GetMapActivePlayer(map_copy)
	--if How_Many_Active2 > 0 then
	--	DealAllActivePlayerInMap(map_copy,"Give_Three_QiYue2")
	--end
	--How_Many_Active2 = 0
	
	local player_num = GetMapPlayer(map_copy)

	--Notice("player_num = "..player_num)

	DealAllPlayerInMap(map_copy,"All_Goto2")
	player_num = GetMapPlayer(map_copy)

	--Notice("player_num = "..player_num)
	
	local pn = player_num * 10
	
	for i=1, pn, 1 do
		if player_num > 0 then
			--local Notice_all2 = "player_num > 0"
			--Notice(Notice_all2)
			DealAllPlayerInMap(map_copy,"All_Goto2")
		end
	end

	--ClearAllSubMapCha(map_copy)

end

--地图关闭时执行
function map_copy_close_guildwar2 ( map_copy )

--How_Many_Active2 = 0
--ClearAllSubMapCha(map_copy)
count_haijun2 = 0
count_haidao2 = 0
five_seconds2 = 0
second_five_seconds2 = 0
time_can_setmonster2 = 0
time_can_setnvsheng2 = 0
check_need_show2 = 0
create_boss_hj2 = 0
create_boss_hd2 = 0
--create_two_side_lose2 = 0
GUILDWARCLOSETIME2 = 10800

di_haijunSide_JDNotice = 0
di_haijunSide_LCNotice = 0
di_haijunSide_DYKNotice =0
di_haidaoSide_JDNotice = 0
di_haidaoSide_LCNotice = 0
di_haidaoSide_DYKNotice= 0

--ClearAllSubMapMonster(map_copy)
ClearAllSubMapCha(map_copy)


	
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_guildwar2( map ) 
--	local time = GetTickCount ( ) 
--	local Now_Week = GetNowWeek()
--	if Now_Week >=5 and Now_Week < 7 then
--		return 1
--	end
--
--	if Now_Week == 0 then
--		return 1
--	end

	return 1 
end 
function HJ_Goto2(role)
   
  local typRoleType = ChaIsBoat(role)			--取角色类型 船？人？NPC.......
	if  typRoleType == 1 then 						 --如果角色是船
		if GetChaGuildID(role) <= 100 and GetChaGuildID(role) > 0 then
		    --for i=1, 45, 1 do
			MoveTo( role,  839, 3693,  "magicsea" )
		    --end
                      
		else
		    return
		end
		    
	else															--角色不是船
		local character = TurnToCha(role)	--将指针转换为角色
		if GetChaGuildID(character) <= 100 and GetChaGuildID(character) > 0 then
		      --for i=1, 45, 1 do
			  MoveTo( character,  910, 3571,  "magicsea" )
		      --end
			 
	        else
		      return
		end
		        
	end
	
end

function HD_Goto2(role)
   
 local typRoleType = ChaIsBoat(role)			--取角色类型 船？人？NPC.......
	if  typRoleType == 1 then 						 --如果角色是船
		if GetChaGuildID(role) > 100 and GetChaGuildID(role) <= 200 then
	               --for i=1, 45, 1 do
			   MoveTo( role,  1188, 674,  "darkblue" )
		       --end
		else
		    return
		end
		    
	else												--角色不是船
		 local character = TurnToCha(role)	--将指针转换为角色
		 if GetChaGuildID(character) > 100 and GetChaGuildID(character) <= 200 then
		      --for i=1, 45, 1 do
			   MoveTo( character,  1271, 527,  "darkblue" )
		      --end
		 else
		      return
		 end
		        
	 end
	
end

function noside_Goto2(role)
   
local typRoleType = ChaIsBoat(role)			--取角色类型 船？人？NPC.......
		if  typRoleType == 1 then 						 --如果角色是船
		    if GetChaGuildID(role) == 0 then
                       MoveTo( role,  2259, 2828,  "garner" )
		    else
		       return
		    end
		    
		else															--角色不是船
		      local character = TurnToCha(role)	--将指针转换为角色
			if GetChaGuildID(character) == 0 then
			  MoveTo( character,  2222, 2777,  "garner" )
			else
			  return
			end
		        
	        end
	
end

function All_Goto2(role)
      local typRoleType = ChaIsBoat(role)			--取角色类型 船？人？NPC.......
		if  typRoleType == 1 then 						 --如果角色是船
		    if GetChaGuildID(role) > 100 and GetChaGuildID(role) <= 200 then
                       MoveTo( role,  1188, 674,  "darkblue" )
		    else
		       MoveTo( role,  839, 3693,  "magicsea" )
		    end
		    
		else															--角色不是船
		    local character = TurnToCha(role)	--将指针转换为角色
		    if GetChaGuildID(character) > 100 and GetChaGuildID(character) <= 200 then
			MoveTo( character,  1271, 527,  "darkblue" )
		    else
			MoveTo( character,  910, 3571,  "magicsea" )
		    end
		        
	        end

end

function Give_Three_QiYue2( role )
   local Item_CanGet = GetChaFreeBagGridNum ( role )
	   if Item_CanGet <= 0 then
		   GiveItemX ( role , 0 , 2383  , 3 , 4 )
	   else
		   GiveItem ( role , 0 , 2383  , 3 , 4 )
	   end
end		 



		
	   


