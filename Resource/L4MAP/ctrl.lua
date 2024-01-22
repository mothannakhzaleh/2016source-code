--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
	MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
	MapCanPK(map, 1)
	MapCanTeam(map , 1)
	MapType ( map , 4 )
	SingleMapCopyPlyNum(map, 150)   --设置一个副本的玩家数
end


function get_map_entry_pos_L4MAP()   --设置入口的位置的坐标（坐标（米））
	local POS_X=2831
	local POS_Y=2710
	return POS_X , POS_Y
end

function init_entry(map)
    SetMapEntryMapName(map, "garner") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2011/5/4/21/0", "0/3/0", "0/1/30", "0/2/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

-- function after_enter_L4MAP( role , map_copy )
-- end


-- function before_leave_L4MAP( role )
-- end

-- function map_copy_first_run_L4MAP( map_copy )
-- end

-- lanlong = nil
-- honglong = nil
-- lvlong = nil
-- lanlongpaotai1 = nil
-- lanlongpaotai2 = nil
-- lanlongpaotai3 = nil
-- lanlongpaotai4 = nil
-- honglongpaotai1 = nil
-- honglongpaotai2 = nil
-- honglongpaotai3 = nil
-- honglongpaotai4 = nil
-- lvlongpaotai1 = nil
-- lvlongpaotai2 = nil
-- lvlongpaotai3 = nil
-- lvlongpaotai4 = nil
-- lanlongflag = nil --1.活 0.死
-- honglongflag = nil
-- lvlongflag = nil
-- lanlongpaotai1flag = nil 
-- lanlongpaotai2flag = nil
-- lanlongpaotai3flag = nil
-- lanlongpaotai4flag = nil
-- honglongpaotai1flag = nil
-- honglongpaotai2flag = nil
-- honglongpaotai3flag = nil
-- honglongpaotai4flag = nil
-- lvlongpaotai1flag = nil
-- lvlongpaotai2flag = nil
-- lvlongpaotai3flag = nil
-- lvlongpaotai4flag = nil

