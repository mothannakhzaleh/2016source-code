--------------------------------------------------------------------------
--									--
--									--
--				AttrCalculate.lua			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading AttrCalculate.lua" )


attr = {}
attr[1] = {0,0}
attr[2] ={0,0}
attr[3] ={0,0}
attr[4] ={0,0}
attr[5] ={0,0}
attr[6] ={0,0}
attr[7] ={0,0}
attr[8] ={0,0}
attr[9] ={0,0}
attr[10]={0,0}

item_add = 
{
  cnt = 0, 
  attr = attr
}

PlayerCredit = {}
PlayerCredit[	2	]=	1
PlayerCredit[	3	]=	2
PlayerCredit[	4	]=	3
PlayerCredit[	5	]=	4
PlayerCredit[	6	]=	5
PlayerCredit[	7	]=	6
PlayerCredit[	8	]=	7
PlayerCredit[	9	]=	8
PlayerCredit[	10	]=	9
PlayerCredit[	11	]=	10
PlayerCredit[	12	]=	11
PlayerCredit[	13	]=	12
PlayerCredit[	14	]=	13
PlayerCredit[	15	]=	14
PlayerCredit[	16	]=	15
PlayerCredit[	17	]=	16
PlayerCredit[	18	]=	17
PlayerCredit[	19	]=	18
PlayerCredit[	20	]=	19
PlayerCredit[	21	]=	20
PlayerCredit[	22	]=	21
PlayerCredit[	23	]=	22
PlayerCredit[	24	]=	23
PlayerCredit[	25	]=	24
PlayerCredit[	26	]=	25
PlayerCredit[	27	]=	26
PlayerCredit[	28	]=	27
PlayerCredit[	29	]=	28
PlayerCredit[	30	]=	29
PlayerCredit[	31	]=	30
PlayerCredit[	32	]=	31
PlayerCredit[	33	]=	32
PlayerCredit[	34	]=	33
PlayerCredit[	35	]=	34
PlayerCredit[	36	]=	35
PlayerCredit[	37	]=	36
PlayerCredit[	38	]=	37
PlayerCredit[	39	]=	38
PlayerCredit[	40	]=	39
PlayerCredit[	41	]=	40
PlayerCredit[	42	]=	41
PlayerCredit[	43	]=	42
PlayerCredit[	44	]=	43
PlayerCredit[	45	]=	47
PlayerCredit[	46	]=	51
PlayerCredit[	47	]=	55
PlayerCredit[	48	]=	60
PlayerCredit[	49	]=	66
PlayerCredit[	50	]=	72
PlayerCredit[	51	]=	78
PlayerCredit[	52	]=	85
PlayerCredit[	53	]=	93
PlayerCredit[	54	]=	101
PlayerCredit[	55	]=	109
PlayerCredit[	56	]=	118
PlayerCredit[	57	]=	128
PlayerCredit[	58	]=	138
PlayerCredit[	59	]=	148
PlayerCredit[	60	]=	159
PlayerCredit[	61	]=	171
PlayerCredit[	62	]=	183
PlayerCredit[	63	]=	195
PlayerCredit[	64	]=	208
PlayerCredit[	65	]=	222
PlayerCredit[	66	]=	236
PlayerCredit[	67	]=	250
PlayerCredit[	68	]=	265
PlayerCredit[	69	]=	281
PlayerCredit[	70	]=	297
PlayerCredit[	71	]=	313
PlayerCredit[	72	]=	330
PlayerCredit[	73	]=	348
PlayerCredit[	74	]=	366
PlayerCredit[	75	]=	384
PlayerCredit[	76	]=	403
PlayerCredit[	77	]=	423
PlayerCredit[	78	]=	443
PlayerCredit[	79	]=	463
PlayerCredit[	80	]=	484
PlayerCredit[	81	]=	506
PlayerCredit[	82	]=	528
PlayerCredit[	83	]=	550
PlayerCredit[	84	]=	573
PlayerCredit[	85	]=	597
PlayerCredit[	86	]=	621
PlayerCredit[	87	]=	645
PlayerCredit[	88	]=	670
PlayerCredit[	89	]=	696
PlayerCredit[	90	]=	722
PlayerCredit[	91	]=	748
PlayerCredit[	92	]=	775
PlayerCredit[	93	]=	803
PlayerCredit[	94	]=	831
PlayerCredit[	95	]=	859
PlayerCredit[	96	]=	888
PlayerCredit[	97	]=	918
PlayerCredit[	98	]=	948
PlayerCredit[	99	]=	978
PlayerCredit[	100	]=	1087

function Reset_item_add()
  item_add.cnt = 0
  item_add.attr[1] ={0,0}
  item_add.attr[2] ={0,0} 
  item_add.attr[3] ={0,0} 
  item_add.attr[4] ={0,0} 
  item_add.attr[5] ={0,0}  
  item_add.attr[6] ={0,0} 
  item_add.attr[7] ={0,0} 
  item_add.attr[8] ={0,0} 
  item_add.attr[9] ={0,0} 
  item_add.attr[10]={0,0} 
end

function Add_Item_Attr(attr_idx, radio)
   item_add.cnt = item_add.cnt + 1
   item_add.attr[item_add.cnt] = { attr_idx, radio }
end

	Mxhp_con_rad1 = {}  
	Mxhp_con_rad2 = {} 
	Mxhp_lv_rad = {}  
	Mxhp_bs = {}   		
	Mxsp_sta_rad1 = {}  
	Mxsp_sta_rad2 = {} 
	Mxsp_lv_rad = {}   		
	Mnatk_str_rad1 = {} 
	Mnatk_str_rad2 = {} 
	Mnatk_dex_rad1 = {}   
	Mnatk_dex_rad2 = {}	
	Mxatk_str_rad1 = {} 
	Mxatk_str_rad2 = {} 
	Mxatk_dex_rad1 = {}   
	Mxatk_dex_rad2 = {}	  
	Def_con_rad1 = {}   	
	Def_con_rad2 = {}	
	Hit_dex_rad1 = {}  
	Hit_dex_rad2 = {} 
	Hit_lv_rad = {}  
	Hit_min = {}   		
	Flee_agi_rad1 = {} 
	Flee_agi_rad2 = {} 
	Flee_lv_rad = {}  
	Flee_min = {}   		
	Mf_luk_rad = {}   	
	Crt_luk_rad = {}  
	Crt_min = {}  
	Crt_max = {}   		
	Hrec_bsmxhp_rad = {}  
	Hrec_con_rad = {}  
	Hrec_min = {}   		
	Srec_bsmxsp_rad = {}  
	Srec_sta_rad = {}  
	Srec_min = {}   	
	Aspd_bsrad = {}  
	Aspd_agi_rad = {}  
	Aspd_min = {}    				

--Attributes Growth Rate of Newbie Class 
-- Max HP
		Mxhp_con_rad1[JOB_TYPE_NEWBIE] = 3  -- Constitution coefficient
		Mxhp_con_rad2[JOB_TYPE_NEWBIE] = 2  -- Level coefficient
		Mxhp_lv_rad[JOB_TYPE_NEWBIE] = 15	-- Basic number	
-- Max SP					
		Mxsp_sta_rad1[JOB_TYPE_NEWBIE] = 1  -- Constitution coefficient
		Mxsp_sta_rad2[JOB_TYPE_NEWBIE]= 0  -- Level coefficient
		Mxsp_lv_rad[JOB_TYPE_NEWBIE] = 3   -- Basic number		
-- Min Atk Power
		Mnatk_str_rad1[JOB_TYPE_NEWBIE] = 1.5   -- Strength coefficient for minimum attack power
		Mnatk_str_rad2[JOB_TYPE_NEWBIE] = 0.4   -- Strength coefficient 2 for minimum attack power
		Mnatk_dex_rad1[JOB_TYPE_NEWBIE] = 0     -- Dexterity coefficient for minimum attack power
		Mnatk_dex_rad2[JOB_TYPE_NEWBIE] = 0     -- Dexterity coefficient 2 for minimum attack power
		Mxatk_str_rad1[JOB_TYPE_NEWBIE] = 1.5     -- Strength coefficient for maximum attack power
		Mxatk_str_rad2[JOB_TYPE_NEWBIE] = 0.4     -- Strength coefficient 2 for maximum attack power
		Mxatk_dex_rad1[JOB_TYPE_NEWBIE] = 0       -- Dexterity coefficient for maximum attack power
		Mxatk_dex_rad2[JOB_TYPE_NEWBIE] = 0       -- Dexterity coefficient 2 for maximum attack power
-- Defense Power
		Def_con_rad1[JOB_TYPE_NEWBIE] = 0.1       -- Defense coefficient 1 for defense
		Def_con_rad2[JOB_TYPE_NEWBIE] = 0.1       -- Defense coefficient 2 for defense: concentration coefficient
-- Hit Rate
		Hit_dex_rad1[JOB_TYPE_NEWBIE] = 0.6       -- Hit coefficient 1: concentration coefficient, level coefficient, minimum hit rate
		Hit_dex_rad2[JOB_TYPE_NEWBIE] = 0         -- Hit coefficient 2: concentration coefficient, level coefficient, minimum hit rate
-- Flee rate
		Flee_agi_rad1[JOB_TYPE_NEWBIE] = 0.6      -- Flee coefficient 1: agility coefficient, level coefficient, minimum flee rate
		Flee_agi_rad2[JOB_TYPE_NEWBIE] = 0        -- Flee coefficient 2: agility coefficient, level coefficient, minimum flee rate
-- Critical rate	
		Mf_luk_rad[JOB_TYPE_NEWBIE] = 0.39        -- Critical rate coefficient: luck coefficient
		Crt_luk_rad[JOB_TYPE_NEWBIE] = 0.31       -- Critical coefficient: luck coefficient, minimum critical rate, maximum critical rate
		Hrec_bsmxhp_rad[JOB_TYPE_NEWBIE] = 1/200  -- HP recovery coefficient: maximum HP coefficient, level coefficient, minimum HP recovery speed
		Hrec_con_rad[JOB_TYPE_NEWBIE] = 1/8       -- HP recovery coefficient: maximum HP coefficient, level coefficient, minimum HP recovery speed
		Srec_bsmxsp_rad[JOB_TYPE_NEWBIE] = 1/100  -- SP recovery coefficient: maximum SP coefficient, level coefficient, minimum SP recovery speed
		Srec_sta_rad[JOB_TYPE_NEWBIE] = 1/12      -- SP recovery coefficient: maximum SP coefficient, level coefficient, minimum SP recovery speed
		Aspd_agi_rad[JOB_TYPE_NEWBIE] = 1.1       -- Attack speed coefficient: base attack, agility coefficient, minimum attack speed

--Attributes Growth Rate of Swordsman Class 
		Mxhp_con_rad1[JOB_TYPE_SWORDSMAN] = 5     -- Maximum HP attribute influence coefficients: Constitution coefficient
		Mxhp_con_rad2[JOB_TYPE_SWORDSMAN] = 7     -- Maximum HP attribute influence coefficients: Level coefficient
		Mxhp_lv_rad[JOB_TYPE_SWORDSMAN] = 25      -- Maximum HP attribute influence coefficients: Base number

		Mxsp_sta_rad1[JOB_TYPE_SWORDSMAN] = 1     -- Maximum SP attribute influence coefficients: Stamina coefficient
		Mxsp_sta_rad2[JOB_TYPE_SWORDSMAN] = 0     -- Maximum SP attribute influence coefficients: Constitution coefficient
		Mxsp_lv_rad[JOB_TYPE_SWORDSMAN] = 3       -- Maximum SP attribute influence coefficients: Level coefficient

		Mnatk_str_rad1[JOB_TYPE_SWORDSMAN] = 1.5     -- Minimum attack power attribute influence coefficients: Strength coefficient
		Mnatk_str_rad2[JOB_TYPE_SWORDSMAN] = 0.4     -- Minimum attack power attribute influence coefficients: Strength coefficient 2
		Mnatk_dex_rad1[JOB_TYPE_SWORDSMAN] = 0       -- Minimum attack power attribute influence coefficients: Dexterity coefficient
		Mnatk_dex_rad2[JOB_TYPE_SWORDSMAN] = 0       -- Minimum attack power attribute influence coefficients: Dexterity coefficient 2

		Mxatk_str_rad1[JOB_TYPE_SWORDSMAN] = 1.5     -- Maximum attack attribute influence coefficients: Strength coefficient
		Mxatk_str_rad2[JOB_TYPE_SWORDSMAN] = 0.4     -- Maximum attack attribute influence coefficients: Strength coefficient 2
		Mxatk_dex_rad1[JOB_TYPE_SWORDSMAN] = 0       -- Maximum attack attribute influence coefficients: Dexterity coefficient
		Mxatk_dex_rad2[JOB_TYPE_SWORDSMAN] = 0       -- Maximum attack attribute influence coefficients: Dexterity coefficient 2

		Def_con_rad1[JOB_TYPE_SWORDSMAN] = 0.2     -- Defense attribute influence coefficients: Concentration coefficient 1
		Def_con_rad2[JOB_TYPE_SWORDSMAN] = 0.2     -- Defense attribute influence coefficients: Concentration coefficient 2

		Hit_dex_rad1[JOB_TYPE_SWORDSMAN] = 0.6    -- Hit attribute influence coefficients: Concentration coefficient
		Hit_dex_rad2[JOB_TYPE_SWORDSMAN] = 0      -- Hit attribute influence coefficients: Level coefficient, minimum hit rate

		Flee_agi_rad1[JOB_TYPE_SWORDSMAN] = 0.6   -- Flee attribute influence coefficients: Agility coefficient
		Flee_agi_rad2[JOB_TYPE_SWORDSMAN] = 0     -- Flee attribute influence coefficients: Level coefficient, minimum flee rate

		Mf_luk_rad[JOB_TYPE_SWORDSMAN] = 0.39     -- Critical rate attribute influence coefficients: Luck coefficient

		Crt_luk_rad[JOB_TYPE_SWORDSMAN] = 0.31    -- Critical attribute influence coefficients: Luck coefficient, minimum and maximum critical rates

		Hrec_bsmxhp_rad[JOB_TYPE_SWORDSMAN] = 1/180  -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed
		Hrec_con_rad[JOB_TYPE_SWORDSMAN] = 1/8       -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed

		Srec_bsmxsp_rad[JOB_TYPE_SWORDSMAN] = 1/100  -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed
		Srec_sta_rad[JOB_TYPE_SWORDSMAN] = 1/12      -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed

		Aspd_agi_rad[JOB_TYPE_SWORDSMAN] = 1.1    -- Attack frequency attribute influence coefficients: Base attack, agility coefficient, minimum attack frequency

