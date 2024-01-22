--------------------------------------------------------------------------
--									--
--									--
--				NPCScript05.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript05.lua" )


-------------小白-------------------
function kzd_xiaobai()
	Talk(1,"Don't think I'm stupid because my name is Whitely, all crimals can't escape from my hawk eye.")
end
-------------小金-------------------
function kzd_xiaojin()
	Talk(1,"I'm not the blacksmith from Argent City, I'm like transformer~")
end
-------------所罗门-------------------
function kzd_suoluomen()
	Talk(1,"If you're here to report, please dial 110, if you want to buy me a drink, I've yet to knock off.")
end
-------------美索门-------------------
function kzd_meisuomen()
	Talk(1,"What matter do you have with me?")
end
------------哈旺-------------------
function kzd_hawang()
	Talk(1,"What matter do you have with our lord?")
end
------------哈财--------------------------
function kzd_hacai()
	Talk(1,"My lord is busy, please do not disturb.")
end
---------------------哈根达斯-------------------
function kzd_hagendasi()
	Talk(1,"Wang Xiao Hu is troubling me, do you have any idea?")
end
-------------------悠一----------------------
function kzd_youyi()
	Talk(1,"Yuichi: I can tell your fortune for free. If you are not happy with the first result, you can pay 20,000g to do it again. If you are still not happy, I'll re-do for 100,000g. If not, I'd be happy to work for a Louis XVI. The maximum time you can do is 6 per day.")
	
	InitTrigger()
	TriggerCondition(1, CanZhanBu,1)
	TriggerAction( 1, ZhanBu,1)
	TriggerFailure(1,JumpPage,7)
	Text(1,"I want my free divination for today.",MultiTrigger, GetMultiTrigger(), 1)
	Text(1,"Which divination should I use?",JumpPage,2)
	Text(1,"I want to change my fortune.",JumpPage,8)
	Text(1,"You look strong. Tell me your divine ability.",JumpPage,3)
	Text(1,"I want to check my divination status",JumpPage,5)
	Text(1,"I decide my faith, not the God!",CloseTalk)

	Talk(2,"Yuichi:","add","GetZhanBuInfo")
	InitTrigger()
	TriggerCondition(1, CanZhanBubyRole)
	TriggerAction( 1, ZhanBubyRole)
	TriggerFailure(1,JumpPage,6)
	Text(2,"Confirm.",MultiTrigger, GetMultiTrigger(), 1)
	Text(2,"Let me think about it.",CloseTalk)
	
	Talk(3,"Hehe, you can get stronger from my fortune telling. The price for the third time drop from a bottle of Louis XVI to 100,000g.")
	Text(3,"Expert fortune telling? What is the difference?",JumpPage,4)
	Text(3,"Let me try.",CloseTalk)

	Talk(4,"Yuichi: Nonono, if you get cursed, I can re-write the destiny and make it help you. Provided I did it successfully.")
	Text(4,"Let me try.",JumpPage,1)
	Text(4,"Got it.",CloseTalk)

	Talk(5,"Yuichi:","add","ZBChaXun")

	Talk(6,"Yuichi:","add","CanZhanBubyRole")

	Talk(7,"Yuichi:","add","CanZhanBu")

	Talk(8,"There are 3 ways of doing it: 20,000g, 100,000g or 1 Louis XVI. But note that if you use 100,000g for it, you can't do it with 20,000g today. Likewise for the Louis XVI.")
	Text(8,"I'm not very sure which method I should use",JumpPage,2)
	InitTrigger()
	TriggerCondition(1, CanZhanBu,2)
	TriggerAction( 1, ZhanBu,2)
	TriggerFailure(1,JumpPage,7)
	Text(8,"20,000 gold",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, CanZhanBu,3)
	TriggerAction( 1, ZhanBu,3)
	TriggerFailure(1,JumpPage,7)
	Text(8,"100,000 gold",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, CanZhanBu,4)
	TriggerAction( 1, ZhanBu,4)
	TriggerFailure(1,JumpPage,7)
	Text(8,"Louis XVI",MultiTrigger, GetMultiTrigger(), 1)
end
---------------------------小爱---------------------------
function kzd_xiaoai()
	Talk( 1, "Lovely: Hi, I am the banker Lovely." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Bank (Per 200g)", MultiTrigger, GetMultiTrigger(), 1)
	Talk( 2, "Sorry, but you don't have enough gold." )
end
---------------------------艾比------------------------------------
function kzd_aibi()
	Talk( 1, "Abby: Hi, I am the banker Abby." )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Bank (Per 200g)", MultiTrigger, GetMultiTrigger(), 1)
	Talk( 2, "Sorry, but you don't have enough gold." )
end
------------------------------小薰-----------------------------------
function kzd_xiaoxun()
	Talk( 1, "Oh who can tell me what is love in this world?" )
end
-----------------------------绵羊-----------------------------------
function kzd_mianyang()
	Talk( 1, "You know why the properties value raises so much? Hehe it's because of me." )
	AddNpcMission	(6948)
end
--------------------------------鸦之鸦---------------------------------
function kzd_yazhiya()
	Talk ( 1, "Hello, ello, llo, lo, this is echo you know? I'm the smug teleporter, you brought enough money?")
	Text ( 1, "Teleport to Forgotten Island", JumpPage, 7 )
	Text ( 1, "Teleport to Argent City", JumpPage, 2)
	Text ( 1, "Teleport to Shaitan City", JumpPage, 3)
	Text ( 1, "Teleport to Icicle City", JumpPage, 4)
	Text ( 1, "Record Respawn Point", JumpPage, 5 )
	Text ( 1, "Nothing, just looking around",CloseTalk )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 250,154, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 7, "Teleport to Forgotten Island. Please pay 2000g. Thank you.")
	Text( 7, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 2187,2776, "garner")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 2187,2776, "garner")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 2, "Teleport to Argent City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 918,3562, "magicsea")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 3, "Teleport to Shaitan City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 1323,544, "darkblue")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 4, "Teleport to Icicle City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 4, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2 )

	Talk( 5, "Marian: Record Respawn Point at Dream City?" )
	Text( 5, "Yes, please record", SetSpawnPos, "Dream City" )
	Text( 5, "No, nevermind",CloseTalk )

	Talk( 6, "Oh no, you don't have enough gold with you!" )
