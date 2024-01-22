--------------------------------------------------------------------------
--									--
--									--
--				NPCScript07.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript07.lua" )


function cherry_mall ()
	
	Talk( 1, "Jack: Hello, I am Jack. I will sell you all the items that are unavalaible In-Game." )
	Text( 1, "Trade", BuyPage )
	Text( 1, "Nothing...",  CloseTalk)	

	InitTrade()
	--Weapon(	938	)--Goddess's Favor
	--Weapon(	1780	)--Stone of Oath
	--Weapon(	2235	)--Rebirth Stone
	--Weapon(	5765	)--Revive Stone
	
	
	Defence(	3109	)--Vial of Strength Reset
	Defence(	3110	)--Vial of Consitution Reset
	Defence(	3111	)--Vial of Agility Reset
	Defence(	3112	)--Vial of Accuracy Reset
	Defence(	3113	)--Vial of spriti Reset
	Defence(	3844	)--Heaven's Berry
	Defence(	3845	)--Charmed Berry
	Defence(	849	)--Party EXP Fruit (Nana)
	Defence(	3094	)--Aplifier of Strive
	Defence(	3096	)--Aplifier of Luck
	Defence(	3095	)--Hi-Aplifier of Strive
	Defence(	3097	)--Hi-Aplifier of Luck

	Other(	3088	)--28 Slot Inventory
	Other(	3089	)--32 Slot Inventory
	Other(	3090	)--36 Slot Inventory
	Other(	3091	)--40 Slot Inventory
	Other(	3092	)--44 Slot Inventory
	Other(	3093	)--48 Slot Inventory
	Other(	207	)--Gold Axe
	Other(	208	)--Gold Pickaxe
	Other(	3462	)--Magical Clover
	Other(	3463	)--Icy Crystal
	Other(	1022	)--Rechargiable Battery
	Other(	1024	)--Super Rechargiable Battery
	Other(	3300	)--Intense Magic (Book)
	Other(	3301	)--Crystalline Blessing (Book)
	Other(	1037	)--Skill - Deficate
	Other(	1038	)--Skill - Undergarment
	Other(	1039	)--Skill - Garment
	Other(	1129	)--Skill - Coin Shower
	Other(	1130	)--Skill - Fool
	Other(	1131	)--Skill - Snooty
	Other(	1132	)--Skill - Trickster
	Other(	1133	)--Skill - Dumb
	Other(	2625	)--Stone Catalyst
	Other(	2630	)--Food Catalyst
	Other(	2634	)--Special Catalyst
	Other(	2635	)--Bone Catalyst
	Other(	2636	)--Plant Catalyst
	Other(	2637	)--Fur Catalyst
	Other(	2638	)--Liquid Catalyst

end

function cherry_pot ()

	Talk( 1, "Hermione: Hi! I am Hermione , I love to make Potions!! and everything about it!, take a look at my collection." )
	Text( 1, "Trade", BuyPage)
	Text( 1, "Nothing...",  CloseTalk)

	InitTrade()
	--Defence(	1860	)--Blessed Potion
	Defence(	3342	)--Lantren
	Defence(	3047	)--Voodoo Puppet
	Defence(	3105	)--Skating potion
	Defence(	893	)--Potion of Monkey
	Defence(	894	)--Potion of Eagle
	Defence(	895	)--Potion of Bull
	Defence(	896	)--Potion of Soul
	Defence(	897	)--Potion of Lion
	Defence(	851	)--Battle Array
	Defence(	850	)--Weigthless Potion
	Defence(	852	)--Full Body Armor
	Defence(	1138 	)--Soul Detector Lv1
	--Defence(	1139	)--Ship Accelerator Lv1
	--Defence(	1140	)--Ship Atomizer Lv1
	--Defence(	1141	)--Ship Penetrator Lv1
	--Defence(	1142	)--Ship Impaler Lv1
	--Defence(	1143	)--Ship Flamer Lv1
	--Defence(	1146	)--Carrion Ball Lv1
	--Defence(	1147	)--Noise Polluter Lv1
	Defence(	1136	)--Flash Bomb Lv1
	Defence(	1137	)--Radiation Lv1
	--Defence(	1148	)--Earthquake Generator Lv1
	--Defence(	1149	)--Time Bomb Lv1
	--Defence(	1150	)--Hull Repair Lv1
	--Defence(	1151	)--Food Generator Lv1
	--Defence(	1152	)--carrion Bullet Lv1
	--Defence(	2673	)--Mirage Generator Lv1
	--Defence(	2674	)--Illusion Generator Lv1
	--Defence(	2675	)--Stealth Lv1
	--Defence(	2676	)--Radar Lv1
	--Defence(	2677	)--Chain Bullet Lv1
	--Defence(	2678	)--Water Mine Lv1
	--Defence(	3343	)--Rose
	--Defence(	3344	)--Lovers Choccolate