--Attributes Growth Rate of Hunter Class 
		Mxhp_con_rad1[JOB_TYPE_HUNTER] = 3    -- Maximum HP attribute influence coefficients: Constitution coefficient
		Mxhp_con_rad2[JOB_TYPE_HUNTER] = 3    -- Maximum HP attribute influence coefficients: Level coefficient
		Mxhp_lv_rad[JOB_TYPE_HUNTER] = 25     -- Maximum HP attribute influence coefficients: Base number

		Mxsp_sta_rad1[JOB_TYPE_HUNTER] = 1    -- Maximum SP attribute influence coefficients: Stamina coefficient
		Mxsp_sta_rad2[JOB_TYPE_HUNTER] = 0    -- Maximum SP attribute influence coefficients: Constitution coefficient
		Mxsp_lv_rad[JOB_TYPE_HUNTER] = 3      -- Maximum SP attribute influence coefficients: Level coefficient

		Mnatk_str_rad1[JOB_TYPE_HUNTER] = 0       -- Minimum attack power attribute influence coefficients: Strength coefficient
		Mnatk_str_rad2[JOB_TYPE_HUNTER] = 0       -- Minimum attack power attribute influence coefficients: Strength coefficient 2
		Mnatk_dex_rad1[JOB_TYPE_HUNTER] = 1.7     -- Minimum attack power attribute influence coefficients: Dexterity coefficient
		Mnatk_dex_rad2[JOB_TYPE_HUNTER] = 0.4     -- Minimum attack power attribute influence coefficients: Dexterity coefficient 2

		Mxatk_str_rad1[JOB_TYPE_HUNTER] = 0       -- Maximum attack attribute influence coefficients: Strength coefficient
		Mxatk_str_rad2[JOB_TYPE_HUNTER] = 0       -- Maximum attack attribute influence coefficients: Strength coefficient 2
		Mxatk_dex_rad1[JOB_TYPE_HUNTER] = 1.7     -- Maximum attack attribute influence coefficients: Dexterity coefficient
		Mxatk_dex_rad2[JOB_TYPE_HUNTER] = 0.4     -- Maximum attack attribute influence coefficients: Dexterity coefficient 2

		Def_con_rad1[JOB_TYPE_HUNTER] = 0.14    -- Defense attribute influence coefficients: Concentration coefficient 1
		Def_con_rad2[JOB_TYPE_HUNTER] = 0.1     -- Defense attribute influence coefficients: Concentration coefficient 2

		Hit_dex_rad1[JOB_TYPE_HUNTER] = 0.7    -- Hit attribute influence coefficients: Concentration coefficient
		Hit_dex_rad2[JOB_TYPE_HUNTER] = 0      -- Hit attribute influence coefficients: Level coefficient, minimum hit rate

		Flee_agi_rad1[JOB_TYPE_HUNTER] = 0.7   -- Flee attribute influence coefficients: Agility coefficient
		Flee_agi_rad2[JOB_TYPE_HUNTER] = 0     -- Flee attribute influence coefficients: Level coefficient, minimum flee rate

		Mf_luk_rad[JOB_TYPE_HUNTER] = 0.39    -- Critical rate attribute influence coefficients: Luck coefficient

		Crt_luk_rad[JOB_TYPE_HUNTER] = 0.25   -- Critical attribute influence coefficients: Luck coefficient, minimum and maximum critical rates

		Hrec_bsmxhp_rad[JOB_TYPE_HUNTER] = 1/180   -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed
		Hrec_con_rad[JOB_TYPE_HUNTER] = 1/8        -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed

		Srec_bsmxsp_rad[JOB_TYPE_HUNTER] = 1/100   -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed
		Srec_sta_rad[JOB_TYPE_HUNTER] = 1/12       -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed

		Aspd_agi_rad[JOB_TYPE_HUNTER] = 1.2    -- Attack frequency attribute influence coefficients: Base attack, agility coefficient, minimum attack frequency

--Attributes Growth Rate of Explorer Class 
		Mxhp_con_rad1[JOB_TYPE_EXPLORER] = 5     -- Maximum HP attribute influence coefficients: Constitution coefficient
		Mxhp_con_rad2[JOB_TYPE_EXPLORER] = 5    -- Maximum HP attribute influence coefficients: Level coefficient
		Mxhp_lv_rad[JOB_TYPE_EXPLORER] = 25     -- Maximum HP attribute influence coefficients: Base number

		Mxsp_sta_rad1[JOB_TYPE_EXPLORER] = 2    -- Maximum SP attribute influence coefficients: Stamina coefficient
		Mxsp_sta_rad2[JOB_TYPE_EXPLORER] = 1.5  -- Maximum SP attribute influence coefficients: Constitution coefficient
		Mxsp_lv_rad[JOB_TYPE_EXPLORER] = 5      -- Maximum SP attribute influence coefficients: Level coefficient

		Mnatk_str_rad1[JOB_TYPE_EXPLORER] = 1.5     -- Minimum attack power attribute influence coefficients: Strength coefficient
		Mnatk_str_rad2[JOB_TYPE_EXPLORER] = 0       -- Minimum attack power attribute influence coefficients: Strength coefficient 2
		Mnatk_dex_rad1[JOB_TYPE_EXPLORER] = 0       -- Minimum attack power attribute influence coefficients: Dexterity coefficient
		Mnatk_dex_rad2[JOB_TYPE_EXPLORER] = 0       -- Minimum attack power attribute influence coefficients: Dexterity coefficient 2

		Mxatk_str_rad1[JOB_TYPE_EXPLORER] = 1.5     -- Maximum attack attribute influence coefficients: Strength coefficient
		Mxatk_str_rad2[JOB_TYPE_EXPLORER] = 0       -- Maximum attack attribute influence coefficients: Strength coefficient 2
		Mxatk_dex_rad1[JOB_TYPE_EXPLORER] = 0       -- Maximum attack attribute influence coefficients: Dexterity coefficient
		Mxatk_dex_rad2[JOB_TYPE_EXPLORER] = 0       -- Maximum attack attribute influence coefficients: Dexterity coefficient 2

		Def_con_rad1[JOB_TYPE_EXPLORER] = 0.13    -- Defense attribute influence coefficients: Concentration coefficient 1
		Def_con_rad2[JOB_TYPE_EXPLORER] = 0.1    -- Defense attribute influence coefficients: Concentration coefficient 2

		Hit_dex_rad1[JOB_TYPE_EXPLORER] = 0.6    -- Hit attribute influence coefficients: Concentration coefficient
		Hit_dex_rad2[JOB_TYPE_EXPLORER] = 0      -- Hit attribute influence coefficients: Level coefficient, minimum hit rate

		Flee_agi_rad1[JOB_TYPE_EXPLORER] = 0.6   -- Flee attribute influence coefficients: Agility coefficient
		Flee_agi_rad2[JOB_TYPE_EXPLORER] = 0     -- Flee attribute influence coefficients: Level coefficient, minimum flee rate

		Mf_luk_rad[JOB_TYPE_EXPLORER] = 0.39    -- Critical rate attribute influence coefficients: Luck coefficient

		Crt_luk_rad[JOB_TYPE_EXPLORER] = 0.31   -- Critical attribute influence coefficients: Luck coefficient, minimum and maximum critical rates

		Hrec_bsmxhp_rad[JOB_TYPE_EXPLORER] = 1/180  -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed
		Hrec_con_rad[JOB_TYPE_EXPLORER] = 1/8       -- HP recovery attribute influence coefficients: Maximum HP coefficient, level coefficient, minimum HP recovery speed

		Srec_bsmxsp_rad[JOB_TYPE_EXPLORER] = 1/100  -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed
		Srec_sta_rad[JOB_TYPE_EXPLORER] = 1/12      -- SP recovery attribute influence coefficients: Maximum SP coefficient, level coefficient, minimum SP recovery speed

		Aspd_agi_rad[JOB_TYPE_EXPLORER] = 1.1    -- Attack frequency attribute influence coefficients: Base attack, agility coefficient, minimum attack frequency


--Attributes Growth Rate of Herbalist Class
		Mxhp_con_rad1[JOB_TYPE_HERBALIST] = 5    -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_HERBALIST] = 5   -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_HERBALIST] = 25     -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_HERBALIST] = 2   -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_HERBALIST] = 1.5 -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_HERBALIST] = 5     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_HERBALIST] = 1.5    -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_HERBALIST] = 0.4    -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_HERBALIST] = 0      -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_HERBALIST] = 0      -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_HERBALIST] = 1.5    -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_HERBALIST] = 0.4    -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_HERBALIST] = 0      -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_HERBALIST] = 0      -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_HERBALIST] = 0.13 -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_HERBALIST] = 0.1  -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_HERBALIST] = 0.6 -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_HERBALIST] = 0   -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_HERBALIST] = 0.6 -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_HERBALIST] = 0   -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_HERBALIST] = 0.39 -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_HERBALIST] = 0.31 -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_HERBALIST] = 1/180 -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_HERBALIST] = 1/8     -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_HERBALIST] = 1/100 -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_HERBALIST] = 1/12     -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_HERBALIST] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

--Attributes Growth Rate of Champion Class
		Mxhp_con_rad1[JOB_TYPE_CHAMPION] = 5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_CHAMPION] = 7  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_CHAMPION] = 40   -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_CHAMPION] = 1  -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_CHAMPION] = 0  -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_CHAMPION] = 3    -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_CHAMPION] = 2    -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_CHAMPION] = 0.45 -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_CHAMPION] = 0    -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_CHAMPION] = 0    -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_CHAMPION] = 2    -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_CHAMPION] = 0.45 -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_CHAMPION] = 0    -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_CHAMPION] = 0    -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_CHAMPION] = 0.2 -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_CHAMPION] = 0.6 -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_CHAMPION] = 0.6 -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_CHAMPION] = 0.2 -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_CHAMPION] = 0.6 -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_CHAMPION] = 0.2 -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_CHAMPION] = 0.39 -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_CHAMPION] = 0.31 -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_CHAMPION] = 1/180 -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_CHAMPION] = 1/8     -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_CHAMPION] = 1/100 -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_CHAMPION] = 1/12     -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_CHAMPION] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

--Attributes Growth Rate of Crusader Class
		Mxhp_con_rad1[JOB_TYPE_CRUSADER] = 5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_CRUSADER] = 7  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_CRUSADER] = 30  -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_CRUSADER] = 1    -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_CRUSADER] = 0    -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_CRUSADER] = 3     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_CRUSADER] = 1.5   -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_CRUSADER] = 0.4   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_CRUSADER] = 0     -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_CRUSADER] = 0     -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_CRUSADER] = 1.5   -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_CRUSADER] = 0.4   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_CRUSADER] = 0     -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_CRUSADER] = 0     -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_CRUSADER] = 0.2  -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_CRUSADER] = 0.1  -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_CRUSADER] = 0.6  -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_CRUSADER] = 0    -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_CRUSADER] = 0.75  -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_CRUSADER] = 0    -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_CRUSADER] = 0.39  -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_CRUSADER] = 0.31  -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_CRUSADER] = 1/180  -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_CRUSADER] = 1/8      -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_CRUSADER] = 1/100  -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_CRUSADER] = 1/12      -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_CRUSADER] = 1.25  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

--Attributes Growth Rate of Sharpshooter Class
		Mxhp_con_rad1[JOB_TYPE_SHARPSHOOTER] = 3.5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_SHARPSHOOTER] = 3.5  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_SHARPSHOOTER] = 30  -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_SHARPSHOOTER] = 1    -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_SHARPSHOOTER] = 0    -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_SHARPSHOOTER] = 3     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_SHARPSHOOTER] = 0   -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_SHARPSHOOTER] = 0   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_SHARPSHOOTER] = 2   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_SHARPSHOOTER] = 0.45 -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_SHARPSHOOTER] = 0   -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_SHARPSHOOTER] = 0   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_SHARPSHOOTER] = 2   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_SHARPSHOOTER] = 0.45 -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_SHARPSHOOTER] = 0.15  -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_SHARPSHOOTER] = 0.15  -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_SHARPSHOOTER] = 0.6  -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_SHARPSHOOTER] = 0    -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_SHARPSHOOTER] = 0.6  -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_SHARPSHOOTER] = 0    -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_SHARPSHOOTER] = 0.39  -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_SHARPSHOOTER] = 0.31  -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_SHARPSHOOTER] = 1/180  -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_SHARPSHOOTER] = 1/8      -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_SHARPSHOOTER] = 1/100  -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_SHARPSHOOTER] = 1/12      -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_SHARPSHOOTER] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