end
-------------------------------------飞飞-----------------------------------------
function kzd_feifei()
	Talk ( 1, "Port port port! BIU")
	Text ( 1, "Teleport to Region of the Demons!", JumpPage, 7)
	Text ( 1, "Teleport to Argent City", JumpPage, 2)
	Text ( 1, "Teleport to Shaitan City", JumpPage, 3)
	Text ( 1, "Teleport to Icicle City", JumpPage, 4)
	Text ( 1, "Record Respawn Point", JumpPage, 5 )
	Text ( 1, "Nothing, just looking around",CloseTalk )

	
	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 652,281, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 7, "Teleport to Region of the Demons! Please pay 2000g. Thank you.")
	Text( 7, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 2187,2776, "garner")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 2187,2776, "garner")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 2, "Teleport to Argent City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 918,3562, "magicsea")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 3, "Teleport to Shaitan City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 1323,544, "darkblue")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 4, "Teleport to Icicle City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 4, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2 )

	Talk( 5, "Marian: Record Respawn Point at Dream City?" )
	Text( 5, "Yes, please record", SetSpawnPos, "Dream City" )
	Text( 5, "No, nevermind",CloseTalk )

	Talk( 6, "Oh no, you don't have enough gold with you!" )
end
------------------------------------灰灰-------------------------------------
function kzd_huihui()
	Talk ( 1, "Port port port! BIU")
	Text ( 1, "Teleport to Argent City", JumpPage, 2)
	Text ( 1, "Teleport to Shaitan City", JumpPage, 3)
	Text ( 1, "Teleport to Icicle City", JumpPage, 4)
	Text ( 1, "Record Respawn Point", JumpPage, 5 )
	Text ( 1, "Nothing, just looking around",CloseTalk )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 2187,2776, "garner")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 2187,2776, "garner")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 2, "Teleport to Argent City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 918,3562, "magicsea")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 3, "Teleport to Shaitan City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 1323,544, "darkblue")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 4, "Teleport to Icicle City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 4, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2 )

	Talk( 5, "Marian: Record Respawn Point at Dream City?" )
	Text( 5, "Yes, please record", SetSpawnPos, "Dream City" )
	Text( 5, "No, nevermind",CloseTalk )

	Talk( 6, "Oh no, you don't have enough gold with you!" )
end
---------------------------------------咻咻--------------------------------------
function kzd_xiuxiu()
	Talk ( 1, "Port port port! BIU")
	Text ( 1, "Teleport to Argent City", JumpPage, 2)
	Text ( 1, "Teleport to Shaitan City", JumpPage, 3)
	Text ( 1, "Teleport to Icicle City", JumpPage, 4)
	Text ( 1, "Record Respawn Point", JumpPage, 5 )
	Text ( 1, "Nothing, just looking around",CloseTalk )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 2187,2776, "garner")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 2187,2776, "garner")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 2, "Teleport to Argent City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 918,3562, "magicsea")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 3, "Teleport to Shaitan City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2)

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 1323,544, "darkblue")
	TriggerFailure( 2, JumpPage, 6 )
	Talk( 4, "Teleport to Icicle City. Please pay 2000g. Free of charge for level 40 and below.")
	Text( 4, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2 )

	Talk( 5, "Marian: Record Respawn Point at Dream City?" )
	Text( 5, "Yes, please record", SetSpawnPos, "Dream City" )
	Text( 5, "No, nevermind",CloseTalk )

	Talk( 6, "Oh no, you don't have enough gold with you!" )
end
------------------------------小晶晶--------------------------------------------
function kzd_xiaojinjin()
	Talk( 1, "Hello, I am Jingle, many have the same name as me" )
	AddNpcMission ( 6890 )----抓捕王小虎
