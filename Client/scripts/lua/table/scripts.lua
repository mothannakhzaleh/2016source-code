
--精炼效果表示
function Item_Stoneeffect ( Stone_Type1 , Stone_Type2 , Stone_Type3 )
	if Stone_Type1 == Stone_Type2 then
		Stone_Type1 = -1
	end

	if Stone_Type1 == Stone_Type3 then
		Stone_Type1 = -1
	end
	
	if Stone_Type2 == Stone_Type3 then
		Stone_Type2 = -1
	end
	
	local jia = Stone_Type1 + Stone_Type2 + Stone_Type3
	local cheng = Stone_Type1 * Stone_Type2 * Stone_Type3
	if cheng > 0 then
		if jia == -1 then
			return 1
		elseif jia == 0 then
			return 2
		elseif jia == 1 then
			return 3
		elseif jia == 2 then
			return 4
		elseif jia == 6 then
			return 11
		elseif jia == 7 then
			return 12
		elseif jia == 8 then
			return 13
		elseif jia == 9 then
			return 14
		end
	elseif cheng < 0 then
		if jia == 2 then
			return 5
		elseif jia == 3 then
			return 6
		elseif jia == 4 then
			if cheng == -4 then
				return 7
			elseif cheng == -6 then
				return 8
			end
		elseif jia == 5 then
			return 9
		elseif jia == 6 then 
			return 10
		end
	end
	return 0
end

---------------------------------------------------------------------------------------------------------------------


--解析精炼内容

function GetNum_Part1 ( Num )
	local a = 0
	a = math.floor ( Num / 1000000000 )
	return a
end

function GetNum_Part2 ( Num )
	local a = 0
	local b = 0
	a = Num - GetNum_Part1 ( Num ) * 1000000000
	b = math.floor ( a / 10000000 )
	return b
end

function GetNum_Part3 ( Num )
	local a = 0
	local b = 0
	a = Num - math.floor ( Num / 10000000 ) * 10000000
	b = math.floor ( a / 1000000 )
	return b
end

function GetNum_Part4 ( Num )
	local a = 0
	local b = 0
	a = Num - math.floor ( Num / 1000000 ) *1000000
	b = math.floor ( a / 10000 )
	return b
end

function GetNum_Part5 ( Num )
	local a = 0
	local b = 0
	a = Num -  math.floor ( Num / 10000 ) * 10000
	b = math.floor ( a / 1000 )
	return b
end

function GetNum_Part6 ( Num )
	local a = 0
	local b = 0
	a = Num - math.floor ( Num / 1000 ) *1000
	b = math.floor ( a / 10 )
	return b
end

function GetNum_Part7 ( Num )
	local a = 0
	local b = 0
	a = Num - math.floor ( Num / 10 ) *10
	b = math.floor ( a / 1 )
	return b
end


--写入部分

function SetNum_Part1 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part1 ( Num )
	b = Part_Num - a
	Num = Num + b * 1000000000
	return Num
end

function SetNum_Part2 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part2 ( Num )
	b = Part_Num - a
	Num = Num + b * 10000000
	return Num
end

function SetNum_Part3 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part3 ( Num )
	b = Part_Num - a
	Num = Num + b * 1000000
	return Num
end

function SetNum_Part4 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part4 ( Num )
	b = Part_Num - a
	Num = Num + b * 10000
	return Num
end

function SetNum_Part5 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part5 ( Num )
	b = Part_Num - a
	Num = Num + b * 1000
	return Num
end

function SetNum_Part6 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part6 ( Num )
	b = Part_Num - a
	Num = Num + b * 10
	return Num
end

function SetNum_Part7 ( Num , Part_Num )
	local a = 0
	local b = 0
	a = GetNum_Part7 ( Num )
	b = Part_Num - a
	Num = Num + b * 1
	return Num
end


-------------------------------------------------------------------------------------------------------------------


--读取洞数

function Get_HoleNum ( Num )
	local a = GetNum_Part1 ( Num )
	return a
end

--读取宝石信息
function Get_Stone_1 ( Num )
	local Stone_1 = 0
	Stone_1 = GetNum_Part2 ( Num )
	return Stone_1
end

function Get_StoneLv_1 ( Num )
	local Stone_1 = 0
	Stone_1 = GetNum_Part3 ( Num )
	return Stone_1
end

function Get_Stone_2 ( Num )
	local Stone_2 = 0
	Stone_2 = GetNum_Part4 ( Num )
	return Stone_2