function map_copy_run_L4MAP( map_copy )


	if CheckMonsterDead ( L4MAPMonster[1] ) == 1 then
		if (lanlongflag == 0 or CheckLLDead (lanlong) == 2) and AddPanduan[1] == 0 then
				KillMonsterInMapByName(map_copy,"Blue Dragon Statue")
			
				local Notice_all = "Blue Dragon: Who is the one disturb my rest!!!"
				MapCopyNotice ( map_copy , Notice_all )
				lanlong = CreateCha(1380, 13952, 46958, 145, 60)
				SetChaLifeTime(lanlong,10800000)
				lanlongpaotai1 = CreateCha(1383, 13152, 45958, 145, 60)
				SetChaLifeTime(lanlongpaotai1,10800000)
				lanlongpaotai2 = CreateCha(1384, 13152, 47658, 145, 60)
				SetChaLifeTime(lanlongpaotai2,10800000)
				lanlongpaotai3 = CreateCha(1385, 14752, 47658, 145, 60)
				SetChaLifeTime(lanlongpaotai3,10800000)
				lanlongpaotai4 = CreateCha(1386, 14752, 45958, 145, 60)
				SetChaLifeTime(lanlongpaotai4,10800000)

				lanlongflag = 1
				lanlongpaotai1flag = 1
				lanlongpaotai2flag = 1
				lanlongpaotai3flag = 1
				lanlongpaotai4flag = 1
				AddPanduan[1] = 1
		end
	elseif  CheckMonsterDead ( L4MAPMonster[1] ) == 0 and AddPanduan[7] == 0 then                     ----------箱子无敌
			lanlongdiaoxiang = CreateCha(1395, 13965, 46932, 270, 60)
			SetChaLifeTime(lanlongdiaoxiang,10800000)
			local statelv = 10
			local statetime = 10800
			if statetime <5 then
				statetime =10800
			end
			AddState( L4MAPMonster[1] , lanlongdiaoxiang , STATE_PKWD , statelv , statetime )
	end	
			
			

	if CheckMonsterDead ( L4MAPMonster[2] ) == 1 then
		if (honglongflag == 0 or CheckHLDead (honglong) == 2) and AddPanduan[2] == 0 then
				KillMonsterInMapByName(map_copy,"Red Dragon Statue")
				local Notice_all = "Red Dragon: Who is the one disturb my rest!!!"
				MapCopyNotice ( map_copy , Notice_all )
				honglong = CreateCha(1381, 10752, 42658, 145, 60)
				SetChaLifeTime(honglong,10800000)
				honglongpaotai1 = CreateCha(1387, 9852, 41858, 145, 60)
				SetChaLifeTime(honglongpaotai1,10800000)
				honglongpaotai2 = CreateCha(1388, 9852, 43658, 145, 60)
				SetChaLifeTime(honglongpaotai2,10800000)
				honglongpaotai3 = CreateCha(1389, 11652, 43658, 145, 60)
				SetChaLifeTime(honglongpaotai3,10800000)
				honglongpaotai4 = CreateCha(1390, 11652, 41858, 145, 60)
				SetChaLifeTime(honglongpaotai4,10800000)	
				
				honglongflag = 1
				honglongpaotai1flag = 1
				honglongpaotai2flag = 1
				honglongpaotai3flag = 1
				honglongpaotai4flag = 1
				AddPanduan[2] = 1
			
		end
	elseif CheckMonsterDead ( L4MAPMonster[2] ) == 0 and AddPanduan[8] == 0 then                      ----------箱子无敌
		honglongdiaoxiang = CreateCha(1396, 10765, 42732, 270, 60)
		SetChaLifeTime(honglongdiaoxiang,10800000)
		local statelv = 10
		local statetime = 10800
		if statetime <5 then
			statetime =10800
		end
		AddState( L4MAPMonster[2] , honglongdiaoxiang , STATE_PKWD , statelv , statetime )

	end	
	

	if CheckMonsterDead ( L4MAPMonster[3] ) == 1 then
		if (lvlongflag == 0 or CheckLvLDead (lvlong) == 2) and AddPanduan[3] == 0 then
				KillMonsterInMapByName(map_copy,"Green Dragon Statue")
				local Notice_all = "Green Dragon: Who is the one disturb my rest!!!"
				MapCopyNotice ( map_copy , Notice_all )
				lvlong = CreateCha(1382, 14752, 40258, 145, 60)
				SetChaLifeTime(lvlong,10800000)
				lvlongpaotai1 = CreateCha(1391, 13852, 39458, 145, 60)
				SetChaLifeTime(lvlongpaotai1,10800000)
				lvlongpaotai2 = CreateCha(1392, 13852, 41258, 145, 60)
				SetChaLifeTime(lvlongpaotai2,10800000)
				lvlongpaotai3 = CreateCha(1393, 15652, 41258, 145, 60)
				SetChaLifeTime(lvlongpaotai3,10800000)
				lvlongpaotai4 = CreateCha(1394, 15652, 39458, 145, 60)
				SetChaLifeTime(lvlongpaotai4,10800000)	
				
				
				lvlongflag = 1
				lvlongpaotai1flag = 1
				lvlongpaotai2flag = 1
				lvlongpaotai3flag = 1
				lvlongpaotai4flag = 1
				
				AddPanduan[3] = 1
			
		end
	elseif CheckMonsterDead ( L4MAPMonster[3] ) == 0 and AddPanduan[6] == 0 then     ----------箱子无敌
			lvlongdiaoxiang = CreateCha(1397, 14765, 40332, 270, 60)	
			SetChaLifeTime(lvlongdiaoxiang,10800000)
			local statelv = 10
			local statetime = 10800
			if statetime <5 then
				statetime =10800
			end
			AddState( L4MAPMonster[3] , lvlongdiaoxiang , STATE_PKWD , statelv , statetime )
			AddPanduan[6] = 1
		
	end	
	
	


	
	
	
	if 	lanlongflag == 1 or honglongflag == 1 or lvlongflag == 1 
		or lanlongpaotai1flag == 1 or lanlongpaotai2flag == 1 or lanlongpaotai3flag == 1 or lanlongpaotai4flag == 1 
		or honglongpaotai1flag == 1 or honglongpaotai2flag == 1 or honglongpaotai3flag == 1 or honglongpaotai4flag == 1 
		or lvlongpaotai1flag == 1 or lvlongpaotai2flag == 1 or lvlongpaotai3flag == 1 or lvlongpaotai4flag == 1 then
	
			local a = CheckLLDead ( lanlong ,1380)	
			local b = CheckHLDead ( honglong ,1381)
			local c = CheckLvLDead ( lvlong ,1382)
			local d = CheckLLPD1Dead ( lanlongpaotai1 , 1383)
			local e = CheckLLPD2Dead ( lanlongpaotai2 , 1384)
			local f = CheckLLPD3Dead ( lanlongpaotai3 , 1385)
			local g = CheckLLPD4Dead ( lanlongpaotai4 , 1386)
			local h = CheckHLPD1Dead ( honglongpaotai1 , 1387)
			local i = CheckHLPD2Dead ( honglongpaotai2 , 1388)
			local j = CheckHLPD3Dead ( honglongpaotai3 , 1389)
			local k = CheckHLPD4Dead ( honglongpaotai4 , 1390)
			local l = CheckLvLPD1Dead ( lvlongpaotai1 , 1391)
			local m = CheckLvLPD2Dead ( lvlongpaotai2 , 1392)
			local n = CheckLvLPD3Dead ( lvlongpaotai3 , 1393)
			local o = CheckLvLPD4Dead ( lvlongpaotai4 , 1394)
			
			if a== 1 and b==1 and c==1  and d==1 and e==1 and f==1 and g==1 and h==1 and i==1 and j==1 and k==1 and l==1 and m==1 and n==1 and o==1 and AddPanduan[4] == 0 then
				local Notice_all = "Ancestor Dragon: I'm been kept in captivity for 10000 years and was chased our by my own country. And now, you are dare to step in to my manor. Your live ends here!"
				MapCopyNotice ( map_copy , Notice_all )
				NFLA_small = CreateCha(1376, 9952, 35358, 145, 60)
				SetChaLifeTime(NFLA_small,10800000)

				AddPanduan[4] = 1

			end
			
			local a = GetChaAttr( NFLA_small , ATTR_PDEF )
			local b = GetChaAttr ( NFLA_small , ATTR_HP )
			local d = GetChaAttr ( NFLA_small , ATTR_MXHP ) 
			local e = 100*b/d
			local mnatk = GetChaAttr(NFLA_small,ATTR_MNATK)
			local mxatk = GetChaAttr(NFLA_small,ATTR_MXATK)
			local atksp = GetChaAttr(NFLA_small, ATTR_ASPD)
			local p = CheckSZLLive(NFLA_small,1376)

			if AddPanduan[5] == 0  and p ==1 then 
				if a<70 or e<30  then
					local Notice_all = "Ancestor Dragon: Taste my wrath!"
					MapCopyNotice ( map_copy , Notice_all )
					SetChaAttr(NFLA_small, ATTR_MNATK, 2*mnatk)
					SetChaAttr(NFLA_small, ATTR_MXATK, 2*mxatk)
					SetChaAttr(NFLA_small, ATTR_ASPD, atksp/2)
					AddPanduan[5] =  1
				end
			end
			if AddPanduan[5]  ==1 and p == 1 then 
				if a>=70 and e>=30 then
					local Notice_all = "Ancestor Dragon: This feeling only last for a short ！！！"
					MapCopyNotice ( map_copy , Notice_all )			
					SetChaAttr(NFLA_small, ATTR_MNATK, mnatk/2)
					SetChaAttr(NFLA_small, ATTR_MXATK, mxatk/2)
					SetChaAttr(NFLA_small, ATTR_ASPD, 2*atksp)
					AddPanduan[5] = 0
				end
			end		
	end