end
-----------------------------健----------------------------------------------
function kzd_jian()
	Talk( 1, "My wish is to heal, so, you need the medicine?" )
	Text( 1, "Trade", BuyPage )
	Text( 1, "Combine", OpenUnite)
	Text( 1, "Nothing, just looking around",CloseTalk )


	InitTrade()
	Other(	3206	)
	Other(	3208	)
	Other(	3205	)
	Other(	3242	)
	Other(	3210	)
	Other(	3207	)
	Other(	3211	)
	Other(	3215	)
	Other(	3212	)
	Other(	3209	)
	Other(	3220	)
	Other(	3222	)
	Other(	3219	)
	Other(	3218	)
	Other(	3216	)
	Other(	3223	)
	Other(	3217	)
	Other(	3224	)
	Other(	3225	)
	Other(	3226	)
	Other(	3294	)
	Other(	3295	)
	Other(	3141	)
	Other(	4602	)
	Other(	4603	)
	Other(	4604	)
	Other( 3296 )
	Other( 886 )
	Other(	1611	)
	Other(	1682	)
	Other(	1842	)
	Other(	1612	)
	Other(	1710	)
	Other(	1693	)
	Other(	4716	)
	Other(	1716	)
	Other(	1711	)
	Other(	3384	)
	Other(	3932	)
	Other(	1619	)
	Other(	2396	)
	Other(	1729	)
	Other(	4459	)
	Other(	1697	)
	Other(	1730	)
	Other(	1712	)
	Other(	1734	)
	Other(	1621	)
	Other(	1703	)
	Other(	6613	)
end
----------威士忌----------
function kzd_weishiji()
	Talk( 1, "Lets get drunk tonight!" )
	AddNpcMission	(6888)
end
---------尘芥---------
function kzd_chengjie()
	Talk( 1, "Nothing worth more than a sip of beer." )
	AddNpcMission	(6943)
end
----------灵儿---------
function kzd_linger()
	Talk( 1, "You saw my sister Yuki? She got lost…" )
end
----------雪影-------
function kzd_xueying()
	Talk( 1, "I miss my sister, but I did something unforgivable so I don’t dare to see her." )
end
----------蔚蓝---------
function kzd_weilan()
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, LvCheck, ">", 39 )
	TriggerCondition( 2, HasMoney, 20000 )
	TriggerAction( 2, TakeMoney, 20000 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )
	Talk( 1, "Blue: Hi, I am the nurse Blue from the City of Sky. You can look for me if you are not feeling well. Lv40 and above have to pay a fee of 20000g." )
	Text( 1, "Greater Heal", MultiTrigger,GetMultiTrigger(),2)
	Talk( 2, "Blue: Sorry you do not have the gold…")

end
------------老A-----------
function kzd_laoa()
	Talk( 1, "The seat will be mine eventually. Hehehe" )
	AddNpcMission	(6946)
end
--------------阿MAY-------
function kzd_amei()
	Talk( 1, "My wish is to become the prettiest girl alive, when that happen, call me Princess!" )
end

-------------苏珊大婶----------
function kzd_susandashen()
	Talk( 1, "That Jack stole my meat last night. Tell him not to be so greedy!" )
	AddNpcMission	(6944)
end

------------杰克大叔----------
function kzd_jiekedashu()
	Talk( 1, "Aunt Susan ask you to come right? I swear I never steal the meat!" )
end

------------红胡子爷爷----------
function kzd_honghuzi()
	Talk( 1, "Hihi, dear girl, come chat with grandpa" )
	AddNpcMission	(6945)
end

------------杰克大叔----------
function kzd_yumen()
	Talk( 1, "Don't need to say anymore, his life is just 2 words, cough~ Hey don’t go, I haven't finish" )
end

------------光荣----------
function kzd_guangrong()
	Talk( 1, "I have pride in selling items" )
end

----------闪亮-------------
function kzd_shanliang()
	Talk( 1, "I have got high class rings and necklace here, don’t worry about the price, we can talk about it later" )
	Text( 1, "Trade", BuyPage )

	InitTrade()
	Defence(	4666	)
	Defence(	4667	)
	Defence(	4668	)
	Defence(	4669	)
	Defence(	4671	)
	Defence(	4672	)
	Defence(	4673	)
	Defence(	4674	)
	Defence(	4675	)
	Defence(	4676	)
	Defence(	4677	)
	Defence(	4678	)
	Defence(	4679	)
	Defence(	4681	)
	Defence(	4682	)
	Defence(	4683	)
	Defence(	4684	)
	Defence(	4685	)
end
-----------非凡---------------------
function kzd_feifan()
	Talk( 1, "Come here and get what you don’t from outside~" )
end
---------------八折---------------------
function kzd_bazhe()
	Talk(1,"Hi, how can I help you?")
	Text( 1, "Trade", BuyPage )
	Text( 1, "Nothing, just looking around",CloseTalk )
	
	InitTrade()
	Other(	1611	)
	Other(	1682	)
	Other(	1842	)
	Other(	1612	)
	Other(	1710	)
	Other(	1693	)
	Other(	4716	)
	Other(	1716	)
	Other(	1711	)
	Other(	3384	)
	Other(	3932	)
	Other(	1619	)
	Other(	2396	)
	Other(	1729	)
	Other(	4459	)
	Other(	1697	)
	Other(	1730	)
	Other(	1712	)
	Other(	1734	)
	Other(	1621	)
	Other(	1703	)
end

-----------流连---------------------
function kzd_liulian()
	Talk( 1, "Today's special fruit -- Durian! Great for boy and girls!" )
end