end

function Get_StoneLv_2 ( Num )
	local Stone_2 = 0
	Stone_2 = GetNum_Part5 ( Num )
	return Stone_2
end

function Get_Stone_3 ( Num )
	local Stone_3 = 0
	Stone_3 = GetNum_Part6 ( Num )
	return Stone_3
end

function Get_StoneLv_3 ( Num )
	local Stone_3 = 0
	Stone_3 = GetNum_Part7 ( Num )
	return Stone_3
end

------------------------------
--Hint对应函数
function ItemHint_LieYanS ( Lv )
	local eff = Lv * 4
	TABLE_SCRIPTS_LUA_000001 = GetResString("TABLE_SCRIPTS_LUA_000001")
	local Hint = TABLE_SCRIPTS_LUA_000001..eff
	return Hint
end

function ItemHint_ZhiYanS ( Lv )
	local eff = Lv * 6
	TABLE_SCRIPTS_LUA_000001 = GetResString("TABLE_SCRIPTS_LUA_000001")
	local Hint = TABLE_SCRIPTS_LUA_000001..eff
	return Hint
end

function ItemHint_HuoYaoS ( Lv )
	local eff = Lv * 10
	TABLE_SCRIPTS_LUA_000001 = GetResString("TABLE_SCRIPTS_LUA_000001")
	local Hint = TABLE_SCRIPTS_LUA_000001..eff
	return Hint
end

function ItemHint_MaNaoS ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000002 = GetResString("TABLE_SCRIPTS_LUA_000002")
	local Hint = TABLE_SCRIPTS_LUA_000002..eff
	return Hint
end

function ItemHint_HanYu ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000003 = GetResString("TABLE_SCRIPTS_LUA_000003")
	local Hint = TABLE_SCRIPTS_LUA_000003..eff
	return Hint
end

function ItemHint_YueZhiX ( Lv )
	local eff = Lv * 100
	TABLE_SCRIPTS_LUA_000004 = GetResString("TABLE_SCRIPTS_LUA_000004")
	local Hint = TABLE_SCRIPTS_LUA_000004..eff
	return Hint
end

function ItemHint_ShuiLingS ( Lv )
	local eff = Lv * 2
	TABLE_SCRIPTS_LUA_000005 = GetResString("TABLE_SCRIPTS_LUA_000005")
	local Hint = TABLE_SCRIPTS_LUA_000005..eff
	return Hint
end

function ItemHint_ShengGuangS ( Lv )
	local eff = Lv * 1
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint = TABLE_SCRIPTS_LUA_000006..eff
	return Hint
end

---2006-02-23 添加

function ItemHint_FengLingS ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000007 = GetResString("TABLE_SCRIPTS_LUA_000007")
	local Hint = TABLE_SCRIPTS_LUA_000007..eff
	return Hint
end

function ItemHint_YingYanS ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000008 = GetResString("TABLE_SCRIPTS_LUA_000008")
	local Hint = TABLE_SCRIPTS_LUA_000008..eff
	return Hint
end

function ItemHint_YanVitS ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint = TABLE_SCRIPTS_LUA_000009..eff
	return Hint
end

function ItemHint_YanStrS ( Lv )
	local eff = Lv * 5
	TABLE_SCRIPTS_LUA_000010 = GetResString("TABLE_SCRIPTS_LUA_000010")
	local Hint = TABLE_SCRIPTS_LUA_000010..eff
	return Hint
end

function ItemHint_LongZhiTong ( Lv )
	local eff = Lv * 50
	TABLE_SCRIPTS_LUA_000011 = GetResString("TABLE_SCRIPTS_LUA_000011")
	local Hint = TABLE_SCRIPTS_LUA_000011..eff
	return Hint
end

function ItemHint_LongZhiHun ( Lv )
	local eff = Lv * 3
	TABLE_SCRIPTS_LUA_000012 = GetResString("TABLE_SCRIPTS_LUA_000012")
	local Hint = TABLE_SCRIPTS_LUA_000012..eff
	return Hint
end

function ItemHint_LongZhiXin ( Lv )
	local eff = Lv * 500
	TABLE_SCRIPTS_LUA_000004 = GetResString("TABLE_SCRIPTS_LUA_000004")
	local Hint = TABLE_SCRIPTS_LUA_000004..eff
	return Hint
end
--2006-09-18添加
function ItemHint_GaNaZhiShen ( Lv )
	local eff =  Lv *5
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint = TABLE_SCRIPTS_LUA_000006..eff
	return Hint