--Attributes Growth Rate of Cleric Class
		Mxhp_con_rad1[JOB_TYPE_CLERIC] = 5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_CLERIC] = 5  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_CLERIC] = 30  -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_CLERIC] = 3    -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_CLERIC] = 1.5  -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_CLERIC] = 5     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_CLERIC] = 1.5   -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_CLERIC] = 0.4   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_CLERIC] = 0     -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_CLERIC] = 0     -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_CLERIC] = 1.5   -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_CLERIC] = 0.4   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_CLERIC] = 0     -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_CLERIC] = 0     -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_CLERIC] = 0.15  -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_CLERIC] = 0.1   -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_CLERIC] = 0.6  -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_CLERIC] = 0    -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_CLERIC] = 0.6  -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_CLERIC] = 0    -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_CLERIC] = 0.39  -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_CLERIC] = 0.31  -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_CLERIC] = 1/180  -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_CLERIC] = 1/8      -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_CLERIC] = 1/100  -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_CLERIC] = 1/12      -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_CLERIC] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

--Attributes Growth Rate of Seal Master Class
		Mxhp_con_rad1[JOB_TYPE_SEALMASTER] = 5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_SEALMASTER] = 5  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_SEALMASTER] = 30  -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_SEALMASTER] = 3    -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_SEALMASTER] = 1.5  -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_SEALMASTER] = 5     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_SEALMASTER] = 1.5   -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_SEALMASTER] = 0.4   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_SEALMASTER] = 0     -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_SEALMASTER] = 0     -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_SEALMASTER] = 1.5   -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_SEALMASTER] = 0.4   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_SEALMASTER] = 0     -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_SEALMASTER] = 0     -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_SEALMASTER] = 0.15  -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_SEALMASTER] = 0.1   -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_SEALMASTER] = 0.6  -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_SEALMASTER] = 0    -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_SEALMASTER] = 0.6  -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_SEALMASTER] = 0    -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_SEALMASTER] = 0.39  -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_SEALMASTER] = 0.31  -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_SEALMASTER] = 1/180  -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_SEALMASTER] = 1/8      -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_SEALMASTER] = 1/100  -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_SEALMASTER] = 1/12      -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_SEALMASTER] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment


--Attributes Growth Rate of Voyager Class
		Mxhp_con_rad1[JOB_TYPE_VOYAGER] = 5  -- Constitution coefficient for maximum HP
		Mxhp_con_rad2[JOB_TYPE_VOYAGER] = 5  -- Level coefficient for maximum HP
		Mxhp_lv_rad[JOB_TYPE_VOYAGER] = 30  -- Basic number for maximum HP

		Mxsp_sta_rad1[JOB_TYPE_VOYAGER] = 3    -- Energy coefficient for maximum SP
		Mxsp_sta_rad2[JOB_TYPE_VOYAGER] = 1.5  -- Constitution coefficient for maximum SP
		Mxsp_lv_rad[JOB_TYPE_VOYAGER] = 5     -- Level coefficient for maximum SP

		Mnatk_str_rad1[JOB_TYPE_VOYAGER] = 1.5   -- Strength coefficient for minimum attack
		Mnatk_str_rad2[JOB_TYPE_VOYAGER] = 0.4   -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad1[JOB_TYPE_VOYAGER] = 0     -- Dexterity coefficient for minimum attack
		Mnatk_dex_rad2[JOB_TYPE_VOYAGER] = 0     -- Dexterity coefficient for minimum attack

		Mxatk_str_rad1[JOB_TYPE_VOYAGER] = 1.5   -- Strength coefficient for maximum attack
		Mxatk_str_rad2[JOB_TYPE_VOYAGER] = 0.4   -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad1[JOB_TYPE_VOYAGER] = 0     -- Dexterity coefficient for maximum attack
		Mxatk_dex_rad2[JOB_TYPE_VOYAGER] = 0     -- Dexterity coefficient for maximum attack

		Def_con_rad1[JOB_TYPE_VOYAGER] = 0.15  -- Focus coefficient for defense
		Def_con_rad2[JOB_TYPE_VOYAGER] = 0.1   -- Focus coefficient for defense

		Hit_dex_rad1[JOB_TYPE_VOYAGER] = 0.6  -- Focus coefficient for hit rate
		Hit_dex_rad2[JOB_TYPE_VOYAGER] = 0    -- Level coefficient for hit rate
		-- Minimum hit rate is implied but not explicitly mentioned in the comment

		Flee_agi_rad1[JOB_TYPE_VOYAGER] = 0.6  -- Agility coefficient for evasion
		Flee_agi_rad2[JOB_TYPE_VOYAGER] = 0    -- Level coefficient for evasion
		-- Minimum evasion rate is implied but not explicitly mentioned in the comment

		Mf_luk_rad[JOB_TYPE_VOYAGER] = 0.39  -- Luck coefficient for critical rate

		Crt_luk_rad[JOB_TYPE_VOYAGER] = 0.31  -- Luck coefficient for critical hit rate
		-- Minimum and maximum critical rates are implied but not explicitly mentioned in the comment

		Hrec_bsmxhp_rad[JOB_TYPE_VOYAGER] = 1/180  -- HP recovery coefficient
		Hrec_con_rad[JOB_TYPE_VOYAGER] = 1/8      -- Level coefficient for HP recovery
		-- Minimum HP recovery speed is implied but not explicitly mentioned in the comment

		Srec_bsmxsp_rad[JOB_TYPE_VOYAGER] = 1/100  -- SP recovery coefficient
		Srec_sta_rad[JOB_TYPE_VOYAGER] = 1/12      -- Level coefficient for SP recovery
		-- Minimum SP recovery speed is implied but not explicitly mentioned in the comment

		Aspd_agi_rad[JOB_TYPE_VOYAGER] = 1.1  -- Attack frequency coefficient
		-- Base attack and minimum attack frequency are implied but not explicitly mentioned in the comment

function Creat_Item(item, item_type, item_lv, item_event) --[[创建道具实例]]--
	--LuaPrint("Enter function Creat_Item()".."\n") 
	--LG("item", "Enter function Creat_Item() type = ", item_type, "  lv = ", item_lv, " event = ", item_event) 
	item_event = item_event 
	item_type   = item_type 
	item_lv       = item_lv 
		 
	Reset_item_add() --	清空 item_add
	
	local i = 0
	local Num = 0
	if item_event==NPC_SALE then --NPC买卖 ？？？？？？？？？？？？？？NPC_SALE定义成宏了吗 在哪里
		--LG("item", "道具创建类型——", "npc买卖", "\n") 
		Npc_Sale(  item_type, item_lv  , item_event) 
		
--		i = SetItemForgeParam ( item , 1 , Num )
		