----------霹雳----------------------
function kzd_pili()
	Talk( 1, "Hi, this is an armor and weapon shop." )
	Text( 1, "Trade", BuyPage )
	Text( 1, "Nothing, just looking around",CloseTalk )


	InitTrade()
	Weapon(	0008	)
	Weapon(	0196	)
	Weapon(	0197	)
	Weapon(	0198	)
	Weapon(	0097	)
	Weapon(	0104	)
	Weapon(	0098	)
	Weapon(	0105	)
	Weapon(	0099	)
	Weapon(	0106	)
	Weapon(	0101	)
	Weapon(	0107	)
	Weapon(	0102	)
	Weapon(	0108	)
	Weapon(	0100	)
	Weapon(	4301	)
	Weapon(	0103	)
	Weapon(	4302	)
	Weapon(	1427	)
	Weapon(	1428	)
	Weapon(	1429	)
	Weapon(	1430	)
	Weapon(	1431	)
	Weapon(	1432	)
	Weapon(	1433	)
	Weapon(	1434	)
	Weapon(	1435	)
	Weapon(	1436	)
	Weapon(	1437	)
	Weapon(	1438	)
	Weapon(	1440	)
	Weapon(	1441	)
	Weapon(	1462	)
	Weapon(	1463	)
	Weapon(	1464	)
	Weapon(	1465	)
	Weapon(	1466	)
	Weapon(	1467	)
	Weapon(	1468	)
	Weapon(	1469	)
	Weapon(	1470	)
	Weapon(	1471	)
	Weapon(	1472	)
	Weapon(	1473	)
	Weapon(	1475	)
	Weapon(	1476	)
	Weapon(	0817	)
	Weapon(	0818	)
	Weapon(	0867	)
	Weapon(	0868	)
	Weapon(	0872	)
	Weapon(	0873	)
	Weapon(	0635	)
	Weapon(	0636	)
end
----------金叔--------------
function kzd_jinshu()
	Talk( 1, "Hi, come find me if you want to upgrade or refine your gear." )
	Text( 1, "Repair", OpenRepair )
	Text( 1, "Forge", OpenForge)
	Text( 1, "Fusion", OpenMilling)
	Text( 1, "Apparel Fusion", OpenFusion)
	Text( 1, "Apparel Upgrade", OpenUpgrade)
	Text( 1, "You are too good… I can't compare to you",CloseTalk )
end
-----------------埃里克斯-----------
function kzd_ailikesi()
	Talk( 1, "Haagen Daz said Wang Xiao Hu jail break. I am very worried" )
	AddNpcMission	(6947)
end
----------------翠花------------------
function kzd_cuihua()
	Talk( 1, "Dear customer, we don’t sell salty vegetables here" )
end
----------------小丽------------------
function kzd_xiaoli()
	Talk( 1, "Hi, welcome. We have all the items from everywhere." )
	Text( 1, "Trade", BuyPage )

	InitTrade()
	Other(	3206	)
	Other(	3208	)
	Other(	3205	)
	Other(	3242	)
	Other(	3210	)
	Other(	3207	)
	Other(	3211	)
	Other(	3215	)
	Other(	3212	)
	Other(	3209	)
	Other(	3220	)
	Other(	3222	)
	Other(	3219	)
	Other(	3218	)
	Other(	3216	)
	Other(	3223	)
	Other(	3217	)
	Other(	3224	)
	Other(	3225	)
	Other(	3226	)
	Other(	3294	)
	Other(	3295	)
	Other(	3141	)
	Other(	4602	)
	Other(	4603	)
	Other(	4604	)
	Other( 3296 )
	Other( 886 )
	--baby--生活技能书Lv1
	--Other(	2679	)
	--Other(	2689	)
	--Other(	2699	)
	--Other(	2709	)
	--Leo
	Other(	1611	)
	Other(	1682	)
	Other(	1842	)
	Other(	1612	)
	Other(	1710	)
	Other(	1693	)
	Other(	4716	)
	Other(	1716	)
	Other(	1711	)
	Other(	3384	)
	Other(	3932	)
	Other(	1619	)
	Other(	2396	)
	Other(	1729	)
	Other(	4459	)
	Other(	1697	)
	Other(	1730	)
	Other(	1712	)
	Other(	1734	)
	Other(	1621	)
	Other(	1703	)
	Other(	6613	)
end