end
	

		
	
	
	

--每5秒执行一次的
function map_run_L4MAP( map )

end

--地图关闭时执行
function map_copy_close_L4MAP ( map_copy )

	AddPanduan[1] = 0
	AddPanduan[2] = 0
	AddPanduan[3] = 0
	AddPanduan[4] = 0
	AddPanduan[5] = 0
	AddPanduan[6] = 0
	AddPanduan[7] = 0
	AddPanduan[8] = 0
	lanlong = nil
	honglong = nil
	lvlong = nil
	lvlongdiaoxiang = nil
	lanlongdiaoxiang= nil
	honglongdiaoxiang = nil
	lanlongpaotai1 = nil
	lanlongpaotai2 = nil
	lanlongpaotai3 = nil
	lanlongpaotai4 = nil
	honglongpaotai1 = nil
	honglongpaotai2 = nil
	honglongpaotai3 = nil
	honglongpaotai4 = nil
	lvlongpaotai1 = nil
	lvlongpaotai2 = nil
	lvlongpaotai3 = nil
	lvlongpaotai4 = nil
	lanlongflag = nil --1.活 0.死
	honglongflag = nil
	lvlongflag = nil
	lanlongpaotai1flag = nil 
	lanlongpaotai2flag = nil
	lanlongpaotai3flag = nil
	lanlongpaotai4flag = nil
	honglongpaotai1flag = nil
	honglongpaotai2flag = nil
	honglongpaotai3flag = nil
	honglongpaotai4flag = nil
	lvlongpaotai1flag = nil
	lvlongpaotai2flag = nil
	lvlongpaotai3flag = nil
	lvlongpaotai4flag = nil
	KillMonsterInMapByName(map_copy,"Detained Blue Dragon")
	KillMonsterInMapByName(map_copy,"Detained Red Dragon")
	KillMonsterInMapByName(map_copy,"Detained Green Dragon")
	KillMonsterInMapByName(map_copy,"Ancestor Dragon")
	KillMonsterInMapByName(map_copy,"Blue Dragon Fort1")
	KillMonsterInMapByName(map_copy,"Blue Dragon Fort2")
	KillMonsterInMapByName(map_copy,"Blue Dragon Fort3")
	KillMonsterInMapByName(map_copy,"Blue Dragon Fort4")
	KillMonsterInMapByName(map_copy,"Green Dragon Fort1")
	KillMonsterInMapByName(map_copy,"Green Dragon Fort2")
	KillMonsterInMapByName(map_copy,"Green Dragon Fort3")
	KillMonsterInMapByName(map_copy,"Green Dragon Fort4")
	KillMonsterInMapByName(map_copy,"Red Dragon Fort1")
	KillMonsterInMapByName(map_copy,"Red Dragon Fort2")
	KillMonsterInMapByName(map_copy,"Red Dragon Fort3")
	KillMonsterInMapByName(map_copy,"Red Dragon Fort4")

end
		
--地图开关判断——————————————————————————————————————————

-- function can_open_entry_L4MAP( map ) 
-- end 

-- function map_copy_run_special_L4MAP(map)
-- end