--		if i == 0 then
--			LG( "Creat_Item" , "设置精炼内容失败" )
--		end
		
		SetItemForgeParam_Npc_Sale ( item , Num )

	elseif item_event==MONSTER_BAOLIAO then --怪物暴料
		--LG("item", "道具创建类型——", "怪物暴料", "\n") 
		Monster_Baoliao( item_type, item_lv  , item_event)
		if item_type<30 then 
			Add_Item_Attr(ITEMATTR_URE,300)
		end

		SetItemForgeParam_MonsterBaoliao ( item , Num )

	elseif item_event == PLAYER_HECHENG then --玩家合成
		--LG("item", "道具创建类型——", "玩家合成", "\n") 
		Player_Hecheng( item_type, item_lv  , item_event)
		
		SetItemForgeParam_PlayerHecheng ( item , Num )

	elseif item_event == PLAYER_XSBOX then --新手宝箱
		--LG("item", "道具创建类型——", "新手宝箱", "\n") 
		Player_XSBox( item_type, item_lv  , item_event)
		local Num = GetItemForgeParam ( item , 1 )	 --32位信息数据
		local Part1 = GetNum_Part1 ( Num )	--Get Num Part 1 到 Part 7
		local Part2 = GetNum_Part2 ( Num )
		local Part3 = GetNum_Part3 ( Num )
		local Part4 = GetNum_Part4 ( Num )
		local Part5 = GetNum_Part5 ( Num )
		local Part6 = GetNum_Part6 ( Num )
		local Part7 = GetNum_Part7 ( Num )
		--local SkillType = 3		--要增加的 Skill 类型
		--local SkillNum = 5		--要增加的Skill 编号
		if item_type == 1 then
			Part1 = 1
			Part2 = 1
			Part3 = 1
		end
		if item_type == 2 then
			Part1 = 1
			Part2 = 2
			Part3 = 1
		end
		if item_type == 3 then
			Part1 = 1
			Part2 = 2
			Part3 = 1
		end
		if item_type == 4 then
			Part1 = 1
			Part2 = 3
			Part3 = 1
		end
		if item_type == 7 then
			Part1 = 1
			Part2 = 8
			Part3 = 1
		end
		if item_type == 9 then
			Part1 = 1
			Part2 = 8
			Part3 = 1
		end

		Num = SetNum_Part3 ( Num , Part3 )
		Num = SetNum_Part2 ( Num , Part2 )
		Num = SetNum_Part1 ( Num , Part1)
		SetItemForgeParam ( item , 1 , Num )
	       -- AddItemEffect(role , item , 1  )
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
	elseif item_event == PLAYER_CCFSBOXA then --磁场发生器a
		Player_CCFSBoxA( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXB then --磁场发生器b
		Player_CCFSBoxB( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXC then --磁场发生器c
		Player_CCFSBoxC( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXD then --磁场发生器d
		Player_CCFSBoxD( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXE then --磁场发生器e
		Player_CCFSBoxE( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXF then --磁场发生器f
		Player_CCFSBoxF( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXG then --磁场发生器g
		Player_CCFSBoxG( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXH then --磁场发生器h
		Player_CCFSBoxH( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_CCFSBOXI then --磁场发生器i
		Player_CCFSBoxI( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_ZSITEM then --紫色装备
		Player_ZSitem( item_type, item_lv  , item_event)
	elseif item_event == QUEST_AWARD_GODBOX then --无插槽装备                                  ----------------kokora
		quest_award_godbox( item_type, item_lv  , item_event)

	elseif item_event == PLAYER_HSSR then --黑市商人
		Player_HSSR( item_type, item_lv  , item_event)
	elseif item_event == PLAYER_HSSRA then --黑市商人
		Player_HSSRA( item_type, item_lv  , item_event)
	elseif item_event == ATTRRESET then --属性重置
		AttrResetItem( item_type, item_lv  , item_event)
	elseif item_event >= QUEST_AWARD_1 then --任务获取
--		LG("item_1", "道具创建类型——", "任务获取", "\n") 
		Quest_Award( item_type, item_lv  , item_event)
		
		SetItemForgeParam_QuestAward ( item , Num , item_event )
	
	else 
		--LG("item", "创建道具来由不存在, event = ", item_event) 
		item_add.cnt = 0 
	end 

	--LG("item","item_add.cnt = " , item_add.cnt,"\n", "item_add.attr[1][1] = ", item_add.attr[1][1], "item_add.attr[1][2] = ", item_add.attr[1][2],"\n", "item_add.attr[2][1] = ", item_add.attr[2][1], "item_add.attr[2][2] = ", item_add.attr[2][2],"\n", "item_add.attr[JOB_TYPE_SAILOR][1] = ",  item_add.attr[3][1], "item_add.attr[JOB_TYPE_SAILOR][2] = ", item_add.attr[3][2],"\n", "item_add.attr[4][1] = ", item_add.attr[4][1], "item_add.attr[4][2] = ", item_add.attr[4][2],"\n", "item_add.attr[5][1] = ", item_add.attr[5][1], "item_add.attr[5][2] =", item_add.attr[5][2],"\n")
	--LG("item", "End Creat_Item()") 

	--LuaPrint("Out function Creat_Item()".."\n") 

	return item_add.cnt, 
	item_add.attr[1][1], item_add.attr[1][2],
	item_add.attr[2][1], item_add.attr[2][2], 
	item_add.attr[3][1], item_add.attr[3][2],
	item_add.attr[4][1], item_add.attr[4][2],
	item_add.attr[5][1], item_add.attr[5][2],
	item_add.attr[6][1], item_add.attr[6][2],
	item_add.attr[7][1], item_add.attr[7][2] 
end 

function Npc_Sale(item_type, item_lv , item_event) --[[创建实例之npc买卖道具]]-- 
	--LuaPrint("Enter function Npc_Sale()") 
	--LG("item", "Enter function Npc_Sale()", "\n")
	Creat_Item_Tattr( item_type, item_lv , item_event ) 
	--LG("item", "Out function Npc_Sale()", "\n")
	--LuaPrint("Out function Npc_Sale()") 
end 

function Monster_Baoliao(item_type, item_lv , item_event) --[[创建实例之怪物暴料]]--
	--LG("item", "Enter Monster_Baoliao()")  
	Creat_Item_Tattr(item_type,item_lv , item_event) 
--	Creat_Item_Tattr( item_type, item_lv ) 
	--LG("item", "End Monster_Baoliao()" ) 
end 

function Player_Hecheng (item_type, item_lv , item_event) --[[创建实例之玩家合成道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end  

function Quest_Award( item_type, item_lv  , item_event) --[[创建实例之任务获取道具]]-- 
	--LuaPrint("Enter function Quest_Award( item_type, item_lv )") 
	--LG("item", "Enter function Quest_Award( item_type, item_lv )", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Quest_Award( item_type, item_lv )", "\n") 
	--LuaPrint("Out function Quest_Award( item_type, item_lv )")  
end  

function Player_XSBox( item_type, item_lv  , item_event) --[[创建实例之新手宝箱道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end  
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

function Player_CCFSBoxA( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 

function Player_CCFSBoxB( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxC( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxD( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxE( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxF( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxG( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxH( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_CCFSBoxI( item_type, item_lv  , item_event) --[[创建实例之磁场发生器道具]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
		--Player_XSBox( item_type, item_lv  , item_event) PLAYER_ZSITEM
function Player_ZSitem( item_type, item_lv  , item_event) --[[创建实例之紫色装备]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 

function quest_award_godbox( item_type, item_lv  , item_event) --[[创建实例之无插槽装备]]--                             ---kokora
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 

function Player_HSSR( item_type, item_lv  , item_event) --[[创建实例之黑市商人]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function Player_HSSRA( item_type, item_lv  , item_event) --[[创建实例之黑市商人]]-- 
	--LuaPrint("Enter function Player_Hecheng()") 
	--LG("item", "Enter function Player_Hecheng()", "\n") 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
	--LG("item", "Out function Player_Hecheng()", "\n") 
	--LuaPrint("Out function Player_Hecheng()")  
end 
function AttrResetItem( item_type, item_lv  , item_event) --[[创建实例之属性重置]]-- 
	Creat_Item_Tattr(item_type,item_lv , item_event) 
end 
function Creat_Item_Battr(item_type, item_lv, item_event) --[[创建道具的基本属性]]--
	--LG("item", "Creat_Item_Battr() type = ", item_type, "\n") 
	if item_type>=1 and item_type<=10 then   ---*********************武器
		Add_Item_Attr(ITEMATTR_MAXURE, 0) 
		Add_Item_Attr(ITEMATTR_VAL_MNATK,  0) 
		Add_Item_Attr(ITEMATTR_VAL_MXATK,  0) 
--		Add_Item_Attr(ITEMATTR_VAL_HIT, 0) 
		if item_type == 1 then ----****************剑
			Add_Item_Attr( ITEMATTR_VAL_HIT, 0) ---********命中率
			Add_Item_Attr( ITEMATTR_COE_ASPD, 0)----********攻击频率
		elseif item_type == 2 then 
			Add_Item_Attr( ITEMATTR_VAL_DEF, 0)
			Add_Item_Attr( ITEMATTR_VAL_MXHP, 0)
		elseif item_type == 3 then 
			Add_Item_Attr( ITEMATTR_COE_ASPD, 0) 
			Add_Item_Attr( ITEMATTR_VAL_HIT, 0)	
		elseif item_type == 4 then 
			Add_Item_Attr( ITEMATTR_VAL_HIT, 0) 
			Add_Item_Attr( ITEMATTR_COE_ASPD, 0)	
		elseif item_type == 7 then 
			Add_Item_Attr( ITEMATTR_VAL_STA, 0)	
			Add_Item_Attr( ITEMATTR_COE_MXSP, 0)	
			Add_Item_Attr( ITEMATTR_COE_MSPD, 0)	
		elseif item_type == 9 then						
			Add_Item_Attr( ITEMATTR_VAL_STA, 0)	
			Add_Item_Attr( ITEMATTR_COE_MXSP, 0)	
			Add_Item_Attr( ITEMATTR_COE_MXHP, 0)	
		end 
	elseif item_type==11 then 
		Add_Item_Attr(ITEMATTR_MAXURE, 0) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
		Add_Item_Attr(ITEMATTR_VAL_PDEF, 0)
	elseif item_type==20 then 
		Add_Item_Attr(ITEMATTR_MAXURE, 0) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
	elseif item_type==22 then 
		Add_Item_Attr(ITEMATTR_MAXURE, 0)
		Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
		Add_Item_Attr(ITEMATTR_VAL_PDEF, 0) 
		Add_Item_Attr(ITEMATTR_VAL_MXSP, 0) 
		Add_Item_Attr(ITEMATTR_VAL_AGI, 0) 
	elseif item_type==27 then 
		Add_Item_Attr(ITEMATTR_MAXURE, 0) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
		Add_Item_Attr(ITEMATTR_VAL_PDEF, 0) 
	elseif item_type==23 then 
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_HIT,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_DEX, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_SREC, 0)  
	elseif item_type==24 then 
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_FLEE, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_DEF, 0) 
	elseif item_type==29 then 
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_MAXENERGY, 0) 
	elseif item_type == 26 then 
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_MXATK,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_DEF,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_FLEE,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_HIT,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_CRT,  0) 
	elseif item_type == 25 then 
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_VAL_MXHP,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_MXSP,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_SREC,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_HREC,  0) 
	       Add_Item_Attr(ITEMATTR_VAL_PDEF,  0) 
	elseif  item_type == 46 then

	elseif item_type == 59 then
	
	else
	      --LG("item", "错误实例化道具类型\n") 
        end 
	--LG("item", "End Creat_Item_Tattr()\n" ) 
end 



function Creat_Item_Tattr(item_type,item_lv , item_event) --[[创建道具随机属性]]--
--	LG("item_1", "Creat_Item_Tattr() type = ", item_type, "\n") 
--	LG("item_1", "Creat_Item_Tattr() item_event = ", item_event, "\n") 
	local quality = SetItemQua ( item_event ) 
--	LG ( "item_1" , "  quality = " , quality ) 
	if item_event == 101 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 10 )							--宝石
		return 
	end 
	if item_event == 102 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 20 )							--宝石
		return 
	end
	if item_event == 103 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 30 )							--宝石
		return 
	end
	if item_event == 104 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 40 )							--宝石
		return 
	end
	if item_event == 105 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 50 )							--宝石
		return 
	end
	if item_event == 106 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 60 )							--宝石
		return 
	end
	if item_event == 107 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 70 )							--宝石
		return 
	end
	if item_event == 108 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 80 )							--宝石
		return 
	end
	if item_event == 109 then 
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 90 )							--宝石
		return 
	end 
	if item_type>=1 and item_type<=10 then 
		Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) ) 
		Add_Item_Attr(ITEMATTR_VAL_MNATK,  quality * 10 ) 
		Add_Item_Attr(ITEMATTR_VAL_MXATK,  quality * 10) 
--		Add_Item_Attr(ITEMATTR_VAL_HIT, quality) 
		if item_type == 1 then									--单手剑
--			Add_Item_Attr( ITEMATTR_VAL_HIT, SetItemQua ( item_event ) ) 
--			Add_Item_Attr( ITEMATTR_COE_ASPD, SetItemQua ( item_event ) ) 
			CreatItemAttr ( item_type,item_lv , item_event, quality ) 

		elseif item_type == 2 then									--巨剑
--			Add_Item_Attr( ITEMATTR_VAL_DEF, SetItemQua ( item_event ) )
--			Add_Item_Attr( ITEMATTR_VAL_MXHP, SetItemQua ( item_event ) )
			CreatItemAttr ( item_type,item_lv , item_event, quality ) 

		elseif item_type == 3 then									--弓
--			Add_Item_Attr( ITEMATTR_COE_ASPD, SetItemQua ( item_event ) ) 
--			Add_Item_Attr( ITEMATTR_VAL_HIT, SetItemQua ( item_event ) )	
			CreatItemAttr ( item_type,item_lv , item_event, quality ) 

		elseif item_type == 4 then									--火枪
--			Add_Item_Attr( ITEMATTR_VAL_HIT, SetItemQua ( item_event ) ) 
--			Add_Item_Attr( ITEMATTR_COE_ASPD, SetItemQua ( item_event ) )	
			CreatItemAttr ( item_type,item_lv , item_event , quality ) 

		elseif item_type == 7 then									--匕首
--			Add_Item_Attr( ITEMATTR_VAL_STA, SetItemQua ( item_event ) )	
--			Add_Item_Attr( ITEMATTR_COE_MXSP, SetItemQua ( item_event ) )	
--			Add_Item_Attr( ITEMATTR_COE_MSPD, SetItemQua ( item_event ) )	
			CreatItemAttr ( item_type,item_lv , item_event , quality ) 

		elseif item_type == 9 then									--短杖
--			Add_Item_Attr( ITEMATTR_VAL_STA, SetItemQua ( item_event ) )	
--			Add_Item_Attr( ITEMATTR_COE_MXSP, SetItemQua ( item_event ) )	
--			Add_Item_Attr( ITEMATTR_COE_MXHP, SetItemQua ( item_event ) )	
			CreatItemAttr ( item_type,item_lv , item_event, quality ) 

		end 
	elseif item_type==11 then										--盾
		Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) ) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10 ) 
		Add_Item_Attr(ITEMATTR_VAL_PDEF, quality ) 
		CreatItemAttr ( item_type,item_lv , item_event , quality ) 

	elseif item_type==20 then										--帽子
--		LG("item_1", " enter 帽子 item_type==", item_type, "\n") 
		Add_Item_Attr(ITEMATTR_MAXURE, 0 ) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10) 
		CreatItemAttr ( item_type,item_lv , item_event , quality) 

	elseif item_type==22 then										--衣服
		Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) )
		Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10) 
	       Add_Item_Attr(ITEMATTR_VAL_PDEF,  quality * 10 ) 
		--Add_Item_Attr(ITEMATTR_VAL_MXHP, quality * 10 ) 
		--Add_Item_Attr(ITEMATTR_VAL_HREC,  quality * 10 ) 
		CreatItemAttr ( item_type,item_lv , item_event , quality ) 

	elseif item_type==27 then										--纹身
		Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) )
		Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10) 
		Add_Item_Attr(ITEMATTR_VAL_PDEF, SetItemQua ( item_event ) ) 
		CreatItemAttr ( item_type,item_lv , item_event , quality) 

	elseif item_type==23 then										--手套
	       Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) ) 
	       Add_Item_Attr(ITEMATTR_VAL_HIT,  quality * 10) 
	       Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10) 
--	       Add_Item_Attr(ITEMATTR_VAL_DEX, SetItemQua ( item_event ) ) 
--	       Add_Item_Attr(ITEMATTR_VAL_SREC, SetItemQua ( item_event ) ) 
		CreatItemAttr ( item_type, item_lv , item_event , quality) 

	elseif item_type==24 then										--鞋子
		Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) ) 
		Add_Item_Attr(ITEMATTR_VAL_FLEE, quality * 10) 
		Add_Item_Attr(ITEMATTR_VAL_DEF, quality * 10) 
		CreatItemAttr ( item_type,item_lv , item_event , quality ) 

	elseif item_type==29 then										--贝壳
	       Add_Item_Attr(ITEMATTR_MAXURE, 0) 
	       Add_Item_Attr(ITEMATTR_MAXENERGY, 0) 

	elseif item_type == 26 then										--戒指
	       Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event )  ) 
	       Add_Item_Attr(ITEMATTR_VAL_MXATK,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_DEF,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_FLEE,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_HIT,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_CRT,  quality * 10 ) 
	       CreatItemAttr ( item_type,item_lv , item_event , quality  ) 

	elseif item_type == 25 then										--项链
	       Add_Item_Attr(ITEMATTR_MAXURE, SetItemQua ( item_event ) ) 
	       Add_Item_Attr(ITEMATTR_VAL_MXHP,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_MXSP,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_SREC,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_HREC,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_PDEF,  quality * 10 ) 
	       CreatItemAttr ( item_type,item_lv , item_event , quality ) 
	elseif item_type == 46 then										--荣誉证
	       CreatItemAttr ( item_type,item_lv , item_event , quality )
	elseif item_type == 49 then
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 10 )							--宝石
	elseif item_type == 50 then
		Add_Item_Attr ( ITEMATTR_VAL_BaoshiLV , 10 )							--精炼石
	elseif item_type == 59 then
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
		Add_Item_Attr(ITEMATTR_VAL_DEX, 10 )
		Add_Item_Attr(ITEMATTR_VAL_CON, 10 )
		Add_Item_Attr(ITEMATTR_VAL_AGI, 10 )
		Add_Item_Attr(ITEMATTR_VAL_STA, 10 )
	elseif item_type == 65 then
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
		Add_Item_Attr(ITEMATTR_VAL_DEX, 10 )
		Add_Item_Attr(ITEMATTR_VAL_CON, 10 )
		Add_Item_Attr(ITEMATTR_VAL_AGI, 10 )
		Add_Item_Attr(ITEMATTR_VAL_STA, 10 )
	elseif 	item_type == 68  then
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
		Add_Item_Attr(ITEMATTR_VAL_DEX, 10 )
		Add_Item_Attr(ITEMATTR_VAL_CON, 10 )
		Add_Item_Attr(ITEMATTR_VAL_AGI, 10 )
		Add_Item_Attr(ITEMATTR_VAL_STA, 10 )
	elseif item_type == 69 then--制造图纸
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
		Add_Item_Attr(ITEMATTR_VAL_DEX, 10 )
		Add_Item_Attr(ITEMATTR_VAL_CON, 10 )
		Add_Item_Attr(ITEMATTR_VAL_AGI, 10 )
		Add_Item_Attr(ITEMATTR_VAL_STA, 10 )
		--Add_Item_Attr(ITEMATTR_VAL_STR, 0 )--装备ID
		--Add_Item_Attr(ITEMATTR_VAL_AGI, 0 )--材料1
		--Add_Item_Attr(ITEMATTR_VAL_DEX, 0 )--材料2
		--Add_Item_Attr(ITEMATTR_VAL_CON, 0 )--材料3
		--Add_Item_Attr(ITEMATTR_VAL_STA, 0 )--基本成功率
		--Add_Item_Attr(ITEMATTR_VAL_LUK, 0 )--图纸等级
		--Add_Item_Attr(ITEMATTR_MAXURE, 0 )--流程数
		--Add_Item_Attr(ITEMATTR_MAXENERGY, 0 )--精灵硬币需求
	elseif item_type == 70 then--工具
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
	elseif item_type == 71 then--工具
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
	elseif item_type == 41 then--工具
		Add_Item_Attr(ITEMATTR_VAL_STR, 10 )
		Add_Item_Attr(ITEMATTR_VAL_AGI, 10 )
		Add_Item_Attr(ITEMATTR_VAL_DEX, 10 )
	else	
	      --LG("item", "错误实例化道具类型\n") 
        end 
	--LG("item", "End Creat_Item_Tattr()\n" ) 