-------------双儿MM-------------
function kzd_shuangermm()

	Talk(1,"Shuang: Want to get a double exp or drop ratre <Time Sand>?")
	InitTrigger()
	TriggerAction(1,GiveSB)
	TriggerAction(1,JumpPage,2)
	Text(1,"I want to receive double experience",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerAction(1,GiveSB)
	TriggerAction(1,JumpPage,3)
	Text(1,"I want to manage my double experience",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerAction(1,GiveSB)
	TriggerAction(1,JumpPage,21)
	Text(1,"I want to purchase Time Gel",MultiTrigger, GetMultiTrigger(), 1)
	Talk(2,"Shuang: Which double effect do you want to receive")
	Text(2,"Receive double experience",JumpPage,5)
	Text(2,"Receive double drop rate",JumpPage,6)
	InitTrigger()
	TriggerAction(1,GiveSB)
	TriggerAction(1,JumpPage,9)
	Text(1,"What is <Time Sand>?",MultiTrigger, GetMultiTrigger(), 1)
	Talk(9,"Shuang: <Time Sand> will be given when you obtain the 2x effect. It record the time you have the effect, once the time is up, the item will be gone. If you destroy the item, the effect will be gone.")
	InitTrigger()
	TriggerAction(1,GiveSB)
	TriggerAction(1,ShuangBei_TimeChaxun)
	Text(1,"I want to check my double experience (Check system notice)",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1,buling )
	TriggerAction( 1, JumpPage ,25)
	TriggerFailure( 1, JumpPage, 26 )
	Text(1,"I want a replacement",MultiTrigger, GetMultiTrigger(), 1)

	Talk(5,"Shuang: How long do you want to claim for the 2x effect? Remember this effect won’t stack with the item from item mall.")
	
	InitTrigger()
	TriggerCondition( 1 , ShuangBei_Time , 1 , 1 )                ----领取1小时
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, GiveItem_SetAttr,6370,0, 1 , 1 , 0 , 1 )
	TriggerAction(1,JumpPage,17)
	TriggerFailure( 1, JumpPage, 15 )
	Text(5,"1 Hour",MultiTrigger, GetMultiTrigger(), 1)
	
	
	InitTrigger()
	TriggerCondition( 1,ShuangBei_Time , 2 , 1 )                         --领取2小时
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, GiveItem_SetAttr,6370,0,1,2,0 , 1  )
	TriggerFailure( 1, JumpPage, 15 )
	Text(5,"2 Hours",MultiTrigger, GetMultiTrigger(), 1)
	
	InitTrigger()
	TriggerCondition( 1,ShuangBei_Time,3 , 1 )                       	--领取3小时
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, GiveItem_SetAttr,6370,0,1,3,0 , 1 )
	TriggerFailure( 1, JumpPage, 15 )
	Text(5,"3 Hours",MultiTrigger, GetMultiTrigger(), 1)
	
	Talk(6,"Shuang: How long do you want to claim for the 2x drop effect? 1 hour of drop = 3 hour of exp. Remember this effect won’t stack with the item from item mall.")
	
	InitTrigger()
	TriggerCondition( 1,ShuangBei_Time,1 , 3 )                       --领取1小时  掉率
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, GiveItem_SetAttr,6370,0,3,1,0, 1  )
	TriggerFailure( 1, JumpPage, 15 )
	Text(6,"1 Hour",MultiTrigger, GetMultiTrigger(), 1)
	
	InitTrigger()
	TriggerCondition( 1,ShuangBei_Time,2 , 3 )                       --领取2小时  掉率
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, GiveItem_SetAttr,6370,0,3,2,0 , 1 )
	TriggerFailure( 1, JumpPage, 15 )
	Text(6,"2 Hours",MultiTrigger, GetMultiTrigger(), 1)
	
	InitTrigger()													--领取3小时  掉率			
	TriggerCondition( 1,ShuangBei_Time,3 , 3 )  
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )	
	TriggerAction( 1, GiveItem_SetAttr,6370,0,3,3,0 , 1 )
	TriggerFailure( 1, JumpPage, 15 )
	Text(6,"3 Hours",MultiTrigger, GetMultiTrigger(), 1)			
	
	Talk(15,"Shuang: You have no more time to claim for this week")
	
	Talk(3,"Shuang: Managing the 2x effect need relevant item, please have it on you.")
	Text(3,"Double concentration",JumpPage,7)
	Text(3,"Double Storage",JumpPage,8)
	Text(3,"What is double concentration?",JumpPage,23)
	Text(3,"What is double storage?",JumpPage,24)
	Talk(7,"Shuang: How much time of 2x exp do you want to concentrate to 1 hour of multi exp? Concentrated effect cannot be pause or stack with item from item mall.")
	Talk(23,"Shuang: You can concentrate many hour of 2x exp into 1 hour of multi exp! You will need time capsule from item mall. Concentrated effect cannot be pause or stack with item from item mall")
	Talk(24,"Shuang: If you cannot finish the allocated 2x time from this week, you can store it via the Time Saving Bottle from item mall to use it next week.")
	
	InitTrigger()															--浓缩5小时					
	TriggerCondition( 1,ShuangBei_Time,5,1)									--剩余时间判定
	TriggerCondition( 1, HasLeaveBagGrid, 1 )		
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem,6380, 1 )
	TriggerAction( 1, GiveItem_SetAttr,6371,0,1,1,0 , 4 ) 	--浓缩函数
	TriggerAction( 1, TakeItem,6380,1 )
	TriggerFailure( 1, JumpPage, 19 )
	Text(7,"5 hours",MultiTrigger, GetMultiTrigger(), 1)
	
	InitTrigger()																			--浓缩10小时
	TriggerCondition( 1,ShuangBei_Time,10,1)                       			  --剩余时间判定
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem,6380, 1 )
	TriggerAction( 1, GiveItem_SetAttr,6371,0,1,1,0 , 7 ) 	--浓缩函数
	TriggerAction( 1, TakeItem,6380,1 )
	TriggerFailure( 1, JumpPage, 19 )
	Text(7,"10 hours", MultiTrigger, GetMultiTrigger(), 1)
	
	Talk(8,"Shuang: You sure you want to save up the time for this week?")
	InitTrigger()														--时间存储
	TriggerCondition( 1,ShuangBei_Time , 1 , 1 )                         --剩余时间判定
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasItem ,6373 , 1 )
	TriggerAction( 1, TakeItem,6373,1 )
	TriggerAction( 1, ShuangBei_ChunChu )                --p5等于1
	TriggerFailure( 1, JumpPage, 18 )
	Text(8,"Hmm~ less make more",MultiTrigger, GetMultiTrigger(), 1)
	
	Text(8,"I insist to finish it",CloseTalk)
	
	Talk(17,"Shuang: Successful!")
	Talk(18,"Shuang: No time saving bottle.")
	
	Talk(19,"Shuang: No time concentrated capsule or time not enough.")
	Talk(21,"Shuang: Time Gel is very rare, I need 20,000g to make one, you sure you need it?")
	
	InitTrigger()														
	TriggerCondition( 1,NoItem, 6372 , 1 )                         
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerCondition( 1, HasMoney , 20000 )
	TriggerAction( 1, TakeMoney,20000 )
	TriggerAction( 1, GiveItem,6372,1 , 4 )
	TriggerFailure( 1, JumpPage, 22 )
	Text(21,"Confirm",MultiTrigger, GetMultiTrigger(), 1)
	Text(21,"Cancel",CloseTalk)
	Text(21,"What is Time Gel?",JumpPage,20)
	Talk(20,"Shuang: Time Gel is an item to allow the movement of time sand to stop for awhile. Use another one to recover the movement. Doesn't work on concentrated 2x effect.")
	Talk(22,"Shuang: You don’t have enough gold.")
	
	Talk(25,"Shuang: What do you want to replace")
	InitTrigger()
	TriggerCondition( 1, CanbulingSB )
	TriggerAction( 1, bulingSB )
	TriggerFailure( 1, JumpPage, 28 )
	Text(25,"I want to replace to experience increase",MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition( 1, CanbulingBL )
	TriggerAction( 1, bulingBL )
	TriggerFailure( 1, JumpPage, 27 )
	Text(25,"I want to claim drop bonus again.",MultiTrigger, GetMultiTrigger(), 1)
	Talk(26,"Shuang: You can come here to replace the experience increase.")
	Talk(28,"Shuang: If you are under the experience effect, I will not be able to give you another one. If you are not, do you want to replace?")
	Talk(27,"Shuang: If you are under the drop rate effect, I will not be able to give you another one. If you are not, do you want to replace?")

  end 

-------------------------------------
--------梦幻大陆 遗之岛　传送使·佐游
-------------------------------------
function di_talk1 ()

	Talk ( 1, "Junior You: As long you come to me, I can teleport you to anywhere in Continent of Dreams.")
	Text ( 1, "Teleport to Dream City", JumpPage, 2)
	--Text ( 1, "Teleport to Region of the Demons!", JumpPage, 3)
	Text ( 1, "Nothing, just looking around",CloseTalk )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 382,553, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 2, "Teleport to Dream City! Please pay 2000g. Thank you. Lv40 and below newbie are free!")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 153,168, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 3, "Teleport to Region of the Demons! Please pay 2000g. Thank you.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )

	Talk( 6, "Please check if you have sufficient gold!" )