end

--2008-02-20 dina添加
function ItemHint_HuangYu ( Lv )
	local eff =  Lv *10
	TABLE_SCRIPTS_LUA_000013 = GetResString("TABLE_SCRIPTS_LUA_000013")
	local Hint = TABLE_SCRIPTS_LUA_000013..eff
	return Hint
end

function ItemHint_ChiYu ( Lv )
	local eff =  Lv *200
	TABLE_SCRIPTS_LUA_000004 = GetResString("TABLE_SCRIPTS_LUA_000004")
	local Hint = TABLE_SCRIPTS_LUA_000004..eff
	return Hint
end

function ItemHint_QingYu ( Lv )
	local eff =  Lv *200
	TABLE_SCRIPTS_LUA_000014 = GetResString("TABLE_SCRIPTS_LUA_000014")
	local Hint = TABLE_SCRIPTS_LUA_000014..eff
	return Hint
end

--2008-04-24 晓玮添加

function ItemHint_XTLingGuang ( Lv )
	local eff =  Lv *10
	TABLE_SCRIPTS_LUA_000015 = GetResString("TABLE_SCRIPTS_LUA_000015")
	local Hint = TABLE_SCRIPTS_LUA_000015..eff
	return Hint
end

function ItemHint_LKBiZhong ( Lv )
	local eff =  Lv *10
	TABLE_SCRIPTS_LUA_000016 = GetResString("TABLE_SCRIPTS_LUA_000016")
	local Hint = TABLE_SCRIPTS_LUA_000016..eff
	return Hint
end

function ItemHint_BBDuoShan ( Lv )
	local eff =  Lv *10
	TABLE_SCRIPTS_LUA_000017 = GetResString("TABLE_SCRIPTS_LUA_000017")
	local Hint = TABLE_SCRIPTS_LUA_000017..eff
	return Hint
end

function ItemHint_FFDiYu ( Lv )
	local eff =  Lv *15
	TABLE_SCRIPTS_LUA_000013 = GetResString("TABLE_SCRIPTS_LUA_000013")
	local Hint = TABLE_SCRIPTS_LUA_000013..eff
	return Hint
end

function ItemHint_XKQiangHua ( Lv )
	local eff =  Lv *300
	TABLE_SCRIPTS_LUA_000004 = GetResString("TABLE_SCRIPTS_LUA_000004")
	local Hint = TABLE_SCRIPTS_LUA_000004..eff
	return Hint
end
-------高超加
function ItemHint_SShuiyao ( Lv )
	local eff =  Lv *8
	TABLE_SCRIPTS_LUA_000010 = GetResString("TABLE_SCRIPTS_LUA_000010")
	local Hint = TABLE_SCRIPTS_LUA_000010..eff
	return Hint
end

function ItemHint_SSbusi ( Lv )
	local eff =  Lv *8
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint = TABLE_SCRIPTS_LUA_000009..eff
	return Hint
end
function ItemHint_SSguangmang ( Lv )
	local eff =  Lv *8
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint = TABLE_SCRIPTS_LUA_000006..eff
	return Hint
end
function ItemHint_SSningju ( Lv )
	local eff =  Lv *8
	TABLE_SCRIPTS_LUA_000008 = GetResString("TABLE_SCRIPTS_LUA_000008")
	local Hint = TABLE_SCRIPTS_LUA_000008..eff
	return Hint
end
function ItemHint_SSxuanwu ( Lv )
	local eff =  Lv *8
	TABLE_SCRIPTS_LUA_000007 = GetResString("TABLE_SCRIPTS_LUA_000007")
	local Hint = TABLE_SCRIPTS_LUA_000007..eff
	return Hint
end
------- by Peter
function ItemHint_ABOLUO ( Lv )
	TABLE_SCRIPTS_LUA_000018 = GetResString("TABLE_SCRIPTS_LUA_000018")
	local Hint = TABLE_SCRIPTS_LUA_000018
	return Hint
end

function ItemHint_QIUBITE ( Lv )
	TABLE_SCRIPTS_LUA_000018 = GetResString("TABLE_SCRIPTS_LUA_000018")
	local Hint = TABLE_SCRIPTS_LUA_000018
	return Hint
end

function ItemHint_YADIANNA ( Lv )
	TABLE_SCRIPTS_LUA_000018 = GetResString("TABLE_SCRIPTS_LUA_000018")
	local Hint = TABLE_SCRIPTS_LUA_000018
	return Hint