end



function SetItemQua ( item_event )								--随机道具品质————————————
--	LG ( "creatItemattr" , "  enter setqua "  , " item_event = " , item_event ) 
	local qua = 0 
	if  item_event == NPC_SALE then					--npc买卖
		qua = 0 
	elseif item_event == MONSTER_BAOLIAO then 
		qua = Item_Quality_Ran ( Item_Baoliao ) 
	elseif item_event == QUEST_AWARD_1 then 
		qua = Item_Quality_Ran ( Item_Mission_1 ) 
	elseif item_event == QUEST_AWARD_2 then 
		qua = Item_Quality_Ran ( Item_Mission_2 ) 
	elseif item_event == QUEST_AWARD_3 then 
		qua = Item_Quality_Ran ( Item_Mission_3 ) 
	elseif item_event == QUEST_AWARD_4 then 
		qua = Item_Quality_Ran ( Item_Mission_4 ) 
	elseif item_event == QUEST_AWARD_5 then 
		qua = Item_Quality_Ran ( Item_Mission_5 )

	elseif item_event == PLAYER_XSBOX then 
		qua = Item_Quality_Ran ( Item_Mission_11 )

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
	elseif item_event == PLAYER_CCFSBOXA then 
		qua = Item_Quality_Ran ( Item_Mission_12 )
	elseif item_event == PLAYER_CCFSBOXB then 
		qua = Item_Quality_Ran ( Item_Mission_13 )
	elseif item_event == PLAYER_CCFSBOXC then 
		qua = Item_Quality_Ran ( Item_Mission_14 )
	elseif item_event == PLAYER_CCFSBOXD then 
		qua = Item_Quality_Ran ( Item_Mission_15 )
	elseif item_event == PLAYER_CCFSBOXE then 
		qua = Item_Quality_Ran ( Item_Mission_16 )
	elseif item_event == PLAYER_CCFSBOXF then 
		qua = Item_Quality_Ran ( Item_Mission_17 )
	elseif item_event == PLAYER_CCFSBOXG then 
		qua = Item_Quality_Ran ( Item_Mission_18 )
	elseif item_event == PLAYER_CCFSBOXH then 
		qua = Item_Quality_Ran ( Item_Mission_19 )
	elseif item_event == PLAYER_CCFSBOXI then 
		qua = Item_Quality_Ran ( Item_Mission_20 )
	elseif item_event == PLAYER_ZSITEM then 
		qua = Item_Quality_Ran ( Item_Mission_22 )
	elseif item_event == PLAYER_HSSR then 
		qua = Item_Quality_Ran ( Item_Mission_23 )
	elseif item_event == PLAYER_HSSRA then 
		qua = Item_Quality_Ran ( Item_Mission_24 )
	elseif item_event == QUEST_AWARD_GODBOX then                                                                       -----kokora
		qua = Item_Quality_Ran ( Item_Mission_94 )
	elseif item_event == QUEST_AWARD_SCBOX then
		qua = Item_Quality_Ran ( Item_Mission_95 )
	elseif item_event == QUEST_AWARD_SDJ then
		qua = Item_Quality_Ran ( Item_Mission_96 )
	elseif item_event == QUEST_AWARD_RYZ then
		qua = Item_Quality_Ran ( Item_Mission_97 )	
	elseif item_event == QUEST_AWARD_WZX then
		qua = Item_Quality_Ran ( Item_Mission_98 )
	elseif item_event == QUEST_AWARD_RAND then 
		qua = Item_Quality_Ran ( Item_Mission_99 ) 
	elseif item_event == ATTRRESET then 
		qua = Item_Quality_Ran ( Item_Mission_AttrReset ) 
	end 
--	LG ( "item_1" , "  qua = " , qua ) 
	return qua 
end 
		
function Item_Quality_Ran ( item_type_ran ) -----*************返回值为1到10？？？？？？？？item_type_ran [i]
	local a = math.random ( 1, 100 ) 
--	LG("item_1", " Item_Quality_Ran a ==", a, "\n") 

	local b = 0 
	for i = 0 , 9 , 1 do 
--		LG("item_1", "loop " , i ) 
--		LG("item_1", " item_type_ran i ==", item_type_ran [i], "\n") 
		if a <= item_type_ran [i] then 
			b =  (10 - i ) 
			return b
		end 
	end 
--	LG ( "item_1" , "  b = " , b ) 

	return b 

end 

-------最多五种属性
function CreateItemAttrCount ( item_type , item_lv , item_event , quality , item_attrcount_ran ) --******？？？item_attrcount_ran [i]
	local a = math.random ( 1, 100 ) 
--	LG("item_1", " count_rad = " , a ) 
	if item_event == PLAYER_CCFSBOXA or  item_event == PLAYER_CCFSBOXB or  item_event == PLAYER_CCFSBOXC  or  item_event == PLAYER_CCFSBOXD  or  item_event == PLAYER_CCFSBOXE or  item_event == PLAYER_CCFSBOXF  or  item_event == PLAYER_CCFSBOXG or  item_event == PLAYER_CCFSBOXH or  item_event == PLAYER_CCFSBOXI then
		return 6
	end
	for i = 0 , 4 , 1 do 
		if a <= item_attrcount_ran [i] then 
--			LG("item_1", "loop" , i , " item_attrcount_ran = " , item_attrcount_ran [i] ) 

			return  5 - i 
		end 
	end 
	return 0  
end 

function CreatItemAttr ( item_type , item_lv , item_event , quality ) 
--	LG("item_1", " enter CreatItemAttr") 
	local count = 0 
	local energy = 0 
	local eleven =0
	if  item_lv <= 10 and item_type ~= 46 then							--新手装备
	       Add_Item_Attr(ITEMATTR_MAXENERGY, 0) 
	       return 
	end 
	if  item_event == NPC_SALE then					--npc买卖
	       Add_Item_Attr(ITEMATTR_MAXENERGY, 0) 
	       return 
	elseif item_event == MONSTER_BAOLIAO then 
--		LG("item_1", " CreateItemAttrCount_baoliao")
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_0 ) 
--		LG("item_1", " count = " , count ) 
	elseif item_event == QUEST_AWARD_1 then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_1 ) 
	elseif item_event == QUEST_AWARD_2 then 
--		LG("item_1", " item_event = " ,  QUEST_AWARD_2) 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_2 ) 
	elseif item_event == QUEST_AWARD_3 then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_3 ) 
	elseif item_event == QUEST_AWARD_4 then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_4 ) 
	elseif item_event == QUEST_AWARD_5 then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_5 )

	elseif item_event == PLAYER_XSBOX then 

		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_11 )

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
	elseif item_event ==  PLAYER_CCFSBOXA then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_12 )
	elseif item_event ==  PLAYER_CCFSBOXB then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_13 )
	elseif item_event ==  PLAYER_CCFSBOXC then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_14 )
	elseif item_event ==  PLAYER_CCFSBOXD then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_15 )
	elseif item_event ==  PLAYER_CCFSBOXE then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_16 )
	elseif item_event ==  PLAYER_CCFSBOXF then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_17 )
	elseif item_event ==  PLAYER_CCFSBOXG then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_18 )
	elseif item_event ==  PLAYER_CCFSBOXH then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_19 )
	elseif item_event ==  PLAYER_CCFSBOXI then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_20 )
	elseif item_event ==  PLAYER_ZSITEM then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_22 )

	elseif item_event ==  PLAYER_HSSR then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_23 )
	elseif item_event ==  PLAYER_HSSRA then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_24 )

	elseif item_event == QUEST_AWARD_GODBOX then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_94 )
	elseif item_event == QUEST_AWARD_SCBOX then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_95 )
	elseif item_event == QUEST_AWARD_SDJ then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_96 )		
	elseif item_event == QUEST_AWARD_RYZ then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_97 )
	elseif item_event == QUEST_AWARD_WZX then
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_98 )
	elseif item_event == QUEST_AWARD_RAND then 
--		LG("item_1", " item_event = " ,  QUEST_AWARD_RAND) 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_99 ) 
--		LG ( "item_1" , "  count = " , count ) 
	elseif item_event == ATTRRESET then 
		count = CreateItemAttrCount ( item_type , item_lv , item_event , quality , Item_Attr_AttrReset )

	end 
	if count >= 2 and item_type ~=46 then 

		count = math.max ( 1 , math.min ( quality-1 , count )  ) 
	end 
	if item_event == 25 or item_event == 26 then 
		count = 0 
	end 
	if  item_event == PLAYER_CCFSBOXA or  item_event == PLAYER_CCFSBOXB or  item_event == PLAYER_CCFSBOXC  or  item_event == PLAYER_CCFSBOXD  or  item_event == PLAYER_CCFSBOXE or  item_event == PLAYER_CCFSBOXF  or  item_event == PLAYER_CCFSBOXG or  item_event == PLAYER_CCFSBOXH or  item_event == PLAYER_CCFSBOXI  then
		eleven = 1
	end	
	if eleven==1  then  
		count = 6		
	end	
--	local	Create_MultiItemAttr = { } 
--	Create_MultiItemAttr [0] = 20							--str几率
--	Create_MultiItemAttr [1] = 40							--dex几率							
--	Create_MultiItemAttr [2] = 65							--con几率
--	Create_MultiItemAttr [3] = 70							--agi几率
--	Create_MultiItemAttr [4] = 100							--sta几率
	
--	local ItemAttr_Record = { } 
--	ItemAttr_Record [0] = 0 
--	ItemAttr_Record [1] = 0 
--	ItemAttr_Record [2] = 0 
--	ItemAttr_Record [3] = 0 
--	ItemAttr_Record [4] = 0 
	if count == 1 then 
		energy = SetItemOneAttr ( item_type , item_lv , item_event , quality ) 
	elseif count == 2 then 
		energy = SetItemTwoAttr ( item_type , item_lv , item_event , quality ) 
	elseif count == 3 then 
		energy = SetItemThreeAttr ( item_type , item_lv , item_event , quality ) 
	elseif count == 4 then 
		energy = SetItemFourAttr ( item_type , item_lv , item_event , quality ) 
	elseif count == 5 then
		energy = SetItemFiveAttr ( item_type , item_lv , item_event , quality )
	elseif count == 6 then
		if item_type ==20 then
			energy = SetItemOneAttr ( item_type , item_lv , item_event , quality ) 
		elseif item_type ==22 then
			energy = SetItemTwoAttr ( item_type , item_lv , item_event , quality ) 	
		elseif item_type ==23 or item_type ==24 then
			energy = SetItemThreeAttr ( item_type , item_lv , item_event , quality ) 
		end
	end 
	energy = quality * 100 + energy 
--	LG("item_1", " energy = ",  energy) 
	Add_Item_Attr ( ITEMATTR_MAXENERGY ,  energy ) 


end 



function SetItemOneAttr ( item_type , item_lv , item_event , quality )  -- 添加一项随机属性
	local firstattr = 1						-- 起始编号
	local lastattr = 5						-- 终结编号
	local General = 0  
	for i = firstattr , lastattr , 1 do 
		General = ItemAttr_Rad [ i ] + General		
	end 
--	LG ( "setoneattr" , "general = " , General ) 
	local a = math.random ( 1, General )
--	LG ( "setoneattr" , "a = " , a ) 
	local b = 0
	local d = 0 
	local c = -1
	local star = 0
	for k = firstattr , lastattr , 1 do				-- 随机出添加的前缀编号

		d = ItemAttr_Rad [ k ] + b
--		LG ( "setoneattr" , "loop" , k , "  d = " , d ) 

		 if a <= d and a > b then
			c = k
--			LG ( "setoneattr" , "loop" , k , "  c = " , c ) 

		end 
		b = d 
	end
--	LG ( "setoneattr" , "end random" , "  c = " , c ) 
	if  item_event == PLAYER_CCFSBOXA or  item_event == PLAYER_CCFSBOXB or  item_event == PLAYER_CCFSBOXC  or  item_event == PLAYER_CCFSBOXD  or  item_event == PLAYER_CCFSBOXE or  item_event == PLAYER_CCFSBOXF  or  item_event == PLAYER_CCFSBOXG or  item_event == PLAYER_CCFSBOXH or  item_event == PLAYER_CCFSBOXI  then
		c = 6
		star = 1
	end
	if c == 1 then							-- 根据编号添加具体属性	
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 2 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event ) * 10 )  )
	end

	if c == 3 then
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 4 then
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 5 then
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end
	if c == -1 then
		CALCULATE_ATTRCALCULATE_LUA_000001 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000001")
		LG( "setitemattr_err" , CALCULATE_ATTRCALCULATE_LUA_000001)
		c = 0
	end
	if c == 6 and star ==1 then
		Add_Item_Attr(ITEMATTR_VAL_MXSP, quality * 10 ) 
	end
	return c 

end 