end

-------------------------------------
--------梦幻大陆　吟游诗人·二浩
-------------------------------------
function di_talk2()
      
    Talk(1,"Er Hao: I love to recite poem and go on a journey")

end

-------------------------------------
--------梦幻大陆 恶魔之域　传送使·楼岚
-------------------------------------
function di_talk3 ()

	Talk ( 1, "Rolan: Hi, where do you want to go")
	Text ( 1, "Teleport to Dream City", JumpPage, 2)
	--Text ( 1, "Teleport to Forgotten Island", JumpPage, 3)
	Text ( 1, "Nothing, just looking around",CloseTalk )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 382,553, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 2, "Teleport to Dream City! Please pay 2000g. Thank you.")
	Text( 2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 567,138, "DreamIsland")
	TriggerFailure( 1, JumpPage, 6 )
	Talk( 3, "Teleport to Forgotten Island. Please pay 2000g. Thank you.")
	Text( 3, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 1 )

	Talk( 6, "You have insufficient gold for teleport" )

end

-------------------------------------
--------梦幻大陆 恶魔之域　旅行者·那嵬
-------------------------------------
function di_talk4()

    	Talk(1,"Nawei: For safety purpose, always keep medicine with you!")
	--Text( 1, "Trade", BuyPage )
	--Text( 1, "Nothing, just looking around",CloseTalk )

	-- InitTrade()
	-- Other(	6203	)
	-- Other(	6204	)
	-- Other(	1847	)
	-- Other(	1848	)
	-- Other(	1849	)
	
end  