end

function cherry_ticket ()
	
	Talk( 1, "Adriana: Hello, i sell all type of Tickets..!" )
	Text( 1, "Trade", BuyPage )
	Text( 1, "Nothing...",  CloseTalk)	

	InitTrade()
	Other(	4602	)--Ticket to Argent
	Other(	4603	)--Ticket to Shaitan
	Other(	4604	)--Ticket to Icicle
	Other(	3141	)--Old Ticket
	Other(	3073	)--Pass to Abandon Mine 1
	Other(	3056	)--Pass to Abandoned Mine 2
	Other(	3057	)--Pass to Silver Mine 2
	Other(	3058	)--Pass to Silver Mine 3
	Other(	3054	)--Pass to Lone Tower
	Other(	3059	)--Ticket to Lone Tower 2
	Other(	3060	)--Pass to Lone Tower 3
	Other(	3070	)--Pass to Lone Tower 4
	Other(	3071	)--Pass to Lone Tower 5
	Other(	3072	)--Pass to Lone Tower 6
	Other(	3048	)--Pass to Thundoria Castle
	Other(	3049	)--Pass to Thundoria Harbor
	Other(	3076	)--Pass to Spring Town
	Other(	563	)--Pass to Summer
	Other(	583	)--Pass to Autumn
	Other(	3050	)--Pass to Sacred Snow Mountain
	Other(	3051	)--Pass to Andes Forest Haven
	Other(	3052	)--Pass to Oasis Haven
	Other(	3053	)--Pass to Icespire Haven
	Other(	2844	)--Pass to Abandon 4
	Other(	2491	)--Pass to Naval Base
	Other(	2447	)--Pass to Skeletar Isle?
	Other(	6205	)--Ticket to Winter Island
	Other(	2445	)--Caribbean Tour Ticket

end

function cherry_pet ()

	Talk( 1, "Marriam: Hi! I am Marriam. I love pets and everything about them, take a look at my collection." )
	Text( 1, "Trade", BuyPage)
	Text( 1, "Nothing...",  CloseTalk)

	InitTrade()
	Defence(	0227	)--Fairy Ration
	Defence(	2312	)--Auto Ration
	Defence(	0578	)--Fruit of Growth
	Defence(	0262	)--Fairy Box
	Defence(	0680	)--Green Mordo
	--Defence(	0231	)--Fairy of Luck
	--Defence(	0232	)--Fairy of Strength
	--Defence(	0233	)--Fairy of Constitution
	--Defence(	0234	)--Fairy of Spirit
	--Defence(	0235	)--Fairy of Accuracy
	--Defence(	0236	)--Fairy of Agility
	--Defence(	0237	)--Fairy of Evil
	--Defence(	0681	)--Mordo Junior
	Defence(	0222	)--Snow Dragon Fruit
	Defence(	0276	)--Great Snow Dragon Fruit
	Defence(	0223	)--Icepire Plum
	Defence(	0277	)--Great Icepire Plum
	Defence(	0224	)--Zephyr Fish Floss
	Defence(	0278	)--Great Zephyr Fish Floss
	Defence(	0225	)--Argent Mango
	Defence(	0279	)--Great Argent Mango
	Defence(	0226	)--Shaitan Biscuit
	Defence(	0280	)--Great Shaitan Biscuit
	Defence(	0244	)--Standard Protection
	Defence(	0247	)--Standard Berserk
	Defence(	0250	)--Standard Magic
	Defence(	0253	)--Standard Recover
	Defence(	0260	)--Standard Meditation
	--Defence(	0239	)--Novice Fairy Possession
	--Defence(	0608	)--Standard Fairy Possession
	--Defence(	0609	)--Expert Fairy Possession
	Defence(	3918	)--Demonic Fruit of Acidity
	Defence(	3919	)--Demonic Fruit of Courage
	Defence(	3920	)--Demonic Fruit of Strength
	Defence(	3921	)--Demonic Fruit of Intellect
	Defence(	3922	)--Demonic Fruit of Energy
	Defence(	3924	)--Demonic Fruit of Aberrant
	--Defence(	4533	)--Polliwog Tail
	--Defence(	3437	)--Wailing Archer Carcass
	--Defence(	4531	)--Cracked Arabic Pearl 
	--Defence(	3435	)--Sorrow Archer Carcass
	--Defence(	4540	)--Shark Fin
	--Defence(	3443	)--Swamp Wood 
	--Defence(	1196	)--Arabic Pearl Fragment 
	--Defence(	3436	)--Wailing Warrior Carcass
	--Defence(	4537	)--Fish Spike
	--Defence(	3444	)--Mud Chunk 
	--Defence(	4530	)--Tasty Squid Meat 
	--Defence(	3434	)--Skeleton of Sorrow Warrior