function SetItemTwoAttr ( item_type , item_lv , item_event , quality )	-- 添加两项随机属性
	local firstattr = 11						-- 起始编号
	local lastattr = 20						-- 终结编号
	local General = 0  
	for i = firstattr , lastattr , 1 do 
		General = ItemAttr_Rad [ i ] + General 
	end 
	local a = math.random ( 1, General )
	local b = 0
	local d = 0 
	local c = -1
	local star = 0
	for k = firstattr , lastattr , 1 do				-- 随机出添加的前缀编号

		d = ItemAttr_Rad [ k ] + b
--		LG ( "setoneattr" , "loop" , k , "  d = " , d ) 

		 if a <= d and a > b then
			c = k
		end 
		b = d 
	end
	if  item_event == PLAYER_CCFSBOXA or  item_event == PLAYER_CCFSBOXB or  item_event == PLAYER_CCFSBOXC  or  item_event == PLAYER_CCFSBOXD  or  item_event == PLAYER_CCFSBOXE or  item_event == PLAYER_CCFSBOXF  or  item_event == PLAYER_CCFSBOXG or  item_event == PLAYER_CCFSBOXH or  item_event == PLAYER_CCFSBOXI  then
		c = 21
		star = 1
	end
	if c == 11 then							-- 根据编号添加具体属性
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )	
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 12 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 13 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 14 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 15 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 16 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 17 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 18 then
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 19 then
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end

	if c == 20 then
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event ) * 10 ) )
	end
	if c == 21 and star ==1 then
		Add_Item_Attr(ITEMATTR_VAL_MXHP, quality * 10 ) 
		Add_Item_Attr(ITEMATTR_VAL_HREC,  quality * 10 )
	end
	if c == -1 then
		CALCULATE_ATTRCALCULATE_LUA_000002 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000002")
		LG( "setitemattr_err" , CALCULATE_ATTRCALCULATE_LUA_000002)
		c = 0
	end

	return c
	
end


function SetItemThreeAttr ( item_type , item_lv , item_event , quality )    -- 添加三项随机属性
	local firstattr = 50						    -- 起始编号
	local lastattr = 59						    -- 终结编号
	local General = 0  
	for i = firstattr , lastattr , 1 do 
		General = ItemAttr_Rad [ i ] + General 
	end 
	local a = math.random ( 1, General )
	local b = 0
	local d = 0 
	local c = -1
	local star = 0
	for k = firstattr , lastattr , 1 do				-- 随机出添加的前缀编号

		d = ItemAttr_Rad [ k ] + b
--		LG ( "setoneattr" , "loop" , k , "  d = " , d ) 

		 if a <= d and a > b then
			c = k
		end 
		b = d 
	end
	if  item_event == PLAYER_CCFSBOXA or  item_event == PLAYER_CCFSBOXB or  item_event == PLAYER_CCFSBOXC  or  item_event == PLAYER_CCFSBOXD  or  item_event == PLAYER_CCFSBOXE or  item_event == PLAYER_CCFSBOXF  or  item_event == PLAYER_CCFSBOXG or  item_event == PLAYER_CCFSBOXH or  item_event == PLAYER_CCFSBOXI  then
		if item_type==23 then
			c = 60
		elseif item_type==24 then
			c = 61
		end
		star = 1
	end
	if c == 50 then							    -- 根据随机出的编号添加属性
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 51 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 52 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 53 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 54 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 55 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 56 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 57 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 58 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 59 then
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end
	if c == 60 then
	       Add_Item_Attr(ITEMATTR_VAL_MXATK,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_MNATK,  quality * 10 ) 
	       Add_Item_Attr(ITEMATTR_VAL_CRT,  quality * 10 )
	end	
	if c == 61 then
		Add_Item_Attr(ITEMATTR_VAL_MSPD, quality * 10)
		Add_Item_Attr(ITEMATTR_VAL_MXSP, quality * 10 )
		Add_Item_Attr(ITEMATTR_VAL_SREC,  quality * 10 )
	end	
	if c == -1 then
		CALCULATE_ATTRCALCULATE_LUA_000003 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000003")
		LG( "setitemattr_err" , CALCULATE_ATTRCALCULATE_LUA_000003)
		c = 0
	end

	return c

end


function SetItemFourAttr ( item_type , item_lv , item_event , quality )    -- 添加四项随机属性
	local firstattr = 90						   -- 起始编号
	local lastattr = 94						   -- 终结编号
	local General = 0  
	for i = firstattr , lastattr , 1 do 
		General = ItemAttr_Rad [ i ] + General 
	end 
	local a = math.random ( 1, General )
	local b = 0				
	local d = 0 
	local c = -1
	for k = firstattr , lastattr , 1 do				-- 随机出添加的前缀编号

		d = ItemAttr_Rad [ k ] + b
--		LG ( "setoneattr" , "loop" , k , "  d = " , d ) 

		 if a <= d and a > b then
			c = k
		end 
		b = d 
	end

	if c == 90 then							   -- 根据随机出的编号添加属性
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 91 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 92 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 93 then
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end

	if c == 94 then
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	end
	
	if c == -1 then
		CALCULATE_ATTRCALCULATE_LUA_000004 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000004")
		LG( "setitemattr_err" , CALCULATE_ATTRCALCULATE_LUA_000004)
		c = 0
	end

	return c
end