end

function GetElfSkill ( Num )



end


----------------------------获取精灵特殊能力----------------------------------------------
function GetElfSkill ( Num )
	--local Part1 = GetNum_Part1 ( Num )	--Get Num Part 1 到 Part 7
	local Part2 = GetNum_Part2 ( Num )
	local Part3 = GetNum_Part3 ( Num )
	local Part4 = GetNum_Part4 ( Num )
	local Part5 = GetNum_Part5 ( Num )
	local Part6 = GetNum_Part6 ( Num )
	local Part7 = GetNum_Part7 ( Num )

	return Part3 , Part2 , Part5 , Part4 , Part7 , Part6 

end
function ItemHint_SLTZBS( Lv )	
	local eff = Lv * 1	
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint =TABLE_SCRIPTS_LUA_000009..eff	
	return Hint	
end

function ItemHint_HLS( Lv )	
	local eff = Lv * 2	
	TABLE_SCRIPTS_LUA_000007 = GetResString("TABLE_SCRIPTS_LUA_000007")
	local Hint =TABLE_SCRIPTS_LUA_000007..eff	
	return Hint	
end

function ItemHint_HYS( Lv )	
	local eff = Lv * 3	
	TABLE_SCRIPTS_LUA_000007 = GetResString("TABLE_SCRIPTS_LUA_000007")
	local Hint =TABLE_SCRIPTS_LUA_000007..eff	
	return Hint	
end

function ItemHint_HJS( Lv )	
	local eff = Lv * 4	
	TABLE_SCRIPTS_LUA_000007 = GetResString("TABLE_SCRIPTS_LUA_000007")
	local Hint =TABLE_SCRIPTS_LUA_000007..eff	
	return Hint	
end

function ItemHint_BLS( Lv )	
	local eff = Lv * 2	
	TABLE_SCRIPTS_LUA_000008 = GetResString("TABLE_SCRIPTS_LUA_000008")
	local Hint =TABLE_SCRIPTS_LUA_000008..eff	
	return Hint	
end

function ItemHint_BYS( Lv )	
	local eff = Lv * 3	
	TABLE_SCRIPTS_LUA_000008 = GetResString("TABLE_SCRIPTS_LUA_000008")
	local Hint =TABLE_SCRIPTS_LUA_000008..eff	
	return Hint	
end

function ItemHint_BJS( Lv )	
	local eff = Lv * 4	
	TABLE_SCRIPTS_LUA_000008 = GetResString("TABLE_SCRIPTS_LUA_000008")
	local Hint =TABLE_SCRIPTS_LUA_000008..eff	
	return Hint	
end

function ItemHint_CLS( Lv )	
	local eff = Lv * 2	
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint =TABLE_SCRIPTS_LUA_000009..eff	
	return Hint	
end

function ItemHint_CYS( Lv )	
	local eff = Lv * 3	
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint =TABLE_SCRIPTS_LUA_000009..eff	
	return Hint	
end

function ItemHint_CJS( Lv )	
	local eff = Lv * 4	
	TABLE_SCRIPTS_LUA_000009 = GetResString("TABLE_SCRIPTS_LUA_000009")
	local Hint =TABLE_SCRIPTS_LUA_000009..eff	
	return Hint	
end

function ItemHint_ZLS( Lv )	
	local eff = Lv * 2	
	TABLE_SCRIPTS_LUA_000010 = GetResString("TABLE_SCRIPTS_LUA_000010")
	local Hint =TABLE_SCRIPTS_LUA_000010..eff	
	return Hint	
end

function ItemHint_ZYS( Lv )	
	local eff = Lv * 3	
	TABLE_SCRIPTS_LUA_000010 = GetResString("TABLE_SCRIPTS_LUA_000010")
	local Hint =TABLE_SCRIPTS_LUA_000010..eff	
	return Hint	
end

function ItemHint_ZJS( Lv )	
	local eff = Lv * 4	
	TABLE_SCRIPTS_LUA_000010 = GetResString("TABLE_SCRIPTS_LUA_000010")
	local Hint =TABLE_SCRIPTS_LUA_000010..eff	
	return Hint	
end

function ItemHint_QLS( Lv )	
	local eff = Lv * 2	
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint =TABLE_SCRIPTS_LUA_000006..eff	
	return Hint	
end

function ItemHint_QYS( Lv )	
	local eff = Lv * 3	
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint =TABLE_SCRIPTS_LUA_000006..eff	
	return Hint	