end

function unseal_seller ()
	
	Talk( 1, "Hime: Welcome to the Unseal Shop of Argent City." )
	Text( 1, "Buy Unseal", BuyPage )

	InitTrade()
	Weapon(	770	)
	Weapon(	771	)
	Weapon(	772	)
	Weapon(	773	)
	Weapon(	774	)
	Weapon(	775	) 
	Weapon(	776	)
	Weapon(	781	) 
	Weapon(	782	)
	Weapon(	783	)
	Weapon(	784	)
	Weapon(	785	)
	Weapon(	786	)
	Weapon(	787	)
	Weapon(	788	) 
	Weapon(	793	)
	Weapon(	794	)
	Weapon(	795	) 
	Weapon(	799	)
	Weapon(	800	)
	Weapon(	801	)
	Weapon(	802	)
	Weapon(	2331	)
	Weapon(	2332	)
	Weapon(	2333	)
	Weapon(	2334	)
	Weapon(	2335	)
	Weapon(	2336	)
	Weapon(	2337	)
	Weapon(	2338	)
	Weapon(	2339	)
	Weapon(	2340	)
	Weapon(	2341	)
	Weapon(	2342	)
	Weapon(	2343	)
	Weapon(	2344	)
	
	Defence(	763	) 
	Defence(	764	)
	Defence(	765	)
	Defence(	766	)
	Defence(	767	)
	Defence(	768	)
	Defence(	769	) 
	Defence(	777	)
	Defence(	778	)
	Defence(	779	)
	Defence(	780	)
	Defence(	789	)
	Defence(	790	)
	Defence(	791	)
	Defence(	792	)
	Defence(	796	)
	Defence(	797	)
	Defence(	798	)
	Defence(	803	) 
	Defence(	804	)
	Defence(	805	)
	Defence(	806	)
	Defence(	807	)
	Defence(	808	)
	Defence(	809	)
	Defence(	810	) 
	Defence(	811	)
	Defence(	812	)
	Defence(	813	)
	Defence(	814	)
	Defence(	815	)
	Defence(	877	)
	Defence(	2835	)
	Defence(	2836	)
	Defence(	2837	)
	Defence(	2838	)
	Defence(	2839	)
	Defence(	2840	)
	Defence(	2841	)

	Other(	419	) 
	Other(	421	)
	Other(	461	)
	Other(	463	)
	Other(	497	)
	Other(	418	) 
	Other(	420	)
	Other(	739	)
	Other(	462	)
	Other(	495	)

	Other(	281	) 
	Other(	286	)
	Other(	324	)
	Other(	334	)
	Other(	387	)

	Other(	285	) 
	Other(	321	)
	Other(	330	)
	Other(	349	)
	Other(	417	)

	Other(	282	) 
	Other(	287	)
	Other(	327	)
	Other(	346	)
	Other(	414	)

	Other(	284	) 
	Other(	524	)
	Other(	329	)
	Other(	348	)
	Other(	416	)

	Other(	283	) 
	Other(	288	)
	Other(	328	)
	Other(	347	)
	Other(	415	)

end