function SetItemFiveAttr ( item_type , item_lv , item_event , quality )
	local c = 0	
		Add_Item_Attr(ITEMATTR_VAL_STR, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_DEX, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_CON, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_AGI, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
		Add_Item_Attr(ITEMATTR_VAL_STA, math.max ( 10 , SetItemQua ( item_event )* 10 ) )
	
	return c
end






function Shengji_Shuxingchengzhang( role )  --[[升级的属性成长及属性计算]]-- 
	--LuaPrint("Enter function Shengji_Shuxingchengzhang()  --[[升级的属性成长及属性计算]]-- ".."\n" ) 
	local lv = Lv ( role ) 
	if lv >= LV_LIMIT then 
		local year = os.date ( "%y" ) 
		local month = os.date ( "%m" ) 
		local day = os.date ( "%d" ) 
		local sep = "_"
		lgname = "lvup"..year..sep..month..sep..day
--		SystemNotice ( role , lgname ) 
		local Cha_name = GetChaDefaultName ( role ) 
--		SystemNotice ( role , Cha_name ) 

		LG ( lgname , Cha_name.." "..lv ) 
	end 
	
	BsAttrUpgrade( role ) 
	AttrRecheck(role) 
	hp = Mxhp_final(role) 
	sp = Mxsp_final(role) 
	SetCharaAttr(hp, role, ATTR_HP) 
	SetCharaAttr(sp, role, ATTR_SP) 
	--LuaPrint("Out function Shengji_Shuxingchengzhang()  --[[升级的属性成长及属性计算]]-- ".."\n" ) 
	
------------------------------------------------------
--        下面是Leo的师徒奖励脚本		    --Lee080716修改
------------------------------------------------------
	local ret = HasMaster(role)
	if ret == LUA_TRUE then
		AddMasterCredit(role, PlayerCredit[lv])		--给师傅加声望，声望值对应最上面的声望表
		if lv <= 40 then
			GiveItemX( role , 0 , 1128  , 1 , 4 )	--给角色1个微型努力增幅器
		end	
		if lv == 10 then				--10级奖励
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000005 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000005")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000005)
			GiveItemX( role , 0 , 1849 , 99 , 4 )		------给徒弟1组蛋糕
			--给师傅的奖励
			AddMasterCredit(role, 10)		--给师傅10点声望补偿值
			
			elseif lv == 20 then
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000006 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000006")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000006)
			GiveItemX( role , 0 , 3848 , 5 , 4 )	--给徒弟体力恢复剂
			GiveItemX( role , 0 , 4671 , 1 , 4 )  ----给徒弟杂耍者项链
			
			--给师傅的奖励
			AddMasterCredit(role, 20)		--给师傅20点声望补偿值
						
			elseif lv == 41 then
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000007 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000007")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000007)
			GiveItemX( role , 0 , 5626 , 5 , 4 )	--给徒弟超级体力恢复剂
			GiveItemX( role , 0 , 4696 , 1 , 4 )	--给徒弟流星之链

			--给师傅的奖励
			AddMasterCredit(role, 300)		--给师傅300点声望补偿值
						
			elseif lv == 60 then				--60级奖励
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000008 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000008")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000008)
			GiveItemX( role , 0 , 1107  , 1 , 4 )	--给徒弟戈壁指环
			GiveItemX( role , 0 , 2816  , 1 , 4 )	--给徒弟荣誉加点书

			--给师傅的奖励
			AddMasterCredit(role, 500)		--给师傅500点声望补偿值
			
			elseif lv == 70 then				--70级奖励
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000009 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000009")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000009)
			GiveItemX( role , 0 , 333  , 1 , 4 )	--给徒弟高级宝石兑换券奖励
			
			--给师傅的奖励
			AddMasterCredit(role, 800)		--给师傅800点声望补偿值
			
			elseif lv == 80 then				--80级奖励
			--给徒弟的奖励
			CALCULATE_ATTRCALCULATE_LUA_000010 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000010")
			SystemNotice(role,CALCULATE_ATTRCALCULATE_LUA_000010)
			GiveItemX( role , 0 , 2835  , 1 , 4 )	--给徒弟后死神的王冠

			--给师傅的奖励
			AddMasterCredit(role, 1300)		--给师傅1300点声望补偿值
					
		end
		
		
		-- if lv == 41 then				--出师
			--给徒弟的奖励
			-- SystemNotice(role,"恭喜您成功出师，现在你也可以收徒弟了哦")
			-- AddCreditX(role, 300)			--出师时给徒弟300点声望补偿值
			-- AddMoney(role , 0, 200000)		--徒弟奖励20W海盗币
			-- GiveItemX( role , 0 , 3345  , 1 , 4 )	--给徒弟各类暴竹一样1个
			-- GiveItemX( role , 0 , 3346  , 1 , 4 )
			-- GiveItemX( role , 0 , 3347  , 1 , 4 )
			-- GiveItemX( role , 0 , 0855  , 49 , 4 )	--给徒弟七七49个精灵硬币
			--...					--其他奖励
			--给师傅的奖励
			-- AddMasterCredit(role, 500)		--出师时给师傅1000点声望补偿值
			--...............			--其他奖励
		-- end
	end
end 

function CreatCha( role ) --[[创建角色]]-- 
	--LuaPrint("Enter function CreatCha(role) --[[创建角色]]--".."\n") 
	local attr_ap = Attr_ap( role ) + 4 --[[＋5点自由分配点数]]--
	SetCharaAttr( attr_ap, role, ATTR_AP ) 
	AttrRecheck(role) 
	hp = GetChaAttr( role, ATTR_MXHP ) 
	sp = GetChaAttr( role, ATTR_MXSP ) 
	SetCharaAttr( hp, role, ATTR_HP ) 
	SetCharaAttr( sp, role, ATTR_SP ) 
	CreatChaSkill ( role ) 
	--LuaPrint("Out function CreatCha(role) --[[创建角色]]--".."\n") 
end 


function AttrRecheck( role ) --[[属性重新计算]]--
	--LuaPrint("Enter function AttrRecheck() --[[属性重新计算]]--") 
	local k = ChaIsBoat ( role ) 
	if k == 1 then 
		local cha_role = GetMainCha ( role ) 
		ShipAttrRecheck ( cha_role , role ) 
		return 
	end 
	BsAttrSet(role) 
	ExAttrCheck(role) 
	ExAttrSet(role) 
	--LuaPrint("Out function AttrRecheck() --[[属性重新计算]]--") 
end 


function BsAttrUpgrade( role ) --[[基础属性升级成长]]--
	--LuaPrint("Enter function BsAttrUpgrade() --[[基础属性升级成长]]--".."\n" ) 

   	--LG("ChaAttr", "Enter function ExAttrCheck()  --[[基本扩展属性计算]]--","\n" ) 
	local job = GetChaAttr( role, ATTR_JOB) --不同职业采用不同的属性成长率
	--LuaPrint("角色职业类型 = "..job) 
	--LuaPrint("\n") 
	local job_check = CheckJobLegal ( job ) 
	if job_check == 0 then 
		--LuaPrint("非法职业类型".."\n") 
		--LG("ChaAttr","非法职业类型 job = ", job , "\n" ) 
		return 
	end 

	local ap_extre = 0 
	local tp_extre = 0 

	local attr_tp = Attr_tp( role )  
	local attr_ap = Attr_ap( role ) 

	local bsstr = BaseStr(role) + 0  --[[基本str每级加1]]--
	SetCharaAttr( bsstr, role, ATTR_BSTR ) --[[设置基本str]]--

	local bsdex = BaseDex( role ) + 0 --[[基本dex每级加1]]--
	SetCharaAttr( bsdex, role, ATTR_BDEX ) --[[设置基本dex]]--

	local bscon = BaseCon( role ) + 0 --[[基本con每级加1]]--
	SetCharaAttr( bscon, role, ATTR_BCON ) --[[设置基本con]]--

	local bsagi = BaseAgi( role ) + 0 --[[基本agi每级加1]]--
	SetCharaAttr( bsagi, role, ATTR_BAGI ) --[[设置基本agi]]-- 

	local bssta = BaseSta(role) + 0 --[[基本sta每级加1]]--
	SetCharaAttr( bssta, role, ATTR_BSTA ) --[[设置基本sta]]--

	local bsluk = BaseLuk( role ) + 0 --[[基本luk每级加1]]--
	SetCharaAttr( bsluk, role, ATTR_BLUK ) --[[设置基本luk]]--



	
	local lv = GetChaAttr ( role , ATTR_LV ) 
	
	if ( math.floor ( ( lv ) / 10 )  - math.floor ( ( lv - 1 ) / 10 ) ) == 1 then 
		ap_extre = 5 
	else 
		ap_extre = 1 
	end 

	if lv >= 60 then 
		ap_extre = ap_extre + 1 
	end 

	attr_ap = attr_ap + ap_extre 
	SetCharaAttr( attr_ap, role, ATTR_AP ) 
	
	if lv > 9 then 
		tp_extre = 1 
	end 

	if lv >= 65 then 
		if ( math.floor ( ( lv ) / 5 )  - math.floor ( ( lv - 1 ) / 5 ) ) == 1 then 
			tp_extre = 2 
		else 
			tp_extre = 1 
		end 
	end 

	attr_tp = attr_tp + tp_extre --[[+1点技能点数]]--
	SetCharaAttr( attr_tp, role, ATTR_TP ) 
	 
	--LuaPrint("Out function BsAttrUpgrade() --[[基础属性升级成长]]--".."\n" ) 
end 


function BsAttrSet( role ) --[[基础属性赋值]]--
	--LuaPrint("Enter function BsAttrSet() --[[基础属性赋值]]--".."\n") 
	local str_final = Str_final( role ) --[[计算最终str]]--
	SetCharaAttr( str_final, role, ATTR_STR ) --[[赋值最终str]]--

	local dex_final = Dex_final( role ) --[[计算最终dex]]--
	SetCharaAttr( dex_final, role, ATTR_DEX ) --[[赋值最终dex]]--

	local agi_final = Agi_final( role ) --[[计算最终agi]]--
	SetCharaAttr( agi_final, role, ATTR_AGI ) --[[赋值最终agi]]--

	local con_final = Con_final( role ) --[[计算最终con]]--
	SetCharaAttr( con_final, role, ATTR_CON ) --[[赋值最终con]]--

	local sta_final = Sta_final( role ) --[[计算最终sta]]--
	SetCharaAttr( sta_final, role, ATTR_STA ) --[[赋值最终sta]]--

	local luk_final = Luk_final( role ) --[[计算最终luk]]--
	SetCharaAttr( luk_final, role, ATTR_LUK ) --[[赋值最终luk]]-- 

	--LuaPrint("Out function BsAttrSet() --[[基础属性赋值]]--".."\n") 
end 

function ExAttrCheck(role)  --[[基本扩展属性计算]]--
	--LuaPrint("Enter function ExAttrCheck()  --[[基本扩展属性计算]]--".."\n") 
	--LG("ChaAttr", "Enter function ExAttrCheck()  --[[基本扩展属性计算]]--","\n" ) 
	local job = GetChaAttr(role, ATTR_JOB) --不同职业采用不同的属性成长率
	--LuaPrint("角色职业类型 = "..job) 
	--LuaPrint("\n") 
	local job_check = CheckJobLegal (job) 
	if job_check == 0 then 
		--LuaPrint("非法职业类型".."\n") 
		--LG("ChaAttr","非法职业类型 job = ", job , "\n" ) 
		return 
	end 
   
	--LG("ChaAttr", "Mxhp_con_rad[job] , Mxhp_lv_rad[job], Mxhp_bs = ", Mxhp_con_rad[job], Mxhp_lv_rad[job], Mxhp_bs[job],"\n" ) 
	--LG("ChaAttr", "Mxsp_sta_rad[job] ,Mxsp_con_rad[job], Mxsp_lv = ", Mxhp_con_rad[job], Mxhp_lv_rad[job], Mxhp_bs[job] ,"\n") 
	--LG("ChaAttr", "Mnatk_str_rad[job] = ", Mnatk_str_rad[job] ,"\n") 
	--LG("ChaAttr", "Mxatk_str_rad[job] = ", Mxatk_str_rad[job] ,"\n") 
	--LG("ChaAttr", "Def_dex_rad[job] =  ",Def_dex_rad[job] ,"\n") 
	--LG("ChaAttr", "Hit_dex_rad[job] ,Hit_lv_rad[job], Hit_min[job] = ", Hit_dex_rad[job], Hit_lv_rad[job], Hit_min[job] ,"\n") 
	--LG("ChaAttr", "Flee_agi_rad[job] ,Flee_lv_rad[job], Flee_min[job] = ", Flee_agi_rad[job], Flee_lv_rad[job], Flee_min[job] ,"\n") 
	--LG("ChaAttr", "Mf_luk_rad[job] = ", Mf_luk_rad[job],"\n" ) 
	--LG("ChaAttr", "Crt_luk_rad[job] , Crt_min[job], Crt_max[job] = ", Crt_luk_rad[job], Crt_min[job], Crt_max[job],"\n" ) 
	--LG("ChaAttr", "Hrec_mxhp_rad[job] ,Hrec_lv_rad[job], Hrec_min[job] = ", Hrec_mxhp_rad[job], Hrec_lv_rad[job], Hrec_min[job],"\n" ) 
	--LG("ChaAttr", "Srec_mxSp_rad[job] ,Srec_lv_rad[job], Srec_min[job] = ", Srec_mxsp_rad[job], Srec_lv_rad[job],Srec_min[job] ,"\n") 
	--LG("ChaAttr", "Aspd_bsrad[job] ,Aspd_agi_rad[job], Aspd_min[job] = ", Aspd_bsrad[job], Aspd_agi_rad[job], Aspd_min[job] ,"\n") 

	local mxhp	= math.floor(Con(role)*3 * Mxhp_con_rad1[job] + Mxhp_con_rad2[job] * math.pow( math.floor(Con(role)*3/20 ),  2) +Lv(role) * Mxhp_lv_rad[job] + 40)	--[[计算基本mxhp]]--
	local mxsp	= math.floor(Sta(role)*3 * Mxsp_sta_rad1[job] + Mxsp_sta_rad2[job] * math.pow( math.floor(Sta(role)*3/20), 2) +Lv(role) * Mxsp_lv_rad[job] + 5)			--[[计算基本mxsp]]--
	local mnatk	 = math.floor( 0+ Str(role) * Mnatk_str_rad1[job] + Dex(role) * Mnatk_dex_rad1[job] + Mnatk_str_rad2[job] * math.pow(math.floor( Str(role)*4/20), 2 ) + Mnatk_dex_rad2[job] * math.pow(math.floor( Dex(role)*4/20), 2 ) )											--[[计算基本mnatk]]--
	local mxatk	= math.floor( 0+ Str(role) * Mxatk_str_rad1[job] + Dex(role) * Mxatk_dex_rad1[job] + Mxatk_str_rad2[job] * math.pow(math.floor( Str(role)*4/20), 2 ) + Mxatk_dex_rad2[job] * math.pow(math.floor( Dex(role)*4/20), 2 ) )											--[[计算基本mxatk]]--
	local def = math.floor( Con(role)* 5 * Def_con_rad1[job]	+ Def_con_rad2[job] * math.floor( math.pow( Con(role) * 3 /20, 2) ) )											--[[计算基本def]]--
	local hit = math.floor( Dex(role) * Hit_dex_rad1[job])	+ Lv(role) * 2 + 5		--[[计算基本hit]]--
	local flee = math.floor( Agi(role) * Flee_agi_rad1[job] ) + Lv(role) * 2 + 5			--[[计算基本flee]]--
	local mf = 100 +  math.floor( Luk(role)*3 * Mf_luk_rad[job] )														--[[计算基本mf]]--
	local crt =11 +  math.floor( Luk(role)*3 * Crt_luk_rad[job] )														--[[计算基本crt]]--
	local hrec = math.max(math.max ( 2 * mxhp * Hrec_bsmxhp_rad[job] + Con(role)*3 * Hrec_con_rad[job] , 1) ,0) 						--[[计算基本hrec]]--
	local srec = math.max((mxsp * Srec_bsmxsp_rad[job] + Sta(role)*3 * Srec_sta_rad[job])/2 , 1 )						--[[计算基本srec]]--
	local aspd = math.floor ( 100000/ (math.min ( math.floor( 65 +  Agi(role) * Aspd_agi_rad[job] ) , 300 ) ) )											--[[计算基本aspd]]--
	
	SetCharaAttr( mxhp, role, ATTR_BMXHP )												--[[赋值基本HP上限]]--
	if mxhp <= 0 then 
		CALCULATE_ATTRCALCULATE_LUA_000011 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000011")
		CALCULATE_ATTRCALCULATE_LUA_000012 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000012")
		LG("ChaAttr_err" , CALCULATE_ATTRCALCULATE_LUA_000012 , GetChaName(role) , CALCULATE_ATTRCALCULATE_LUA_000011 )  
		LG("ChaAttr_err", "mxhp = ", mxhp,"    con = ", Con(role) , "	lv = " , Lv(role) ) 
	end 
	SetCharaAttr(mxsp, role, ATTR_BMXSP )												--[[赋值基本SP上限]]--
	--LG("ChaAttr", "mxsp = ", mxsp,"\n") 
	SetCharaAttr(mnatk, role, ATTR_BMNATK )											--[[赋值基本最小伤害力]]--
	--LG("ChaAttr", "mnatk = ", mnatk,"\n") 
	SetCharaAttr(mxatk, role, ATTR_BMXATK )												--[[赋值基本最大伤害力]]--
	--LG("ChaAttr", "mxatk = ", mxatk,"\n") 
	SetCharaAttr(def, role, ATTR_BDEF )													--[[赋值基本防御力]]--
	--LG("ChaAttr", "def= ", def,"\n") 
	SetCharaAttr(hit, role, ATTR_BHIT)													--[[赋值基本命中率]]--
	--LG("ChaAttr", "hit= ", hit,"\n") 
	SetCharaAttr(flee, role, ATTR_BFLEE)												--[[赋值基本闪避率]]--
	--LG("ChaAttr", "flee= ",flee,"\n") 
	SetCharaAttr(mf, role, ATTR_BMF)													--[[赋值基本MF率]]--
	--LG("ChaAttr", "mf= ", mf,"\n") 
	SetCharaAttr(crt, role, ATTR_BCRT)													--[[赋值基本暴击率]]--
	--LG("ChaAttr", "crt= ", crt,"\n") 
	SetCharaAttr(hrec, role, ATTR_BHREC)												--[[赋值基本HP回复速度]]--
	if hrec<= 0 then 
		CALCULATE_ATTRCALCULATE_LUA_000013 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000013")
		CALCULATE_ATTRCALCULATE_LUA_000012 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000012")
		LG("ChaAttr_err" , CALCULATE_ATTRCALCULATE_LUA_000012 , GetChaName(role) , CALCULATE_ATTRCALCULATE_LUA_000013 )  
		LG("ChaAttr_err", "hrec = ", hrec, "    mxhp = ", mxhp , "	con = " , Con(role) ) 
	end 
	--LG("ChaAttr", "hrec= ", hrec,"\n") 
	SetCharaAttr(srec, role, ATTR_BSREC)												--[[赋值基本SP回复速度]]--
	if srec<= 0 then 
		CALCULATE_ATTRCALCULATE_LUA_000014 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000014")
		CALCULATE_ATTRCALCULATE_LUA_000012 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000012")
		LG("ChaAttr_err" , CALCULATE_ATTRCALCULATE_LUA_000012 , GetChaName(role) , CALCULATE_ATTRCALCULATE_LUA_000014 )  
		LG("ChaAttr_err", "srec = ", srec, "    mxsp = ", mxsp , "	sta = " , Sta(role) ) 
	end 

	--LG("ChaAttr", "srec= ", srec,"\n") 
	SetCharaAttr(aspd, role, ATTR_BASPD) 												--[[赋值基本攻击速度]]--
	--LuaPrint("Out function ExAttrCheck()  --[[基本扩展属性计算]]--".."\n") 
	--LG("ChaAttr", "Out function ExAttrCheck()  --[[基本扩展属性计算]]--" ,"\n") 
end 

function ExAttrSet(role) --[[赋值扩展属性]]--
	--LuaPrint("Enter function ExAttrSet() --[[赋值扩展属性]]--") 
	local mxhp_final= Mxhp_final(role) --[[计算最终mxhp]]--
	SetCharaAttr(mxhp_final, role, ATTR_MXHP) --[[赋值最终最终mxhp]]--

	local mxsp_final = Mxsp_final(role) --[[计算最终mxsp]]--
	SetCharaAttr(mxsp_final, role, ATTR_MXSP) --[[赋值最终最终mxsp]]--

	local mnatk_final = Mnatk_final(role) --[[计算最终mnatk]]--
	SetCharaAttr(mnatk_final, role, ATTR_MNATK) --[[赋值最终最终mnatk]]--

	local mxatk_final = Mxatk_final(role) --[[计算最终mxatk]]--
	SetCharaAttr(mxatk_final, role, ATTR_MXATK) --[[赋值最终最终mxatk]]--

	local def_final = Def_final(role) --[[计算最终def]]--
	SetCharaAttr(def_final, role, ATTR_DEF ) --[[赋值最终最终def]]--

	local resist_final = Resist_final(role) --[[计算最终resist]]--
	SetCharaAttr( resist_final, role, ATTR_PDEF) 

	local hit_final = Hit_final(role) --[[计算最终hit]]--
	SetCharaAttr(hit_final, role, ATTR_HIT ) --[[赋值最终最终hit]]--

	local flee_final = Flee_final(role) --[[计算最终flee]]--
	SetCharaAttr(flee_final, role, ATTR_FLEE) --[[赋值最终最终flee]]--

	local mf_final = Mf_final(role) --[[计算最终mf]]--
	SetCharaAttr(mf_final, role, ATTR_MF ) --[[赋值最终最终mf]]--

	local crt_final = Crt_final(role) --[[计算最终crt]]--
	SetCharaAttr(crt_final, role, ATTR_CRT ) --[[赋值最终最终crt]]--

	local hrec_final = Hrec_final(role) --[[计算最终hrec]]--
	SetCharaAttr(hrec_final, role, ATTR_HREC ) --[[赋值最终最终hrec]]--

	local srec_final = Srec_final(role) --[[计算最终srec]]--
	SetCharaAttr(srec_final, role, ATTR_SREC ) --[[赋值最终最终srec]]--

	local aspd_final = math.floor ( 100000 / ( Aspd_final(role)  ) ) --[[计算最终aspd]]--
	SetCharaAttr(aspd_final, role, ATTR_ASPD ) --[[赋值最终最终aspd]]--

	local adis_final = Adis_final(role) --[[计算最终adis]]--
	SetCharaAttr(adis_final, role, ATTR_ADIS ) --[[赋值最终最终adis]]--

	local mspd_final = Mspd_final(role) --[[计算最终mspd]]--
	SetCharaAttr(mspd_final, role, ATTR_MSPD ) --[[赋值最终最终mspd]]--
	--LuaPrint("Out function ExAttrSet() --[[赋值扩展属性]]--") 
end 

function ShipAttrRecheck ( cha_role , ship_role )									--船只属性设置
	Ship_ExAttrCheck ( cha_role , ship_role ) 
	Ship_ExAttrSet ( cha_role , ship_role ) 
end 

function Ship_ExAttrCheck ( cha_role , ship_role ) 

	if ship_role == nil then 
		CALCULATE_ATTRCALCULATE_LUA_000015 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000015")
		LG("luascript_err" , CALCULATE_ATTRCALCULATE_LUA_000015 ) 
		return 0 
	end 
	
	if cha_role == nil then 
		CALCULATE_ATTRCALCULATE_LUA_000016 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000016")
		LG ( "luascript_err" , CALCULATE_ATTRCALCULATE_LUA_000016 ) 
		return 
--		ship_mnatk_final		=	Ship_BSMnatk ( ship_role )						--船只基本最小攻击
--		ship_mxatk_final		=	Ship_BSMxatk ( ship_role )						--船只基本最大攻击
--		ship_adis_final		=	Ship_BSAdis ( ship_role )						--船只基本攻击距离
--		ship_cspd_final		=	Ship_BSCspd ( ship_role )						--炮弹基本飞行速度
--		ship_aspd_final		=	Ship_BSAspd ( ship_role )						--炮弹基本攻击间隔
--		ship_crange_final		=	Ship_BSCrange ( ship_role ) 						--炮弹基本爆炸范围
--		ship_def_final		=	Ship_BSDef ( ship_role ) 						--船只基本防御
--		ship_resist_final		=	Ship_BSResist ( ship_role ) 						--船只基本抵抗
--		ship_mxhp_final		=	Ship_BSMxhp ( ship_role ) 						--船只基本最大耐久
--		ship_hrec_final		=	Ship_BSHrec ( ship_role ) 						--船只基本耐久回复速度
--		ship_srec_final		=	Ship_BSSrec ( ship_role ) 						--船只基本补给消耗速度
--		ship_mspd_final		=	Ship_BSMspd ( ship_role ) 						--船只基本移动速度
--		ship_mxsp_final		=	Ship_BSMxsp ( ship_role ) 						--船只基本最大补给值
	else 
		lv = GetChaAttr ( ship_role , ATTR_LV ) 
		job = GetChaAttr ( cha_role , ATTR_JOB ) 
		sta = GetChaAttr ( cha_role , ATTR_STA ) 
		ship_mnatk_final		=	Boat_plus_MNATk ( lv , Ship_Mnatk_final ( cha_role , ship_role ) )						--船只最终最小攻击
		ship_mxatk_final		=	Boat_plus_MXATk ( lv , Ship_Mxatk_final ( cha_role , ship_role ) )						--船只最终最大攻击
		ship_adis_final		=	Ship_Adis_final ( cha_role , ship_role )						--船只最终攻击距离
		ship_cspd_final		=	Ship_Cspd_final ( cha_role , ship_role )						--炮弹最终飞行速度
		ship_aspd_final		=	math.floor ( 100000 / Ship_Aspd_final ( cha_role , ship_role ) ) 		--炮弹最终攻击间隔
		ship_crange_final		=	Ship_Crange_final ( cha_role , ship_role )					--炮弹最终爆炸范围
		ship_def_final		=	Boat_plus_def ( lv , Ship_Def_final ( cha_role , ship_role )	) 		--船只最终防御
		ship_resist_final		=	Ship_Resist_final ( cha_role , ship_role )						--船只最终抵抗
		ship_mxhp_final		=	Boat_plus_Mxhp ( lv , Ship_Mxhp_final ( cha_role , ship_role ) ) 		--船只最终最大耐久
		ship_hrec_final		=	Ship_Hrec_final ( cha_role , ship_role )						--船只最终耐久回复速度
		ship_srec_final		=	Ship_Srec_final ( cha_role , ship_role )						--船只最终补给消耗速度
		ship_mspd_final		=	Boat_plus_Mspd ( lv , Ship_Mspd_final ( cha_role , ship_role ) )  	--船只最终移动速度
		ship_mxsp_final		=	Ship_Mxsp_final ( cha_role , ship_role )						--船只最终最大补给值
	end
	--SystemNotice( cha_role , "最小攻击力"..ship_mnatk_final)
	--ship_mnatk_final		=	Boat_plus_MNATk ( lv , ship_mnatk_final)
	--ship_mxatk_final		=	Boat_plus_MXATk ( lv , ship_mxatk_final)
	--ship_def_fina		=	Boat_plus_DEF ( lv , ship_def_final)
	--ship_mxhp_final		=	Boat_plus_Mxhp ( lv , ship_mxhp_final)
	--ship_mspd_final		=	Boat_plus_Mspd ( lv , ship_mspd_final)
--	SetCharaAttr(lv, ship_role, ATTR_LV )												--[[赋值船只lv]]--
	SetCharaAttr(job, ship_role, ATTR_JOB )											--[[赋值船只职业]]--
	SetCharaAttr(sta, ship_role, ATTR_STA )											--[[赋值船只精神]]--
	SetCharaAttr(ship_mnatk_final, ship_role, ATTR_MNATK )									--[[赋值最终mnatk]]--
	SetCharaAttr(ship_mxatk_final, ship_role, ATTR_MXATK )									--[[赋值最终mxatk]]--
	SetCharaAttr(ship_adis_final, ship_role, ATTR_ADIS )									--[[赋值最终adis]]--
	SetCharaAttr(ship_cspd_final, ship_role, ATTR_BOAT_CSPD )								--[[赋值最终船只炮弹飞行速度]]--
	SetCharaAttr(ship_aspd_final, ship_role, ATTR_ASPD )									--[[赋值最终船只攻击速度]]--
	SetCharaAttr(ship_crange_final, ship_role, ATTR_BOAT_CRANGE )								--[[赋值最终船只炮弹爆炸范围]]--
	SetCharaAttr(ship_def_final, ship_role, ATTR_DEF )										--[[赋值最终船只防御]]--
	SetCharaAttr(ship_resist_final, ship_role, ATTR_PDEF )									--[[赋值最终船只抵抗]]--
	SetCharaAttr(ship_mxhp_final, ship_role, ATTR_MXHP )									--[[赋值最终船只最大耐久]]--
	SetCharaAttr(ship_hrec_final, ship_role, ATTR_HREC )									--[[赋值最终船只耐久回复速度]]--
	SetCharaAttr(ship_srec_final, ship_role, ATTR_SREC )									--[[赋值最终船只补给消耗速度]]--
	SetCharaAttr(ship_mspd_final, ship_role, ATTR_MSPD )									--[[赋值最终船只移动速度]]--
	SetCharaAttr(ship_mxsp_final, ship_role, ATTR_MXSP )									--[[赋值最终船只最大补给值]]--

	
	
	SetCharaAttr( 1 , ship_role , ATTR_FLEE )											--船只不具备闪避属性，始终初始化为1 

end 


function	Ship_ExAttrSet ( cha_role , ship_role ) 
end 


function Lifelv_Up ( cha_role )								--生活等级提升
	local life_ap = GetChaAttr ( cha_role , ATTR_LIFETP ) 
	life_ap = life_ap + 1 
	SetCharaAttr( life_ap , cha_role , ATTR_LIFETP ) 
end 

function Saillv_Up ( cha_role )								--航海等级提升

end 



function Resume ( role ) 
	local role_type = ChaIsBoat ( role ) 
	local srec = GetChaAttr ( role , ATTR_SREC ) 
	local sp = GetChaAttr ( role , ATTR_SP ) 
	local mxsp = GetChaAttr ( role , ATTR_MXSP ) 
	local hrec = GetChaAttr ( role , ATTR_HREC ) 
	if hrec < 0 then 
			CALCULATE_ATTRCALCULATE_LUA_000017 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000017")
			LG ( "resume_err" , "role = " , GetChaName (role) , CALCULATE_ATTRCALCULATE_LUA_000017 ) 
			LG ( "resume_err" , "role_hrec_statec = " , GetChaAttr ( role , ATTR_STATEC_HREC) , "role_hrec_statev = ", GetChaAttr ( role , ATTR_STATEV_HREC)  ) 
			CALCULATE_ATTRCALCULATE_LUA_000018 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000018")
			LG ( "luascript_err" , CALCULATE_ATTRCALCULATE_LUA_000018 ) 
			return 
	end 
	local hp = GetChaAttr ( role , ATTR_HP ) 
	local mxhp = GetChaAttr ( role , ATTR_MXHP ) 

	if role_type == 1 then									--船只resume
		--Rem_State_NOSEA ( role ) 
--	SystemNotice (role,"enter 船只回复")
		if hp <= 0 then 
			CALCULATE_ATTRCALCULATE_LUA_000019 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000019")
			LG ( "luascript_err" , CALCULATE_ATTRCALCULATE_LUA_000019 ) 
			return 
		end 
		cha_role = GetMainCha ( role ) 
		if sp <= 0 then 
			CALCULATE_ATTRCALCULATE_LUA_000020 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000020")
			BickerNotice ( role , CALCULATE_ATTRCALCULATE_LUA_000020 ) 
			hrec = hrec - 0.025 * mxhp 
			srec = 0 
		end 
		sp = math.max ( 0 , sp - srec ) 
		hp = math.min ( mxhp , hp + hrec ) 
		local ship_lv = GetChaAttr ( role , ATTR_LV ) 
		local ship_exp = GetChaAttr ( role , ATTR_CEXP ) 
		local boatexpup_count = GetBoatCtrlTick ( role ) 
		if ( boatexpup_count - math.floor ( boatexpup_count / 5 ) * 5  )  ==  4 then 
			a = 1 
		else	
			a = 0 
		end 
		boatexpup_count = boatexpup_count + 1 
		if boatexpup_count >= 500 then 
			boatexpup_count = 0 
		end 
		SetBoatCtrlTick ( role , boatexpup_count ) 
--		SetAttrChangeFlag( role)

		if ship_lv <= 30 and ship_exp <= 1000  then 
--			SystemNotice (role,"enter 船只expup")
			if a == 1 then 
	--			SystemNotice (role,"ship_expadd = " ..ship_expadd)
	--			SystemNotice (role,"ship_exp = " ..ship_exp)
				local ship_expadd = math.floor ( math.random ( 1, 3 )  + math.max ( 0 , ( 2 - ship_lv /10 ) )  ) 
				ship_exp = ship_exp + ship_expadd
	--			SystemNotice (role,"after resume ship_exp = " ..ship_exp)
				CALCULATE_ATTRCALCULATE_LUA_000021 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000021")
				SystemNotice (role,CALCULATE_ATTRCALCULATE_LUA_000021 ..ship_expadd)
				SetCharaAttr (ship_exp ,role , ATTR_CEXP ) 
	--			ship_exp = GetChaAttr ( role , ATTR_CEXP ) 
	--			SystemNotice (role,"1 after resume ship_exp = " ..ship_exp)
			end 
		end 
--		cha_hp = math.min ( Mxhp ( cha_role ) , Hp ( cha_role ) + Hrec ( cha_role ) ) 
		cha_sp = math.min ( Mxsp ( cha_role ) , Sp ( cha_role ) + Srec ( cha_role ) ) 
		SetCharaAttr ( sp , role , ATTR_SP ) 
		SetCharaAttr ( hp , role , ATTR_HP ) 
--		SetCharaAttr ( cha_hp , cha_role , ATTR_HP ) 
		SetCharaAttr ( cha_sp , cha_role , ATTR_SP ) 
--		SyncBoat ( role, 4 )
	else 
		if hp <= 0 then 
			CALCULATE_ATTRCALCULATE_LUA_000019 = GetResString("CALCULATE_ATTRCALCULATE_LUA_000019")
			LG ( "luascript_err" , CALCULATE_ATTRCALCULATE_LUA_000019 ) 
			return 
		end 
		local Elf_SkillHpResume = 0
		local Elf_SkillSpResume = 0
			
		if mxhp ~= hp then
			Elf_SkillHpResume = ElfSkill_HpResume ( role )
		end
	
		if mxsp ~= sp then
			Elf_SkillSpResume = ElfSkill_SpResume ( role )
		end
		
		hrec = hrec + Elf_SkillHpResume
		srec = srec + Elf_SkillSpResume
		sp = math.min ( mxsp , sp + srec ) 
		hp = math.min ( mxhp , hp + hrec ) 
		SetCharaAttr ( hp , role , ATTR_HP ) 
		SetCharaAttr ( sp , role , ATTR_SP )
	end 
end 