function KZ_xyq()

	Talk(1,"Don't look down on me judging from my size! I'm way stronger than you think…")
	
	Text(1,"Exchange for Apparel",JumpPage, 27)
	--Text(1,"兑换废弃图纸C",JumpPage, 11)
	--Text(1,"兑换废弃图纸D",JumpPage, 12)
	Text(1,"Exchange for Constellation Medal",JumpPage, 13)

	Talk(27,"Please select apparel choice")	

	Text(27,"Leo Apparel",JumpPage, 2)
	Text(27,"Virgo Apparel",JumpPage, 3)
	Text(27,"Libra Apparel",JumpPage, 4)
	Text(27,"Scorpio Apparel",JumpPage, 5)
	Text(27,"Sagittarius Apparel",JumpPage, 6)
	Text(27,"Capricorn Apparel",JumpPage, 7)
	Text(27,"Aquarius Apparel",JumpPage, 8)
	Text(27,"Pisces Apparel",JumpPage, 9)

	Talk(2,"Leo Essence 1,Leo Energy 1,Leo Chest 1,Leo Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8714, 1 )	
	TriggerCondition( 1, HasItem, 8715, 1 )	
	TriggerCondition( 1, HasItem, 8716, 1 )	
	TriggerCondition( 1, HasItem, 8445, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8714, 1 )	
   	TriggerAction( 1, TakeItem, 8715, 1 )
    	TriggerAction( 1, TakeItem, 8716, 1 )	
   	TriggerAction( 1, TakeItem, 8445, 1 )	
	TriggerAction( 1, GiveItem,8648, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(2,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(3,"Virgo Essence 1,Virgo Energy 1,Virgo Chest 1,Virgo Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8446, 1 )	
	TriggerCondition( 1, HasItem, 8447, 1 )	
	TriggerCondition( 1, HasItem, 8448, 1 )	
	TriggerCondition( 1, HasItem, 8449, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8446, 1 )	
   	TriggerAction( 1, TakeItem, 8447, 1 )
    	TriggerAction( 1, TakeItem, 8448, 1 )	
   	TriggerAction( 1, TakeItem, 8449, 1 )	
	TriggerAction( 1, GiveItem,8722, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(3,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(4,"Libra Essence 1,Libra Energy 1,Libra Chest 1,Libra Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8450, 1 )	
	TriggerCondition( 1, HasItem, 8451, 1 )	
	TriggerCondition( 1, HasItem, 8452, 1 )	
	TriggerCondition( 1, HasItem, 8453, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8450, 1 )	
   	TriggerAction( 1, TakeItem, 8451, 1 )
    	TriggerAction( 1, TakeItem, 8452, 1 )	
   	TriggerAction( 1, TakeItem, 8453, 1 )	
	TriggerAction( 1, GiveItem,8723, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(4,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(5,"Scorpio Essence 1,Scorpio Energy 1,Scorpio Chest 1,Scorpio Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8454, 1 )	
	TriggerCondition( 1, HasItem, 8455, 1 )	
	TriggerCondition( 1, HasItem, 8456, 1 )	
	TriggerCondition( 1, HasItem, 8457, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8454, 1 )	
   	TriggerAction( 1, TakeItem, 8455, 1 )
    	TriggerAction( 1, TakeItem, 8456, 1 )	
   	TriggerAction( 1, TakeItem, 8457, 1 )	
	TriggerAction( 1, GiveItem,8724, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(5,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(6,"Sagittarius Essence 1,Sagittarius Energy 1,Sagittarius Chest 1,Sagittarius Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8458, 1 )	
	TriggerCondition( 1, HasItem, 8459, 1 )	
	TriggerCondition( 1, HasItem, 8460, 1 )	
	TriggerCondition( 1, HasItem, 8461, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8458, 1 )	
   	TriggerAction( 1, TakeItem, 8459, 1 )
    	TriggerAction( 1, TakeItem, 8460, 1 )	
   	TriggerAction( 1, TakeItem, 8461, 1 )	
	TriggerAction( 1, GiveItem,8725, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(6,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(7,"Capricorn Essence 1,Capricorn Energy 1,Capricorn Chest 1,Capricorn Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8462, 1 )	
	TriggerCondition( 1, HasItem, 8463, 1 )	
	TriggerCondition( 1, HasItem, 8464, 1 )	
	TriggerCondition( 1, HasItem, 8465, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8462, 1 )	
   	TriggerAction( 1, TakeItem, 8463, 1 )
    	TriggerAction( 1, TakeItem, 8464, 1 )	
   	TriggerAction( 1, TakeItem, 8465, 1 )	
	TriggerAction( 1, GiveItem,8649, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(7,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(8,"Aquarius Essence 1,Aquarius Energy 1,Aquarius Chest 1,Aquarius Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8466, 1 )	
	TriggerCondition( 1, HasItem, 8467, 1 )	
	TriggerCondition( 1, HasItem, 8468, 1 )	
	TriggerCondition( 1, HasItem, 8469, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8466, 1 )	
   	TriggerAction( 1, TakeItem, 8467, 1 )
    	TriggerAction( 1, TakeItem, 8468, 1 )	
   	TriggerAction( 1, TakeItem, 8469, 1 )	
	TriggerAction( 1, GiveItem,8650, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(8,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(9,"Pisces Essence 1,Pisces Energy 1,Pisces Chest 1,Pisces Key 1")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8470, 1 )	
	TriggerCondition( 1, HasItem, 8471, 1 )	
	TriggerCondition( 1, HasItem, 8472, 1 )	
	TriggerCondition( 1, HasItem, 8473, 1 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8470, 1 )	
   	TriggerAction( 1, TakeItem, 8471, 1 )
    	TriggerAction( 1, TakeItem, 8472, 1 )	
   	TriggerAction( 1, TakeItem, 8473, 1 )	
	TriggerAction( 1, GiveItem,8651, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text(9,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 10, "Exchange requirement insufficient otherwise your inventory is locked. Please ensure you have at least 1 empty slot.")
	
	Talk( 11, "Redeem Abandon Print C requires 50 Abandon Print A or 40 Abandon Print B, inclusive of a couple of Commerce Permit")
	
	Text( 11,"Exchange using 50 Abandon Print A with a couple of Commerce Permit",JumpPage, 14)
	Text( 11,"Exchange using 40 Abandon Print B with a couple of Commerce Permit",JumpPage, 15)

	Talk( 14, "Select what Permit for exchange.")

	Text( 14,"Exchange using 50 Abandon Print A with 20 Junior Commerce Permit",JumpPage, 16)
	Text( 14,"Exchange using 50 Abandon Print A with 15 Intermediate Commerce Permit for Abandon Print C. Confirm?",JumpPage, 17)
	Text( 14,"Exchange using 50 Abandon Print A with 10 Advance Commerce Permit for Abandon Print C. Confirm?",JumpPage, 18)

	Talk( 16, "Exchange using 50 Abandon Print A with 20 Junior Commerce Permit for Abandon Print C. Confirm？")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1000, 50 )	
	TriggerCondition( 1, HasItem, 8318, 20 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1000, 50 )	
   	TriggerAction( 1, TakeItem, 8318, 20 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 16,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 17, "Exchange using 50 Abandon Print A with 15 Intermediate Commerce Permit for Abandon Print C. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1000, 50 )	
	TriggerCondition( 1, HasItem, 8319, 15 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1000, 50 )	
   	TriggerAction( 1, TakeItem, 8319, 15 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 17,"Exchange",MultiTrigger, GetMultiTrigger(), 1)
	
	
	Talk( 18, "Exchange using 50 Abandon Print A with 10 Advance Commerce Permit for Abandon Print C. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1000, 50 )	
	TriggerCondition( 1, HasItem, 8320, 10 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1000, 50 )	
   	TriggerAction( 1, TakeItem, 8320, 10 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 18,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 15, "Select what Permit for exchange.")

	Text( 15,"Exchange using 40 Abandon Print B with 20 Junior Commerce Permit",JumpPage, 19)
	Text( 15,"Exchange using 40 Abandon Print B with 15 Intermediate Commerce Permit",JumpPage, 20)
	Text( 15,"Exchange using 40 Abandon Print B with 10 Advance Commerce Permit",JumpPage, 21)

	Talk( 19, "Exchange using 50 Abandon Print A with 20 Junior Commerce Permit for Abandon Print C. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1001, 40 )	
	TriggerCondition( 1, HasItem, 8318, 20 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1001, 40 )	
   	TriggerAction( 1, TakeItem, 8318, 20 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 19,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 20, "Exchange using 50 Abandon Print A with 15 Intermediate Commerce Permit for Abandon Print C. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1001, 40 )	
	TriggerCondition( 1, HasItem, 8319, 15 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1001, 40 )	
   	TriggerAction( 1, TakeItem, 8319, 15 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 20,"Exchange",MultiTrigger, GetMultiTrigger(), 1)
	
	
	Talk( 21, "Exchange using 50 Abandon Print A with 10 Advance Commerce Permit for Abandon Print C. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1001, 40 )	
	TriggerCondition( 1, HasItem, 8320, 10 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1001, 40 )	
   	TriggerAction( 1, TakeItem, 8320, 10 )	
	TriggerAction( 1, GiveItem,1002, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 21,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 12, "Redeem Abandon Print D requires 15 Abandon Print C , inclusive of a couple of Commerce Permit")

	Text( 12,"Exchange using 15 Abandon Print C with 100 Intermediate Commerce Permit",JumpPage, 22)
	Text( 12,"Exchange using 15 Abandon Print C with 50 Advance Commerce Permit",JumpPage, 23)

	
	Talk( 22, "Exchange using 15 Abandon Print C with 100 Intermediate Commerce Permit for Abandon Print D. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1002, 15 )	
	TriggerCondition( 1, HasItem, 8319, 100 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1002, 15 )	
   	TriggerAction( 1, TakeItem, 8319, 100 )	
	TriggerAction( 1, GiveItem,1003, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 22,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk( 23, "Exchange using 15 Abandon Print C with 50 Advance Commerce Permit for Abandon Print D. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1002, 15 )	
	TriggerCondition( 1, HasItem, 8320, 50 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 1002, 15 )	
   	TriggerAction( 1, TakeItem, 8320, 50 )	
	TriggerAction( 1, GiveItem,1003, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 23,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	Talk(13,"Exchange for Constellation Medal requires a couple of Commerce Permit~")
	
	Text( 13,"Exchange using 40 Junior Commerce Permit",JumpPage, 24)
	Text( 13,"Exchange using 20 Intermediate Commerce Permit",JumpPage, 25)
	Text( 13,"Exchange using 5 Advance Commerce Permit",JumpPage, 26)

	Talk( 24, "Exchange using 40 Junior Commerce Permit for Constellation Medal. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8318, 40 )
	TriggerCondition( 1, HasMoney, 100000 )	
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8318, 40 )
	TriggerAction( 1, TakeMoney, 100000 )	
	TriggerAction( 1, GiveItem,8713, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 24,"Exchange",MultiTrigger, GetMultiTrigger(), 1)


	Talk( 25, "Exchange using 20 Intermediate Commerce Permit for Constellation Medal. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8319, 20 )	
	TriggerCondition( 1, HasMoney, 100000 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8319, 20 )	
	TriggerAction( 1, TakeMoney, 100000 )
	TriggerAction( 1, GiveItem,8713, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 25,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

	
	Talk( 26, "Exchange using 5 Advance Commerce Permit for Constellation Medal. Confirm?")
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 8320, 5 )
	TriggerCondition( 1, HasMoney, 100000 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    	TriggerAction( 1, TakeItem, 8320, 5 )
	TriggerAction( 1, TakeMoney, 100000 )			
	TriggerAction( 1, GiveItem,8713, 1,4 )	
	TriggerFailure( 1, JumpPage, 10 ) 					
	Text( 26,"Exchange",MultiTrigger, GetMultiTrigger(), 1)

end