end

function ItemHint_QJS( Lv )	
	local eff = Lv * 4	
	TABLE_SCRIPTS_LUA_000006 = GetResString("TABLE_SCRIPTS_LUA_000006")
	local Hint =TABLE_SCRIPTS_LUA_000006..eff	
	return Hint	
end

------------------X1补-----------------
function ItemHint_GGR ( Lv )
	local eff = Lv * 6	
	local Hint ="Gem Bonus Strength +"..eff	
	return Hint	
end 
function ItemHint_GGS ( Lv )
	local eff = Lv * 6	
	local Hint ="Gem Bonus Spirit +"..eff	
	return Hint	
end 
function ItemHint_GGOS ( Lv )
	local eff = Lv * 6	
	local Hint ="Added Accuracy +"..eff	
	return Hint	
end 
function ItemHint_GGC ( Lv )
	local eff = Lv * 6	
	local Hint ="Gem Bonus Constitution +"..eff	
	return Hint	
end 
function ItemHint_GGW ( Lv )
	local eff = Lv * 6	
	local Hint ="Gem Bonus Agility +"..eff	
	return Hint	
end 
function ItemHint_JinYanS ( Lv )
	local eff = Lv * 2
	local Hint = "Gem Bonus Strength +"..eff
	return Hint
end
function ItemHint_MuYanS ( Lv )
	local eff = Lv * 2
	local Hint = "Gem Bonus Spirit +"..eff
	return Hint
end
function ItemHint_ShuiYanS ( Lv )
	local eff = Lv * 2
	local Hint = "Added Accuracy +"..eff
	return Hint
end
function ItemHint_HuoYanS ( Lv )
	local eff = Lv * 2
	local Hint = "Gem Bonus Agility +"..eff
	return Hint
end
function ItemHint_TuYanS ( Lv )
	local eff = Lv * 2
	local Hint = "Gem Bonus Constitution +"..eff
	return Hint
end
--------------------X1补-------------------------
-------------------Daniel.li----------------------
function ItemHint_SaDanWG ( Lv )
	local eff = Lv * 20
	local Hint = "Gem Bonus Defense +"..eff
	return Hint
end 
function ItemHint_SaDanQH ( Lv )
	local eff = Lv * 300
	local Hint = "Gem Bonus Max HP +"..eff
	return Hint
end 
function ItemHint_SaDanZH ( Lv )
	local eff = Lv * 3
	local Hint = "Gem Bonus Spirit +"..eff
	return Hint
end 
function ItemHint_SaDanNX ( Lv )
	local eff = Lv * 3
	local Hint = "Gem Bonus Accuracy +"..eff
	return Hint
end 
function ItemHint_SaDanJF ( Lv )
	local eff = Lv * 3
	local Hint = "Gem Bonus Agility +"..eff
	return Hint
end 
-------------------Daniel.li----------------------
function ItemHint_LuoKeZL ( Lv )
	local eff = Lv * 3
	local Hint = "Gem Bonus Accuracy +"..eff
	return Hint
end 

function ItemHint_MLZY ( Lv ) ------魔龙之牙.小苏苏
	local eff = Lv * 20
	local Hint = "Critical Rate +"..eff
	return Hint
end

function ItemHint_DuanHunFW ( Lv ) -----断魂符文-ljf
	local eff = Lv * 5
	local Hint = "Reduces target's Physical Resistance "..eff
	return Hint
end

function ItemHint_PoFangFW ( Lv ) -----破防符文-ljf
	local eff = Lv * 50
	local Hint = "Reduces target's Defense "..eff
	return Hint
end

function ItemHint_HuanMoFW ( Lv ) -----幻魔符文-ljf
	local eff = Lv * 10
	local Hint = "Reduces target's Dodge "..eff
	return Hint
end


function ItemHint_QiFuFW ( Lv ) -----祈福符文-ljf
	local eff = Lv * 5
	local Hint = "Exp from monsters increased by "..eff.."%"
	return Hint
end

function ItemHint_EnCiFW ( Lv ) -----恩赐符文-ljf
	local eff = Lv * 5
	local Hint = "Drop Rate from monsters increased by "..eff.."%"
	return Hint
end

function ItemHint_WuZhouFW ( Lv ) -----巫咒符文-ljf
	local eff = Lv * 10
	local Hint = "Reduces target's Hit Rate "..eff
	return Hint
end 