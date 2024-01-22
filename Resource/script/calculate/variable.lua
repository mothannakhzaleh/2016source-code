--------------------------------------------------------------------------
--									--
--									--
--				variable.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Variable.lua" )


NOZB=-2
ZBEXP=1
ZBFORGE=2
ZBWABAO=3
ZBMOVE=4
ZBHP=5
ZBSP=6
ZBMOREEXP=7
ZBXIULI=8
ZBJXXH=9
ZBDEAD=0
ZBNSDHAS=11
ZBNSDREM=12
ZBFORGEREM=13

XmasMonsterNum1 = 0
XmasMonsterNum2 = 0
XmasMonsterNum3 = 0
XmasMonsterNum4 = 0
XmasMonsterNum5 = 0

CheckBossLifeTime1 = 0
CheckBossLifeTime2 = 0
CheckBossLifeTime3 = 0
CheckBossLifeTime4 = 0
CheckBossLifeTime5 = 0

CheckBoss1Dead = 1
CheckBoss2Dead = 1
CheckBoss3Dead = 1
CheckBoss4Dead = 1
CheckBoss5Dead = 1

monster1 = 0
monster2 = 0
monster3 = 0
monster4 = 0
monster5 = 0

L4MAPMonster = {}
L4MAPMonster[1] = 0
L4MAPMonster[2] = 0
L4MAPMonster[3] = 0
L4MAPMonster[4] = 0
L4MAPMonster[5] = 0
L4MAPMonster[6] = 0
L4MAPMonster[7] = 0

AddPanduan = {}
AddPanduan[1] = 0
AddPanduan[2] = 0
AddPanduan[3] = 0
AddPanduan[4] = 0
AddPanduan[5] = 0
AddPanduan[6] = 0
AddPanduan[7] = 0
AddPanduan[8] = 0
AddPanduan[9] = 0
AddPanduan[10] = 0

----七夕喜鹊记数
XiqueNum = 0
-----万圣南瓜头记数
NanguaNum = 0
----万圣纪念卡牌计数
WanShengKaPai = 0

--中秋吃秋香月饼大赛记数
now_time = {}
last_time = {}
ran_time = {}
MoonChampion = 10

--Wizard Coin Counting

PlayUseBox1 = {}
PlayUseBox2 = {}
PlayUseBox3 = {}

--彩票时间初始化

TimeNum=0

--怪物攻城状态
GHYG_ACTIVETY_garner=0
-- GHYG_ACTIVETY_magicsea=0
-- GHYG_ACTIVETY_darkblue=0

BBBB = {}		--Following array of monsters

MFRADIX=100 		--mf Base rate
CRTRADIX=100 		--Crt Base rate

TestGuildLv = 0
ReadyToFight = 0
--ATKER=0 		--Attacker
--DEFER=1 		--By The Attacker
--SPLASHER = 2 		--By Sputtering
--SKILLPOS = 3 		--The Skills Cast-Point
--USE_TRAN = 1 		--Using The Call
--UNUSE_TRAN = 2 	--Stop Using The Call
--ATK_PHASE = 1 	--Attack Phase
--DEF_PHASE = 2 	--By The Attack Phase
ATTR_RADIX = 1000	--Properties Coefficient Ratio
AREA_SAFE = 2		--Safety Zone Attribute Number
EXP_RAID = 10		--Experience Rate ( default = 1 )
MF_RAID = 7		--Drop Rate ( default = 1 )
Resource_RAID_ADJUST= 7 --Resource Drop Rate ( default = 1 )
TeamExp_RAID = 15	--Team Experience Rate (TeamExp_Increas = 0.25 * TeamExp_RAID) ( default = 1 )
ELEEXP_GETRAD = 500	--Pet Growth Rate ( default = 1 )
LV_LIMIT = 50		--Limited Access To Track Level
A_B_C = 8	        --Maximum Number Of Calls Only
Money_all = 1000000	--Argent City Into Total Chaos Fighting Money
How_Many_Active = 0	--he Survival Of The Map Off The Number Of Players
Every_5_minute = 0      --Program Execution Times Every 5 Minutes
NOWTIME_TE=0
NOWTIME_YI=0
NOWTIME_HEI=0
JINISI_TIME=2100
CHURCHSTAR_FLAG=0

--Leo The Exchange Of Information Registerer

ChangeItemList = {}
ChangeItemList[	1	]=	{	2608	,	100	,	2682	,	1	}
ChangeItemList[	2	]=	{	2609	,	100	,	2683	,	1	}
ChangeItemList[	3	]=	{	2609	,	1000	,	2684	,	1	}
ChangeItemList[	4	]=	{	2608	,	100	,	2692	,	1	}
ChangeItemList[	5	]=	{	2609	,	100	,	2693	,	1	}
ChangeItemList[	6	]=	{	2609	,	1000	,	2694	,	1	}
ChangeItemList[	7	]=	{	2608	,	100	,	2702	,	1	}
ChangeItemList[	8	]=	{	2609	,	100	,	2703	,	1	}
ChangeItemList[	9	]=	{	2609	,	1000	,	2704	,	1	}
ChangeItemList[	10	]=	{	2608	,	100	,	2712	,	1	}
ChangeItemList[	11	]=	{	2609	,	100	,	2713	,	1	}
ChangeItemList[	12	]=	{	2609	,	1000	,	2714	,	1	}
ChangeItemList[	13	]=	{	3989	,	99	,	3999	,	20	}
ChangeItemList[	14	]=	{	3990	,	99	,	4000	,	20	}
ChangeItemList[	15	]=	{	3991	,	99	,	4001	,	20	}
ChangeItemList[	16	]=	{	3992	,	99	,	4002	,	20	}
ChangeItemList[	17	]=	{	3993	,	99	,	4003	,	20	}
ChangeItemList[	18	]=	{	3994	,	99	,	4004	,	20	}
ChangeItemList[	19	]=	{	3995	,	99	,	4005	,	20	}
ChangeItemList[	20	]=	{	3996	,	99	,	4006	,	20	}
ChangeItemList[	21	]=	{	3997	,	99	,	4007	,	20	}
ChangeItemList[	22	]=	{	3998	,	99	,	4008	,	20	}
ChangeItemList[	23	]=	{	4029	,	99	,	4039	,	20	}
ChangeItemList[	24	]=	{	4030	,	99	,	4040	,	20	}
ChangeItemList[	25	]=	{	4031	,	99	,	4041	,	20	}
ChangeItemList[	26	]=	{	4032	,	99	,	4042	,	20	}
ChangeItemList[	27	]=	{	4033	,	99	,	4043	,	20	}
ChangeItemList[	28	]=	{	4034	,	99	,	4044	,	20	}
ChangeItemList[	29	]=	{	4035	,	99	,	4045	,	20	}
ChangeItemList[	30	]=	{	4036	,	99	,	4046	,	20	}
ChangeItemList[	31	]=	{	4037	,	99	,	4047	,	20	}
ChangeItemList[	32	]=	{	4038	,	99	,	4048	,	20	}
ChangeItemList[	33	]=	{	1670	,	99	,	1671	,	20	}
ChangeItemList[	34	]=	{	1668	,	99	,	3368	,	20	}
ChangeItemList[	35	]=	{	1667	,	99	,	3360	,	20	}
ChangeItemList[	36	]=	{	1642	,	99	,	1643	,	20	}
ChangeItemList[	37	]=	{	4825	,	99	,	1638	,	20	}
ChangeItemList[	38	]=	{	1633	,	99	,	1641	,	20	}
ChangeItemList[	39	]=	{	1782	,	99	,	1769	,	20	}
ChangeItemList[	40	]=	{	2815	,	99	,	1775	,	20	}
ChangeItemList[	41	]=	{	1674	,	99	,	1767	,	20	}
ChangeItemList[	42	]=	{	4832	,	99	,	2901	,	20	}
ChangeItemList[	43	]=	{	855	,	60	,	2617	,	1	}
ChangeItemList[	44	]=	{	2588	,	3	,	2619	,	1	}
ChangeItemList[	45	]=	{	2588	,	20	,	2622	,	1	}
ChangeItemList[	46	]=	{	2589	,	5	,	2624	,	1	}
ChangeItemList[	47	]=	{	2588	,	3	,	2640	,	1	}
ChangeItemList[	48	]=	{	855	,	60	,	2641	,	1	}
ChangeItemList[	49	]=	{	2588	,	20	,	2642	,	1	}
ChangeItemList[	50	]=	{	2588	,	20	,	2643	,	1	}
ChangeItemList[	51	]=	{	2588	,	50	,	2644	,	1	}
ChangeItemList[	52	]=	{	2588	,	50	,	2649	,	1	}
ChangeItemList[	53	]=	{	855	,	100	,	1055	,	1	}
ChangeItemList[	54	]=	{	2588	,	100	,	1056	,	1	}
ChangeItemList[	55	]=	{	855	,	100	,	1058	,	1	}
ChangeItemList[	56	]=	{	2588	,	100	,	1059	,	1	}
ChangeItemList[	57	]=	{	855	,	100	,	1061	,	1	}
ChangeItemList[	58	]=	{	2588	,	100	,	1062	,	1	}
ChangeItemList[	59	]=	{	855	,	100	,	1064	,	1	}
ChangeItemList[	60	]=	{	2588	,	100	,	1065	,	1	}
ChangeItemList[	61	]=	{	855	,	10	,	2680	,	1	}
ChangeItemList[	62	]=	{	855	,	50	,	2681	,	1	}
ChangeItemList[	63	]=	{	855	,	300	,	2682	,	1	}
ChangeItemList[	64	]=	{	2588	,	10	,	2683	,	1	}
ChangeItemList[	65	]=	{	2588	,	50	,	2684	,	1	}
ChangeItemList[	66	]=	{	2588	,	300	,	2685	,	1	}
ChangeItemList[	67	]=	{	855	,	10	,	2690	,	1	}
ChangeItemList[	68	]=	{	855	,	50	,	2691	,	1	}
ChangeItemList[	69	]=	{	855	,	300	,	2692	,	1	}
ChangeItemList[	70	]=	{	2588	,	10	,	2693	,	1	}
ChangeItemList[	71	]=	{	2588	,	50	,	2694	,	1	}
ChangeItemList[	72	]=	{	2588	,	300	,	2695	,	1	}
ChangeItemList[	73	]=	{	855	,	10	,	2700	,	1	}
ChangeItemList[	74	]=	{	855	,	50	,	2701	,	1	}
ChangeItemList[	75	]=	{	855	,	300	,	2702	,	1	}
ChangeItemList[	76	]=	{	2588	,	10	,	2703	,	1	}
ChangeItemList[	77	]=	{	2588	,	50	,	2704	,	1	}
ChangeItemList[	78	]=	{	2588	,	300	,	2705	,	1	}
ChangeItemList[	79	]=	{	855	,	10	,	2710	,	1	}
ChangeItemList[	80	]=	{	855	,	50	,	2711	,	1	}
ChangeItemList[	81	]=	{	855	,	300	,	2712	,	1	}
ChangeItemList[	82	]=	{	2588	,	10	,	2713	,	1	}
ChangeItemList[	83	]=	{	2588	,	50	,	2714	,	1	}
ChangeItemList[	84	]=	{	2588	,	300	,	2715	,	1	}
ChangeItemList[	85	]=	{	4215	,	5	,	3655	,	1	}
ChangeItemList[	86	]=	{	4215	,	20	,	3656	,	1	}
ChangeItemList[	87	]=	{	4215	,	50	,	3657	,	1	}
ChangeItemList[	88	]=	{	4215	,	5	,	3658	,	1	}
ChangeItemList[	89	]=	{	4215	,	20	,	3659	,	1	}
ChangeItemList[	90	]=	{	4215	,	30	,	3660	,	1	}
ChangeItemList[	91	]=	{	4215	,	100	,	5781	,	1	}
ChangeItemList[	92	]=	{	3272	,	100	,	5782	,	1	}
ChangeItemList[	93	]=	{	4215	,	100	,	5784	,	1	}
ChangeItemList[	94	]=	{	3272	,	100	,	5785	,	1	}
ChangeItemList[	95	]=	{	4215	,	100	,	5787	,	1	}
ChangeItemList[	96	]=	{	3272	,	100	,	5788	,	1	}
ChangeItemList[	97	]=	{	4215	,	100	,	5790	,	1	}
ChangeItemList[	98	]=	{	3272	,	100	,	5791	,	1	}
ChangeItemList[	99	]=	{	4215	,	10	,	3915	,	1	}
ChangeItemList[	100	]=	{	4215	,	50	,	3916	,	1	}
ChangeItemList[	101	]=	{	4215	,	300	,	3917	,	1	}
ChangeItemList[	102	]=	{	3272	,	10	,	3918	,	1	}
ChangeItemList[	103	]=	{	3272	,	50	,	3919	,	1	}
ChangeItemList[	104	]=	{	3272	,	300	,	3920	,	1	}
ChangeItemList[	105	]=	{	4215	,	10	,	3925	,	1	}
ChangeItemList[	106	]=	{	4215	,	50	,	3926	,	1	}
ChangeItemList[	107	]=	{	4215	,	300	,	3927	,	1	}
ChangeItemList[	108	]=	{	3272	,	10	,	3928	,	1	}
ChangeItemList[	109	]=	{	3272	,	50	,	3929	,	1	}
ChangeItemList[	110	]=	{	3272	,	300	,	3930	,	1	}
ChangeItemList[	111	]=	{	4215	,	10	,	3935	,	1	}
ChangeItemList[	112	]=	{	4215	,	50	,	3936	,	1	}
ChangeItemList[	113	]=	{	4215	,	300	,	3937	,	1	}
ChangeItemList[	114	]=	{	3272	,	10	,	3938	,	1	}
ChangeItemList[	115	]=	{	3272	,	50	,	3939	,	1	}
ChangeItemList[	116	]=	{	3272	,	300	,	3940	,	1	}
ChangeItemList[	117	]=	{	4215	,	10	,	3935	,	1	}
ChangeItemList[	118	]=	{	4215	,	50	,	3936	,	1	}
ChangeItemList[	119	]=	{	4215	,	300	,	3937	,	1	}
ChangeItemList[	120	]=	{	3272	,	10	,	3938	,	1	}
ChangeItemList[	121	]=	{	3272	,	50	,	3939	,	1	}
ChangeItemList[	122	]=	{	3272	,	300	,	3940	,	1	}
ChangeItemList[ 123	]=	{	1028	,	2	,	0766	,	1	}
ChangeItemList[ 124	]=	{	1028	,	2	,	0769	,	1	}
ChangeItemList[ 125	]=	{	1028	,	2	,	0773	,	1	}
ChangeItemList[ 126	]=	{	1028	,	2	,	0776	,	1	}
ChangeItemList[ 127	]=	{	1028	,	2	,	0780	,	1	}
ChangeItemList[ 128	]=	{	1028	,	2	,	0784	,	1	}
ChangeItemList[ 129	]=	{	1028	,	2	,	0788	,	1	}
ChangeItemList[ 130	]=	{	1028	,	2	,	0792	,	1	}
ChangeItemList[ 131	]=	{	1028	,	2	,	0795	,	1	}
ChangeItemList[ 132	]=	{	1028	,	2	,	0798	,	1	}
ChangeItemList[ 133	]=	{	1028	,	2	,	0802	,	1	}
ChangeItemList[ 134	]=	{	1028	,	2	,	0806	,	1	}
ChangeItemList[ 135	]=	{	3457	,	1	,	0765	,	1	}
ChangeItemList[ 136	]=	{	3457	,	1	,	0768	,	1	}
ChangeItemList[ 137	]=	{	3457	,	1	,	0772	,	1	}
ChangeItemList[ 138	]=	{	3457	,	1	,	0775	,	1	}
ChangeItemList[ 139	]=	{	3457	,	1	,	0779	,	1	}
ChangeItemList[ 140	]=	{	3457	,	1	,	0783	,	1	}
ChangeItemList[ 141	]=	{	3457	,	1	,	0787	,	1	}
ChangeItemList[ 142	]=	{	3457	,	1	,	0791	,	1	}
ChangeItemList[ 143	]=	{	3457	,	1	,	0794	,	1	}
ChangeItemList[ 144	]=	{	3457	,	1	,	0797	,	1	}
ChangeItemList[ 145	]=	{	3457	,	1	,	0801	,	1	}
ChangeItemList[ 146	]=	{	3457	,	1	,	0805	,	1	}
ChangeItemList[ 147	]=	{	3457	,	1	,	0807	,	1	}
ChangeItemList[ 148	]=	{	3457	,	1	,	0808	,	1	}
ChangeItemList[ 149	]=	{	3457	,	1	,	0809	,	1	}
ChangeItemList[ 150	]=	{	3457	,	1	,	0810	,	1	}
ChangeItemList[ 151	]=	{	3457	,	1	,	0811	,	1	}
ChangeItemList[ 152	]=	{	3457	,	1	,	0812	,	1	}
ChangeItemList[ 153	]=	{	3457	,	1	,	0813	,	1	}
ChangeItemList[ 154	]=	{	3457	,	1	,	0814	,	1	}
ChangeItemList[ 155	]=	{	3457	,	1	,	0815	,	1	}
ChangeItemList[ 156	]=	{	3457	,	1	,	0877	,	1	}
ChangeItemList[ 157	]=	{	855	,	1000	,	764	,	1	}
ChangeItemList[ 158	]=	{	855	,	1000	,	767	,	1	}
ChangeItemList[ 159	]=	{	855	,	1000	,	771	,	1	}
ChangeItemList[ 160	]=	{	855	,	1000	,	774	,	1	}
ChangeItemList[ 161	]=	{	855	,	1000	,	778	,	1	}
ChangeItemList[ 162	]=	{	855	,	1000	,	782	,	1	}
ChangeItemList[ 163	]=	{	855	,	1000	,	786	,	1	}
ChangeItemList[ 164	]=	{	855	,	1000	,	790	,	1	}
ChangeItemList[ 165	]=	{	855	,	1000	,	793	,	1	}
ChangeItemList[ 166	]=	{	855	,	1000	,	796	,	1	}
ChangeItemList[ 167	]=	{	855	,	1000	,	800	,	1	}
ChangeItemList[ 168	]=	{	855	,	1000	,	804	,	1	}
ChangeItemList[ 169	]=	{	855	,	1000	,	764	,	1	}
ChangeItemList[ 170	]=	{	855	,	1000	,	767	,	1	}
ChangeItemList[ 171	]=	{	855	,	1000	,	771	,	1	}
ChangeItemList[ 172	]=	{	855	,	1000	,	774	,	1	}
ChangeItemList[ 173	]=	{	855	,	1000	,	778	,	1	}
ChangeItemList[ 174	]=	{	855	,	1000	,	782	,	1	}
ChangeItemList[ 175	]=	{	855	,	1000	,	786	,	1	}
ChangeItemList[ 176	]=	{	855	,	1000	,	790	,	1	}
ChangeItemList[ 177	]=	{	855	,	1000	,	793	,	1	}
ChangeItemList[ 178	]=	{	855	,	1000	,	796	,	1	}
ChangeItemList[ 179	]=	{	855	,	1000	,	800	,	1	}
ChangeItemList[ 180	]=	{	855	,	1000	,	804	,	1	}
ChangeItemList[ 181	]=	{	855	,	1000	,	764	,	1	}
ChangeItemList[ 182	]=	{	855	,	1000	,	767	,	1	}
ChangeItemList[ 183	]=	{	855	,	1000	,	771	,	1	}
ChangeItemList[ 184	]=	{	855	,	1000	,	774	,	1	}
ChangeItemList[ 185	]=	{	855	,	1000	,	778	,	1	}
ChangeItemList[ 186	]=	{	855	,	1000	,	782	,	1	}
ChangeItemList[ 187	]=	{	855	,	1000	,	786	,	1	}
ChangeItemList[ 188	]=	{	855	,	1000	,	790	,	1	}
ChangeItemList[ 189	]=	{	855	,	1000	,	793	,	1	}
ChangeItemList[ 190	]=	{	855	,	1000	,	796	,	1	}
ChangeItemList[ 191	]=	{	855	,	1000	,	800	,	1	}
ChangeItemList[ 192	]=	{	855	,	1000	,	804	,	1	}
ChangeItemList[ 193	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 194	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 195	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 196	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 197	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 198	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 199	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 200	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 201	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 202	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 203	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 204	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 205	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 206	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 207	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 208	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 209	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 210	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 211	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 212	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 213	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 214	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 215	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 216	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 217	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 218	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 219	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 220	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 221	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 222	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 223	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 224	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 225	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 226	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 227	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 228	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 229	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 230	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 231	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 232	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 233	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 234	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 235	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 236	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 237	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 238	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 239	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 240	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 241	]=	{	855	,	600	,	763	,	1	}
ChangeItemList[ 242	]=	{	855	,	600	,	770	,	1	}
ChangeItemList[ 243	]=	{	855	,	600	,	777	,	1	}
ChangeItemList[ 244	]=	{	855	,	600	,	781	,	1	}
ChangeItemList[ 245	]=	{	855	,	600	,	785	,	1	}
ChangeItemList[ 246	]=	{	855	,	600	,	789	,	1	}
ChangeItemList[ 247	]=	{	855	,	600	,	799	,	1	}
ChangeItemList[ 248	]=	{	855	,	600	,	803	,	1	}
ChangeItemList[ 249	]=	{	855	,	5	,	2617	,	1		}
ChangeItemList[ 250	]=	{	855	,	10	,	2619	,	1		}
ChangeItemList[ 251	]=	{	855	,	15	,	2622	,	1		}
ChangeItemList[ 252	]=	{	855	,	20	,	2624	,	1		}
ChangeItemList[ 253	]=	{	855	,	5	,	2640	,	1		}
ChangeItemList[ 254	]=	{	855	,	10	,	2641	,	1		}
ChangeItemList[ 255	]=	{	855	,	15	,	2642	,	1		}
ChangeItemList[ 256	]=	{	855	,	20	,	2643	,	1		}
ChangeItemList[ 257	]=	{	855	,	25	,	2644	,	1		}
ChangeItemList[ 258	]=	{	855	,	30	,	2649	,	1		}
ChangeItemList[ 259	]=	{	855	,	15	,	8080	,	1		}
ChangeItemList[ 260	]=	{	2588	,	3	,	2679	,	1		}
ChangeItemList[ 261	]=	{	2588	,	6	,	2680	,	1		}
ChangeItemList[ 262	]=	{	2588	,	9	,	2681	,	1		}
ChangeItemList[ 263	]=	{	2588	,	12	,	2682	,	1		}
ChangeItemList[ 264	]=	{	2588	,	15	,	2683	,	1		}
ChangeItemList[ 265	]=	{	2588	,	18	,	2684	,	1		}
ChangeItemList[ 266	]=	{	2588	,	21	,	2685	,	1		}
ChangeItemList[ 267	]=	{	2588	,	24	,	2686	,	1		}
ChangeItemList[ 268	]=	{	2588	,	3	,	2689	,	1		}
ChangeItemList[ 269	]=	{	2588	,	6	,	2690	,	1		}
ChangeItemList[ 270	]=	{	2588	,	9	,	2691	,	1		}
ChangeItemList[ 271	]=	{	2588	,	12	,	2692	,	1		}
ChangeItemList[ 272	]=	{	2588	,	15	,	2693	,	1		}
ChangeItemList[ 273	]=	{	2588	,	18	,	2694	,	1		}
ChangeItemList[ 274	]=	{	2588	,	21	,	2695	,	1		}
ChangeItemList[ 275	]=	{	2588	,	24	,	2696	,	1		}
ChangeItemList[ 276	]=	{	2588	,	3	,	2699	,	1		}
ChangeItemList[ 277	]=	{	2588	,	6	,	2700	,	1		}
ChangeItemList[ 278	]=	{	2588	,	9	,	2701	,	1		}
ChangeItemList[ 279	]=	{	2588	,	12	,	2702	,	1		}
ChangeItemList[ 280	]=	{	2588	,	15	,	2703	,	1		}
ChangeItemList[ 281	]=	{	2588	,	18	,	2704	,	1		}
ChangeItemList[ 282	]=	{	2588	,	21	,	2705	,	1		}
ChangeItemList[ 283	]=	{	2588	,	24	,	2706	,	1		}
ChangeItemList[ 284	]=	{	2588	,	1	,	196	,	1		}
ChangeItemList[ 285	]=	{	2588	,	1	,	197	,	1		}

--Types Of Items that can be repaired

Item_CanRepair_Num = 13
Item_CanRepair_ID = { }
Item_CanRepair_ID [0]  =		1	--Sword
Item_CanRepair_ID [1]  =		2	--Greatsword
Item_CanRepair_ID [2]  =		3	--Bows
Item_CanRepair_ID [3]  =		4	--Guns
Item_CanRepair_ID [4]  =		7	--Dagger
Item_CanRepair_ID [5]  =		11	--Shields
Item_CanRepair_ID [6]  =		20	--Hats
Item_CanRepair_ID [7]  =		22	--Clothes
Item_CanRepair_ID [8]  =		23	--Gloves
Item_CanRepair_ID [9]  =		24	--Shoes
Item_CanRepair_ID [10] =		27	--Tattoo
Item_CanRepair_ID [11] =		9	--Staff
Item_CanRepair_ID [12] =		26 	--Ring 
Item_CanRepair_ID [13] =		25 	--Neck 

--Forgiable Item types

Item_CanJinglian_Num = 11
Item_CanJinglian_ID = { }
Item_CanJinglian_ID [0]  =		1	-- Sword
Item_CanJinglian_ID [1]  =		2	-- Greatsword
Item_CanJinglian_ID [2]  =		3	-- Bows
Item_CanJinglian_ID [3]  =		4	-- Guns
Item_CanJinglian_ID [4]  =		7	-- Daggers
Item_CanJinglian_ID [5]  =		11	-- Shields
Item_CanJinglian_ID [6]  =		20	-- Hats
Item_CanJinglian_ID [7]  =		22	-- Clothes
Item_CanJinglian_ID [8]  =		23	-- Gloves
Item_CanJinglian_ID [9]  =		24	-- Shoes
Item_CanJinglian_ID [10] =		27	-- Tattoo
Item_CanJinglian_ID [11] =		9	-- Staff
Item_CanJinglian_ID [12] =		26	-- Ring
Item_CanJinglian_ID [13] =		25	-- Neck


JNSTime_Flag_Num=13
JNSTime_Flag={}
JNSTime_Flag[1]				=0
JNSTime_Flag[2]				=31
JNSTime_Flag[3]				=59
JNSTime_Flag[4]				=90
JNSTime_Flag[5]				=120
JNSTime_Flag[6]				=151
JNSTime_Flag[7]				=181
JNSTime_Flag[8]				=212
JNSTime_Flag[9]				=243
JNSTime_Flag[10]			=273
JNSTime_Flag[11]			=304
JNSTime_Flag[12]			=334
JNSTime_Flag[13]			=365

--Experience Level And The Corresponding Total

DEXP_Num = 130
DEXP 	={}
DEXP[1]	 					=		0
DEXP[2]						=		5
DEXP[3]						=		15
DEXP[4]						=		35
DEXP[5]						=		101
DEXP[6]						=		250
DEXP[7]						=		500
DEXP[8]						=		1000
DEXP[9]						=		1974
DEXP[10]					=		3208
DEXP[11]					=		4986
DEXP[12]					=		7468
DEXP[13]					=		10844
DEXP[14]					=		15338
DEXP[15]					=		21210
DEXP[16]					=		28766
DEXP[17]					=		38356
DEXP[18]					=		50382
DEXP[19]					=		65306
DEXP[20]					=		83656
DEXP[21]					=		106032
DEXP[22]					=		133112
DEXP[23]					=		165668
DEXP[24]					=		204564
DEXP[25]					=		250780
DEXP[26]					=		305412
DEXP[27]					=		369692
DEXP[28]					=		444998
DEXP[29]					=		532870
DEXP[30]					=		635026
DEXP[31]					=		753378
DEXP[32]					=		890062
DEXP[33]					=		1047438
DEXP[34]					=		1228138
DEXP[35]					=		1435074
DEXP[36]					=		1671470
DEXP[37]					=		1940892
DEXP[38]					=		2247288
DEXP[39]					=		2595010
DEXP[40]					=		2988860
DEXP[41]					=		3090719 
DEXP[42]					=		3542992 
DEXP[43]					=		4052570 
DEXP[44]					=		4625800 
DEXP[45]					=		5269662 
DEXP[46]					=		5991818 
DEXP[47]					=		6800679 
DEXP[48]					=		7705467 
DEXP[49]					=		8716288 
DEXP[50]					=		9844214 
DEXP[51]					=		11101370 
DEXP[52]					=		12501018 
DEXP[53]					=		14057660 
DEXP[54]					=		15787154 
DEXP[55]					=		17706816 
DEXP[56]					=		19835564 
DEXP[57]					=		22194040 
DEXP[58]					=		24804767 
DEXP[59]					=		27692307 
DEXP[60]					=		33971776 
DEXP[61]					=		41288784 
DEXP[62]					=		53614038 
DEXP[63]					=		68133274 
DEXP[64]					=		85153751 
DEXP[65]					=		105019474 
DEXP[66]					=		139761953 
DEXP[67]					=		167776212 
DEXP[68]					=		214343653 
DEXP[69]					=		268760050 
DEXP[70]					=		332078265 
DEXP[71]					=		405472994 
DEXP[72]					=		511568801 
DEXP[73]					=		611392270 
DEXP[74]					=		725890112 
DEXP[75]					=		856882552 
DEXP[76]					=		1069289312
DEXP[77]					=		1332386290
DEXP[78]					=		1598513026
DEXP[79]					=		1882471412
DEXP[80]					=		2182814829
DEXP[81]					=		2196805577
DEXP[82]					=		2213006864
DEXP[83]					=		2231767952
DEXP[84]					=		2253493292
DEXP[85]					=		2278651236
DEXP[86]					=		2307784135
DEXP[87]					=		2341520031
DEXP[88]					=		2380586198
DEXP[89]					=		2425824818
DEXP[90]					=		2478211141
DEXP[91]					=		2538874501
DEXP[92]					=		2609122672
DEXP[93]					=		2690470053
DEXP[94]					=		2784670320
DEXP[95]					=		2893754228
DEXP[96]					=		3020073395
DEXP[97]					=		3166350989
DEXP[98]					=		3335740442
DEXP[99]					=		3531893429
DEXP[100]					=		3759038587
DEXP[101]					=		4008898261
DEXP[102]					=		4283743902
DEXP[103]					=		4586074108
DEXP[104]					=		4918637335
DEXP[105]					=		5284456884
DEXP[106]					=		5686858388
DEXP[107]					=		6102778106
DEXP[108]					=		6533116038
DEXP[109]					=		6978772184
DEXP[110]					=		7440646545
DEXP[111]					=		7919639120
DEXP[112]					=		8416649909
DEXP[113]					=		8932578912
DEXP[114]					=		9468326129
DEXP[115]					=		10024791561
DEXP[116]					=		10602875207
DEXP[117]					=		11203477067
DEXP[118]					=		11827497141
DEXP[119]					=		12475835429
DEXP[120]					=		13149391932
DEXP[121]					=		13890304085
DEXP[122]					=		14705307452
DEXP[123]					=		15601811155
DEXP[124]					=		16587965228
DEXP[125]					=		17672734709
DEXP[126]					=		18865981138
DEXP[127]					=		20178552209
DEXP[128]					=		21622380388
DEXP[129]					=		23210591385
DEXP[130]					=		24957623481

LV_EXP_Num = 130
LV_EXP	={}
LV_EXP	[	1	]	=	1
LV_EXP	[	2	]	=	1
LV_EXP	[	3	]	=	1
LV_EXP	[	4	]	=	1
LV_EXP	[	5	]	=	1
LV_EXP	[	6	]	=	1.2
LV_EXP	[	7	]	=	1.2
LV_EXP	[	8	]	=	1.3
LV_EXP	[	9	]	=	1.3
LV_EXP	[	10	]	=	1.5
LV_EXP	[	11	]	=	1.5
LV_EXP	[	12	]	=	1.5
LV_EXP	[	13	]	=	1.5
LV_EXP	[	14	]	=	1.5
LV_EXP	[	15	]	=	1.5
LV_EXP	[	16	]	=	1.8
LV_EXP	[	17	]	=	1.8
LV_EXP	[	18	]	=	1.8
LV_EXP	[	19	]	=	1.8
LV_EXP	[	20	]	=	1.8
LV_EXP	[	21	]	=	2
LV_EXP	[	22	]	=	2
LV_EXP	[	23	]	=	2
LV_EXP	[	24	]	=	2
LV_EXP	[	25	]	=	2
LV_EXP	[	26	]	=	2.2
LV_EXP	[	27	]	=	2.2
LV_EXP	[	28	]	=	2.2
LV_EXP	[	29	]	=	2.2
LV_EXP	[	30	]	=	2.2
LV_EXP	[	31	]	=	2
LV_EXP	[	32	]	=	2
LV_EXP	[	33	]	=	2
LV_EXP	[	34	]	=	2
LV_EXP	[	35	]	=	2
LV_EXP	[	36	]	=	1.8
LV_EXP	[	37	]	=	1.8
LV_EXP	[	38	]	=	1.8
LV_EXP	[	39	]	=	1.8
LV_EXP	[	40	]	=	1.8
LV_EXP	[	41	]	=	1.5
LV_EXP	[	42	]	=	1.5
LV_EXP	[	43	]	=	1.5
LV_EXP	[	44	]	=	1.5
LV_EXP	[	45	]	=	1.3
LV_EXP	[	46	]	=	1.3
LV_EXP	[	47	]	=	1.3
LV_EXP	[	48	]	=	1.3
LV_EXP	[	49	]	=	1.2
LV_EXP	[	50	]	=	1.2
LV_EXP	[	51	]	=	1.2
LV_EXP	[	52	]	=	1.2
LV_EXP	[	53	]	=	1.1
LV_EXP	[	54	]	=	1.1
LV_EXP	[	55	]	=	1.1
LV_EXP	[	56	]	=	1.1
LV_EXP	[	57	]	=	1
LV_EXP	[	58	]	=	1
LV_EXP	[	59	]	=	1
LV_EXP	[	60	]	=	1
LV_EXP	[	61	]	=	1
LV_EXP	[	62	]	=	1
LV_EXP	[	63	]	=	1
LV_EXP	[	64	]	=	1
LV_EXP	[	65	]	=	1
LV_EXP	[	66	]	=	1
LV_EXP	[	67	]	=	1
LV_EXP	[	68	]	=	1
LV_EXP	[	69	]	=	1
LV_EXP	[	70	]	=	1
LV_EXP	[	71	]	=	1
LV_EXP	[	72	]	=	1
LV_EXP	[	73	]	=	1
LV_EXP	[	74	]	=	1
LV_EXP	[	75	]	=	1
LV_EXP	[	76	]	=	1
LV_EXP	[	77	]	=	1
LV_EXP	[	78	]	=	1
LV_EXP	[	79	]	=	1
LV_EXP	[	80	]	=	1
LV_EXP	[	81	]	=	1
LV_EXP	[	82	]	=	1
LV_EXP	[	83	]	=	1
LV_EXP	[	84	]	=	1
LV_EXP	[	85	]	=	1
LV_EXP	[	86	]	=	1
LV_EXP	[	87	]	=	1
LV_EXP	[	88	]	=	1
LV_EXP	[	89	]	=	1
LV_EXP	[	90	]	=	1
LV_EXP	[	91	]	=	1
LV_EXP	[	92	]	=	1
LV_EXP	[	93	]	=	1
LV_EXP	[	94	]	=	1
LV_EXP	[	95	]	=	1
LV_EXP	[	96	]	=	1
LV_EXP	[	97	]	=	1
LV_EXP	[	98	]	=	1
LV_EXP	[	99	]	=	1
LV_EXP	[	100	]	=	1
LV_EXP	[	101	]	=	1
LV_EXP	[	102	]	=	1
LV_EXP	[	103	]	=	1
LV_EXP	[	104	]	=	1
LV_EXP	[	105	]	=	1
LV_EXP	[	106	]	=	1
LV_EXP	[	107	]	=	1
LV_EXP	[	108	]	=	1
LV_EXP	[	109	]	=	1
LV_EXP	[	110	]	=	1
LV_EXP	[	111	]	=	1
LV_EXP	[	112	]	=	1
LV_EXP	[	113	]	=	1
LV_EXP	[	114	]	=	1
LV_EXP	[	115	]	=	1
LV_EXP	[	116	]	=	1
LV_EXP	[	117	]	=	1
LV_EXP	[	118	]	=	1
LV_EXP	[	119	]	=	1
LV_EXP	[	120	]	=	1
LV_EXP	[	121	]	=	1
LV_EXP	[	122	]	=	1
LV_EXP	[	123	]	=	1
LV_EXP	[	124	]	=	1
LV_EXP	[	125	]	=	1
LV_EXP	[	126	]	=	1
LV_EXP	[	127	]	=	1
LV_EXP	[	128	]	=	1
LV_EXP	[	129	]	=	1
LV_EXP	[	130	]	=	1

--------------------属性编号
STAR_ATTR_Num = 47
STAR_ATTR={}
CALCULATE_VARIABLE_LUA_000001 = GetResString("CALCULATE_VARIABLE_LUA_000001")
STAR_ATTR[1]				=	CALCULATE_VARIABLE_LUA_000001	--力量系数加成             
CALCULATE_VARIABLE_LUA_000002 = GetResString("CALCULATE_VARIABLE_LUA_000002")
STAR_ATTR[2]				=	CALCULATE_VARIABLE_LUA_000002	--敏捷系数加成             
CALCULATE_VARIABLE_LUA_000003 = GetResString("CALCULATE_VARIABLE_LUA_000003")
STAR_ATTR[3]				=	CALCULATE_VARIABLE_LUA_000003	--专注系数加成             
CALCULATE_VARIABLE_LUA_000004 = GetResString("CALCULATE_VARIABLE_LUA_000004")
STAR_ATTR[4]				=	CALCULATE_VARIABLE_LUA_000004	--体质系数加成             
CALCULATE_VARIABLE_LUA_000005 = GetResString("CALCULATE_VARIABLE_LUA_000005")
STAR_ATTR[5]				=	CALCULATE_VARIABLE_LUA_000005	--精力系数加成             
CALCULATE_VARIABLE_LUA_000006 = GetResString("CALCULATE_VARIABLE_LUA_000006")
STAR_ATTR[6]				=	CALCULATE_VARIABLE_LUA_000006	--幸运系数加成             
CALCULATE_VARIABLE_LUA_000007 = GetResString("CALCULATE_VARIABLE_LUA_000007")
STAR_ATTR[7]				=	CALCULATE_VARIABLE_LUA_000007	--攻击频率系数加成       
CALCULATE_VARIABLE_LUA_000008 = GetResString("CALCULATE_VARIABLE_LUA_000008")
STAR_ATTR[8]				=	CALCULATE_VARIABLE_LUA_000008	--攻击距离系数加成       
CALCULATE_VARIABLE_LUA_000009 = GetResString("CALCULATE_VARIABLE_LUA_000009")
STAR_ATTR[9]				=	CALCULATE_VARIABLE_LUA_000009	--最小攻击力系数加成    
CALCULATE_VARIABLE_LUA_000010 = GetResString("CALCULATE_VARIABLE_LUA_000010")
STAR_ATTR[10]				=	CALCULATE_VARIABLE_LUA_000010	--最大攻击力系数加成    
CALCULATE_VARIABLE_LUA_000011 = GetResString("CALCULATE_VARIABLE_LUA_000011")
STAR_ATTR[11]				=	CALCULATE_VARIABLE_LUA_000011	--防御系数加成             
CALCULATE_VARIABLE_LUA_000012 = GetResString("CALCULATE_VARIABLE_LUA_000012")
STAR_ATTR[12]				=	CALCULATE_VARIABLE_LUA_000012	--最大Hp系数加成         
CALCULATE_VARIABLE_LUA_000013 = GetResString("CALCULATE_VARIABLE_LUA_000013")
STAR_ATTR[13]				=	CALCULATE_VARIABLE_LUA_000013	--最大Sp系数加成         
CALCULATE_VARIABLE_LUA_000014 = GetResString("CALCULATE_VARIABLE_LUA_000014")
STAR_ATTR[14]				=	CALCULATE_VARIABLE_LUA_000014	--闪避率系数加成          
CALCULATE_VARIABLE_LUA_000015 = GetResString("CALCULATE_VARIABLE_LUA_000015")
STAR_ATTR[15]				=	CALCULATE_VARIABLE_LUA_000015	--命中率系数加成          
CALCULATE_VARIABLE_LUA_000016 = GetResString("CALCULATE_VARIABLE_LUA_000016")
STAR_ATTR[16]				=	CALCULATE_VARIABLE_LUA_000016	--爆击率系数加成          
CALCULATE_VARIABLE_LUA_000017 = GetResString("CALCULATE_VARIABLE_LUA_000017")
STAR_ATTR[17]				=	CALCULATE_VARIABLE_LUA_000017	--寻宝率系数加成          
CALCULATE_VARIABLE_LUA_000018 = GetResString("CALCULATE_VARIABLE_LUA_000018")
STAR_ATTR[18]				=	CALCULATE_VARIABLE_LUA_000018	--hp恢复速度系数加成   
CALCULATE_VARIABLE_LUA_000019 = GetResString("CALCULATE_VARIABLE_LUA_000019")
STAR_ATTR[19]				=	CALCULATE_VARIABLE_LUA_000019	--sp恢复速度系数加成    
CALCULATE_VARIABLE_LUA_000020 = GetResString("CALCULATE_VARIABLE_LUA_000020")
STAR_ATTR[20]				=	CALCULATE_VARIABLE_LUA_000020	--移动速度系数加成       
CALCULATE_VARIABLE_LUA_000021 = GetResString("CALCULATE_VARIABLE_LUA_000021")
STAR_ATTR[21]				=	CALCULATE_VARIABLE_LUA_000021	--资源采集速度系数加成 
CALCULATE_VARIABLE_LUA_000022 = GetResString("CALCULATE_VARIABLE_LUA_000022")
STAR_ATTR[22]				=	CALCULATE_VARIABLE_LUA_000022	--物理抵抗系数加成       
CALCULATE_VARIABLE_LUA_000023 = GetResString("CALCULATE_VARIABLE_LUA_000023")
STAR_ATTR[23]				=	CALCULATE_VARIABLE_LUA_000023	--无                            
CALCULATE_VARIABLE_LUA_000023 = GetResString("CALCULATE_VARIABLE_LUA_000023")
STAR_ATTR[24]				=	CALCULATE_VARIABLE_LUA_000023	--无                            
CALCULATE_VARIABLE_LUA_000023 = GetResString("CALCULATE_VARIABLE_LUA_000023")
STAR_ATTR[25]				=	CALCULATE_VARIABLE_LUA_000023	--无                            
CALCULATE_VARIABLE_LUA_000024 = GetResString("CALCULATE_VARIABLE_LUA_000024")
STAR_ATTR[26]				=	CALCULATE_VARIABLE_LUA_000024	--力量常数加成             
CALCULATE_VARIABLE_LUA_000025 = GetResString("CALCULATE_VARIABLE_LUA_000025")
STAR_ATTR[27]				=	CALCULATE_VARIABLE_LUA_000025	--敏捷常数加成             
CALCULATE_VARIABLE_LUA_000026 = GetResString("CALCULATE_VARIABLE_LUA_000026")
STAR_ATTR[28]				=	CALCULATE_VARIABLE_LUA_000026	--专注常数加成             
CALCULATE_VARIABLE_LUA_000027 = GetResString("CALCULATE_VARIABLE_LUA_000027")
STAR_ATTR[29]				=	CALCULATE_VARIABLE_LUA_000027	--体质常数加成             
CALCULATE_VARIABLE_LUA_000028 = GetResString("CALCULATE_VARIABLE_LUA_000028")
STAR_ATTR[30]				=	CALCULATE_VARIABLE_LUA_000028	--精力常数加成             
CALCULATE_VARIABLE_LUA_000029 = GetResString("CALCULATE_VARIABLE_LUA_000029")
STAR_ATTR[31]				=	CALCULATE_VARIABLE_LUA_000029	--幸运常数加成             
CALCULATE_VARIABLE_LUA_000030 = GetResString("CALCULATE_VARIABLE_LUA_000030")
STAR_ATTR[32]				=	CALCULATE_VARIABLE_LUA_000030	--攻击频率常数加成       
CALCULATE_VARIABLE_LUA_000031 = GetResString("CALCULATE_VARIABLE_LUA_000031")
STAR_ATTR[33]				=	CALCULATE_VARIABLE_LUA_000031	--攻击距离常数加成       
CALCULATE_VARIABLE_LUA_000032 = GetResString("CALCULATE_VARIABLE_LUA_000032")
STAR_ATTR[34]				=	CALCULATE_VARIABLE_LUA_000032	--最小攻击力常数加成    
CALCULATE_VARIABLE_LUA_000033 = GetResString("CALCULATE_VARIABLE_LUA_000033")
STAR_ATTR[35]				=	CALCULATE_VARIABLE_LUA_000033	--最大攻击力常数加成    
CALCULATE_VARIABLE_LUA_000034 = GetResString("CALCULATE_VARIABLE_LUA_000034")
STAR_ATTR[36]				=	CALCULATE_VARIABLE_LUA_000034	--防御常数加成             
CALCULATE_VARIABLE_LUA_000035 = GetResString("CALCULATE_VARIABLE_LUA_000035")
STAR_ATTR[37]				=	CALCULATE_VARIABLE_LUA_000035	--最大Hp常数加成         
CALCULATE_VARIABLE_LUA_000036 = GetResString("CALCULATE_VARIABLE_LUA_000036")
STAR_ATTR[38]				=	CALCULATE_VARIABLE_LUA_000036	--最大Sp常数加成         
CALCULATE_VARIABLE_LUA_000037 = GetResString("CALCULATE_VARIABLE_LUA_000037")
STAR_ATTR[39]				=	CALCULATE_VARIABLE_LUA_000037	--闪避率常数加成          
CALCULATE_VARIABLE_LUA_000038 = GetResString("CALCULATE_VARIABLE_LUA_000038")
STAR_ATTR[40]				=	CALCULATE_VARIABLE_LUA_000038	--命中率常数加成          
CALCULATE_VARIABLE_LUA_000039 = GetResString("CALCULATE_VARIABLE_LUA_000039")
STAR_ATTR[41]				=	CALCULATE_VARIABLE_LUA_000039	--爆击率常数加成          
CALCULATE_VARIABLE_LUA_000040 = GetResString("CALCULATE_VARIABLE_LUA_000040")
STAR_ATTR[42]				=	CALCULATE_VARIABLE_LUA_000040	--寻宝率常数加成          
CALCULATE_VARIABLE_LUA_000041 = GetResString("CALCULATE_VARIABLE_LUA_000041")
STAR_ATTR[43]				=	CALCULATE_VARIABLE_LUA_000041	--hp恢复速度常数加成   
CALCULATE_VARIABLE_LUA_000042 = GetResString("CALCULATE_VARIABLE_LUA_000042")
STAR_ATTR[44]				=	CALCULATE_VARIABLE_LUA_000042	--sp恢复速度常数加成    
CALCULATE_VARIABLE_LUA_000043 = GetResString("CALCULATE_VARIABLE_LUA_000043")
STAR_ATTR[45]				=	CALCULATE_VARIABLE_LUA_000043	--移动速度常数加成       
CALCULATE_VARIABLE_LUA_000044 = GetResString("CALCULATE_VARIABLE_LUA_000044")
STAR_ATTR[46]				=	CALCULATE_VARIABLE_LUA_000044	--资源采集速度常数加成 
CALCULATE_VARIABLE_LUA_000045 = GetResString("CALCULATE_VARIABLE_LUA_000045")
STAR_ATTR[47]				=	CALCULATE_VARIABLE_LUA_000045	--物理抵抗常数加成  
     
--------------------------------------------------------------------字母都他妈是字母

WORD_Num = 52
WORD={}
WORD[1]="A"
WORD[2]="B"
WORD[3]="C"
WORD[4]="D"
WORD[5]="E"
WORD[6]="F"
WORD[7]="G"
WORD[8]="H"
WORD[9]="I"
WORD[10]="G"
WORD[11]="K"
WORD[12]="L"
WORD[13]="M"
WORD[14]="N"
WORD[15]="O"
WORD[16]="P"
WORD[17]="Q"
WORD[18]="R"
WORD[19]="S"
WORD[20]="T"
WORD[21]="U"
WORD[22]="V"
WORD[23]="W"
WORD[24]="X"
WORD[25]="Y"
WORD[26]="Z"
WORD[27]="a"
WORD[28]="b"
WORD[29]="c"
WORD[30]="d"
WORD[31]="e"
WORD[32]="f"
WORD[33]="g"
WORD[34]="h"
WORD[35]="i"
WORD[36]="g"
WORD[37]="k"
WORD[38]="l"
WORD[39]="m"
WORD[40]="n"
WORD[41]="o"
WORD[42]="p"
WORD[43]="q"
WORD[44]="r"
WORD[45]="s"
WORD[46]="t"
WORD[47]="u"
WORD[48]="v"
WORD[49]="w"
WORD[50]="x"
WORD[51]="y"
WORD[52]="z"
-------------------------
	-------老虎机限制ID
	LHJ_ID_Num = 252					
	LHJ_ID	=	{}			
	LHJ_ID	[	1	]	=	387
	LHJ_ID	[	2	]	=	395
	LHJ_ID	[	3	]	=	397
	LHJ_ID	[	4	]	=	399
	LHJ_ID	[	5	]	=	401
	LHJ_ID	[	6	]	=	403
	LHJ_ID	[	7	]	=	405
	LHJ_ID	[	8	]	=	407
	LHJ_ID	[	9	]	=	409
	LHJ_ID	[	10	]	=	412
	LHJ_ID	[	11	]	=	414
	LHJ_ID	[	12	]	=	415
	LHJ_ID	[	13	]	=	416
	LHJ_ID	[	14	]	=	417
	LHJ_ID	[	15	]	=	484
	LHJ_ID	[	16	]	=	485
	LHJ_ID	[	17	]	=	495
	LHJ_ID	[	18	]	=	497
	LHJ_ID	[	19	]	=	505
	LHJ_ID	[	20	]	=	506
	LHJ_ID	[	21	]	=	522
	LHJ_ID	[	22	]	=	523
	LHJ_ID	[	23	]	=	587
	LHJ_ID	[	24	]	=	589
	LHJ_ID	[	25	]	=	591
	LHJ_ID	[	26	]	=	593
	LHJ_ID	[	27	]	=	595
	LHJ_ID	[	28	]	=	597
	LHJ_ID	[	29	]	=	599
	LHJ_ID	[	30	]	=	601
	LHJ_ID	[	31	]	=	603
	LHJ_ID	[	32	]	=	660
	LHJ_ID	[	33	]	=	661
	LHJ_ID	[	34	]	=	747
	LHJ_ID	[	35	]	=	749
	LHJ_ID	[	36	]	=	751
	LHJ_ID	[	37	]	=	753
	LHJ_ID	[	38	]	=	755
	LHJ_ID	[	39	]	=	757
	LHJ_ID	[	40	]	=	759
	LHJ_ID	[	41	]	=	761
	LHJ_ID	[	42	]	=	763
	LHJ_ID	[	43	]	=	764
	LHJ_ID	[	44	]	=	765
	LHJ_ID	[	45	]	=	766
	LHJ_ID	[	46	]	=	767
	LHJ_ID	[	47	]	=	768
	LHJ_ID	[	48	]	=	769
	LHJ_ID	[	49	]	=	770
	LHJ_ID	[	50	]	=	771
	LHJ_ID	[	51	]	=	772
	LHJ_ID	[	52	]	=	773
	LHJ_ID	[	53	]	=	774
	LHJ_ID	[	54	]	=	775
	LHJ_ID	[	55	]	=	776
	LHJ_ID	[	56	]	=	777
	LHJ_ID	[	57	]	=	778
	LHJ_ID	[	58	]	=	779
	LHJ_ID	[	59	]	=	780
	LHJ_ID	[	60	]	=	781
	LHJ_ID	[	61	]	=	782
	LHJ_ID	[	62	]	=	783
	LHJ_ID	[	63	]	=	784
	LHJ_ID	[	64	]	=	785
	LHJ_ID	[	65	]	=	786
	LHJ_ID	[	66	]	=	787
	LHJ_ID	[	67	]	=	788
	LHJ_ID	[	68	]	=	789
	LHJ_ID	[	69	]	=	790
	LHJ_ID	[	70	]	=	791
	LHJ_ID	[	71	]	=	792
	LHJ_ID	[	72	]	=	793
	LHJ_ID	[	73	]	=	794
	LHJ_ID	[	74	]	=	795
	LHJ_ID	[	75	]	=	796
	LHJ_ID	[	76	]	=	797
	LHJ_ID	[	77	]	=	798
	LHJ_ID	[	78	]	=	799
	LHJ_ID	[	79	]	=	800
	LHJ_ID	[	80	]	=	801
	LHJ_ID	[	81	]	=	802
	LHJ_ID	[	82	]	=	803
	LHJ_ID	[	83	]	=	804
	LHJ_ID	[	84	]	=	805
	LHJ_ID	[	85	]	=	806
	LHJ_ID	[	86	]	=	807
	LHJ_ID	[	87	]	=	808
	LHJ_ID	[	88	]	=	809
	LHJ_ID	[	89	]	=	810
	LHJ_ID	[	90	]	=	811
	LHJ_ID	[	91	]	=	812
	LHJ_ID	[	92	]	=	813
	LHJ_ID	[	93	]	=	814
	LHJ_ID	[	94	]	=	815
	LHJ_ID	[	95	]	=	816
	LHJ_ID	[	96	]	=	822
	LHJ_ID	[	97	]	=	823
	LHJ_ID	[	98	]	=	829
	LHJ_ID	[	99	]	=	1375
	LHJ_ID	[	100	]	=	1376
	LHJ_ID	[	101	]	=	1384
	LHJ_ID	[	102	]	=	1385
	LHJ_ID	[	103	]	=	1394
	LHJ_ID	[	104	]	=	1412
	LHJ_ID	[	105	]	=	1415
	LHJ_ID	[	106	]	=	1928
	LHJ_ID	[	107	]	=	1929
	LHJ_ID	[	108	]	=	1930
	LHJ_ID	[	109	]	=	1931
	LHJ_ID	[	110	]	=	1932
	LHJ_ID	[	111	]	=	1933
	LHJ_ID	[	112	]	=	1934
	LHJ_ID	[	113	]	=	1935
	LHJ_ID	[	114	]	=	1936
	LHJ_ID	[	115	]	=	1937
	LHJ_ID	[	116	]	=	1938
	LHJ_ID	[	117	]	=	1939
	LHJ_ID	[	118	]	=	1940
	LHJ_ID	[	119	]	=	1941
	LHJ_ID	[	120	]	=	1942
	LHJ_ID	[	121	]	=	1943
	LHJ_ID	[	122	]	=	1944
	LHJ_ID	[	123	]	=	1945
	LHJ_ID	[	124	]	=	1946
	LHJ_ID	[	125	]	=	1947
	LHJ_ID	[	126	]	=	1948
	LHJ_ID	[	127	]	=	1949
	LHJ_ID	[	128	]	=	1950
	LHJ_ID	[	129	]	=	1951
	LHJ_ID	[	130	]	=	1952
	LHJ_ID	[	131	]	=	1953
	LHJ_ID	[	132	]	=	1954
	LHJ_ID	[	133	]	=	1955
	LHJ_ID	[	134	]	=	1956
	LHJ_ID	[	135	]	=	1957
	LHJ_ID	[	136	]	=	1958
	LHJ_ID	[	137	]	=	1959
	LHJ_ID	[	138	]	=	1960
	LHJ_ID	[	139	]	=	1961
	LHJ_ID	[	140	]	=	1962
	LHJ_ID	[	141	]	=	1963
	LHJ_ID	[	142	]	=	1964
	LHJ_ID	[	143	]	=	1965
	LHJ_ID	[	144	]	=	1966
	LHJ_ID	[	145	]	=	1967
	LHJ_ID	[	146	]	=	1968
	LHJ_ID	[	147	]	=	1969
	LHJ_ID	[	148	]	=	1970
	LHJ_ID	[	149	]	=	1971
	LHJ_ID	[	150	]	=	1972
	LHJ_ID	[	151	]	=	1973
	LHJ_ID	[	152	]	=	1974
	LHJ_ID	[	153	]	=	1975
	LHJ_ID	[	154	]	=	1976
	LHJ_ID	[	155	]	=	1977
	LHJ_ID	[	156	]	=	1978
	LHJ_ID	[	157	]	=	1979
	LHJ_ID	[	158	]	=	1980
	LHJ_ID	[	159	]	=	1981
	LHJ_ID	[	160	]	=	1982
	LHJ_ID	[	161	]	=	1983
	LHJ_ID	[	162	]	=	1984
	LHJ_ID	[	163	]	=	1985
	LHJ_ID	[	164	]	=	1986
	LHJ_ID	[	165	]	=	1987
	LHJ_ID	[	166	]	=	2312
	LHJ_ID	[	167	]	=	2426
	LHJ_ID	[	168	]	=	2445
	LHJ_ID	[	169	]	=	2530
	LHJ_ID	[	170	]	=	2533
	LHJ_ID	[	171	]	=	2536
	LHJ_ID	[	172	]	=	2539
	LHJ_ID	[	173	]	=	2542
	LHJ_ID	[	174	]	=	2545
	LHJ_ID	[	175	]	=	3115
	LHJ_ID	[	176	]	=	3798
	LHJ_ID	[	177	]	=	3799
	LHJ_ID	[	178	]	=	3800
	LHJ_ID	[	179	]	=	3801
	LHJ_ID	[	180	]	=	3802
	LHJ_ID	[	181	]	=	3803
	LHJ_ID	[	182	]	=	3804
	LHJ_ID	[	183	]	=	3805
	LHJ_ID	[	184	]	=	3806
	LHJ_ID	[	185	]	=	3807
	LHJ_ID	[	186	]	=	3808
	LHJ_ID	[	187	]	=	3809
	LHJ_ID	[	188	]	=	3810
	LHJ_ID	[	189	]	=	3811
	LHJ_ID	[	190	]	=	3812
	LHJ_ID	[	191	]	=	3813
	LHJ_ID	[	192	]	=	3814
	LHJ_ID	[	193	]	=	3815
	LHJ_ID	[	194	]	=	3816
	LHJ_ID	[	195	]	=	3817
	LHJ_ID	[	196	]	=	3818
	LHJ_ID	[	197	]	=	3819
	LHJ_ID	[	198	]	=	4146
	LHJ_ID	[	199	]	=	4210
	LHJ_ID	[	200	]	=	4213
	LHJ_ID	[	201	]	=	239
	LHJ_ID	[	202	]	=	608
	LHJ_ID	[	203	]	=	609
	LHJ_ID	[	204	]	=	610
	LHJ_ID	[	205	]	=	611
	LHJ_ID	[	206	]	=	612
	LHJ_ID	[	207	]	=	292
	LHJ_ID	[	208	]	=	294
	LHJ_ID	[	209	]	=	468
	LHJ_ID	[	210	]	=	470
	LHJ_ID	[	211	]	=	644
	LHJ_ID	[	212	]	=	646
	LHJ_ID	[	213	]	=	2331
	LHJ_ID	[	214	]	=	2332
	LHJ_ID	[	215	]	=	2333
	LHJ_ID	[	216	]	=	2334
	LHJ_ID	[	217	]	=	2335
	LHJ_ID	[	218	]	=	2336
	LHJ_ID	[	219	]	=	2337
	LHJ_ID	[	220	]	=	2338
	LHJ_ID	[	221	]	=	2339
	LHJ_ID	[	222	]	=	2340
	LHJ_ID	[	223	]	=	2341
	LHJ_ID	[	224	]	=	2342
	LHJ_ID	[	225	]	=	2343
	LHJ_ID	[	226	]	=	2344
	LHJ_ID	[	227	]	=	2367
	LHJ_ID	[	228	]	=	2368
	LHJ_ID	[	229	]	=	2369
	LHJ_ID	[	230	]	=	2370
	LHJ_ID	[	231	]	=	2549
	LHJ_ID	[	232	]	=	2550
	LHJ_ID	[	233	]	=	2551
	LHJ_ID	[	234	]	=	2552
	LHJ_ID	[	235	]	=	2817
	LHJ_ID	[	236	]	=	2818
	LHJ_ID	[	237	]	=	2819
	LHJ_ID	[	238	]	=	2820
	LHJ_ID	[	239	]	=	2821
	LHJ_ID	[	240	]	=	2822
	LHJ_ID	[	241	]	=	2823
	LHJ_ID	[	242	]	=	2824
	LHJ_ID	[	243	]	=	2825
	LHJ_ID	[	244	]	=	2826
	LHJ_ID	[	245	]	=	2827
	LHJ_ID	[	246	]	=	2828
	LHJ_ID	[	247	]	=	2829
	LHJ_ID	[	248	]	=	2830
	LHJ_ID	[	249	]	=	2831
	LHJ_ID	[	250	]	=	2832
	LHJ_ID	[	251	]	=	2833
	LHJ_ID	[	252	]	=	2834


--	石材		
	STONE1_ID_Num = 143
	STONE1_ID	=	{}			
	STONE1_ID	[	1	]	=	3387
	STONE1_ID	[	2	]	=	1671
	STONE1_ID	[	3	]	=	1670
	STONE1_ID	[	4	]	=	4415
	STONE1_ID	[	5	]	=	4029
	STONE1_ID	[	6	]	=	4039
	STONE1_ID	[	7	]	=	1640
	STONE1_ID	[	8	]	=	1706
	STONE1_ID	[	9	]	=	3363
	STONE1_ID	[	10	]	=	3368
	STONE1_ID	[	11	]	=	1668
	STONE1_ID	[	12	]	=	1784
	STONE1_ID	[	13	]	=	4030
	STONE1_ID	[	14	]	=	4040
	STONE1_ID	[	15	]	=	1634
	STONE1_ID	[	16	]	=	4351
	STONE1_ID	[	17	]	=	4349
	STONE1_ID	[	18	]	=	1673
	STONE1_ID	[	19	]	=	3391
	STONE1_ID	[	20	]	=	3360
	STONE1_ID	[	21	]	=	1667
	STONE1_ID	[	22	]	=	1662
	STONE1_ID	[	23	]	=	3388
	STONE1_ID	[	24	]	=	1639
	STONE1_ID	[	25	]	=	1786
	STONE1_ID	[	26	]	=	3380
	STONE1_ID	[	27	]	=	1771
	STONE1_ID	[	28	]	=	4031
	STONE1_ID	[	29	]	=	4041
	STONE1_ID	[	30	]	=	3425
	STONE1_ID	[	31	]	=	1196
	STONE1_ID	[	32	]	=	3428
	STONE1_ID	[	33	]	=	1216
	STONE1_ID	[	34	]	=	1630
	STONE1_ID	[	35	]	=	1781
	STONE1_ID	[	36	]	=	4467
	STONE1_ID	[	37	]	=	1631
	STONE1_ID	[	38	]	=	1643
	STONE1_ID	[	39	]	=	1642
	STONE1_ID	[	40	]	=	1751
	STONE1_ID	[	41	]	=	4363
	STONE1_ID	[	42	]	=	1645
	STONE1_ID	[	43	]	=	3426
	STONE1_ID	[	44	]	=	1636
	STONE1_ID	[	45	]	=	4536
	STONE1_ID	[	46	]	=	3431
	STONE1_ID	[	47	]	=	1669
	STONE1_ID	[	48	]	=	1672
	STONE1_ID	[	49	]	=	3442
	STONE1_ID	[	50	]	=	3927
	STONE1_ID	[	51	]	=	1666
	STONE1_ID	[	52	]	=	1699
	STONE1_ID	[	53	]	=	4368
	STONE1_ID	[	54	]	=	4455
	STONE1_ID	[	55	]	=	3429
	STONE1_ID	[	56	]	=	3364
	STONE1_ID	[	57	]	=	4032
	STONE1_ID	[	58	]	=	4042
	STONE1_ID	[	59	]	=	4541
	STONE1_ID	[	60	]	=	1234
	STONE1_ID	[	61	]	=	1253
	STONE1_ID	[	62	]	=	3369
	STONE1_ID	[	63	]	=	1638
	STONE1_ID	[	64	]	=	4825
	STONE1_ID	[	65	]	=	1288
	STONE1_ID	[	66	]	=	1308
	STONE1_ID	[	67	]	=	1326
	STONE1_ID	[	68	]	=	3378
	STONE1_ID	[	69	]	=	4850
	STONE1_ID	[	70	]	=	4791
	STONE1_ID	[	71	]	=	4895
	STONE1_ID	[	72	]	=	3432
	STONE1_ID	[	73	]	=	3444
	STONE1_ID	[	74	]	=	3371
	STONE1_ID	[	75	]	=	1637
	STONE1_ID	[	76	]	=	3427
	STONE1_ID	[	77	]	=	3820
	STONE1_ID	[	78	]	=	4033
	STONE1_ID	[	79	]	=	4043
	STONE1_ID	[	80	]	=	4721
	STONE1_ID	[	81	]	=	1345
	STONE1_ID	[	82	]	=	3390
	STONE1_ID	[	83	]	=	3433
	STONE1_ID	[	84	]	=	3821
	STONE1_ID	[	85	]	=	1641
	STONE1_ID	[	86	]	=	1633
	STONE1_ID	[	87	]	=	3389
	STONE1_ID	[	88	]	=	3430
	STONE1_ID	[	89	]	=	3361
	STONE1_ID	[	90	]	=	1201
	STONE1_ID	[	91	]	=	1635
	STONE1_ID	[	92	]	=	1239
	STONE1_ID	[	93	]	=	1647
	STONE1_ID	[	94	]	=	1483
	STONE1_ID	[	95	]	=	1494
	STONE1_ID	[	96	]	=	1482
	STONE1_ID	[	97	]	=	4034
	STONE1_ID	[	98	]	=	4044
	STONE1_ID	[	99	]	=	3455
	STONE1_ID	[	100	]	=	1632
	STONE1_ID	[	101	]	=	3456
	STONE1_ID	[	102	]	=	1258
	STONE1_ID	[	103	]	=	1258
	STONE1_ID	[	104	]	=	3366
	STONE1_ID	[	105	]	=	1769
	STONE1_ID	[	106	]	=	1782
	STONE1_ID	[	107	]	=	1268
	STONE1_ID	[	108	]	=	1205
	STONE1_ID	[	109	]	=	1295
	STONE1_ID	[	110	]	=	1314
	STONE1_ID	[	111	]	=	1263
	STONE1_ID	[	112	]	=	3365
	STONE1_ID	[	113	]	=	4728
	STONE1_ID	[	114	]	=	1297
	STONE1_ID	[	115	]	=	1785
	STONE1_ID	[	116	]	=	1271
	STONE1_ID	[	117	]	=	4035
	STONE1_ID	[	118	]	=	4045
	STONE1_ID	[	119	]	=	1315
	STONE1_ID	[	120	]	=	1333
	STONE1_ID	[	121	]	=	1644
	STONE1_ID	[	122	]	=	1335
	STONE1_ID	[	123	]	=	1783
	STONE1_ID	[	124	]	=	1775
	STONE1_ID	[	125	]	=	2815
	STONE1_ID	[	126	]	=	1363
	STONE1_ID	[	127	]	=	1355
	STONE1_ID	[	128	]	=	1352
	STONE1_ID	[	129	]	=	1360
	STONE1_ID	[	130	]	=	3362
	STONE1_ID	[	131	]	=	3367
	STONE1_ID	[	132	]	=	1780
	STONE1_ID	[	133	]	=	3379
	STONE1_ID	[	134	]	=	4036
	STONE1_ID	[	135	]	=	4046
	STONE1_ID	[	136	]	=	1767
	STONE1_ID	[	137	]	=	1674
	STONE1_ID	[	138	]	=	4037
	STONE1_ID	[	139	]	=	4047
	STONE1_ID	[	140	]	=	2901
	STONE1_ID	[	141	]	=	4832
	STONE1_ID	[	142	]	=	4038
	STONE1_ID	[	143	]	=	4048
-------------------------------------
--	液体					
	WATER_ID_Num = 37
	WATER_ID	=	{}			
	WATER_ID	[	1	]	=	1585
	WATER_ID	[	2	]	=	4318
	WATER_ID	[	3	]	=	1648
	WATER_ID	[	4	]	=	1705
	WATER_ID	[	5	]	=	1650
	WATER_ID	[	6	]	=	1681
	WATER_ID	[	7	]	=	1844
	WATER_ID	[	8	]	=	4488
	WATER_ID	[	9	]	=	1649
	WATER_ID	[	10	]	=	4340
	WATER_ID	[	11	]	=	4475
	WATER_ID	[	12	]	=	1628
	WATER_ID	[	13	]	=	1651
	WATER_ID	[	14	]	=	1627
	WATER_ID	[	15	]	=	1629
	WATER_ID	[	16	]	=	1726
	WATER_ID	[	17	]	=	4441
	WATER_ID	[	18	]	=	1838
	WATER_ID	[	19	]	=	4514
	WATER_ID	[	20	]	=	4924
	WATER_ID	[	21	]	=	4931
	WATER_ID	[	22	]	=	4951
	WATER_ID	[	23	]	=	4925
	WATER_ID	[	24	]	=	1652
	WATER_ID	[	25	]	=	4482
	WATER_ID	[	26	]	=	4945
	WATER_ID	[	27	]	=	4963
	WATER_ID	[	28	]	=	4969
	WATER_ID	[	29	]	=	4988
	WATER_ID	[	30	]	=	1289
	WATER_ID	[	31	]	=	1309
	WATER_ID	[	32	]	=	1327
	WATER_ID	[	33	]	=	1346
	WATER_ID	[	34	]	=	1294
	WATER_ID	[	35	]	=	1313
	WATER_ID	[	36	]	=	1332
	WATER_ID	[	37	]	=	1351

------------------------------------------------
--	骨头		
	BONE_ID_Num = 176
	BONE_ID	=	{}			
	BONE_ID	[	1	]	=	1583
	BONE_ID	[	2	]	=	4319
	BONE_ID	[	3	]	=	4507
	BONE_ID	[	4	]	=	4400
	BONE_ID	[	5	]	=	1610
	BONE_ID	[	6	]	=	1623
	BONE_ID	[	7	]	=	4327
	BONE_ID	[	8	]	=	4328
	BONE_ID	[	9	]	=	4408
	BONE_ID	[	10	]	=	1843
	BONE_ID	[	11	]	=	4410
	BONE_ID	[	12	]	=	1614
	BONE_ID	[	13	]	=	4330
	BONE_ID	[	14	]	=	4409
	BONE_ID	[	15	]	=	1584
	BONE_ID	[	16	]	=	4414
	BONE_ID	[	17	]	=	4331
	BONE_ID	[	18	]	=	4412
	BONE_ID	[	19	]	=	4487
	BONE_ID	[	20	]	=	1611
	BONE_ID	[	21	]	=	1720
	BONE_ID	[	22	]	=	1617
	BONE_ID	[	23	]	=	1696
	BONE_ID	[	24	]	=	4335
	BONE_ID	[	25	]	=	4336
	BONE_ID	[	26	]	=	4420
	BONE_ID	[	27	]	=	4337
	BONE_ID	[	28	]	=	4339
	BONE_ID	[	29	]	=	4423
	BONE_ID	[	30	]	=	4490
	BONE_ID	[	31	]	=	4388
	BONE_ID	[	32	]	=	4497
	BONE_ID	[	33	]	=	1709
	BONE_ID	[	34	]	=	4427
	BONE_ID	[	35	]	=	4342
	BONE_ID	[	36	]	=	1618
	BONE_ID	[	37	]	=	4344
	BONE_ID	[	38	]	=	1682
	BONE_ID	[	39	]	=	4346
	BONE_ID	[	40	]	=	4430
	BONE_ID	[	41	]	=	1677
	BONE_ID	[	42	]	=	4500
	BONE_ID	[	43	]	=	4379
	BONE_ID	[	44	]	=	4432
	BONE_ID	[	45	]	=	4376
	BONE_ID	[	46	]	=	4373
	BONE_ID	[	47	]	=	4493
	BONE_ID	[	48	]	=	4383
	BONE_ID	[	49	]	=	4356
	BONE_ID	[	50	]	=	4371
	BONE_ID	[	51	]	=	4480
	BONE_ID	[	52	]	=	4439
	BONE_ID	[	53	]	=	4377
	BONE_ID	[	54	]	=	4513
	BONE_ID	[	55	]	=	4465
	BONE_ID	[	56	]	=	1842
	BONE_ID	[	57	]	=	4374
	BONE_ID	[	58	]	=	4443
	BONE_ID	[	59	]	=	1624
	BONE_ID	[	60	]	=	1688
	BONE_ID	[	61	]	=	4446
	BONE_ID	[	62	]	=	4509
	BONE_ID	[	63	]	=	4930
	BONE_ID	[	64	]	=	4950
	BONE_ID	[	65	]	=	3434
	BONE_ID	[	66	]	=	4451
	BONE_ID	[	67	]	=	3435
	BONE_ID	[	68	]	=	4469
	BONE_ID	[	69	]	=	3436
	BONE_ID	[	70	]	=	3437
	BONE_ID	[	71	]	=	1717
	BONE_ID	[	72	]	=	4386
	BONE_ID	[	73	]	=	4534
	BONE_ID	[	74	]	=	4449
	BONE_ID	[	75	]	=	4381
	BONE_ID	[	76	]	=	4468
	BONE_ID	[	77	]	=	4384
	BONE_ID	[	78	]	=	4385
	BONE_ID	[	79	]	=	3449
	BONE_ID	[	80	]	=	4395
	BONE_ID	[	81	]	=	4365
	BONE_ID	[	82	]	=	4453
	BONE_ID	[	83	]	=	1713
	BONE_ID	[	84	]	=	4521
	BONE_ID	[	85	]	=	4537
	BONE_ID	[	86	]	=	4324
	BONE_ID	[	87	]	=	3450
	BONE_ID	[	88	]	=	1612
	BONE_ID	[	89	]	=	3451
	BONE_ID	[	90	]	=	4968
	BONE_ID	[	91	]	=	4539
	BONE_ID	[	92	]	=	1715
	BONE_ID	[	93	]	=	4353
	BONE_ID	[	94	]	=	4987
	BONE_ID	[	95	]	=	1616
	BONE_ID	[	96	]	=	3452
	BONE_ID	[	97	]	=	4908
	BONE_ID	[	98	]	=	4524
	BONE_ID	[	99	]	=	4909
	BONE_ID	[	100	]	=	4717
	BONE_ID	[	101	]	=	4821
	BONE_ID	[	102	]	=	1613
	BONE_ID	[	103	]	=	1176
	BONE_ID	[	104	]	=	4542
	BONE_ID	[	105	]	=	4822
	BONE_ID	[	106	]	=	4746
	BONE_ID	[	107	]	=	4824
	BONE_ID	[	108	]	=	1199
	BONE_ID	[	109	]	=	4812
	BONE_ID	[	110	]	=	1710
	BONE_ID	[	111	]	=	1219
	BONE_ID	[	112	]	=	1683
	BONE_ID	[	113	]	=	4753
	BONE_ID	[	114	]	=	1334
	BONE_ID	[	115	]	=	4979
	BONE_ID	[	116	]	=	1237
	BONE_ID	[	117	]	=	1353
	BONE_ID	[	118	]	=	4998
	BONE_ID	[	119	]	=	4883
	BONE_ID	[	120	]	=	1182
	BONE_ID	[	121	]	=	1364
	BONE_ID	[	122	]	=	167
	BONE_ID	[	123	]	=	1179
	BONE_ID	[	124	]	=	1361
	BONE_ID	[	125	]	=	4835
	BONE_ID	[	126	]	=	1183
	BONE_ID	[	127	]	=	1365
	BONE_ID	[	128	]	=	4858
	BONE_ID	[	129	]	=	4886
	BONE_ID	[	130	]	=	1202
	BONE_ID	[	131	]	=	1293
	BONE_ID	[	132	]	=	4938
	BONE_ID	[	133	]	=	4818
	BONE_ID	[	134	]	=	1693
	BONE_ID	[	135	]	=	1312
	BONE_ID	[	136	]	=	4957
	BONE_ID	[	137	]	=	1684
	BONE_ID	[	138	]	=	1221
	BONE_ID	[	139	]	=	1240
	BONE_ID	[	140	]	=	4976
	BONE_ID	[	141	]	=	1331
	BONE_ID	[	142	]	=	4897
	BONE_ID	[	143	]	=	4828
	BONE_ID	[	144	]	=	4783
	BONE_ID	[	145	]	=	4887
	BONE_ID	[	146	]	=	1485
	BONE_ID	[	147	]	=	4737
	BONE_ID	[	148	]	=	1259
	BONE_ID	[	149	]	=	4995
	BONE_ID	[	150	]	=	1774
	BONE_ID	[	151	]	=	1350
	BONE_ID	[	152	]	=	4860
	BONE_ID	[	153	]	=	1204
	BONE_ID	[	154	]	=	1223
	BONE_ID	[	155	]	=	3063
	BONE_ID	[	156	]	=	4716
	BONE_ID	[	157	]	=	2419
	BONE_ID	[	158	]	=	2488
	BONE_ID	[	159	]	=	4742
	BONE_ID	[	160	]	=	1224
	BONE_ID	[	161	]	=	1242
	BONE_ID	[	162	]	=	4761
	BONE_ID	[	163	]	=	4889
	BONE_ID	[	164	]	=	3067
	BONE_ID	[	165	]	=	1272
	BONE_ID	[	166	]	=	1264
	BONE_ID	[	167	]	=	1261
	BONE_ID	[	168	]	=	4767
	BONE_ID	[	169	]	=	1269
	BONE_ID	[	170	]	=	4891
	BONE_ID	[	171	]	=	1716
	BONE_ID	[	172	]	=	1492
	BONE_ID	[	173	]	=	1625
	BONE_ID	[	174	]	=	1711
	BONE_ID	[	175	]	=	1758
	BONE_ID	[	176	]	=	1626

------------------------------------------
--	毛皮		
	SKIP_ID_Num = 97
	SKIP_ID	=	{}			
	SKIP_ID	[	1	]	=	4317
	SKIP_ID	[	2	]	=	1695
	SKIP_ID	[	3	]	=	4405
	SKIP_ID	[	4	]	=	4486
	SKIP_ID	[	5	]	=	4407
	SKIP_ID	[	6	]	=	1678
	SKIP_ID	[	7	]	=	1679
	SKIP_ID	[	8	]	=	4413
	SKIP_ID	[	9	]	=	4333
	SKIP_ID	[	10	]	=	4334
	SKIP_ID	[	11	]	=	4416
	SKIP_ID	[	12	]	=	3383
	SKIP_ID	[	13	]	=	1603
	SKIP_ID	[	14	]	=	1604
	SKIP_ID	[	15	]	=	1707
	SKIP_ID	[	16	]	=	1605
	SKIP_ID	[	17	]	=	4422
	SKIP_ID	[	18	]	=	4489
	SKIP_ID	[	19	]	=	4341
	SKIP_ID	[	20	]	=	1845
	SKIP_ID	[	21	]	=	3384
	SKIP_ID	[	22	]	=	4347
	SKIP_ID	[	23	]	=	4479
	SKIP_ID	[	24	]	=	4470
	SKIP_ID	[	25	]	=	4458
	SKIP_ID	[	26	]	=	1608
	SKIP_ID	[	27	]	=	4512
	SKIP_ID	[	28	]	=	4929
	SKIP_ID	[	29	]	=	4949
	SKIP_ID	[	30	]	=	4359
	SKIP_ID	[	31	]	=	3932
	SKIP_ID	[	32	]	=	1721
	SKIP_ID	[	33	]	=	4364
	SKIP_ID	[	34	]	=	4516
	SKIP_ID	[	35	]	=	1287
	SKIP_ID	[	36	]	=	1307
	SKIP_ID	[	37	]	=	4517
	SKIP_ID	[	38	]	=	1606
	SKIP_ID	[	39	]	=	4380
	SKIP_ID	[	40	]	=	4967
	SKIP_ID	[	41	]	=	4519
	SKIP_ID	[	42	]	=	4986
	SKIP_ID	[	43	]	=	1607
	SKIP_ID	[	44	]	=	4472
	SKIP_ID	[	45	]	=	1609
	SKIP_ID	[	46	]	=	4474
	SKIP_ID	[	47	]	=	4522
	SKIP_ID	[	48	]	=	1619
	SKIP_ID	[	49	]	=	4820
	SKIP_ID	[	50	]	=	4805
	SKIP_ID	[	51	]	=	1325
	SKIP_ID	[	52	]	=	1344
	SKIP_ID	[	53	]	=	2396
	SKIP_ID	[	54	]	=	4933
	SKIP_ID	[	55	]	=	4953
	SKIP_ID	[	56	]	=	4934
	SKIP_ID	[	57	]	=	4971
	SKIP_ID	[	58	]	=	176
	SKIP_ID	[	59	]	=	178
	SKIP_ID	[	60	]	=	4954
	SKIP_ID	[	61	]	=	4972
	SKIP_ID	[	62	]	=	1290
	SKIP_ID	[	63	]	=	1310
	SKIP_ID	[	64	]	=	1729
	SKIP_ID	[	65	]	=	1328
	SKIP_ID	[	66	]	=	4857
	SKIP_ID	[	67	]	=	3385
	SKIP_ID	[	68	]	=	160
	SKIP_ID	[	69	]	=	161
	SKIP_ID	[	70	]	=	175
	SKIP_ID	[	71	]	=	177
	SKIP_ID	[	72	]	=	4779
	SKIP_ID	[	73	]	=	4780
	SKIP_ID	[	74	]	=	4884
	SKIP_ID	[	75	]	=	4990
	SKIP_ID	[	76	]	=	4991
	SKIP_ID	[	77	]	=	4459
	SKIP_ID	[	78	]	=	4731
	SKIP_ID	[	79	]	=	4936
	SKIP_ID	[	80	]	=	4956
	SKIP_ID	[	81	]	=	4782
	SKIP_ID	[	82	]	=	1697
	SKIP_ID	[	83	]	=	4939
	SKIP_ID	[	84	]	=	4896
	SKIP_ID	[	85	]	=	4958
	SKIP_ID	[	86	]	=	4977
	SKIP_ID	[	87	]	=	4724
	SKIP_ID	[	88	]	=	4974
	SKIP_ID	[	89	]	=	1347
	SKIP_ID	[	90	]	=	4993
	SKIP_ID	[	91	]	=	1730
	SKIP_ID	[	92	]	=	4756
	SKIP_ID	[	93	]	=	4996
	SKIP_ID	[	94	]	=	1712
	SKIP_ID	[	95	]	=	1734
	SKIP_ID	[	96	]	=	1621
	SKIP_ID	[	97	]	=	1703

-------------------------------------------------
--	植物			
	TREE_ID_Num = 72
	TREE_ID	=	{}			
	TREE_ID	[	1	]	=	1576
	TREE_ID	[	2	]	=	1575
	TREE_ID	[	3	]	=	1597
	TREE_ID	[	4	]	=	1691
	TREE_ID	[	5	]	=	4314
	TREE_ID	[	6	]	=	4315
	TREE_ID	[	7	]	=	4316
	TREE_ID	[	8	]	=	4396
	TREE_ID	[	9	]	=	4397
	TREE_ID	[	10	]	=	4398
	TREE_ID	[	11	]	=	4506
	TREE_ID	[	12	]	=	1577
	TREE_ID	[	13	]	=	1574
	TREE_ID	[	14	]	=	1579
	TREE_ID	[	15	]	=	1600
	TREE_ID	[	16	]	=	1692
	TREE_ID	[	17	]	=	3372
	TREE_ID	[	18	]	=	4322
	TREE_ID	[	19	]	=	4323
	TREE_ID	[	20	]	=	4401
	TREE_ID	[	21	]	=	4403
	TREE_ID	[	22	]	=	4483
	TREE_ID	[	23	]	=	4508
	TREE_ID	[	24	]	=	1725
	TREE_ID	[	25	]	=	4406
	TREE_ID	[	26	]	=	4049
	TREE_ID	[	27	]	=	4338
	TREE_ID	[	28	]	=	4421
	TREE_ID	[	29	]	=	1601
	TREE_ID	[	30	]	=	1685
	TREE_ID	[	31	]	=	1686
	TREE_ID	[	32	]	=	1846
	TREE_ID	[	33	]	=	4343
	TREE_ID	[	34	]	=	4477
	TREE_ID	[	35	]	=	4345
	TREE_ID	[	36	]	=	4429
	TREE_ID	[	37	]	=	4050
	TREE_ID	[	38	]	=	4466
	TREE_ID	[	39	]	=	4389
	TREE_ID	[	40	]	=	4476
	TREE_ID	[	41	]	=	1212
	TREE_ID	[	42	]	=	1303
	TREE_ID	[	43	]	=	4511
	TREE_ID	[	44	]	=	4527
	TREE_ID	[	45	]	=	4948
	TREE_ID	[	46	]	=	1230
	TREE_ID	[	47	]	=	1321
	TREE_ID	[	48	]	=	4352
	TREE_ID	[	49	]	=	4966
	TREE_ID	[	50	]	=	1192
	TREE_ID	[	51	]	=	1283
	TREE_ID	[	52	]	=	4928
	TREE_ID	[	53	]	=	1249
	TREE_ID	[	54	]	=	1340
	TREE_ID	[	55	]	=	4378
	TREE_ID	[	56	]	=	4985
	TREE_ID	[	57	]	=	1593
	TREE_ID	[	58	]	=	1578
	TREE_ID	[	59	]	=	4060
	TREE_ID	[	60	]	=	4804
	TREE_ID	[	61	]	=	4915
	TREE_ID	[	62	]	=	4055
	TREE_ID	[	63	]	=	4730
	TREE_ID	[	64	]	=	4061
	TREE_ID	[	65	]	=	4790
	TREE_ID	[	66	]	=	4894
	TREE_ID	[	67	]	=	4864
	TREE_ID	[	68	]	=	4727
	TREE_ID	[	69	]	=	4831
	TREE_ID	[	70	]	=	2225
	TREE_ID	[	71	]	=	4057
	TREE_ID	[	72	]	=	1768

--------------------------------------------
--	食料	
	FOOD_ID_Num = 151
	FOOD_ID	=	{}			
	FOOD_ID	[	1	]	=	1690
	FOOD_ID	[	2	]	=	1622
	FOOD_ID	[	3	]	=	4320
	FOOD_ID	[	4	]	=	1587
	FOOD_ID	[	5	]	=	4484
	FOOD_ID	[	6	]	=	1676
	FOOD_ID	[	7	]	=	1704
	FOOD_ID	[	8	]	=	1746
	FOOD_ID	[	9	]	=	4404
	FOOD_ID	[	10	]	=	4325
	FOOD_ID	[	11	]	=	4329
	FOOD_ID	[	12	]	=	4411
	FOOD_ID	[	13	]	=	1595
	FOOD_ID	[	14	]	=	1680
	FOOD_ID	[	15	]	=	4417
	FOOD_ID	[	16	]	=	4009
	FOOD_ID	[	17	]	=	1722
	FOOD_ID	[	18	]	=	4419
	FOOD_ID	[	19	]	=	1689
	FOOD_ID	[	20	]	=	4425
	FOOD_ID	[	21	]	=	4426
	FOOD_ID	[	22	]	=	4491
	FOOD_ID	[	23	]	=	4390
	FOOD_ID	[	24	]	=	4428
	FOOD_ID	[	25	]	=	4457
	FOOD_ID	[	26	]	=	4494
	FOOD_ID	[	27	]	=	4010
	FOOD_ID	[	28	]	=	4463
	FOOD_ID	[	29	]	=	4433
	FOOD_ID	[	30	]	=	4442
	FOOD_ID	[	31	]	=	4393
	FOOD_ID	[	32	]	=	4528
	FOOD_ID	[	33	]	=	4355
	FOOD_ID	[	34	]	=	4464
	FOOD_ID	[	35	]	=	4529
	FOOD_ID	[	36	]	=	4530
	FOOD_ID	[	37	]	=	1193
	FOOD_ID	[	38	]	=	1213
	FOOD_ID	[	39	]	=	1284
	FOOD_ID	[	40	]	=	1304
	FOOD_ID	[	41	]	=	1188
	FOOD_ID	[	42	]	=	1279
	FOOD_ID	[	43	]	=	4357
	FOOD_ID	[	44	]	=	4461
	FOOD_ID	[	45	]	=	4011
	FOOD_ID	[	46	]	=	1194
	FOOD_ID	[	47	]	=	1214
	FOOD_ID	[	48	]	=	1285
	FOOD_ID	[	49	]	=	1305
	FOOD_ID	[	50	]	=	1195
	FOOD_ID	[	51	]	=	1286
	FOOD_ID	[	52	]	=	4532
	FOOD_ID	[	53	]	=	1215
	FOOD_ID	[	54	]	=	1306
	FOOD_ID	[	55	]	=	4382
	FOOD_ID	[	56	]	=	4533
	FOOD_ID	[	57	]	=	1231
	FOOD_ID	[	58	]	=	1322
	FOOD_ID	[	59	]	=	4473
	FOOD_ID	[	60	]	=	4518
	FOOD_ID	[	61	]	=	1250
	FOOD_ID	[	62	]	=	1341
	FOOD_ID	[	63	]	=	4535
	FOOD_ID	[	64	]	=	1189
	FOOD_ID	[	65	]	=	1280
	FOOD_ID	[	66	]	=	4520
	FOOD_ID	[	67	]	=	1209
	FOOD_ID	[	68	]	=	1300
	FOOD_ID	[	69	]	=	4366
	FOOD_ID	[	70	]	=	4452
	FOOD_ID	[	71	]	=	1218
	FOOD_ID	[	72	]	=	1227
	FOOD_ID	[	73	]	=	1318
	FOOD_ID	[	74	]	=	4387
	FOOD_ID	[	75	]	=	4462
	FOOD_ID	[	76	]	=	1232
	FOOD_ID	[	77	]	=	1323
	FOOD_ID	[	78	]	=	4012
	FOOD_ID	[	79	]	=	1251
	FOOD_ID	[	80	]	=	1342
	FOOD_ID	[	81	]	=	1233
	FOOD_ID	[	82	]	=	1324
	FOOD_ID	[	83	]	=	4540
	FOOD_ID	[	84	]	=	1252
	FOOD_ID	[	85	]	=	1343
	FOOD_ID	[	86	]	=	4525
	FOOD_ID	[	87	]	=	1267
	FOOD_ID	[	88	]	=	1358
	FOOD_ID	[	89	]	=	1197
	FOOD_ID	[	90	]	=	1217
	FOOD_ID	[	91	]	=	4809
	FOOD_ID	[	92	]	=	1198
	FOOD_ID	[	93	]	=	1235
	FOOD_ID	[	94	]	=	4786
	FOOD_ID	[	95	]	=	4890
	FOOD_ID	[	96	]	=	165
	FOOD_ID	[	97	]	=	1236
	FOOD_ID	[	98	]	=	4720
	FOOD_ID	[	99	]	=	4935
	FOOD_ID	[	100	]	=	4955
	FOOD_ID	[	101	]	=	4013
	FOOD_ID	[	102	]	=	1243
	FOOD_ID	[	103	]	=	4973
	FOOD_ID	[	104	]	=	1262
	FOOD_ID	[	105	]	=	1270
	FOOD_ID	[	106	]	=	1273
	FOOD_ID	[	107	]	=	1254
	FOOD_ID	[	108	]	=	1255
	FOOD_ID	[	109	]	=	1200
	FOOD_ID	[	110	]	=	1274
	FOOD_ID	[	111	]	=	1291
	FOOD_ID	[	112	]	=	1220
	FOOD_ID	[	113	]	=	1292
	FOOD_ID	[	114	]	=	1311
	FOOD_ID	[	115	]	=	4937
	FOOD_ID	[	116	]	=	1330
	FOOD_ID	[	117	]	=	4975
	FOOD_ID	[	118	]	=	1735
	FOOD_ID	[	119	]	=	3062
	FOOD_ID	[	120	]	=	4014
	FOOD_ID	[	121	]	=	1203
	FOOD_ID	[	122	]	=	1222
	FOOD_ID	[	123	]	=	1241
	FOOD_ID	[	124	]	=	4792
	FOOD_ID	[	125	]	=	4793
	FOOD_ID	[	126	]	=	1238
	FOOD_ID	[	127	]	=	1329
	FOOD_ID	[	128	]	=	4735
	FOOD_ID	[	129	]	=	1256
	FOOD_ID	[	130	]	=	1257
	FOOD_ID	[	131	]	=	1348
	FOOD_ID	[	132	]	=	4992
	FOOD_ID	[	133	]	=	1349
	FOOD_ID	[	134	]	=	3064
	FOOD_ID	[	135	]	=	4994
	FOOD_ID	[	136	]	=	1177
	FOOD_ID	[	137	]	=	1260
	FOOD_ID	[	138	]	=	1359
	FOOD_ID	[	139	]	=	1296
	FOOD_ID	[	140	]	=	4759
	FOOD_ID	[	141	]	=	4941
	FOOD_ID	[	142	]	=	1354
	FOOD_ID	[	143	]	=	4999
	FOOD_ID	[	144	]	=	1180
	FOOD_ID	[	145	]	=	1362
	FOOD_ID	[	146	]	=	3069
	FOOD_ID	[	147	]	=	4015
	FOOD_ID	[	148	]	=	4785
	FOOD_ID	[	149	]	=	4016
	FOOD_ID	[	150	]	=	4017
	FOOD_ID	[	151	]	=	4018

-------------------------------------
--	特殊	
	SPECIL_ID_Num = 346
	SPECIL_ID	=	{}			
	SPECIL_ID	[	1	]	=	1573
	SPECIL_ID	[	2	]	=	4399
	SPECIL_ID	[	3	]	=	1620
	SPECIL_ID	[	4	]	=	1777
	SPECIL_ID	[	5	]	=	1839
	SPECIL_ID	[	6	]	=	4402
	SPECIL_ID	[	7	]	=	1840
	SPECIL_ID	[	8	]	=	4485
	SPECIL_ID	[	9	]	=	1779
	SPECIL_ID	[	10	]	=	1654
	SPECIL_ID	[	11	]	=	4332
	SPECIL_ID	[	12	]	=	1719
	SPECIL_ID	[	13	]	=	1778
	SPECIL_ID	[	14	]	=	4418
	SPECIL_ID	[	15	]	=	1752
	SPECIL_ID	[	16	]	=	3381
	SPECIL_ID	[	17	]	=	4503
	SPECIL_ID	[	18	]	=	1708
	SPECIL_ID	[	19	]	=	1658
	SPECIL_ID	[	20	]	=	1747
	SPECIL_ID	[	21	]	=	3929
	SPECIL_ID	[	22	]	=	4370
	SPECIL_ID	[	23	]	=	4391
	SPECIL_ID	[	24	]	=	4431
	SPECIL_ID	[	25	]	=	4492
	SPECIL_ID	[	26	]	=	1661
	SPECIL_ID	[	27	]	=	1698
	SPECIL_ID	[	28	]	=	4392
	SPECIL_ID	[	29	]	=	4434
	SPECIL_ID	[	30	]	=	1773
	SPECIL_ID	[	31	]	=	4438
	SPECIL_ID	[	32	]	=	4460
	SPECIL_ID	[	33	]	=	1759
	SPECIL_ID	[	34	]	=	4436
	SPECIL_ID	[	35	]	=	1749
	SPECIL_ID	[	36	]	=	1753
	SPECIL_ID	[	37	]	=	1841
	SPECIL_ID	[	38	]	=	3933
	SPECIL_ID	[	39	]	=	4350
	SPECIL_ID	[	40	]	=	4437
	SPECIL_ID	[	41	]	=	4445
	SPECIL_ID	[	42	]	=	1749
	SPECIL_ID	[	43	]	=	4501
	SPECIL_ID	[	44	]	=	3382
	SPECIL_ID	[	45	]	=	4354
	SPECIL_ID	[	46	]	=	4440
	SPECIL_ID	[	47	]	=	1728
	SPECIL_ID	[	48	]	=	4348
	SPECIL_ID	[	49	]	=	4435
	SPECIL_ID	[	50	]	=	4394
	SPECIL_ID	[	51	]	=	4481
	SPECIL_ID	[	52	]	=	4496
	SPECIL_ID	[	53	]	=	4502
	SPECIL_ID	[	54	]	=	3793
	SPECIL_ID	[	55	]	=	4358
	SPECIL_ID	[	56	]	=	4444
	SPECIL_ID	[	57	]	=	4478
	SPECIL_ID	[	58	]	=	1739
	SPECIL_ID	[	59	]	=	1757
	SPECIL_ID	[	60	]	=	3790
	SPECIL_ID	[	61	]	=	3794
	SPECIL_ID	[	62	]	=	4498
	SPECIL_ID	[	63	]	=	4504
	SPECIL_ID	[	64	]	=	4515
	SPECIL_ID	[	65	]	=	4531
	SPECIL_ID	[	66	]	=	4372
	SPECIL_ID	[	67	]	=	4424
	SPECIL_ID	[	68	]	=	1657
	SPECIL_ID	[	69	]	=	1754
	SPECIL_ID	[	70	]	=	4932
	SPECIL_ID	[	71	]	=	4360
	SPECIL_ID	[	72	]	=	4361
	SPECIL_ID	[	73	]	=	4447
	SPECIL_ID	[	74	]	=	4510
	SPECIL_ID	[	75	]	=	4952
	SPECIL_ID	[	76	]	=	1653
	SPECIL_ID	[	77	]	=	4448
	SPECIL_ID	[	78	]	=	4499
	SPECIL_ID	[	79	]	=	4505
	SPECIL_ID	[	80	]	=	1655
	SPECIL_ID	[	81	]	=	4362
	SPECIL_ID	[	82	]	=	4450
	SPECIL_ID	[	83	]	=	4471
	SPECIL_ID	[	84	]	=	3438
	SPECIL_ID	[	85	]	=	3439
	SPECIL_ID	[	86	]	=	3935
	SPECIL_ID	[	87	]	=	4367
	SPECIL_ID	[	88	]	=	4454
	SPECIL_ID	[	89	]	=	3440
	SPECIL_ID	[	90	]	=	3441
	SPECIL_ID	[	91	]	=	4369
	SPECIL_ID	[	92	]	=	4456
	SPECIL_ID	[	93	]	=	4523
	SPECIL_ID	[	94	]	=	3791
	SPECIL_ID	[	95	]	=	3795
	SPECIL_ID	[	96	]	=	4732
	SPECIL_ID	[	97	]	=	4836
	SPECIL_ID	[	98	]	=	4803
	SPECIL_ID	[	99	]	=	4907
	SPECIL_ID	[	100	]	=	4806
	SPECIL_ID	[	101	]	=	4861
	SPECIL_ID	[	102	]	=	4734
	SPECIL_ID	[	103	]	=	4838
	SPECIL_ID	[	104	]	=	4970
	SPECIL_ID	[	105	]	=	4989
	SPECIL_ID	[	106	]	=	3446
	SPECIL_ID	[	107	]	=	3453
	SPECIL_ID	[	108	]	=	3792
	SPECIL_ID	[	109	]	=	3796
	SPECIL_ID	[	110	]	=	4526
	SPECIL_ID	[	111	]	=	4807
	SPECIL_ID	[	112	]	=	4808
	SPECIL_ID	[	113	]	=	4862
	SPECIL_ID	[	114	]	=	4911
	SPECIL_ID	[	115	]	=	4810
	SPECIL_ID	[	116	]	=	4913
	SPECIL_ID	[	117	]	=	4914
	SPECIL_ID	[	118	]	=	4718
	SPECIL_ID	[	119	]	=	153
	SPECIL_ID	[	120	]	=	3370
	SPECIL_ID	[	121	]	=	1210
	SPECIL_ID	[	122	]	=	1301
	SPECIL_ID	[	123	]	=	4719
	SPECIL_ID	[	124	]	=	4823
	SPECIL_ID	[	125	]	=	4946
	SPECIL_ID	[	126	]	=	1211
	SPECIL_ID	[	127	]	=	1302
	SPECIL_ID	[	128	]	=	3447
	SPECIL_ID	[	129	]	=	3454
	SPECIL_ID	[	130	]	=	4757
	SPECIL_ID	[	131	]	=	4910
	SPECIL_ID	[	132	]	=	4916
	SPECIL_ID	[	133	]	=	4947
	SPECIL_ID	[	134	]	=	4758
	SPECIL_ID	[	135	]	=	4794
	SPECIL_ID	[	136	]	=	4898
	SPECIL_ID	[	137	]	=	4912
	SPECIL_ID	[	138	]	=	1185
	SPECIL_ID	[	139	]	=	1276
	SPECIL_ID	[	140	]	=	1367
	SPECIL_ID	[	141	]	=	4722
	SPECIL_ID	[	142	]	=	4795
	SPECIL_ID	[	143	]	=	4796
	SPECIL_ID	[	144	]	=	4813
	SPECIL_ID	[	145	]	=	4826
	SPECIL_ID	[	146	]	=	4899
	SPECIL_ID	[	147	]	=	4900
	SPECIL_ID	[	148	]	=	4917
	SPECIL_ID	[	149	]	=	4729
	SPECIL_ID	[	150	]	=	4833
	SPECIL_ID	[	151	]	=	1190
	SPECIL_ID	[	152	]	=	1281
	SPECIL_ID	[	153	]	=	4834
	SPECIL_ID	[	154	]	=	4926
	SPECIL_ID	[	155	]	=	1191
	SPECIL_ID	[	156	]	=	1282
	SPECIL_ID	[	157	]	=	1480
	SPECIL_ID	[	158	]	=	1481
	SPECIL_ID	[	159	]	=	1740
	SPECIL_ID	[	160	]	=	3448
	SPECIL_ID	[	161	]	=	3827
	SPECIL_ID	[	162	]	=	4814
	SPECIL_ID	[	163	]	=	4815
	SPECIL_ID	[	164	]	=	4918
	SPECIL_ID	[	165	]	=	4919
	SPECIL_ID	[	166	]	=	4920
	SPECIL_ID	[	167	]	=	4927
	SPECIL_ID	[	168	]	=	3822
	SPECIL_ID	[	169	]	=	4733
	SPECIL_ID	[	170	]	=	4781
	SPECIL_ID	[	171	]	=	4797
	SPECIL_ID	[	172	]	=	4798
	SPECIL_ID	[	173	]	=	4837
	SPECIL_ID	[	174	]	=	4885
	SPECIL_ID	[	175	]	=	4901
	SPECIL_ID	[	176	]	=	4902
	SPECIL_ID	[	177	]	=	1184
	SPECIL_ID	[	178	]	=	1275
	SPECIL_ID	[	179	]	=	1366
	SPECIL_ID	[	180	]	=	4754
	SPECIL_ID	[	181	]	=	4799
	SPECIL_ID	[	182	]	=	4817
	SPECIL_ID	[	183	]	=	4903
	SPECIL_ID	[	184	]	=	4921
	SPECIL_ID	[	185	]	=	1228
	SPECIL_ID	[	186	]	=	1319
	SPECIL_ID	[	187	]	=	3823
	SPECIL_ID	[	188	]	=	4775
	SPECIL_ID	[	189	]	=	4879
	SPECIL_ID	[	190	]	=	4964
	SPECIL_ID	[	191	]	=	1229
	SPECIL_ID	[	192	]	=	1320
	SPECIL_ID	[	193	]	=	1493
	SPECIL_ID	[	194	]	=	1504
	SPECIL_ID	[	195	]	=	1505
	SPECIL_ID	[	196	]	=	1742
	SPECIL_ID	[	197	]	=	1763
	SPECIL_ID	[	198	]	=	3386
	SPECIL_ID	[	199	]	=	4819
	SPECIL_ID	[	200	]	=	4922
	SPECIL_ID	[	201	]	=	4965
	SPECIL_ID	[	202	]	=	3824
	SPECIL_ID	[	203	]	=	1186
	SPECIL_ID	[	204	]	=	1277
	SPECIL_ID	[	205	]	=	1368
	SPECIL_ID	[	206	]	=	1788
	SPECIL_ID	[	207	]	=	4839
	SPECIL_ID	[	208	]	=	1790
	SPECIL_ID	[	209	]	=	4736
	SPECIL_ID	[	210	]	=	4840
	SPECIL_ID	[	211	]	=	1484
	SPECIL_ID	[	212	]	=	1495
	SPECIL_ID	[	213	]	=	1791
	SPECIL_ID	[	214	]	=	3825
	SPECIL_ID	[	215	]	=	3826
	SPECIL_ID	[	216	]	=	4841
	SPECIL_ID	[	217	]	=	1793
	SPECIL_ID	[	218	]	=	4606
	SPECIL_ID	[	219	]	=	4762
	SPECIL_ID	[	220	]	=	4866
	SPECIL_ID	[	221	]	=	4608
	SPECIL_ID	[	222	]	=	4776
	SPECIL_ID	[	223	]	=	4800
	SPECIL_ID	[	224	]	=	4880
	SPECIL_ID	[	225	]	=	4904
	SPECIL_ID	[	226	]	=	4940
	SPECIL_ID	[	227	]	=	4788
	SPECIL_ID	[	228	]	=	4789
	SPECIL_ID	[	229	]	=	4801
	SPECIL_ID	[	230	]	=	4802
	SPECIL_ID	[	231	]	=	4892
	SPECIL_ID	[	232	]	=	4893
	SPECIL_ID	[	233	]	=	4905
	SPECIL_ID	[	234	]	=	4906
	SPECIL_ID	[	235	]	=	4959
	SPECIL_ID	[	236	]	=	1206
	SPECIL_ID	[	237	]	=	1247
	SPECIL_ID	[	238	]	=	1338
	SPECIL_ID	[	239	]	=	4738
	SPECIL_ID	[	240	]	=	4739
	SPECIL_ID	[	241	]	=	4740
	SPECIL_ID	[	242	]	=	4741
	SPECIL_ID	[	243	]	=	4842
	SPECIL_ID	[	244	]	=	4843
	SPECIL_ID	[	245	]	=	4844
	SPECIL_ID	[	246	]	=	4845
	SPECIL_ID	[	247	]	=	4942
	SPECIL_ID	[	248	]	=	4983
	SPECIL_ID	[	249	]	=	1248
	SPECIL_ID	[	250	]	=	1339
	SPECIL_ID	[	251	]	=	1486
	SPECIL_ID	[	252	]	=	1487
	SPECIL_ID	[	253	]	=	1488
	SPECIL_ID	[	254	]	=	1489
	SPECIL_ID	[	255	]	=	1497
	SPECIL_ID	[	256	]	=	1498
	SPECIL_ID	[	257	]	=	1499
	SPECIL_ID	[	258	]	=	1500
	SPECIL_ID	[	259	]	=	3085
	SPECIL_ID	[	260	]	=	4984
	SPECIL_ID	[	261	]	=	1207
	SPECIL_ID	[	262	]	=	1298
	SPECIL_ID	[	263	]	=	4743
	SPECIL_ID	[	264	]	=	4744
	SPECIL_ID	[	265	]	=	4777
	SPECIL_ID	[	266	]	=	4846
	SPECIL_ID	[	267	]	=	4847
	SPECIL_ID	[	268	]	=	4848
	SPECIL_ID	[	269	]	=	4881
	SPECIL_ID	[	270	]	=	4943
	SPECIL_ID	[	271	]	=	4960
	SPECIL_ID	[	272	]	=	1208
	SPECIL_ID	[	273	]	=	1299
	SPECIL_ID	[	274	]	=	4745
	SPECIL_ID	[	275	]	=	4778
	SPECIL_ID	[	276	]	=	4849
	SPECIL_ID	[	277	]	=	4882
	SPECIL_ID	[	278	]	=	4944
	SPECIL_ID	[	279	]	=	4978
	SPECIL_ID	[	280	]	=	1187
	SPECIL_ID	[	281	]	=	1244
	SPECIL_ID	[	282	]	=	1278
	SPECIL_ID	[	283	]	=	1369
	SPECIL_ID	[	284	]	=	4725
	SPECIL_ID	[	285	]	=	4748
	SPECIL_ID	[	286	]	=	4749
	SPECIL_ID	[	287	]	=	4829
	SPECIL_ID	[	288	]	=	4852
	SPECIL_ID	[	289	]	=	4853
	SPECIL_ID	[	290	]	=	4980
	SPECIL_ID	[	291	]	=	1225
	SPECIL_ID	[	292	]	=	1226
	SPECIL_ID	[	293	]	=	1316
	SPECIL_ID	[	294	]	=	1317
	SPECIL_ID	[	295	]	=	4747
	SPECIL_ID	[	296	]	=	4851
	SPECIL_ID	[	297	]	=	4865
	SPECIL_ID	[	298	]	=	4961
	SPECIL_ID	[	299	]	=	4962
	SPECIL_ID	[	300	]	=	1245
	SPECIL_ID	[	301	]	=	1246
	SPECIL_ID	[	302	]	=	1336
	SPECIL_ID	[	303	]	=	1337
	SPECIL_ID	[	304	]	=	1490
	SPECIL_ID	[	305	]	=	1501
	SPECIL_ID	[	306	]	=	2489
	SPECIL_ID	[	307	]	=	4750
	SPECIL_ID	[	308	]	=	4763
	SPECIL_ID	[	309	]	=	4854
	SPECIL_ID	[	310	]	=	4867
	SPECIL_ID	[	311	]	=	4981
	SPECIL_ID	[	312	]	=	4982
	SPECIL_ID	[	313	]	=	1181
	SPECIL_ID	[	314	]	=	1479
	SPECIL_ID	[	315	]	=	1660
	SPECIL_ID	[	316	]	=	4764
	SPECIL_ID	[	317	]	=	4770
	SPECIL_ID	[	318	]	=	4868
	SPECIL_ID	[	319	]	=	4874
	SPECIL_ID	[	320	]	=	4765
	SPECIL_ID	[	321	]	=	4766
	SPECIL_ID	[	322	]	=	4772
	SPECIL_ID	[	323	]	=	4869
	SPECIL_ID	[	324	]	=	4870
	SPECIL_ID	[	325	]	=	4876
	SPECIL_ID	[	326	]	=	4997
	SPECIL_ID	[	327	]	=	1178
	SPECIL_ID	[	328	]	=	1491
	SPECIL_ID	[	329	]	=	1502
	SPECIL_ID	[	330	]	=	4871
	SPECIL_ID	[	331	]	=	1174
	SPECIL_ID	[	332	]	=	1265
	SPECIL_ID	[	333	]	=	1356
	SPECIL_ID	[	334	]	=	1702
	SPECIL_ID	[	335	]	=	4787
	SPECIL_ID	[	336	]	=	1175
	SPECIL_ID	[	337	]	=	1266
	SPECIL_ID	[	338	]	=	1357
	SPECIL_ID	[	339	]	=	2490
	SPECIL_ID	[	340	]	=	3084
	SPECIL_ID	[	341	]	=	4784
	SPECIL_ID	[	342	]	=	4888
	SPECIL_ID	[	343	]	=	179
	SPECIL_ID	[	344	]	=	3065
	SPECIL_ID	[	345	]	=	1797
	SPECIL_ID	[	346	]	=	1797

-----------------------特殊ID
TESHU_ID_Num = 54					
TESHU_ID	=	{}			
TESHU_ID	[	1	]	=	2650
TESHU_ID	[	2	]	=	2651
TESHU_ID	[	3	]	=	2652
TESHU_ID	[	4	]	=	2653
TESHU_ID	[	5	]	=	2654
TESHU_ID	[	6	]	=	2617
TESHU_ID	[	7	]	=	2655
TESHU_ID	[	8	]	=	2656
TESHU_ID	[	9	]	=	2657
TESHU_ID	[	10	]	=	2658
TESHU_ID	[	11	]	=	2605
TESHU_ID	[	12	]	=	2588
TESHU_ID	[	13	]	=	2602
TESHU_ID	[	14	]	=	2659
TESHU_ID	[	15	]	=	2660
TESHU_ID	[	16	]	=	2661
TESHU_ID	[	17	]	=	2614
TESHU_ID	[	18	]	=	2640
TESHU_ID	[	19	]	=	2662
TESHU_ID	[	20	]	=	2664
TESHU_ID	[	21	]	=	2608
TESHU_ID	[	22	]	=	2619
TESHU_ID	[	23	]	=	2641
TESHU_ID	[	24	]	=	2668
TESHU_ID	[	25	]	=	2663
TESHU_ID	[	26	]	=	2603
TESHU_ID	[	27	]	=	2615
TESHU_ID	[	28	]	=	2602
TESHU_ID	[	29	]	=	2642
TESHU_ID	[	30	]	=	2667
TESHU_ID	[	31	]	=	2603
TESHU_ID	[	32	]	=	2606
TESHU_ID	[	33	]	=	2609
TESHU_ID	[	34	]	=	2589
TESHU_ID	[	35	]	=	2622
TESHU_ID	[	36	]	=	2643
TESHU_ID	[	37	]	=	2604
TESHU_ID	[	38	]	=	2604
TESHU_ID	[	39	]	=	2616
TESHU_ID	[	40	]	=	2610
TESHU_ID	[	41	]	=	2644
TESHU_ID	[	42	]	=	2666
TESHU_ID	[	43	]	=	2607
TESHU_ID	[	44	]	=	2624
TESHU_ID	[	45	]	=	2649
TESHU_ID	[	46	]	=	2665
TESHU_ID	[	47	]	=	2665
TESHU_ID	[	48	]	=	2665
TESHU_ID	[	49	]	=	2665
TESHU_ID	[	50	]	=	2665
TESHU_ID	[	51	]	=	2665
TESHU_ID	[	52	]	=	2665
TESHU_ID	[	53	]	=	2665
TESHU_ID	[	54	]	=	2665


--	制造																																							
--	物品质量							宝箱物品上限																																
	ZHIZAO_Qua	=	5	 			ZHIZAO_Mxcount	=	280																															
	ZHIZAO_ID	=	{}					ZHIZAO_LV	=	{}					ZHIZAO_ID1	=	{}					ZHIZAO_ID2	=	{}					ZHIZAO_ID3	=	{}				ZHIZAO__Rad	=	{}			
	ZHIZAO_ID	[	1	]	=	1067		ZHIZAO_LV	[	1	]	=	10		ZHIZAO_ID1	[	1	]	=	3989		ZHIZAO_ID2	[	1	]	=	1720		ZHIZAO_ID3	[1	]	=	2617		ZHIZAO__Rad	[	1	]	=	5
	ZHIZAO_ID	[	2	]	=	1068		ZHIZAO_LV	[	2	]	=	10		ZHIZAO_ID1	[	2	]	=	3989		ZHIZAO_ID2	[	2	]	=	4029		ZHIZAO_ID3	[2	]	=	2617		ZHIZAO__Rad	[	2	]	=	5
	ZHIZAO_ID	[	3	]	=	1069		ZHIZAO_LV	[	3	]	=	10		ZHIZAO_ID1	[	3	]	=	3989		ZHIZAO_ID2	[	3	]	=	1720		ZHIZAO_ID3	[3	]	=	2617		ZHIZAO__Rad	[	3	]	=	5
	ZHIZAO_ID	[	4	]	=	1070		ZHIZAO_LV	[	4	]	=	10		ZHIZAO_ID1	[	4	]	=	3989		ZHIZAO_ID2	[	4	]	=	4029		ZHIZAO_ID3	[4	]	=	2617		ZHIZAO__Rad	[	4	]	=	5
	ZHIZAO_ID	[	5	]	=	1135		ZHIZAO_LV	[	5	]	=	10		ZHIZAO_ID1	[	5	]	=	3989		ZHIZAO_ID2	[	5	]	=	1720		ZHIZAO_ID3	[5	]	=	2617		ZHIZAO__Rad	[	5	]	=	1
	ZHIZAO_ID	[	6	]	=	2372		ZHIZAO_LV	[	6	]	=	10		ZHIZAO_ID1	[	6	]	=	3989		ZHIZAO_ID2	[	6	]	=	4029		ZHIZAO_ID3	[6	]	=	2617		ZHIZAO__Rad	[	6	]	=	1
	ZHIZAO_ID	[	7	]	=	1137		ZHIZAO_LV	[	7	]	=	10		ZHIZAO_ID1	[	7	]	=	3989		ZHIZAO_ID2	[	7	]	=	1720		ZHIZAO_ID3	[7	]	=	2617		ZHIZAO__Rad	[	7	]	=	1
	ZHIZAO_ID	[	8	]	=	1146		ZHIZAO_LV	[	8	]	=	10		ZHIZAO_ID1	[	8	]	=	3989		ZHIZAO_ID2	[	8	]	=	4029		ZHIZAO_ID3	[8	]	=	2617		ZHIZAO__Rad	[	8	]	=	1
	ZHIZAO_ID	[	9	]	=	1145		ZHIZAO_LV	[	9	]	=	10		ZHIZAO_ID1	[	9	]	=	3989		ZHIZAO_ID2	[	9	]	=	1720		ZHIZAO_ID3	[9	]	=	2617		ZHIZAO__Rad	[	9	]	=	1
	ZHIZAO_ID	[	10	]	=	1136		ZHIZAO_LV	[	10	]	=	10		ZHIZAO_ID1	[	10	]	=	3989		ZHIZAO_ID2	[	10	]	=	4029		ZHIZAO_ID3	[10	]	=	2617		ZHIZAO__Rad	[	10	]	=	1
	ZHIZAO_ID	[	11	]	=	1135		ZHIZAO_LV	[	11	]	=	10		ZHIZAO_ID1	[	11	]	=	3989		ZHIZAO_ID2	[	11	]	=	1720		ZHIZAO_ID3	[11	]	=	2617		ZHIZAO__Rad	[	11	]	=	1
	ZHIZAO_ID	[	12	]	=	6533		ZHIZAO_LV	[	12	]	=	10		ZHIZAO_ID1	[	12	]	=	3989		ZHIZAO_ID2	[	12	]	=	4029		ZHIZAO_ID3	[12	]	=	2617		ZHIZAO__Rad	[	12	]	=	1
	ZHIZAO_ID	[	13	]	=	1138		ZHIZAO_LV	[	13	]	=	10		ZHIZAO_ID1	[	13	]	=	3989		ZHIZAO_ID2	[	13	]	=	1720		ZHIZAO_ID3	[13	]	=	2617		ZHIZAO__Rad	[	13	]	=	1
	ZHIZAO_ID	[	14	]	=	6533		ZHIZAO_LV	[	14	]	=	10		ZHIZAO_ID1	[	14	]	=	3989		ZHIZAO_ID2	[	14	]	=	4029		ZHIZAO_ID3	[14	]	=	2617		ZHIZAO__Rad	[	14	]	=	1
	ZHIZAO_ID	[	15	]	=	1150		ZHIZAO_LV	[	15	]	=	10		ZHIZAO_ID1	[	15	]	=	3989		ZHIZAO_ID2	[	15	]	=	1720		ZHIZAO_ID3	[15	]	=	2617		ZHIZAO__Rad	[	15	]	=	1
	ZHIZAO_ID	[	16	]	=	1152		ZHIZAO_LV	[	16	]	=	10		ZHIZAO_ID1	[	16	]	=	3989		ZHIZAO_ID2	[	16	]	=	4029		ZHIZAO_ID3	[16	]	=	2617		ZHIZAO__Rad	[	16	]	=	1
	ZHIZAO_ID	[	17	]	=	2673		ZHIZAO_LV	[	17	]	=	10		ZHIZAO_ID1	[	17	]	=	3989		ZHIZAO_ID2	[	17	]	=	1720		ZHIZAO_ID3	[17	]	=	2617		ZHIZAO__Rad	[	17	]	=	1
	ZHIZAO_ID	[	18	]	=	1139		ZHIZAO_LV	[	18	]	=	10		ZHIZAO_ID1	[	18	]	=	3989		ZHIZAO_ID2	[	18	]	=	4029		ZHIZAO_ID3	[18	]	=	2617		ZHIZAO__Rad	[	18	]	=	1
	ZHIZAO_ID	[	19	]	=	6533		ZHIZAO_LV	[	19	]	=	10		ZHIZAO_ID1	[	19	]	=	3989		ZHIZAO_ID2	[	19	]	=	1720		ZHIZAO_ID3	[19	]	=	2617		ZHIZAO__Rad	[	19	]	=	1
	ZHIZAO_ID	[	20	]	=	2677		ZHIZAO_LV	[	20	]	=	10		ZHIZAO_ID1	[	20	]	=	3989		ZHIZAO_ID2	[	20	]	=	4029		ZHIZAO_ID3	[20	]	=	2617		ZHIZAO__Rad	[	20	]	=	1
	ZHIZAO_ID	[	21	]	=	1140		ZHIZAO_LV	[	21	]	=	10		ZHIZAO_ID1	[	21	]	=	3989		ZHIZAO_ID2	[	21	]	=	1720		ZHIZAO_ID3	[21	]	=	2617		ZHIZAO__Rad	[	21	]	=	1
	ZHIZAO_ID	[	22	]	=	1141		ZHIZAO_LV	[	22	]	=	10		ZHIZAO_ID1	[	22	]	=	3989		ZHIZAO_ID2	[	22	]	=	4029		ZHIZAO_ID3	[22	]	=	2617		ZHIZAO__Rad	[	22	]	=	1
	ZHIZAO_ID	[	23	]	=	1142		ZHIZAO_LV	[	23	]	=	10		ZHIZAO_ID1	[	23	]	=	3989		ZHIZAO_ID2	[	23	]	=	1720		ZHIZAO_ID3	[23	]	=	2617		ZHIZAO__Rad	[	23	]	=	1
	ZHIZAO_ID	[	24	]	=	6533		ZHIZAO_LV	[	24	]	=	10		ZHIZAO_ID1	[	24	]	=	3989		ZHIZAO_ID2	[	24	]	=	4029		ZHIZAO_ID3	[24	]	=	2617		ZHIZAO__Rad	[	24	]	=	1
	ZHIZAO_ID	[	25	]	=	1143		ZHIZAO_LV	[	25	]	=	10		ZHIZAO_ID1	[	25	]	=	3989		ZHIZAO_ID2	[	25	]	=	1720		ZHIZAO_ID3	[25	]	=	2617		ZHIZAO__Rad	[	25	]	=	1
	ZHIZAO_ID	[	26	]	=	1151		ZHIZAO_LV	[	26	]	=	10		ZHIZAO_ID1	[	26	]	=	3989		ZHIZAO_ID2	[	26	]	=	4029		ZHIZAO_ID3	[26	]	=	2617		ZHIZAO__Rad	[	26	]	=	1
	ZHIZAO_ID	[	27	]	=	2678		ZHIZAO_LV	[	27	]	=	10		ZHIZAO_ID1	[	27	]	=	3989		ZHIZAO_ID2	[	27	]	=	1720		ZHIZAO_ID3	[27	]	=	2617		ZHIZAO__Rad	[	27	]	=	1
	ZHIZAO_ID	[	28	]	=	6533		ZHIZAO_LV	[	28	]	=	10		ZHIZAO_ID1	[	28	]	=	3989		ZHIZAO_ID2	[	28	]	=	4029		ZHIZAO_ID3	[28	]	=	2617		ZHIZAO__Rad	[	28	]	=	1
	ZHIZAO_ID	[	29	]	=	2236		ZHIZAO_LV	[	29	]	=	20		ZHIZAO_ID1	[	29	]	=	3990		ZHIZAO_ID2	[	29	]	=	1677		ZHIZAO_ID3	[29	]	=	2617		ZHIZAO__Rad	[	29	]	=	5
	ZHIZAO_ID	[	30	]	=	6533		ZHIZAO_LV	[	30	]	=	20		ZHIZAO_ID1	[	30	]	=	3990		ZHIZAO_ID2	[	30	]	=	4030		ZHIZAO_ID3	[30	]	=	2617		ZHIZAO__Rad	[	30	]	=	5
	ZHIZAO_ID	[	31	]	=	2236		ZHIZAO_LV	[	31	]	=	20		ZHIZAO_ID1	[	31	]	=	3990		ZHIZAO_ID2	[	31	]	=	1677		ZHIZAO_ID3	[31	]	=	2617		ZHIZAO__Rad	[	31	]	=	5
	ZHIZAO_ID	[	32	]	=	2236		ZHIZAO_LV	[	32	]	=	20		ZHIZAO_ID1	[	32	]	=	3990		ZHIZAO_ID2	[	32	]	=	4030		ZHIZAO_ID3	[32	]	=	2617		ZHIZAO__Rad	[	32	]	=	5
	ZHIZAO_ID	[	33	]	=	1135		ZHIZAO_LV	[	33	]	=	20		ZHIZAO_ID1	[	33	]	=	3990		ZHIZAO_ID2	[	33	]	=	1677		ZHIZAO_ID3	[33	]	=	2617		ZHIZAO__Rad	[	33	]	=	1
	ZHIZAO_ID	[	34	]	=	2372		ZHIZAO_LV	[	34	]	=	20		ZHIZAO_ID1	[	34	]	=	3990		ZHIZAO_ID2	[	34	]	=	4030		ZHIZAO_ID3	[34	]	=	2617		ZHIZAO__Rad	[	34	]	=	1
	ZHIZAO_ID	[	35	]	=	1137		ZHIZAO_LV	[	35	]	=	20		ZHIZAO_ID1	[	35	]	=	3990		ZHIZAO_ID2	[	35	]	=	1677		ZHIZAO_ID3	[35	]	=	2617		ZHIZAO__Rad	[	35	]	=	1
	ZHIZAO_ID	[	36	]	=	1146		ZHIZAO_LV	[	36	]	=	20		ZHIZAO_ID1	[	36	]	=	3990		ZHIZAO_ID2	[	36	]	=	4030		ZHIZAO_ID3	[36	]	=	2617		ZHIZAO__Rad	[	36	]	=	1
	ZHIZAO_ID	[	37	]	=	1145		ZHIZAO_LV	[	37	]	=	20		ZHIZAO_ID1	[	37	]	=	3990		ZHIZAO_ID2	[	37	]	=	1677		ZHIZAO_ID3	[37	]	=	2617		ZHIZAO__Rad	[	37	]	=	1
	ZHIZAO_ID	[	38	]	=	1136		ZHIZAO_LV	[	38	]	=	20		ZHIZAO_ID1	[	38	]	=	3990		ZHIZAO_ID2	[	38	]	=	4030		ZHIZAO_ID3	[38	]	=	2617		ZHIZAO__Rad	[	38	]	=	1
	ZHIZAO_ID	[	39	]	=	1135		ZHIZAO_LV	[	39	]	=	20		ZHIZAO_ID1	[	39	]	=	3990		ZHIZAO_ID2	[	39	]	=	1677		ZHIZAO_ID3	[39	]	=	2617		ZHIZAO__Rad	[	39	]	=	1
	ZHIZAO_ID	[	40	]	=	6533		ZHIZAO_LV	[	40	]	=	20		ZHIZAO_ID1	[	40	]	=	3990		ZHIZAO_ID2	[	40	]	=	4030		ZHIZAO_ID3	[40	]	=	2617		ZHIZAO__Rad	[	40	]	=	1
	ZHIZAO_ID	[	41	]	=	1138		ZHIZAO_LV	[	41	]	=	20		ZHIZAO_ID1	[	41	]	=	3990		ZHIZAO_ID2	[	41	]	=	1677		ZHIZAO_ID3	[41	]	=	2617		ZHIZAO__Rad	[	41	]	=	1
	ZHIZAO_ID	[	42	]	=	6533		ZHIZAO_LV	[	42	]	=	20		ZHIZAO_ID1	[	42	]	=	3990		ZHIZAO_ID2	[	42	]	=	4030		ZHIZAO_ID3	[42	]	=	2617		ZHIZAO__Rad	[	42	]	=	1
	ZHIZAO_ID	[	43	]	=	1150		ZHIZAO_LV	[	43	]	=	20		ZHIZAO_ID1	[	43	]	=	3990		ZHIZAO_ID2	[	43	]	=	1677		ZHIZAO_ID3	[43	]	=	2617		ZHIZAO__Rad	[	43	]	=	1
	ZHIZAO_ID	[	44	]	=	1152		ZHIZAO_LV	[	44	]	=	20		ZHIZAO_ID1	[	44	]	=	3990		ZHIZAO_ID2	[	44	]	=	4030		ZHIZAO_ID3	[44	]	=	2617		ZHIZAO__Rad	[	44	]	=	1
	ZHIZAO_ID	[	45	]	=	2673		ZHIZAO_LV	[	45	]	=	20		ZHIZAO_ID1	[	45	]	=	3990		ZHIZAO_ID2	[	45	]	=	1677		ZHIZAO_ID3	[45	]	=	2617		ZHIZAO__Rad	[	45	]	=	1
	ZHIZAO_ID	[	46	]	=	6533		ZHIZAO_LV	[	46	]	=	20		ZHIZAO_ID1	[	46	]	=	3990		ZHIZAO_ID2	[	46	]	=	4030		ZHIZAO_ID3	[46	]	=	2617		ZHIZAO__Rad	[	46	]	=	1
	ZHIZAO_ID	[	47	]	=	1139		ZHIZAO_LV	[	47	]	=	20		ZHIZAO_ID1	[	47	]	=	3990		ZHIZAO_ID2	[	47	]	=	1677		ZHIZAO_ID3	[47	]	=	2617		ZHIZAO__Rad	[	47	]	=	1
	ZHIZAO_ID	[	48	]	=	2677		ZHIZAO_LV	[	48	]	=	20		ZHIZAO_ID1	[	48	]	=	3990		ZHIZAO_ID2	[	48	]	=	4030		ZHIZAO_ID3	[48	]	=	2617		ZHIZAO__Rad	[	48	]	=	1
	ZHIZAO_ID	[	49	]	=	1140		ZHIZAO_LV	[	49	]	=	20		ZHIZAO_ID1	[	49	]	=	3990		ZHIZAO_ID2	[	49	]	=	1677		ZHIZAO_ID3	[49	]	=	2617		ZHIZAO__Rad	[	49	]	=	1
	ZHIZAO_ID	[	50	]	=	1141		ZHIZAO_LV	[	50	]	=	20		ZHIZAO_ID1	[	50	]	=	3990		ZHIZAO_ID2	[	50	]	=	4030		ZHIZAO_ID3	[50	]	=	2617		ZHIZAO__Rad	[	50	]	=	1
	ZHIZAO_ID	[	51	]	=	6533		ZHIZAO_LV	[	51	]	=	20		ZHIZAO_ID1	[	51	]	=	3990		ZHIZAO_ID2	[	51	]	=	1677		ZHIZAO_ID3	[51	]	=	2617		ZHIZAO__Rad	[	51	]	=	1
	ZHIZAO_ID	[	52	]	=	1142		ZHIZAO_LV	[	52	]	=	20		ZHIZAO_ID1	[	52	]	=	3990		ZHIZAO_ID2	[	52	]	=	4030		ZHIZAO_ID3	[52	]	=	2617		ZHIZAO__Rad	[	52	]	=	1
	ZHIZAO_ID	[	53	]	=	1143		ZHIZAO_LV	[	53	]	=	20		ZHIZAO_ID1	[	53	]	=	3990		ZHIZAO_ID2	[	53	]	=	1677		ZHIZAO_ID3	[53	]	=	2617		ZHIZAO__Rad	[	53	]	=	1
	ZHIZAO_ID	[	54	]	=	1151		ZHIZAO_LV	[	54	]	=	20		ZHIZAO_ID1	[	54	]	=	3990		ZHIZAO_ID2	[	54	]	=	4030		ZHIZAO_ID3	[54	]	=	2617		ZHIZAO__Rad	[	54	]	=	1
	ZHIZAO_ID	[	55	]	=	2678		ZHIZAO_LV	[	55	]	=	20		ZHIZAO_ID1	[	55	]	=	3990		ZHIZAO_ID2	[	55	]	=	1677		ZHIZAO_ID3	[55	]	=	2617		ZHIZAO__Rad	[	55	]	=	1
	ZHIZAO_ID	[	56	]	=	6533		ZHIZAO_LV	[	56	]	=	20		ZHIZAO_ID1	[	56	]	=	3990		ZHIZAO_ID2	[	56	]	=	4030		ZHIZAO_ID3	[56	]	=	2617		ZHIZAO__Rad	[	56	]	=	1
	ZHIZAO_ID	[	57	]	=	2236		ZHIZAO_LV	[	57	]	=	30		ZHIZAO_ID1	[	57	]	=	3991		ZHIZAO_ID2	[	57	]	=	1624		ZHIZAO_ID3	[57	]	=	2619		ZHIZAO__Rad	[	57	]	=	5
	ZHIZAO_ID	[	58	]	=	6533		ZHIZAO_LV	[	58	]	=	30		ZHIZAO_ID1	[	58	]	=	3991		ZHIZAO_ID2	[	58	]	=	4031		ZHIZAO_ID3	[58	]	=	2619		ZHIZAO__Rad	[	58	]	=	5
	ZHIZAO_ID	[	59	]	=	2236		ZHIZAO_LV	[	59	]	=	30		ZHIZAO_ID1	[	59	]	=	3991		ZHIZAO_ID2	[	59	]	=	1624		ZHIZAO_ID3	[59	]	=	2619		ZHIZAO__Rad	[	59	]	=	5
	ZHIZAO_ID	[	60	]	=	2236		ZHIZAO_LV	[	60	]	=	30		ZHIZAO_ID1	[	60	]	=	3991		ZHIZAO_ID2	[	60	]	=	4031		ZHIZAO_ID3	[60	]	=	2619		ZHIZAO__Rad	[	60	]	=	5
	ZHIZAO_ID	[	61	]	=	1135		ZHIZAO_LV	[	61	]	=	30		ZHIZAO_ID1	[	61	]	=	3991		ZHIZAO_ID2	[	61	]	=	1624		ZHIZAO_ID3	[61	]	=	2619		ZHIZAO__Rad	[	61	]	=	1
	ZHIZAO_ID	[	62	]	=	2372		ZHIZAO_LV	[	62	]	=	30		ZHIZAO_ID1	[	62	]	=	3991		ZHIZAO_ID2	[	62	]	=	4031		ZHIZAO_ID3	[62	]	=	2619		ZHIZAO__Rad	[	62	]	=	1
	ZHIZAO_ID	[	63	]	=	1137		ZHIZAO_LV	[	63	]	=	30		ZHIZAO_ID1	[	63	]	=	3991		ZHIZAO_ID2	[	63	]	=	1624		ZHIZAO_ID3	[63	]	=	2619		ZHIZAO__Rad	[	63	]	=	1
	ZHIZAO_ID	[	64	]	=	1146		ZHIZAO_LV	[	64	]	=	30		ZHIZAO_ID1	[	64	]	=	3991		ZHIZAO_ID2	[	64	]	=	4031		ZHIZAO_ID3	[64	]	=	2619		ZHIZAO__Rad	[	64	]	=	1
	ZHIZAO_ID	[	65	]	=	1145		ZHIZAO_LV	[	65	]	=	30		ZHIZAO_ID1	[	65	]	=	3991		ZHIZAO_ID2	[	65	]	=	1624		ZHIZAO_ID3	[65	]	=	2619		ZHIZAO__Rad	[	65	]	=	1
	ZHIZAO_ID	[	66	]	=	1136		ZHIZAO_LV	[	66	]	=	30		ZHIZAO_ID1	[	66	]	=	3991		ZHIZAO_ID2	[	66	]	=	4031		ZHIZAO_ID3	[66	]	=	2619		ZHIZAO__Rad	[	66	]	=	1
	ZHIZAO_ID	[	67	]	=	1135		ZHIZAO_LV	[	67	]	=	30		ZHIZAO_ID1	[	67	]	=	3991		ZHIZAO_ID2	[	67	]	=	1624		ZHIZAO_ID3	[67	]	=	2619		ZHIZAO__Rad	[	67	]	=	1
	ZHIZAO_ID	[	68	]	=	6533		ZHIZAO_LV	[	68	]	=	30		ZHIZAO_ID1	[	68	]	=	3991		ZHIZAO_ID2	[	68	]	=	4031		ZHIZAO_ID3	[68	]	=	2619		ZHIZAO__Rad	[	68	]	=	1
	ZHIZAO_ID	[	69	]	=	1138		ZHIZAO_LV	[	69	]	=	30		ZHIZAO_ID1	[	69	]	=	3991		ZHIZAO_ID2	[	69	]	=	1624		ZHIZAO_ID3	[69	]	=	2619		ZHIZAO__Rad	[	69	]	=	1
	ZHIZAO_ID	[	70	]	=	6533		ZHIZAO_LV	[	70	]	=	30		ZHIZAO_ID1	[	70	]	=	3991		ZHIZAO_ID2	[	70	]	=	4031		ZHIZAO_ID3	[70	]	=	2619		ZHIZAO__Rad	[	70	]	=	1
	ZHIZAO_ID	[	71	]	=	1150		ZHIZAO_LV	[	71	]	=	30		ZHIZAO_ID1	[	71	]	=	3991		ZHIZAO_ID2	[	71	]	=	1624		ZHIZAO_ID3	[71	]	=	2619		ZHIZAO__Rad	[	71	]	=	1
	ZHIZAO_ID	[	72	]	=	1152		ZHIZAO_LV	[	72	]	=	30		ZHIZAO_ID1	[	72	]	=	3991		ZHIZAO_ID2	[	72	]	=	4031		ZHIZAO_ID3	[72	]	=	2619		ZHIZAO__Rad	[	72	]	=	1
	ZHIZAO_ID	[	73	]	=	2673		ZHIZAO_LV	[	73	]	=	30		ZHIZAO_ID1	[	73	]	=	3991		ZHIZAO_ID2	[	73	]	=	1624		ZHIZAO_ID3	[73	]	=	2619		ZHIZAO__Rad	[	73	]	=	1
	ZHIZAO_ID	[	74	]	=	6533		ZHIZAO_LV	[	74	]	=	30		ZHIZAO_ID1	[	74	]	=	3991		ZHIZAO_ID2	[	74	]	=	4031		ZHIZAO_ID3	[74	]	=	2619		ZHIZAO__Rad	[	74	]	=	1
	ZHIZAO_ID	[	75	]	=	1139		ZHIZAO_LV	[	75	]	=	30		ZHIZAO_ID1	[	75	]	=	3991		ZHIZAO_ID2	[	75	]	=	1624		ZHIZAO_ID3	[75	]	=	2619		ZHIZAO__Rad	[	75	]	=	1
	ZHIZAO_ID	[	76	]	=	2677		ZHIZAO_LV	[	76	]	=	30		ZHIZAO_ID1	[	76	]	=	3991		ZHIZAO_ID2	[	76	]	=	4031		ZHIZAO_ID3	[76	]	=	2619		ZHIZAO__Rad	[	76	]	=	1
	ZHIZAO_ID	[	77	]	=	1140		ZHIZAO_LV	[	77	]	=	30		ZHIZAO_ID1	[	77	]	=	3991		ZHIZAO_ID2	[	77	]	=	1624		ZHIZAO_ID3	[77	]	=	2619		ZHIZAO__Rad	[	77	]	=	1
	ZHIZAO_ID	[	78	]	=	1141		ZHIZAO_LV	[	78	]	=	30		ZHIZAO_ID1	[	78	]	=	3991		ZHIZAO_ID2	[	78	]	=	4031		ZHIZAO_ID3	[78	]	=	2619		ZHIZAO__Rad	[	78	]	=	1
	ZHIZAO_ID	[	79	]	=	6533		ZHIZAO_LV	[	79	]	=	30		ZHIZAO_ID1	[	79	]	=	3991		ZHIZAO_ID2	[	79	]	=	1624		ZHIZAO_ID3	[79	]	=	2619		ZHIZAO__Rad	[	79	]	=	1
	ZHIZAO_ID	[	80	]	=	1142		ZHIZAO_LV	[	80	]	=	30		ZHIZAO_ID1	[	80	]	=	3991		ZHIZAO_ID2	[	80	]	=	4031		ZHIZAO_ID3	[80	]	=	2619		ZHIZAO__Rad	[	80	]	=	1
	ZHIZAO_ID	[	81	]	=	1143		ZHIZAO_LV	[	81	]	=	30		ZHIZAO_ID1	[	81	]	=	3991		ZHIZAO_ID2	[	81	]	=	1624		ZHIZAO_ID3	[81	]	=	2619		ZHIZAO__Rad	[	81	]	=	1
	ZHIZAO_ID	[	82	]	=	1151		ZHIZAO_LV	[	82	]	=	30		ZHIZAO_ID1	[	82	]	=	3991		ZHIZAO_ID2	[	82	]	=	4031		ZHIZAO_ID3	[82	]	=	2619		ZHIZAO__Rad	[	82	]	=	1
	ZHIZAO_ID	[	83	]	=	2678		ZHIZAO_LV	[	83	]	=	30		ZHIZAO_ID1	[	83	]	=	3991		ZHIZAO_ID2	[	83	]	=	1624		ZHIZAO_ID3	[83	]	=	2619		ZHIZAO__Rad	[	83	]	=	1
	ZHIZAO_ID	[	84	]	=	6533		ZHIZAO_LV	[	84	]	=	30		ZHIZAO_ID1	[	84	]	=	3991		ZHIZAO_ID2	[	84	]	=	4031		ZHIZAO_ID3	[84	]	=	2619		ZHIZAO__Rad	[	84	]	=	1
	ZHIZAO_ID	[	85	]	=	2236		ZHIZAO_LV	[	85	]	=	40		ZHIZAO_ID1	[	85	]	=	3992		ZHIZAO_ID2	[	85	]	=	4032		ZHIZAO_ID3	[85	]	=	2619		ZHIZAO__Rad	[	85	]	=	5
	ZHIZAO_ID	[	86	]	=	2236		ZHIZAO_LV	[	86	]	=	40		ZHIZAO_ID1	[	86	]	=	3992		ZHIZAO_ID2	[	86	]	=	1715		ZHIZAO_ID3	[86	]	=	2619		ZHIZAO__Rad	[	86	]	=	5
	ZHIZAO_ID	[	87	]	=	2236		ZHIZAO_LV	[	87	]	=	40		ZHIZAO_ID1	[	87	]	=	3992		ZHIZAO_ID2	[	87	]	=	4032		ZHIZAO_ID3	[87	]	=	2619		ZHIZAO__Rad	[	87	]	=	5
	ZHIZAO_ID	[	88	]	=	2236		ZHIZAO_LV	[	88	]	=	40		ZHIZAO_ID1	[	88	]	=	3992		ZHIZAO_ID2	[	88	]	=	1715		ZHIZAO_ID3	[88	]	=	2619		ZHIZAO__Rad	[	88	]	=	5
	ZHIZAO_ID	[	89	]	=	2721		ZHIZAO_LV	[	89	]	=	40		ZHIZAO_ID1	[	89	]	=	3992		ZHIZAO_ID2	[	89	]	=	4032		ZHIZAO_ID3	[89	]	=	2619		ZHIZAO__Rad	[	89	]	=	1
	ZHIZAO_ID	[	90	]	=	2373		ZHIZAO_LV	[	90	]	=	40		ZHIZAO_ID1	[	90	]	=	3992		ZHIZAO_ID2	[	90	]	=	1715		ZHIZAO_ID3	[90	]	=	2619		ZHIZAO__Rad	[	90	]	=	1
	ZHIZAO_ID	[	91	]	=	2721		ZHIZAO_LV	[	91	]	=	40		ZHIZAO_ID1	[	91	]	=	3992		ZHIZAO_ID2	[	91	]	=	4032		ZHIZAO_ID3	[91	]	=	2619		ZHIZAO__Rad	[	91	]	=	1
	ZHIZAO_ID	[	92	]	=	2730		ZHIZAO_LV	[	92	]	=	40		ZHIZAO_ID1	[	92	]	=	3992		ZHIZAO_ID2	[	92	]	=	1715		ZHIZAO_ID3	[92	]	=	2619		ZHIZAO__Rad	[	92	]	=	1
	ZHIZAO_ID	[	93	]	=	2729		ZHIZAO_LV	[	93	]	=	40		ZHIZAO_ID1	[	93	]	=	3992		ZHIZAO_ID2	[	93	]	=	4032		ZHIZAO_ID3	[93	]	=	2619		ZHIZAO__Rad	[	93	]	=	1
	ZHIZAO_ID	[	94	]	=	2720		ZHIZAO_LV	[	94	]	=	40		ZHIZAO_ID1	[	94	]	=	3992		ZHIZAO_ID2	[	94	]	=	1715		ZHIZAO_ID3	[94	]	=	2619		ZHIZAO__Rad	[	94	]	=	1
	ZHIZAO_ID	[	95	]	=	2719		ZHIZAO_LV	[	95	]	=	40		ZHIZAO_ID1	[	95	]	=	3992		ZHIZAO_ID2	[	95	]	=	4032		ZHIZAO_ID3	[95	]	=	2619		ZHIZAO__Rad	[	95	]	=	1
	ZHIZAO_ID	[	96	]	=	2719		ZHIZAO_LV	[	96	]	=	40		ZHIZAO_ID1	[	96	]	=	3992		ZHIZAO_ID2	[	96	]	=	1715		ZHIZAO_ID3	[96	]	=	2619		ZHIZAO__Rad	[	96	]	=	1
	ZHIZAO_ID	[	97	]	=	2722		ZHIZAO_LV	[	97	]	=	40		ZHIZAO_ID1	[	97	]	=	3992		ZHIZAO_ID2	[	97	]	=	4032		ZHIZAO_ID3	[97	]	=	2619		ZHIZAO__Rad	[	97	]	=	1
	ZHIZAO_ID	[	98	]	=	2724		ZHIZAO_LV	[	98	]	=	40		ZHIZAO_ID1	[	98	]	=	3992		ZHIZAO_ID2	[	98	]	=	1715		ZHIZAO_ID3	[98	]	=	2619		ZHIZAO__Rad	[	98	]	=	1
	ZHIZAO_ID	[	99	]	=	2734		ZHIZAO_LV	[	99	]	=	40		ZHIZAO_ID1	[	99	]	=	3992		ZHIZAO_ID2	[	99	]	=	4032		ZHIZAO_ID3	[99	]	=	2619		ZHIZAO__Rad	[	99	]	=	1
	ZHIZAO_ID	[	100	]	=	2736		ZHIZAO_LV	[	100	]	=	40		ZHIZAO_ID1	[	100	]	=	3992		ZHIZAO_ID2	[	100	]	=	1715		ZHIZAO_ID3	[100	]	=	2619		ZHIZAO__Rad	[	100	]	=	1
	ZHIZAO_ID	[	101	]	=	2737		ZHIZAO_LV	[	101	]	=	40		ZHIZAO_ID1	[	101	]	=	3992		ZHIZAO_ID2	[	101	]	=	4032		ZHIZAO_ID3	[101	]	=	2619		ZHIZAO__Rad	[	101	]	=	1
	ZHIZAO_ID	[	102	]	=	2723		ZHIZAO_LV	[	102	]	=	40		ZHIZAO_ID1	[	102	]	=	3992		ZHIZAO_ID2	[	102	]	=	1715		ZHIZAO_ID3	[102	]	=	2619		ZHIZAO__Rad	[	102	]	=	1
	ZHIZAO_ID	[	103	]	=	2741		ZHIZAO_LV	[	103	]	=	40		ZHIZAO_ID1	[	103	]	=	3992		ZHIZAO_ID2	[	103	]	=	4032		ZHIZAO_ID3	[103	]	=	2619		ZHIZAO__Rad	[	103	]	=	1
	ZHIZAO_ID	[	104	]	=	2741		ZHIZAO_LV	[	104	]	=	40		ZHIZAO_ID1	[	104	]	=	3992		ZHIZAO_ID2	[	104	]	=	1715		ZHIZAO_ID3	[104	]	=	2619		ZHIZAO__Rad	[	104	]	=	1
	ZHIZAO_ID	[	105	]	=	2724		ZHIZAO_LV	[	105	]	=	40		ZHIZAO_ID1	[	105	]	=	3992		ZHIZAO_ID2	[	105	]	=	4032		ZHIZAO_ID3	[105	]	=	2619		ZHIZAO__Rad	[	105	]	=	1
	ZHIZAO_ID	[	106	]	=	2725		ZHIZAO_LV	[	106	]	=	40		ZHIZAO_ID1	[	106	]	=	3992		ZHIZAO_ID2	[	106	]	=	1715		ZHIZAO_ID3	[106	]	=	2619		ZHIZAO__Rad	[	106	]	=	1
	ZHIZAO_ID	[	107	]	=	2726		ZHIZAO_LV	[	107	]	=	40		ZHIZAO_ID1	[	107	]	=	3992		ZHIZAO_ID2	[	107	]	=	4032		ZHIZAO_ID3	[107	]	=	2619		ZHIZAO__Rad	[	107	]	=	1
	ZHIZAO_ID	[	108	]	=	2727		ZHIZAO_LV	[	108	]	=	40		ZHIZAO_ID1	[	108	]	=	3992		ZHIZAO_ID2	[	108	]	=	1715		ZHIZAO_ID3	[108	]	=	2619		ZHIZAO__Rad	[	108	]	=	1
	ZHIZAO_ID	[	109	]	=	2727		ZHIZAO_LV	[	109	]	=	40		ZHIZAO_ID1	[	109	]	=	3992		ZHIZAO_ID2	[	109	]	=	4032		ZHIZAO_ID3	[109	]	=	2619		ZHIZAO__Rad	[	109	]	=	1
	ZHIZAO_ID	[	110	]	=	2735		ZHIZAO_LV	[	110	]	=	40		ZHIZAO_ID1	[	110	]	=	3992		ZHIZAO_ID2	[	110	]	=	1715		ZHIZAO_ID3	[110	]	=	2619		ZHIZAO__Rad	[	110	]	=	1
	ZHIZAO_ID	[	111	]	=	2742		ZHIZAO_LV	[	111	]	=	40		ZHIZAO_ID1	[	111	]	=	3992		ZHIZAO_ID2	[	111	]	=	4032		ZHIZAO_ID3	[111	]	=	2619		ZHIZAO__Rad	[	111	]	=	1
	ZHIZAO_ID	[	112	]	=	2722		ZHIZAO_LV	[	112	]	=	40		ZHIZAO_ID1	[	112	]	=	3992		ZHIZAO_ID2	[	112	]	=	1715		ZHIZAO_ID3	[112	]	=	2619		ZHIZAO__Rad	[	112	]	=	1
	ZHIZAO_ID	[	113	]	=	2236		ZHIZAO_LV	[	113	]	=	50		ZHIZAO_ID1	[	113	]	=	3993		ZHIZAO_ID2	[	113	]	=	1683		ZHIZAO_ID3	[113	]	=	2622		ZHIZAO__Rad	[	113	]	=	5
	ZHIZAO_ID	[	114	]	=	2236		ZHIZAO_LV	[	114	]	=	50		ZHIZAO_ID1	[	114	]	=	3993		ZHIZAO_ID2	[	114	]	=	4033		ZHIZAO_ID3	[114	]	=	2622		ZHIZAO__Rad	[	114	]	=	5
	ZHIZAO_ID	[	115	]	=	2236		ZHIZAO_LV	[	115	]	=	50		ZHIZAO_ID1	[	115	]	=	3993		ZHIZAO_ID2	[	115	]	=	1683		ZHIZAO_ID3	[115	]	=	2622		ZHIZAO__Rad	[	115	]	=	5
	ZHIZAO_ID	[	116	]	=	2236		ZHIZAO_LV	[	116	]	=	50		ZHIZAO_ID1	[	116	]	=	3993		ZHIZAO_ID2	[	116	]	=	4033		ZHIZAO_ID3	[116	]	=	2622		ZHIZAO__Rad	[	116	]	=	5
	ZHIZAO_ID	[	117	]	=	2721		ZHIZAO_LV	[	117	]	=	50		ZHIZAO_ID1	[	117	]	=	3993		ZHIZAO_ID2	[	117	]	=	1683		ZHIZAO_ID3	[117	]	=	2622		ZHIZAO__Rad	[	117	]	=	1
	ZHIZAO_ID	[	118	]	=	2373		ZHIZAO_LV	[	118	]	=	50		ZHIZAO_ID1	[	118	]	=	3993		ZHIZAO_ID2	[	118	]	=	4033		ZHIZAO_ID3	[118	]	=	2622		ZHIZAO__Rad	[	118	]	=	1
	ZHIZAO_ID	[	119	]	=	2721		ZHIZAO_LV	[	119	]	=	50		ZHIZAO_ID1	[	119	]	=	3993		ZHIZAO_ID2	[	119	]	=	1683		ZHIZAO_ID3	[119	]	=	2622		ZHIZAO__Rad	[	119	]	=	1
	ZHIZAO_ID	[	120	]	=	2730		ZHIZAO_LV	[	120	]	=	50		ZHIZAO_ID1	[	120	]	=	3993		ZHIZAO_ID2	[	120	]	=	4033		ZHIZAO_ID3	[120	]	=	2622		ZHIZAO__Rad	[	120	]	=	1
	ZHIZAO_ID	[	121	]	=	2729		ZHIZAO_LV	[	121	]	=	50		ZHIZAO_ID1	[	121	]	=	3993		ZHIZAO_ID2	[	121	]	=	1683		ZHIZAO_ID3	[121	]	=	6534		ZHIZAO__Rad	[	121	]	=	1
	ZHIZAO_ID	[	122	]	=	2720		ZHIZAO_LV	[	122	]	=	50		ZHIZAO_ID1	[	122	]	=	3993		ZHIZAO_ID2	[	122	]	=	4033		ZHIZAO_ID3	[122	]	=	2622		ZHIZAO__Rad	[	122	]	=	1
	ZHIZAO_ID	[	123	]	=	2719		ZHIZAO_LV	[	123	]	=	50		ZHIZAO_ID1	[	123	]	=	3993		ZHIZAO_ID2	[	123	]	=	1683		ZHIZAO_ID3	[123	]	=	2622		ZHIZAO__Rad	[	123	]	=	1
	ZHIZAO_ID	[	124	]	=	2719		ZHIZAO_LV	[	124	]	=	50		ZHIZAO_ID1	[	124	]	=	3993		ZHIZAO_ID2	[	124	]	=	4033		ZHIZAO_ID3	[124	]	=	2622		ZHIZAO__Rad	[	124	]	=	1
	ZHIZAO_ID	[	125	]	=	2722		ZHIZAO_LV	[	125	]	=	50		ZHIZAO_ID1	[	125	]	=	3993		ZHIZAO_ID2	[	125	]	=	1683		ZHIZAO_ID3	[125	]	=	2622		ZHIZAO__Rad	[	125	]	=	1
	ZHIZAO_ID	[	126	]	=	2724		ZHIZAO_LV	[	126	]	=	50		ZHIZAO_ID1	[	126	]	=	3993		ZHIZAO_ID2	[	126	]	=	4033		ZHIZAO_ID3	[126	]	=	2622		ZHIZAO__Rad	[	126	]	=	1
	ZHIZAO_ID	[	127	]	=	2734		ZHIZAO_LV	[	127	]	=	50		ZHIZAO_ID1	[	127	]	=	3993		ZHIZAO_ID2	[	127	]	=	1683		ZHIZAO_ID3	[127	]	=	2622		ZHIZAO__Rad	[	127	]	=	1
	ZHIZAO_ID	[	128	]	=	2736		ZHIZAO_LV	[	128	]	=	50		ZHIZAO_ID1	[	128	]	=	3993		ZHIZAO_ID2	[	128	]	=	4033		ZHIZAO_ID3	[128	]	=	6534		ZHIZAO__Rad	[	128	]	=	1
	ZHIZAO_ID	[	129	]	=	2737		ZHIZAO_LV	[	129	]	=	50		ZHIZAO_ID1	[	129	]	=	3993		ZHIZAO_ID2	[	129	]	=	1683		ZHIZAO_ID3	[129	]	=	2622		ZHIZAO__Rad	[	129	]	=	1
	ZHIZAO_ID	[	130	]	=	2723		ZHIZAO_LV	[	130	]	=	50		ZHIZAO_ID1	[	130	]	=	3993		ZHIZAO_ID2	[	130	]	=	4033		ZHIZAO_ID3	[130	]	=	2622		ZHIZAO__Rad	[	130	]	=	1
	ZHIZAO_ID	[	131	]	=	2741		ZHIZAO_LV	[	131	]	=	50		ZHIZAO_ID1	[	131	]	=	3993		ZHIZAO_ID2	[	131	]	=	1683		ZHIZAO_ID3	[131	]	=	2622		ZHIZAO__Rad	[	131	]	=	1
	ZHIZAO_ID	[	132	]	=	2741		ZHIZAO_LV	[	132	]	=	50		ZHIZAO_ID1	[	132	]	=	3993		ZHIZAO_ID2	[	132	]	=	4033		ZHIZAO_ID3	[132	]	=	2622		ZHIZAO__Rad	[	132	]	=	1
	ZHIZAO_ID	[	133	]	=	2724		ZHIZAO_LV	[	133	]	=	50		ZHIZAO_ID1	[	133	]	=	3993		ZHIZAO_ID2	[	133	]	=	1683		ZHIZAO_ID3	[133	]	=	2622		ZHIZAO__Rad	[	133	]	=	1
	ZHIZAO_ID	[	134	]	=	2725		ZHIZAO_LV	[	134	]	=	50		ZHIZAO_ID1	[	134	]	=	3993		ZHIZAO_ID2	[	134	]	=	4033		ZHIZAO_ID3	[134	]	=	2622		ZHIZAO__Rad	[	134	]	=	1
	ZHIZAO_ID	[	135	]	=	2726		ZHIZAO_LV	[	135	]	=	50		ZHIZAO_ID1	[	135	]	=	3993		ZHIZAO_ID2	[	135	]	=	1683		ZHIZAO_ID3	[135	]	=	2622		ZHIZAO__Rad	[	135	]	=	1
	ZHIZAO_ID	[	136	]	=	2727		ZHIZAO_LV	[	136	]	=	50		ZHIZAO_ID1	[	136	]	=	3993		ZHIZAO_ID2	[	136	]	=	4033		ZHIZAO_ID3	[136	]	=	6534		ZHIZAO__Rad	[	136	]	=	1
	ZHIZAO_ID	[	137	]	=	2727		ZHIZAO_LV	[	137	]	=	50		ZHIZAO_ID1	[	137	]	=	3993		ZHIZAO_ID2	[	137	]	=	1683		ZHIZAO_ID3	[137	]	=	2622		ZHIZAO__Rad	[	137	]	=	1
	ZHIZAO_ID	[	138	]	=	2735		ZHIZAO_LV	[	138	]	=	50		ZHIZAO_ID1	[	138	]	=	3993		ZHIZAO_ID2	[	138	]	=	4033		ZHIZAO_ID3	[138	]	=	2622		ZHIZAO__Rad	[	138	]	=	1
	ZHIZAO_ID	[	139	]	=	2742		ZHIZAO_LV	[	139	]	=	50		ZHIZAO_ID1	[	139	]	=	3993		ZHIZAO_ID2	[	139	]	=	1683		ZHIZAO_ID3	[139	]	=	2622		ZHIZAO__Rad	[	139	]	=	1
	ZHIZAO_ID	[	140	]	=	2722		ZHIZAO_LV	[	140	]	=	50		ZHIZAO_ID1	[	140	]	=	3993		ZHIZAO_ID2	[	140	]	=	4033		ZHIZAO_ID3	[140	]	=	2622		ZHIZAO__Rad	[	140	]	=	1
	ZHIZAO_ID	[	141	]	=	2236		ZHIZAO_LV	[	141	]	=	60		ZHIZAO_ID1	[	141	]	=	3994		ZHIZAO_ID2	[	141	]	=	1684		ZHIZAO_ID3	[141	]	=	2622		ZHIZAO__Rad	[	141	]	=	5
	ZHIZAO_ID	[	142	]	=	2236		ZHIZAO_LV	[	142	]	=	60		ZHIZAO_ID1	[	142	]	=	3994		ZHIZAO_ID2	[	142	]	=	4034		ZHIZAO_ID3	[142	]	=	2622		ZHIZAO__Rad	[	142	]	=	5
	ZHIZAO_ID	[	143	]	=	2236		ZHIZAO_LV	[	143	]	=	60		ZHIZAO_ID1	[	143	]	=	3994		ZHIZAO_ID2	[	143	]	=	1684		ZHIZAO_ID3	[143	]	=	2622		ZHIZAO__Rad	[	143	]	=	5
	ZHIZAO_ID	[	144	]	=	2236		ZHIZAO_LV	[	144	]	=	60		ZHIZAO_ID1	[	144	]	=	3994		ZHIZAO_ID2	[	144	]	=	4034		ZHIZAO_ID3	[144	]	=	2622		ZHIZAO__Rad	[	144	]	=	5
	ZHIZAO_ID	[	145	]	=	2750		ZHIZAO_LV	[	145	]	=	60		ZHIZAO_ID1	[	145	]	=	3994		ZHIZAO_ID2	[	145	]	=	1684		ZHIZAO_ID3	[145	]	=	2622		ZHIZAO__Rad	[	145	]	=	1
	ZHIZAO_ID	[	146	]	=	2375		ZHIZAO_LV	[	146	]	=	60		ZHIZAO_ID1	[	146	]	=	3994		ZHIZAO_ID2	[	146	]	=	4034		ZHIZAO_ID3	[146	]	=	2622		ZHIZAO__Rad	[	146	]	=	1
	ZHIZAO_ID	[	147	]	=	2745		ZHIZAO_LV	[	147	]	=	60		ZHIZAO_ID1	[	147	]	=	3994		ZHIZAO_ID2	[	147	]	=	1684		ZHIZAO_ID3	[147	]	=	2622		ZHIZAO__Rad	[	147	]	=	1
	ZHIZAO_ID	[	148	]	=	2754		ZHIZAO_LV	[	148	]	=	60		ZHIZAO_ID1	[	148	]	=	3994		ZHIZAO_ID2	[	148	]	=	4034		ZHIZAO_ID3	[148	]	=	2622		ZHIZAO__Rad	[	148	]	=	1
	ZHIZAO_ID	[	149	]	=	2753		ZHIZAO_LV	[	149	]	=	60		ZHIZAO_ID1	[	149	]	=	3994		ZHIZAO_ID2	[	149	]	=	1684		ZHIZAO_ID3	[149	]	=	2622		ZHIZAO__Rad	[	149	]	=	1
	ZHIZAO_ID	[	150	]	=	2744		ZHIZAO_LV	[	150	]	=	60		ZHIZAO_ID1	[	150	]	=	3994		ZHIZAO_ID2	[	150	]	=	4034		ZHIZAO_ID3	[150	]	=	2622		ZHIZAO__Rad	[	150	]	=	1
	ZHIZAO_ID	[	151	]	=	2743		ZHIZAO_LV	[	151	]	=	60		ZHIZAO_ID1	[	151	]	=	3994		ZHIZAO_ID2	[	151	]	=	1684		ZHIZAO_ID3	[151	]	=	6534		ZHIZAO__Rad	[	151	]	=	1
	ZHIZAO_ID	[	152	]	=	2743		ZHIZAO_LV	[	152	]	=	60		ZHIZAO_ID1	[	152	]	=	3994		ZHIZAO_ID2	[	152	]	=	4034		ZHIZAO_ID3	[152	]	=	2622		ZHIZAO__Rad	[	152	]	=	1
	ZHIZAO_ID	[	153	]	=	2746		ZHIZAO_LV	[	153	]	=	60		ZHIZAO_ID1	[	153	]	=	3994		ZHIZAO_ID2	[	153	]	=	1684		ZHIZAO_ID3	[153	]	=	2622		ZHIZAO__Rad	[	153	]	=	1
	ZHIZAO_ID	[	154	]	=	2758		ZHIZAO_LV	[	154	]	=	60		ZHIZAO_ID1	[	154	]	=	3994		ZHIZAO_ID2	[	154	]	=	4034		ZHIZAO_ID3	[154	]	=	2622		ZHIZAO__Rad	[	154	]	=	1
	ZHIZAO_ID	[	155	]	=	2758		ZHIZAO_LV	[	155	]	=	60		ZHIZAO_ID1	[	155	]	=	3994		ZHIZAO_ID2	[	155	]	=	1684		ZHIZAO_ID3	[155	]	=	2622		ZHIZAO__Rad	[	155	]	=	1
	ZHIZAO_ID	[	156	]	=	2760		ZHIZAO_LV	[	156	]	=	60		ZHIZAO_ID1	[	156	]	=	3994		ZHIZAO_ID2	[	156	]	=	4034		ZHIZAO_ID3	[156	]	=	2622		ZHIZAO__Rad	[	156	]	=	1
	ZHIZAO_ID	[	157	]	=	2761		ZHIZAO_LV	[	157	]	=	60		ZHIZAO_ID1	[	157	]	=	3994		ZHIZAO_ID2	[	157	]	=	1684		ZHIZAO_ID3	[157	]	=	2622		ZHIZAO__Rad	[	157	]	=	1
	ZHIZAO_ID	[	158	]	=	2747		ZHIZAO_LV	[	158	]	=	60		ZHIZAO_ID1	[	158	]	=	3994		ZHIZAO_ID2	[	158	]	=	4034		ZHIZAO_ID3	[158	]	=	2622		ZHIZAO__Rad	[	158	]	=	1
	ZHIZAO_ID	[	159	]	=	2765		ZHIZAO_LV	[	159	]	=	60		ZHIZAO_ID1	[	159	]	=	3994		ZHIZAO_ID2	[	159	]	=	1684		ZHIZAO_ID3	[159	]	=	2622		ZHIZAO__Rad	[	159	]	=	1
	ZHIZAO_ID	[	160	]	=	2765		ZHIZAO_LV	[	160	]	=	60		ZHIZAO_ID1	[	160	]	=	3994		ZHIZAO_ID2	[	160	]	=	4034		ZHIZAO_ID3	[160	]	=	2622		ZHIZAO__Rad	[	160	]	=	1
	ZHIZAO_ID	[	161	]	=	2748		ZHIZAO_LV	[	161	]	=	60		ZHIZAO_ID1	[	161	]	=	3994		ZHIZAO_ID2	[	161	]	=	1684		ZHIZAO_ID3	[161	]	=	2622		ZHIZAO__Rad	[	161	]	=	1
	ZHIZAO_ID	[	162	]	=	2749		ZHIZAO_LV	[	162	]	=	60		ZHIZAO_ID1	[	162	]	=	3994		ZHIZAO_ID2	[	162	]	=	4034		ZHIZAO_ID3	[162	]	=	2622		ZHIZAO__Rad	[	162	]	=	1
	ZHIZAO_ID	[	163	]	=	2750		ZHIZAO_LV	[	163	]	=	60		ZHIZAO_ID1	[	163	]	=	3994		ZHIZAO_ID2	[	163	]	=	1684		ZHIZAO_ID3	[163	]	=	2622		ZHIZAO__Rad	[	163	]	=	1
	ZHIZAO_ID	[	164	]	=	2751		ZHIZAO_LV	[	164	]	=	60		ZHIZAO_ID1	[	164	]	=	3994		ZHIZAO_ID2	[	164	]	=	4034		ZHIZAO_ID3	[164	]	=	6534		ZHIZAO__Rad	[	164	]	=	1
	ZHIZAO_ID	[	165	]	=	2751		ZHIZAO_LV	[	165	]	=	60		ZHIZAO_ID1	[	165	]	=	3994		ZHIZAO_ID2	[	165	]	=	1684		ZHIZAO_ID3	[165	]	=	2622		ZHIZAO__Rad	[	165	]	=	1
	ZHIZAO_ID	[	166	]	=	2759		ZHIZAO_LV	[	166	]	=	60		ZHIZAO_ID1	[	166	]	=	3994		ZHIZAO_ID2	[	166	]	=	4034		ZHIZAO_ID3	[166	]	=	2622		ZHIZAO__Rad	[	166	]	=	1
	ZHIZAO_ID	[	167	]	=	2766		ZHIZAO_LV	[	167	]	=	60		ZHIZAO_ID1	[	167	]	=	3994		ZHIZAO_ID2	[	167	]	=	1684		ZHIZAO_ID3	[167	]	=	2622		ZHIZAO__Rad	[	167	]	=	1
	ZHIZAO_ID	[	168	]	=	2746		ZHIZAO_LV	[	168	]	=	60		ZHIZAO_ID1	[	168	]	=	3994		ZHIZAO_ID2	[	168	]	=	4034		ZHIZAO_ID3	[168	]	=	2622		ZHIZAO__Rad	[	168	]	=	1
	ZHIZAO_ID	[	169	]	=	2236		ZHIZAO_LV	[	169	]	=	70		ZHIZAO_ID1	[	169	]	=	3995		ZHIZAO_ID2	[	169	]	=	2419		ZHIZAO_ID3	[169	]	=	2624		ZHIZAO__Rad	[	169	]	=	5
	ZHIZAO_ID	[	170	]	=	2236		ZHIZAO_LV	[	170	]	=	70		ZHIZAO_ID1	[	170	]	=	3995		ZHIZAO_ID2	[	170	]	=	4035		ZHIZAO_ID3	[170	]	=	6534		ZHIZAO__Rad	[	170	]	=	5
	ZHIZAO_ID	[	171	]	=	2236		ZHIZAO_LV	[	171	]	=	70		ZHIZAO_ID1	[	171	]	=	3995		ZHIZAO_ID2	[	171	]	=	2419		ZHIZAO_ID3	[171	]	=	2624		ZHIZAO__Rad	[	171	]	=	5
	ZHIZAO_ID	[	172	]	=	2236		ZHIZAO_LV	[	172	]	=	70		ZHIZAO_ID1	[	172	]	=	3995		ZHIZAO_ID2	[	172	]	=	4035		ZHIZAO_ID3	[172	]	=	2624		ZHIZAO__Rad	[	172	]	=	5
	ZHIZAO_ID	[	173	]	=	2769		ZHIZAO_LV	[	173	]	=	70		ZHIZAO_ID1	[	173	]	=	3995		ZHIZAO_ID2	[	173	]	=	2419		ZHIZAO_ID3	[173	]	=	2624		ZHIZAO__Rad	[	173	]	=	1
	ZHIZAO_ID	[	174	]	=	2379		ZHIZAO_LV	[	174	]	=	70		ZHIZAO_ID1	[	174	]	=	3995		ZHIZAO_ID2	[	174	]	=	2419		ZHIZAO_ID3	[174	]	=	2624		ZHIZAO__Rad	[	174	]	=	1
	ZHIZAO_ID	[	175	]	=	2769		ZHIZAO_LV	[	175	]	=	70		ZHIZAO_ID1	[	175	]	=	3995		ZHIZAO_ID2	[	175	]	=	4035		ZHIZAO_ID3	[175	]	=	2624		ZHIZAO__Rad	[	175	]	=	1
	ZHIZAO_ID	[	176	]	=	2778		ZHIZAO_LV	[	176	]	=	70		ZHIZAO_ID1	[	176	]	=	3995		ZHIZAO_ID2	[	176	]	=	2419		ZHIZAO_ID3	[176	]	=	6534		ZHIZAO__Rad	[	176	]	=	1
	ZHIZAO_ID	[	177	]	=	2777		ZHIZAO_LV	[	177	]	=	70		ZHIZAO_ID1	[	177	]	=	3995		ZHIZAO_ID2	[	177	]	=	4035		ZHIZAO_ID3	[177	]	=	2624		ZHIZAO__Rad	[	177	]	=	1
	ZHIZAO_ID	[	178	]	=	2768		ZHIZAO_LV	[	178	]	=	70		ZHIZAO_ID1	[	178	]	=	3995		ZHIZAO_ID2	[	178	]	=	2419		ZHIZAO_ID3	[178	]	=	2624		ZHIZAO__Rad	[	178	]	=	1
	ZHIZAO_ID	[	179	]	=	2767		ZHIZAO_LV	[	179	]	=	70		ZHIZAO_ID1	[	179	]	=	3995		ZHIZAO_ID2	[	179	]	=	2419		ZHIZAO_ID3	[179	]	=	2624		ZHIZAO__Rad	[	179	]	=	1
	ZHIZAO_ID	[	180	]	=	2767		ZHIZAO_LV	[	180	]	=	70		ZHIZAO_ID1	[	180	]	=	3995		ZHIZAO_ID2	[	180	]	=	2419		ZHIZAO_ID3	[180	]	=	6534		ZHIZAO__Rad	[	180	]	=	1
	ZHIZAO_ID	[	181	]	=	2770		ZHIZAO_LV	[	181	]	=	70		ZHIZAO_ID1	[	181	]	=	3995		ZHIZAO_ID2	[	181	]	=	4035		ZHIZAO_ID3	[181	]	=	2624		ZHIZAO__Rad	[	181	]	=	1
	ZHIZAO_ID	[	182	]	=	2782		ZHIZAO_LV	[	182	]	=	70		ZHIZAO_ID1	[	182	]	=	3995		ZHIZAO_ID2	[	182	]	=	2419		ZHIZAO_ID3	[182	]	=	6534		ZHIZAO__Rad	[	182	]	=	1
	ZHIZAO_ID	[	183	]	=	2782		ZHIZAO_LV	[	183	]	=	70		ZHIZAO_ID1	[	183	]	=	3995		ZHIZAO_ID2	[	183	]	=	4035		ZHIZAO_ID3	[183	]	=	2624		ZHIZAO__Rad	[	183	]	=	1
	ZHIZAO_ID	[	184	]	=	2784		ZHIZAO_LV	[	184	]	=	70		ZHIZAO_ID1	[	184	]	=	3995		ZHIZAO_ID2	[	184	]	=	2419		ZHIZAO_ID3	[184	]	=	2624		ZHIZAO__Rad	[	184	]	=	1
	ZHIZAO_ID	[	185	]	=	2785		ZHIZAO_LV	[	185	]	=	70		ZHIZAO_ID1	[	185	]	=	3995		ZHIZAO_ID2	[	185	]	=	2419		ZHIZAO_ID3	[185	]	=	2624		ZHIZAO__Rad	[	185	]	=	1
	ZHIZAO_ID	[	186	]	=	2771		ZHIZAO_LV	[	186	]	=	70		ZHIZAO_ID1	[	186	]	=	3995		ZHIZAO_ID2	[	186	]	=	4035		ZHIZAO_ID3	[186	]	=	2624		ZHIZAO__Rad	[	186	]	=	1
	ZHIZAO_ID	[	187	]	=	2789		ZHIZAO_LV	[	187	]	=	70		ZHIZAO_ID1	[	187	]	=	3995		ZHIZAO_ID2	[	187	]	=	2419		ZHIZAO_ID3	[187	]	=	6534		ZHIZAO__Rad	[	187	]	=	1
	ZHIZAO_ID	[	188	]	=	2789		ZHIZAO_LV	[	188	]	=	70		ZHIZAO_ID1	[	188	]	=	3995		ZHIZAO_ID2	[	188	]	=	4035		ZHIZAO_ID3	[188	]	=	2624		ZHIZAO__Rad	[	188	]	=	1
	ZHIZAO_ID	[	189	]	=	2772		ZHIZAO_LV	[	189	]	=	70		ZHIZAO_ID1	[	189	]	=	3995		ZHIZAO_ID2	[	189	]	=	2419		ZHIZAO_ID3	[189	]	=	2624		ZHIZAO__Rad	[	189	]	=	1
	ZHIZAO_ID	[	190	]	=	2773		ZHIZAO_LV	[	190	]	=	70		ZHIZAO_ID1	[	190	]	=	3995		ZHIZAO_ID2	[	190	]	=	4035		ZHIZAO_ID3	[190	]	=	2624		ZHIZAO__Rad	[	190	]	=	1
	ZHIZAO_ID	[	191	]	=	2774		ZHIZAO_LV	[	191	]	=	70		ZHIZAO_ID1	[	191	]	=	3995		ZHIZAO_ID2	[	191	]	=	2419		ZHIZAO_ID3	[191	]	=	2624		ZHIZAO__Rad	[	191	]	=	1
	ZHIZAO_ID	[	192	]	=	2775		ZHIZAO_LV	[	192	]	=	70		ZHIZAO_ID1	[	192	]	=	3995		ZHIZAO_ID2	[	192	]	=	4035		ZHIZAO_ID3	[192	]	=	2624		ZHIZAO__Rad	[	192	]	=	1
	ZHIZAO_ID	[	193	]	=	2775		ZHIZAO_LV	[	193	]	=	70		ZHIZAO_ID1	[	193	]	=	3995		ZHIZAO_ID2	[	193	]	=	2419		ZHIZAO_ID3	[193	]	=	2624		ZHIZAO__Rad	[	193	]	=	1
	ZHIZAO_ID	[	194	]	=	2783		ZHIZAO_LV	[	194	]	=	70		ZHIZAO_ID1	[	194	]	=	3995		ZHIZAO_ID2	[	194	]	=	4035		ZHIZAO_ID3	[194	]	=	2624		ZHIZAO__Rad	[	194	]	=	1
	ZHIZAO_ID	[	195	]	=	2790		ZHIZAO_LV	[	195	]	=	70		ZHIZAO_ID1	[	195	]	=	3995		ZHIZAO_ID2	[	195	]	=	2419		ZHIZAO_ID3	[195	]	=	2624		ZHIZAO__Rad	[	195	]	=	1
	ZHIZAO_ID	[	196	]	=	2770		ZHIZAO_LV	[	196	]	=	70		ZHIZAO_ID1	[	196	]	=	3995		ZHIZAO_ID2	[	196	]	=	4035		ZHIZAO_ID3	[196	]	=	2624		ZHIZAO__Rad	[	196	]	=	1
	ZHIZAO_ID	[	197	]	=	2236		ZHIZAO_LV	[	197	]	=	80		ZHIZAO_ID1	[	197	]	=	3996		ZHIZAO_ID2	[	197	]	=	1625		ZHIZAO_ID3	[197	]	=	2624		ZHIZAO__Rad	[	197	]	=	5
	ZHIZAO_ID	[	198	]	=	2236		ZHIZAO_LV	[	198	]	=	80		ZHIZAO_ID1	[	198	]	=	3996		ZHIZAO_ID2	[	198	]	=	4036		ZHIZAO_ID3	[198	]	=	6534		ZHIZAO__Rad	[	198	]	=	5
	ZHIZAO_ID	[	199	]	=	2236		ZHIZAO_LV	[	199	]	=	80		ZHIZAO_ID1	[	199	]	=	3996		ZHIZAO_ID2	[	199	]	=	1625		ZHIZAO_ID3	[199	]	=	2624		ZHIZAO__Rad	[	199	]	=	5
	ZHIZAO_ID	[	200	]	=	2236		ZHIZAO_LV	[	200	]	=	80		ZHIZAO_ID1	[	200	]	=	3996		ZHIZAO_ID2	[	200	]	=	4036		ZHIZAO_ID3	[200	]	=	2624		ZHIZAO__Rad	[	200	]	=	5
	ZHIZAO_ID	[	201	]	=	2793		ZHIZAO_LV	[	201	]	=	80		ZHIZAO_ID1	[	201	]	=	3996		ZHIZAO_ID2	[	201	]	=	1625		ZHIZAO_ID3	[201	]	=	2624		ZHIZAO__Rad	[	201	]	=	1
	ZHIZAO_ID	[	202	]	=	2380		ZHIZAO_LV	[	202	]	=	80		ZHIZAO_ID1	[	202	]	=	3996		ZHIZAO_ID2	[	202	]	=	4036		ZHIZAO_ID3	[202	]	=	2624		ZHIZAO__Rad	[	202	]	=	1
	ZHIZAO_ID	[	203	]	=	2793		ZHIZAO_LV	[	203	]	=	80		ZHIZAO_ID1	[	203	]	=	3996		ZHIZAO_ID2	[	203	]	=	1625		ZHIZAO_ID3	[203	]	=	2624		ZHIZAO__Rad	[	203	]	=	1
	ZHIZAO_ID	[	204	]	=	2802		ZHIZAO_LV	[	204	]	=	80		ZHIZAO_ID1	[	204	]	=	3996		ZHIZAO_ID2	[	204	]	=	4036		ZHIZAO_ID3	[204	]	=	6534		ZHIZAO__Rad	[	204	]	=	1
	ZHIZAO_ID	[	205	]	=	2801		ZHIZAO_LV	[	205	]	=	80		ZHIZAO_ID1	[	205	]	=	3996		ZHIZAO_ID2	[	205	]	=	1625		ZHIZAO_ID3	[205	]	=	2624		ZHIZAO__Rad	[	205	]	=	1
	ZHIZAO_ID	[	206	]	=	2792		ZHIZAO_LV	[	206	]	=	80		ZHIZAO_ID1	[	206	]	=	3996		ZHIZAO_ID2	[	206	]	=	4036		ZHIZAO_ID3	[206	]	=	2624		ZHIZAO__Rad	[	206	]	=	1
	ZHIZAO_ID	[	207	]	=	2791		ZHIZAO_LV	[	207	]	=	80		ZHIZAO_ID1	[	207	]	=	3996		ZHIZAO_ID2	[	207	]	=	1625		ZHIZAO_ID3	[207	]	=	6534		ZHIZAO__Rad	[	207	]	=	1
	ZHIZAO_ID	[	208	]	=	2791		ZHIZAO_LV	[	208	]	=	80		ZHIZAO_ID1	[	208	]	=	3996		ZHIZAO_ID2	[	208	]	=	4036		ZHIZAO_ID3	[208	]	=	2624		ZHIZAO__Rad	[	208	]	=	1
	ZHIZAO_ID	[	209	]	=	2794		ZHIZAO_LV	[	209	]	=	80		ZHIZAO_ID1	[	209	]	=	3996		ZHIZAO_ID2	[	209	]	=	1625		ZHIZAO_ID3	[209	]	=	2624		ZHIZAO__Rad	[	209	]	=	1
	ZHIZAO_ID	[	210	]	=	2806		ZHIZAO_LV	[	210	]	=	80		ZHIZAO_ID1	[	210	]	=	3996		ZHIZAO_ID2	[	210	]	=	4036		ZHIZAO_ID3	[210	]	=	2624		ZHIZAO__Rad	[	210	]	=	1
	ZHIZAO_ID	[	211	]	=	2806		ZHIZAO_LV	[	211	]	=	80		ZHIZAO_ID1	[	211	]	=	3996		ZHIZAO_ID2	[	211	]	=	1625		ZHIZAO_ID3	[211	]	=	2624		ZHIZAO__Rad	[	211	]	=	1
	ZHIZAO_ID	[	212	]	=	2808		ZHIZAO_LV	[	212	]	=	80		ZHIZAO_ID1	[	212	]	=	3996		ZHIZAO_ID2	[	212	]	=	4036		ZHIZAO_ID3	[212	]	=	6534		ZHIZAO__Rad	[	212	]	=	1
	ZHIZAO_ID	[	213	]	=	2809		ZHIZAO_LV	[	213	]	=	80		ZHIZAO_ID1	[	213	]	=	3996		ZHIZAO_ID2	[	213	]	=	1625		ZHIZAO_ID3	[213	]	=	2624		ZHIZAO__Rad	[	213	]	=	1
	ZHIZAO_ID	[	214	]	=	2795		ZHIZAO_LV	[	214	]	=	80		ZHIZAO_ID1	[	214	]	=	3996		ZHIZAO_ID2	[	214	]	=	4036		ZHIZAO_ID3	[214	]	=	2624		ZHIZAO__Rad	[	214	]	=	1
	ZHIZAO_ID	[	215	]	=	2796		ZHIZAO_LV	[	215	]	=	80		ZHIZAO_ID1	[	215	]	=	3996		ZHIZAO_ID2	[	215	]	=	1625		ZHIZAO_ID3	[215	]	=	6534		ZHIZAO__Rad	[	215	]	=	1
	ZHIZAO_ID	[	216	]	=	2813		ZHIZAO_LV	[	216	]	=	80		ZHIZAO_ID1	[	216	]	=	3996		ZHIZAO_ID2	[	216	]	=	4036		ZHIZAO_ID3	[216	]	=	2624		ZHIZAO__Rad	[	216	]	=	1
	ZHIZAO_ID	[	217	]	=	2796		ZHIZAO_LV	[	217	]	=	80		ZHIZAO_ID1	[	217	]	=	3996		ZHIZAO_ID2	[	217	]	=	1625		ZHIZAO_ID3	[217	]	=	2624		ZHIZAO__Rad	[	217	]	=	1
	ZHIZAO_ID	[	218	]	=	2797		ZHIZAO_LV	[	218	]	=	80		ZHIZAO_ID1	[	218	]	=	3996		ZHIZAO_ID2	[	218	]	=	4036		ZHIZAO_ID3	[218	]	=	2624		ZHIZAO__Rad	[	218	]	=	1
	ZHIZAO_ID	[	219	]	=	2798		ZHIZAO_LV	[	219	]	=	80		ZHIZAO_ID1	[	219	]	=	3996		ZHIZAO_ID2	[	219	]	=	1625		ZHIZAO_ID3	[219	]	=	2624		ZHIZAO__Rad	[	219	]	=	1
	ZHIZAO_ID	[	220	]	=	2799		ZHIZAO_LV	[	220	]	=	80		ZHIZAO_ID1	[	220	]	=	3996		ZHIZAO_ID2	[	220	]	=	4036		ZHIZAO_ID3	[220	]	=	2624		ZHIZAO__Rad	[	220	]	=	1
	ZHIZAO_ID	[	221	]	=	2799		ZHIZAO_LV	[	221	]	=	80		ZHIZAO_ID1	[	221	]	=	3996		ZHIZAO_ID2	[	221	]	=	1625		ZHIZAO_ID3	[221	]	=	2624		ZHIZAO__Rad	[	221	]	=	1
	ZHIZAO_ID	[	222	]	=	2807		ZHIZAO_LV	[	222	]	=	80		ZHIZAO_ID1	[	222	]	=	3996		ZHIZAO_ID2	[	222	]	=	4036		ZHIZAO_ID3	[222	]	=	6534		ZHIZAO__Rad	[	222	]	=	1
	ZHIZAO_ID	[	223	]	=	2814		ZHIZAO_LV	[	223	]	=	80		ZHIZAO_ID1	[	223	]	=	3996		ZHIZAO_ID2	[	223	]	=	1625		ZHIZAO_ID3	[223	]	=	2624		ZHIZAO__Rad	[	223	]	=	1
	ZHIZAO_ID	[	224	]	=	2794		ZHIZAO_LV	[	224	]	=	80		ZHIZAO_ID1	[	224	]	=	3996		ZHIZAO_ID2	[	224	]	=	4036		ZHIZAO_ID3	[224	]	=	2624		ZHIZAO__Rad	[	224	]	=	1
	ZHIZAO_ID	[	225	]	=	8716		ZHIZAO_LV	[	225	]	=	80		ZHIZAO_ID1	[	225	]	=	3996		ZHIZAO_ID2	[	225	]	=	4036		ZHIZAO_ID3	[225	]	=	2624		ZHIZAO__Rad	[	225	]	=	1
	ZHIZAO_ID	[	226	]	=	8448		ZHIZAO_LV	[	226	]	=	80		ZHIZAO_ID1	[	226	]	=	3996		ZHIZAO_ID2	[	226	]	=	4036		ZHIZAO_ID3	[226	]	=	2624		ZHIZAO__Rad	[	226	]	=	1
	ZHIZAO_ID	[	227	]	=	8452		ZHIZAO_LV	[	227	]	=	80		ZHIZAO_ID1	[	227	]	=	3996		ZHIZAO_ID2	[	227	]	=	4036		ZHIZAO_ID3	[227	]	=	2624		ZHIZAO__Rad	[	227	]	=	1
	ZHIZAO_ID	[	228	]	=	8456		ZHIZAO_LV	[	228	]	=	80		ZHIZAO_ID1	[	228	]	=	3996		ZHIZAO_ID2	[	228	]	=	4036		ZHIZAO_ID3	[228	]	=	2624		ZHIZAO__Rad	[	228	]	=	1
	ZHIZAO_ID	[	229	]	=	8460		ZHIZAO_LV	[	229	]	=	80		ZHIZAO_ID1	[	229	]	=	3996		ZHIZAO_ID2	[	229	]	=	4036		ZHIZAO_ID3	[229	]	=	2624		ZHIZAO__Rad	[	229	]	=	1
	ZHIZAO_ID	[	230 ]	=	8464		ZHIZAO_LV	[	230	]	=	80		ZHIZAO_ID1	[	230	]	=	3996		ZHIZAO_ID2	[	230	]	=	4036		ZHIZAO_ID3	[230	]	=	2624		ZHIZAO__Rad	[	230	]	=	1
	ZHIZAO_ID	[	231 ]	=	8468		ZHIZAO_LV	[	231	]	=	80		ZHIZAO_ID1	[	231	]	=	3996		ZHIZAO_ID2	[	231	]	=	4036		ZHIZAO_ID3	[231	]	=	2624		ZHIZAO__Rad	[	231	]	=	1
	ZHIZAO_ID	[	232 ]	=	8472		ZHIZAO_LV	[	232	]	=	80		ZHIZAO_ID1	[	232	]	=	3996		ZHIZAO_ID2	[	232	]	=	4036		ZHIZAO_ID3	[232	]	=	2624		ZHIZAO__Rad	[	232	]	=	1
	-- ZHIZAO_ID	[	233	]	=	2801		ZHIZAO_LV	[	233	]	=	90		ZHIZAO_ID1	[	233	]	=	4037		ZHIZAO_ID2	[	233	]	=	4007		ZHIZAO_ID3	[233	]	=	2607		ZHIZAO__Rad	[	233	]	=	1
	-- ZHIZAO_ID	[	234	]	=	2792		ZHIZAO_LV	[	234	]	=	90		ZHIZAO_ID1	[	234	]	=	3463		ZHIZAO_ID2	[	234	]	=	4007		ZHIZAO_ID3	[234	]	=	2607		ZHIZAO__Rad	[	234	]	=	1
	-- ZHIZAO_ID	[	235	]	=	2791		ZHIZAO_LV	[	235	]	=	90		ZHIZAO_ID1	[	235	]	=	4037		ZHIZAO_ID2	[	235	]	=	4007		ZHIZAO_ID3	[235	]	=	2607		ZHIZAO__Rad	[	235	]	=	1
	-- ZHIZAO_ID	[	236	]	=	2791		ZHIZAO_LV	[	236	]	=	90		ZHIZAO_ID1	[	236	]	=	3463		ZHIZAO_ID2	[	236	]	=	4007		ZHIZAO_ID3	[236	]	=	2607		ZHIZAO__Rad	[	236	]	=	1
	-- ZHIZAO_ID	[	237	]	=	2794		ZHIZAO_LV	[	237	]	=	90		ZHIZAO_ID1	[	237	]	=	4037		ZHIZAO_ID2	[	237	]	=	4007		ZHIZAO_ID3	[237	]	=	2607		ZHIZAO__Rad	[	237	]	=	1
	-- ZHIZAO_ID	[	238	]	=	2806		ZHIZAO_LV	[	238	]	=	90		ZHIZAO_ID1	[	238	]	=	3463		ZHIZAO_ID2	[	238	]	=	4007		ZHIZAO_ID3	[238	]	=	2607		ZHIZAO__Rad	[	238	]	=	1
	-- ZHIZAO_ID	[	239	]	=	2806		ZHIZAO_LV	[	239	]	=	90		ZHIZAO_ID1	[	239	]	=	1711		ZHIZAO_ID2	[	239	]	=	4007		ZHIZAO_ID3	[239	]	=	2610		ZHIZAO__Rad	[	239	]	=	1
	-- ZHIZAO_ID	[	240	]	=	2808		ZHIZAO_LV	[	240	]	=	90		ZHIZAO_ID1	[	240	]	=	1758		ZHIZAO_ID2	[	240	]	=	4007		ZHIZAO_ID3	[240	]	=	2610		ZHIZAO__Rad	[	240	]	=	1
	-- ZHIZAO_ID	[	241	]	=	2809		ZHIZAO_LV	[	241	]	=	90		ZHIZAO_ID1	[	241	]	=	1711		ZHIZAO_ID2	[	241	]	=	4007		ZHIZAO_ID3	[241	]	=	2610		ZHIZAO__Rad	[	241	]	=	1
	-- ZHIZAO_ID	[	242	]	=	2795		ZHIZAO_LV	[	242	]	=	90		ZHIZAO_ID1	[	242	]	=	1711		ZHIZAO_ID2	[	242	]	=	4007		ZHIZAO_ID3	[242	]	=	2610		ZHIZAO__Rad	[	242	]	=	1
	-- ZHIZAO_ID	[	243	]	=	2796		ZHIZAO_LV	[	243	]	=	90		ZHIZAO_ID1	[	243	]	=	1758		ZHIZAO_ID2	[	243	]	=	4007		ZHIZAO_ID3	[243	]	=	2610		ZHIZAO__Rad	[	243	]	=	1
	-- ZHIZAO_ID	[	244	]	=	2813		ZHIZAO_LV	[	244	]	=	90		ZHIZAO_ID1	[	244	]	=	1711		ZHIZAO_ID2	[	244	]	=	4007		ZHIZAO_ID3	[244	]	=	2610		ZHIZAO__Rad	[	244	]	=	1
	-- ZHIZAO_ID	[	245	]	=	2796		ZHIZAO_LV	[	245	]	=	90		ZHIZAO_ID1	[	245	]	=	1758		ZHIZAO_ID2	[	245	]	=	4007		ZHIZAO_ID3	[245	]	=	2610		ZHIZAO__Rad	[	245	]	=	1
	-- ZHIZAO_ID	[	246	]	=	2797		ZHIZAO_LV	[	246	]	=	90		ZHIZAO_ID1	[	246	]	=	1711		ZHIZAO_ID2	[	246	]	=	4007		ZHIZAO_ID3	[246	]	=	2610		ZHIZAO__Rad	[	246	]	=	1
	-- ZHIZAO_ID	[	247	]	=	2798		ZHIZAO_LV	[	247	]	=	90		ZHIZAO_ID1	[	247	]	=	1758		ZHIZAO_ID2	[	247	]	=	4007		ZHIZAO_ID3	[247	]	=	2610		ZHIZAO__Rad	[	247	]	=	1
	-- ZHIZAO_ID	[	248	]	=	2799		ZHIZAO_LV	[	248	]	=	90		ZHIZAO_ID1	[	248	]	=	1711		ZHIZAO_ID2	[	248	]	=	4007		ZHIZAO_ID3	[248	]	=	2610		ZHIZAO__Rad	[	248	]	=	1
	-- ZHIZAO_ID	[	249	]	=	2799		ZHIZAO_LV	[	249	]	=	90		ZHIZAO_ID1	[	249	]	=	1711		ZHIZAO_ID2	[	249	]	=	4007		ZHIZAO_ID3	[249	]	=	2610		ZHIZAO__Rad	[	249	]	=	1
	-- ZHIZAO_ID	[	250	]	=	2807		ZHIZAO_LV	[	250	]	=	90		ZHIZAO_ID1	[	250	]	=	1758		ZHIZAO_ID2	[	250	]	=	4007		ZHIZAO_ID3	[250	]	=	2610		ZHIZAO__Rad	[	250	]	=	1
	-- ZHIZAO_ID	[	251	]	=	2814		ZHIZAO_LV	[	251	]	=	90		ZHIZAO_ID1	[	251	]	=	1758		ZHIZAO_ID2	[	251	]	=	4007		ZHIZAO_ID3	[251	]	=	2610		ZHIZAO__Rad	[	251	]	=	1
	-- ZHIZAO_ID	[	252	]	=	2794		ZHIZAO_LV	[	252	]	=	90		ZHIZAO_ID1	[	252	]	=	1758		ZHIZAO_ID2	[	252	]	=	4007		ZHIZAO_ID3	[252	]	=	2610		ZHIZAO__Rad	[	252	]	=	1
	-- ZHIZAO_ID	[	253	]	=	2236		ZHIZAO_LV	[	253	]	=	100		ZHIZAO_ID1	[	253	]	=	1797		ZHIZAO_ID2	[	253	]	=	4008		ZHIZAO_ID3	[253	]	=	2665		ZHIZAO__Rad	[	253	]	=	5
	-- ZHIZAO_ID	[	254	]	=	2236		ZHIZAO_LV	[	254	]	=	100		ZHIZAO_ID1	[	254	]	=	1797		ZHIZAO_ID2	[	254	]	=	4008		ZHIZAO_ID3	[254	]	=	2665		ZHIZAO__Rad	[	254	]	=	5
	-- ZHIZAO_ID	[	255	]	=	2236		ZHIZAO_LV	[	255	]	=	100		ZHIZAO_ID1	[	255	]	=	1797		ZHIZAO_ID2	[	255	]	=	4008		ZHIZAO_ID3	[255	]	=	2665		ZHIZAO__Rad	[	255	]	=	5
	-- ZHIZAO_ID	[	256	]	=	2236		ZHIZAO_LV	[	256	]	=	100		ZHIZAO_ID1	[	256	]	=	1797		ZHIZAO_ID2	[	256	]	=	4008		ZHIZAO_ID3	[256	]	=	2665		ZHIZAO__Rad	[	256	]	=	5
	-- ZHIZAO_ID	[	257	]	=	2793		ZHIZAO_LV	[	257	]	=	100		ZHIZAO_ID1	[	257	]	=	4038		ZHIZAO_ID2	[	257	]	=	4008		ZHIZAO_ID3	[257	]	=	2610		ZHIZAO__Rad	[	257	]	=	1
	-- ZHIZAO_ID	[	258	]	=	2380		ZHIZAO_LV	[	258	]	=	100		ZHIZAO_ID1	[	258	]	=	4038		ZHIZAO_ID2	[	258	]	=	4008		ZHIZAO_ID3	[258	]	=	2610		ZHIZAO__Rad	[	258	]	=	1
	-- ZHIZAO_ID	[	259	]	=	2793		ZHIZAO_LV	[	259	]	=	100		ZHIZAO_ID1	[	259	]	=	4038		ZHIZAO_ID2	[	259	]	=	4008		ZHIZAO_ID3	[259	]	=	2610		ZHIZAO__Rad	[	259	]	=	1
	-- ZHIZAO_ID	[	260	]	=	2802		ZHIZAO_LV	[	260	]	=	100		ZHIZAO_ID1	[	260	]	=	4038		ZHIZAO_ID2	[	260	]	=	4008		ZHIZAO_ID3	[260	]	=	2610		ZHIZAO__Rad	[	260	]	=	1
	-- ZHIZAO_ID	[	261	]	=	2801		ZHIZAO_LV	[	261	]	=	100		ZHIZAO_ID1	[	261	]	=	4038		ZHIZAO_ID2	[	261	]	=	4008		ZHIZAO_ID3	[261	]	=	2610		ZHIZAO__Rad	[	261	]	=	1
	-- ZHIZAO_ID	[	262	]	=	2792		ZHIZAO_LV	[	262	]	=	100		ZHIZAO_ID1	[	262	]	=	4038		ZHIZAO_ID2	[	262	]	=	4008		ZHIZAO_ID3	[262	]	=	2610		ZHIZAO__Rad	[	262	]	=	1
	-- ZHIZAO_ID	[	263	]	=	2791		ZHIZAO_LV	[	263	]	=	100		ZHIZAO_ID1	[	263	]	=	4038		ZHIZAO_ID2	[	263	]	=	4008		ZHIZAO_ID3	[263	]	=	2610		ZHIZAO__Rad	[	263	]	=	1
	-- ZHIZAO_ID	[	264	]	=	2791		ZHIZAO_LV	[	264	]	=	100		ZHIZAO_ID1	[	264	]	=	4038		ZHIZAO_ID2	[	264	]	=	4008		ZHIZAO_ID3	[264	]	=	2610		ZHIZAO__Rad	[	264	]	=	1
	-- ZHIZAO_ID	[	265	]	=	2794		ZHIZAO_LV	[	265	]	=	100		ZHIZAO_ID1	[	265	]	=	4038		ZHIZAO_ID2	[	265	]	=	4008		ZHIZAO_ID3	[265	]	=	2610		ZHIZAO__Rad	[	265	]	=	1
	-- ZHIZAO_ID	[	266	]	=	2806		ZHIZAO_LV	[	266	]	=	100		ZHIZAO_ID1	[	266	]	=	4038		ZHIZAO_ID2	[	266	]	=	4008		ZHIZAO_ID3	[266	]	=	2610		ZHIZAO__Rad	[	266	]	=	1
	-- ZHIZAO_ID	[	267	]	=	2806		ZHIZAO_LV	[	267	]	=	100		ZHIZAO_ID1	[	267	]	=	1626		ZHIZAO_ID2	[	267	]	=	4008		ZHIZAO_ID3	[267	]	=	2610		ZHIZAO__Rad	[	267	]	=	1
	-- ZHIZAO_ID	[	268	]	=	2808		ZHIZAO_LV	[	268	]	=	100		ZHIZAO_ID1	[	268	]	=	1626		ZHIZAO_ID2	[	268	]	=	4008		ZHIZAO_ID3	[268	]	=	2610		ZHIZAO__Rad	[	268	]	=	1
	-- ZHIZAO_ID	[	269	]	=	2809		ZHIZAO_LV	[	269	]	=	100		ZHIZAO_ID1	[	269	]	=	1626		ZHIZAO_ID2	[	269	]	=	4008		ZHIZAO_ID3	[269	]	=	2610		ZHIZAO__Rad	[	269	]	=	1
	-- ZHIZAO_ID	[	270	]	=	2795		ZHIZAO_LV	[	270	]	=	100		ZHIZAO_ID1	[	270	]	=	1626		ZHIZAO_ID2	[	270	]	=	4008		ZHIZAO_ID3	[270	]	=	2610		ZHIZAO__Rad	[	270	]	=	1
	-- ZHIZAO_ID	[	271	]	=	2796		ZHIZAO_LV	[	271	]	=	100		ZHIZAO_ID1	[	271	]	=	1626		ZHIZAO_ID2	[	271	]	=	4008		ZHIZAO_ID3	[271	]	=	2610		ZHIZAO__Rad	[	271	]	=	1
	-- ZHIZAO_ID	[	272	]	=	2813		ZHIZAO_LV	[	272	]	=	100		ZHIZAO_ID1	[	272	]	=	1626		ZHIZAO_ID2	[	272	]	=	4008		ZHIZAO_ID3	[272	]	=	2610		ZHIZAO__Rad	[	272	]	=	1
	-- ZHIZAO_ID	[	273	]	=	2796		ZHIZAO_LV	[	273	]	=	100		ZHIZAO_ID1	[	273	]	=	1626		ZHIZAO_ID2	[	273	]	=	4008		ZHIZAO_ID3	[273	]	=	2610		ZHIZAO__Rad	[	273	]	=	1
	-- ZHIZAO_ID	[	274	]	=	2797		ZHIZAO_LV	[	274	]	=	100		ZHIZAO_ID1	[	274	]	=	1626		ZHIZAO_ID2	[	274	]	=	4008		ZHIZAO_ID3	[274	]	=	2610		ZHIZAO__Rad	[	274	]	=	1
	-- ZHIZAO_ID	[	275	]	=	2798		ZHIZAO_LV	[	275	]	=	100		ZHIZAO_ID1	[	275	]	=	1626		ZHIZAO_ID2	[	275	]	=	4008		ZHIZAO_ID3	[275	]	=	2610		ZHIZAO__Rad	[	275	]	=	1
	-- ZHIZAO_ID	[	276	]	=	2799		ZHIZAO_LV	[	276	]	=	100		ZHIZAO_ID1	[	276	]	=	1626		ZHIZAO_ID2	[	276	]	=	4008		ZHIZAO_ID3	[276	]	=	2610		ZHIZAO__Rad	[	276	]	=	1
	-- ZHIZAO_ID	[	277	]	=	2799		ZHIZAO_LV	[	277	]	=	100		ZHIZAO_ID1	[	277	]	=	1626		ZHIZAO_ID2	[	277	]	=	4008		ZHIZAO_ID3	[277	]	=	2610		ZHIZAO__Rad	[	277	]	=	1
	-- ZHIZAO_ID	[	278	]	=	2807		ZHIZAO_LV	[	278	]	=	100		ZHIZAO_ID1	[	278	]	=	1626		ZHIZAO_ID2	[	278	]	=	4008		ZHIZAO_ID3	[278	]	=	2610		ZHIZAO__Rad	[	278	]	=	1
	-- ZHIZAO_ID	[	279	]	=	2814		ZHIZAO_LV	[	279	]	=	100		ZHIZAO_ID1	[	279	]	=	1626		ZHIZAO_ID2	[	279	]	=	4008		ZHIZAO_ID3	[279	]	=	2610		ZHIZAO__Rad	[	279	]	=	1
	-- ZHIZAO_ID	[	280	]	=	2794		ZHIZAO_LV	[	280	]	=	100		ZHIZAO_ID1	[	280	]	=	1626		ZHIZAO_ID2	[	280	]	=	4008		ZHIZAO_ID3	[280	]	=	2610		ZHIZAO__Rad	[	280	]	=	1




																																									
--	铸造																																								
--	物品质量							宝箱物品上限																																	
	ZHUZAO_Qua	=	5	 				ZHUZAO_Mxcount	=	902																															
	ZHUZAO_ID	=	{}					ZHUZAO_LV	=	{}					ZHUZAO_ID1	=	{}					ZHUZAO_ID2	=	{}					ZHUZAO_ID3	=	{}					ZHUZAO__Rad	=	{}			
	ZHUZAO_ID	[	1	]	=	635		ZHUZAO_LV	[	1	]	=	10		ZHUZAO_ID1	[	1	]	=	4029		ZHUZAO_ID2	[	1	]	=	1720		ZHUZAO_ID3	[	1	]	=	2640		ZHUZAO__Rad	[	1	]	=	1
	ZHUZAO_ID	[	2	]	=	817		ZHUZAO_LV	[	2	]	=	10		ZHUZAO_ID1	[	2	]	=	4029		ZHUZAO_ID2	[	2	]	=	3989		ZHUZAO_ID3	[	2	]	=	2640		ZHUZAO__Rad	[	2	]	=	1
	ZHUZAO_ID	[	3	]	=	867		ZHUZAO_LV	[	3	]	=	10		ZHUZAO_ID1	[	3	]	=	4029		ZHUZAO_ID2	[	3	]	=	1720		ZHUZAO_ID3	[	3	]	=	2640		ZHUZAO__Rad	[	3	]	=	1
	ZHUZAO_ID	[	4	]	=	872		ZHUZAO_LV	[	4	]	=	10		ZHUZAO_ID1	[	4	]	=	4029		ZHUZAO_ID2	[	4	]	=	3989		ZHUZAO_ID3	[	4	]	=	2640		ZHUZAO__Rad	[	4	]	=	1
	ZHUZAO_ID	[	5	]	=	6534		ZHUZAO_LV	[	5	]	=	10		ZHUZAO_ID1	[	5	]	=	4029		ZHUZAO_ID2	[	5	]	=	1720		ZHUZAO_ID3	[	5	]	=	2640		ZHUZAO__Rad	[	5	]	=	1
	ZHUZAO_ID	[	6	]	=	6534		ZHUZAO_LV	[	6	]	=	10		ZHUZAO_ID1	[	6	]	=	4029		ZHUZAO_ID2	[	6	]	=	3989		ZHUZAO_ID3	[	6	]	=	2640		ZHUZAO__Rad	[	6	]	=	1
	ZHUZAO_ID	[	7	]	=	6534		ZHUZAO_LV	[	7	]	=	10		ZHUZAO_ID1	[	7	]	=	4029		ZHUZAO_ID2	[	7	]	=	1720		ZHUZAO_ID3	[	7	]	=	2640		ZHUZAO__Rad	[	7	]	=	1
	ZHUZAO_ID	[	8	]	=	6534		ZHUZAO_LV	[	8	]	=	10		ZHUZAO_ID1	[	8	]	=	4029		ZHUZAO_ID2	[	8	]	=	3989		ZHUZAO_ID3	[	8	]	=	2640		ZHUZAO__Rad	[	8	]	=	1
	ZHUZAO_ID	[	9	]	=	6534		ZHUZAO_LV	[	9	]	=	10		ZHUZAO_ID1	[	9	]	=	4029		ZHUZAO_ID2	[	9	]	=	1720		ZHUZAO_ID3	[	9	]	=	2640		ZHUZAO__Rad	[	9	]	=	1
	ZHUZAO_ID	[	10	]	=	6534		ZHUZAO_LV	[	10	]	=	10		ZHUZAO_ID1	[	10	]	=	4029		ZHUZAO_ID2	[	10	]	=	3989		ZHUZAO_ID3	[	10	]	=	2640		ZHUZAO__Rad	[	10	]	=	1
	ZHUZAO_ID	[	11	]	=	1443		ZHUZAO_LV	[	11	]	=	10		ZHUZAO_ID1	[	11	]	=	4029		ZHUZAO_ID2	[	11	]	=	1720		ZHUZAO_ID3	[	11	]	=	2640		ZHUZAO__Rad	[	11	]	=	1
	ZHUZAO_ID	[	12	]	=	97		ZHUZAO_LV	[	12	]	=	10		ZHUZAO_ID1	[	12	]	=	4029		ZHUZAO_ID2	[	12	]	=	3989		ZHUZAO_ID3	[	12	]	=	2640		ZHUZAO__Rad	[	12	]	=	1
	ZHUZAO_ID	[	13	]	=	1427		ZHUZAO_LV	[	13	]	=	10		ZHUZAO_ID1	[	13	]	=	4029		ZHUZAO_ID2	[	13	]	=	1720		ZHUZAO_ID3	[	13	]	=	2640		ZHUZAO__Rad	[	13	]	=	1
	ZHUZAO_ID	[	14	]	=	1462		ZHUZAO_LV	[	14	]	=	10		ZHUZAO_ID1	[	14	]	=	4029		ZHUZAO_ID2	[	14	]	=	3989		ZHUZAO_ID3	[	14	]	=	2640		ZHUZAO__Rad	[	14	]	=	1
	ZHUZAO_ID	[	15	]	=	6534		ZHUZAO_LV	[	15	]	=	10		ZHUZAO_ID1	[	15	]	=	4029		ZHUZAO_ID2	[	15	]	=	1720		ZHUZAO_ID3	[	15	]	=	2640		ZHUZAO__Rad	[	15	]	=	1
	ZHUZAO_ID	[	16	]	=	2202		ZHUZAO_LV	[	16	]	=	10		ZHUZAO_ID1	[	16	]	=	4029		ZHUZAO_ID2	[	16	]	=	3989		ZHUZAO_ID3	[	16	]	=	2640		ZHUZAO__Rad	[	16	]	=	1
	ZHUZAO_ID	[	17	]	=	2205		ZHUZAO_LV	[	17	]	=	10		ZHUZAO_ID1	[	17	]	=	4029		ZHUZAO_ID2	[	17	]	=	1720		ZHUZAO_ID3	[	17	]	=	2640		ZHUZAO__Rad	[	17	]	=	1
	ZHUZAO_ID	[	18	]	=	335		ZHUZAO_LV	[	18	]	=	10		ZHUZAO_ID1	[	18	]	=	4029		ZHUZAO_ID2	[	18	]	=	3989		ZHUZAO_ID3	[	18	]	=	2640		ZHUZAO__Rad	[	18	]	=	1
	ZHUZAO_ID	[	19	]	=	305		ZHUZAO_LV	[	19	]	=	10		ZHUZAO_ID1	[	19	]	=	4029		ZHUZAO_ID2	[	19	]	=	1720		ZHUZAO_ID3	[	19	]	=	2640		ZHUZAO__Rad	[	19	]	=	1
	ZHUZAO_ID	[	20	]	=	380		ZHUZAO_LV	[	20	]	=	10		ZHUZAO_ID1	[	20	]	=	4029		ZHUZAO_ID2	[	20	]	=	3989		ZHUZAO_ID3	[	20	]	=	2640		ZHUZAO__Rad	[	20	]	=	1
	ZHUZAO_ID	[	21	]	=	6534		ZHUZAO_LV	[	21	]	=	10		ZHUZAO_ID1	[	21	]	=	4029		ZHUZAO_ID2	[	21	]	=	1720		ZHUZAO_ID3	[	21	]	=	2640		ZHUZAO__Rad	[	21	]	=	1
	ZHUZAO_ID	[	22	]	=	365		ZHUZAO_LV	[	22	]	=	10		ZHUZAO_ID1	[	22	]	=	4029		ZHUZAO_ID2	[	22	]	=	3989		ZHUZAO_ID3	[	22	]	=	2640		ZHUZAO__Rad	[	22	]	=	1
	ZHUZAO_ID	[	23	]	=	383		ZHUZAO_LV	[	23	]	=	10		ZHUZAO_ID1	[	23	]	=	4029		ZHUZAO_ID2	[	23	]	=	1720		ZHUZAO_ID3	[	23	]	=	2640		ZHUZAO__Rad	[	23	]	=	1
	ZHUZAO_ID	[	24	]	=	511		ZHUZAO_LV	[	24	]	=	10		ZHUZAO_ID1	[	24	]	=	4029		ZHUZAO_ID2	[	24	]	=	3989		ZHUZAO_ID3	[	24	]	=	2640		ZHUZAO__Rad	[	24	]	=	1
	ZHUZAO_ID	[	25	]	=	481		ZHUZAO_LV	[	25	]	=	10		ZHUZAO_ID1	[	25	]	=	4029		ZHUZAO_ID2	[	25	]	=	1720		ZHUZAO_ID3	[	25	]	=	2640		ZHUZAO__Rad	[	25	]	=	1
	ZHUZAO_ID	[	26	]	=	556		ZHUZAO_LV	[	26	]	=	10		ZHUZAO_ID1	[	26	]	=	4029		ZHUZAO_ID2	[	26	]	=	3989		ZHUZAO_ID3	[	26	]	=	2640		ZHUZAO__Rad	[	26	]	=	1
	ZHUZAO_ID	[	27	]	=	466		ZHUZAO_LV	[	27	]	=	10		ZHUZAO_ID1	[	27	]	=	4029		ZHUZAO_ID2	[	27	]	=	1720		ZHUZAO_ID3	[	27	]	=	2640		ZHUZAO__Rad	[	27	]	=	1
	ZHUZAO_ID	[	28	]	=	541		ZHUZAO_LV	[	28	]	=	10		ZHUZAO_ID1	[	28	]	=	4029		ZHUZAO_ID2	[	28	]	=	3989		ZHUZAO_ID3	[	28	]	=	2640		ZHUZAO__Rad	[	28	]	=	1
	ZHUZAO_ID	[	29	]	=	559		ZHUZAO_LV	[	29	]	=	10		ZHUZAO_ID1	[	29	]	=	4029		ZHUZAO_ID2	[	29	]	=	1720		ZHUZAO_ID3	[	29	]	=	2640		ZHUZAO__Rad	[	29	]	=	1
	ZHUZAO_ID	[	30	]	=	6534		ZHUZAO_LV	[	30	]	=	10		ZHUZAO_ID1	[	30	]	=	4029		ZHUZAO_ID2	[	30	]	=	3989		ZHUZAO_ID3	[	30	]	=	2640		ZHUZAO__Rad	[	30	]	=	1
	ZHUZAO_ID	[	31	]	=	657		ZHUZAO_LV	[	31	]	=	10		ZHUZAO_ID1	[	31	]	=	4029		ZHUZAO_ID2	[	31	]	=	1720		ZHUZAO_ID3	[	31	]	=	2640		ZHUZAO__Rad	[	31	]	=	1
	ZHUZAO_ID	[	32	]	=	732		ZHUZAO_LV	[	32	]	=	10		ZHUZAO_ID1	[	32	]	=	4029		ZHUZAO_ID2	[	32	]	=	3989		ZHUZAO_ID3	[	32	]	=	2640		ZHUZAO__Rad	[	32	]	=	1
	ZHUZAO_ID	[	33	]	=	6534		ZHUZAO_LV	[	33	]	=	10		ZHUZAO_ID1	[	33	]	=	4029		ZHUZAO_ID2	[	33	]	=	1720		ZHUZAO_ID3	[	33	]	=	2640		ZHUZAO__Rad	[	33	]	=	1
	ZHUZAO_ID	[	34	]	=	6534		ZHUZAO_LV	[	34	]	=	10		ZHUZAO_ID1	[	34	]	=	4029		ZHUZAO_ID2	[	34	]	=	3989		ZHUZAO_ID3	[	34	]	=	2640		ZHUZAO__Rad	[	34	]	=	1
	ZHUZAO_ID	[	35	]	=	735		ZHUZAO_LV	[	35	]	=	10		ZHUZAO_ID1	[	35	]	=	4029		ZHUZAO_ID2	[	35	]	=	1720		ZHUZAO_ID3	[	35	]	=	2640		ZHUZAO__Rad	[	35	]	=	1
	ZHUZAO_ID	[	36	]	=	4666		ZHUZAO_LV	[	36	]	=	15		ZHUZAO_ID1	[	36	]	=	4029		ZHUZAO_ID2	[	36	]	=	3989		ZHUZAO_ID3	[	36	]	=	2640		ZHUZAO__Rad	[	36	]	=	1
	ZHUZAO_ID	[	37	]	=	4667		ZHUZAO_LV	[	37	]	=	15		ZHUZAO_ID1	[	37	]	=	4029		ZHUZAO_ID2	[	37	]	=	1720		ZHUZAO_ID3	[	37	]	=	2640		ZHUZAO__Rad	[	37	]	=	1
	ZHUZAO_ID	[	38	]	=	4668		ZHUZAO_LV	[	38	]	=	15		ZHUZAO_ID1	[	38	]	=	4029		ZHUZAO_ID2	[	38	]	=	3989		ZHUZAO_ID3	[	38	]	=	2640		ZHUZAO__Rad	[	38	]	=	1
	ZHUZAO_ID	[	39	]	=	4669		ZHUZAO_LV	[	39	]	=	15		ZHUZAO_ID1	[	39	]	=	4029		ZHUZAO_ID2	[	39	]	=	1720		ZHUZAO_ID3	[	39	]	=	2640		ZHUZAO__Rad	[	39	]	=	1
	ZHUZAO_ID	[	40	]	=	4611		ZHUZAO_LV	[	40	]	=	15		ZHUZAO_ID1	[	40	]	=	4029		ZHUZAO_ID2	[	40	]	=	3989		ZHUZAO_ID3	[	40	]	=	2640		ZHUZAO__Rad	[	40	]	=	1
	ZHUZAO_ID	[	41	]	=	4612		ZHUZAO_LV	[	41	]	=	15		ZHUZAO_ID1	[	41	]	=	4029		ZHUZAO_ID2	[	41	]	=	1720		ZHUZAO_ID3	[	41	]	=	2640		ZHUZAO__Rad	[	41	]	=	1
	ZHUZAO_ID	[	42	]	=	4613		ZHUZAO_LV	[	42	]	=	15		ZHUZAO_ID1	[	42	]	=	4029		ZHUZAO_ID2	[	42	]	=	3989		ZHUZAO_ID3	[	42	]	=	2640		ZHUZAO__Rad	[	42	]	=	1
	ZHUZAO_ID	[	43	]	=	4614		ZHUZAO_LV	[	43	]	=	15		ZHUZAO_ID1	[	43	]	=	4029		ZHUZAO_ID2	[	43	]	=	1720		ZHUZAO_ID3	[	43	]	=	2640		ZHUZAO__Rad	[	43	]	=	1
	ZHUZAO_ID	[	44	]	=	4615		ZHUZAO_LV	[	44	]	=	15		ZHUZAO_ID1	[	44	]	=	4029		ZHUZAO_ID2	[	44	]	=	3989		ZHUZAO_ID3	[	44	]	=	2640		ZHUZAO__Rad	[	44	]	=	1
	ZHUZAO_ID	[	45	]	=	6534		ZHUZAO_LV	[	45	]	=	15		ZHUZAO_ID1	[	45	]	=	4029		ZHUZAO_ID2	[	45	]	=	1720		ZHUZAO_ID3	[	45	]	=	2640		ZHUZAO__Rad	[	45	]	=	1
	ZHUZAO_ID	[	46	]	=	1395		ZHUZAO_LV	[	46	]	=	15		ZHUZAO_ID1	[	46	]	=	4029		ZHUZAO_ID2	[	46	]	=	3989		ZHUZAO_ID3	[	46	]	=	2640		ZHUZAO__Rad	[	46	]	=	1
	ZHUZAO_ID	[	47	]	=	6534		ZHUZAO_LV	[	47	]	=	15		ZHUZAO_ID1	[	47	]	=	4029		ZHUZAO_ID2	[	47	]	=	1720		ZHUZAO_ID3	[	47	]	=	2640		ZHUZAO__Rad	[	47	]	=	1
	ZHUZAO_ID	[	48	]	=	1370		ZHUZAO_LV	[	48	]	=	15		ZHUZAO_ID1	[	48	]	=	4029		ZHUZAO_ID2	[	48	]	=	3989		ZHUZAO_ID3	[	48	]	=	2640		ZHUZAO__Rad	[	48	]	=	1
	ZHUZAO_ID	[	49	]	=	1379		ZHUZAO_LV	[	49	]	=	15		ZHUZAO_ID1	[	49	]	=	4029		ZHUZAO_ID2	[	49	]	=	1720		ZHUZAO_ID3	[	49	]	=	2640		ZHUZAO__Rad	[	49	]	=	1
	ZHUZAO_ID	[	50	]	=	32		ZHUZAO_LV	[	50	]	=	15		ZHUZAO_ID1	[	50	]	=	4029		ZHUZAO_ID2	[	50	]	=	3989		ZHUZAO_ID3	[	50	]	=	2640		ZHUZAO__Rad	[	50	]	=	1
	ZHUZAO_ID	[	51	]	=	1403		ZHUZAO_LV	[	51	]	=	15		ZHUZAO_ID1	[	51	]	=	4029		ZHUZAO_ID2	[	51	]	=	1720		ZHUZAO_ID3	[	51	]	=	2640		ZHUZAO__Rad	[	51	]	=	1
	ZHUZAO_ID	[	52	]	=	80		ZHUZAO_LV	[	52	]	=	15		ZHUZAO_ID1	[	52	]	=	4029		ZHUZAO_ID2	[	52	]	=	3989		ZHUZAO_ID3	[	52	]	=	2640		ZHUZAO__Rad	[	52	]	=	1
	ZHUZAO_ID	[	53	]	=	1422		ZHUZAO_LV	[	53	]	=	15		ZHUZAO_ID1	[	53	]	=	4029		ZHUZAO_ID2	[	53	]	=	1720		ZHUZAO_ID3	[	53	]	=	2640		ZHUZAO__Rad	[	53	]	=	1
	ZHUZAO_ID	[	54	]	=	1450		ZHUZAO_LV	[	54	]	=	15		ZHUZAO_ID1	[	54	]	=	4029		ZHUZAO_ID2	[	54	]	=	3989		ZHUZAO_ID3	[	54	]	=	2640		ZHUZAO__Rad	[	54	]	=	1
	ZHUZAO_ID	[	55	]	=	6534		ZHUZAO_LV	[	55	]	=	15		ZHUZAO_ID1	[	55	]	=	4029		ZHUZAO_ID2	[	55	]	=	1720		ZHUZAO_ID3	[	55	]	=	2640		ZHUZAO__Rad	[	55	]	=	1
	ZHUZAO_ID	[	56	]	=	6534		ZHUZAO_LV	[	56	]	=	15		ZHUZAO_ID1	[	56	]	=	4029		ZHUZAO_ID2	[	56	]	=	3989		ZHUZAO_ID3	[	56	]	=	2640		ZHUZAO__Rad	[	56	]	=	1
	ZHUZAO_ID	[	57	]	=	1469		ZHUZAO_LV	[	57	]	=	15		ZHUZAO_ID1	[	57	]	=	4029		ZHUZAO_ID2	[	57	]	=	1720		ZHUZAO_ID3	[	57	]	=	2640		ZHUZAO__Rad	[	57	]	=	1
	ZHUZAO_ID	[	58	]	=	2188		ZHUZAO_LV	[	58	]	=	15		ZHUZAO_ID1	[	58	]	=	4029		ZHUZAO_ID2	[	58	]	=	3989		ZHUZAO_ID3	[	58	]	=	2640		ZHUZAO__Rad	[	58	]	=	1
	ZHUZAO_ID	[	59	]	=	2196		ZHUZAO_LV	[	59	]	=	15		ZHUZAO_ID1	[	59	]	=	4029		ZHUZAO_ID2	[	59	]	=	1720		ZHUZAO_ID3	[	59	]	=	2640		ZHUZAO__Rad	[	59	]	=	1
	ZHUZAO_ID	[	60	]	=	311		ZHUZAO_LV	[	60	]	=	15		ZHUZAO_ID1	[	60	]	=	4029		ZHUZAO_ID2	[	60	]	=	3989		ZHUZAO_ID3	[	60	]	=	2640		ZHUZAO__Rad	[	60	]	=	1
	ZHUZAO_ID	[	61	]	=	351		ZHUZAO_LV	[	61	]	=	15		ZHUZAO_ID1	[	61	]	=	4029		ZHUZAO_ID2	[	61	]	=	1720		ZHUZAO_ID3	[	61	]	=	2640		ZHUZAO__Rad	[	61	]	=	1
	ZHUZAO_ID	[	62	]	=	336		ZHUZAO_LV	[	62	]	=	15		ZHUZAO_ID1	[	62	]	=	4029		ZHUZAO_ID2	[	62	]	=	3989		ZHUZAO_ID3	[	62	]	=	2640		ZHUZAO__Rad	[	62	]	=	1
	ZHUZAO_ID	[	63	]	=	372		ZHUZAO_LV	[	63	]	=	15		ZHUZAO_ID1	[	63	]	=	4029		ZHUZAO_ID2	[	63	]	=	1720		ZHUZAO_ID3	[	63	]	=	2640		ZHUZAO__Rad	[	63	]	=	1
	ZHUZAO_ID	[	64	]	=	359		ZHUZAO_LV	[	64	]	=	15		ZHUZAO_ID1	[	64	]	=	4029		ZHUZAO_ID2	[	64	]	=	3989		ZHUZAO_ID3	[	64	]	=	2640		ZHUZAO__Rad	[	64	]	=	1
	ZHUZAO_ID	[	65	]	=	296		ZHUZAO_LV	[	65	]	=	15		ZHUZAO_ID1	[	65	]	=	4029		ZHUZAO_ID2	[	65	]	=	1720		ZHUZAO_ID3	[	65	]	=	2640		ZHUZAO__Rad	[	65	]	=	1
	ZHUZAO_ID	[	66	]	=	489		ZHUZAO_LV	[	66	]	=	15		ZHUZAO_ID1	[	66	]	=	4029		ZHUZAO_ID2	[	66	]	=	3989		ZHUZAO_ID3	[	66	]	=	2640		ZHUZAO__Rad	[	66	]	=	1
	ZHUZAO_ID	[	67	]	=	527		ZHUZAO_LV	[	67	]	=	15		ZHUZAO_ID1	[	67	]	=	4029		ZHUZAO_ID2	[	67	]	=	1720		ZHUZAO_ID3	[	67	]	=	2640		ZHUZAO__Rad	[	67	]	=	1
	ZHUZAO_ID	[	68	]	=	512		ZHUZAO_LV	[	68	]	=	15		ZHUZAO_ID1	[	68	]	=	4029		ZHUZAO_ID2	[	68	]	=	3989		ZHUZAO_ID3	[	68	]	=	2640		ZHUZAO__Rad	[	68	]	=	1
	ZHUZAO_ID	[	69	]	=	548		ZHUZAO_LV	[	69	]	=	15		ZHUZAO_ID1	[	69	]	=	4029		ZHUZAO_ID2	[	69	]	=	1720		ZHUZAO_ID3	[	69	]	=	2640		ZHUZAO__Rad	[	69	]	=	1
	ZHUZAO_ID	[	70	]	=	535		ZHUZAO_LV	[	70	]	=	15		ZHUZAO_ID1	[	70	]	=	4029		ZHUZAO_ID2	[	70	]	=	3989		ZHUZAO_ID3	[	70	]	=	2640		ZHUZAO__Rad	[	70	]	=	1
	ZHUZAO_ID	[	71	]	=	472		ZHUZAO_LV	[	71	]	=	15		ZHUZAO_ID1	[	71	]	=	4029		ZHUZAO_ID2	[	71	]	=	1720		ZHUZAO_ID3	[	71	]	=	2640		ZHUZAO__Rad	[	71	]	=	1
	ZHUZAO_ID	[	72	]	=	663		ZHUZAO_LV	[	72	]	=	15		ZHUZAO_ID1	[	72	]	=	4029		ZHUZAO_ID2	[	72	]	=	3989		ZHUZAO_ID3	[	72	]	=	2640		ZHUZAO__Rad	[	72	]	=	1
	ZHUZAO_ID	[	73	]	=	703		ZHUZAO_LV	[	73	]	=	15		ZHUZAO_ID1	[	73	]	=	4029		ZHUZAO_ID2	[	73	]	=	1720		ZHUZAO_ID3	[	73	]	=	2640		ZHUZAO__Rad	[	73	]	=	1
	ZHUZAO_ID	[	74	]	=	688		ZHUZAO_LV	[	74	]	=	15		ZHUZAO_ID1	[	74	]	=	4029		ZHUZAO_ID2	[	74	]	=	3989		ZHUZAO_ID3	[	74	]	=	2640		ZHUZAO__Rad	[	74	]	=	1
	ZHUZAO_ID	[	75	]	=	724		ZHUZAO_LV	[	75	]	=	15		ZHUZAO_ID1	[	75	]	=	4029		ZHUZAO_ID2	[	75	]	=	1720		ZHUZAO_ID3	[	75	]	=	2640		ZHUZAO__Rad	[	75	]	=	1
	ZHUZAO_ID	[	76	]	=	711		ZHUZAO_LV	[	76	]	=	15		ZHUZAO_ID1	[	76	]	=	4029		ZHUZAO_ID2	[	76	]	=	3989		ZHUZAO_ID3	[	76	]	=	2640		ZHUZAO__Rad	[	76	]	=	1
	ZHUZAO_ID	[	77	]	=	648		ZHUZAO_LV	[	77	]	=	15		ZHUZAO_ID1	[	77	]	=	4029		ZHUZAO_ID2	[	77	]	=	1720		ZHUZAO_ID3	[	77	]	=	2640		ZHUZAO__Rad	[	77	]	=	1
	ZHUZAO_ID	[	78	]	=	4671		ZHUZAO_LV	[	78	]	=	20		ZHUZAO_ID1	[	78	]	=	4030		ZHUZAO_ID2	[	78	]	=	1677		ZHUZAO_ID3	[	78	]	=	2640		ZHUZAO__Rad	[	78	]	=	1
	ZHUZAO_ID	[	79	]	=	4672		ZHUZAO_LV	[	79	]	=	20		ZHUZAO_ID1	[	79	]	=	4030		ZHUZAO_ID2	[	79	]	=	3990		ZHUZAO_ID3	[	79	]	=	2640		ZHUZAO__Rad	[	79	]	=	1
	ZHUZAO_ID	[	80	]	=	4673		ZHUZAO_LV	[	80	]	=	20		ZHUZAO_ID1	[	80	]	=	4030		ZHUZAO_ID2	[	80	]	=	1677		ZHUZAO_ID3	[	80	]	=	2640		ZHUZAO__Rad	[	80	]	=	1
	ZHUZAO_ID	[	81	]	=	4674		ZHUZAO_LV	[	81	]	=	20		ZHUZAO_ID1	[	81	]	=	4030		ZHUZAO_ID2	[	81	]	=	3990		ZHUZAO_ID3	[	81	]	=	2640		ZHUZAO__Rad	[	81	]	=	1
	ZHUZAO_ID	[	82	]	=	4675		ZHUZAO_LV	[	82	]	=	20		ZHUZAO_ID1	[	82	]	=	4030		ZHUZAO_ID2	[	82	]	=	1677		ZHUZAO_ID3	[	82	]	=	2640		ZHUZAO__Rad	[	82	]	=	1
	ZHUZAO_ID	[	83	]	=	4616		ZHUZAO_LV	[	83	]	=	20		ZHUZAO_ID1	[	83	]	=	4030		ZHUZAO_ID2	[	83	]	=	3990		ZHUZAO_ID3	[	83	]	=	2640		ZHUZAO__Rad	[	83	]	=	1
	ZHUZAO_ID	[	84	]	=	4617		ZHUZAO_LV	[	84	]	=	20		ZHUZAO_ID1	[	84	]	=	4030		ZHUZAO_ID2	[	84	]	=	1677		ZHUZAO_ID3	[	84	]	=	2640		ZHUZAO__Rad	[	84	]	=	1
	ZHUZAO_ID	[	85	]	=	4618		ZHUZAO_LV	[	85	]	=	20		ZHUZAO_ID1	[	85	]	=	4030		ZHUZAO_ID2	[	85	]	=	3990		ZHUZAO_ID3	[	85	]	=	2640		ZHUZAO__Rad	[	85	]	=	1
	ZHUZAO_ID	[	86	]	=	4619		ZHUZAO_LV	[	86	]	=	20		ZHUZAO_ID1	[	86	]	=	4030		ZHUZAO_ID2	[	86	]	=	1677		ZHUZAO_ID3	[	86	]	=	2640		ZHUZAO__Rad	[	86	]	=	1
	ZHUZAO_ID	[	87	]	=	4620		ZHUZAO_LV	[	87	]	=	20		ZHUZAO_ID1	[	87	]	=	4030		ZHUZAO_ID2	[	87	]	=	3990		ZHUZAO_ID3	[	87	]	=	2640		ZHUZAO__Rad	[	87	]	=	1
	ZHUZAO_ID	[	88	]	=	636		ZHUZAO_LV	[	88	]	=	20		ZHUZAO_ID1	[	88	]	=	4030		ZHUZAO_ID2	[	88	]	=	1677		ZHUZAO_ID3	[	88	]	=	2640		ZHUZAO__Rad	[	88	]	=	1
	ZHUZAO_ID	[	89	]	=	818		ZHUZAO_LV	[	89	]	=	20		ZHUZAO_ID1	[	89	]	=	4030		ZHUZAO_ID2	[	89	]	=	3990		ZHUZAO_ID3	[	89	]	=	2640		ZHUZAO__Rad	[	89	]	=	1
	ZHUZAO_ID	[	90	]	=	868		ZHUZAO_LV	[	90	]	=	20		ZHUZAO_ID1	[	90	]	=	4030		ZHUZAO_ID2	[	90	]	=	1677		ZHUZAO_ID3	[	90	]	=	2640		ZHUZAO__Rad	[	90	]	=	1
	ZHUZAO_ID	[	91	]	=	873		ZHUZAO_LV	[	91	]	=	20		ZHUZAO_ID1	[	91	]	=	4030		ZHUZAO_ID2	[	91	]	=	3990		ZHUZAO_ID3	[	91	]	=	2640		ZHUZAO__Rad	[	91	]	=	1
	ZHUZAO_ID	[	92	]	=	2		ZHUZAO_LV	[	92	]	=	20		ZHUZAO_ID1	[	92	]	=	4030		ZHUZAO_ID2	[	92	]	=	1677		ZHUZAO_ID3	[	92	]	=	2640		ZHUZAO__Rad	[	92	]	=	1
	ZHUZAO_ID	[	93	]	=	1389		ZHUZAO_LV	[	93	]	=	20		ZHUZAO_ID1	[	93	]	=	4030		ZHUZAO_ID2	[	93	]	=	3990		ZHUZAO_ID3	[	93	]	=	2640		ZHUZAO__Rad	[	93	]	=	1
	ZHUZAO_ID	[	94	]	=	26		ZHUZAO_LV	[	94	]	=	20		ZHUZAO_ID1	[	94	]	=	4030		ZHUZAO_ID2	[	94	]	=	1677		ZHUZAO_ID3	[	94	]	=	2640		ZHUZAO__Rad	[	94	]	=	1
	ZHUZAO_ID	[	95	]	=	1401		ZHUZAO_LV	[	95	]	=	20		ZHUZAO_ID1	[	95	]	=	4030		ZHUZAO_ID2	[	95	]	=	3990		ZHUZAO_ID3	[	95	]	=	2640		ZHUZAO__Rad	[	95	]	=	1
	ZHUZAO_ID	[	96	]	=	74		ZHUZAO_LV	[	96	]	=	20		ZHUZAO_ID1	[	96	]	=	4030		ZHUZAO_ID2	[	96	]	=	1677		ZHUZAO_ID3	[	96	]	=	2640		ZHUZAO__Rad	[	96	]	=	1
	ZHUZAO_ID	[	97	]	=	1416		ZHUZAO_LV	[	97	]	=	20		ZHUZAO_ID1	[	97	]	=	4030		ZHUZAO_ID2	[	97	]	=	3990		ZHUZAO_ID3	[	97	]	=	2640		ZHUZAO__Rad	[	97	]	=	1
	ZHUZAO_ID	[	98	]	=	1444		ZHUZAO_LV	[	98	]	=	20		ZHUZAO_ID1	[	98	]	=	4030		ZHUZAO_ID2	[	98	]	=	1677		ZHUZAO_ID3	[	98	]	=	2640		ZHUZAO__Rad	[	98	]	=	1
	ZHUZAO_ID	[	99	]	=	6534		ZHUZAO_LV	[	99	]	=	20		ZHUZAO_ID1	[	99	]	=	4030		ZHUZAO_ID2	[	99	]	=	3990		ZHUZAO_ID3	[	99	]	=	2640		ZHUZAO__Rad	[	99	]	=	1
	ZHUZAO_ID	[	100	]	=	1428		ZHUZAO_LV	[	100	]	=	20		ZHUZAO_ID1	[	100	]	=	4030		ZHUZAO_ID2	[	100	]	=	1677		ZHUZAO_ID3	[	100	]	=	2640		ZHUZAO__Rad	[	100	]	=	1
	ZHUZAO_ID	[	101	]	=	1463		ZHUZAO_LV	[	101	]	=	20		ZHUZAO_ID1	[	101	]	=	4030		ZHUZAO_ID2	[	101	]	=	3990		ZHUZAO_ID3	[	101	]	=	2640		ZHUZAO__Rad	[	101	]	=	1
	ZHUZAO_ID	[	102	]	=	122		ZHUZAO_LV	[	102	]	=	20		ZHUZAO_ID1	[	102	]	=	4030		ZHUZAO_ID2	[	102	]	=	1677		ZHUZAO_ID3	[	102	]	=	2640		ZHUZAO__Rad	[	102	]	=	1
	ZHUZAO_ID	[	103	]	=	2208		ZHUZAO_LV	[	103	]	=	20		ZHUZAO_ID1	[	103	]	=	4030		ZHUZAO_ID2	[	103	]	=	3990		ZHUZAO_ID3	[	103	]	=	2640		ZHUZAO__Rad	[	103	]	=	1
	ZHUZAO_ID	[	104	]	=	2203		ZHUZAO_LV	[	104	]	=	20		ZHUZAO_ID1	[	104	]	=	4030		ZHUZAO_ID2	[	104	]	=	1677		ZHUZAO_ID3	[	104	]	=	2640		ZHUZAO__Rad	[	104	]	=	1
	ZHUZAO_ID	[	105	]	=	386		ZHUZAO_LV	[	105	]	=	20		ZHUZAO_ID1	[	105	]	=	4030		ZHUZAO_ID2	[	105	]	=	3990		ZHUZAO_ID3	[	105	]	=	2640		ZHUZAO__Rad	[	105	]	=	1
	ZHUZAO_ID	[	106	]	=	338		ZHUZAO_LV	[	106	]	=	20		ZHUZAO_ID1	[	106	]	=	4030		ZHUZAO_ID2	[	106	]	=	1677		ZHUZAO_ID3	[	106	]	=	2640		ZHUZAO__Rad	[	106	]	=	1
	ZHUZAO_ID	[	107	]	=	306		ZHUZAO_LV	[	107	]	=	20		ZHUZAO_ID1	[	107	]	=	4030		ZHUZAO_ID2	[	107	]	=	3990		ZHUZAO_ID3	[	107	]	=	2640		ZHUZAO__Rad	[	107	]	=	1
	ZHUZAO_ID	[	108	]	=	291		ZHUZAO_LV	[	108	]	=	20		ZHUZAO_ID1	[	108	]	=	4030		ZHUZAO_ID2	[	108	]	=	1677		ZHUZAO_ID3	[	108	]	=	2640		ZHUZAO__Rad	[	108	]	=	1
	ZHUZAO_ID	[	109	]	=	381		ZHUZAO_LV	[	109	]	=	20		ZHUZAO_ID1	[	109	]	=	4030		ZHUZAO_ID2	[	109	]	=	3990		ZHUZAO_ID3	[	109	]	=	2640		ZHUZAO__Rad	[	109	]	=	1
	ZHUZAO_ID	[	110	]	=	366		ZHUZAO_LV	[	110	]	=	20		ZHUZAO_ID1	[	110	]	=	4030		ZHUZAO_ID2	[	110	]	=	1677		ZHUZAO_ID3	[	110	]	=	2640		ZHUZAO__Rad	[	110	]	=	1
	ZHUZAO_ID	[	111	]	=	562		ZHUZAO_LV	[	111	]	=	20		ZHUZAO_ID1	[	111	]	=	4030		ZHUZAO_ID2	[	111	]	=	3990		ZHUZAO_ID3	[	111	]	=	2640		ZHUZAO__Rad	[	111	]	=	1
	ZHUZAO_ID	[	112	]	=	514		ZHUZAO_LV	[	112	]	=	20		ZHUZAO_ID1	[	112	]	=	4030		ZHUZAO_ID2	[	112	]	=	1677		ZHUZAO_ID3	[	112	]	=	2640		ZHUZAO__Rad	[	112	]	=	1
	ZHUZAO_ID	[	113	]	=	482		ZHUZAO_LV	[	113	]	=	20		ZHUZAO_ID1	[	113	]	=	4030		ZHUZAO_ID2	[	113	]	=	3990		ZHUZAO_ID3	[	113	]	=	2640		ZHUZAO__Rad	[	113	]	=	1
	ZHUZAO_ID	[	114	]	=	467		ZHUZAO_LV	[	114	]	=	20		ZHUZAO_ID1	[	114	]	=	4030		ZHUZAO_ID2	[	114	]	=	1677		ZHUZAO_ID3	[	114	]	=	2640		ZHUZAO__Rad	[	114	]	=	1
	ZHUZAO_ID	[	115	]	=	557		ZHUZAO_LV	[	115	]	=	20		ZHUZAO_ID1	[	115	]	=	4030		ZHUZAO_ID2	[	115	]	=	3990		ZHUZAO_ID3	[	115	]	=	2640		ZHUZAO__Rad	[	115	]	=	1
	ZHUZAO_ID	[	116	]	=	542		ZHUZAO_LV	[	116	]	=	20		ZHUZAO_ID1	[	116	]	=	4030		ZHUZAO_ID2	[	116	]	=	1677		ZHUZAO_ID3	[	116	]	=	2640		ZHUZAO__Rad	[	116	]	=	1
	ZHUZAO_ID	[	117	]	=	738		ZHUZAO_LV	[	117	]	=	20		ZHUZAO_ID1	[	117	]	=	4030		ZHUZAO_ID2	[	117	]	=	3990		ZHUZAO_ID3	[	117	]	=	2640		ZHUZAO__Rad	[	117	]	=	1
	ZHUZAO_ID	[	118	]	=	690		ZHUZAO_LV	[	118	]	=	20		ZHUZAO_ID1	[	118	]	=	4030		ZHUZAO_ID2	[	118	]	=	1677		ZHUZAO_ID3	[	118	]	=	2640		ZHUZAO__Rad	[	118	]	=	1
	ZHUZAO_ID	[	119	]	=	658		ZHUZAO_LV	[	119	]	=	20		ZHUZAO_ID1	[	119	]	=	4030		ZHUZAO_ID2	[	119	]	=	3990		ZHUZAO_ID3	[	119	]	=	2640		ZHUZAO__Rad	[	119	]	=	1
	ZHUZAO_ID	[	120	]	=	643		ZHUZAO_LV	[	120	]	=	20		ZHUZAO_ID1	[	120	]	=	4030		ZHUZAO_ID2	[	120	]	=	1677		ZHUZAO_ID3	[	120	]	=	2640		ZHUZAO__Rad	[	120	]	=	1
	ZHUZAO_ID	[	121	]	=	733		ZHUZAO_LV	[	121	]	=	20		ZHUZAO_ID1	[	121	]	=	4030		ZHUZAO_ID2	[	121	]	=	3990		ZHUZAO_ID3	[	121	]	=	2640		ZHUZAO__Rad	[	121	]	=	1
	ZHUZAO_ID	[	122	]	=	718		ZHUZAO_LV	[	122	]	=	20		ZHUZAO_ID1	[	122	]	=	4030		ZHUZAO_ID2	[	122	]	=	1677		ZHUZAO_ID3	[	122	]	=	2640		ZHUZAO__Rad	[	122	]	=	1
	ZHUZAO_ID	[	123	]	=	4676		ZHUZAO_LV	[	123	]	=	25		ZHUZAO_ID1	[	123	]	=	4030		ZHUZAO_ID2	[	123	]	=	3990		ZHUZAO_ID3	[	123	]	=	2640		ZHUZAO__Rad	[	123	]	=	1
	ZHUZAO_ID	[	124	]	=	4677		ZHUZAO_LV	[	124	]	=	25		ZHUZAO_ID1	[	124	]	=	4030		ZHUZAO_ID2	[	124	]	=	1677		ZHUZAO_ID3	[	124	]	=	2640		ZHUZAO__Rad	[	124	]	=	1
	ZHUZAO_ID	[	125	]	=	4678		ZHUZAO_LV	[	125	]	=	25		ZHUZAO_ID1	[	125	]	=	4030		ZHUZAO_ID2	[	125	]	=	3990		ZHUZAO_ID3	[	125	]	=	2640		ZHUZAO__Rad	[	125	]	=	1
	ZHUZAO_ID	[	126	]	=	4679		ZHUZAO_LV	[	126	]	=	25		ZHUZAO_ID1	[	126	]	=	4030		ZHUZAO_ID2	[	126	]	=	1677		ZHUZAO_ID3	[	126	]	=	2640		ZHUZAO__Rad	[	126	]	=	1
	ZHUZAO_ID	[	127	]	=	4621		ZHUZAO_LV	[	127	]	=	25		ZHUZAO_ID1	[	127	]	=	4030		ZHUZAO_ID2	[	127	]	=	3990		ZHUZAO_ID3	[	127	]	=	2640		ZHUZAO__Rad	[	127	]	=	1
	ZHUZAO_ID	[	128	]	=	4622		ZHUZAO_LV	[	128	]	=	25		ZHUZAO_ID1	[	128	]	=	4030		ZHUZAO_ID2	[	128	]	=	1677		ZHUZAO_ID3	[	128	]	=	2640		ZHUZAO__Rad	[	128	]	=	1
	ZHUZAO_ID	[	129	]	=	4623		ZHUZAO_LV	[	129	]	=	25		ZHUZAO_ID1	[	129	]	=	4030		ZHUZAO_ID2	[	129	]	=	3990		ZHUZAO_ID3	[	129	]	=	2640		ZHUZAO__Rad	[	129	]	=	1
	ZHUZAO_ID	[	130	]	=	4624		ZHUZAO_LV	[	130	]	=	25		ZHUZAO_ID1	[	130	]	=	4030		ZHUZAO_ID2	[	130	]	=	1677		ZHUZAO_ID3	[	130	]	=	2640		ZHUZAO__Rad	[	130	]	=	1
	ZHUZAO_ID	[	131	]	=	4625		ZHUZAO_LV	[	131	]	=	25		ZHUZAO_ID1	[	131	]	=	4030		ZHUZAO_ID2	[	131	]	=	3990		ZHUZAO_ID3	[	131	]	=	2640		ZHUZAO__Rad	[	131	]	=	1
	ZHUZAO_ID	[	132	]	=	11		ZHUZAO_LV	[	132	]	=	25		ZHUZAO_ID1	[	132	]	=	4030		ZHUZAO_ID2	[	132	]	=	1677		ZHUZAO_ID3	[	132	]	=	2640		ZHUZAO__Rad	[	132	]	=	1
	ZHUZAO_ID	[	133	]	=	1396		ZHUZAO_LV	[	133	]	=	25		ZHUZAO_ID1	[	133	]	=	4030		ZHUZAO_ID2	[	133	]	=	3990		ZHUZAO_ID3	[	133	]	=	2640		ZHUZAO__Rad	[	133	]	=	1
	ZHUZAO_ID	[	134	]	=	14		ZHUZAO_LV	[	134	]	=	25		ZHUZAO_ID1	[	134	]	=	4030		ZHUZAO_ID2	[	134	]	=	1677		ZHUZAO_ID3	[	134	]	=	2640		ZHUZAO__Rad	[	134	]	=	1
	ZHUZAO_ID	[	135	]	=	1371		ZHUZAO_LV	[	135	]	=	25		ZHUZAO_ID1	[	135	]	=	4030		ZHUZAO_ID2	[	135	]	=	3990		ZHUZAO_ID3	[	135	]	=	2640		ZHUZAO__Rad	[	135	]	=	1
	ZHUZAO_ID	[	136	]	=	1380		ZHUZAO_LV	[	136	]	=	25		ZHUZAO_ID1	[	136	]	=	4030		ZHUZAO_ID2	[	136	]	=	1677		ZHUZAO_ID3	[	136	]	=	2640		ZHUZAO__Rad	[	136	]	=	1
	ZHUZAO_ID	[	137	]	=	33		ZHUZAO_LV	[	137	]	=	25		ZHUZAO_ID1	[	137	]	=	4030		ZHUZAO_ID2	[	137	]	=	3990		ZHUZAO_ID3	[	137	]	=	2640		ZHUZAO__Rad	[	137	]	=	1
	ZHUZAO_ID	[	138	]	=	1404		ZHUZAO_LV	[	138	]	=	25		ZHUZAO_ID1	[	138	]	=	4030		ZHUZAO_ID2	[	138	]	=	1677		ZHUZAO_ID3	[	138	]	=	2640		ZHUZAO__Rad	[	138	]	=	1
	ZHUZAO_ID	[	139	]	=	37		ZHUZAO_LV	[	139	]	=	25		ZHUZAO_ID1	[	139	]	=	4030		ZHUZAO_ID2	[	139	]	=	3990		ZHUZAO_ID3	[	139	]	=	2640		ZHUZAO__Rad	[	139	]	=	1
	ZHUZAO_ID	[	140	]	=	1406		ZHUZAO_LV	[	140	]	=	25		ZHUZAO_ID1	[	140	]	=	4030		ZHUZAO_ID2	[	140	]	=	1677		ZHUZAO_ID3	[	140	]	=	2640		ZHUZAO__Rad	[	140	]	=	1
	ZHUZAO_ID	[	141	]	=	81		ZHUZAO_LV	[	141	]	=	25		ZHUZAO_ID1	[	141	]	=	4030		ZHUZAO_ID2	[	141	]	=	3990		ZHUZAO_ID3	[	141	]	=	2640		ZHUZAO__Rad	[	141	]	=	1
	ZHUZAO_ID	[	142	]	=	1423		ZHUZAO_LV	[	142	]	=	25		ZHUZAO_ID1	[	142	]	=	4030		ZHUZAO_ID2	[	142	]	=	1677		ZHUZAO_ID3	[	142	]	=	2640		ZHUZAO__Rad	[	142	]	=	1
	ZHUZAO_ID	[	143	]	=	1451		ZHUZAO_LV	[	143	]	=	25		ZHUZAO_ID1	[	143	]	=	4030		ZHUZAO_ID2	[	143	]	=	3990		ZHUZAO_ID3	[	143	]	=	2640		ZHUZAO__Rad	[	143	]	=	1
	ZHUZAO_ID	[	144	]	=	105		ZHUZAO_LV	[	144	]	=	25		ZHUZAO_ID1	[	144	]	=	4030		ZHUZAO_ID2	[	144	]	=	1677		ZHUZAO_ID3	[	144	]	=	2640		ZHUZAO__Rad	[	144	]	=	1
	ZHUZAO_ID	[	145	]	=	1435		ZHUZAO_LV	[	145	]	=	25		ZHUZAO_ID1	[	145	]	=	4030		ZHUZAO_ID2	[	145	]	=	3990		ZHUZAO_ID3	[	145	]	=	2640		ZHUZAO__Rad	[	145	]	=	1
	ZHUZAO_ID	[	146	]	=	1470		ZHUZAO_LV	[	146	]	=	25		ZHUZAO_ID1	[	146	]	=	4030		ZHUZAO_ID2	[	146	]	=	1677		ZHUZAO_ID3	[	146	]	=	2640		ZHUZAO__Rad	[	146	]	=	1
	ZHUZAO_ID	[	147	]	=	2189		ZHUZAO_LV	[	147	]	=	25		ZHUZAO_ID1	[	147	]	=	4030		ZHUZAO_ID2	[	147	]	=	3990		ZHUZAO_ID3	[	147	]	=	2640		ZHUZAO__Rad	[	147	]	=	1
	ZHUZAO_ID	[	148	]	=	2197		ZHUZAO_LV	[	148	]	=	25		ZHUZAO_ID1	[	148	]	=	4030		ZHUZAO_ID2	[	148	]	=	1677		ZHUZAO_ID3	[	148	]	=	2640		ZHUZAO__Rad	[	148	]	=	1
	ZHUZAO_ID	[	149	]	=	313		ZHUZAO_LV	[	149	]	=	25		ZHUZAO_ID1	[	149	]	=	4030		ZHUZAO_ID2	[	149	]	=	3990		ZHUZAO_ID3	[	149	]	=	2640		ZHUZAO__Rad	[	149	]	=	1
	ZHUZAO_ID	[	150	]	=	352		ZHUZAO_LV	[	150	]	=	25		ZHUZAO_ID1	[	150	]	=	4030		ZHUZAO_ID2	[	150	]	=	1677		ZHUZAO_ID3	[	150	]	=	2640		ZHUZAO__Rad	[	150	]	=	1
	ZHUZAO_ID	[	151	]	=	337		ZHUZAO_LV	[	151	]	=	25		ZHUZAO_ID1	[	151	]	=	4030		ZHUZAO_ID2	[	151	]	=	3990		ZHUZAO_ID3	[	151	]	=	2640		ZHUZAO__Rad	[	151	]	=	1
	ZHUZAO_ID	[	152	]	=	360		ZHUZAO_LV	[	152	]	=	25		ZHUZAO_ID1	[	152	]	=	4030		ZHUZAO_ID2	[	152	]	=	1677		ZHUZAO_ID3	[	152	]	=	2640		ZHUZAO__Rad	[	152	]	=	1
	ZHUZAO_ID	[	153	]	=	297		ZHUZAO_LV	[	153	]	=	25		ZHUZAO_ID1	[	153	]	=	4030		ZHUZAO_ID2	[	153	]	=	3990		ZHUZAO_ID3	[	153	]	=	2640		ZHUZAO__Rad	[	153	]	=	1
	ZHUZAO_ID	[	154	]	=	373		ZHUZAO_LV	[	154	]	=	25		ZHUZAO_ID1	[	154	]	=	4030		ZHUZAO_ID2	[	154	]	=	1677		ZHUZAO_ID3	[	154	]	=	2640		ZHUZAO__Rad	[	154	]	=	1
	ZHUZAO_ID	[	155	]	=	487		ZHUZAO_LV	[	155	]	=	25		ZHUZAO_ID1	[	155	]	=	4030		ZHUZAO_ID2	[	155	]	=	3990		ZHUZAO_ID3	[	155	]	=	2640		ZHUZAO__Rad	[	155	]	=	1
	ZHUZAO_ID	[	156	]	=	528		ZHUZAO_LV	[	156	]	=	25		ZHUZAO_ID1	[	156	]	=	4030		ZHUZAO_ID2	[	156	]	=	1677		ZHUZAO_ID3	[	156	]	=	2640		ZHUZAO__Rad	[	156	]	=	1
	ZHUZAO_ID	[	157	]	=	513		ZHUZAO_LV	[	157	]	=	25		ZHUZAO_ID1	[	157	]	=	4030		ZHUZAO_ID2	[	157	]	=	3990		ZHUZAO_ID3	[	157	]	=	2640		ZHUZAO__Rad	[	157	]	=	1
	ZHUZAO_ID	[	158	]	=	536		ZHUZAO_LV	[	158	]	=	25		ZHUZAO_ID1	[	158	]	=	4030		ZHUZAO_ID2	[	158	]	=	1677		ZHUZAO_ID3	[	158	]	=	2640		ZHUZAO__Rad	[	158	]	=	1
	ZHUZAO_ID	[	159	]	=	473		ZHUZAO_LV	[	159	]	=	25		ZHUZAO_ID1	[	159	]	=	4030		ZHUZAO_ID2	[	159	]	=	3990		ZHUZAO_ID3	[	159	]	=	2640		ZHUZAO__Rad	[	159	]	=	1
	ZHUZAO_ID	[	160	]	=	549		ZHUZAO_LV	[	160	]	=	25		ZHUZAO_ID1	[	160	]	=	4030		ZHUZAO_ID2	[	160	]	=	1677		ZHUZAO_ID3	[	160	]	=	2640		ZHUZAO__Rad	[	160	]	=	1
	ZHUZAO_ID	[	161	]	=	665		ZHUZAO_LV	[	161	]	=	25		ZHUZAO_ID1	[	161	]	=	4030		ZHUZAO_ID2	[	161	]	=	3990		ZHUZAO_ID3	[	161	]	=	2640		ZHUZAO__Rad	[	161	]	=	1
	ZHUZAO_ID	[	162	]	=	704		ZHUZAO_LV	[	162	]	=	25		ZHUZAO_ID1	[	162	]	=	4030		ZHUZAO_ID2	[	162	]	=	1677		ZHUZAO_ID3	[	162	]	=	2640		ZHUZAO__Rad	[	162	]	=	1
	ZHUZAO_ID	[	163	]	=	689		ZHUZAO_LV	[	163	]	=	25		ZHUZAO_ID1	[	163	]	=	4030		ZHUZAO_ID2	[	163	]	=	3990		ZHUZAO_ID3	[	163	]	=	2640		ZHUZAO__Rad	[	163	]	=	1
	ZHUZAO_ID	[	164	]	=	712		ZHUZAO_LV	[	164	]	=	25		ZHUZAO_ID1	[	164	]	=	4030		ZHUZAO_ID2	[	164	]	=	1677		ZHUZAO_ID3	[	164	]	=	2640		ZHUZAO__Rad	[	164	]	=	1
	ZHUZAO_ID	[	165	]	=	649		ZHUZAO_LV	[	165	]	=	25		ZHUZAO_ID1	[	165	]	=	4030		ZHUZAO_ID2	[	165	]	=	3990		ZHUZAO_ID3	[	165	]	=	2640		ZHUZAO__Rad	[	165	]	=	1
	ZHUZAO_ID	[	166	]	=	725		ZHUZAO_LV	[	166	]	=	25		ZHUZAO_ID1	[	166	]	=	4030		ZHUZAO_ID2	[	166	]	=	1677		ZHUZAO_ID3	[	166	]	=	2640		ZHUZAO__Rad	[	166	]	=	1
	ZHUZAO_ID	[	167	]	=	4681		ZHUZAO_LV	[	167	]	=	30		ZHUZAO_ID1	[	167	]	=	4031		ZHUZAO_ID2	[	167	]	=	1624		ZHUZAO_ID3	[	167	]	=	2641		ZHUZAO__Rad	[	167	]	=	1
	ZHUZAO_ID	[	168	]	=	4682		ZHUZAO_LV	[	168	]	=	30		ZHUZAO_ID1	[	168	]	=	4031		ZHUZAO_ID2	[	168	]	=	3991		ZHUZAO_ID3	[	168	]	=	2641		ZHUZAO__Rad	[	168	]	=	1
	ZHUZAO_ID	[	169	]	=	4683		ZHUZAO_LV	[	169	]	=	30		ZHUZAO_ID1	[	169	]	=	4031		ZHUZAO_ID2	[	169	]	=	1624		ZHUZAO_ID3	[	169	]	=	2641		ZHUZAO__Rad	[	169	]	=	1
	ZHUZAO_ID	[	170	]	=	4684		ZHUZAO_LV	[	170	]	=	30		ZHUZAO_ID1	[	170	]	=	4031		ZHUZAO_ID2	[	170	]	=	3991		ZHUZAO_ID3	[	170	]	=	2641		ZHUZAO__Rad	[	170	]	=	1
	ZHUZAO_ID	[	171	]	=	4685		ZHUZAO_LV	[	171	]	=	30		ZHUZAO_ID1	[	171	]	=	4031		ZHUZAO_ID2	[	171	]	=	1624		ZHUZAO_ID3	[	171	]	=	2641		ZHUZAO__Rad	[	171	]	=	1
	ZHUZAO_ID	[	172	]	=	4626		ZHUZAO_LV	[	172	]	=	30		ZHUZAO_ID1	[	172	]	=	4031		ZHUZAO_ID2	[	172	]	=	3991		ZHUZAO_ID3	[	172	]	=	2641		ZHUZAO__Rad	[	172	]	=	1
	ZHUZAO_ID	[	173	]	=	4627		ZHUZAO_LV	[	173	]	=	30		ZHUZAO_ID1	[	173	]	=	4031		ZHUZAO_ID2	[	173	]	=	1624		ZHUZAO_ID3	[	173	]	=	2641		ZHUZAO__Rad	[	173	]	=	1
	ZHUZAO_ID	[	174	]	=	4628		ZHUZAO_LV	[	174	]	=	30		ZHUZAO_ID1	[	174	]	=	4031		ZHUZAO_ID2	[	174	]	=	3991		ZHUZAO_ID3	[	174	]	=	2641		ZHUZAO__Rad	[	174	]	=	1
	ZHUZAO_ID	[	175	]	=	4629		ZHUZAO_LV	[	175	]	=	30		ZHUZAO_ID1	[	175	]	=	4031		ZHUZAO_ID2	[	175	]	=	1624		ZHUZAO_ID3	[	175	]	=	2641		ZHUZAO__Rad	[	175	]	=	1
	ZHUZAO_ID	[	176	]	=	4630		ZHUZAO_LV	[	176	]	=	30		ZHUZAO_ID1	[	176	]	=	4031		ZHUZAO_ID2	[	176	]	=	3991		ZHUZAO_ID3	[	176	]	=	2641		ZHUZAO__Rad	[	176	]	=	1
	ZHUZAO_ID	[	177	]	=	637		ZHUZAO_LV	[	177	]	=	30		ZHUZAO_ID1	[	177	]	=	4031		ZHUZAO_ID2	[	177	]	=	1624		ZHUZAO_ID3	[	177	]	=	2641		ZHUZAO__Rad	[	177	]	=	1
	ZHUZAO_ID	[	178	]	=	819		ZHUZAO_LV	[	178	]	=	30		ZHUZAO_ID1	[	178	]	=	4031		ZHUZAO_ID2	[	178	]	=	3991		ZHUZAO_ID3	[	178	]	=	2641		ZHUZAO__Rad	[	178	]	=	1
	ZHUZAO_ID	[	179	]	=	869		ZHUZAO_LV	[	179	]	=	30		ZHUZAO_ID1	[	179	]	=	4031		ZHUZAO_ID2	[	179	]	=	1624		ZHUZAO_ID3	[	179	]	=	2641		ZHUZAO__Rad	[	179	]	=	1
	ZHUZAO_ID	[	180	]	=	874		ZHUZAO_LV	[	180	]	=	30		ZHUZAO_ID1	[	180	]	=	4031		ZHUZAO_ID2	[	180	]	=	3991		ZHUZAO_ID3	[	180	]	=	2641		ZHUZAO__Rad	[	180	]	=	1
	ZHUZAO_ID	[	181	]	=	3		ZHUZAO_LV	[	181	]	=	30		ZHUZAO_ID1	[	181	]	=	4031		ZHUZAO_ID2	[	181	]	=	1624		ZHUZAO_ID3	[	181	]	=	2641		ZHUZAO__Rad	[	181	]	=	1
	ZHUZAO_ID	[	182	]	=	1390		ZHUZAO_LV	[	182	]	=	30		ZHUZAO_ID1	[	182	]	=	4031		ZHUZAO_ID2	[	182	]	=	3991		ZHUZAO_ID3	[	182	]	=	2641		ZHUZAO__Rad	[	182	]	=	1
	ZHUZAO_ID	[	183	]	=	3798		ZHUZAO_LV	[	183	]	=	30		ZHUZAO_ID1	[	183	]	=	4031		ZHUZAO_ID2	[	183	]	=	1624		ZHUZAO_ID3	[	183	]	=	2641		ZHUZAO__Rad	[	183	]	=	1
	ZHUZAO_ID	[	184	]	=	27		ZHUZAO_LV	[	184	]	=	30		ZHUZAO_ID1	[	184	]	=	4031		ZHUZAO_ID2	[	184	]	=	3991		ZHUZAO_ID3	[	184	]	=	2641		ZHUZAO__Rad	[	184	]	=	1
	ZHUZAO_ID	[	185	]	=	1402		ZHUZAO_LV	[	185	]	=	30		ZHUZAO_ID1	[	185	]	=	4031		ZHUZAO_ID2	[	185	]	=	1624		ZHUZAO_ID3	[	185	]	=	2641		ZHUZAO__Rad	[	185	]	=	1
	ZHUZAO_ID	[	186	]	=	3805		ZHUZAO_LV	[	186	]	=	30		ZHUZAO_ID1	[	186	]	=	4031		ZHUZAO_ID2	[	186	]	=	3991		ZHUZAO_ID3	[	186	]	=	2641		ZHUZAO__Rad	[	186	]	=	1
	ZHUZAO_ID	[	187	]	=	75		ZHUZAO_LV	[	187	]	=	30		ZHUZAO_ID1	[	187	]	=	4031		ZHUZAO_ID2	[	187	]	=	1624		ZHUZAO_ID3	[	187	]	=	2641		ZHUZAO__Rad	[	187	]	=	1
	ZHUZAO_ID	[	188	]	=	1417		ZHUZAO_LV	[	188	]	=	30		ZHUZAO_ID1	[	188	]	=	4031		ZHUZAO_ID2	[	188	]	=	3991		ZHUZAO_ID3	[	188	]	=	2641		ZHUZAO__Rad	[	188	]	=	1
	ZHUZAO_ID	[	189	]	=	1445		ZHUZAO_LV	[	189	]	=	30		ZHUZAO_ID1	[	189	]	=	4031		ZHUZAO_ID2	[	189	]	=	1624		ZHUZAO_ID3	[	189	]	=	2641		ZHUZAO__Rad	[	189	]	=	1
	ZHUZAO_ID	[	190	]	=	3816		ZHUZAO_LV	[	190	]	=	30		ZHUZAO_ID1	[	190	]	=	4031		ZHUZAO_ID2	[	190	]	=	3991		ZHUZAO_ID3	[	190	]	=	2641		ZHUZAO__Rad	[	190	]	=	1
	ZHUZAO_ID	[	191	]	=	99		ZHUZAO_LV	[	191	]	=	30		ZHUZAO_ID1	[	191	]	=	4031		ZHUZAO_ID2	[	191	]	=	1624		ZHUZAO_ID3	[	191	]	=	2641		ZHUZAO__Rad	[	191	]	=	1
	ZHUZAO_ID	[	192	]	=	1429		ZHUZAO_LV	[	192	]	=	30		ZHUZAO_ID1	[	192	]	=	4031		ZHUZAO_ID2	[	192	]	=	3991		ZHUZAO_ID3	[	192	]	=	2641		ZHUZAO__Rad	[	192	]	=	1
	ZHUZAO_ID	[	193	]	=	1464		ZHUZAO_LV	[	193	]	=	30		ZHUZAO_ID1	[	193	]	=	4031		ZHUZAO_ID2	[	193	]	=	1624		ZHUZAO_ID3	[	193	]	=	2641		ZHUZAO__Rad	[	193	]	=	1
	ZHUZAO_ID	[	194	]	=	3809		ZHUZAO_LV	[	194	]	=	30		ZHUZAO_ID1	[	194	]	=	4031		ZHUZAO_ID2	[	194	]	=	3991		ZHUZAO_ID3	[	194	]	=	2641		ZHUZAO__Rad	[	194	]	=	1
	ZHUZAO_ID	[	195	]	=	123		ZHUZAO_LV	[	195	]	=	30		ZHUZAO_ID1	[	195	]	=	4031		ZHUZAO_ID2	[	195	]	=	1624		ZHUZAO_ID3	[	195	]	=	2641		ZHUZAO__Rad	[	195	]	=	1
	ZHUZAO_ID	[	196	]	=	2187		ZHUZAO_LV	[	196	]	=	30		ZHUZAO_ID1	[	196	]	=	4031		ZHUZAO_ID2	[	196	]	=	3991		ZHUZAO_ID3	[	196	]	=	2641		ZHUZAO__Rad	[	196	]	=	1
	ZHUZAO_ID	[	197	]	=	2211		ZHUZAO_LV	[	197	]	=	30		ZHUZAO_ID1	[	197	]	=	4031		ZHUZAO_ID2	[	197	]	=	1624		ZHUZAO_ID3	[	197	]	=	2641		ZHUZAO__Rad	[	197	]	=	1
	ZHUZAO_ID	[	198	]	=	307		ZHUZAO_LV	[	198	]	=	30		ZHUZAO_ID1	[	198	]	=	4031		ZHUZAO_ID2	[	198	]	=	3991		ZHUZAO_ID3	[	198	]	=	2641		ZHUZAO__Rad	[	198	]	=	1
	ZHUZAO_ID	[	199	]	=	340		ZHUZAO_LV	[	199	]	=	30		ZHUZAO_ID1	[	199	]	=	4031		ZHUZAO_ID2	[	199	]	=	1624		ZHUZAO_ID3	[	199	]	=	2641		ZHUZAO__Rad	[	199	]	=	1
	ZHUZAO_ID	[	200	]	=	1976		ZHUZAO_LV	[	200	]	=	30		ZHUZAO_ID1	[	200	]	=	4031		ZHUZAO_ID2	[	200	]	=	3991		ZHUZAO_ID3	[	200	]	=	2641		ZHUZAO__Rad	[	200	]	=	1
	ZHUZAO_ID	[	201	]	=	1943		ZHUZAO_LV	[	201	]	=	30		ZHUZAO_ID1	[	201	]	=	4031		ZHUZAO_ID2	[	201	]	=	1624		ZHUZAO_ID3	[	201	]	=	2641		ZHUZAO__Rad	[	201	]	=	1
	ZHUZAO_ID	[	202	]	=	350		ZHUZAO_LV	[	202	]	=	30		ZHUZAO_ID1	[	202	]	=	4031		ZHUZAO_ID2	[	202	]	=	3991		ZHUZAO_ID3	[	202	]	=	2641		ZHUZAO__Rad	[	202	]	=	1
	ZHUZAO_ID	[	203	]	=	1928		ZHUZAO_LV	[	203	]	=	30		ZHUZAO_ID1	[	203	]	=	4031		ZHUZAO_ID2	[	203	]	=	1624		ZHUZAO_ID3	[	203	]	=	2641		ZHUZAO__Rad	[	203	]	=	1
	ZHUZAO_ID	[	204	]	=	368		ZHUZAO_LV	[	204	]	=	30		ZHUZAO_ID1	[	204	]	=	4031		ZHUZAO_ID2	[	204	]	=	3991		ZHUZAO_ID3	[	204	]	=	2641		ZHUZAO__Rad	[	204	]	=	1
	ZHUZAO_ID	[	205	]	=	1955		ZHUZAO_LV	[	205	]	=	30		ZHUZAO_ID1	[	205	]	=	4031		ZHUZAO_ID2	[	205	]	=	1624		ZHUZAO_ID3	[	205	]	=	2641		ZHUZAO__Rad	[	205	]	=	1
	ZHUZAO_ID	[	206	]	=	389		ZHUZAO_LV	[	206	]	=	30		ZHUZAO_ID1	[	206	]	=	4031		ZHUZAO_ID2	[	206	]	=	3991		ZHUZAO_ID3	[	206	]	=	2641		ZHUZAO__Rad	[	206	]	=	1
	ZHUZAO_ID	[	207	]	=	293		ZHUZAO_LV	[	207	]	=	30		ZHUZAO_ID1	[	207	]	=	4031		ZHUZAO_ID2	[	207	]	=	1624		ZHUZAO_ID3	[	207	]	=	2641		ZHUZAO__Rad	[	207	]	=	1
	ZHUZAO_ID	[	208	]	=	483		ZHUZAO_LV	[	208	]	=	30		ZHUZAO_ID1	[	208	]	=	4031		ZHUZAO_ID2	[	208	]	=	3991		ZHUZAO_ID3	[	208	]	=	2641		ZHUZAO__Rad	[	208	]	=	1
	ZHUZAO_ID	[	209	]	=	516		ZHUZAO_LV	[	209	]	=	30		ZHUZAO_ID1	[	209	]	=	4031		ZHUZAO_ID2	[	209	]	=	1624		ZHUZAO_ID3	[	209	]	=	2641		ZHUZAO__Rad	[	209	]	=	1
	ZHUZAO_ID	[	210	]	=	1980		ZHUZAO_LV	[	210	]	=	30		ZHUZAO_ID1	[	210	]	=	4031		ZHUZAO_ID2	[	210	]	=	3991		ZHUZAO_ID3	[	210	]	=	2641		ZHUZAO__Rad	[	210	]	=	1
	ZHUZAO_ID	[	211	]	=	1947		ZHUZAO_LV	[	211	]	=	30		ZHUZAO_ID1	[	211	]	=	4031		ZHUZAO_ID2	[	211	]	=	1624		ZHUZAO_ID3	[	211	]	=	2641		ZHUZAO__Rad	[	211	]	=	1
	ZHUZAO_ID	[	212	]	=	526		ZHUZAO_LV	[	212	]	=	30		ZHUZAO_ID1	[	212	]	=	4031		ZHUZAO_ID2	[	212	]	=	3991		ZHUZAO_ID3	[	212	]	=	2641		ZHUZAO__Rad	[	212	]	=	1
	ZHUZAO_ID	[	213	]	=	1935		ZHUZAO_LV	[	213	]	=	30		ZHUZAO_ID1	[	213	]	=	4031		ZHUZAO_ID2	[	213	]	=	1624		ZHUZAO_ID3	[	213	]	=	2641		ZHUZAO__Rad	[	213	]	=	1
	ZHUZAO_ID	[	214	]	=	544		ZHUZAO_LV	[	214	]	=	30		ZHUZAO_ID1	[	214	]	=	4031		ZHUZAO_ID2	[	214	]	=	3991		ZHUZAO_ID3	[	214	]	=	2641		ZHUZAO__Rad	[	214	]	=	1
	ZHUZAO_ID	[	215	]	=	1962		ZHUZAO_LV	[	215	]	=	30		ZHUZAO_ID1	[	215	]	=	4031		ZHUZAO_ID2	[	215	]	=	1624		ZHUZAO_ID3	[	215	]	=	2641		ZHUZAO__Rad	[	215	]	=	1
	ZHUZAO_ID	[	216	]	=	565		ZHUZAO_LV	[	216	]	=	30		ZHUZAO_ID1	[	216	]	=	4031		ZHUZAO_ID2	[	216	]	=	3991		ZHUZAO_ID3	[	216	]	=	2641		ZHUZAO__Rad	[	216	]	=	1
	ZHUZAO_ID	[	217	]	=	469		ZHUZAO_LV	[	217	]	=	30		ZHUZAO_ID1	[	217	]	=	4031		ZHUZAO_ID2	[	217	]	=	1624		ZHUZAO_ID3	[	217	]	=	2641		ZHUZAO__Rad	[	217	]	=	1
	ZHUZAO_ID	[	218	]	=	659		ZHUZAO_LV	[	218	]	=	30		ZHUZAO_ID1	[	218	]	=	4031		ZHUZAO_ID2	[	218	]	=	3991		ZHUZAO_ID3	[	218	]	=	2641		ZHUZAO__Rad	[	218	]	=	1
	ZHUZAO_ID	[	219	]	=	692		ZHUZAO_LV	[	219	]	=	30		ZHUZAO_ID1	[	219	]	=	4031		ZHUZAO_ID2	[	219	]	=	1624		ZHUZAO_ID3	[	219	]	=	2641		ZHUZAO__Rad	[	219	]	=	1
	ZHUZAO_ID	[	220	]	=	1984		ZHUZAO_LV	[	220	]	=	30		ZHUZAO_ID1	[	220	]	=	4031		ZHUZAO_ID2	[	220	]	=	3991		ZHUZAO_ID3	[	220	]	=	2641		ZHUZAO__Rad	[	220	]	=	1
	ZHUZAO_ID	[	221	]	=	1951		ZHUZAO_LV	[	221	]	=	30		ZHUZAO_ID1	[	221	]	=	4031		ZHUZAO_ID2	[	221	]	=	1624		ZHUZAO_ID3	[	221	]	=	2641		ZHUZAO__Rad	[	221	]	=	1
	ZHUZAO_ID	[	222	]	=	702		ZHUZAO_LV	[	222	]	=	30		ZHUZAO_ID1	[	222	]	=	4031		ZHUZAO_ID2	[	222	]	=	3991		ZHUZAO_ID3	[	222	]	=	2641		ZHUZAO__Rad	[	222	]	=	1
	ZHUZAO_ID	[	223	]	=	1939		ZHUZAO_LV	[	223	]	=	30		ZHUZAO_ID1	[	223	]	=	4031		ZHUZAO_ID2	[	223	]	=	1624		ZHUZAO_ID3	[	223	]	=	2641		ZHUZAO__Rad	[	223	]	=	1
	ZHUZAO_ID	[	224	]	=	720		ZHUZAO_LV	[	224	]	=	30		ZHUZAO_ID1	[	224	]	=	4031		ZHUZAO_ID2	[	224	]	=	3991		ZHUZAO_ID3	[	224	]	=	2641		ZHUZAO__Rad	[	224	]	=	1
	ZHUZAO_ID	[	225	]	=	1969		ZHUZAO_LV	[	225	]	=	30		ZHUZAO_ID1	[	225	]	=	4031		ZHUZAO_ID2	[	225	]	=	1624		ZHUZAO_ID3	[	225	]	=	2641		ZHUZAO__Rad	[	225	]	=	1
	ZHUZAO_ID	[	226	]	=	741		ZHUZAO_LV	[	226	]	=	30		ZHUZAO_ID1	[	226	]	=	4031		ZHUZAO_ID2	[	226	]	=	3991		ZHUZAO_ID3	[	226	]	=	2641		ZHUZAO__Rad	[	226	]	=	1
	ZHUZAO_ID	[	227	]	=	645		ZHUZAO_LV	[	227	]	=	30		ZHUZAO_ID1	[	227	]	=	4031		ZHUZAO_ID2	[	227	]	=	1624		ZHUZAO_ID3	[	227	]	=	2641		ZHUZAO__Rad	[	227	]	=	1
	ZHUZAO_ID	[	228	]	=	4686		ZHUZAO_LV	[	228	]	=	35		ZHUZAO_ID1	[	228	]	=	4031		ZHUZAO_ID2	[	228	]	=	3991		ZHUZAO_ID3	[	228	]	=	2641		ZHUZAO__Rad	[	228	]	=	1
	ZHUZAO_ID	[	229	]	=	4687		ZHUZAO_LV	[	229	]	=	35		ZHUZAO_ID1	[	229	]	=	4031		ZHUZAO_ID2	[	229	]	=	1624		ZHUZAO_ID3	[	229	]	=	2641		ZHUZAO__Rad	[	229	]	=	1
	ZHUZAO_ID	[	230	]	=	4688		ZHUZAO_LV	[	230	]	=	35		ZHUZAO_ID1	[	230	]	=	4031		ZHUZAO_ID2	[	230	]	=	3991		ZHUZAO_ID3	[	230	]	=	2641		ZHUZAO__Rad	[	230	]	=	1
	ZHUZAO_ID	[	231	]	=	4689		ZHUZAO_LV	[	231	]	=	35		ZHUZAO_ID1	[	231	]	=	4031		ZHUZAO_ID2	[	231	]	=	1624		ZHUZAO_ID3	[	231	]	=	2641		ZHUZAO__Rad	[	231	]	=	1
	ZHUZAO_ID	[	232	]	=	4631		ZHUZAO_LV	[	232	]	=	35		ZHUZAO_ID1	[	232	]	=	4031		ZHUZAO_ID2	[	232	]	=	3991		ZHUZAO_ID3	[	232	]	=	2641		ZHUZAO__Rad	[	232	]	=	1
	ZHUZAO_ID	[	233	]	=	4632		ZHUZAO_LV	[	233	]	=	35		ZHUZAO_ID1	[	233	]	=	4031		ZHUZAO_ID2	[	233	]	=	1624		ZHUZAO_ID3	[	233	]	=	2641		ZHUZAO__Rad	[	233	]	=	1
	ZHUZAO_ID	[	234	]	=	4633		ZHUZAO_LV	[	234	]	=	35		ZHUZAO_ID1	[	234	]	=	4031		ZHUZAO_ID2	[	234	]	=	3991		ZHUZAO_ID3	[	234	]	=	2641		ZHUZAO__Rad	[	234	]	=	1
	ZHUZAO_ID	[	235	]	=	4634		ZHUZAO_LV	[	235	]	=	35		ZHUZAO_ID1	[	235	]	=	4031		ZHUZAO_ID2	[	235	]	=	1624		ZHUZAO_ID3	[	235	]	=	2641		ZHUZAO__Rad	[	235	]	=	1
	ZHUZAO_ID	[	236	]	=	4635		ZHUZAO_LV	[	236	]	=	35		ZHUZAO_ID1	[	236	]	=	4031		ZHUZAO_ID2	[	236	]	=	3991		ZHUZAO_ID3	[	236	]	=	2641		ZHUZAO__Rad	[	236	]	=	1
	ZHUZAO_ID	[	237	]	=	12		ZHUZAO_LV	[	237	]	=	35		ZHUZAO_ID1	[	237	]	=	4031		ZHUZAO_ID2	[	237	]	=	1624		ZHUZAO_ID3	[	237	]	=	2641		ZHUZAO__Rad	[	237	]	=	1
	ZHUZAO_ID	[	238	]	=	1397		ZHUZAO_LV	[	238	]	=	35		ZHUZAO_ID1	[	238	]	=	4031		ZHUZAO_ID2	[	238	]	=	3991		ZHUZAO_ID3	[	238	]	=	2641		ZHUZAO__Rad	[	238	]	=	1
	ZHUZAO_ID	[	239	]	=	770		ZHUZAO_LV	[	239	]	=	35		ZHUZAO_ID1	[	239	]	=	4031		ZHUZAO_ID2	[	239	]	=	1624		ZHUZAO_ID3	[	239	]	=	2641		ZHUZAO__Rad	[	239	]	=	1
	ZHUZAO_ID	[	240	]	=	28		ZHUZAO_LV	[	240	]	=	35		ZHUZAO_ID1	[	240	]	=	4031		ZHUZAO_ID2	[	240	]	=	3991		ZHUZAO_ID3	[	240	]	=	2641		ZHUZAO__Rad	[	240	]	=	1
	ZHUZAO_ID	[	241	]	=	34		ZHUZAO_LV	[	241	]	=	35		ZHUZAO_ID1	[	241	]	=	4031		ZHUZAO_ID2	[	241	]	=	1624		ZHUZAO_ID3	[	241	]	=	2641		ZHUZAO__Rad	[	241	]	=	1
	ZHUZAO_ID	[	242	]	=	1405		ZHUZAO_LV	[	242	]	=	35		ZHUZAO_ID1	[	242	]	=	4031		ZHUZAO_ID2	[	242	]	=	3991		ZHUZAO_ID3	[	242	]	=	2641		ZHUZAO__Rad	[	242	]	=	1
	ZHUZAO_ID	[	243	]	=	38		ZHUZAO_LV	[	243	]	=	35		ZHUZAO_ID1	[	243	]	=	4031		ZHUZAO_ID2	[	243	]	=	1624		ZHUZAO_ID3	[	243	]	=	2641		ZHUZAO__Rad	[	243	]	=	1
	ZHUZAO_ID	[	244	]	=	781		ZHUZAO_LV	[	244	]	=	35		ZHUZAO_ID1	[	244	]	=	4031		ZHUZAO_ID2	[	244	]	=	3991		ZHUZAO_ID3	[	244	]	=	2641		ZHUZAO__Rad	[	244	]	=	1
	ZHUZAO_ID	[	245	]	=	1407		ZHUZAO_LV	[	245	]	=	35		ZHUZAO_ID1	[	245	]	=	4031		ZHUZAO_ID2	[	245	]	=	1624		ZHUZAO_ID3	[	245	]	=	2641		ZHUZAO__Rad	[	245	]	=	1
	ZHUZAO_ID	[	246	]	=	82		ZHUZAO_LV	[	246	]	=	35		ZHUZAO_ID1	[	246	]	=	4031		ZHUZAO_ID2	[	246	]	=	3991		ZHUZAO_ID3	[	246	]	=	2641		ZHUZAO__Rad	[	246	]	=	1
	ZHUZAO_ID	[	247	]	=	799		ZHUZAO_LV	[	247	]	=	35		ZHUZAO_ID1	[	247	]	=	4031		ZHUZAO_ID2	[	247	]	=	1624		ZHUZAO_ID3	[	247	]	=	2641		ZHUZAO__Rad	[	247	]	=	1
	ZHUZAO_ID	[	248	]	=	1424		ZHUZAO_LV	[	248	]	=	35		ZHUZAO_ID1	[	248	]	=	4031		ZHUZAO_ID2	[	248	]	=	3991		ZHUZAO_ID3	[	248	]	=	2641		ZHUZAO__Rad	[	248	]	=	1
	ZHUZAO_ID	[	249	]	=	1452		ZHUZAO_LV	[	249	]	=	35		ZHUZAO_ID1	[	249	]	=	4031		ZHUZAO_ID2	[	249	]	=	1624		ZHUZAO_ID3	[	249	]	=	2641		ZHUZAO__Rad	[	249	]	=	1
	ZHUZAO_ID	[	250	]	=	106		ZHUZAO_LV	[	250	]	=	35		ZHUZAO_ID1	[	250	]	=	4031		ZHUZAO_ID2	[	250	]	=	3991		ZHUZAO_ID3	[	250	]	=	2641		ZHUZAO__Rad	[	250	]	=	1
	ZHUZAO_ID	[	251	]	=	785		ZHUZAO_LV	[	251	]	=	35		ZHUZAO_ID1	[	251	]	=	4031		ZHUZAO_ID2	[	251	]	=	1624		ZHUZAO_ID3	[	251	]	=	2641		ZHUZAO__Rad	[	251	]	=	1
	ZHUZAO_ID	[	252	]	=	1436		ZHUZAO_LV	[	252	]	=	35		ZHUZAO_ID1	[	252	]	=	4031		ZHUZAO_ID2	[	252	]	=	3991		ZHUZAO_ID3	[	252	]	=	2641		ZHUZAO__Rad	[	252	]	=	1
	ZHUZAO_ID	[	253	]	=	1471		ZHUZAO_LV	[	253	]	=	35		ZHUZAO_ID1	[	253	]	=	4031		ZHUZAO_ID2	[	253	]	=	1624		ZHUZAO_ID3	[	253	]	=	2641		ZHUZAO__Rad	[	253	]	=	1
	ZHUZAO_ID	[	254	]	=	124		ZHUZAO_LV	[	254	]	=	35		ZHUZAO_ID1	[	254	]	=	4031		ZHUZAO_ID2	[	254	]	=	3991		ZHUZAO_ID3	[	254	]	=	2641		ZHUZAO__Rad	[	254	]	=	1
	ZHUZAO_ID	[	255	]	=	2191		ZHUZAO_LV	[	255	]	=	35		ZHUZAO_ID1	[	255	]	=	4031		ZHUZAO_ID2	[	255	]	=	1624		ZHUZAO_ID3	[	255	]	=	2641		ZHUZAO__Rad	[	255	]	=	1
	ZHUZAO_ID	[	256	]	=	2198		ZHUZAO_LV	[	256	]	=	35		ZHUZAO_ID1	[	256	]	=	4031		ZHUZAO_ID2	[	256	]	=	3991		ZHUZAO_ID3	[	256	]	=	2641		ZHUZAO__Rad	[	256	]	=	1
	ZHUZAO_ID	[	257	]	=	339		ZHUZAO_LV	[	257	]	=	35		ZHUZAO_ID1	[	257	]	=	4031		ZHUZAO_ID2	[	257	]	=	1624		ZHUZAO_ID3	[	257	]	=	2641		ZHUZAO__Rad	[	257	]	=	1
	ZHUZAO_ID	[	258	]	=	803		ZHUZAO_LV	[	258	]	=	35		ZHUZAO_ID1	[	258	]	=	4031		ZHUZAO_ID2	[	258	]	=	3991		ZHUZAO_ID3	[	258	]	=	2641		ZHUZAO__Rad	[	258	]	=	1
	ZHUZAO_ID	[	259	]	=	354		ZHUZAO_LV	[	259	]	=	35		ZHUZAO_ID1	[	259	]	=	4031		ZHUZAO_ID2	[	259	]	=	1624		ZHUZAO_ID3	[	259	]	=	2641		ZHUZAO__Rad	[	259	]	=	1
	ZHUZAO_ID	[	260	]	=	314		ZHUZAO_LV	[	260	]	=	35		ZHUZAO_ID1	[	260	]	=	4031		ZHUZAO_ID2	[	260	]	=	3991		ZHUZAO_ID3	[	260	]	=	2641		ZHUZAO__Rad	[	260	]	=	1
	ZHUZAO_ID	[	261	]	=	777		ZHUZAO_LV	[	261	]	=	35		ZHUZAO_ID1	[	261	]	=	4031		ZHUZAO_ID2	[	261	]	=	1624		ZHUZAO_ID3	[	261	]	=	2641		ZHUZAO__Rad	[	261	]	=	1
	ZHUZAO_ID	[	262	]	=	374		ZHUZAO_LV	[	262	]	=	35		ZHUZAO_ID1	[	262	]	=	4031		ZHUZAO_ID2	[	262	]	=	3991		ZHUZAO_ID3	[	262	]	=	2641		ZHUZAO__Rad	[	262	]	=	1
	ZHUZAO_ID	[	263	]	=	789		ZHUZAO_LV	[	263	]	=	35		ZHUZAO_ID1	[	263	]	=	4031		ZHUZAO_ID2	[	263	]	=	1624		ZHUZAO_ID3	[	263	]	=	2641		ZHUZAO__Rad	[	263	]	=	1
	ZHUZAO_ID	[	264	]	=	361		ZHUZAO_LV	[	264	]	=	35		ZHUZAO_ID1	[	264	]	=	4031		ZHUZAO_ID2	[	264	]	=	3991		ZHUZAO_ID3	[	264	]	=	2641		ZHUZAO__Rad	[	264	]	=	1
	ZHUZAO_ID	[	265	]	=	298		ZHUZAO_LV	[	265	]	=	35		ZHUZAO_ID1	[	265	]	=	4031		ZHUZAO_ID2	[	265	]	=	1624		ZHUZAO_ID3	[	265	]	=	2641		ZHUZAO__Rad	[	265	]	=	1
	ZHUZAO_ID	[	266	]	=	763		ZHUZAO_LV	[	266	]	=	35		ZHUZAO_ID1	[	266	]	=	4031		ZHUZAO_ID2	[	266	]	=	3991		ZHUZAO_ID3	[	266	]	=	2641		ZHUZAO__Rad	[	266	]	=	1
	ZHUZAO_ID	[	267	]	=	515		ZHUZAO_LV	[	267	]	=	35		ZHUZAO_ID1	[	267	]	=	4031		ZHUZAO_ID2	[	267	]	=	1624		ZHUZAO_ID3	[	267	]	=	2641		ZHUZAO__Rad	[	267	]	=	1
	ZHUZAO_ID	[	268	]	=	530		ZHUZAO_LV	[	268	]	=	35		ZHUZAO_ID1	[	268	]	=	4031		ZHUZAO_ID2	[	268	]	=	3991		ZHUZAO_ID3	[	268	]	=	2641		ZHUZAO__Rad	[	268	]	=	1
	ZHUZAO_ID	[	269	]	=	490		ZHUZAO_LV	[	269	]	=	35		ZHUZAO_ID1	[	269	]	=	4031		ZHUZAO_ID2	[	269	]	=	1624		ZHUZAO_ID3	[	269	]	=	2641		ZHUZAO__Rad	[	269	]	=	1
	ZHUZAO_ID	[	270	]	=	550		ZHUZAO_LV	[	270	]	=	35		ZHUZAO_ID1	[	270	]	=	4031		ZHUZAO_ID2	[	270	]	=	3991		ZHUZAO_ID3	[	270	]	=	2641		ZHUZAO__Rad	[	270	]	=	1
	ZHUZAO_ID	[	271	]	=	537		ZHUZAO_LV	[	271	]	=	35		ZHUZAO_ID1	[	271	]	=	4031		ZHUZAO_ID2	[	271	]	=	1624		ZHUZAO_ID3	[	271	]	=	2641		ZHUZAO__Rad	[	271	]	=	1
	ZHUZAO_ID	[	272	]	=	474		ZHUZAO_LV	[	272	]	=	35		ZHUZAO_ID1	[	272	]	=	4031		ZHUZAO_ID2	[	272	]	=	3991		ZHUZAO_ID3	[	272	]	=	2641		ZHUZAO__Rad	[	272	]	=	1
	ZHUZAO_ID	[	273	]	=	691		ZHUZAO_LV	[	273	]	=	35		ZHUZAO_ID1	[	273	]	=	4031		ZHUZAO_ID2	[	273	]	=	1624		ZHUZAO_ID3	[	273	]	=	2641		ZHUZAO__Rad	[	273	]	=	1
	ZHUZAO_ID	[	274	]	=	706		ZHUZAO_LV	[	274	]	=	35		ZHUZAO_ID1	[	274	]	=	4031		ZHUZAO_ID2	[	274	]	=	3991		ZHUZAO_ID3	[	274	]	=	2641		ZHUZAO__Rad	[	274	]	=	1
	ZHUZAO_ID	[	275	]	=	666		ZHUZAO_LV	[	275	]	=	35		ZHUZAO_ID1	[	275	]	=	4031		ZHUZAO_ID2	[	275	]	=	1624		ZHUZAO_ID3	[	275	]	=	2641		ZHUZAO__Rad	[	275	]	=	1
	ZHUZAO_ID	[	276	]	=	726		ZHUZAO_LV	[	276	]	=	35		ZHUZAO_ID1	[	276	]	=	4031		ZHUZAO_ID2	[	276	]	=	3991		ZHUZAO_ID3	[	276	]	=	2641		ZHUZAO__Rad	[	276	]	=	1
	ZHUZAO_ID	[	277	]	=	713		ZHUZAO_LV	[	277	]	=	35		ZHUZAO_ID1	[	277	]	=	4031		ZHUZAO_ID2	[	277	]	=	1624		ZHUZAO_ID3	[	277	]	=	2641		ZHUZAO__Rad	[	277	]	=	1
	ZHUZAO_ID	[	278	]	=	650		ZHUZAO_LV	[	278	]	=	35		ZHUZAO_ID1	[	278	]	=	4031		ZHUZAO_ID2	[	278	]	=	3991		ZHUZAO_ID3	[	278	]	=	2641		ZHUZAO__Rad	[	278	]	=	1
	ZHUZAO_ID	[	279	]	=	739		ZHUZAO_LV	[	279	]	=	40		ZHUZAO_ID1	[	279	]	=	4032		ZHUZAO_ID2	[	279	]	=	1715		ZHUZAO_ID3	[	279	]	=	2641		ZHUZAO__Rad	[	279	]	=	1
	ZHUZAO_ID	[	280	]	=	4691		ZHUZAO_LV	[	280	]	=	40		ZHUZAO_ID1	[	280	]	=	4032		ZHUZAO_ID2	[	280	]	=	3992		ZHUZAO_ID3	[	280	]	=	2641		ZHUZAO__Rad	[	280	]	=	1
	ZHUZAO_ID	[	281	]	=	4692		ZHUZAO_LV	[	281	]	=	40		ZHUZAO_ID1	[	281	]	=	4032		ZHUZAO_ID2	[	281	]	=	1715		ZHUZAO_ID3	[	281	]	=	2641		ZHUZAO__Rad	[	281	]	=	1
	ZHUZAO_ID	[	282	]	=	4693		ZHUZAO_LV	[	282	]	=	40		ZHUZAO_ID1	[	282	]	=	4032		ZHUZAO_ID2	[	282	]	=	3992		ZHUZAO_ID3	[	282	]	=	2641		ZHUZAO__Rad	[	282	]	=	1
	ZHUZAO_ID	[	283	]	=	4694		ZHUZAO_LV	[	283	]	=	40		ZHUZAO_ID1	[	283	]	=	4032		ZHUZAO_ID2	[	283	]	=	1715		ZHUZAO_ID3	[	283	]	=	2641		ZHUZAO__Rad	[	283	]	=	1
	ZHUZAO_ID	[	284	]	=	1121		ZHUZAO_LV	[	284	]	=	40		ZHUZAO_ID1	[	284	]	=	4032		ZHUZAO_ID2	[	284	]	=	3992		ZHUZAO_ID3	[	284	]	=	2641		ZHUZAO__Rad	[	284	]	=	1
	ZHUZAO_ID	[	285	]	=	1122		ZHUZAO_LV	[	285	]	=	40		ZHUZAO_ID1	[	285	]	=	4032		ZHUZAO_ID2	[	285	]	=	1715		ZHUZAO_ID3	[	285	]	=	2641		ZHUZAO__Rad	[	285	]	=	1
	ZHUZAO_ID	[	286	]	=	1120		ZHUZAO_LV	[	286	]	=	40		ZHUZAO_ID1	[	286	]	=	4032		ZHUZAO_ID2	[	286	]	=	3992		ZHUZAO_ID3	[	286	]	=	2641		ZHUZAO__Rad	[	286	]	=	1
	ZHUZAO_ID	[	287	]	=	4695		ZHUZAO_LV	[	287	]	=	40		ZHUZAO_ID1	[	287	]	=	4032		ZHUZAO_ID2	[	287	]	=	1715		ZHUZAO_ID3	[	287	]	=	2641		ZHUZAO__Rad	[	287	]	=	1
	ZHUZAO_ID	[	288	]	=	4636		ZHUZAO_LV	[	288	]	=	40		ZHUZAO_ID1	[	288	]	=	4032		ZHUZAO_ID2	[	288	]	=	3992		ZHUZAO_ID3	[	288	]	=	2641		ZHUZAO__Rad	[	288	]	=	1
	ZHUZAO_ID	[	289	]	=	4637		ZHUZAO_LV	[	289	]	=	40		ZHUZAO_ID1	[	289	]	=	4032		ZHUZAO_ID2	[	289	]	=	1715		ZHUZAO_ID3	[	289	]	=	2641		ZHUZAO__Rad	[	289	]	=	1
	ZHUZAO_ID	[	290	]	=	4638		ZHUZAO_LV	[	290	]	=	40		ZHUZAO_ID1	[	290	]	=	4032		ZHUZAO_ID2	[	290	]	=	3992		ZHUZAO_ID3	[	290	]	=	2641		ZHUZAO__Rad	[	290	]	=	1
	ZHUZAO_ID	[	291	]	=	4639		ZHUZAO_LV	[	291	]	=	40		ZHUZAO_ID1	[	291	]	=	4032		ZHUZAO_ID2	[	291	]	=	1715		ZHUZAO_ID3	[	291	]	=	2641		ZHUZAO__Rad	[	291	]	=	1
	ZHUZAO_ID	[	292	]	=	4640		ZHUZAO_LV	[	292	]	=	40		ZHUZAO_ID1	[	292	]	=	4032		ZHUZAO_ID2	[	292	]	=	3992		ZHUZAO_ID3	[	292	]	=	2641		ZHUZAO__Rad	[	292	]	=	1
	ZHUZAO_ID	[	293	]	=	638		ZHUZAO_LV	[	293	]	=	40		ZHUZAO_ID1	[	293	]	=	4032		ZHUZAO_ID2	[	293	]	=	1715		ZHUZAO_ID3	[	293	]	=	2641		ZHUZAO__Rad	[	293	]	=	1
	ZHUZAO_ID	[	294	]	=	820		ZHUZAO_LV	[	294	]	=	40		ZHUZAO_ID1	[	294	]	=	4032		ZHUZAO_ID2	[	294	]	=	3992		ZHUZAO_ID3	[	294	]	=	2641		ZHUZAO__Rad	[	294	]	=	1
	ZHUZAO_ID	[	295	]	=	870		ZHUZAO_LV	[	295	]	=	40		ZHUZAO_ID1	[	295	]	=	4032		ZHUZAO_ID2	[	295	]	=	1715		ZHUZAO_ID3	[	295	]	=	2641		ZHUZAO__Rad	[	295	]	=	1
	ZHUZAO_ID	[	296	]	=	875		ZHUZAO_LV	[	296	]	=	40		ZHUZAO_ID1	[	296	]	=	4032		ZHUZAO_ID2	[	296	]	=	3992		ZHUZAO_ID3	[	296	]	=	2641		ZHUZAO__Rad	[	296	]	=	1
	ZHUZAO_ID	[	297	]	=	885		ZHUZAO_LV	[	297	]	=	40		ZHUZAO_ID1	[	297	]	=	4032		ZHUZAO_ID2	[	297	]	=	1715		ZHUZAO_ID3	[	297	]	=	2641		ZHUZAO__Rad	[	297	]	=	1
	ZHUZAO_ID	[	298	]	=	4		ZHUZAO_LV	[	298	]	=	40		ZHUZAO_ID1	[	298	]	=	4032		ZHUZAO_ID2	[	298	]	=	3992		ZHUZAO_ID3	[	298	]	=	2641		ZHUZAO__Rad	[	298	]	=	1
	ZHUZAO_ID	[	299	]	=	1391		ZHUZAO_LV	[	299	]	=	40		ZHUZAO_ID1	[	299	]	=	4032		ZHUZAO_ID2	[	299	]	=	1715		ZHUZAO_ID3	[	299	]	=	2641		ZHUZAO__Rad	[	299	]	=	1
	ZHUZAO_ID	[	300	]	=	3799		ZHUZAO_LV	[	300	]	=	40		ZHUZAO_ID1	[	300	]	=	4032		ZHUZAO_ID2	[	300	]	=	3992		ZHUZAO_ID3	[	300	]	=	2641		ZHUZAO__Rad	[	300	]	=	1
	ZHUZAO_ID	[	301	]	=	15		ZHUZAO_LV	[	301	]	=	40		ZHUZAO_ID1	[	301	]	=	4032		ZHUZAO_ID2	[	301	]	=	1715		ZHUZAO_ID3	[	301	]	=	2641		ZHUZAO__Rad	[	301	]	=	1
	ZHUZAO_ID	[	302	]	=	1372		ZHUZAO_LV	[	302	]	=	40		ZHUZAO_ID1	[	302	]	=	4032		ZHUZAO_ID2	[	302	]	=	3992		ZHUZAO_ID3	[	302	]	=	2641		ZHUZAO__Rad	[	302	]	=	1
	ZHUZAO_ID	[	303	]	=	1381		ZHUZAO_LV	[	303	]	=	40		ZHUZAO_ID1	[	303	]	=	4032		ZHUZAO_ID2	[	303	]	=	1715		ZHUZAO_ID3	[	303	]	=	2641		ZHUZAO__Rad	[	303	]	=	1
	ZHUZAO_ID	[	304	]	=	3802		ZHUZAO_LV	[	304	]	=	40		ZHUZAO_ID1	[	304	]	=	4032		ZHUZAO_ID2	[	304	]	=	3992		ZHUZAO_ID3	[	304	]	=	2641		ZHUZAO__Rad	[	304	]	=	1
	ZHUZAO_ID	[	305	]	=	39		ZHUZAO_LV	[	305	]	=	40		ZHUZAO_ID1	[	305	]	=	4032		ZHUZAO_ID2	[	305	]	=	1715		ZHUZAO_ID3	[	305	]	=	2641		ZHUZAO__Rad	[	305	]	=	1
	ZHUZAO_ID	[	306	]	=	1408		ZHUZAO_LV	[	306	]	=	40		ZHUZAO_ID1	[	306	]	=	4032		ZHUZAO_ID2	[	306	]	=	3992		ZHUZAO_ID3	[	306	]	=	2641		ZHUZAO__Rad	[	306	]	=	1
	ZHUZAO_ID	[	307	]	=	3806		ZHUZAO_LV	[	307	]	=	40		ZHUZAO_ID1	[	307	]	=	4032		ZHUZAO_ID2	[	307	]	=	1715		ZHUZAO_ID3	[	307	]	=	2641		ZHUZAO__Rad	[	307	]	=	1
	ZHUZAO_ID	[	308	]	=	76		ZHUZAO_LV	[	308	]	=	40		ZHUZAO_ID1	[	308	]	=	4032		ZHUZAO_ID2	[	308	]	=	3992		ZHUZAO_ID3	[	308	]	=	2641		ZHUZAO__Rad	[	308	]	=	1
	ZHUZAO_ID	[	309	]	=	1418		ZHUZAO_LV	[	309	]	=	40		ZHUZAO_ID1	[	309	]	=	4032		ZHUZAO_ID2	[	309	]	=	1715		ZHUZAO_ID3	[	309	]	=	2641		ZHUZAO__Rad	[	309	]	=	1
	ZHUZAO_ID	[	310	]	=	1446		ZHUZAO_LV	[	310	]	=	40		ZHUZAO_ID1	[	310	]	=	4032		ZHUZAO_ID2	[	310	]	=	3992		ZHUZAO_ID3	[	310	]	=	2641		ZHUZAO__Rad	[	310	]	=	1
	ZHUZAO_ID	[	311	]	=	3817		ZHUZAO_LV	[	311	]	=	40		ZHUZAO_ID1	[	311	]	=	4032		ZHUZAO_ID2	[	311	]	=	1715		ZHUZAO_ID3	[	311	]	=	2641		ZHUZAO__Rad	[	311	]	=	1
	ZHUZAO_ID	[	312	]	=	100		ZHUZAO_LV	[	312	]	=	40		ZHUZAO_ID1	[	312	]	=	4032		ZHUZAO_ID2	[	312	]	=	3992		ZHUZAO_ID3	[	312	]	=	2641		ZHUZAO__Rad	[	312	]	=	1
	ZHUZAO_ID	[	313	]	=	101		ZHUZAO_LV	[	313	]	=	40		ZHUZAO_ID1	[	313	]	=	4032		ZHUZAO_ID2	[	313	]	=	1715		ZHUZAO_ID3	[	313	]	=	2641		ZHUZAO__Rad	[	313	]	=	1
	ZHUZAO_ID	[	314	]	=	1430		ZHUZAO_LV	[	314	]	=	40		ZHUZAO_ID1	[	314	]	=	4032		ZHUZAO_ID2	[	314	]	=	3992		ZHUZAO_ID3	[	314	]	=	2641		ZHUZAO__Rad	[	314	]	=	1
	ZHUZAO_ID	[	315	]	=	1431		ZHUZAO_LV	[	315	]	=	40		ZHUZAO_ID1	[	315	]	=	4032		ZHUZAO_ID2	[	315	]	=	1715		ZHUZAO_ID3	[	315	]	=	2641		ZHUZAO__Rad	[	315	]	=	1
	ZHUZAO_ID	[	316	]	=	1465		ZHUZAO_LV	[	316	]	=	40		ZHUZAO_ID1	[	316	]	=	4032		ZHUZAO_ID2	[	316	]	=	3992		ZHUZAO_ID3	[	316	]	=	2641		ZHUZAO__Rad	[	316	]	=	1
	ZHUZAO_ID	[	317	]	=	1466		ZHUZAO_LV	[	317	]	=	40		ZHUZAO_ID1	[	317	]	=	4032		ZHUZAO_ID2	[	317	]	=	1715		ZHUZAO_ID3	[	317	]	=	2641		ZHUZAO__Rad	[	317	]	=	1
	ZHUZAO_ID	[	318	]	=	3810		ZHUZAO_LV	[	318	]	=	40		ZHUZAO_ID1	[	318	]	=	4032		ZHUZAO_ID2	[	318	]	=	3992		ZHUZAO_ID3	[	318	]	=	2641		ZHUZAO__Rad	[	318	]	=	1
	ZHUZAO_ID	[	319	]	=	3813		ZHUZAO_LV	[	319	]	=	40		ZHUZAO_ID1	[	319	]	=	4032		ZHUZAO_ID2	[	319	]	=	1715		ZHUZAO_ID3	[	319	]	=	2641		ZHUZAO__Rad	[	319	]	=	1
	ZHUZAO_ID	[	320	]	=	2214		ZHUZAO_LV	[	320	]	=	40		ZHUZAO_ID1	[	320	]	=	4032		ZHUZAO_ID2	[	320	]	=	3992		ZHUZAO_ID3	[	320	]	=	2641		ZHUZAO__Rad	[	320	]	=	1
	ZHUZAO_ID	[	321	]	=	2212		ZHUZAO_LV	[	321	]	=	40		ZHUZAO_ID1	[	321	]	=	4032		ZHUZAO_ID2	[	321	]	=	1715		ZHUZAO_ID3	[	321	]	=	2641		ZHUZAO__Rad	[	321	]	=	1
	ZHUZAO_ID	[	322	]	=	2190		ZHUZAO_LV	[	322	]	=	40		ZHUZAO_ID1	[	322	]	=	4032		ZHUZAO_ID2	[	322	]	=	3992		ZHUZAO_ID3	[	322	]	=	2641		ZHUZAO__Rad	[	322	]	=	1
	ZHUZAO_ID	[	323	]	=	1977		ZHUZAO_LV	[	323	]	=	40		ZHUZAO_ID1	[	323	]	=	4032		ZHUZAO_ID2	[	323	]	=	1715		ZHUZAO_ID3	[	323	]	=	2641		ZHUZAO__Rad	[	323	]	=	1
	ZHUZAO_ID	[	324	]	=	310		ZHUZAO_LV	[	324	]	=	40		ZHUZAO_ID1	[	324	]	=	4032		ZHUZAO_ID2	[	324	]	=	3992		ZHUZAO_ID3	[	324	]	=	2641		ZHUZAO__Rad	[	324	]	=	1
	ZHUZAO_ID	[	325	]	=	300		ZHUZAO_LV	[	325	]	=	40		ZHUZAO_ID1	[	325	]	=	4032		ZHUZAO_ID2	[	325	]	=	1715		ZHUZAO_ID3	[	325	]	=	2641		ZHUZAO__Rad	[	325	]	=	1
	ZHUZAO_ID	[	326	]	=	1929		ZHUZAO_LV	[	326	]	=	40		ZHUZAO_ID1	[	326	]	=	4032		ZHUZAO_ID2	[	326	]	=	3992		ZHUZAO_ID3	[	326	]	=	2641		ZHUZAO__Rad	[	326	]	=	1
	ZHUZAO_ID	[	327	]	=	1944		ZHUZAO_LV	[	327	]	=	40		ZHUZAO_ID1	[	327	]	=	4032		ZHUZAO_ID2	[	327	]	=	1715		ZHUZAO_ID3	[	327	]	=	2641		ZHUZAO__Rad	[	327	]	=	1
	ZHUZAO_ID	[	328	]	=	392		ZHUZAO_LV	[	328	]	=	40		ZHUZAO_ID1	[	328	]	=	4032		ZHUZAO_ID2	[	328	]	=	3992		ZHUZAO_ID3	[	328	]	=	2641		ZHUZAO__Rad	[	328	]	=	1
	ZHUZAO_ID	[	329	]	=	390		ZHUZAO_LV	[	329	]	=	40		ZHUZAO_ID1	[	329	]	=	4032		ZHUZAO_ID2	[	329	]	=	1715		ZHUZAO_ID3	[	329	]	=	2641		ZHUZAO__Rad	[	329	]	=	1
	ZHUZAO_ID	[	330	]	=	1956		ZHUZAO_LV	[	330	]	=	40		ZHUZAO_ID1	[	330	]	=	4032		ZHUZAO_ID2	[	330	]	=	3992		ZHUZAO_ID3	[	330	]	=	2641		ZHUZAO__Rad	[	330	]	=	1
	ZHUZAO_ID	[	331	]	=	341		ZHUZAO_LV	[	331	]	=	40		ZHUZAO_ID1	[	331	]	=	4032		ZHUZAO_ID2	[	331	]	=	1715		ZHUZAO_ID3	[	331	]	=	2641		ZHUZAO__Rad	[	331	]	=	1
	ZHUZAO_ID	[	332	]	=	367		ZHUZAO_LV	[	332	]	=	40		ZHUZAO_ID1	[	332	]	=	4032		ZHUZAO_ID2	[	332	]	=	3992		ZHUZAO_ID3	[	332	]	=	2641		ZHUZAO__Rad	[	332	]	=	1
	ZHUZAO_ID	[	333	]	=	295		ZHUZAO_LV	[	333	]	=	40		ZHUZAO_ID1	[	333	]	=	4032		ZHUZAO_ID2	[	333	]	=	1715		ZHUZAO_ID3	[	333	]	=	2641		ZHUZAO__Rad	[	333	]	=	1
	ZHUZAO_ID	[	334	]	=	353		ZHUZAO_LV	[	334	]	=	40		ZHUZAO_ID1	[	334	]	=	4032		ZHUZAO_ID2	[	334	]	=	3992		ZHUZAO_ID3	[	334	]	=	2641		ZHUZAO__Rad	[	334	]	=	1
	ZHUZAO_ID	[	335	]	=	370		ZHUZAO_LV	[	335	]	=	40		ZHUZAO_ID1	[	335	]	=	4032		ZHUZAO_ID2	[	335	]	=	1715		ZHUZAO_ID3	[	335	]	=	2641		ZHUZAO__Rad	[	335	]	=	1
	ZHUZAO_ID	[	336	]	=	1959		ZHUZAO_LV	[	336	]	=	40		ZHUZAO_ID1	[	336	]	=	4032		ZHUZAO_ID2	[	336	]	=	3992		ZHUZAO_ID3	[	336	]	=	2641		ZHUZAO__Rad	[	336	]	=	1
	ZHUZAO_ID	[	337	]	=	1981		ZHUZAO_LV	[	337	]	=	40		ZHUZAO_ID1	[	337	]	=	4032		ZHUZAO_ID2	[	337	]	=	1715		ZHUZAO_ID3	[	337	]	=	2641		ZHUZAO__Rad	[	337	]	=	1
	ZHUZAO_ID	[	338	]	=	486		ZHUZAO_LV	[	338	]	=	40		ZHUZAO_ID1	[	338	]	=	4032		ZHUZAO_ID2	[	338	]	=	3992		ZHUZAO_ID3	[	338	]	=	2641		ZHUZAO__Rad	[	338	]	=	1
	ZHUZAO_ID	[	339	]	=	476		ZHUZAO_LV	[	339	]	=	40		ZHUZAO_ID1	[	339	]	=	4032		ZHUZAO_ID2	[	339	]	=	1715		ZHUZAO_ID3	[	339	]	=	2641		ZHUZAO__Rad	[	339	]	=	1
	ZHUZAO_ID	[	340	]	=	568		ZHUZAO_LV	[	340	]	=	40		ZHUZAO_ID1	[	340	]	=	4032		ZHUZAO_ID2	[	340	]	=	3992		ZHUZAO_ID3	[	340	]	=	2641		ZHUZAO__Rad	[	340	]	=	1
	ZHUZAO_ID	[	341	]	=	1936		ZHUZAO_LV	[	341	]	=	40		ZHUZAO_ID1	[	341	]	=	4032		ZHUZAO_ID2	[	341	]	=	1715		ZHUZAO_ID3	[	341	]	=	2641		ZHUZAO__Rad	[	341	]	=	1
	ZHUZAO_ID	[	342	]	=	1948		ZHUZAO_LV	[	342	]	=	40		ZHUZAO_ID1	[	342	]	=	4032		ZHUZAO_ID2	[	342	]	=	3992		ZHUZAO_ID3	[	342	]	=	2641		ZHUZAO__Rad	[	342	]	=	1
	ZHUZAO_ID	[	343	]	=	566		ZHUZAO_LV	[	343	]	=	40		ZHUZAO_ID1	[	343	]	=	4032		ZHUZAO_ID2	[	343	]	=	1715		ZHUZAO_ID3	[	343	]	=	2641		ZHUZAO__Rad	[	343	]	=	1
	ZHUZAO_ID	[	344	]	=	1963		ZHUZAO_LV	[	344	]	=	40		ZHUZAO_ID1	[	344	]	=	4032		ZHUZAO_ID2	[	344	]	=	3992		ZHUZAO_ID3	[	344	]	=	2641		ZHUZAO__Rad	[	344	]	=	1
	ZHUZAO_ID	[	345	]	=	543		ZHUZAO_LV	[	345	]	=	40		ZHUZAO_ID1	[	345	]	=	4032		ZHUZAO_ID2	[	345	]	=	1715		ZHUZAO_ID3	[	345	]	=	2641		ZHUZAO__Rad	[	345	]	=	1
	ZHUZAO_ID	[	346	]	=	517		ZHUZAO_LV	[	346	]	=	40		ZHUZAO_ID1	[	346	]	=	4032		ZHUZAO_ID2	[	346	]	=	3992		ZHUZAO_ID3	[	346	]	=	2641		ZHUZAO__Rad	[	346	]	=	1
	ZHUZAO_ID	[	347	]	=	471		ZHUZAO_LV	[	347	]	=	40		ZHUZAO_ID1	[	347	]	=	4032		ZHUZAO_ID2	[	347	]	=	1715		ZHUZAO_ID3	[	347	]	=	2641		ZHUZAO__Rad	[	347	]	=	1
	ZHUZAO_ID	[	348	]	=	546		ZHUZAO_LV	[	348	]	=	40		ZHUZAO_ID1	[	348	]	=	4032		ZHUZAO_ID2	[	348	]	=	3992		ZHUZAO_ID3	[	348	]	=	2641		ZHUZAO__Rad	[	348	]	=	1
	ZHUZAO_ID	[	349	]	=	529		ZHUZAO_LV	[	349	]	=	40		ZHUZAO_ID1	[	349	]	=	4032		ZHUZAO_ID2	[	349	]	=	1715		ZHUZAO_ID3	[	349	]	=	2641		ZHUZAO__Rad	[	349	]	=	1
	ZHUZAO_ID	[	350	]	=	1966		ZHUZAO_LV	[	350	]	=	40		ZHUZAO_ID1	[	350	]	=	4032		ZHUZAO_ID2	[	350	]	=	3992		ZHUZAO_ID3	[	350	]	=	2641		ZHUZAO__Rad	[	350	]	=	1
	ZHUZAO_ID	[	351	]	=	1985		ZHUZAO_LV	[	351	]	=	40		ZHUZAO_ID1	[	351	]	=	4032		ZHUZAO_ID2	[	351	]	=	1715		ZHUZAO_ID3	[	351	]	=	2641		ZHUZAO__Rad	[	351	]	=	1
	ZHUZAO_ID	[	352	]	=	662		ZHUZAO_LV	[	352	]	=	40		ZHUZAO_ID1	[	352	]	=	4032		ZHUZAO_ID2	[	352	]	=	3992		ZHUZAO_ID3	[	352	]	=	2641		ZHUZAO__Rad	[	352	]	=	1
	ZHUZAO_ID	[	353	]	=	744		ZHUZAO_LV	[	353	]	=	40		ZHUZAO_ID1	[	353	]	=	4032		ZHUZAO_ID2	[	353	]	=	1715		ZHUZAO_ID3	[	353	]	=	2641		ZHUZAO__Rad	[	353	]	=	1
	ZHUZAO_ID	[	354	]	=	1940		ZHUZAO_LV	[	354	]	=	40		ZHUZAO_ID1	[	354	]	=	4032		ZHUZAO_ID2	[	354	]	=	3992		ZHUZAO_ID3	[	354	]	=	2641		ZHUZAO__Rad	[	354	]	=	1
	ZHUZAO_ID	[	355	]	=	1952		ZHUZAO_LV	[	355	]	=	40		ZHUZAO_ID1	[	355	]	=	4032		ZHUZAO_ID2	[	355	]	=	1715		ZHUZAO_ID3	[	355	]	=	2641		ZHUZAO__Rad	[	355	]	=	1
	ZHUZAO_ID	[	356	]	=	742		ZHUZAO_LV	[	356	]	=	40		ZHUZAO_ID1	[	356	]	=	4032		ZHUZAO_ID2	[	356	]	=	3992		ZHUZAO_ID3	[	356	]	=	2641		ZHUZAO__Rad	[	356	]	=	1
	ZHUZAO_ID	[	357	]	=	1970		ZHUZAO_LV	[	357	]	=	40		ZHUZAO_ID1	[	357	]	=	4032		ZHUZAO_ID2	[	357	]	=	1715		ZHUZAO_ID3	[	357	]	=	2641		ZHUZAO__Rad	[	357	]	=	1
	ZHUZAO_ID	[	358	]	=	719		ZHUZAO_LV	[	358	]	=	40		ZHUZAO_ID1	[	358	]	=	4032		ZHUZAO_ID2	[	358	]	=	3992		ZHUZAO_ID3	[	358	]	=	2641		ZHUZAO__Rad	[	358	]	=	1
	ZHUZAO_ID	[	359	]	=	652		ZHUZAO_LV	[	359	]	=	40		ZHUZAO_ID1	[	359	]	=	4032		ZHUZAO_ID2	[	359	]	=	1715		ZHUZAO_ID3	[	359	]	=	2641		ZHUZAO__Rad	[	359	]	=	1
	ZHUZAO_ID	[	360	]	=	693		ZHUZAO_LV	[	360	]	=	40		ZHUZAO_ID1	[	360	]	=	4032		ZHUZAO_ID2	[	360	]	=	3992		ZHUZAO_ID3	[	360	]	=	2641		ZHUZAO__Rad	[	360	]	=	1
	ZHUZAO_ID	[	361	]	=	647		ZHUZAO_LV	[	361	]	=	40		ZHUZAO_ID1	[	361	]	=	4032		ZHUZAO_ID2	[	361	]	=	1715		ZHUZAO_ID3	[	361	]	=	2641		ZHUZAO__Rad	[	361	]	=	1
	ZHUZAO_ID	[	362	]	=	722		ZHUZAO_LV	[	362	]	=	40		ZHUZAO_ID1	[	362	]	=	4032		ZHUZAO_ID2	[	362	]	=	3992		ZHUZAO_ID3	[	362	]	=	2641		ZHUZAO__Rad	[	362	]	=	1
	ZHUZAO_ID	[	363	]	=	705		ZHUZAO_LV	[	363	]	=	40		ZHUZAO_ID1	[	363	]	=	4032		ZHUZAO_ID2	[	363	]	=	1715		ZHUZAO_ID3	[	363	]	=	2641		ZHUZAO__Rad	[	363	]	=	1
	ZHUZAO_ID	[	364	]	=	1973		ZHUZAO_LV	[	364	]	=	40		ZHUZAO_ID1	[	364	]	=	4032		ZHUZAO_ID2	[	364	]	=	3992		ZHUZAO_ID3	[	364	]	=	2641		ZHUZAO__Rad	[	364	]	=	1
	ZHUZAO_ID	[	365	]	=	1932		ZHUZAO_LV	[	365	]	=	40		ZHUZAO_ID1	[	365	]	=	4032		ZHUZAO_ID2	[	365	]	=	1715		ZHUZAO_ID3	[	365	]	=	2641		ZHUZAO__Rad	[	365	]	=	1
	ZHUZAO_ID	[	366	]	=	29		ZHUZAO_LV	[	366	]	=	44		ZHUZAO_ID1	[	366	]	=	4032		ZHUZAO_ID2	[	366	]	=	3992		ZHUZAO_ID3	[	366	]	=	2641		ZHUZAO__Rad	[	366	]	=	1
	ZHUZAO_ID	[	367	]	=	4696		ZHUZAO_LV	[	367	]	=	45		ZHUZAO_ID1	[	367	]	=	4032		ZHUZAO_ID2	[	367	]	=	1715		ZHUZAO_ID3	[	367	]	=	2641		ZHUZAO__Rad	[	367	]	=	1
	ZHUZAO_ID	[	368	]	=	4697		ZHUZAO_LV	[	368	]	=	45		ZHUZAO_ID1	[	368	]	=	4032		ZHUZAO_ID2	[	368	]	=	3992		ZHUZAO_ID3	[	368	]	=	2641		ZHUZAO__Rad	[	368	]	=	1
	ZHUZAO_ID	[	369	]	=	4698		ZHUZAO_LV	[	369	]	=	45		ZHUZAO_ID1	[	369	]	=	4032		ZHUZAO_ID2	[	369	]	=	1715		ZHUZAO_ID3	[	369	]	=	2641		ZHUZAO__Rad	[	369	]	=	1
	ZHUZAO_ID	[	370	]	=	4699		ZHUZAO_LV	[	370	]	=	45		ZHUZAO_ID1	[	370	]	=	4032		ZHUZAO_ID2	[	370	]	=	3992		ZHUZAO_ID3	[	370	]	=	2641		ZHUZAO__Rad	[	370	]	=	1
	ZHUZAO_ID	[	371	]	=	4641		ZHUZAO_LV	[	371	]	=	45		ZHUZAO_ID1	[	371	]	=	4032		ZHUZAO_ID2	[	371	]	=	1715		ZHUZAO_ID3	[	371	]	=	2641		ZHUZAO__Rad	[	371	]	=	1
	ZHUZAO_ID	[	372	]	=	4642		ZHUZAO_LV	[	372	]	=	45		ZHUZAO_ID1	[	372	]	=	4032		ZHUZAO_ID2	[	372	]	=	3992		ZHUZAO_ID3	[	372	]	=	2641		ZHUZAO__Rad	[	372	]	=	1
	ZHUZAO_ID	[	373	]	=	4643		ZHUZAO_LV	[	373	]	=	45		ZHUZAO_ID1	[	373	]	=	4032		ZHUZAO_ID2	[	373	]	=	1715		ZHUZAO_ID3	[	373	]	=	2641		ZHUZAO__Rad	[	373	]	=	1
	ZHUZAO_ID	[	374	]	=	4644		ZHUZAO_LV	[	374	]	=	45		ZHUZAO_ID1	[	374	]	=	4032		ZHUZAO_ID2	[	374	]	=	3992		ZHUZAO_ID3	[	374	]	=	2641		ZHUZAO__Rad	[	374	]	=	1
	ZHUZAO_ID	[	375	]	=	4645		ZHUZAO_LV	[	375	]	=	45		ZHUZAO_ID1	[	375	]	=	4032		ZHUZAO_ID2	[	375	]	=	1715		ZHUZAO_ID3	[	375	]	=	2641		ZHUZAO__Rad	[	375	]	=	1
	ZHUZAO_ID	[	376	]	=	22		ZHUZAO_LV	[	376	]	=	45		ZHUZAO_ID1	[	376	]	=	4032		ZHUZAO_ID2	[	376	]	=	3992		ZHUZAO_ID3	[	376	]	=	2641		ZHUZAO__Rad	[	376	]	=	1
	ZHUZAO_ID	[	377	]	=	774		ZHUZAO_LV	[	377	]	=	45		ZHUZAO_ID1	[	377	]	=	4032		ZHUZAO_ID2	[	377	]	=	1715		ZHUZAO_ID3	[	377	]	=	2641		ZHUZAO__Rad	[	377	]	=	1
	ZHUZAO_ID	[	378	]	=	1398		ZHUZAO_LV	[	378	]	=	45		ZHUZAO_ID1	[	378	]	=	4032		ZHUZAO_ID2	[	378	]	=	3992		ZHUZAO_ID3	[	378	]	=	2641		ZHUZAO__Rad	[	378	]	=	1
	ZHUZAO_ID	[	379	]	=	20		ZHUZAO_LV	[	379	]	=	45		ZHUZAO_ID1	[	379	]	=	4032		ZHUZAO_ID2	[	379	]	=	1715		ZHUZAO_ID3	[	379	]	=	2641		ZHUZAO__Rad	[	379	]	=	1
	ZHUZAO_ID	[	380	]	=	771		ZHUZAO_LV	[	380	]	=	45		ZHUZAO_ID1	[	380	]	=	4032		ZHUZAO_ID2	[	380	]	=	3992		ZHUZAO_ID3	[	380	]	=	2641		ZHUZAO__Rad	[	380	]	=	1
	ZHUZAO_ID	[	381	]	=	1377		ZHUZAO_LV	[	381	]	=	45		ZHUZAO_ID1	[	381	]	=	4032		ZHUZAO_ID2	[	381	]	=	1715		ZHUZAO_ID3	[	381	]	=	2641		ZHUZAO__Rad	[	381	]	=	1
	ZHUZAO_ID	[	382	]	=	1386		ZHUZAO_LV	[	382	]	=	45		ZHUZAO_ID1	[	382	]	=	4032		ZHUZAO_ID2	[	382	]	=	3992		ZHUZAO_ID3	[	382	]	=	2641		ZHUZAO__Rad	[	382	]	=	1
	ZHUZAO_ID	[	383	]	=	44		ZHUZAO_LV	[	383	]	=	45		ZHUZAO_ID1	[	383	]	=	4032		ZHUZAO_ID2	[	383	]	=	1715		ZHUZAO_ID3	[	383	]	=	2641		ZHUZAO__Rad	[	383	]	=	1
	ZHUZAO_ID	[	384	]	=	782		ZHUZAO_LV	[	384	]	=	45		ZHUZAO_ID1	[	384	]	=	4032		ZHUZAO_ID2	[	384	]	=	3992		ZHUZAO_ID3	[	384	]	=	2641		ZHUZAO__Rad	[	384	]	=	1
	ZHUZAO_ID	[	385	]	=	1413		ZHUZAO_LV	[	385	]	=	45		ZHUZAO_ID1	[	385	]	=	4032		ZHUZAO_ID2	[	385	]	=	1715		ZHUZAO_ID3	[	385	]	=	2641		ZHUZAO__Rad	[	385	]	=	1
	ZHUZAO_ID	[	386	]	=	83		ZHUZAO_LV	[	386	]	=	45		ZHUZAO_ID1	[	386	]	=	4032		ZHUZAO_ID2	[	386	]	=	3992		ZHUZAO_ID3	[	386	]	=	2641		ZHUZAO__Rad	[	386	]	=	1
	ZHUZAO_ID	[	387	]	=	800		ZHUZAO_LV	[	387	]	=	45		ZHUZAO_ID1	[	387	]	=	4032		ZHUZAO_ID2	[	387	]	=	1715		ZHUZAO_ID3	[	387	]	=	2641		ZHUZAO__Rad	[	387	]	=	1
	ZHUZAO_ID	[	388	]	=	1425		ZHUZAO_LV	[	388	]	=	45		ZHUZAO_ID1	[	388	]	=	4032		ZHUZAO_ID2	[	388	]	=	3992		ZHUZAO_ID3	[	388	]	=	2641		ZHUZAO__Rad	[	388	]	=	1
	ZHUZAO_ID	[	389	]	=	1460		ZHUZAO_LV	[	389	]	=	45		ZHUZAO_ID1	[	389	]	=	4032		ZHUZAO_ID2	[	389	]	=	1715		ZHUZAO_ID3	[	389	]	=	2641		ZHUZAO__Rad	[	389	]	=	1
	ZHUZAO_ID	[	390	]	=	107		ZHUZAO_LV	[	390	]	=	45		ZHUZAO_ID1	[	390	]	=	4032		ZHUZAO_ID2	[	390	]	=	3992		ZHUZAO_ID3	[	390	]	=	2641		ZHUZAO__Rad	[	390	]	=	1
	ZHUZAO_ID	[	391	]	=	786		ZHUZAO_LV	[	391	]	=	45		ZHUZAO_ID1	[	391	]	=	4032		ZHUZAO_ID2	[	391	]	=	1715		ZHUZAO_ID3	[	391	]	=	2641		ZHUZAO__Rad	[	391	]	=	1
	ZHUZAO_ID	[	392	]	=	793		ZHUZAO_LV	[	392	]	=	45		ZHUZAO_ID1	[	392	]	=	4032		ZHUZAO_ID2	[	392	]	=	3992		ZHUZAO_ID3	[	392	]	=	2641		ZHUZAO__Rad	[	392	]	=	1
	ZHUZAO_ID	[	393	]	=	1437		ZHUZAO_LV	[	393	]	=	45		ZHUZAO_ID1	[	393	]	=	4032		ZHUZAO_ID2	[	393	]	=	1715		ZHUZAO_ID3	[	393	]	=	2641		ZHUZAO__Rad	[	393	]	=	1
	ZHUZAO_ID	[	394	]	=	1440		ZHUZAO_LV	[	394	]	=	45		ZHUZAO_ID1	[	394	]	=	4032		ZHUZAO_ID2	[	394	]	=	3992		ZHUZAO_ID3	[	394	]	=	2641		ZHUZAO__Rad	[	394	]	=	1
	ZHUZAO_ID	[	395	]	=	1472		ZHUZAO_LV	[	395	]	=	45		ZHUZAO_ID1	[	395	]	=	4032		ZHUZAO_ID2	[	395	]	=	1715		ZHUZAO_ID3	[	395	]	=	2641		ZHUZAO__Rad	[	395	]	=	1
	ZHUZAO_ID	[	396	]	=	1475		ZHUZAO_LV	[	396	]	=	45		ZHUZAO_ID1	[	396	]	=	4032		ZHUZAO_ID2	[	396	]	=	3992		ZHUZAO_ID3	[	396	]	=	2641		ZHUZAO__Rad	[	396	]	=	1
	ZHUZAO_ID	[	397	]	=	4301		ZHUZAO_LV	[	397	]	=	45		ZHUZAO_ID1	[	397	]	=	4032		ZHUZAO_ID2	[	397	]	=	1715		ZHUZAO_ID3	[	397	]	=	2641		ZHUZAO__Rad	[	397	]	=	1
	ZHUZAO_ID	[	398	]	=	125		ZHUZAO_LV	[	398	]	=	45		ZHUZAO_ID1	[	398	]	=	4032		ZHUZAO_ID2	[	398	]	=	3992		ZHUZAO_ID3	[	398	]	=	2641		ZHUZAO__Rad	[	398	]	=	1
	ZHUZAO_ID	[	399	]	=	2199		ZHUZAO_LV	[	399	]	=	45		ZHUZAO_ID1	[	399	]	=	4032		ZHUZAO_ID2	[	399	]	=	1715		ZHUZAO_ID3	[	399	]	=	2641		ZHUZAO__Rad	[	399	]	=	1
	ZHUZAO_ID	[	400	]	=	2210		ZHUZAO_LV	[	400	]	=	45		ZHUZAO_ID1	[	400	]	=	4032		ZHUZAO_ID2	[	400	]	=	3992		ZHUZAO_ID3	[	400	]	=	2641		ZHUZAO__Rad	[	400	]	=	1
	ZHUZAO_ID	[	401	]	=	2193		ZHUZAO_LV	[	401	]	=	45		ZHUZAO_ID1	[	401	]	=	4032		ZHUZAO_ID2	[	401	]	=	1715		ZHUZAO_ID3	[	401	]	=	2641		ZHUZAO__Rad	[	401	]	=	1
	ZHUZAO_ID	[	402	]	=	315		ZHUZAO_LV	[	402	]	=	45		ZHUZAO_ID1	[	402	]	=	4032		ZHUZAO_ID2	[	402	]	=	3992		ZHUZAO_ID3	[	402	]	=	2641		ZHUZAO__Rad	[	402	]	=	1
	ZHUZAO_ID	[	403	]	=	790		ZHUZAO_LV	[	403	]	=	45		ZHUZAO_ID1	[	403	]	=	4032		ZHUZAO_ID2	[	403	]	=	1715		ZHUZAO_ID3	[	403	]	=	2641		ZHUZAO__Rad	[	403	]	=	1
	ZHUZAO_ID	[	404	]	=	362		ZHUZAO_LV	[	404	]	=	45		ZHUZAO_ID1	[	404	]	=	4032		ZHUZAO_ID2	[	404	]	=	3992		ZHUZAO_ID3	[	404	]	=	2641		ZHUZAO__Rad	[	404	]	=	1
	ZHUZAO_ID	[	405	]	=	388		ZHUZAO_LV	[	405	]	=	45		ZHUZAO_ID1	[	405	]	=	4032		ZHUZAO_ID2	[	405	]	=	1715		ZHUZAO_ID3	[	405	]	=	2641		ZHUZAO__Rad	[	405	]	=	1
	ZHUZAO_ID	[	406	]	=	778		ZHUZAO_LV	[	406	]	=	45		ZHUZAO_ID1	[	406	]	=	4032		ZHUZAO_ID2	[	406	]	=	3992		ZHUZAO_ID3	[	406	]	=	2641		ZHUZAO__Rad	[	406	]	=	1
	ZHUZAO_ID	[	407	]	=	375		ZHUZAO_LV	[	407	]	=	45		ZHUZAO_ID1	[	407	]	=	4032		ZHUZAO_ID2	[	407	]	=	1715		ZHUZAO_ID3	[	407	]	=	2641		ZHUZAO__Rad	[	407	]	=	1
	ZHUZAO_ID	[	408	]	=	764		ZHUZAO_LV	[	408	]	=	45		ZHUZAO_ID1	[	408	]	=	4032		ZHUZAO_ID2	[	408	]	=	3992		ZHUZAO_ID3	[	408	]	=	2641		ZHUZAO__Rad	[	408	]	=	1
	ZHUZAO_ID	[	409	]	=	301		ZHUZAO_LV	[	409	]	=	45		ZHUZAO_ID1	[	409	]	=	4032		ZHUZAO_ID2	[	409	]	=	1715		ZHUZAO_ID3	[	409	]	=	2641		ZHUZAO__Rad	[	409	]	=	1
	ZHUZAO_ID	[	410	]	=	302		ZHUZAO_LV	[	410	]	=	45		ZHUZAO_ID1	[	410	]	=	4032		ZHUZAO_ID2	[	410	]	=	3992		ZHUZAO_ID3	[	410	]	=	2641		ZHUZAO__Rad	[	410	]	=	1
	ZHUZAO_ID	[	411	]	=	796		ZHUZAO_LV	[	411	]	=	45		ZHUZAO_ID1	[	411	]	=	4032		ZHUZAO_ID2	[	411	]	=	1715		ZHUZAO_ID3	[	411	]	=	2641		ZHUZAO__Rad	[	411	]	=	1
	ZHUZAO_ID	[	412	]	=	378		ZHUZAO_LV	[	412	]	=	45		ZHUZAO_ID1	[	412	]	=	4032		ZHUZAO_ID2	[	412	]	=	3992		ZHUZAO_ID3	[	412	]	=	2641		ZHUZAO__Rad	[	412	]	=	1
	ZHUZAO_ID	[	413	]	=	342		ZHUZAO_LV	[	413	]	=	45		ZHUZAO_ID1	[	413	]	=	4032		ZHUZAO_ID2	[	413	]	=	1715		ZHUZAO_ID3	[	413	]	=	2641		ZHUZAO__Rad	[	413	]	=	1
	ZHUZAO_ID	[	414	]	=	356		ZHUZAO_LV	[	414	]	=	45		ZHUZAO_ID1	[	414	]	=	4032		ZHUZAO_ID2	[	414	]	=	3992		ZHUZAO_ID3	[	414	]	=	2641		ZHUZAO__Rad	[	414	]	=	1
	ZHUZAO_ID	[	415	]	=	804		ZHUZAO_LV	[	415	]	=	45		ZHUZAO_ID1	[	415	]	=	4032		ZHUZAO_ID2	[	415	]	=	1715		ZHUZAO_ID3	[	415	]	=	2641		ZHUZAO__Rad	[	415	]	=	1
	ZHUZAO_ID	[	416	]	=	767		ZHUZAO_LV	[	416	]	=	45		ZHUZAO_ID1	[	416	]	=	4032		ZHUZAO_ID2	[	416	]	=	3992		ZHUZAO_ID3	[	416	]	=	2641		ZHUZAO__Rad	[	416	]	=	1
	ZHUZAO_ID	[	417	]	=	538		ZHUZAO_LV	[	417	]	=	45		ZHUZAO_ID1	[	417	]	=	4032		ZHUZAO_ID2	[	417	]	=	1715		ZHUZAO_ID3	[	417	]	=	2641		ZHUZAO__Rad	[	417	]	=	1
	ZHUZAO_ID	[	418	]	=	491		ZHUZAO_LV	[	418	]	=	45		ZHUZAO_ID1	[	418	]	=	4032		ZHUZAO_ID2	[	418	]	=	3992		ZHUZAO_ID3	[	418	]	=	2641		ZHUZAO__Rad	[	418	]	=	1
	ZHUZAO_ID	[	419	]	=	564		ZHUZAO_LV	[	419	]	=	45		ZHUZAO_ID1	[	419	]	=	4032		ZHUZAO_ID2	[	419	]	=	1715		ZHUZAO_ID3	[	419	]	=	2641		ZHUZAO__Rad	[	419	]	=	1
	ZHUZAO_ID	[	420	]	=	554		ZHUZAO_LV	[	420	]	=	45		ZHUZAO_ID1	[	420	]	=	4032		ZHUZAO_ID2	[	420	]	=	3992		ZHUZAO_ID3	[	420	]	=	2641		ZHUZAO__Rad	[	420	]	=	1
	ZHUZAO_ID	[	421	]	=	518		ZHUZAO_LV	[	421	]	=	45		ZHUZAO_ID1	[	421	]	=	4032		ZHUZAO_ID2	[	421	]	=	1715		ZHUZAO_ID3	[	421	]	=	2641		ZHUZAO__Rad	[	421	]	=	1
	ZHUZAO_ID	[	422	]	=	551		ZHUZAO_LV	[	422	]	=	45		ZHUZAO_ID1	[	422	]	=	4032		ZHUZAO_ID2	[	422	]	=	3992		ZHUZAO_ID3	[	422	]	=	2641		ZHUZAO__Rad	[	422	]	=	1
	ZHUZAO_ID	[	423	]	=	477		ZHUZAO_LV	[	423	]	=	45		ZHUZAO_ID1	[	423	]	=	4032		ZHUZAO_ID2	[	423	]	=	1715		ZHUZAO_ID3	[	423	]	=	2641		ZHUZAO__Rad	[	423	]	=	1
	ZHUZAO_ID	[	424	]	=	478		ZHUZAO_LV	[	424	]	=	45		ZHUZAO_ID1	[	424	]	=	4032		ZHUZAO_ID2	[	424	]	=	3992		ZHUZAO_ID3	[	424	]	=	2641		ZHUZAO__Rad	[	424	]	=	1
	ZHUZAO_ID	[	425	]	=	532		ZHUZAO_LV	[	425	]	=	45		ZHUZAO_ID1	[	425	]	=	4032		ZHUZAO_ID2	[	425	]	=	1715		ZHUZAO_ID3	[	425	]	=	2641		ZHUZAO__Rad	[	425	]	=	1
	ZHUZAO_ID	[	426	]	=	714		ZHUZAO_LV	[	426	]	=	45		ZHUZAO_ID1	[	426	]	=	4032		ZHUZAO_ID2	[	426	]	=	3992		ZHUZAO_ID3	[	426	]	=	2641		ZHUZAO__Rad	[	426	]	=	1
	ZHUZAO_ID	[	427	]	=	667		ZHUZAO_LV	[	427	]	=	45		ZHUZAO_ID1	[	427	]	=	4032		ZHUZAO_ID2	[	427	]	=	1715		ZHUZAO_ID3	[	427	]	=	2641		ZHUZAO__Rad	[	427	]	=	1
	ZHUZAO_ID	[	428	]	=	740		ZHUZAO_LV	[	428	]	=	45		ZHUZAO_ID1	[	428	]	=	4032		ZHUZAO_ID2	[	428	]	=	3992		ZHUZAO_ID3	[	428	]	=	2641		ZHUZAO__Rad	[	428	]	=	1
	ZHUZAO_ID	[	429	]	=	730		ZHUZAO_LV	[	429	]	=	45		ZHUZAO_ID1	[	429	]	=	4032		ZHUZAO_ID2	[	429	]	=	1715		ZHUZAO_ID3	[	429	]	=	2641		ZHUZAO__Rad	[	429	]	=	1
	ZHUZAO_ID	[	430	]	=	727		ZHUZAO_LV	[	430	]	=	45		ZHUZAO_ID1	[	430	]	=	4032		ZHUZAO_ID2	[	430	]	=	3992		ZHUZAO_ID3	[	430	]	=	2641		ZHUZAO__Rad	[	430	]	=	1
	ZHUZAO_ID	[	431	]	=	654		ZHUZAO_LV	[	431	]	=	45		ZHUZAO_ID1	[	431	]	=	4032		ZHUZAO_ID2	[	431	]	=	1715		ZHUZAO_ID3	[	431	]	=	2641		ZHUZAO__Rad	[	431	]	=	1
	ZHUZAO_ID	[	432	]	=	694		ZHUZAO_LV	[	432	]	=	45		ZHUZAO_ID1	[	432	]	=	4032		ZHUZAO_ID2	[	432	]	=	3992		ZHUZAO_ID3	[	432	]	=	2641		ZHUZAO__Rad	[	432	]	=	1
	ZHUZAO_ID	[	433	]	=	708		ZHUZAO_LV	[	433	]	=	45		ZHUZAO_ID1	[	433	]	=	4032		ZHUZAO_ID2	[	433	]	=	1715		ZHUZAO_ID3	[	433	]	=	2641		ZHUZAO__Rad	[	433	]	=	1
	ZHUZAO_ID	[	434	]	=	653		ZHUZAO_LV	[	434	]	=	45		ZHUZAO_ID1	[	434	]	=	4032		ZHUZAO_ID2	[	434	]	=	3992		ZHUZAO_ID3	[	434	]	=	2641		ZHUZAO__Rad	[	434	]	=	1
	ZHUZAO_ID	[	435	]	=	4701		ZHUZAO_LV	[	435	]	=	50		ZHUZAO_ID1	[	435	]	=	4033		ZHUZAO_ID2	[	435	]	=	1683		ZHUZAO_ID3	[	435	]	=	2642		ZHUZAO__Rad	[	435	]	=	1
	ZHUZAO_ID	[	436	]	=	4702		ZHUZAO_LV	[	436	]	=	50		ZHUZAO_ID1	[	436	]	=	4033		ZHUZAO_ID2	[	436	]	=	3993		ZHUZAO_ID3	[	436	]	=	2642		ZHUZAO__Rad	[	436	]	=	1
	ZHUZAO_ID	[	437	]	=	4703		ZHUZAO_LV	[	437	]	=	50		ZHUZAO_ID1	[	437	]	=	4033		ZHUZAO_ID2	[	437	]	=	1683		ZHUZAO_ID3	[	437	]	=	2642		ZHUZAO__Rad	[	437	]	=	1
	ZHUZAO_ID	[	438	]	=	4704		ZHUZAO_LV	[	438	]	=	50		ZHUZAO_ID1	[	438	]	=	4033		ZHUZAO_ID2	[	438	]	=	3993		ZHUZAO_ID3	[	438	]	=	2642		ZHUZAO__Rad	[	438	]	=	1
	ZHUZAO_ID	[	439	]	=	4705		ZHUZAO_LV	[	439	]	=	50		ZHUZAO_ID1	[	439	]	=	4033		ZHUZAO_ID2	[	439	]	=	1683		ZHUZAO_ID3	[	439	]	=	2642		ZHUZAO__Rad	[	439	]	=	1
	ZHUZAO_ID	[	440	]	=	4646		ZHUZAO_LV	[	440	]	=	50		ZHUZAO_ID1	[	440	]	=	4033		ZHUZAO_ID2	[	440	]	=	3993		ZHUZAO_ID3	[	440	]	=	2642		ZHUZAO__Rad	[	440	]	=	1
	ZHUZAO_ID	[	441	]	=	4647		ZHUZAO_LV	[	441	]	=	50		ZHUZAO_ID1	[	441	]	=	4033		ZHUZAO_ID2	[	441	]	=	1683		ZHUZAO_ID3	[	441	]	=	2642		ZHUZAO__Rad	[	441	]	=	1
	ZHUZAO_ID	[	442	]	=	4648		ZHUZAO_LV	[	442	]	=	50		ZHUZAO_ID1	[	442	]	=	4033		ZHUZAO_ID2	[	442	]	=	3993		ZHUZAO_ID3	[	442	]	=	2642		ZHUZAO__Rad	[	442	]	=	1
	ZHUZAO_ID	[	443	]	=	4649		ZHUZAO_LV	[	443	]	=	50		ZHUZAO_ID1	[	443	]	=	4033		ZHUZAO_ID2	[	443	]	=	1683		ZHUZAO_ID3	[	443	]	=	2642		ZHUZAO__Rad	[	443	]	=	1
	ZHUZAO_ID	[	444	]	=	4650		ZHUZAO_LV	[	444	]	=	50		ZHUZAO_ID1	[	444	]	=	4033		ZHUZAO_ID2	[	444	]	=	3993		ZHUZAO_ID3	[	444	]	=	2642		ZHUZAO__Rad	[	444	]	=	1
	ZHUZAO_ID	[	445	]	=	639		ZHUZAO_LV	[	445	]	=	50		ZHUZAO_ID1	[	445	]	=	4033		ZHUZAO_ID2	[	445	]	=	1683		ZHUZAO_ID3	[	445	]	=	2642		ZHUZAO__Rad	[	445	]	=	1
	ZHUZAO_ID	[	446	]	=	821		ZHUZAO_LV	[	446	]	=	50		ZHUZAO_ID1	[	446	]	=	4033		ZHUZAO_ID2	[	446	]	=	3993		ZHUZAO_ID3	[	446	]	=	2642		ZHUZAO__Rad	[	446	]	=	1
	ZHUZAO_ID	[	447	]	=	871		ZHUZAO_LV	[	447	]	=	50		ZHUZAO_ID1	[	447	]	=	4033		ZHUZAO_ID2	[	447	]	=	1683		ZHUZAO_ID3	[	447	]	=	2642		ZHUZAO__Rad	[	447	]	=	1
	ZHUZAO_ID	[	448	]	=	876		ZHUZAO_LV	[	448	]	=	50		ZHUZAO_ID1	[	448	]	=	4033		ZHUZAO_ID2	[	448	]	=	3993		ZHUZAO_ID3	[	448	]	=	2642		ZHUZAO__Rad	[	448	]	=	1
	ZHUZAO_ID	[	449	]	=	881		ZHUZAO_LV	[	449	]	=	50		ZHUZAO_ID1	[	449	]	=	4033		ZHUZAO_ID2	[	449	]	=	1683		ZHUZAO_ID3	[	449	]	=	2642		ZHUZAO__Rad	[	449	]	=	1
	ZHUZAO_ID	[	450	]	=	882		ZHUZAO_LV	[	450	]	=	50		ZHUZAO_ID1	[	450	]	=	4033		ZHUZAO_ID2	[	450	]	=	3993		ZHUZAO_ID3	[	450	]	=	2642		ZHUZAO__Rad	[	450	]	=	1
	ZHUZAO_ID	[	451	]	=	883		ZHUZAO_LV	[	451	]	=	50		ZHUZAO_ID1	[	451	]	=	4033		ZHUZAO_ID2	[	451	]	=	1683		ZHUZAO_ID3	[	451	]	=	2642		ZHUZAO__Rad	[	451	]	=	1
	ZHUZAO_ID	[	452	]	=	884		ZHUZAO_LV	[	452	]	=	50		ZHUZAO_ID1	[	452	]	=	4033		ZHUZAO_ID2	[	452	]	=	3993		ZHUZAO_ID3	[	452	]	=	2642		ZHUZAO__Rad	[	452	]	=	1
	ZHUZAO_ID	[	453	]	=	887		ZHUZAO_LV	[	453	]	=	50		ZHUZAO_ID1	[	453	]	=	4033		ZHUZAO_ID2	[	453	]	=	1683		ZHUZAO_ID3	[	453	]	=	2642		ZHUZAO__Rad	[	453	]	=	1
	ZHUZAO_ID	[	454	]	=	5		ZHUZAO_LV	[	454	]	=	50		ZHUZAO_ID1	[	454	]	=	4033		ZHUZAO_ID2	[	454	]	=	3993		ZHUZAO_ID3	[	454	]	=	2642		ZHUZAO__Rad	[	454	]	=	1
	ZHUZAO_ID	[	455	]	=	1392		ZHUZAO_LV	[	455	]	=	50		ZHUZAO_ID1	[	455	]	=	4033		ZHUZAO_ID2	[	455	]	=	1683		ZHUZAO_ID3	[	455	]	=	2642		ZHUZAO__Rad	[	455	]	=	1
	ZHUZAO_ID	[	456	]	=	3800		ZHUZAO_LV	[	456	]	=	50		ZHUZAO_ID1	[	456	]	=	4033		ZHUZAO_ID2	[	456	]	=	3993		ZHUZAO_ID3	[	456	]	=	2642		ZHUZAO__Rad	[	456	]	=	1
	ZHUZAO_ID	[	457	]	=	16		ZHUZAO_LV	[	457	]	=	50		ZHUZAO_ID1	[	457	]	=	4033		ZHUZAO_ID2	[	457	]	=	1683		ZHUZAO_ID3	[	457	]	=	2642		ZHUZAO__Rad	[	457	]	=	1
	ZHUZAO_ID	[	458	]	=	1373		ZHUZAO_LV	[	458	]	=	50		ZHUZAO_ID1	[	458	]	=	4033		ZHUZAO_ID2	[	458	]	=	3993		ZHUZAO_ID3	[	458	]	=	2642		ZHUZAO__Rad	[	458	]	=	1
	ZHUZAO_ID	[	459	]	=	1382		ZHUZAO_LV	[	459	]	=	50		ZHUZAO_ID1	[	459	]	=	4033		ZHUZAO_ID2	[	459	]	=	1683		ZHUZAO_ID3	[	459	]	=	2642		ZHUZAO__Rad	[	459	]	=	1
	ZHUZAO_ID	[	460	]	=	3803		ZHUZAO_LV	[	460	]	=	50		ZHUZAO_ID1	[	460	]	=	4033		ZHUZAO_ID2	[	460	]	=	3993		ZHUZAO_ID3	[	460	]	=	2642		ZHUZAO__Rad	[	460	]	=	1
	ZHUZAO_ID	[	461	]	=	40		ZHUZAO_LV	[	461	]	=	50		ZHUZAO_ID1	[	461	]	=	4033		ZHUZAO_ID2	[	461	]	=	1683		ZHUZAO_ID3	[	461	]	=	2642		ZHUZAO__Rad	[	461	]	=	1
	ZHUZAO_ID	[	462	]	=	1409		ZHUZAO_LV	[	462	]	=	50		ZHUZAO_ID1	[	462	]	=	4033		ZHUZAO_ID2	[	462	]	=	3993		ZHUZAO_ID3	[	462	]	=	2642		ZHUZAO__Rad	[	462	]	=	1
	ZHUZAO_ID	[	463	]	=	3807		ZHUZAO_LV	[	463	]	=	50		ZHUZAO_ID1	[	463	]	=	4033		ZHUZAO_ID2	[	463	]	=	1683		ZHUZAO_ID3	[	463	]	=	2642		ZHUZAO__Rad	[	463	]	=	1
	ZHUZAO_ID	[	464	]	=	77		ZHUZAO_LV	[	464	]	=	50		ZHUZAO_ID1	[	464	]	=	4033		ZHUZAO_ID2	[	464	]	=	3993		ZHUZAO_ID3	[	464	]	=	2642		ZHUZAO__Rad	[	464	]	=	1
	ZHUZAO_ID	[	465	]	=	1419		ZHUZAO_LV	[	465	]	=	50		ZHUZAO_ID1	[	465	]	=	4033		ZHUZAO_ID2	[	465	]	=	1683		ZHUZAO_ID3	[	465	]	=	2642		ZHUZAO__Rad	[	465	]	=	1
	ZHUZAO_ID	[	466	]	=	1447		ZHUZAO_LV	[	466	]	=	50		ZHUZAO_ID1	[	466	]	=	4033		ZHUZAO_ID2	[	466	]	=	3993		ZHUZAO_ID3	[	466	]	=	2642		ZHUZAO__Rad	[	466	]	=	1
	ZHUZAO_ID	[	467	]	=	3818		ZHUZAO_LV	[	467	]	=	50		ZHUZAO_ID1	[	467	]	=	4033		ZHUZAO_ID2	[	467	]	=	1683		ZHUZAO_ID3	[	467	]	=	2642		ZHUZAO__Rad	[	467	]	=	1
	ZHUZAO_ID	[	468	]	=	102		ZHUZAO_LV	[	468	]	=	50		ZHUZAO_ID1	[	468	]	=	4033		ZHUZAO_ID2	[	468	]	=	3993		ZHUZAO_ID3	[	468	]	=	2642		ZHUZAO__Rad	[	468	]	=	1
	ZHUZAO_ID	[	469	]	=	103		ZHUZAO_LV	[	469	]	=	50		ZHUZAO_ID1	[	469	]	=	4033		ZHUZAO_ID2	[	469	]	=	1683		ZHUZAO_ID3	[	469	]	=	2642		ZHUZAO__Rad	[	469	]	=	1
	ZHUZAO_ID	[	470	]	=	1432		ZHUZAO_LV	[	470	]	=	50		ZHUZAO_ID1	[	470	]	=	4033		ZHUZAO_ID2	[	470	]	=	3993		ZHUZAO_ID3	[	470	]	=	2642		ZHUZAO__Rad	[	470	]	=	1
	ZHUZAO_ID	[	471	]	=	1433		ZHUZAO_LV	[	471	]	=	50		ZHUZAO_ID1	[	471	]	=	4033		ZHUZAO_ID2	[	471	]	=	1683		ZHUZAO_ID3	[	471	]	=	2642		ZHUZAO__Rad	[	471	]	=	1
	ZHUZAO_ID	[	472	]	=	1467		ZHUZAO_LV	[	472	]	=	50		ZHUZAO_ID1	[	472	]	=	4033		ZHUZAO_ID2	[	472	]	=	3993		ZHUZAO_ID3	[	472	]	=	2642		ZHUZAO__Rad	[	472	]	=	1
	ZHUZAO_ID	[	473	]	=	1468		ZHUZAO_LV	[	473	]	=	50		ZHUZAO_ID1	[	473	]	=	4033		ZHUZAO_ID2	[	473	]	=	1683		ZHUZAO_ID3	[	473	]	=	2642		ZHUZAO__Rad	[	473	]	=	1
	ZHUZAO_ID	[	474	]	=	3811		ZHUZAO_LV	[	474	]	=	50		ZHUZAO_ID1	[	474	]	=	4033		ZHUZAO_ID2	[	474	]	=	3993		ZHUZAO_ID3	[	474	]	=	2642		ZHUZAO__Rad	[	474	]	=	1
	ZHUZAO_ID	[	475	]	=	3814		ZHUZAO_LV	[	475	]	=	50		ZHUZAO_ID1	[	475	]	=	4033		ZHUZAO_ID2	[	475	]	=	1683		ZHUZAO_ID3	[	475	]	=	2642		ZHUZAO__Rad	[	475	]	=	1
	ZHUZAO_ID	[	476	]	=	2207		ZHUZAO_LV	[	476	]	=	50		ZHUZAO_ID1	[	476	]	=	4033		ZHUZAO_ID2	[	476	]	=	3993		ZHUZAO_ID3	[	476	]	=	2642		ZHUZAO__Rad	[	476	]	=	1
	ZHUZAO_ID	[	477	]	=	2204		ZHUZAO_LV	[	477	]	=	50		ZHUZAO_ID1	[	477	]	=	4033		ZHUZAO_ID2	[	477	]	=	1683		ZHUZAO_ID3	[	477	]	=	2642		ZHUZAO__Rad	[	477	]	=	1
	ZHUZAO_ID	[	478	]	=	2192		ZHUZAO_LV	[	478	]	=	50		ZHUZAO_ID1	[	478	]	=	4033		ZHUZAO_ID2	[	478	]	=	3993		ZHUZAO_ID3	[	478	]	=	2642		ZHUZAO__Rad	[	478	]	=	1
	ZHUZAO_ID	[	479	]	=	312		ZHUZAO_LV	[	479	]	=	50		ZHUZAO_ID1	[	479	]	=	4033		ZHUZAO_ID2	[	479	]	=	1683		ZHUZAO_ID3	[	479	]	=	2642		ZHUZAO__Rad	[	479	]	=	1
	ZHUZAO_ID	[	480	]	=	1945		ZHUZAO_LV	[	480	]	=	50		ZHUZAO_ID1	[	480	]	=	4033		ZHUZAO_ID2	[	480	]	=	3993		ZHUZAO_ID3	[	480	]	=	2642		ZHUZAO__Rad	[	480	]	=	1
	ZHUZAO_ID	[	481	]	=	385		ZHUZAO_LV	[	481	]	=	50		ZHUZAO_ID1	[	481	]	=	4033		ZHUZAO_ID2	[	481	]	=	1683		ZHUZAO_ID3	[	481	]	=	2642		ZHUZAO__Rad	[	481	]	=	1
	ZHUZAO_ID	[	482	]	=	382		ZHUZAO_LV	[	482	]	=	50		ZHUZAO_ID1	[	482	]	=	4033		ZHUZAO_ID2	[	482	]	=	3993		ZHUZAO_ID3	[	482	]	=	2642		ZHUZAO__Rad	[	482	]	=	1
	ZHUZAO_ID	[	483	]	=	369		ZHUZAO_LV	[	483	]	=	50		ZHUZAO_ID1	[	483	]	=	4033		ZHUZAO_ID2	[	483	]	=	1683		ZHUZAO_ID3	[	483	]	=	2642		ZHUZAO__Rad	[	483	]	=	1
	ZHUZAO_ID	[	484	]	=	1957		ZHUZAO_LV	[	484	]	=	50		ZHUZAO_ID1	[	484	]	=	4033		ZHUZAO_ID2	[	484	]	=	3993		ZHUZAO_ID3	[	484	]	=	2642		ZHUZAO__Rad	[	484	]	=	1
	ZHUZAO_ID	[	485	]	=	345		ZHUZAO_LV	[	485	]	=	50		ZHUZAO_ID1	[	485	]	=	4033		ZHUZAO_ID2	[	485	]	=	1683		ZHUZAO_ID3	[	485	]	=	2642		ZHUZAO__Rad	[	485	]	=	1
	ZHUZAO_ID	[	486	]	=	1978		ZHUZAO_LV	[	486	]	=	50		ZHUZAO_ID1	[	486	]	=	4033		ZHUZAO_ID2	[	486	]	=	3993		ZHUZAO_ID3	[	486	]	=	2642		ZHUZAO__Rad	[	486	]	=	1
	ZHUZAO_ID	[	487	]	=	299		ZHUZAO_LV	[	487	]	=	50		ZHUZAO_ID1	[	487	]	=	4033		ZHUZAO_ID2	[	487	]	=	1683		ZHUZAO_ID3	[	487	]	=	2642		ZHUZAO__Rad	[	487	]	=	1
	ZHUZAO_ID	[	488	]	=	355		ZHUZAO_LV	[	488	]	=	50		ZHUZAO_ID1	[	488	]	=	4033		ZHUZAO_ID2	[	488	]	=	3993		ZHUZAO_ID3	[	488	]	=	2642		ZHUZAO__Rad	[	488	]	=	1
	ZHUZAO_ID	[	489	]	=	1960		ZHUZAO_LV	[	489	]	=	50		ZHUZAO_ID1	[	489	]	=	4033		ZHUZAO_ID2	[	489	]	=	1683		ZHUZAO_ID3	[	489	]	=	2642		ZHUZAO__Rad	[	489	]	=	1
	ZHUZAO_ID	[	490	]	=	1930		ZHUZAO_LV	[	490	]	=	50		ZHUZAO_ID1	[	490	]	=	4033		ZHUZAO_ID2	[	490	]	=	3993		ZHUZAO_ID3	[	490	]	=	2642		ZHUZAO__Rad	[	490	]	=	1
	ZHUZAO_ID	[	491	]	=	371		ZHUZAO_LV	[	491	]	=	50		ZHUZAO_ID1	[	491	]	=	4033		ZHUZAO_ID2	[	491	]	=	1683		ZHUZAO_ID3	[	491	]	=	2642		ZHUZAO__Rad	[	491	]	=	1
	ZHUZAO_ID	[	492	]	=	488		ZHUZAO_LV	[	492	]	=	50		ZHUZAO_ID1	[	492	]	=	4033		ZHUZAO_ID2	[	492	]	=	3993		ZHUZAO_ID3	[	492	]	=	2642		ZHUZAO__Rad	[	492	]	=	1
	ZHUZAO_ID	[	493	]	=	1949		ZHUZAO_LV	[	493	]	=	50		ZHUZAO_ID1	[	493	]	=	4033		ZHUZAO_ID2	[	493	]	=	1683		ZHUZAO_ID3	[	493	]	=	2642		ZHUZAO__Rad	[	493	]	=	1
	ZHUZAO_ID	[	494	]	=	561		ZHUZAO_LV	[	494	]	=	50		ZHUZAO_ID1	[	494	]	=	4033		ZHUZAO_ID2	[	494	]	=	3993		ZHUZAO_ID3	[	494	]	=	2642		ZHUZAO__Rad	[	494	]	=	1
	ZHUZAO_ID	[	495	]	=	545		ZHUZAO_LV	[	495	]	=	50		ZHUZAO_ID1	[	495	]	=	4033		ZHUZAO_ID2	[	495	]	=	1683		ZHUZAO_ID3	[	495	]	=	2642		ZHUZAO__Rad	[	495	]	=	1
	ZHUZAO_ID	[	496	]	=	558		ZHUZAO_LV	[	496	]	=	50		ZHUZAO_ID1	[	496	]	=	4033		ZHUZAO_ID2	[	496	]	=	3993		ZHUZAO_ID3	[	496	]	=	2642		ZHUZAO__Rad	[	496	]	=	1
	ZHUZAO_ID	[	497	]	=	1964		ZHUZAO_LV	[	497	]	=	50		ZHUZAO_ID1	[	497	]	=	4033		ZHUZAO_ID2	[	497	]	=	1683		ZHUZAO_ID3	[	497	]	=	2642		ZHUZAO__Rad	[	497	]	=	1
	ZHUZAO_ID	[	498	]	=	521		ZHUZAO_LV	[	498	]	=	50		ZHUZAO_ID1	[	498	]	=	4033		ZHUZAO_ID2	[	498	]	=	3993		ZHUZAO_ID3	[	498	]	=	2642		ZHUZAO__Rad	[	498	]	=	1
	ZHUZAO_ID	[	499	]	=	1982		ZHUZAO_LV	[	499	]	=	50		ZHUZAO_ID1	[	499	]	=	4033		ZHUZAO_ID2	[	499	]	=	1683		ZHUZAO_ID3	[	499	]	=	2642		ZHUZAO__Rad	[	499	]	=	1
	ZHUZAO_ID	[	500	]	=	475		ZHUZAO_LV	[	500	]	=	50		ZHUZAO_ID1	[	500	]	=	4033		ZHUZAO_ID2	[	500	]	=	3993		ZHUZAO_ID3	[	500	]	=	2642		ZHUZAO__Rad	[	500	]	=	1
	ZHUZAO_ID	[	501	]	=	531		ZHUZAO_LV	[	501	]	=	50		ZHUZAO_ID1	[	501	]	=	4033		ZHUZAO_ID2	[	501	]	=	1683		ZHUZAO_ID3	[	501	]	=	2642		ZHUZAO__Rad	[	501	]	=	1
	ZHUZAO_ID	[	502	]	=	1967		ZHUZAO_LV	[	502	]	=	50		ZHUZAO_ID1	[	502	]	=	4033		ZHUZAO_ID2	[	502	]	=	3993		ZHUZAO_ID3	[	502	]	=	2642		ZHUZAO__Rad	[	502	]	=	1
	ZHUZAO_ID	[	503	]	=	547		ZHUZAO_LV	[	503	]	=	50		ZHUZAO_ID1	[	503	]	=	4033		ZHUZAO_ID2	[	503	]	=	1683		ZHUZAO_ID3	[	503	]	=	2642		ZHUZAO__Rad	[	503	]	=	1
	ZHUZAO_ID	[	504	]	=	1937		ZHUZAO_LV	[	504	]	=	50		ZHUZAO_ID1	[	504	]	=	4033		ZHUZAO_ID2	[	504	]	=	3993		ZHUZAO_ID3	[	504	]	=	2642		ZHUZAO__Rad	[	504	]	=	1
	ZHUZAO_ID	[	505	]	=	664		ZHUZAO_LV	[	505	]	=	50		ZHUZAO_ID1	[	505	]	=	4033		ZHUZAO_ID2	[	505	]	=	1683		ZHUZAO_ID3	[	505	]	=	2642		ZHUZAO__Rad	[	505	]	=	1
	ZHUZAO_ID	[	506	]	=	737		ZHUZAO_LV	[	506	]	=	50		ZHUZAO_ID1	[	506	]	=	4033		ZHUZAO_ID2	[	506	]	=	3993		ZHUZAO_ID3	[	506	]	=	2642		ZHUZAO__Rad	[	506	]	=	1
	ZHUZAO_ID	[	507	]	=	721		ZHUZAO_LV	[	507	]	=	50		ZHUZAO_ID1	[	507	]	=	4033		ZHUZAO_ID2	[	507	]	=	1683		ZHUZAO_ID3	[	507	]	=	2642		ZHUZAO__Rad	[	507	]	=	1
	ZHUZAO_ID	[	508	]	=	1953		ZHUZAO_LV	[	508	]	=	50		ZHUZAO_ID1	[	508	]	=	4033		ZHUZAO_ID2	[	508	]	=	3993		ZHUZAO_ID3	[	508	]	=	2642		ZHUZAO__Rad	[	508	]	=	1
	ZHUZAO_ID	[	509	]	=	734		ZHUZAO_LV	[	509	]	=	50		ZHUZAO_ID1	[	509	]	=	4033		ZHUZAO_ID2	[	509	]	=	1683		ZHUZAO_ID3	[	509	]	=	2642		ZHUZAO__Rad	[	509	]	=	1
	ZHUZAO_ID	[	510	]	=	697		ZHUZAO_LV	[	510	]	=	50		ZHUZAO_ID1	[	510	]	=	4033		ZHUZAO_ID2	[	510	]	=	3993		ZHUZAO_ID3	[	510	]	=	2642		ZHUZAO__Rad	[	510	]	=	1
	ZHUZAO_ID	[	511	]	=	1986		ZHUZAO_LV	[	511	]	=	50		ZHUZAO_ID1	[	511	]	=	4033		ZHUZAO_ID2	[	511	]	=	1683		ZHUZAO_ID3	[	511	]	=	2642		ZHUZAO__Rad	[	511	]	=	1
	ZHUZAO_ID	[	512	]	=	1971		ZHUZAO_LV	[	512	]	=	50		ZHUZAO_ID1	[	512	]	=	4033		ZHUZAO_ID2	[	512	]	=	3993		ZHUZAO_ID3	[	512	]	=	2642		ZHUZAO__Rad	[	512	]	=	1
	ZHUZAO_ID	[	513	]	=	707		ZHUZAO_LV	[	513	]	=	50		ZHUZAO_ID1	[	513	]	=	4033		ZHUZAO_ID2	[	513	]	=	1683		ZHUZAO_ID3	[	513	]	=	2642		ZHUZAO__Rad	[	513	]	=	1
	ZHUZAO_ID	[	514	]	=	1974		ZHUZAO_LV	[	514	]	=	50		ZHUZAO_ID1	[	514	]	=	4033		ZHUZAO_ID2	[	514	]	=	3993		ZHUZAO_ID3	[	514	]	=	2642		ZHUZAO__Rad	[	514	]	=	1
	ZHUZAO_ID	[	515	]	=	651		ZHUZAO_LV	[	515	]	=	50		ZHUZAO_ID1	[	515	]	=	4033		ZHUZAO_ID2	[	515	]	=	1683		ZHUZAO_ID3	[	515	]	=	2642		ZHUZAO__Rad	[	515	]	=	1
	ZHUZAO_ID	[	516	]	=	1941		ZHUZAO_LV	[	516	]	=	50		ZHUZAO_ID1	[	516	]	=	4033		ZHUZAO_ID2	[	516	]	=	3993		ZHUZAO_ID3	[	516	]	=	2642		ZHUZAO__Rad	[	516	]	=	1
	ZHUZAO_ID	[	517	]	=	723		ZHUZAO_LV	[	517	]	=	50		ZHUZAO_ID1	[	517	]	=	4033		ZHUZAO_ID2	[	517	]	=	1683		ZHUZAO_ID3	[	517	]	=	2642		ZHUZAO__Rad	[	517	]	=	1
	ZHUZAO_ID	[	518	]	=	1933		ZHUZAO_LV	[	518	]	=	50		ZHUZAO_ID1	[	518	]	=	4033		ZHUZAO_ID2	[	518	]	=	3993		ZHUZAO_ID3	[	518	]	=	2642		ZHUZAO__Rad	[	518	]	=	1
	ZHUZAO_ID	[	519	]	=	229		ZHUZAO_LV	[	519	]	=	50		ZHUZAO_ID1	[	519	]	=	4033		ZHUZAO_ID2	[	519	]	=	1683		ZHUZAO_ID3	[	519	]	=	2642		ZHUZAO__Rad	[	519	]	=	1
	ZHUZAO_ID	[	520	]	=	30		ZHUZAO_LV	[	520	]	=	55		ZHUZAO_ID1	[	520	]	=	4033		ZHUZAO_ID2	[	520	]	=	3993		ZHUZAO_ID3	[	520	]	=	2642		ZHUZAO__Rad	[	520	]	=	1
	ZHUZAO_ID	[	521	]	=	4706		ZHUZAO_LV	[	521	]	=	55		ZHUZAO_ID1	[	521	]	=	4033		ZHUZAO_ID2	[	521	]	=	1683		ZHUZAO_ID3	[	521	]	=	2642		ZHUZAO__Rad	[	521	]	=	1
	ZHUZAO_ID	[	522	]	=	4707		ZHUZAO_LV	[	522	]	=	55		ZHUZAO_ID1	[	522	]	=	4033		ZHUZAO_ID2	[	522	]	=	3993		ZHUZAO_ID3	[	522	]	=	2642		ZHUZAO__Rad	[	522	]	=	1
	ZHUZAO_ID	[	523	]	=	4708		ZHUZAO_LV	[	523	]	=	55		ZHUZAO_ID1	[	523	]	=	4033		ZHUZAO_ID2	[	523	]	=	1683		ZHUZAO_ID3	[	523	]	=	2642		ZHUZAO__Rad	[	523	]	=	1
	ZHUZAO_ID	[	524	]	=	4709		ZHUZAO_LV	[	524	]	=	55		ZHUZAO_ID1	[	524	]	=	4033		ZHUZAO_ID2	[	524	]	=	3993		ZHUZAO_ID3	[	524	]	=	2642		ZHUZAO__Rad	[	524	]	=	1
	ZHUZAO_ID	[	525	]	=	4651		ZHUZAO_LV	[	525	]	=	55		ZHUZAO_ID1	[	525	]	=	4033		ZHUZAO_ID2	[	525	]	=	1683		ZHUZAO_ID3	[	525	]	=	2642		ZHUZAO__Rad	[	525	]	=	1
	ZHUZAO_ID	[	526	]	=	4652		ZHUZAO_LV	[	526	]	=	55		ZHUZAO_ID1	[	526	]	=	4033		ZHUZAO_ID2	[	526	]	=	3993		ZHUZAO_ID3	[	526	]	=	2642		ZHUZAO__Rad	[	526	]	=	1
	ZHUZAO_ID	[	527	]	=	4653		ZHUZAO_LV	[	527	]	=	55		ZHUZAO_ID1	[	527	]	=	4033		ZHUZAO_ID2	[	527	]	=	1683		ZHUZAO_ID3	[	527	]	=	2642		ZHUZAO__Rad	[	527	]	=	1
	ZHUZAO_ID	[	528	]	=	4654		ZHUZAO_LV	[	528	]	=	55		ZHUZAO_ID1	[	528	]	=	4033		ZHUZAO_ID2	[	528	]	=	3993		ZHUZAO_ID3	[	528	]	=	2642		ZHUZAO__Rad	[	528	]	=	1
	ZHUZAO_ID	[	529	]	=	4655		ZHUZAO_LV	[	529	]	=	55		ZHUZAO_ID1	[	529	]	=	4033		ZHUZAO_ID2	[	529	]	=	1683		ZHUZAO_ID3	[	529	]	=	2642		ZHUZAO__Rad	[	529	]	=	1
	ZHUZAO_ID	[	530	]	=	23		ZHUZAO_LV	[	530	]	=	55		ZHUZAO_ID1	[	530	]	=	4033		ZHUZAO_ID2	[	530	]	=	3993		ZHUZAO_ID3	[	530	]	=	2642		ZHUZAO__Rad	[	530	]	=	1
	ZHUZAO_ID	[	531	]	=	775		ZHUZAO_LV	[	531	]	=	55		ZHUZAO_ID1	[	531	]	=	4033		ZHUZAO_ID2	[	531	]	=	1683		ZHUZAO_ID3	[	531	]	=	2642		ZHUZAO__Rad	[	531	]	=	1
	ZHUZAO_ID	[	532	]	=	1399		ZHUZAO_LV	[	532	]	=	55		ZHUZAO_ID1	[	532	]	=	4033		ZHUZAO_ID2	[	532	]	=	3993		ZHUZAO_ID3	[	532	]	=	2642		ZHUZAO__Rad	[	532	]	=	1
	ZHUZAO_ID	[	533	]	=	21		ZHUZAO_LV	[	533	]	=	55		ZHUZAO_ID1	[	533	]	=	4033		ZHUZAO_ID2	[	533	]	=	1683		ZHUZAO_ID3	[	533	]	=	2642		ZHUZAO__Rad	[	533	]	=	1
	ZHUZAO_ID	[	534	]	=	772		ZHUZAO_LV	[	534	]	=	55		ZHUZAO_ID1	[	534	]	=	4033		ZHUZAO_ID2	[	534	]	=	3993		ZHUZAO_ID3	[	534	]	=	2642		ZHUZAO__Rad	[	534	]	=	1
	ZHUZAO_ID	[	535	]	=	1378		ZHUZAO_LV	[	535	]	=	55		ZHUZAO_ID1	[	535	]	=	4033		ZHUZAO_ID2	[	535	]	=	1683		ZHUZAO_ID3	[	535	]	=	2642		ZHUZAO__Rad	[	535	]	=	1
	ZHUZAO_ID	[	536	]	=	1387		ZHUZAO_LV	[	536	]	=	55		ZHUZAO_ID1	[	536	]	=	4033		ZHUZAO_ID2	[	536	]	=	3993		ZHUZAO_ID3	[	536	]	=	2642		ZHUZAO__Rad	[	536	]	=	1
	ZHUZAO_ID	[	537	]	=	45		ZHUZAO_LV	[	537	]	=	55		ZHUZAO_ID1	[	537	]	=	4033		ZHUZAO_ID2	[	537	]	=	1683		ZHUZAO_ID3	[	537	]	=	2642		ZHUZAO__Rad	[	537	]	=	1
	ZHUZAO_ID	[	538	]	=	783		ZHUZAO_LV	[	538	]	=	55		ZHUZAO_ID1	[	538	]	=	4033		ZHUZAO_ID2	[	538	]	=	3993		ZHUZAO_ID3	[	538	]	=	2642		ZHUZAO__Rad	[	538	]	=	1
	ZHUZAO_ID	[	539	]	=	1414		ZHUZAO_LV	[	539	]	=	55		ZHUZAO_ID1	[	539	]	=	4033		ZHUZAO_ID2	[	539	]	=	1683		ZHUZAO_ID3	[	539	]	=	2642		ZHUZAO__Rad	[	539	]	=	1
	ZHUZAO_ID	[	540	]	=	84		ZHUZAO_LV	[	540	]	=	55		ZHUZAO_ID1	[	540	]	=	4033		ZHUZAO_ID2	[	540	]	=	3993		ZHUZAO_ID3	[	540	]	=	2642		ZHUZAO__Rad	[	540	]	=	1
	ZHUZAO_ID	[	541	]	=	801		ZHUZAO_LV	[	541	]	=	55		ZHUZAO_ID1	[	541	]	=	4033		ZHUZAO_ID2	[	541	]	=	1683		ZHUZAO_ID3	[	541	]	=	2642		ZHUZAO__Rad	[	541	]	=	1
	ZHUZAO_ID	[	542	]	=	1426		ZHUZAO_LV	[	542	]	=	55		ZHUZAO_ID1	[	542	]	=	4033		ZHUZAO_ID2	[	542	]	=	3993		ZHUZAO_ID3	[	542	]	=	2642		ZHUZAO__Rad	[	542	]	=	1
	ZHUZAO_ID	[	543	]	=	1461		ZHUZAO_LV	[	543	]	=	55		ZHUZAO_ID1	[	543	]	=	4033		ZHUZAO_ID2	[	543	]	=	1683		ZHUZAO_ID3	[	543	]	=	2642		ZHUZAO__Rad	[	543	]	=	1
	ZHUZAO_ID	[	544	]	=	108		ZHUZAO_LV	[	544	]	=	55		ZHUZAO_ID1	[	544	]	=	4033		ZHUZAO_ID2	[	544	]	=	3993		ZHUZAO_ID3	[	544	]	=	2642		ZHUZAO__Rad	[	544	]	=	1
	ZHUZAO_ID	[	545	]	=	787		ZHUZAO_LV	[	545	]	=	55		ZHUZAO_ID1	[	545	]	=	4033		ZHUZAO_ID2	[	545	]	=	1683		ZHUZAO_ID3	[	545	]	=	2642		ZHUZAO__Rad	[	545	]	=	1
	ZHUZAO_ID	[	546	]	=	794		ZHUZAO_LV	[	546	]	=	55		ZHUZAO_ID1	[	546	]	=	4033		ZHUZAO_ID2	[	546	]	=	3993		ZHUZAO_ID3	[	546	]	=	2642		ZHUZAO__Rad	[	546	]	=	1
	ZHUZAO_ID	[	547	]	=	1438		ZHUZAO_LV	[	547	]	=	55		ZHUZAO_ID1	[	547	]	=	4033		ZHUZAO_ID2	[	547	]	=	1683		ZHUZAO_ID3	[	547	]	=	2642		ZHUZAO__Rad	[	547	]	=	1
	ZHUZAO_ID	[	548	]	=	1441		ZHUZAO_LV	[	548	]	=	55		ZHUZAO_ID1	[	548	]	=	4033		ZHUZAO_ID2	[	548	]	=	3993		ZHUZAO_ID3	[	548	]	=	2642		ZHUZAO__Rad	[	548	]	=	1
	ZHUZAO_ID	[	549	]	=	1473		ZHUZAO_LV	[	549	]	=	55		ZHUZAO_ID1	[	549	]	=	4033		ZHUZAO_ID2	[	549	]	=	1683		ZHUZAO_ID3	[	549	]	=	2642		ZHUZAO__Rad	[	549	]	=	1
	ZHUZAO_ID	[	550	]	=	1476		ZHUZAO_LV	[	550	]	=	55		ZHUZAO_ID1	[	550	]	=	4033		ZHUZAO_ID2	[	550	]	=	3993		ZHUZAO_ID3	[	550	]	=	2642		ZHUZAO__Rad	[	550	]	=	1
	ZHUZAO_ID	[	551	]	=	4302		ZHUZAO_LV	[	551	]	=	55		ZHUZAO_ID1	[	551	]	=	4033		ZHUZAO_ID2	[	551	]	=	1683		ZHUZAO_ID3	[	551	]	=	2642		ZHUZAO__Rad	[	551	]	=	1
	ZHUZAO_ID	[	552	]	=	126		ZHUZAO_LV	[	552	]	=	55		ZHUZAO_ID1	[	552	]	=	4033		ZHUZAO_ID2	[	552	]	=	3993		ZHUZAO_ID3	[	552	]	=	2642		ZHUZAO__Rad	[	552	]	=	1
	ZHUZAO_ID	[	553	]	=	2200		ZHUZAO_LV	[	553	]	=	55		ZHUZAO_ID1	[	553	]	=	4033		ZHUZAO_ID2	[	553	]	=	1683		ZHUZAO_ID3	[	553	]	=	2642		ZHUZAO__Rad	[	553	]	=	1
	ZHUZAO_ID	[	554	]	=	2194		ZHUZAO_LV	[	554	]	=	55		ZHUZAO_ID1	[	554	]	=	4033		ZHUZAO_ID2	[	554	]	=	3993		ZHUZAO_ID3	[	554	]	=	2642		ZHUZAO__Rad	[	554	]	=	1
	ZHUZAO_ID	[	555	]	=	2213		ZHUZAO_LV	[	555	]	=	55		ZHUZAO_ID1	[	555	]	=	4033		ZHUZAO_ID2	[	555	]	=	1683		ZHUZAO_ID3	[	555	]	=	2642		ZHUZAO__Rad	[	555	]	=	1
	ZHUZAO_ID	[	556	]	=	316		ZHUZAO_LV	[	556	]	=	55		ZHUZAO_ID1	[	556	]	=	4033		ZHUZAO_ID2	[	556	]	=	3993		ZHUZAO_ID3	[	556	]	=	2642		ZHUZAO__Rad	[	556	]	=	1
	ZHUZAO_ID	[	557	]	=	363		ZHUZAO_LV	[	557	]	=	55		ZHUZAO_ID1	[	557	]	=	4033		ZHUZAO_ID2	[	557	]	=	1683		ZHUZAO_ID3	[	557	]	=	2642		ZHUZAO__Rad	[	557	]	=	1
	ZHUZAO_ID	[	558	]	=	797		ZHUZAO_LV	[	558	]	=	55		ZHUZAO_ID1	[	558	]	=	4033		ZHUZAO_ID2	[	558	]	=	3993		ZHUZAO_ID3	[	558	]	=	2642		ZHUZAO__Rad	[	558	]	=	1
	ZHUZAO_ID	[	559	]	=	779		ZHUZAO_LV	[	559	]	=	55		ZHUZAO_ID1	[	559	]	=	4033		ZHUZAO_ID2	[	559	]	=	1683		ZHUZAO_ID3	[	559	]	=	2642		ZHUZAO__Rad	[	559	]	=	1
	ZHUZAO_ID	[	560	]	=	357		ZHUZAO_LV	[	560	]	=	55		ZHUZAO_ID1	[	560	]	=	4033		ZHUZAO_ID2	[	560	]	=	3993		ZHUZAO_ID3	[	560	]	=	2642		ZHUZAO__Rad	[	560	]	=	1
	ZHUZAO_ID	[	561	]	=	303		ZHUZAO_LV	[	561	]	=	55		ZHUZAO_ID1	[	561	]	=	4033		ZHUZAO_ID2	[	561	]	=	1683		ZHUZAO_ID3	[	561	]	=	2642		ZHUZAO__Rad	[	561	]	=	1
	ZHUZAO_ID	[	562	]	=	768		ZHUZAO_LV	[	562	]	=	55		ZHUZAO_ID1	[	562	]	=	4033		ZHUZAO_ID2	[	562	]	=	3993		ZHUZAO_ID3	[	562	]	=	2642		ZHUZAO__Rad	[	562	]	=	1
	ZHUZAO_ID	[	563	]	=	391		ZHUZAO_LV	[	563	]	=	55		ZHUZAO_ID1	[	563	]	=	4033		ZHUZAO_ID2	[	563	]	=	1683		ZHUZAO_ID3	[	563	]	=	2642		ZHUZAO__Rad	[	563	]	=	1
	ZHUZAO_ID	[	564	]	=	805		ZHUZAO_LV	[	564	]	=	55		ZHUZAO_ID1	[	564	]	=	4033		ZHUZAO_ID2	[	564	]	=	3993		ZHUZAO_ID3	[	564	]	=	2642		ZHUZAO__Rad	[	564	]	=	1
	ZHUZAO_ID	[	565	]	=	343		ZHUZAO_LV	[	565	]	=	55		ZHUZAO_ID1	[	565	]	=	4033		ZHUZAO_ID2	[	565	]	=	1683		ZHUZAO_ID3	[	565	]	=	2642		ZHUZAO__Rad	[	565	]	=	1
	ZHUZAO_ID	[	566	]	=	791		ZHUZAO_LV	[	566	]	=	55		ZHUZAO_ID1	[	566	]	=	4033		ZHUZAO_ID2	[	566	]	=	3993		ZHUZAO_ID3	[	566	]	=	2642		ZHUZAO__Rad	[	566	]	=	1
	ZHUZAO_ID	[	567	]	=	379		ZHUZAO_LV	[	567	]	=	55		ZHUZAO_ID1	[	567	]	=	4033		ZHUZAO_ID2	[	567	]	=	1683		ZHUZAO_ID3	[	567	]	=	2642		ZHUZAO__Rad	[	567	]	=	1
	ZHUZAO_ID	[	568	]	=	376		ZHUZAO_LV	[	568	]	=	55		ZHUZAO_ID1	[	568	]	=	4033		ZHUZAO_ID2	[	568	]	=	3993		ZHUZAO_ID3	[	568	]	=	2642		ZHUZAO__Rad	[	568	]	=	1
	ZHUZAO_ID	[	569	]	=	492		ZHUZAO_LV	[	569	]	=	55		ZHUZAO_ID1	[	569	]	=	4033		ZHUZAO_ID2	[	569	]	=	1683		ZHUZAO_ID3	[	569	]	=	2642		ZHUZAO__Rad	[	569	]	=	1
	ZHUZAO_ID	[	570	]	=	539		ZHUZAO_LV	[	570	]	=	55		ZHUZAO_ID1	[	570	]	=	4033		ZHUZAO_ID2	[	570	]	=	3993		ZHUZAO_ID3	[	570	]	=	2642		ZHUZAO__Rad	[	570	]	=	1
	ZHUZAO_ID	[	571	]	=	811		ZHUZAO_LV	[	571	]	=	55		ZHUZAO_ID1	[	571	]	=	4033		ZHUZAO_ID2	[	571	]	=	1683		ZHUZAO_ID3	[	571	]	=	2642		ZHUZAO__Rad	[	571	]	=	1
	ZHUZAO_ID	[	572	]	=	809		ZHUZAO_LV	[	572	]	=	55		ZHUZAO_ID1	[	572	]	=	4033		ZHUZAO_ID2	[	572	]	=	3993		ZHUZAO_ID3	[	572	]	=	2642		ZHUZAO__Rad	[	572	]	=	1
	ZHUZAO_ID	[	573	]	=	533		ZHUZAO_LV	[	573	]	=	55		ZHUZAO_ID1	[	573	]	=	4033		ZHUZAO_ID2	[	573	]	=	1683		ZHUZAO_ID3	[	573	]	=	2642		ZHUZAO__Rad	[	573	]	=	1
	ZHUZAO_ID	[	574	]	=	479		ZHUZAO_LV	[	574	]	=	55		ZHUZAO_ID1	[	574	]	=	4033		ZHUZAO_ID2	[	574	]	=	3993		ZHUZAO_ID3	[	574	]	=	2642		ZHUZAO__Rad	[	574	]	=	1
	ZHUZAO_ID	[	575	]	=	807		ZHUZAO_LV	[	575	]	=	55		ZHUZAO_ID1	[	575	]	=	4033		ZHUZAO_ID2	[	575	]	=	1683		ZHUZAO_ID3	[	575	]	=	2642		ZHUZAO__Rad	[	575	]	=	1
	ZHUZAO_ID	[	576	]	=	567		ZHUZAO_LV	[	576	]	=	55		ZHUZAO_ID1	[	576	]	=	4033		ZHUZAO_ID2	[	576	]	=	3993		ZHUZAO_ID3	[	576	]	=	2642		ZHUZAO__Rad	[	576	]	=	1
	ZHUZAO_ID	[	577	]	=	815		ZHUZAO_LV	[	577	]	=	55		ZHUZAO_ID1	[	577	]	=	4033		ZHUZAO_ID2	[	577	]	=	1683		ZHUZAO_ID3	[	577	]	=	2642		ZHUZAO__Rad	[	577	]	=	1
	ZHUZAO_ID	[	578	]	=	519		ZHUZAO_LV	[	578	]	=	55		ZHUZAO_ID1	[	578	]	=	4033		ZHUZAO_ID2	[	578	]	=	3993		ZHUZAO_ID3	[	578	]	=	2642		ZHUZAO__Rad	[	578	]	=	1
	ZHUZAO_ID	[	579	]	=	552		ZHUZAO_LV	[	579	]	=	55		ZHUZAO_ID1	[	579	]	=	4033		ZHUZAO_ID2	[	579	]	=	1683		ZHUZAO_ID3	[	579	]	=	2642		ZHUZAO__Rad	[	579	]	=	1
	ZHUZAO_ID	[	580	]	=	812		ZHUZAO_LV	[	580	]	=	55		ZHUZAO_ID1	[	580	]	=	4033		ZHUZAO_ID2	[	580	]	=	3993		ZHUZAO_ID3	[	580	]	=	2642		ZHUZAO__Rad	[	580	]	=	1
	ZHUZAO_ID	[	581	]	=	555		ZHUZAO_LV	[	581	]	=	55		ZHUZAO_ID1	[	581	]	=	4033		ZHUZAO_ID2	[	581	]	=	1683		ZHUZAO_ID3	[	581	]	=	2642		ZHUZAO__Rad	[	581	]	=	1
	ZHUZAO_ID	[	582	]	=	668		ZHUZAO_LV	[	582	]	=	55		ZHUZAO_ID1	[	582	]	=	4033		ZHUZAO_ID2	[	582	]	=	3993		ZHUZAO_ID3	[	582	]	=	2642		ZHUZAO__Rad	[	582	]	=	1
	ZHUZAO_ID	[	583	]	=	715		ZHUZAO_LV	[	583	]	=	55		ZHUZAO_ID1	[	583	]	=	4033		ZHUZAO_ID2	[	583	]	=	1683		ZHUZAO_ID3	[	583	]	=	2642		ZHUZAO__Rad	[	583	]	=	1
	ZHUZAO_ID	[	584	]	=	813		ZHUZAO_LV	[	584	]	=	55		ZHUZAO_ID1	[	584	]	=	4033		ZHUZAO_ID2	[	584	]	=	3993		ZHUZAO_ID3	[	584	]	=	2642		ZHUZAO__Rad	[	584	]	=	1
	ZHUZAO_ID	[	585	]	=	810		ZHUZAO_LV	[	585	]	=	55		ZHUZAO_ID1	[	585	]	=	4033		ZHUZAO_ID2	[	585	]	=	1683		ZHUZAO_ID3	[	585	]	=	2642		ZHUZAO__Rad	[	585	]	=	1
	ZHUZAO_ID	[	586	]	=	709		ZHUZAO_LV	[	586	]	=	55		ZHUZAO_ID1	[	586	]	=	4033		ZHUZAO_ID2	[	586	]	=	3993		ZHUZAO_ID3	[	586	]	=	2642		ZHUZAO__Rad	[	586	]	=	1
	ZHUZAO_ID	[	587	]	=	655		ZHUZAO_LV	[	587	]	=	55		ZHUZAO_ID1	[	587	]	=	4033		ZHUZAO_ID2	[	587	]	=	1683		ZHUZAO_ID3	[	587	]	=	2642		ZHUZAO__Rad	[	587	]	=	1
	ZHUZAO_ID	[	588	]	=	808		ZHUZAO_LV	[	588	]	=	55		ZHUZAO_ID1	[	588	]	=	4033		ZHUZAO_ID2	[	588	]	=	3993		ZHUZAO_ID3	[	588	]	=	2642		ZHUZAO__Rad	[	588	]	=	1
	ZHUZAO_ID	[	589	]	=	743		ZHUZAO_LV	[	589	]	=	55		ZHUZAO_ID1	[	589	]	=	4033		ZHUZAO_ID2	[	589	]	=	1683		ZHUZAO_ID3	[	589	]	=	2642		ZHUZAO__Rad	[	589	]	=	1
	ZHUZAO_ID	[	590	]	=	877		ZHUZAO_LV	[	590	]	=	55		ZHUZAO_ID1	[	590	]	=	4033		ZHUZAO_ID2	[	590	]	=	3993		ZHUZAO_ID3	[	590	]	=	2642		ZHUZAO__Rad	[	590	]	=	1
	ZHUZAO_ID	[	591	]	=	695		ZHUZAO_LV	[	591	]	=	55		ZHUZAO_ID1	[	591	]	=	4033		ZHUZAO_ID2	[	591	]	=	1683		ZHUZAO_ID3	[	591	]	=	2642		ZHUZAO__Rad	[	591	]	=	1
	ZHUZAO_ID	[	592	]	=	728		ZHUZAO_LV	[	592	]	=	55		ZHUZAO_ID1	[	592	]	=	4033		ZHUZAO_ID2	[	592	]	=	3993		ZHUZAO_ID3	[	592	]	=	2642		ZHUZAO__Rad	[	592	]	=	1
	ZHUZAO_ID	[	593	]	=	814		ZHUZAO_LV	[	593	]	=	55		ZHUZAO_ID1	[	593	]	=	4033		ZHUZAO_ID2	[	593	]	=	1683		ZHUZAO_ID3	[	593	]	=	2642		ZHUZAO__Rad	[	593	]	=	1
	ZHUZAO_ID	[	594	]	=	731		ZHUZAO_LV	[	594	]	=	55		ZHUZAO_ID1	[	594	]	=	4033		ZHUZAO_ID2	[	594	]	=	3993		ZHUZAO_ID3	[	594	]	=	2642		ZHUZAO__Rad	[	594	]	=	1
	ZHUZAO_ID	[	595	]	=	765		ZHUZAO_LV	[	595	]	=	55		ZHUZAO_ID1	[	595	]	=	4033		ZHUZAO_ID2	[	595	]	=	1683		ZHUZAO_ID3	[	595	]	=	2642		ZHUZAO__Rad	[	595	]	=	1
	ZHUZAO_ID	[	596	]	=	228		ZHUZAO_LV	[	596	]	=	55		ZHUZAO_ID1	[	596	]	=	4033		ZHUZAO_ID2	[	596	]	=	3993		ZHUZAO_ID3	[	596	]	=	2642		ZHUZAO__Rad	[	596	]	=	1
	ZHUZAO_ID	[	597	]	=	495		ZHUZAO_LV	[	597	]	=	60		ZHUZAO_ID1	[	597	]	=	4034		ZHUZAO_ID2	[	597	]	=	3994		ZHUZAO_ID3	[	597	]	=	2643		ZHUZAO__Rad	[	597	]	=	1
	ZHUZAO_ID	[	598	]	=	497		ZHUZAO_LV	[	598	]	=	60		ZHUZAO_ID1	[	598	]	=	4034		ZHUZAO_ID2	[	598	]	=	1684		ZHUZAO_ID3	[	598	]	=	8318		ZHUZAO__Rad	[	598	]	=	1
	ZHUZAO_ID	[	599	]	=	4711		ZHUZAO_LV	[	599	]	=	60		ZHUZAO_ID1	[	599	]	=	4034		ZHUZAO_ID2	[	599	]	=	3994		ZHUZAO_ID3	[	599	]	=	2643		ZHUZAO__Rad	[	599	]	=	1
	ZHUZAO_ID	[	600	]	=	4712		ZHUZAO_LV	[	600	]	=	60		ZHUZAO_ID1	[	600	]	=	4034		ZHUZAO_ID2	[	600	]	=	1684		ZHUZAO_ID3	[	600	]	=	2643		ZHUZAO__Rad	[	600	]	=	1
	ZHUZAO_ID	[	601	]	=	4713		ZHUZAO_LV	[	601	]	=	60		ZHUZAO_ID1	[	601	]	=	4034		ZHUZAO_ID2	[	601	]	=	3994		ZHUZAO_ID3	[	601	]	=	2643		ZHUZAO__Rad	[	601	]	=	1
	ZHUZAO_ID	[	602	]	=	4714		ZHUZAO_LV	[	602	]	=	60		ZHUZAO_ID1	[	602	]	=	4034		ZHUZAO_ID2	[	602	]	=	1684		ZHUZAO_ID3	[	602	]	=	8318		ZHUZAO__Rad	[	602	]	=	1
	ZHUZAO_ID	[	603	]	=	4715		ZHUZAO_LV	[	603	]	=	60		ZHUZAO_ID1	[	603	]	=	4034		ZHUZAO_ID2	[	603	]	=	3994		ZHUZAO_ID3	[	603	]	=	2643		ZHUZAO__Rad	[	603	]	=	1
	ZHUZAO_ID	[	604	]	=	4656		ZHUZAO_LV	[	604	]	=	60		ZHUZAO_ID1	[	604	]	=	4034		ZHUZAO_ID2	[	604	]	=	1684		ZHUZAO_ID3	[	604	]	=	6532		ZHUZAO__Rad	[	604	]	=	1
	ZHUZAO_ID	[	605	]	=	4657		ZHUZAO_LV	[	605	]	=	60		ZHUZAO_ID1	[	605	]	=	4034		ZHUZAO_ID2	[	605	]	=	3994		ZHUZAO_ID3	[	605	]	=	2643		ZHUZAO__Rad	[	605	]	=	1
	ZHUZAO_ID	[	606	]	=	4658		ZHUZAO_LV	[	606	]	=	60		ZHUZAO_ID1	[	606	]	=	4034		ZHUZAO_ID2	[	606	]	=	1684		ZHUZAO_ID3	[	606	]	=	2643		ZHUZAO__Rad	[	606	]	=	1
	ZHUZAO_ID	[	607	]	=	4659		ZHUZAO_LV	[	607	]	=	60		ZHUZAO_ID1	[	607	]	=	4034		ZHUZAO_ID2	[	607	]	=	3994		ZHUZAO_ID3	[	607	]	=	2643		ZHUZAO__Rad	[	607	]	=	1
	ZHUZAO_ID	[	608	]	=	4660		ZHUZAO_LV	[	608	]	=	60		ZHUZAO_ID1	[	608	]	=	4034		ZHUZAO_ID2	[	608	]	=	1684		ZHUZAO_ID3	[	608	]	=	8318		ZHUZAO__Rad	[	608	]	=	1
	ZHUZAO_ID	[	609	]	=	878		ZHUZAO_LV	[	609	]	=	60		ZHUZAO_ID1	[	609	]	=	4034		ZHUZAO_ID2	[	609	]	=	3994		ZHUZAO_ID3	[	609	]	=	2643		ZHUZAO__Rad	[	609	]	=	1
	ZHUZAO_ID	[	610	]	=	879		ZHUZAO_LV	[	610	]	=	60		ZHUZAO_ID1	[	610	]	=	4034		ZHUZAO_ID2	[	610	]	=	1684		ZHUZAO_ID3	[	610	]	=	2643		ZHUZAO__Rad	[	610	]	=	1
	ZHUZAO_ID	[	611	]	=	880		ZHUZAO_LV	[	611	]	=	60		ZHUZAO_ID1	[	611	]	=	4034		ZHUZAO_ID2	[	611	]	=	3994		ZHUZAO_ID3	[	611	]	=	8318		ZHUZAO__Rad	[	611	]	=	1
	ZHUZAO_ID	[	612	]	=	8081		ZHUZAO_LV	[	612	]	=	60		ZHUZAO_ID1	[	612	]	=	4034		ZHUZAO_ID2	[	612	]	=	1684		ZHUZAO_ID3	[	612	]	=	2643		ZHUZAO__Rad	[	612	]	=	1
	ZHUZAO_ID	[	613	]	=	8082		ZHUZAO_LV	[	613	]	=	60		ZHUZAO_ID1	[	613	]	=	4034		ZHUZAO_ID2	[	613	]	=	3994		ZHUZAO_ID3	[	613	]	=	2643		ZHUZAO__Rad	[	613	]	=	1
	ZHUZAO_ID	[	614	]	=	8083		ZHUZAO_LV	[	614	]	=	60		ZHUZAO_ID1	[	614	]	=	4034		ZHUZAO_ID2	[	614	]	=	1684		ZHUZAO_ID3	[	614	]	=	2643		ZHUZAO__Rad	[	614	]	=	1
	ZHUZAO_ID	[	615	]	=	8084		ZHUZAO_LV	[	615	]	=	60		ZHUZAO_ID1	[	615	]	=	4034		ZHUZAO_ID2	[	615	]	=	3994		ZHUZAO_ID3	[	615	]	=	6532		ZHUZAO__Rad	[	615	]	=	1
	ZHUZAO_ID	[	616	]	=	8085		ZHUZAO_LV	[	616	]	=	60		ZHUZAO_ID1	[	616	]	=	4034		ZHUZAO_ID2	[	616	]	=	1684		ZHUZAO_ID3	[	616	]	=	2643		ZHUZAO__Rad	[	616	]	=	1
	ZHUZAO_ID	[	617	]	=	8086		ZHUZAO_LV	[	617	]	=	60		ZHUZAO_ID1	[	617	]	=	4034		ZHUZAO_ID2	[	617	]	=	3994		ZHUZAO_ID3	[	617	]	=	8318		ZHUZAO__Rad	[	617	]	=	1
	ZHUZAO_ID	[	618	]	=	8087		ZHUZAO_LV	[	618	]	=	60		ZHUZAO_ID1	[	618	]	=	4034		ZHUZAO_ID2	[	618	]	=	1684		ZHUZAO_ID3	[	618	]	=	2643		ZHUZAO__Rad	[	618	]	=	1
	ZHUZAO_ID	[	619	]	=	8088		ZHUZAO_LV	[	619	]	=	60		ZHUZAO_ID1	[	619	]	=	4034		ZHUZAO_ID2	[	619	]	=	3994		ZHUZAO_ID3	[	619	]	=	2643		ZHUZAO__Rad	[	619	]	=	1
	ZHUZAO_ID	[	620	]	=	8089		ZHUZAO_LV	[	620	]	=	60		ZHUZAO_ID1	[	620	]	=	4034		ZHUZAO_ID2	[	620	]	=	1684		ZHUZAO_ID3	[	620	]	=	2643		ZHUZAO__Rad	[	620	]	=	1
	ZHUZAO_ID	[	621	]	=	8090		ZHUZAO_LV	[	621	]	=	60		ZHUZAO_ID1	[	621	]	=	4034		ZHUZAO_ID2	[	621	]	=	3994		ZHUZAO_ID3	[	621	]	=	8318		ZHUZAO__Rad	[	621	]	=	1
	ZHUZAO_ID	[	622	]	=	8091		ZHUZAO_LV	[	622	]	=	60		ZHUZAO_ID1	[	622	]	=	4034		ZHUZAO_ID2	[	622	]	=	1684		ZHUZAO_ID3	[	622	]	=	2643		ZHUZAO__Rad	[	622	]	=	1
	ZHUZAO_ID	[	623	]	=	8092		ZHUZAO_LV	[	623	]	=	60		ZHUZAO_ID1	[	623	]	=	4034		ZHUZAO_ID2	[	623	]	=	3994		ZHUZAO_ID3	[	623	]	=	2643		ZHUZAO__Rad	[	623	]	=	1
	ZHUZAO_ID	[	624	]	=	8093		ZHUZAO_LV	[	624	]	=	60		ZHUZAO_ID1	[	624	]	=	4034		ZHUZAO_ID2	[	624	]	=	1684		ZHUZAO_ID3	[	624	]	=	8318		ZHUZAO__Rad	[	624	]	=	1
	ZHUZAO_ID	[	625	]	=	8094		ZHUZAO_LV	[	625	]	=	60		ZHUZAO_ID1	[	625	]	=	4034		ZHUZAO_ID2	[	625	]	=	3994		ZHUZAO_ID3	[	625	]	=	2643		ZHUZAO__Rad	[	625	]	=	1
	ZHUZAO_ID	[	626	]	=	8095		ZHUZAO_LV	[	626	]	=	60		ZHUZAO_ID1	[	626	]	=	4034		ZHUZAO_ID2	[	626	]	=	1684		ZHUZAO_ID3	[	626	]	=	2643		ZHUZAO__Rad	[	626	]	=	1
	ZHUZAO_ID	[	627	]	=	8096		ZHUZAO_LV	[	627	]	=	60		ZHUZAO_ID1	[	627	]	=	4034		ZHUZAO_ID2	[	627	]	=	3994		ZHUZAO_ID3	[	627	]	=	2643		ZHUZAO__Rad	[	627	]	=	1
	ZHUZAO_ID	[	628	]	=	8097		ZHUZAO_LV	[	628	]	=	60		ZHUZAO_ID1	[	628	]	=	4034		ZHUZAO_ID2	[	628	]	=	1684		ZHUZAO_ID3	[	628	]	=	8318		ZHUZAO__Rad	[	628	]	=	1
	ZHUZAO_ID	[	629	]	=	8098		ZHUZAO_LV	[	629	]	=	60		ZHUZAO_ID1	[	629	]	=	4034		ZHUZAO_ID2	[	629	]	=	3994		ZHUZAO_ID3	[	629	]	=	2643		ZHUZAO__Rad	[	629	]	=	1
	ZHUZAO_ID	[	630	]	=	8099		ZHUZAO_LV	[	630	]	=	60		ZHUZAO_ID1	[	630	]	=	4034		ZHUZAO_ID2	[	630	]	=	1684		ZHUZAO_ID3	[	630	]	=	8318		ZHUZAO__Rad	[	630	]	=	1
	ZHUZAO_ID	[	631	]	=	8100		ZHUZAO_LV	[	631	]	=	60		ZHUZAO_ID1	[	631	]	=	4034		ZHUZAO_ID2	[	631	]	=	3994		ZHUZAO_ID3	[	631	]	=	2643		ZHUZAO__Rad	[	631	]	=	1
	ZHUZAO_ID	[	632	]	=	8101		ZHUZAO_LV	[	632	]	=	60		ZHUZAO_ID1	[	632	]	=	4034		ZHUZAO_ID2	[	632	]	=	1684		ZHUZAO_ID3	[	632	]	=	2643		ZHUZAO__Rad	[	632	]	=	1
	ZHUZAO_ID	[	633	]	=	8102		ZHUZAO_LV	[	633	]	=	60		ZHUZAO_ID1	[	633	]	=	4034		ZHUZAO_ID2	[	633	]	=	3994		ZHUZAO_ID3	[	633	]	=	6532		ZHUZAO__Rad	[	633	]	=	1
	ZHUZAO_ID	[	634	]	=	8103		ZHUZAO_LV	[	634	]	=	60		ZHUZAO_ID1	[	634	]	=	4034		ZHUZAO_ID2	[	634	]	=	1684		ZHUZAO_ID3	[	634	]	=	8318		ZHUZAO__Rad	[	634	]	=	1
	ZHUZAO_ID	[	635	]	=	8104		ZHUZAO_LV	[	635	]	=	60		ZHUZAO_ID1	[	635	]	=	4034		ZHUZAO_ID2	[	635	]	=	3994		ZHUZAO_ID3	[	635	]	=	2643		ZHUZAO__Rad	[	635	]	=	1
	ZHUZAO_ID	[	636	]	=	8105		ZHUZAO_LV	[	636	]	=	60		ZHUZAO_ID1	[	636	]	=	4034		ZHUZAO_ID2	[	636	]	=	1684		ZHUZAO_ID3	[	636	]	=	2643		ZHUZAO__Rad	[	636	]	=	1
	ZHUZAO_ID	[	637	]	=	8106		ZHUZAO_LV	[	637	]	=	60		ZHUZAO_ID1	[	637	]	=	4034		ZHUZAO_ID2	[	637	]	=	3994		ZHUZAO_ID3	[	637	]	=	2643		ZHUZAO__Rad	[	637	]	=	1
	ZHUZAO_ID	[	638	]	=	8107		ZHUZAO_LV	[	638	]	=	60		ZHUZAO_ID1	[	638	]	=	4034		ZHUZAO_ID2	[	638	]	=	1684		ZHUZAO_ID3	[	638	]	=	2643		ZHUZAO__Rad	[	638	]	=	1
	ZHUZAO_ID	[	639	]	=	8108		ZHUZAO_LV	[	639	]	=	60		ZHUZAO_ID1	[	639	]	=	4034		ZHUZAO_ID2	[	639	]	=	3994		ZHUZAO_ID3	[	639	]	=	2643		ZHUZAO__Rad	[	639	]	=	1
	ZHUZAO_ID	[	640	]	=	8109		ZHUZAO_LV	[	640	]	=	60		ZHUZAO_ID1	[	640	]	=	4034		ZHUZAO_ID2	[	640	]	=	1684		ZHUZAO_ID3	[	640	]	=	2643		ZHUZAO__Rad	[	640	]	=	1
	ZHUZAO_ID	[	641	]	=	8110		ZHUZAO_LV	[	641	]	=	60		ZHUZAO_ID1	[	641	]	=	4034		ZHUZAO_ID2	[	641	]	=	3994		ZHUZAO_ID3	[	641	]	=	2643		ZHUZAO__Rad	[	641	]	=	1
	ZHUZAO_ID	[	642	]	=	8111		ZHUZAO_LV	[	642	]	=	60		ZHUZAO_ID1	[	642	]	=	4034		ZHUZAO_ID2	[	642	]	=	1684		ZHUZAO_ID3	[	642	]	=	6532		ZHUZAO__Rad	[	642	]	=	1
	ZHUZAO_ID	[	643	]	=	8112		ZHUZAO_LV	[	643	]	=	60		ZHUZAO_ID1	[	643	]	=	4034		ZHUZAO_ID2	[	643	]	=	3994		ZHUZAO_ID3	[	643	]	=	2643		ZHUZAO__Rad	[	643	]	=	1
	ZHUZAO_ID	[	644	]	=	8113		ZHUZAO_LV	[	644	]	=	60		ZHUZAO_ID1	[	644	]	=	4034		ZHUZAO_ID2	[	644	]	=	1684		ZHUZAO_ID3	[	644	]	=	2643		ZHUZAO__Rad	[	644	]	=	1
	ZHUZAO_ID	[	645	]	=	8114		ZHUZAO_LV	[	645	]	=	60		ZHUZAO_ID1	[	645	]	=	4034		ZHUZAO_ID2	[	645	]	=	3994		ZHUZAO_ID3	[	645	]	=	2643		ZHUZAO__Rad	[	645	]	=	1
	ZHUZAO_ID	[	646	]	=	8115		ZHUZAO_LV	[	646	]	=	60		ZHUZAO_ID1	[	646	]	=	4034		ZHUZAO_ID2	[	646	]	=	1684		ZHUZAO_ID3	[	646	]	=	8318		ZHUZAO__Rad	[	646	]	=	1
	ZHUZAO_ID	[	647	]	=	8116		ZHUZAO_LV	[	647	]	=	60		ZHUZAO_ID1	[	647	]	=	4034		ZHUZAO_ID2	[	647	]	=	3994		ZHUZAO_ID3	[	647	]	=	2643		ZHUZAO__Rad	[	647	]	=	1
	ZHUZAO_ID	[	648	]	=	8117		ZHUZAO_LV	[	648	]	=	60		ZHUZAO_ID1	[	648	]	=	4034		ZHUZAO_ID2	[	648	]	=	1684		ZHUZAO_ID3	[	648	]	=	8318		ZHUZAO__Rad	[	648	]	=	1
	ZHUZAO_ID	[	649	]	=	8118		ZHUZAO_LV	[	649	]	=	60		ZHUZAO_ID1	[	649	]	=	4034		ZHUZAO_ID2	[	649	]	=	3994		ZHUZAO_ID3	[	649	]	=	2643		ZHUZAO__Rad	[	649	]	=	1
	ZHUZAO_ID	[	650	]	=	8119		ZHUZAO_LV	[	650	]	=	60		ZHUZAO_ID1	[	650	]	=	4034		ZHUZAO_ID2	[	650	]	=	1684		ZHUZAO_ID3	[	650	]	=	2643		ZHUZAO__Rad	[	650	]	=	1
	ZHUZAO_ID	[	651	]	=	8120		ZHUZAO_LV	[	651	]	=	60		ZHUZAO_ID1	[	651	]	=	4034		ZHUZAO_ID2	[	651	]	=	3994		ZHUZAO_ID3	[	651	]	=	2643		ZHUZAO__Rad	[	651	]	=	1
	ZHUZAO_ID	[	652	]	=	8121		ZHUZAO_LV	[	652	]	=	60		ZHUZAO_ID1	[	652	]	=	4034		ZHUZAO_ID2	[	652	]	=	1684		ZHUZAO_ID3	[	652	]	=	8318		ZHUZAO__Rad	[	652	]	=	1
	ZHUZAO_ID	[	653	]	=	8122		ZHUZAO_LV	[	653	]	=	60		ZHUZAO_ID1	[	653	]	=	4034		ZHUZAO_ID2	[	653	]	=	3994		ZHUZAO_ID3	[	653	]	=	2643		ZHUZAO__Rad	[	653	]	=	1
	ZHUZAO_ID	[	654	]	=	8123		ZHUZAO_LV	[	654	]	=	60		ZHUZAO_ID1	[	654	]	=	4034		ZHUZAO_ID2	[	654	]	=	1684		ZHUZAO_ID3	[	654	]	=	2643		ZHUZAO__Rad	[	654	]	=	1
	ZHUZAO_ID	[	655	]	=	8124		ZHUZAO_LV	[	655	]	=	60		ZHUZAO_ID1	[	655	]	=	4034		ZHUZAO_ID2	[	655	]	=	3994		ZHUZAO_ID3	[	655	]	=	6532		ZHUZAO__Rad	[	655	]	=	1
	ZHUZAO_ID	[	656	]	=	8125		ZHUZAO_LV	[	656	]	=	60		ZHUZAO_ID1	[	656	]	=	4034		ZHUZAO_ID2	[	656	]	=	1684		ZHUZAO_ID3	[	656	]	=	6532		ZHUZAO__Rad	[	656	]	=	1
	ZHUZAO_ID	[	657	]	=	8126		ZHUZAO_LV	[	657	]	=	60		ZHUZAO_ID1	[	657	]	=	4034		ZHUZAO_ID2	[	657	]	=	3994		ZHUZAO_ID3	[	657	]	=	8318		ZHUZAO__Rad	[	657	]	=	1
	ZHUZAO_ID	[	658	]	=	8127		ZHUZAO_LV	[	658	]	=	60		ZHUZAO_ID1	[	658	]	=	4034		ZHUZAO_ID2	[	658	]	=	1684		ZHUZAO_ID3	[	658	]	=	2643		ZHUZAO__Rad	[	658	]	=	1
	ZHUZAO_ID	[	659	]	=	8128		ZHUZAO_LV	[	659	]	=	60		ZHUZAO_ID1	[	659	]	=	4034		ZHUZAO_ID2	[	659	]	=	3994		ZHUZAO_ID3	[	659	]	=	2643		ZHUZAO__Rad	[	659	]	=	1
	ZHUZAO_ID	[	660	]	=	8129		ZHUZAO_LV	[	660	]	=	60		ZHUZAO_ID1	[	660	]	=	4034		ZHUZAO_ID2	[	660	]	=	1684		ZHUZAO_ID3	[	660	]	=	2643		ZHUZAO__Rad	[	660	]	=	1
	ZHUZAO_ID	[	661	]	=	8130		ZHUZAO_LV	[	661	]	=	60		ZHUZAO_ID1	[	661	]	=	4034		ZHUZAO_ID2	[	661	]	=	3994		ZHUZAO_ID3	[	661	]	=	8318		ZHUZAO__Rad	[	661	]	=	1
	ZHUZAO_ID	[	662	]	=	8131		ZHUZAO_LV	[	662	]	=	60		ZHUZAO_ID1	[	662	]	=	4034		ZHUZAO_ID2	[	662	]	=	1684		ZHUZAO_ID3	[	662	]	=	2643		ZHUZAO__Rad	[	662	]	=	1
	ZHUZAO_ID	[	663	]	=	8132		ZHUZAO_LV	[	663	]	=	60		ZHUZAO_ID1	[	663	]	=	4034		ZHUZAO_ID2	[	663	]	=	3994		ZHUZAO_ID3	[	663	]	=	8318		ZHUZAO__Rad	[	663	]	=	1
	ZHUZAO_ID	[	664	]	=	8133		ZHUZAO_LV	[	664	]	=	60		ZHUZAO_ID1	[	664	]	=	4034		ZHUZAO_ID2	[	664	]	=	1684		ZHUZAO_ID3	[	664	]	=	2643		ZHUZAO__Rad	[	664	]	=	1
	ZHUZAO_ID	[	665	]	=	8134		ZHUZAO_LV	[	665	]	=	60		ZHUZAO_ID1	[	665	]	=	4034		ZHUZAO_ID2	[	665	]	=	3994		ZHUZAO_ID3	[	665	]	=	2643		ZHUZAO__Rad	[	665	]	=	1
	ZHUZAO_ID	[	666	]	=	8135		ZHUZAO_LV	[	666	]	=	60		ZHUZAO_ID1	[	666	]	=	4034		ZHUZAO_ID2	[	666	]	=	1684		ZHUZAO_ID3	[	666	]	=	2643		ZHUZAO__Rad	[	666	]	=	1
	ZHUZAO_ID	[	667	]	=	8136		ZHUZAO_LV	[	667	]	=	60		ZHUZAO_ID1	[	667	]	=	4034		ZHUZAO_ID2	[	667	]	=	3994		ZHUZAO_ID3	[	667	]	=	8318		ZHUZAO__Rad	[	667	]	=	1
	ZHUZAO_ID	[	668	]	=	8137		ZHUZAO_LV	[	668	]	=	60		ZHUZAO_ID1	[	668	]	=	4034		ZHUZAO_ID2	[	668	]	=	1684		ZHUZAO_ID3	[	668	]	=	6532		ZHUZAO__Rad	[	668	]	=	1
	ZHUZAO_ID	[	669	]	=	8138		ZHUZAO_LV	[	669	]	=	60		ZHUZAO_ID1	[	669	]	=	4034		ZHUZAO_ID2	[	669	]	=	3994		ZHUZAO_ID3	[	669	]	=	2643		ZHUZAO__Rad	[	669	]	=	1
	ZHUZAO_ID	[	670	]	=	8139		ZHUZAO_LV	[	670	]	=	60		ZHUZAO_ID1	[	670	]	=	4034		ZHUZAO_ID2	[	670	]	=	1684		ZHUZAO_ID3	[	670	]	=	2643		ZHUZAO__Rad	[	670	]	=	1
	ZHUZAO_ID	[	671	]	=	8140		ZHUZAO_LV	[	671	]	=	60		ZHUZAO_ID1	[	671	]	=	4034		ZHUZAO_ID2	[	671	]	=	3994		ZHUZAO_ID3	[	671	]	=	2643		ZHUZAO__Rad	[	671	]	=	1
	ZHUZAO_ID	[	672	]	=	8141		ZHUZAO_LV	[	672	]	=	60		ZHUZAO_ID1	[	672	]	=	4034		ZHUZAO_ID2	[	672	]	=	1684		ZHUZAO_ID3	[	672	]	=	2643		ZHUZAO__Rad	[	672	]	=	1
	ZHUZAO_ID	[	673	]	=	8142		ZHUZAO_LV	[	673	]	=	60		ZHUZAO_ID1	[	673	]	=	4034		ZHUZAO_ID2	[	673	]	=	3994		ZHUZAO_ID3	[	673	]	=	8318		ZHUZAO__Rad	[	673	]	=	1
	ZHUZAO_ID	[	674	]	=	8143		ZHUZAO_LV	[	674	]	=	60		ZHUZAO_ID1	[	674	]	=	4034		ZHUZAO_ID2	[	674	]	=	1684		ZHUZAO_ID3	[	674	]	=	2643		ZHUZAO__Rad	[	674	]	=	1
	ZHUZAO_ID	[	675	]	=	8144		ZHUZAO_LV	[	675	]	=	60		ZHUZAO_ID1	[	675	]	=	4034		ZHUZAO_ID2	[	675	]	=	3994		ZHUZAO_ID3	[	675	]	=	2643		ZHUZAO__Rad	[	675	]	=	1
	ZHUZAO_ID	[	676	]	=	8145		ZHUZAO_LV	[	676	]	=	60		ZHUZAO_ID1	[	676	]	=	4034		ZHUZAO_ID2	[	676	]	=	1684		ZHUZAO_ID3	[	676	]	=	2643		ZHUZAO__Rad	[	676	]	=	1
	ZHUZAO_ID	[	677	]	=	8146		ZHUZAO_LV	[	677	]	=	60		ZHUZAO_ID1	[	677	]	=	4034		ZHUZAO_ID2	[	677	]	=	3994		ZHUZAO_ID3	[	677	]	=	2643		ZHUZAO__Rad	[	677	]	=	1
	ZHUZAO_ID	[	678	]	=	8147		ZHUZAO_LV	[	678	]	=	65		ZHUZAO_ID1	[	678	]	=	4034		ZHUZAO_ID2	[	678	]	=	1684		ZHUZAO_ID3	[	678	]	=	8318		ZHUZAO__Rad	[	678	]	=	1
	ZHUZAO_ID	[	679	]	=	8148		ZHUZAO_LV	[	679	]	=	65		ZHUZAO_ID1	[	679	]	=	4034		ZHUZAO_ID2	[	679	]	=	3994		ZHUZAO_ID3	[	679	]	=	2643		ZHUZAO__Rad	[	679	]	=	1
	ZHUZAO_ID	[	680	]	=	8149		ZHUZAO_LV	[	680	]	=	65		ZHUZAO_ID1	[	680	]	=	4034		ZHUZAO_ID2	[	680	]	=	1684		ZHUZAO_ID3	[	680	]	=	2643		ZHUZAO__Rad	[	680	]	=	1
	ZHUZAO_ID	[	681	]	=	8150		ZHUZAO_LV	[	681	]	=	65		ZHUZAO_ID1	[	681	]	=	4034		ZHUZAO_ID2	[	681	]	=	3994		ZHUZAO_ID3	[	681	]	=	6532		ZHUZAO__Rad	[	681	]	=	1
	ZHUZAO_ID	[	682	]	=	8151		ZHUZAO_LV	[	682	]	=	65		ZHUZAO_ID1	[	682	]	=	4034		ZHUZAO_ID2	[	682	]	=	1684		ZHUZAO_ID3	[	682	]	=	8318		ZHUZAO__Rad	[	682	]	=	1
	ZHUZAO_ID	[	683	]	=	8152		ZHUZAO_LV	[	683	]	=	65		ZHUZAO_ID1	[	683	]	=	4034		ZHUZAO_ID2	[	683	]	=	3994		ZHUZAO_ID3	[	683	]	=	2643		ZHUZAO__Rad	[	683	]	=	1
	ZHUZAO_ID	[	684	]	=	8153		ZHUZAO_LV	[	684	]	=	65		ZHUZAO_ID1	[	684	]	=	4034		ZHUZAO_ID2	[	684	]	=	1684		ZHUZAO_ID3	[	684	]	=	8318		ZHUZAO__Rad	[	684	]	=	1
	ZHUZAO_ID	[	685	]	=	8154		ZHUZAO_LV	[	685	]	=	65		ZHUZAO_ID1	[	685	]	=	4034		ZHUZAO_ID2	[	685	]	=	3994		ZHUZAO_ID3	[	685	]	=	2643		ZHUZAO__Rad	[	685	]	=	1
	ZHUZAO_ID	[	686	]	=	8155		ZHUZAO_LV	[	686	]	=	65		ZHUZAO_ID1	[	686	]	=	4034		ZHUZAO_ID2	[	686	]	=	1684		ZHUZAO_ID3	[	686	]	=	2643		ZHUZAO__Rad	[	686	]	=	1
	ZHUZAO_ID	[	687	]	=	8156		ZHUZAO_LV	[	687	]	=	65		ZHUZAO_ID1	[	687	]	=	4034		ZHUZAO_ID2	[	687	]	=	3994		ZHUZAO_ID3	[	687	]	=	2643		ZHUZAO__Rad	[	687	]	=	1
	ZHUZAO_ID	[	688	]	=	8157		ZHUZAO_LV	[	688	]	=	65		ZHUZAO_ID1	[	688	]	=	4034		ZHUZAO_ID2	[	688	]	=	1684		ZHUZAO_ID3	[	688	]	=	8318		ZHUZAO__Rad	[	688	]	=	1
	ZHUZAO_ID	[	689	]	=	8158		ZHUZAO_LV	[	689	]	=	65		ZHUZAO_ID1	[	689	]	=	4034		ZHUZAO_ID2	[	689	]	=	3994		ZHUZAO_ID3	[	689	]	=	2643		ZHUZAO__Rad	[	689	]	=	1
	ZHUZAO_ID	[	690	]	=	8159		ZHUZAO_LV	[	690	]	=	65		ZHUZAO_ID1	[	690	]	=	4034		ZHUZAO_ID2	[	690	]	=	1684		ZHUZAO_ID3	[	690	]	=	2643		ZHUZAO__Rad	[	690	]	=	1
	ZHUZAO_ID	[	691	]	=	8160		ZHUZAO_LV	[	691	]	=	65		ZHUZAO_ID1	[	691	]	=	4034		ZHUZAO_ID2	[	691	]	=	3994		ZHUZAO_ID3	[	691	]	=	2643		ZHUZAO__Rad	[	691	]	=	1
	ZHUZAO_ID	[	692	]	=	8161		ZHUZAO_LV	[	692	]	=	65		ZHUZAO_ID1	[	692	]	=	4034		ZHUZAO_ID2	[	692	]	=	1684		ZHUZAO_ID3	[	692	]	=	8318		ZHUZAO__Rad	[	692	]	=	1
	ZHUZAO_ID	[	693	]	=	8162		ZHUZAO_LV	[	693	]	=	65		ZHUZAO_ID1	[	693	]	=	4034		ZHUZAO_ID2	[	693	]	=	3994		ZHUZAO_ID3	[	693	]	=	2643		ZHUZAO__Rad	[	693	]	=	1
	ZHUZAO_ID	[	694	]	=	8163		ZHUZAO_LV	[	694	]	=	65		ZHUZAO_ID1	[	694	]	=	4034		ZHUZAO_ID2	[	694	]	=	1684		ZHUZAO_ID3	[	694	]	=	8318		ZHUZAO__Rad	[	694	]	=	1
	ZHUZAO_ID	[	695	]	=	8164		ZHUZAO_LV	[	695	]	=	65		ZHUZAO_ID1	[	695	]	=	4034		ZHUZAO_ID2	[	695	]	=	3994		ZHUZAO_ID3	[	695	]	=	2643		ZHUZAO__Rad	[	695	]	=	1
	ZHUZAO_ID	[	696	]	=	8165		ZHUZAO_LV	[	696	]	=	65		ZHUZAO_ID1	[	696	]	=	4034		ZHUZAO_ID2	[	696	]	=	1684		ZHUZAO_ID3	[	696	]	=	2643		ZHUZAO__Rad	[	696	]	=	1
	ZHUZAO_ID	[	697	]	=	8166		ZHUZAO_LV	[	697	]	=	65		ZHUZAO_ID1	[	697	]	=	4034		ZHUZAO_ID2	[	697	]	=	3994		ZHUZAO_ID3	[	697	]	=	2643		ZHUZAO__Rad	[	697	]	=	1
	ZHUZAO_ID	[	698	]	=	8167		ZHUZAO_LV	[	698	]	=	65		ZHUZAO_ID1	[	698	]	=	4034		ZHUZAO_ID2	[	698	]	=	1684		ZHUZAO_ID3	[	698	]	=	8318		ZHUZAO__Rad	[	698	]	=	1
	ZHUZAO_ID	[	699	]	=	8168		ZHUZAO_LV	[	699	]	=	65		ZHUZAO_ID1	[	699	]	=	4034		ZHUZAO_ID2	[	699	]	=	3994		ZHUZAO_ID3	[	699	]	=	2643		ZHUZAO__Rad	[	699	]	=	1
	ZHUZAO_ID	[	700	]	=	8169		ZHUZAO_LV	[	700	]	=	65		ZHUZAO_ID1	[	700	]	=	4034		ZHUZAO_ID2	[	700	]	=	1684		ZHUZAO_ID3	[	700	]	=	6532		ZHUZAO__Rad	[	700	]	=	1
	ZHUZAO_ID	[	701	]	=	8170		ZHUZAO_LV	[	701	]	=	65		ZHUZAO_ID1	[	701	]	=	4034		ZHUZAO_ID2	[	701	]	=	3994		ZHUZAO_ID3	[	701	]	=	2643		ZHUZAO__Rad	[	701	]	=	1
	ZHUZAO_ID	[	702	]	=	8171		ZHUZAO_LV	[	702	]	=	65		ZHUZAO_ID1	[	702	]	=	4034		ZHUZAO_ID2	[	702	]	=	1684		ZHUZAO_ID3	[	702	]	=	8318		ZHUZAO__Rad	[	702	]	=	1
	ZHUZAO_ID	[	703	]	=	8172		ZHUZAO_LV	[	703	]	=	65		ZHUZAO_ID1	[	703	]	=	4034		ZHUZAO_ID2	[	703	]	=	3994		ZHUZAO_ID3	[	703	]	=	2643		ZHUZAO__Rad	[	703	]	=	1
	ZHUZAO_ID	[	704	]	=	8173		ZHUZAO_LV	[	704	]	=	65		ZHUZAO_ID1	[	704	]	=	4034		ZHUZAO_ID2	[	704	]	=	1684		ZHUZAO_ID3	[	704	]	=	2643		ZHUZAO__Rad	[	704	]	=	1
	ZHUZAO_ID	[	705	]	=	8174		ZHUZAO_LV	[	705	]	=	65		ZHUZAO_ID1	[	705	]	=	4034		ZHUZAO_ID2	[	705	]	=	3994		ZHUZAO_ID3	[	705	]	=	2643		ZHUZAO__Rad	[	705	]	=	1
	ZHUZAO_ID	[	706	]	=	8175		ZHUZAO_LV	[	706	]	=	65		ZHUZAO_ID1	[	706	]	=	4034		ZHUZAO_ID2	[	706	]	=	1684		ZHUZAO_ID3	[	706	]	=	8318		ZHUZAO__Rad	[	706	]	=	1
	ZHUZAO_ID	[	707	]	=	8176		ZHUZAO_LV	[	707	]	=	65		ZHUZAO_ID1	[	707	]	=	4034		ZHUZAO_ID2	[	707	]	=	3994		ZHUZAO_ID3	[	707	]	=	2643		ZHUZAO__Rad	[	707	]	=	1
	ZHUZAO_ID	[	708	]	=	8177		ZHUZAO_LV	[	708	]	=	65		ZHUZAO_ID1	[	708	]	=	4034		ZHUZAO_ID2	[	708	]	=	1684		ZHUZAO_ID3	[	708	]	=	8318		ZHUZAO__Rad	[	708	]	=	1
	ZHUZAO_ID	[	709	]	=	8178		ZHUZAO_LV	[	709	]	=	65		ZHUZAO_ID1	[	709	]	=	4034		ZHUZAO_ID2	[	709	]	=	3994		ZHUZAO_ID3	[	709	]	=	2643		ZHUZAO__Rad	[	709	]	=	1
	ZHUZAO_ID	[	710	]	=	8179		ZHUZAO_LV	[	710	]	=	65		ZHUZAO_ID1	[	710	]	=	4034		ZHUZAO_ID2	[	710	]	=	1684		ZHUZAO_ID3	[	710	]	=	2643		ZHUZAO__Rad	[	710	]	=	1
	ZHUZAO_ID	[	711	]	=	8180		ZHUZAO_LV	[	711	]	=	65		ZHUZAO_ID1	[	711	]	=	4034		ZHUZAO_ID2	[	711	]	=	3994		ZHUZAO_ID3	[	711	]	=	2643		ZHUZAO__Rad	[	711	]	=	1
	ZHUZAO_ID	[	712	]	=	8181		ZHUZAO_LV	[	712	]	=	65		ZHUZAO_ID1	[	712	]	=	4034		ZHUZAO_ID2	[	712	]	=	1684		ZHUZAO_ID3	[	712	]	=	8318		ZHUZAO__Rad	[	712	]	=	1
	ZHUZAO_ID	[	713	]	=	8182		ZHUZAO_LV	[	713	]	=	65		ZHUZAO_ID1	[	713	]	=	4034		ZHUZAO_ID2	[	713	]	=	3994		ZHUZAO_ID3	[	713	]	=	2643		ZHUZAO__Rad	[	713	]	=	1
	ZHUZAO_ID	[	714	]	=	8183		ZHUZAO_LV	[	714	]	=	65		ZHUZAO_ID1	[	714	]	=	4034		ZHUZAO_ID2	[	714	]	=	1684		ZHUZAO_ID3	[	714	]	=	2643		ZHUZAO__Rad	[	714	]	=	1
	ZHUZAO_ID	[	715	]	=	8184		ZHUZAO_LV	[	715	]	=	65		ZHUZAO_ID1	[	715	]	=	4034		ZHUZAO_ID2	[	715	]	=	3994		ZHUZAO_ID3	[	715	]	=	2643		ZHUZAO__Rad	[	715	]	=	1
	ZHUZAO_ID	[	716	]	=	8185		ZHUZAO_LV	[	716	]	=	65		ZHUZAO_ID1	[	716	]	=	4034		ZHUZAO_ID2	[	716	]	=	1684		ZHUZAO_ID3	[	716	]	=	8318		ZHUZAO__Rad	[	716	]	=	1
	ZHUZAO_ID	[	717	]	=	8186		ZHUZAO_LV	[	717	]	=	65		ZHUZAO_ID1	[	717	]	=	4034		ZHUZAO_ID2	[	717	]	=	3994		ZHUZAO_ID3	[	717	]	=	6532		ZHUZAO__Rad	[	717	]	=	1
	ZHUZAO_ID	[	718	]	=	8187		ZHUZAO_LV	[	718	]	=	65		ZHUZAO_ID1	[	718	]	=	4034		ZHUZAO_ID2	[	718	]	=	1684		ZHUZAO_ID3	[	718	]	=	2643		ZHUZAO__Rad	[	718	]	=	1
	ZHUZAO_ID	[	719	]	=	8188		ZHUZAO_LV	[	719	]	=	65		ZHUZAO_ID1	[	719	]	=	4034		ZHUZAO_ID2	[	719	]	=	3994		ZHUZAO_ID3	[	719	]	=	2643		ZHUZAO__Rad	[	719	]	=	1
	ZHUZAO_ID	[	720	]	=	8189		ZHUZAO_LV	[	720	]	=	65		ZHUZAO_ID1	[	720	]	=	4034		ZHUZAO_ID2	[	720	]	=	1684		ZHUZAO_ID3	[	720	]	=	8318		ZHUZAO__Rad	[	720	]	=	1
	ZHUZAO_ID	[	721	]	=	8190		ZHUZAO_LV	[	721	]	=	65		ZHUZAO_ID1	[	721	]	=	4034		ZHUZAO_ID2	[	721	]	=	3994		ZHUZAO_ID3	[	721	]	=	2643		ZHUZAO__Rad	[	721	]	=	1
	ZHUZAO_ID	[	722	]	=	8191		ZHUZAO_LV	[	722	]	=	65		ZHUZAO_ID1	[	722	]	=	4034		ZHUZAO_ID2	[	722	]	=	1684		ZHUZAO_ID3	[	722	]	=	8318		ZHUZAO__Rad	[	722	]	=	1
	ZHUZAO_ID	[	723	]	=	8192		ZHUZAO_LV	[	723	]	=	65		ZHUZAO_ID1	[	723	]	=	4034		ZHUZAO_ID2	[	723	]	=	3994		ZHUZAO_ID3	[	723	]	=	2643		ZHUZAO__Rad	[	723	]	=	1
	ZHUZAO_ID	[	724	]	=	8193		ZHUZAO_LV	[	724	]	=	65		ZHUZAO_ID1	[	724	]	=	4034		ZHUZAO_ID2	[	724	]	=	1684		ZHUZAO_ID3	[	724	]	=	8318		ZHUZAO__Rad	[	724	]	=	1
	ZHUZAO_ID	[	725	]	=	8194		ZHUZAO_LV	[	725	]	=	65		ZHUZAO_ID1	[	725	]	=	4034		ZHUZAO_ID2	[	725	]	=	3994		ZHUZAO_ID3	[	725	]	=	2643		ZHUZAO__Rad	[	725	]	=	1
	ZHUZAO_ID	[	726	]	=	8195		ZHUZAO_LV	[	726	]	=	65		ZHUZAO_ID1	[	726	]	=	4034		ZHUZAO_ID2	[	726	]	=	1684		ZHUZAO_ID3	[	726	]	=	6532		ZHUZAO__Rad	[	726	]	=	1
	ZHUZAO_ID	[	727	]	=	8196		ZHUZAO_LV	[	727	]	=	65		ZHUZAO_ID1	[	727	]	=	4034		ZHUZAO_ID2	[	727	]	=	3994		ZHUZAO_ID3	[	727	]	=	2643		ZHUZAO__Rad	[	727	]	=	1
	ZHUZAO_ID	[	728	]	=	8197		ZHUZAO_LV	[	728	]	=	65		ZHUZAO_ID1	[	728	]	=	4034		ZHUZAO_ID2	[	728	]	=	1684		ZHUZAO_ID3	[	728	]	=	8318		ZHUZAO__Rad	[	728	]	=	1
	ZHUZAO_ID	[	729	]	=	8198		ZHUZAO_LV	[	729	]	=	65		ZHUZAO_ID1	[	729	]	=	4034		ZHUZAO_ID2	[	729	]	=	3994		ZHUZAO_ID3	[	729	]	=	2643		ZHUZAO__Rad	[	729	]	=	1
	ZHUZAO_ID	[	730	]	=	8199		ZHUZAO_LV	[	730	]	=	65		ZHUZAO_ID1	[	730	]	=	4034		ZHUZAO_ID2	[	730	]	=	1684		ZHUZAO_ID3	[	730	]	=	8318		ZHUZAO__Rad	[	730	]	=	1
	ZHUZAO_ID	[	731	]	=	8200		ZHUZAO_LV	[	731	]	=	65		ZHUZAO_ID1	[	731	]	=	4034		ZHUZAO_ID2	[	731	]	=	3994		ZHUZAO_ID3	[	731	]	=	2643		ZHUZAO__Rad	[	731	]	=	1
	ZHUZAO_ID	[	732	]	=	8201		ZHUZAO_LV	[	732	]	=	65		ZHUZAO_ID1	[	732	]	=	4034		ZHUZAO_ID2	[	732	]	=	1684		ZHUZAO_ID3	[	732	]	=	2643		ZHUZAO__Rad	[	732	]	=	1
	ZHUZAO_ID	[	733	]	=	8202		ZHUZAO_LV	[	733	]	=	70		ZHUZAO_ID1	[	733	]	=	4035		ZHUZAO_ID2	[	733	]	=	2419		ZHUZAO_ID3	[	733	]	=	8319		ZHUZAO__Rad	[	733	]	=	1
	ZHUZAO_ID	[	734	]	=	8203		ZHUZAO_LV	[	734	]	=	70		ZHUZAO_ID1	[	734	]	=	4035		ZHUZAO_ID2	[	734	]	=	3995		ZHUZAO_ID3	[	734	]	=	2644		ZHUZAO__Rad	[	734	]	=	1
	ZHUZAO_ID	[	735	]	=	8204		ZHUZAO_LV	[	735	]	=	70		ZHUZAO_ID1	[	735	]	=	4035		ZHUZAO_ID2	[	735	]	=	2419		ZHUZAO_ID3	[	735	]	=	2644		ZHUZAO__Rad	[	735	]	=	1
	ZHUZAO_ID	[	736	]	=	8205		ZHUZAO_LV	[	736	]	=	70		ZHUZAO_ID1	[	736	]	=	4035		ZHUZAO_ID2	[	736	]	=	3995		ZHUZAO_ID3	[	736	]	=	8319		ZHUZAO__Rad	[	736	]	=	1
	ZHUZAO_ID	[	737	]	=	8206		ZHUZAO_LV	[	737	]	=	70		ZHUZAO_ID1	[	737	]	=	4035		ZHUZAO_ID2	[	737	]	=	2419		ZHUZAO_ID3	[	737	]	=	2644		ZHUZAO__Rad	[	737	]	=	1
	ZHUZAO_ID	[	738	]	=	8207		ZHUZAO_LV	[	738	]	=	70		ZHUZAO_ID1	[	738	]	=	4035		ZHUZAO_ID2	[	738	]	=	3995		ZHUZAO_ID3	[	738	]	=	8319		ZHUZAO__Rad	[	738	]	=	1
	ZHUZAO_ID	[	739	]	=	8208		ZHUZAO_LV	[	739	]	=	70		ZHUZAO_ID1	[	739	]	=	4035		ZHUZAO_ID2	[	739	]	=	2419		ZHUZAO_ID3	[	739	]	=	8319		ZHUZAO__Rad	[	739	]	=	1
	ZHUZAO_ID	[	740	]	=	8209		ZHUZAO_LV	[	740	]	=	70		ZHUZAO_ID1	[	740	]	=	4035		ZHUZAO_ID2	[	740	]	=	3995		ZHUZAO_ID3	[	740	]	=	2644		ZHUZAO__Rad	[	740	]	=	1
	ZHUZAO_ID	[	741	]	=	8210		ZHUZAO_LV	[	741	]	=	70		ZHUZAO_ID1	[	741	]	=	4035		ZHUZAO_ID2	[	741	]	=	2419		ZHUZAO_ID3	[	741	]	=	2644		ZHUZAO__Rad	[	741	]	=	1
	ZHUZAO_ID	[	742	]	=	8211		ZHUZAO_LV	[	742	]	=	70		ZHUZAO_ID1	[	742	]	=	4035		ZHUZAO_ID2	[	742	]	=	3995		ZHUZAO_ID3	[	742	]	=	8319		ZHUZAO__Rad	[	742	]	=	1
	ZHUZAO_ID	[	743	]	=	8212		ZHUZAO_LV	[	743	]	=	70		ZHUZAO_ID1	[	743	]	=	4035		ZHUZAO_ID2	[	743	]	=	2419		ZHUZAO_ID3	[	743	]	=	2644		ZHUZAO__Rad	[	743	]	=	1
	ZHUZAO_ID	[	744	]	=	8213		ZHUZAO_LV	[	744	]	=	70		ZHUZAO_ID1	[	744	]	=	4035		ZHUZAO_ID2	[	744	]	=	3995		ZHUZAO_ID3	[	744	]	=	6532		ZHUZAO__Rad	[	744	]	=	1
	ZHUZAO_ID	[	745	]	=	8214		ZHUZAO_LV	[	745	]	=	70		ZHUZAO_ID1	[	745	]	=	4035		ZHUZAO_ID2	[	745	]	=	2419		ZHUZAO_ID3	[	745	]	=	8319		ZHUZAO__Rad	[	745	]	=	1
	ZHUZAO_ID	[	746	]	=	8215		ZHUZAO_LV	[	746	]	=	70		ZHUZAO_ID1	[	746	]	=	4035		ZHUZAO_ID2	[	746	]	=	3995		ZHUZAO_ID3	[	746	]	=	2644		ZHUZAO__Rad	[	746	]	=	1
	ZHUZAO_ID	[	747	]	=	8216		ZHUZAO_LV	[	747	]	=	70		ZHUZAO_ID1	[	747	]	=	4035		ZHUZAO_ID2	[	747	]	=	2419		ZHUZAO_ID3	[	747	]	=	2644		ZHUZAO__Rad	[	747	]	=	1
	ZHUZAO_ID	[	748	]	=	8217		ZHUZAO_LV	[	748	]	=	70		ZHUZAO_ID1	[	748	]	=	4035		ZHUZAO_ID2	[	748	]	=	3995		ZHUZAO_ID3	[	748	]	=	8319		ZHUZAO__Rad	[	748	]	=	1
	ZHUZAO_ID	[	749	]	=	8218		ZHUZAO_LV	[	749	]	=	70		ZHUZAO_ID1	[	749	]	=	4035		ZHUZAO_ID2	[	749	]	=	2419		ZHUZAO_ID3	[	749	]	=	8319		ZHUZAO__Rad	[	749	]	=	1
	ZHUZAO_ID	[	750	]	=	8219		ZHUZAO_LV	[	750	]	=	70		ZHUZAO_ID1	[	750	]	=	4035		ZHUZAO_ID2	[	750	]	=	3995		ZHUZAO_ID3	[	750	]	=	2644		ZHUZAO__Rad	[	750	]	=	1
	ZHUZAO_ID	[	751	]	=	8220		ZHUZAO_LV	[	751	]	=	70		ZHUZAO_ID1	[	751	]	=	4035		ZHUZAO_ID2	[	751	]	=	2419		ZHUZAO_ID3	[	751	]	=	2644		ZHUZAO__Rad	[	751	]	=	1
	ZHUZAO_ID	[	752	]	=	8221		ZHUZAO_LV	[	752	]	=	70		ZHUZAO_ID1	[	752	]	=	4035		ZHUZAO_ID2	[	752	]	=	3995		ZHUZAO_ID3	[	752	]	=	8319		ZHUZAO__Rad	[	752	]	=	1
	ZHUZAO_ID	[	753	]	=	8222		ZHUZAO_LV	[	753	]	=	70		ZHUZAO_ID1	[	753	]	=	4035		ZHUZAO_ID2	[	753	]	=	2419		ZHUZAO_ID3	[	753	]	=	2644		ZHUZAO__Rad	[	753	]	=	1
	ZHUZAO_ID	[	754	]	=	8223		ZHUZAO_LV	[	754	]	=	70		ZHUZAO_ID1	[	754	]	=	4035		ZHUZAO_ID2	[	754	]	=	3995		ZHUZAO_ID3	[	754	]	=	8318		ZHUZAO__Rad	[	754	]	=	1
	ZHUZAO_ID	[	755	]	=	8224		ZHUZAO_LV	[	755	]	=	70		ZHUZAO_ID1	[	755	]	=	4035		ZHUZAO_ID2	[	755	]	=	2419		ZHUZAO_ID3	[	755	]	=	8319		ZHUZAO__Rad	[	755	]	=	1
	ZHUZAO_ID	[	756	]	=	8225		ZHUZAO_LV	[	756	]	=	70		ZHUZAO_ID1	[	756	]	=	4035		ZHUZAO_ID2	[	756	]	=	3995		ZHUZAO_ID3	[	756	]	=	2644		ZHUZAO__Rad	[	756	]	=	1
	ZHUZAO_ID	[	757	]	=	8226		ZHUZAO_LV	[	757	]	=	70		ZHUZAO_ID1	[	757	]	=	4035		ZHUZAO_ID2	[	757	]	=	2419		ZHUZAO_ID3	[	757	]	=	2644		ZHUZAO__Rad	[	757	]	=	1
	ZHUZAO_ID	[	758	]	=	8227		ZHUZAO_LV	[	758	]	=	70		ZHUZAO_ID1	[	758	]	=	4035		ZHUZAO_ID2	[	758	]	=	3995		ZHUZAO_ID3	[	758	]	=	8319		ZHUZAO__Rad	[	758	]	=	1
	ZHUZAO_ID	[	759	]	=	8228		ZHUZAO_LV	[	759	]	=	70		ZHUZAO_ID1	[	759	]	=	4035		ZHUZAO_ID2	[	759	]	=	2419		ZHUZAO_ID3	[	759	]	=	2644		ZHUZAO__Rad	[	759	]	=	1
	ZHUZAO_ID	[	760	]	=	8229		ZHUZAO_LV	[	760	]	=	70		ZHUZAO_ID1	[	760	]	=	4035		ZHUZAO_ID2	[	760	]	=	3995		ZHUZAO_ID3	[	760	]	=	8319		ZHUZAO__Rad	[	760	]	=	1
	ZHUZAO_ID	[	761	]	=	8230		ZHUZAO_LV	[	761	]	=	70		ZHUZAO_ID1	[	761	]	=	4035		ZHUZAO_ID2	[	761	]	=	2419		ZHUZAO_ID3	[	761	]	=	2644		ZHUZAO__Rad	[	761	]	=	1
	ZHUZAO_ID	[	762	]	=	8231		ZHUZAO_LV	[	762	]	=	70		ZHUZAO_ID1	[	762	]	=	4035		ZHUZAO_ID2	[	762	]	=	3995		ZHUZAO_ID3	[	762	]	=	2644		ZHUZAO__Rad	[	762	]	=	1
	ZHUZAO_ID	[	763	]	=	8232		ZHUZAO_LV	[	763	]	=	70		ZHUZAO_ID1	[	763	]	=	4035		ZHUZAO_ID2	[	763	]	=	2419		ZHUZAO_ID3	[	763	]	=	8319		ZHUZAO__Rad	[	763	]	=	1
	ZHUZAO_ID	[	764	]	=	8233		ZHUZAO_LV	[	764	]	=	70		ZHUZAO_ID1	[	764	]	=	4035		ZHUZAO_ID2	[	764	]	=	3995		ZHUZAO_ID3	[	764	]	=	6532		ZHUZAO__Rad	[	764	]	=	1
	ZHUZAO_ID	[	765	]	=	8234		ZHUZAO_LV	[	765	]	=	70		ZHUZAO_ID1	[	765	]	=	4035		ZHUZAO_ID2	[	765	]	=	2419		ZHUZAO_ID3	[	765	]	=	2644		ZHUZAO__Rad	[	765	]	=	1
	ZHUZAO_ID	[	766	]	=	8235		ZHUZAO_LV	[	766	]	=	70		ZHUZAO_ID1	[	766	]	=	4035		ZHUZAO_ID2	[	766	]	=	3995		ZHUZAO_ID3	[	766	]	=	2644		ZHUZAO__Rad	[	766	]	=	1
	ZHUZAO_ID	[	767	]	=	8236		ZHUZAO_LV	[	767	]	=	70		ZHUZAO_ID1	[	767	]	=	4035		ZHUZAO_ID2	[	767	]	=	2419		ZHUZAO_ID3	[	767	]	=	8319		ZHUZAO__Rad	[	767	]	=	1
	ZHUZAO_ID	[	768	]	=	8237		ZHUZAO_LV	[	768	]	=	70		ZHUZAO_ID1	[	768	]	=	4035		ZHUZAO_ID2	[	768	]	=	3995		ZHUZAO_ID3	[	768	]	=	2644		ZHUZAO__Rad	[	768	]	=	1
	ZHUZAO_ID	[	769	]	=	8238		ZHUZAO_LV	[	769	]	=	70		ZHUZAO_ID1	[	769	]	=	4035		ZHUZAO_ID2	[	769	]	=	2419		ZHUZAO_ID3	[	769	]	=	8319		ZHUZAO__Rad	[	769	]	=	1
	ZHUZAO_ID	[	770	]	=	8239		ZHUZAO_LV	[	770	]	=	70		ZHUZAO_ID1	[	770	]	=	4035		ZHUZAO_ID2	[	770	]	=	3995		ZHUZAO_ID3	[	770	]	=	8319		ZHUZAO__Rad	[	770	]	=	1
	ZHUZAO_ID	[	771	]	=	8240		ZHUZAO_LV	[	771	]	=	70		ZHUZAO_ID1	[	771	]	=	4035		ZHUZAO_ID2	[	771	]	=	2419		ZHUZAO_ID3	[	771	]	=	2644		ZHUZAO__Rad	[	771	]	=	1
	ZHUZAO_ID	[	772	]	=	8241		ZHUZAO_LV	[	772	]	=	70		ZHUZAO_ID1	[	772	]	=	4035		ZHUZAO_ID2	[	772	]	=	3995		ZHUZAO_ID3	[	772	]	=	6532		ZHUZAO__Rad	[	772	]	=	1
	ZHUZAO_ID	[	773	]	=	8242		ZHUZAO_LV	[	773	]	=	70		ZHUZAO_ID1	[	773	]	=	4035		ZHUZAO_ID2	[	773	]	=	2419		ZHUZAO_ID3	[	773	]	=	8319		ZHUZAO__Rad	[	773	]	=	1
	ZHUZAO_ID	[	774	]	=	8243		ZHUZAO_LV	[	774	]	=	70		ZHUZAO_ID1	[	774	]	=	4035		ZHUZAO_ID2	[	774	]	=	3995		ZHUZAO_ID3	[	774	]	=	2644		ZHUZAO__Rad	[	774	]	=	1
	ZHUZAO_ID	[	775	]	=	8244		ZHUZAO_LV	[	775	]	=	70		ZHUZAO_ID1	[	775	]	=	4035		ZHUZAO_ID2	[	775	]	=	2419		ZHUZAO_ID3	[	775	]	=	2644		ZHUZAO__Rad	[	775	]	=	1
	ZHUZAO_ID	[	776	]	=	8245		ZHUZAO_LV	[	776	]	=	70		ZHUZAO_ID1	[	776	]	=	4035		ZHUZAO_ID2	[	776	]	=	3995		ZHUZAO_ID3	[	776	]	=	8319		ZHUZAO__Rad	[	776	]	=	1
	ZHUZAO_ID	[	777	]	=	8246		ZHUZAO_LV	[	777	]	=	70		ZHUZAO_ID1	[	777	]	=	4035		ZHUZAO_ID2	[	777	]	=	2419		ZHUZAO_ID3	[	777	]	=	2644		ZHUZAO__Rad	[	777	]	=	1
	ZHUZAO_ID	[	778	]	=	8247		ZHUZAO_LV	[	778	]	=	70		ZHUZAO_ID1	[	778	]	=	4035		ZHUZAO_ID2	[	778	]	=	3995		ZHUZAO_ID3	[	778	]	=	8319		ZHUZAO__Rad	[	778	]	=	1
	ZHUZAO_ID	[	779	]	=	8248		ZHUZAO_LV	[	779	]	=	70		ZHUZAO_ID1	[	779	]	=	4035		ZHUZAO_ID2	[	779	]	=	2419		ZHUZAO_ID3	[	779	]	=	8319		ZHUZAO__Rad	[	779	]	=	1
	ZHUZAO_ID	[	780	]	=	8249		ZHUZAO_LV	[	780	]	=	70		ZHUZAO_ID1	[	780	]	=	4035		ZHUZAO_ID2	[	780	]	=	3995		ZHUZAO_ID3	[	780	]	=	2644		ZHUZAO__Rad	[	780	]	=	1
	ZHUZAO_ID	[	781	]	=	8250		ZHUZAO_LV	[	781	]	=	70		ZHUZAO_ID1	[	781	]	=	4035		ZHUZAO_ID2	[	781	]	=	2419		ZHUZAO_ID3	[	781	]	=	2644		ZHUZAO__Rad	[	781	]	=	1
	ZHUZAO_ID	[	782	]	=	8251		ZHUZAO_LV	[	782	]	=	70		ZHUZAO_ID1	[	782	]	=	4035		ZHUZAO_ID2	[	782	]	=	3995		ZHUZAO_ID3	[	782	]	=	8319		ZHUZAO__Rad	[	782	]	=	1
	ZHUZAO_ID	[	783	]	=	8252		ZHUZAO_LV	[	783	]	=	70		ZHUZAO_ID1	[	783	]	=	4035		ZHUZAO_ID2	[	783	]	=	2419		ZHUZAO_ID3	[	783	]	=	2644		ZHUZAO__Rad	[	783	]	=	1
	ZHUZAO_ID	[	784	]	=	8253		ZHUZAO_LV	[	784	]	=	70		ZHUZAO_ID1	[	784	]	=	4035		ZHUZAO_ID2	[	784	]	=	3995		ZHUZAO_ID3	[	784	]	=	2644		ZHUZAO__Rad	[	784	]	=	1
	ZHUZAO_ID	[	785	]	=	8254		ZHUZAO_LV	[	785	]	=	70		ZHUZAO_ID1	[	785	]	=	4035		ZHUZAO_ID2	[	785	]	=	2419		ZHUZAO_ID3	[	785	]	=	8319		ZHUZAO__Rad	[	785	]	=	1
	ZHUZAO_ID	[	786	]	=	8255		ZHUZAO_LV	[	786	]	=	70		ZHUZAO_ID1	[	786	]	=	4035		ZHUZAO_ID2	[	786	]	=	3995		ZHUZAO_ID3	[	786	]	=	8319		ZHUZAO__Rad	[	786	]	=	1
	ZHUZAO_ID	[	787	]	=	8256		ZHUZAO_LV	[	787	]	=	70		ZHUZAO_ID1	[	787	]	=	4035		ZHUZAO_ID2	[	787	]	=	2419		ZHUZAO_ID3	[	787	]	=	2644		ZHUZAO__Rad	[	787	]	=	1
	ZHUZAO_ID	[	788	]	=	8257		ZHUZAO_LV	[	788	]	=	70		ZHUZAO_ID1	[	788	]	=	4035		ZHUZAO_ID2	[	788	]	=	3995		ZHUZAO_ID3	[	788	]	=	2644		ZHUZAO__Rad	[	788	]	=	1
	ZHUZAO_ID	[	789	]	=	8258		ZHUZAO_LV	[	789	]	=	70		ZHUZAO_ID1	[	789	]	=	4035		ZHUZAO_ID2	[	789	]	=	2419		ZHUZAO_ID3	[	789	]	=	8319		ZHUZAO__Rad	[	789	]	=	1
	ZHUZAO_ID	[	790	]	=	8259		ZHUZAO_LV	[	790	]	=	70		ZHUZAO_ID1	[	790	]	=	4035		ZHUZAO_ID2	[	790	]	=	3995		ZHUZAO_ID3	[	790	]	=	2644		ZHUZAO__Rad	[	790	]	=	1
	ZHUZAO_ID	[	791	]	=	8260		ZHUZAO_LV	[	791	]	=	70		ZHUZAO_ID1	[	791	]	=	4035		ZHUZAO_ID2	[	791	]	=	2419		ZHUZAO_ID3	[	791	]	=	8319		ZHUZAO__Rad	[	791	]	=	1
	ZHUZAO_ID	[	792	]	=	8261		ZHUZAO_LV	[	792	]	=	70		ZHUZAO_ID1	[	792	]	=	4035		ZHUZAO_ID2	[	792	]	=	3995		ZHUZAO_ID3	[	792	]	=	8319		ZHUZAO__Rad	[	792	]	=	1
	ZHUZAO_ID	[	793	]	=	8262		ZHUZAO_LV	[	793	]	=	70		ZHUZAO_ID1	[	793	]	=	4035		ZHUZAO_ID2	[	793	]	=	2419		ZHUZAO_ID3	[	793	]	=	2644		ZHUZAO__Rad	[	793	]	=	1
	ZHUZAO_ID	[	794	]	=	8263		ZHUZAO_LV	[	794	]	=	70		ZHUZAO_ID1	[	794	]	=	4035		ZHUZAO_ID2	[	794	]	=	3995		ZHUZAO_ID3	[	794	]	=	6532		ZHUZAO__Rad	[	794	]	=	1
	ZHUZAO_ID	[	795	]	=	8264		ZHUZAO_LV	[	795	]	=	70		ZHUZAO_ID1	[	795	]	=	4035		ZHUZAO_ID2	[	795	]	=	2419		ZHUZAO_ID3	[	795	]	=	8319		ZHUZAO__Rad	[	795	]	=	1
	ZHUZAO_ID	[	796	]	=	8265		ZHUZAO_LV	[	796	]	=	70		ZHUZAO_ID1	[	796	]	=	4035		ZHUZAO_ID2	[	796	]	=	3995		ZHUZAO_ID3	[	796	]	=	2644		ZHUZAO__Rad	[	796	]	=	1
	ZHUZAO_ID	[	797	]	=	8266		ZHUZAO_LV	[	797	]	=	70		ZHUZAO_ID1	[	797	]	=	4035		ZHUZAO_ID2	[	797	]	=	2419		ZHUZAO_ID3	[	797	]	=	8319		ZHUZAO__Rad	[	797	]	=	1
	ZHUZAO_ID	[	798	]	=	8267		ZHUZAO_LV	[	798	]	=	70		ZHUZAO_ID1	[	798	]	=	4035		ZHUZAO_ID2	[	798	]	=	3995		ZHUZAO_ID3	[	798	]	=	8319		ZHUZAO__Rad	[	798	]	=	1
	ZHUZAO_ID	[	799	]	=	8268		ZHUZAO_LV	[	799	]	=	70		ZHUZAO_ID1	[	799	]	=	4035		ZHUZAO_ID2	[	799	]	=	2419		ZHUZAO_ID3	[	799	]	=	2644		ZHUZAO__Rad	[	799	]	=	1
	ZHUZAO_ID	[	800	]	=	8269		ZHUZAO_LV	[	800	]	=	70		ZHUZAO_ID1	[	800	]	=	4035		ZHUZAO_ID2	[	800	]	=	3995		ZHUZAO_ID3	[	800	]	=	2644		ZHUZAO__Rad	[	800	]	=	1
	ZHUZAO_ID	[	801	]	=	8270		ZHUZAO_LV	[	801	]	=	70		ZHUZAO_ID1	[	801	]	=	4035		ZHUZAO_ID2	[	801	]	=	2419		ZHUZAO_ID3	[	801	]	=	8319		ZHUZAO__Rad	[	801	]	=	1
	ZHUZAO_ID	[	802	]	=	8271		ZHUZAO_LV	[	802	]	=	70		ZHUZAO_ID1	[	802	]	=	4035		ZHUZAO_ID2	[	802	]	=	3995		ZHUZAO_ID3	[	802	]	=	2644		ZHUZAO__Rad	[	802	]	=	1
	ZHUZAO_ID	[	803	]	=	8272		ZHUZAO_LV	[	803	]	=	70		ZHUZAO_ID1	[	803	]	=	4035		ZHUZAO_ID2	[	803	]	=	2419		ZHUZAO_ID3	[	803	]	=	8319		ZHUZAO__Rad	[	803	]	=	1
	ZHUZAO_ID	[	804	]	=	8273		ZHUZAO_LV	[	804	]	=	70		ZHUZAO_ID1	[	804	]	=	4035		ZHUZAO_ID2	[	804	]	=	3995		ZHUZAO_ID3	[	804	]	=	8319		ZHUZAO__Rad	[	804	]	=	1
	ZHUZAO_ID	[	805	]	=	8274		ZHUZAO_LV	[	805	]	=	70		ZHUZAO_ID1	[	805	]	=	4035		ZHUZAO_ID2	[	805	]	=	2419		ZHUZAO_ID3	[	805	]	=	2644		ZHUZAO__Rad	[	805	]	=	1
	ZHUZAO_ID	[	806	]	=	8275		ZHUZAO_LV	[	806	]	=	70		ZHUZAO_ID1	[	806	]	=	4035		ZHUZAO_ID2	[	806	]	=	3995		ZHUZAO_ID3	[	806	]	=	2644		ZHUZAO__Rad	[	806	]	=	1
	ZHUZAO_ID	[	807	]	=	8276		ZHUZAO_LV	[	807	]	=	70		ZHUZAO_ID1	[	807	]	=	4035		ZHUZAO_ID2	[	807	]	=	2419		ZHUZAO_ID3	[	807	]	=	8319		ZHUZAO__Rad	[	807	]	=	1
	ZHUZAO_ID	[	808	]	=	8277		ZHUZAO_LV	[	808	]	=	70		ZHUZAO_ID1	[	808	]	=	4035		ZHUZAO_ID2	[	808	]	=	3995		ZHUZAO_ID3	[	808	]	=	2644		ZHUZAO__Rad	[	808	]	=	1
	ZHUZAO_ID	[	809	]	=	8278		ZHUZAO_LV	[	809	]	=	70		ZHUZAO_ID1	[	809	]	=	4035		ZHUZAO_ID2	[	809	]	=	2419		ZHUZAO_ID3	[	809	]	=	8319		ZHUZAO__Rad	[	809	]	=	1
	ZHUZAO_ID	[	810	]	=	8279		ZHUZAO_LV	[	810	]	=	70		ZHUZAO_ID1	[	810	]	=	4035		ZHUZAO_ID2	[	810	]	=	3995		ZHUZAO_ID3	[	810	]	=	8319		ZHUZAO__Rad	[	810	]	=	1
	ZHUZAO_ID	[	811	]	=	8280		ZHUZAO_LV	[	811	]	=	70		ZHUZAO_ID1	[	811	]	=	4035		ZHUZAO_ID2	[	811	]	=	2419		ZHUZAO_ID3	[	811	]	=	8319		ZHUZAO__Rad	[	811	]	=	1
	ZHUZAO_ID	[	812	]	=	8281		ZHUZAO_LV	[	812	]	=	70		ZHUZAO_ID1	[	812	]	=	4035		ZHUZAO_ID2	[	812	]	=	3995		ZHUZAO_ID3	[	812	]	=	8319		ZHUZAO__Rad	[	812	]	=	1
	ZHUZAO_ID	[	813	]	=	8282		ZHUZAO_LV	[	813	]	=	70		ZHUZAO_ID1	[	813	]	=	4035		ZHUZAO_ID2	[	813	]	=	2419		ZHUZAO_ID3	[	813	]	=	2644		ZHUZAO__Rad	[	813	]	=	1
	ZHUZAO_ID	[	814	]	=	8283		ZHUZAO_LV	[	814	]	=	70		ZHUZAO_ID1	[	814	]	=	4035		ZHUZAO_ID2	[	814	]	=	3995		ZHUZAO_ID3	[	814	]	=	6532		ZHUZAO__Rad	[	814	]	=	1
	ZHUZAO_ID	[	815	]	=	8284		ZHUZAO_LV	[	815	]	=	70		ZHUZAO_ID1	[	815	]	=	4035		ZHUZAO_ID2	[	815	]	=	2419		ZHUZAO_ID3	[	815	]	=	8319		ZHUZAO__Rad	[	815	]	=	1
	ZHUZAO_ID	[	816	]	=	8285		ZHUZAO_LV	[	816	]	=	70		ZHUZAO_ID1	[	816	]	=	4035		ZHUZAO_ID2	[	816	]	=	3995		ZHUZAO_ID3	[	816	]	=	2644		ZHUZAO__Rad	[	816	]	=	1
	ZHUZAO_ID	[	817	]	=	8286		ZHUZAO_LV	[	817	]	=	70		ZHUZAO_ID1	[	817	]	=	4035		ZHUZAO_ID2	[	817	]	=	2419		ZHUZAO_ID3	[	817	]	=	8319		ZHUZAO__Rad	[	817	]	=	1
	ZHUZAO_ID	[	818	]	=	8287		ZHUZAO_LV	[	818	]	=	70		ZHUZAO_ID1	[	818	]	=	4035		ZHUZAO_ID2	[	818	]	=	3995		ZHUZAO_ID3	[	818	]	=	8319		ZHUZAO__Rad	[	818	]	=	1
	ZHUZAO_ID	[	819	]	=	8288		ZHUZAO_LV	[	819	]	=	70		ZHUZAO_ID1	[	819	]	=	4035		ZHUZAO_ID2	[	819	]	=	2419		ZHUZAO_ID3	[	819	]	=	2644		ZHUZAO__Rad	[	819	]	=	1
	ZHUZAO_ID	[	820	]	=	8289		ZHUZAO_LV	[	820	]	=	70		ZHUZAO_ID1	[	820	]	=	4035		ZHUZAO_ID2	[	820	]	=	3995		ZHUZAO_ID3	[	820	]	=	8319		ZHUZAO__Rad	[	820	]	=	1
	ZHUZAO_ID	[	821	]	=	8290		ZHUZAO_LV	[	821	]	=	70		ZHUZAO_ID1	[	821	]	=	4035		ZHUZAO_ID2	[	821	]	=	2419		ZHUZAO_ID3	[	821	]	=	8319		ZHUZAO__Rad	[	821	]	=	1
	ZHUZAO_ID	[	822	]	=	8291		ZHUZAO_LV	[	822	]	=	70		ZHUZAO_ID1	[	822	]	=	4035		ZHUZAO_ID2	[	822	]	=	3995		ZHUZAO_ID3	[	822	]	=	2644		ZHUZAO__Rad	[	822	]	=	1
	ZHUZAO_ID	[	823	]	=	8292		ZHUZAO_LV	[	823	]	=	70		ZHUZAO_ID1	[	823	]	=	4035		ZHUZAO_ID2	[	823	]	=	2419		ZHUZAO_ID3	[	823	]	=	2644		ZHUZAO__Rad	[	823	]	=	1
	ZHUZAO_ID	[	824	]	=	8293		ZHUZAO_LV	[	824	]	=	70		ZHUZAO_ID1	[	824	]	=	4035		ZHUZAO_ID2	[	824	]	=	3995		ZHUZAO_ID3	[	824	]	=	8319		ZHUZAO__Rad	[	824	]	=	1
	ZHUZAO_ID	[	825	]	=	8294		ZHUZAO_LV	[	825	]	=	70		ZHUZAO_ID1	[	825	]	=	4035		ZHUZAO_ID2	[	825	]	=	2419		ZHUZAO_ID3	[	825	]	=	2644		ZHUZAO__Rad	[	825	]	=	1
	ZHUZAO_ID	[	826	]	=	8295		ZHUZAO_LV	[	826	]	=	70		ZHUZAO_ID1	[	826	]	=	4035		ZHUZAO_ID2	[	826	]	=	3995		ZHUZAO_ID3	[	826	]	=	8319		ZHUZAO__Rad	[	826	]	=	1
	ZHUZAO_ID	[	827	]	=	8296		ZHUZAO_LV	[	827	]	=	70		ZHUZAO_ID1	[	827	]	=	4035		ZHUZAO_ID2	[	827	]	=	2419		ZHUZAO_ID3	[	827	]	=	8319		ZHUZAO__Rad	[	827	]	=	1
	ZHUZAO_ID	[	828	]	=	8297		ZHUZAO_LV	[	828	]	=	70		ZHUZAO_ID1	[	828	]	=	4035		ZHUZAO_ID2	[	828	]	=	3995		ZHUZAO_ID3	[	828	]	=	2644		ZHUZAO__Rad	[	828	]	=	1
	ZHUZAO_ID	[	829	]	=	8298		ZHUZAO_LV	[	829	]	=	70		ZHUZAO_ID1	[	829	]	=	4035		ZHUZAO_ID2	[	829	]	=	2419		ZHUZAO_ID3	[	829	]	=	8319		ZHUZAO__Rad	[	829	]	=	1
	ZHUZAO_ID	[	830	]	=	8299		ZHUZAO_LV	[	830	]	=	70		ZHUZAO_ID1	[	830	]	=	4035		ZHUZAO_ID2	[	830	]	=	3995		ZHUZAO_ID3	[	830	]	=	6532		ZHUZAO__Rad	[	830	]	=	1
	ZHUZAO_ID	[	831	]	=	8300		ZHUZAO_LV	[	831	]	=	70		ZHUZAO_ID1	[	831	]	=	4035		ZHUZAO_ID2	[	831	]	=	2419		ZHUZAO_ID3	[	831	]	=	2644		ZHUZAO__Rad	[	831	]	=	1
	ZHUZAO_ID	[	832	]	=	8301		ZHUZAO_LV	[	832	]	=	70		ZHUZAO_ID1	[	832	]	=	4035		ZHUZAO_ID2	[	832	]	=	3995		ZHUZAO_ID3	[	832	]	=	2644		ZHUZAO__Rad	[	832	]	=	1
	ZHUZAO_ID	[	833	]	=	8302		ZHUZAO_LV	[	833	]	=	70		ZHUZAO_ID1	[	833	]	=	4035		ZHUZAO_ID2	[	833	]	=	2419		ZHUZAO_ID3	[	833	]	=	8319		ZHUZAO__Rad	[	833	]	=	1
	ZHUZAO_ID	[	834	]	=	8303		ZHUZAO_LV	[	834	]	=	70		ZHUZAO_ID1	[	834	]	=	4035		ZHUZAO_ID2	[	834	]	=	3995		ZHUZAO_ID3	[	834	]	=	2644		ZHUZAO__Rad	[	834	]	=	1
	ZHUZAO_ID	[	835	]	=	8304		ZHUZAO_LV	[	835	]	=	70		ZHUZAO_ID1	[	835	]	=	4035		ZHUZAO_ID2	[	835	]	=	2419		ZHUZAO_ID3	[	835	]	=	6532		ZHUZAO__Rad	[	835	]	=	1
	ZHUZAO_ID	[	836	]	=	8305		ZHUZAO_LV	[	836	]	=	70		ZHUZAO_ID1	[	836	]	=	4035		ZHUZAO_ID2	[	836	]	=	3995		ZHUZAO_ID3	[	836	]	=	8319		ZHUZAO__Rad	[	836	]	=	1
	ZHUZAO_ID	[	837	]	=	860		ZHUZAO_LV	[	836	]	=	70		ZHUZAO_ID1	[	837	]	=	4035		ZHUZAO_ID2	[	837	]	=	2419		ZHUZAO_ID3	[	837	]	=	8319		ZHUZAO__Rad	[	837	]	=	1
	ZHUZAO_ID	[	838	]	=	861		ZHUZAO_LV	[	836	]	=	70		ZHUZAO_ID1	[	838	]	=	4035		ZHUZAO_ID2	[	838	]	=	2419		ZHUZAO_ID3	[	838	]	=	8319		ZHUZAO__Rad	[	838	]	=	1
	ZHUZAO_ID	[	839	]	=	862		ZHUZAO_LV	[	836	]	=	70		ZHUZAO_ID1	[	839	]	=	4035		ZHUZAO_ID2	[	839	]	=	2419		ZHUZAO_ID3	[	839	]	=	8319		ZHUZAO__Rad	[	839	]	=	1
	ZHUZAO_ID	[	840	]	=	863		ZHUZAO_LV	[	836	]	=	70		ZHUZAO_ID1	[	840	]	=	4035		ZHUZAO_ID2	[	840	]	=	2419		ZHUZAO_ID3	[	840	]	=	8319		ZHUZAO__Rad	[	840	]	=	1
	-- ZHUZAO_ID	[	841	]	=	112		ZHUZAO_LV	[	841	]	=	75		ZHUZAO_ID1	[	841	]	=	1363		ZHUZAO_ID2	[	841	]	=	1775		ZHUZAO_ID3	[	841	]	=	2601		ZHUZAO__Rad	[	841	]	=	1
	-- ZHUZAO_ID	[	842	]	=	2223		ZHUZAO_LV	[	842	]	=	75		ZHUZAO_ID1	[	842	]	=	1360		ZHUZAO_ID2	[	842	]	=	1734		ZHUZAO_ID3	[	842	]	=	2598		ZHUZAO__Rad	[	842	]	=	1
	-- ZHUZAO_ID	[	843	]	=	2219		ZHUZAO_LV	[	843	]	=	75		ZHUZAO_ID1	[	843	]	=	1363		ZHUZAO_ID2	[	843	]	=	1734		ZHUZAO_ID3	[	843	]	=	2601		ZHUZAO__Rad	[	843	]	=	1
	-- ZHUZAO_ID	[	844	]	=	2221		ZHUZAO_LV	[	844	]	=	75		ZHUZAO_ID1	[	844	]	=	1360		ZHUZAO_ID2	[	844	]	=	1734		ZHUZAO_ID3	[	844	]	=	2601		ZHUZAO__Rad	[	844	]	=	1
	-- ZHUZAO_ID	[	845	]	=	400		ZHUZAO_LV	[	845	]	=	75		ZHUZAO_ID1	[	845	]	=	1355		ZHUZAO_ID2	[	845	]	=	1734		ZHUZAO_ID3	[	845	]	=	2595		ZHUZAO__Rad	[	845	]	=	1
	-- ZHUZAO_ID	[	846	]	=	406		ZHUZAO_LV	[	846	]	=	75		ZHUZAO_ID1	[	846	]	=	1355		ZHUZAO_ID2	[	846	]	=	1734		ZHUZAO_ID3	[	846	]	=	2601		ZHUZAO__Rad	[	846	]	=	1
	-- ZHUZAO_ID	[	847	]	=	411		ZHUZAO_LV	[	847	]	=	75		ZHUZAO_ID1	[	847	]	=	1352		ZHUZAO_ID2	[	847	]	=	1734		ZHUZAO_ID3	[	847	]	=	2598		ZHUZAO__Rad	[	847	]	=	1
	-- ZHUZAO_ID	[	848	]	=	413		ZHUZAO_LV	[	848	]	=	75		ZHUZAO_ID1	[	848	]	=	3367		ZHUZAO_ID2	[	848	]	=	1734		ZHUZAO_ID3	[	848	]	=	2598		ZHUZAO__Rad	[	848	]	=	1
	-- ZHUZAO_ID	[	849	]	=	404		ZHUZAO_LV	[	849	]	=	75		ZHUZAO_ID1	[	849	]	=	3379		ZHUZAO_ID2	[	849	]	=	1734		ZHUZAO_ID3	[	849	]	=	2601		ZHUZAO__Rad	[	849	]	=	1
	-- ZHUZAO_ID	[	850	]	=	402		ZHUZAO_LV	[	850	]	=	75		ZHUZAO_ID1	[	850	]	=	4038		ZHUZAO_ID2	[	850	]	=	1734		ZHUZAO_ID3	[	850	]	=	2601		ZHUZAO__Rad	[	850	]	=	1
	-- ZHUZAO_ID	[	851	]	=	408		ZHUZAO_LV	[	851	]	=	75		ZHUZAO_ID1	[	851	]	=	4047		ZHUZAO_ID2	[	851	]	=	1734		ZHUZAO_ID3	[	851	]	=	2601		ZHUZAO__Rad	[	851	]	=	1
	-- ZHUZAO_ID	[	852	]	=	396		ZHUZAO_LV	[	852	]	=	75		ZHUZAO_ID1	[	852	]	=	4037		ZHUZAO_ID2	[	852	]	=	1734		ZHUZAO_ID3	[	852	]	=	2592		ZHUZAO__Rad	[	852	]	=	1
	-- ZHUZAO_ID	[	853	]	=	590		ZHUZAO_LV	[	853	]	=	75		ZHUZAO_ID1	[	853	]	=	1674		ZHUZAO_ID2	[	853	]	=	1734		ZHUZAO_ID3	[	853	]	=	2595		ZHUZAO__Rad	[	853	]	=	1
	-- ZHUZAO_ID	[	854	]	=	600		ZHUZAO_LV	[	854	]	=	75		ZHUZAO_ID1	[	854	]	=	4038		ZHUZAO_ID2	[	854	]	=	1734		ZHUZAO_ID3	[	854	]	=	2598		ZHUZAO__Rad	[	854	]	=	1
	-- ZHUZAO_ID	[	855	]	=	596		ZHUZAO_LV	[	855	]	=	75		ZHUZAO_ID1	[	855	]	=	2901		ZHUZAO_ID2	[	855	]	=	1734		ZHUZAO_ID3	[	855	]	=	2601		ZHUZAO__Rad	[	855	]	=	1
	-- ZHUZAO_ID	[	856	]	=	602		ZHUZAO_LV	[	856	]	=	75		ZHUZAO_ID1	[	856	]	=	4832		ZHUZAO_ID2	[	856	]	=	1734		ZHUZAO_ID3	[	856	]	=	2598		ZHUZAO__Rad	[	856	]	=	1
	-- ZHUZAO_ID	[	857	]	=	588		ZHUZAO_LV	[	857	]	=	75		ZHUZAO_ID1	[	857	]	=	4048		ZHUZAO_ID2	[	857	]	=	1734		ZHUZAO_ID3	[	857	]	=	2592		ZHUZAO__Rad	[	857	]	=	1
	-- ZHUZAO_ID	[	858	]	=	594		ZHUZAO_LV	[	858	]	=	75		ZHUZAO_ID1	[	858	]	=	4832		ZHUZAO_ID2	[	858	]	=	1734		ZHUZAO_ID3	[	858	]	=	2601		ZHUZAO__Rad	[	858	]	=	1
	-- ZHUZAO_ID	[	859	]	=	604		ZHUZAO_LV	[	859	]	=	75		ZHUZAO_ID1	[	859	]	=	4048		ZHUZAO_ID2	[	859	]	=	1734		ZHUZAO_ID3	[	859	]	=	2592		ZHUZAO__Rad	[	859	]	=	1
	-- ZHUZAO_ID	[	860	]	=	592		ZHUZAO_LV	[	860	]	=	75		ZHUZAO_ID1	[	860	]	=	4047		ZHUZAO_ID2	[	860	]	=	1734		ZHUZAO_ID3	[	860	]	=	2601		ZHUZAO__Rad	[	860	]	=	1
	-- ZHUZAO_ID	[	861	]	=	598		ZHUZAO_LV	[	861	]	=	75		ZHUZAO_ID1	[	861	]	=	1674		ZHUZAO_ID2	[	861	]	=	1734		ZHUZAO_ID3	[	861	]	=	2601		ZHUZAO__Rad	[	861	]	=	1
	-- ZHUZAO_ID	[	862	]	=	760		ZHUZAO_LV	[	862	]	=	75		ZHUZAO_ID1	[	862	]	=	4037		ZHUZAO_ID2	[	862	]	=	4756		ZHUZAO_ID3	[	862	]	=	2598		ZHUZAO__Rad	[	862	]	=	1
	-- ZHUZAO_ID	[	863	]	=	756		ZHUZAO_LV	[	863	]	=	75		ZHUZAO_ID1	[	863	]	=	4038		ZHUZAO_ID2	[	863	]	=	4756		ZHUZAO_ID3	[	863	]	=	2601		ZHUZAO__Rad	[	863	]	=	1
	-- ZHUZAO_ID	[	864	]	=	824		ZHUZAO_LV	[	864	]	=	75		ZHUZAO_ID1	[	864	]	=	1360		ZHUZAO_ID2	[	864	]	=	4756		ZHUZAO_ID3	[	864	]	=	2598		ZHUZAO__Rad	[	864	]	=	1
	-- ZHUZAO_ID	[	865	]	=	750		ZHUZAO_LV	[	865	]	=	75		ZHUZAO_ID1	[	865	]	=	1352		ZHUZAO_ID2	[	865	]	=	1712		ZHUZAO_ID3	[	865	]	=	2595		ZHUZAO__Rad	[	865	]	=	1
	-- ZHUZAO_ID	[	866	]	=	748		ZHUZAO_LV	[	866	]	=	75		ZHUZAO_ID1	[	866	]	=	4037		ZHUZAO_ID2	[	866	]	=	4993		ZHUZAO_ID3	[	866	]	=	2592		ZHUZAO__Rad	[	866	]	=	1
	-- ZHUZAO_ID	[	867	]	=	830		ZHUZAO_LV	[	867	]	=	75		ZHUZAO_ID1	[	867	]	=	1780		ZHUZAO_ID2	[	867	]	=	4756		ZHUZAO_ID3	[	867	]	=	2592		ZHUZAO__Rad	[	867	]	=	1
	-- ZHUZAO_ID	[	868	]	=	754		ZHUZAO_LV	[	868	]	=	75		ZHUZAO_ID1	[	868	]	=	4037		ZHUZAO_ID2	[	868	]	=	1712		ZHUZAO_ID3	[	868	]	=	2601		ZHUZAO__Rad	[	868	]	=	1
	-- ZHUZAO_ID	[	869	]	=	752		ZHUZAO_LV	[	869	]	=	75		ZHUZAO_ID1	[	869	]	=	1363		ZHUZAO_ID2	[	869	]	=	4993		ZHUZAO_ID3	[	869	]	=	2601		ZHUZAO__Rad	[	869	]	=	1
	-- ZHUZAO_ID	[	870	]	=	758		ZHUZAO_LV	[	870	]	=	75		ZHUZAO_ID1	[	870	]	=	2901		ZHUZAO_ID2	[	870	]	=	4993		ZHUZAO_ID3	[	870	]	=	2601		ZHUZAO__Rad	[	870	]	=	1
	-- ZHUZAO_ID	[	871	]	=	398		ZHUZAO_LV	[	871	]	=	75		ZHUZAO_ID1	[	871	]	=	4832		ZHUZAO_ID2	[	871	]	=	1734		ZHUZAO_ID3	[	871	]	=	2592		ZHUZAO__Rad	[	871	]	=	1
	-- ZHUZAO_ID	[	872	]	=	2368		ZHUZAO_LV	[	872	]	=	75		ZHUZAO_ID1	[	872	]	=	4038		ZHUZAO_ID2	[	872	]	=	1712		ZHUZAO_ID3	[	872	]	=	2665		ZHUZAO__Rad	[	872	]	=	1
	-- ZHUZAO_ID	[	873	]	=	1098		ZHUZAO_LV	[	873	]	=	75		ZHUZAO_ID1	[	873	]	=	1626		ZHUZAO_ID2	[	873	]	=	1703		ZHUZAO_ID3	[	873	]	=	2665		ZHUZAO__Rad	[	873	]	=	1
	-- ZHUZAO_ID	[	874	]	=	1111		ZHUZAO_LV	[	874	]	=	75		ZHUZAO_ID1	[	874	]	=	1626		ZHUZAO_ID2	[	874	]	=	1703		ZHUZAO_ID3	[	874	]	=	2665		ZHUZAO__Rad	[	874	]	=	1
	-- ZHUZAO_ID	[	875	]	=	1104		ZHUZAO_LV	[	875	]	=	75		ZHUZAO_ID1	[	875	]	=	1626		ZHUZAO_ID2	[	875	]	=	1621		ZHUZAO_ID3	[	875	]	=	2665		ZHUZAO__Rad	[	875	]	=	1
	-- ZHUZAO_ID	[	876	]	=	1114		ZHUZAO_LV	[	876	]	=	75		ZHUZAO_ID1	[	876	]	=	2490		ZHUZAO_ID2	[	876	]	=	1734		ZHUZAO_ID3	[	876	]	=	2665		ZHUZAO__Rad	[	876	]	=	1
	-- ZHUZAO_ID	[	877	]	=	1107		ZHUZAO_LV	[	877	]	=	75		ZHUZAO_ID1	[	877	]	=	2490		ZHUZAO_ID2	[	877	]	=	1621		ZHUZAO_ID3	[	877	]	=	2665		ZHUZAO__Rad	[	877	]	=	1
	-- ZHUZAO_ID	[	878	]	=	1101		ZHUZAO_LV	[	878	]	=	75		ZHUZAO_ID1	[	878	]	=	2490		ZHUZAO_ID2	[	878	]	=	3385		ZHUZAO_ID3	[	878	]	=	2665		ZHUZAO__Rad	[	878	]	=	1
	-- ZHUZAO_ID	[	879	]	=	1108		ZHUZAO_LV	[	879	]	=	75		ZHUZAO_ID1	[	879	]	=	2490		ZHUZAO_ID2	[	879	]	=	1734		ZHUZAO_ID3	[	879	]	=	2665		ZHUZAO__Rad	[	879	]	=	1
	-- ZHUZAO_ID	[	880	]	=	2369		ZHUZAO_LV	[	880	]	=	75		ZHUZAO_ID1	[	880	]	=	2490		ZHUZAO_ID2	[	880	]	=	1734		ZHUZAO_ID3	[	880	]	=	2665		ZHUZAO__Rad	[	880	]	=	1
	-- ZHUZAO_ID	[	881	]	=	2553		ZHUZAO_LV	[	881	]	=	75		ZHUZAO_ID1	[	881	]	=	4048		ZHUZAO_ID2	[	881	]	=	1703		ZHUZAO_ID3	[	881	]	=	2665		ZHUZAO__Rad	[	881	]	=	1
	-- ZHUZAO_ID	[	882	]	=	2370		ZHUZAO_LV	[	882	]	=	75		ZHUZAO_ID1	[	882	]	=	4047		ZHUZAO_ID2	[	882	]	=	1621		ZHUZAO_ID3	[	882	]	=	2665		ZHUZAO__Rad	[	882	]	=	1
	-- ZHUZAO_ID	[	883	]	=	1102		ZHUZAO_LV	[	883	]	=	75		ZHUZAO_ID1	[	883	]	=	1674		ZHUZAO_ID2	[	883	]	=	1703		ZHUZAO_ID3	[	883	]	=	2665		ZHUZAO__Rad	[	883	]	=	1
	-- ZHUZAO_ID	[	884	]	=	1109		ZHUZAO_LV	[	884	]	=	75		ZHUZAO_ID1	[	884	]	=	4037		ZHUZAO_ID2	[	884	]	=	4756		ZHUZAO_ID3	[	884	]	=	2665		ZHUZAO__Rad	[	884	]	=	1
	-- ZHUZAO_ID	[	885	]	=	2367		ZHUZAO_LV	[	885	]	=	75		ZHUZAO_ID1	[	885	]	=	4038		ZHUZAO_ID2	[	885	]	=	1621		ZHUZAO_ID3	[	885	]	=	2665		ZHUZAO__Rad	[	885	]	=	1
	-- ZHUZAO_ID	[	886	]	=	2371		ZHUZAO_LV	[	886	]	=	75		ZHUZAO_ID1	[	886	]	=	1360		ZHUZAO_ID2	[	886	]	=	1621		ZHUZAO_ID3	[	886	]	=	2665		ZHUZAO__Rad	[	886	]	=	1
	-- ZHUZAO_ID	[	887	]	=	1103		ZHUZAO_LV	[	887	]	=	75		ZHUZAO_ID1	[	887	]	=	1352		ZHUZAO_ID2	[	887	]	=	1621		ZHUZAO_ID3	[	887	]	=	2665		ZHUZAO__Rad	[	887	]	=	1
	-- ZHUZAO_ID	[	888	]	=	1110		ZHUZAO_LV	[	888	]	=	75		ZHUZAO_ID1	[	888	]	=	4037		ZHUZAO_ID2	[	888	]	=	1621		ZHUZAO_ID3	[	888	]	=	2665		ZHUZAO__Rad	[	888	]	=	1
	-- ZHUZAO_ID	[	889	]	=	1100		ZHUZAO_LV	[	889	]	=	75		ZHUZAO_ID1	[	889	]	=	1780		ZHUZAO_ID2	[	889	]	=	1621		ZHUZAO_ID3	[	889	]	=	2665		ZHUZAO__Rad	[	889	]	=	1
	-- ZHUZAO_ID	[	890	]	=	1106		ZHUZAO_LV	[	890	]	=	75		ZHUZAO_ID1	[	890	]	=	4037		ZHUZAO_ID2	[	890	]	=	1734		ZHUZAO_ID3	[	890	]	=	2665		ZHUZAO__Rad	[	890	]	=	1
	--ZHUZAO_ID	[	891	]	=	8306		ZHUZAO_LV	[	891	]	=	80		ZHUZAO_ID1	[	891	]	=	4037		ZHUZAO_ID2	[	891	]	=	4038		ZHUZAO_ID3	[	891	]	=	8320		ZHUZAO__Rad	[	891	]	=	1
	--ZHUZAO_ID	[	892	]	=	8308		ZHUZAO_LV	[	892	]	=	80		ZHUZAO_ID1	[	892	]	=	4037		ZHUZAO_ID2	[	892	]	=	1758		ZHUZAO_ID3	[	892	]	=	8320		ZHUZAO__Rad	[	892	]	=	1
	ZHUZAO_ID	[	893	]	=	8307		ZHUZAO_LV	[	893	]	=	80		ZHUZAO_ID1	[	893	]	=	4037		ZHUZAO_ID2	[	893	]	=	4038		ZHUZAO_ID3	[	893	]	=	8320		ZHUZAO__Rad	[	893	]	=	1
	ZHUZAO_ID	[	894	]	=	8309		ZHUZAO_LV	[	894	]	=	80		ZHUZAO_ID1	[	894	]	=	4037		ZHUZAO_ID2	[	894	]	=	2649		ZHUZAO_ID3	[	894	]	=	8320		ZHUZAO__Rad	[	894	]	=	1
	ZHUZAO_ID	[	895	]	=	8310		ZHUZAO_LV	[	895	]	=	80		ZHUZAO_ID1	[	895	]	=	4036		ZHUZAO_ID2	[	895	]	=	2649		ZHUZAO_ID3	[	895	]	=	8320		ZHUZAO__Rad	[	895	]	=	1
	ZHUZAO_ID	[	896	]	=	8311		ZHUZAO_LV	[	896	]	=	80		ZHUZAO_ID1	[	896	]	=	4036		ZHUZAO_ID2	[	896	]	=	2649		ZHUZAO_ID3	[	896	]	=	8320		ZHUZAO__Rad	[	896	]	=	1
	ZHUZAO_ID	[	897	]	=	8312		ZHUZAO_LV	[	897	]	=	80		ZHUZAO_ID1	[	897	]	=	4036		ZHUZAO_ID2	[	897	]	=	4037		ZHUZAO_ID3	[	897	]	=	8320		ZHUZAO__Rad	[	897	]	=	1
	ZHUZAO_ID	[	898	]	=	8313		ZHUZAO_LV	[	898	]	=	80		ZHUZAO_ID1	[	898	]	=	4036		ZHUZAO_ID2	[	898	]	=	2649		ZHUZAO_ID3	[	898	]	=	8320		ZHUZAO__Rad	[	898	]	=	1
	ZHUZAO_ID	[	899	]	=	8314		ZHUZAO_LV	[	899	]	=	80		ZHUZAO_ID1	[	899	]	=	4036		ZHUZAO_ID2	[	899	]	=	3997		ZHUZAO_ID3	[	899	]	=	8320		ZHUZAO__Rad	[	899	]	=	1
	ZHUZAO_ID	[	900	]	=	8315		ZHUZAO_LV	[	900	]	=	80		ZHUZAO_ID1	[	900	]	=	4036		ZHUZAO_ID2	[	900	]	=	2649		ZHUZAO_ID3	[	900	]	=	8320		ZHUZAO__Rad	[	900	]	=	1
	ZHUZAO_ID	[	901	]	=	8316		ZHUZAO_LV	[	901	]	=	80		ZHUZAO_ID1	[	901	]	=	4036		ZHUZAO_ID2	[	901	]	=	1758		ZHUZAO_ID3	[	901	]	=	8320		ZHUZAO__Rad	[	901	]	=	1
	ZHUZAO_ID	[	902	]	=	8317		ZHUZAO_LV	[	902	]	=	80		ZHUZAO_ID1	[	902	]	=	4036		ZHUZAO_ID2	[	902	]	=	2649		ZHUZAO_ID3	[	902	]	=	8320		ZHUZAO__Rad	[	902	]	=	1
	ZHUZAO_ID	[	903	]	=	866		ZHUZAO_LV	[	903	]	=	80		ZHUZAO_ID1	[	903	]	=	4036		ZHUZAO_ID2	[	903	]	=	2649		ZHUZAO_ID3	[	903	]	=	8320		ZHUZAO__Rad	[	903	]	=	1
	--ZHUZAO_ID	[	904	]	=	865		ZHUZAO_LV	[	904	]	=	80		ZHUZAO_ID1	[	904	]	=	4036		ZHUZAO_ID2	[	904	]	=	4037		ZHUZAO_ID3	[	904	]	=	8320		ZHUZAO__Rad	[	904	]	=	1
	--ZHUZAO_ID	[	905	]	=	864		ZHUZAO_LV	[	905	]	=	80		ZHUZAO_ID1	[	905	]	=	4036		ZHUZAO_ID2	[	905	]	=	1758		ZHUZAO_ID3	[	905	]	=	8320		ZHUZAO__Rad	[	905	]	=	1
	ZHUZAO_ID	[	906	]	=	8715			ZHUZAO_LV	[	906	]	=	80		ZHUZAO_ID1	[	906	]	=	4036		ZHUZAO_ID2	[	906	]	=	2649		ZHUZAO_ID3	[	906	]	=	8320		ZHUZAO__Rad	[	906	]	=	1
	ZHUZAO_ID	[	907	]	=	8447			ZHUZAO_LV	[	907	]	=	80		ZHUZAO_ID1	[	907	]	=	4036		ZHUZAO_ID2	[	907	]	=	2649		ZHUZAO_ID3	[	907	]	=	8320		ZHUZAO__Rad	[	907	]	=	1
	ZHUZAO_ID	[	908	]	=	8451			ZHUZAO_LV	[	908	]	=	80		ZHUZAO_ID1	[	908	]	=	4036		ZHUZAO_ID2	[	908	]	=	2649		ZHUZAO_ID3	[	908	]	=	8320		ZHUZAO__Rad	[	908	]	=	1
	ZHUZAO_ID	[	909	]	=	8455			ZHUZAO_LV	[	909	]	=	80		ZHUZAO_ID1	[	909	]	=	4036		ZHUZAO_ID2	[	909	]	=	2649		ZHUZAO_ID3	[	909	]	=	8320		ZHUZAO__Rad	[	909	]	=	1
	ZHUZAO_ID	[	910	]	=	8459			ZHUZAO_LV	[	910	]	=	80		ZHUZAO_ID1	[	910	]	=	4036		ZHUZAO_ID2	[	910	]	=	2649		ZHUZAO_ID3	[	910	]	=	8320		ZHUZAO__Rad	[	910	]	=	1
	ZHUZAO_ID	[	911	]	=	8463			ZHUZAO_LV	[	911	]	=	80		ZHUZAO_ID1	[	911	]	=	4036		ZHUZAO_ID2	[	911	]	=	2649		ZHUZAO_ID3	[	911	]	=	8320		ZHUZAO__Rad	[	911	]	=	1
	ZHUZAO_ID	[	912	]	=	8467			ZHUZAO_LV	[	912	]	=	80		ZHUZAO_ID1	[	912	]	=	4036		ZHUZAO_ID2	[	912	]	=	2649		ZHUZAO_ID3	[	912	]	=	8320		ZHUZAO__Rad	[	912	]	=	1
	ZHUZAO_ID	[	913	]	=	8471			ZHUZAO_LV	[	913	]	=	80		ZHUZAO_ID1	[	913	]	=	4036		ZHUZAO_ID2	[	913	]	=	2649		ZHUZAO_ID3	[	913	]	=	8320		ZHUZAO__Rad	[	913	]	=	1
	
		
																																	
																																									
--	烹饪																																								
--	物品质量							宝箱物品上限																																	
	PENGREN_Qua	=	5	 				PENGREN_Mxcount	=	40																															
	PENGREN_ID	=	{}					PENGREN_LV	=	{}					PENGREN_ID1	=	{}					PENGREN_ID2	=	{}					PENGREN_ID3	=	{}					PENGREN__Rad	=	{}			
	PENGREN_ID	[	1	]	=	1848		PENGREN_LV	[	1	]	=	0		PENGREN_ID1	[	1	]	=	4315		PENGREN_ID2	[	1	]	=	4397		PENGREN_ID3	[	1	]	=	3116		PENGREN__Rad	[	1	]	=	1
	PENGREN_ID	[	2	]	=	3133		PENGREN_LV	[	2	]	=	0		PENGREN_ID1	[	2	]	=	4315		PENGREN_ID2	[	2	]	=	4397		PENGREN_ID3	[	2	]	=	3116		PENGREN__Rad	[	2	]	=	1
	PENGREN_ID	[	3	]	=	4019		PENGREN_LV	[	3	]	=	10		PENGREN_ID1	[	3	]	=	4009		PENGREN_ID2	[	3	]	=	1847		PENGREN_ID3	[	3	]	=	3116		PENGREN__Rad	[	3	]	=	1
	PENGREN_ID	[	4	]	=	6532		PENGREN_LV	[	4	]	=	10		PENGREN_ID1	[	4	]	=	4009		PENGREN_ID2	[	4	]	=	1847		PENGREN_ID3	[	4	]	=	3116		PENGREN__Rad	[	4	]	=	1
	PENGREN_ID	[	5	]	=	6532		PENGREN_LV	[	5	]	=	10		PENGREN_ID1	[	5	]	=	4009		PENGREN_ID2	[	5	]	=	1847		PENGREN_ID3	[	5	]	=	3116		PENGREN__Rad	[	5	]	=	1
	PENGREN_ID	[	6	]	=	3134		PENGREN_LV	[	6	]	=	10		PENGREN_ID1	[	6	]	=	4315		PENGREN_ID2	[	6	]	=	1847		PENGREN_ID3	[	6	]	=	3116		PENGREN__Rad	[	6	]	=	1
	PENGREN_ID	[	7	]	=	3135		PENGREN_LV	[	7	]	=	10		PENGREN_ID1	[	7	]	=	4009		PENGREN_ID2	[	7	]	=	1847		PENGREN_ID3	[	7	]	=	3116		PENGREN__Rad	[	7	]	=	1
	PENGREN_ID	[	8	]	=	4020		PENGREN_LV	[	8	]	=	20		PENGREN_ID1	[	8	]	=	4010		PENGREN_ID2	[	8	]	=	1847		PENGREN_ID3	[	8	]	=	3116		PENGREN__Rad	[	8	]	=	1
	PENGREN_ID	[	9	]	=	6532		PENGREN_LV	[	9	]	=	20		PENGREN_ID1	[	9	]	=	4010		PENGREN_ID2	[	9	]	=	1847		PENGREN_ID3	[	9	]	=	3116		PENGREN__Rad	[	9	]	=	1
	PENGREN_ID	[	10	]	=	6532		PENGREN_LV	[	10	]	=	20		PENGREN_ID1	[	10	]	=	4010		PENGREN_ID2	[	10	]	=	1847		PENGREN_ID3	[	10	]	=	3116		PENGREN__Rad	[	10	]	=	1
	PENGREN_ID	[	11	]	=	3136		PENGREN_LV	[	11	]	=	20		PENGREN_ID1	[	11	]	=	4010		PENGREN_ID2	[	11	]	=	1847		PENGREN_ID3	[	11	]	=	3116		PENGREN__Rad	[	11	]	=	1
	PENGREN_ID	[	12	]	=	3137		PENGREN_LV	[	12	]	=	20		PENGREN_ID1	[	12	]	=	4010		PENGREN_ID2	[	12	]	=	1847		PENGREN_ID3	[	12	]	=	3116		PENGREN__Rad	[	12	]	=	1
	PENGREN_ID	[	13	]	=	4021		PENGREN_LV	[	13	]	=	30		PENGREN_ID1	[	13	]	=	4011		PENGREN_ID2	[	13	]	=	1847		PENGREN_ID3	[	13	]	=	3116		PENGREN__Rad	[	13	]	=	1
	PENGREN_ID	[	14	]	=	3125		PENGREN_LV	[	14	]	=	30		PENGREN_ID1	[	14	]	=	4011		PENGREN_ID2	[	14	]	=	1847		PENGREN_ID3	[	14	]	=	3116		PENGREN__Rad	[	14	]	=	1
	PENGREN_ID	[	15	]	=	3126		PENGREN_LV	[	15	]	=	30		PENGREN_ID1	[	15	]	=	4011		PENGREN_ID2	[	15	]	=	1847		PENGREN_ID3	[	15	]	=	3116		PENGREN__Rad	[	15	]	=	1
	PENGREN_ID	[	16	]	=	3138		PENGREN_LV	[	16	]	=	30		PENGREN_ID1	[	16	]	=	4011		PENGREN_ID2	[	16	]	=	1847		PENGREN_ID3	[	16	]	=	3116		PENGREN__Rad	[	16	]	=	1
	PENGREN_ID	[	17	]	=	3139		PENGREN_LV	[	17	]	=	30		PENGREN_ID1	[	17	]	=	4011		PENGREN_ID2	[	17	]	=	1847		PENGREN_ID3	[	17	]	=	3116		PENGREN__Rad	[	17	]	=	1
	PENGREN_ID	[	18	]	=	4022		PENGREN_LV	[	18	]	=	40		PENGREN_ID1	[	18	]	=	4012		PENGREN_ID2	[	18	]	=	1848		PENGREN_ID3	[	18	]	=	3116		PENGREN__Rad	[	18	]	=	1
	PENGREN_ID	[	19	]	=	1078		PENGREN_LV	[	19	]	=	40		PENGREN_ID1	[	19	]	=	4012		PENGREN_ID2	[	19	]	=	1848		PENGREN_ID3	[	19	]	=	3116		PENGREN__Rad	[	19	]	=	1
	PENGREN_ID	[	20	]	=	1079		PENGREN_LV	[	20	]	=	40		PENGREN_ID1	[	20	]	=	4012		PENGREN_ID2	[	20	]	=	1848		PENGREN_ID3	[	20	]	=	3116		PENGREN__Rad	[	20	]	=	1
	PENGREN_ID	[	21	]	=	1084		PENGREN_LV	[	21	]	=	40		PENGREN_ID1	[	21	]	=	4012		PENGREN_ID2	[	21	]	=	1848		PENGREN_ID3	[	21	]	=	3116		PENGREN__Rad	[	21	]	=	1
	PENGREN_ID	[	22	]	=	1085		PENGREN_LV	[	22	]	=	40		PENGREN_ID1	[	22	]	=	4012		PENGREN_ID2	[	22	]	=	1848		PENGREN_ID3	[	22	]	=	3116		PENGREN__Rad	[	22	]	=	1
	PENGREN_ID	[	23	]	=	3127		PENGREN_LV	[	23	]	=	40		PENGREN_ID1	[	23	]	=	4012		PENGREN_ID2	[	23	]	=	1848		PENGREN_ID3	[	23	]	=	3116		PENGREN__Rad	[	23	]	=	1
	PENGREN_ID	[	24	]	=	3128		PENGREN_LV	[	24	]	=	40		PENGREN_ID1	[	24	]	=	4012		PENGREN_ID2	[	24	]	=	1848		PENGREN_ID3	[	24	]	=	3116		PENGREN__Rad	[	24	]	=	1
	PENGREN_ID	[	25	]	=	3099		PENGREN_LV	[	25	]	=	40		PENGREN_ID1	[	25	]	=	4012		PENGREN_ID2	[	25	]	=	1848		PENGREN_ID3	[	25	]	=	3116		PENGREN__Rad	[	25	]	=	1
	PENGREN_ID	[	26	]	=	3140		PENGREN_LV	[	26	]	=	40		PENGREN_ID1	[	26	]	=	4012		PENGREN_ID2	[	26	]	=	1848		PENGREN_ID3	[	26	]	=	3116		PENGREN__Rad	[	26	]	=	1
	PENGREN_ID	[	27	]	=	4023		PENGREN_LV	[	27	]	=	50		PENGREN_ID1	[	27	]	=	4013		PENGREN_ID2	[	27	]	=	1849		PENGREN_ID3	[	27	]	=	2617		PENGREN__Rad	[	27	]	=	1
	PENGREN_ID	[	28	]	=	1080		PENGREN_LV	[	28	]	=	50		PENGREN_ID1	[	28	]	=	4013		PENGREN_ID2	[	28	]	=	1849		PENGREN_ID3	[	28	]	=	2617		PENGREN__Rad	[	28	]	=	1
	PENGREN_ID	[	29	]	=	1082		PENGREN_LV	[	29	]	=	50		PENGREN_ID1	[	29	]	=	4013		PENGREN_ID2	[	29	]	=	1849		PENGREN_ID3	[	29	]	=	2617		PENGREN__Rad	[	29	]	=	1
	PENGREN_ID	[	30	]	=	1088		PENGREN_LV	[	30	]	=	50		PENGREN_ID1	[	30	]	=	4013		PENGREN_ID2	[	30	]	=	1849		PENGREN_ID3	[	30	]	=	2617		PENGREN__Rad	[	30	]	=	1
	PENGREN_ID	[	31	]	=	1087		PENGREN_LV	[	31	]	=	50		PENGREN_ID1	[	31	]	=	4013		PENGREN_ID2	[	31	]	=	1849		PENGREN_ID3	[	31	]	=	2617		PENGREN__Rad	[	31	]	=	1
	PENGREN_ID	[	32	]	=	4024		PENGREN_LV	[	32	]	=	60		PENGREN_ID1	[	32	]	=	4014		PENGREN_ID2	[	32	]	=	1849		PENGREN_ID3	[	32	]	=	2619		PENGREN__Rad	[	32	]	=	1
	PENGREN_ID	[	33	]	=	1083		PENGREN_LV	[	33	]	=	60		PENGREN_ID1	[	33	]	=	4014		PENGREN_ID2	[	33	]	=	1849		PENGREN_ID3	[	33	]	=	2619		PENGREN__Rad	[	33	]	=	1
	PENGREN_ID	[	34	]	=	1089		PENGREN_LV	[	34	]	=	60		PENGREN_ID1	[	34	]	=	4014		PENGREN_ID2	[	34	]	=	1849		PENGREN_ID3	[	34	]	=	2619		PENGREN__Rad	[	34	]	=	1
	PENGREN_ID	[	35	]	=	1090		PENGREN_LV	[	35	]	=	60		PENGREN_ID1	[	35	]	=	4014		PENGREN_ID2	[	35	]	=	1849		PENGREN_ID3	[	35	]	=	2619		PENGREN__Rad	[	35	]	=	1
	PENGREN_ID	[	36	]	=	4025		PENGREN_LV	[	36	]	=	70		PENGREN_ID1	[	36	]	=	4015		PENGREN_ID2	[	36	]	=	6533		PENGREN_ID3	[	36	]	=	2622		PENGREN__Rad	[	36	]	=	1
	PENGREN_ID	[	37	]	=	4026		PENGREN_LV	[	37	]	=	70		PENGREN_ID1	[	37	]	=	4016		PENGREN_ID2	[	37	]	=	6533		PENGREN_ID3	[	37	]	=	2622		PENGREN__Rad	[	37	]	=	1
	PENGREN_ID	[	38	]	=	4027		PENGREN_LV	[	38	]	=	70		PENGREN_ID1	[	38	]	=	4017		PENGREN_ID2	[	38	]	=	6533		PENGREN_ID3	[	38	]	=	2622		PENGREN__Rad	[	38	]	=	1
	PENGREN_ID	[	39	]	=	4028		PENGREN_LV	[	39	]	=	80		PENGREN_ID1	[	39	]	=	4018		PENGREN_ID2	[	39	]	=	6533		PENGREN_ID3	[	39	]	=	2624		PENGREN__Rad	[	39	]	=	1
	--PENGREN_ID	[	40	]	=	1860		PENGREN_LV	[	40	]	=	80		PENGREN_ID1	[	40	]	=	4018		PENGREN_ID2	[	40	]	=	6533		PENGREN_ID3	[	40	]	=	2624		PENGREN__Rad	[	40	]	=	1
    PENGREN_ID	[	41	]	=	8714		PENGREN_LV	[	41	]	=	80		PENGREN_ID1	[	41	]	=	4017		PENGREN_ID2	[	41	]	=	6533		PENGREN_ID3	[	41	]	=	2624		PENGREN__Rad	[	41	]	=	1
	PENGREN_ID	[	42	]	=	8446		PENGREN_LV	[	42	]	=	80		PENGREN_ID1	[	42	]	=	4017		PENGREN_ID2	[	42	]	=	6533		PENGREN_ID3	[	42	]	=	2624		PENGREN__Rad	[	42	]	=	1
	PENGREN_ID	[	43	]	=	8450		PENGREN_LV	[	43	]	=	80		PENGREN_ID1	[	43	]	=	4017		PENGREN_ID2	[	43	]	=	6533		PENGREN_ID3	[	43	]	=	2624		PENGREN__Rad	[	43	]	=	1
	PENGREN_ID	[	44	]	=	8454		PENGREN_LV	[	44	]	=	80		PENGREN_ID1	[	44	]	=	4017		PENGREN_ID2	[	44	]	=	6533		PENGREN_ID3	[	44	]	=	2624		PENGREN__Rad	[	44	]	=	1
	PENGREN_ID	[	45	]	=	8458		PENGREN_LV	[	45	]	=	80		PENGREN_ID1	[	45	]	=	4017		PENGREN_ID2	[	45	]	=	6533		PENGREN_ID3	[	45	]	=	2624		PENGREN__Rad	[	45	]	=	1
	PENGREN_ID	[	46	]	=	8462		PENGREN_LV	[	46	]	=	80		PENGREN_ID1	[	46	]	=	4017		PENGREN_ID2	[	46	]	=	6533		PENGREN_ID3	[	46	]	=	2624		PENGREN__Rad	[	46	]	=	1
	PENGREN_ID	[	47	]	=	8466		PENGREN_LV	[	47	]	=	80		PENGREN_ID1	[	47	]	=	4017		PENGREN_ID2	[	47	]	=	6533		PENGREN_ID3	[	47	]	=	2624		PENGREN__Rad	[	47	]	=	1
	PENGREN_ID	[	48	]	=	8470		PENGREN_LV	[	48	]	=	80		PENGREN_ID1	[	48	]	=	4017		PENGREN_ID2	[	48	]	=	6533		PENGREN_ID3	[	48	]	=	2624		PENGREN__Rad	[	48	]	=	1


--------------------测试宝箱开除道具的ID
A1	=	1849
A2 	=	1849
A3 	=	1849
A4 	=	1849
A5 	=	1849
A6 	=	1849
A7 	=	1849
A8 	=	1849
A9 	=	1849
A10	=	1849
A11	=	1849
A12	=	1849
A13	=	1849
A14	=	1849
A15	=	1849
A16	=	1849
A17	=	1849
A18	=	1849
A19	=	1849
A20	=	1849
A21	=	1849
A22	=	1849
A23	=	1849
A24	=	1849

--------------------测试宝箱开除对应ID道具的数量
B1	=	1 
B2 	=	1 
B3 	=	1 
B4 	=	1 
B5 	=	1 
B6 	=	1 
B7 	=	1 
B8 	=	1 
B9 	=	1 
B10	=	1 
B11	=	1 
B12	=	1 
B13	=	1 
B14	=	1 
B15	=	1 
B16	=	1 
B17	=	1 
B18	=	1 
B19	=	1 
B20	=	1 
B21	=	1 
B22	=	1 
B23	=	1 
B24	=	1 
---------------------------------超级精灵宝箱精灵ID
C1=183
---------------------------------超级精灵宝箱精灵属性
N1=5
N2=5
N3=5
N4=5
N5=5
--------------------------------超级精灵宝箱精灵体力

--------------------------------超级精灵宝箱精灵成长度

---------------------------------阴阳五行轮回塔内容ID
SI=183
---------------------------------阴阳五行轮回塔内容数量
SN=1
--------------------------------阴阳五行轮回塔属性
SA1=5
SA2=5
SA3=5
SA4=5
SA5=5
------------------------------阴阳五行轮回塔颜色与能量
SE=15			-----绿色
--SE=2			-----灰色
--SE=12			-----白色
--SE=13			-----白色
--SE=14			-----绿色
--SE=15			-----绿色
--SE=16			-----紫色
--SE=17			-----紫色
--SE=18			-----红色
--SE=19			-----红色
--SE=20			-----红得发紫
-----------------------石头记
STONE_ID				=		0878
STONE_LV				=		2



---宝石类型编号 				-- 宝石效果类型				---宝石可精炼道具类型 ( 0为结束 )						--宝石效果信息				--宝石对应属性类型
StoneTpye_ID_Num = 48			StoneEff_Num = 48	StoneAttrType_Num = 48	
StoneTpye_ID = {}	StoneEffType = {}	StoneItemType ={}	StoneEff = {}	StoneAttrType= {}	
StoneTpye_ID[0] = 0	StoneEffType[0] = 0	StoneItemType[0] ={ 0 }	StoneEff[0] =0	StoneAttrType[0] =0   	
StoneTpye_ID[1] = 878	StoneEffType[1] = 1	StoneItemType[1] ={ 1,0 }	StoneEff[1] =4	StoneAttrType[1] =ITEMATTR_VAL_MNATK      	--烈炎石
StoneTpye_ID[2] = 879	StoneEffType[2] = 1	StoneItemType[2] ={ 2,3,7,9,0 }	StoneEff[2] =6	StoneAttrType[2] =ITEMATTR_VAL_MNATK      	--炙焰石
StoneTpye_ID[3] = 880	StoneEffType[3] = 1	StoneItemType[3] ={ 4,0 }	StoneEff[3] =10	StoneAttrType[3] =ITEMATTR_VAL_MNATK      	--火药石
StoneTpye_ID[4] = 881	StoneEffType[4] = 1	StoneItemType[4] ={ 1,2,3,4,7,9,23,0 }	StoneEff[4] =5	StoneAttrType[4] =ITEMATTR_VAL_HIT        	--玛瑙石
StoneTpye_ID[5] = 882	StoneEffType[5] = 2	StoneItemType[5] ={ 11,22,27,0 }	StoneEff[5] =5	StoneAttrType[5] =ITEMATTR_VAL_DEF        	--寒玉
StoneTpye_ID[6] = 883	StoneEffType[6] = 2	StoneItemType[6] ={ 11,22,27,0 }	StoneEff[6] =100	StoneAttrType[6] =ITEMATTR_VAL_MXHP       	--月之心
StoneTpye_ID[7] = 884	StoneEffType[7] = 2	StoneItemType[7] ={ 1,2,3,4,7,9,24,0 }	StoneEff[7] =2	StoneAttrType[7] =ITEMATTR_VAL_FLEE       	--仙灵石
StoneTpye_ID[8] = 887	StoneEffType[8] = 4	StoneItemType[8] ={ 1,2,3,4,7,9,24,0 }	StoneEff[8] =1	StoneAttrType[8] =ITEMATTR_VAL_STA        	--圣光石
StoneTpye_ID[9] = 860	StoneEffType[9] = 4	StoneItemType[9] ={ 24,0 }	StoneEff[9] =5	StoneAttrType[9] =ITEMATTR_VAL_AGI        	--风灵石
StoneTpye_ID[10] = 861	StoneEffType[10] = 4	StoneItemType[10] ={ 23,0 }	StoneEff[10] =5	StoneAttrType[10] =ITEMATTR_VAL_DEX        	--鹰眼石
StoneTpye_ID[11] = 862	StoneEffType[11] = 4	StoneItemType[11] ={ 11,22,27,0 }	StoneEff[11] =5	StoneAttrType[11] =ITEMATTR_VAL_CON        	--岩玉
StoneTpye_ID[12] = 863	StoneEffType[12] = 4	StoneItemType[12] ={ 1,2,3,4,7,9,0 }	StoneEff[12] =5	StoneAttrType[12] =ITEMATTR_VAL_STR        	--炎玉
StoneTpye_ID[13] = 864	StoneEffType[13] = 1	StoneItemType[13] ={ 1,2,3,4,7,9,0 }	StoneEff[13] =50	StoneAttrType[13] =ITEMATTR_VAL_MNATK      	--黑龙之瞳
StoneTpye_ID[14] = 865	StoneEffType[14] = 2	StoneItemType[14] ={ 11,22,27,0 }	StoneEff[14] =3	StoneAttrType[14] =ITEMATTR_VAL_PDEF       	--黑龙之魂
StoneTpye_ID[15] = 866	StoneEffType[15] = 2	StoneItemType[15] ={ 23,24,0 }	StoneEff[15] =500	StoneAttrType[15] =ITEMATTR_VAL_MXHP       	--黑龙之心
StoneTpye_ID[16] = 1012	StoneEffType[16] = 4	StoneItemType[16] ={ 1,2,3,4,7,9,0 }	StoneEff[16] =5	StoneAttrType[16] =ITEMATTR_VAL_STA        	--加纳之神
StoneTpye_ID[17] = 5750	StoneEffType[17] = 2	StoneItemType[17] ={ 20,0 }	StoneEff[17] =10	StoneAttrType[17] =ITEMATTR_VAL_DEF        	--黄玉
StoneTpye_ID[18] = 5751	StoneEffType[18] = 2	StoneItemType[18] ={ 20,0 }	StoneEff[18] =200	StoneAttrType[18] =ITEMATTR_VAL_MXHP       	--赤玉
StoneTpye_ID[19] = 5752	StoneEffType[19] = 2	StoneItemType[19] ={ 20,0 }	StoneEff[19] =200	StoneAttrType[19] =ITEMATTR_VAL_MXSP       	--青玉
StoneTpye_ID[20] = 5771	StoneEffType[20] = 1	StoneItemType[20] ={ 20,0 }	StoneEff[20] =10	StoneAttrType[20] =ITEMATTR_VAL_CRT        	--夏天之灵光
StoneTpye_ID[21] = 5772	StoneEffType[21] = 1	StoneItemType[21] ={ 23,0 }	StoneEff[21] =10	StoneAttrType[21] =ITEMATTR_VAL_HIT        	--洛克之必中
StoneTpye_ID[22] = 5773	StoneEffType[22] = 2	StoneItemType[22] ={ 24,0 }	StoneEff[22] =10	StoneAttrType[22] =ITEMATTR_VAL_FLEE       	--冰冰之躲闪
StoneTpye_ID[23] = 5774	StoneEffType[23] = 2	StoneItemType[23] ={ 22,0 }	StoneEff[23] =15	StoneAttrType[23] =ITEMATTR_VAL_DEF        	--丰烽之抵御
StoneTpye_ID[24] = 5775	StoneEffType[24] = 4	StoneItemType[24] ={ 22,11,0 }	StoneEff[24] =300	StoneAttrType[24] =ITEMATTR_VAL_MXHP       	--夏克之强化
StoneTpye_ID[25] = 5845	StoneEffType[25] = 1	StoneItemType[25] ={ 1,2,3,4,7,9,0 }	StoneEff[25] =8	StoneAttrType[25] =ITEMATTR_VAL_STR        	--死神辉耀
StoneTpye_ID[26] = 5846	StoneEffType[26] = 2	StoneItemType[26] ={ 22,27,0 }	StoneEff[26] =8	StoneAttrType[26] =ITEMATTR_VAL_CON        	--死神不死
StoneTpye_ID[27] = 5847	StoneEffType[27] = 1	StoneItemType[27] ={ 1,2,3,4,7,9,22,27,0 }	StoneEff[27] =8	StoneAttrType[27] =ITEMATTR_VAL_STA        	--死神光芒
StoneTpye_ID[28] = 5848	StoneEffType[28] = 1	StoneItemType[28] ={ 1,2,3,4,7,9,23,0 }	StoneEff[28] =8	StoneAttrType[28] =ITEMATTR_VAL_DEX        	--死神凝聚
StoneTpye_ID[29] = 5849	StoneEffType[29] = 4	StoneItemType[29] ={ 24,0 }	StoneEff[29] =8	StoneAttrType[29] =ITEMATTR_VAL_AGI        	--死神旋舞
StoneTpye_ID[30] = 5878	StoneEffType[30] = 1	StoneItemType[30] ={ 1,2,3,4,7,9,0 }	StoneEff[30] =50	StoneAttrType[30] =ITEMATTR_VAL_PDEF       	--阿波罗的精神
StoneTpye_ID[31] = 5879	StoneEffType[31] = 2	StoneItemType[31] ={ 11,22,27,0 }	StoneEff[31] =3	StoneAttrType[31] =ITEMATTR_VAL_MXHP       	--丘比特的精神
StoneTpye_ID[32] = 5880	StoneEffType[32] = 2	StoneItemType[32] ={ 23,24,0 }	StoneEff[32] =500	StoneAttrType[32] =ITEMATTR_VAL_STA        	--雅典娜的精神
StoneTpye_ID[33] = 6718	StoneEffType[33] = 2	StoneItemType[33] ={ 22,27,0 }	StoneEff[33] =1	StoneAttrType[33] =ITEMATTR_VAL_CON        	--试炼之体质宝石
StoneTpye_ID[34] = 6817	StoneEffType[34] = 4	StoneItemType[34] ={ 24,0 }	StoneEff[34] =2	StoneAttrType[34] =ITEMATTR_VAL_AGI        	--黑琉石
StoneTpye_ID[35] = 6818	StoneEffType[35] = 4	StoneItemType[35] ={ 24,0 }	StoneEff[35] =3	StoneAttrType[35] =ITEMATTR_VAL_AGI        	--黑莹石
StoneTpye_ID[36] = 6819	StoneEffType[36] = 4	StoneItemType[36] ={ 24,0 }	StoneEff[36] =4	StoneAttrType[36] =ITEMATTR_VAL_AGI        	--黑晶石
StoneTpye_ID[37] = 6820	StoneEffType[37] = 4	StoneItemType[37] ={ 23,0 }	StoneEff[37] =2	StoneAttrType[37] =ITEMATTR_VAL_DEX        	--白琉石
StoneTpye_ID[38] = 6821	StoneEffType[38] = 4	StoneItemType[38] ={ 23,0 }	StoneEff[38] =3	StoneAttrType[38] =ITEMATTR_VAL_DEX        	--白莹石
StoneTpye_ID[39] = 6822	StoneEffType[39] = 4	StoneItemType[39] ={ 23,0 }	StoneEff[39] =4	StoneAttrType[39] =ITEMATTR_VAL_DEX        	--白晶石
StoneTpye_ID[40] = 6823	StoneEffType[40] = 4	StoneItemType[40] ={ 11,22,27,0 }	StoneEff[40] =2	StoneAttrType[40] =ITEMATTR_VAL_CON        	--赤琉石
StoneTpye_ID[41] = 6824	StoneEffType[41] = 4	StoneItemType[41] ={ 11,22,27,0 }	StoneEff[41] =3	StoneAttrType[41] =ITEMATTR_VAL_CON        	--赤莹石
StoneTpye_ID[42] = 6825	StoneEffType[42] = 4	StoneItemType[42] ={ 11,22,27,0 }	StoneEff[42] =4	StoneAttrType[42] =ITEMATTR_VAL_CON        	--赤晶石
StoneTpye_ID[43] = 6826	StoneEffType[43] = 4	StoneItemType[43] ={ 1,2,3,4,7,9,0 }	StoneEff[43] =2	StoneAttrType[43] =ITEMATTR_VAL_STR        	--紫琉石
StoneTpye_ID[44] = 6827	StoneEffType[44] = 4	StoneItemType[44] ={ 1,2,3,4,7,9,0 }	StoneEff[44] =3	StoneAttrType[44] =ITEMATTR_VAL_STR        	--紫莹石
StoneTpye_ID[45] = 6828	StoneEffType[45] = 4	StoneItemType[45] ={ 1,2,3,4,7,9,0 }	StoneEff[45] =4	StoneAttrType[45] =ITEMATTR_VAL_STR        	--紫晶石
StoneTpye_ID[46] = 6829	StoneEffType[46] = 4	StoneItemType[46] ={ 1,2,3,4,7,9,0 }	StoneEff[46] =2	StoneAttrType[46] =ITEMATTR_VAL_STA        	--青琉石
StoneTpye_ID[47] = 6830	StoneEffType[47] = 4	StoneItemType[47] ={ 1,2,3,4,7,9,0 }	StoneEff[47] =3	StoneAttrType[47] =ITEMATTR_VAL_STA        	--青莹石
StoneTpye_ID[48] = 6831	StoneEffType[48] = 4	StoneItemType[48] ={ 1,2,3,4,7,9,0 }	StoneEff[48] =4	StoneAttrType[48] =ITEMATTR_VAL_STA        	--青晶石
StoneTpye_ID[49] = 8423	StoneEffType[49] = 2	StoneItemType[49] ={ 1,2,3,4,7,9,24,0 }	StoneEff[49] =5	StoneAttrType[49] =ITEMATTR_VAL_FLEE       	--五彩晶石

--荣誉值限制最小值
RYZ_Rongyu_Min = -300
RYZ_Rongyu_Max = 30000

--普通怪物
UnNormalMonster_Num =		13
UnNormalMonster_ID = { }
UnNormalMonster_ID [0]	=	1
UnNormalMonster_ID [1]	=	2
UnNormalMonster_ID [2]	=	3
UnNormalMonster_ID [3]	=	4
UnNormalMonster_ID [4]	=	728
UnNormalMonster_ID [5]	=	729
UnNormalMonster_ID [6]	=	730
UnNormalMonster_ID [7]	=	731
UnNormalMonster_ID [8]	=	739
UnNormalMonster_ID [9]	=	740
UnNormalMonster_ID [10]	=	742
UnNormalMonster_ID [11]	=	743
UnNormalMonster_ID [12]	=	744
UnNormalMonster_ID [13]	=	745

--PK岛关闭计数-----------
PK_Win_CountNum		=	60

----------------------------------------------------------------------------------------------------
--PK岛需要删除的道具
PK_BagItemDelCheckNum = 6
PK_BagItemDelCheck_ID = { }
PK_BagItemDelCheck_ID [0] = 1854
PK_BagItemDelCheck_ID [1] = 1855
PK_BagItemDelCheck_ID [2] = 1856
PK_BagItemDelCheck_ID [3] = 1857
PK_BagItemDelCheck_ID [4] = 1858
PK_BagItemDelCheck_ID [5] = 1859
PK_BagItemDelCheck_ID [6] = 1860
--PK_BagItemDelCheck_ID [7] = 4661



--圣战关闭-----------
SZ_Win_CountNum		=	60
SZ_Win_CountNum2	=	60
GUILDNOTICE = 6
GUILDCLOSESHOW = {}
GUILDCLOSESHOW[1] = 900
GUILDCLOSESHOW[2] = 600
GUILDCLOSESHOW[3] = 300
GUILDCLOSESHOW[4] = 180
GUILDCLOSESHOW[5] = 120
GUILDCLOSESHOW[6] = 60
GUILDWARCLOSETIME = 10800

GUILDNOTICE2 = 6
GUILDCLOSESHOW2 = {}
GUILDCLOSESHOW2[1] = 900
GUILDCLOSESHOW2[2] = 600
GUILDCLOSESHOW2[3] = 300
GUILDCLOSESHOW2[4] = 180
GUILDCLOSESHOW2[5] = 120
GUILDCLOSESHOW2[6] = 60
GUILDWARCLOSETIME2 = 10800

 


--退出圣战地图会删除的道具
SZ_BagItemDelCheckNum = 4
SZ_BagItemDelCheck_ID = { }
SZ_BagItemDelCheck_ID [0] = 4661
SZ_BagItemDelCheck_ID [1] = 2964
SZ_BagItemDelCheck_ID [2] = 3001
SZ_BagItemDelCheck_ID [3] = 2381 ---守护神召唤券




--死神攻略中要删除的道具--死神专属部分开始
SS_BagItemDelCheckNum = 2
SS_BagItemDelCheck_ID = { }
SS_BagItemDelCheck_ID [1] = 1855		--进入永恒地狱的门票
SS_BagItemDelCheck_ID [2] = 1856		--杀死神必须使用的道具

CRY = {}
CRY[5]=0
CRY[6]=0
CRY[7]=0
CRY[8]=0
CRY[9]=0
CRY[10]=0
CRY[11]=0
CRY[12]=0
CRY[13]=0
CRY[14]=0
CRY[15]=0
CRY[16]=0
CRY[17]=0
CRY[18]=0
CRY[19]=0

AZRAEL = {}
AZRAEL[5]=0
AZRAEL[6]=0
AZRAEL[7]=0
AZRAEL[8]=0
AZRAEL[9]=0
AZRAEL[10]=0
AZRAEL[11]=0
AZRAEL[12]=0
AZRAEL[13]=0
AZRAEL[14]=0
AZRAEL[15]=0
AZRAEL[16]=0
AZRAEL[17]=0
AZRAEL[18]=0
AZRAEL[19]=0

SUMMON = {}
SUMMON[1]=0
SUMMON[2]=0
SUMMON[3]=0
SUMMON[4]=0
SUMMON[5]=0

HELLCLOSETIME = 300
MAXNOTICE = 17
NOTICETIME = {}
NOTICETIME[1] = 300
NOTICETIME[2] = 240
NOTICETIME[3] = 180
NOTICETIME[4] = 120
NOTICETIME[5] = 60
NOTICETIME[6] = 30
NOTICETIME[7] = 15
NOTICETIME[8] = 10
NOTICETIME[9] = 9
NOTICETIME[10] = 8
NOTICETIME[11] = 7
NOTICETIME[12] = 6
NOTICETIME[13] = 5
NOTICETIME[14] = 4
NOTICETIME[15] = 3
NOTICETIME[16] = 2
NOTICETIME[17] = 1

--死神专属部分


--道具实例化事件类型
NPC_SALE				=	0	--npc买卖
MONSTER_BAOLIAO		=	1	--怪物暴料
PLAYER_HECHENG		=	2	--玩家合成
QUEST_AWARD_1		=	3	--任务获取1
QUEST_AWARD_2		=	4	--任务获取2
QUEST_AWARD_3		=	5	--任务获取3
QUEST_AWARD_4		=	6	--任务获取4
QUEST_AWARD_5		=	7	--任务获取5
QUEST_AWARD_6		=	8	--任务获取6
QUEST_AWARD_7		=	9	--任务获取7
QUEST_AWARD_8		=	10	--任务获取8
PLAYER_XSBOX			=	11	--新手宝箱

PLAYER_CCFSBOXA		=	12
PLAYER_CCFSBOXB		=	13
PLAYER_CCFSBOXC		=	14
PLAYER_CCFSBOXD		=	15
PLAYER_CCFSBOXE		=	16
PLAYER_CCFSBOXF 		=	17
PLAYER_CCFSBOXG		=	18
PLAYER_CCFSBOXH		=	19
PLAYER_CCFSBOXI		=	20
PLAYER_ZSITEM			=	22	--紫色装备
PLAYER_HSSR			=	23	--黑市商人
PLAYER_HSSRA			=	24	--黑市商人A

ATTRRESET = 27
QUEST_AWARD_GODBOX	=	94	--效果等同商城箱子但开出物品无槽                                                  --------------kokora
QUEST_AWARD_SCBOX	=	95	--商城箱子
QUEST_AWARD_SDJ		=	96	--圣诞换取礼品
QUEST_AWARD_RYZ		=	97	--荣誉证获得
QUEST_AWARD_WZX		=	98	--职业任务宝箱
QUEST_AWARD_RAND		=	99	--随机职业任务




--附加属性套装名称对应————————————————————————————————————

ITEMSERIES_DRAGON		=  1							--巨龙套装（力量）
ITEMSERIES_TAITAN       =  2							--泰坦套装（体质）
ITEMSERIES_HUNTER      =  3							--猎手套装（专注）
ITEMSERIES_DELIVER      =  4							--信使套装（敏捷）
ITEMSERIES_HOLY   =  5							--神圣套装（精神）

--附加属性概率—————————————————————————————————————————

Itemattr_Baoliao  =  { }





--道具品质随机概率——————————————————————————————————————————————————————————

Item_Baoliao = { }									--怪物暴料 --从最高级品质开始随机，高级物品优先，相邻等级的数值差值为实际概率
Item_Baoliao [0]		=		0						--
Item_Baoliao [1]		=		0						--
Item_Baoliao [2]		=		0						--
Item_Baoliao [3]		=		0						--
Item_Baoliao [4]		=		0						--
Item_Baoliao [5]		=		1						--神喻之...
Item_Baoliao [6]		=		5						--王者之...	
Item_Baoliao [7]		=		10						--统帅之...
Item_Baoliao [8]		=		40						--卓越之...
Item_Baoliao [9]		=		80						--普通型...

Item_Attr_0 = { }					
Item_Attr_0 [0]		=		0						--5个附加属性
Item_Attr_0 [1]		=		0						--4个附加属性
Item_Attr_0 [2]		=		1						--3个附加属性
Item_Attr_0 [3]		=		4						--2个附加属性
Item_Attr_0 [4]		=		50						--1个附加属性


Item_Mission_1 = { }					
Item_Mission_1 [0]		=		0						--
Item_Mission_1 [1]		=		0						--
Item_Mission_1 [2]		=		0						--
Item_Mission_1 [3]		=		0						--
Item_Mission_1 [4]		=		0						-- 
Item_Mission_1 [5]		=		0						--神喻之... 
Item_Mission_1 [6]		=		0						--王者之... 
Item_Mission_1 [7]		=		1						--统帅之... 
Item_Mission_1 [8]		=		10						--卓越之... 
Item_Mission_1 [9]		=		50						--普通型... 

Item_Attr_1 = { }					
Item_Attr_1 [0]		=		0						--5个附加属性      
Item_Attr_1 [1]		=		0						--4个附加属性      
Item_Attr_1 [2]		=		0						--3个附加属性      
Item_Attr_1 [3]		=		0						--2个附加属性      
Item_Attr_1 [4]		=		0						--1个附加属性      





Item_Mission_2 = { }					                                                          
Item_Mission_2 [0]		=		0						--                
Item_Mission_2 [1]		=		0						--                
Item_Mission_2 [2]		=		0						--                
Item_Mission_2 [3]		=		0						--                
Item_Mission_2 [4]		=		0						--                
Item_Mission_2 [5]		=		0						--神喻之...    
Item_Mission_2 [6]		=		1						--王者之...    
Item_Mission_2 [7]		=		5						--统帅之...    
Item_Mission_2 [8]		=		20						--卓越之...    
Item_Mission_2 [9]		=		80						--普通型...    

Item_Attr_2 = { }							
Item_Attr_2 [0]		=		0						--5个附加属性      
Item_Attr_2 [1]		=		0						--4个附加属性      
Item_Attr_2 [2]		=		0						--3个附加属性      
Item_Attr_2 [3]		=		10						--2个附加属性      
Item_Attr_2 [4]		=		30						--1个附加属性      



Item_Mission_3 = { }					                                                          
Item_Mission_3 [0]		=		0						--                
Item_Mission_3 [1]		=		0						--                
Item_Mission_3 [2]		=		0						--                
Item_Mission_3 [3]		=		0						--                
Item_Mission_3 [4]		=		0						--                
Item_Mission_3 [5]		=		0						--神喻之...    
Item_Mission_3 [6]		=		1						--王者之...    
Item_Mission_3 [7]		=		5						--统帅之...    
Item_Mission_3 [8]		=		50						--卓越之...    
Item_Mission_3 [9]		=		100						--普通型...    

Item_Attr_3 = { }									
Item_Attr_3 [0]		=		0						--5个附加属性 
Item_Attr_3 [1]		=		0						--4个附加属性 
Item_Attr_3 [2]		=		0						--3个附加属性 
Item_Attr_3 [3]		=		10						--2个附加属性 
Item_Attr_3 [4]		=		60						--1个附加属性 
												                              
												                              



Item_Mission_4 = { }					                                                          
Item_Mission_4 [0]		=		0						--                
Item_Mission_4 [1]		=		0						--                
Item_Mission_4 [2]		=		0						--                
Item_Mission_4 [3]		=		0						--                
Item_Mission_4 [4]		=		0						--                
Item_Mission_4 [5]		=		1						--神喻之...    
Item_Mission_4 [6]		=		5						--王者之...    
Item_Mission_4 [7]		=		15						--统帅之...    
Item_Mission_4 [8]		=		90						--卓越之...    
Item_Mission_4 [9]		=		100						--普通型...    

Item_Attr_4 = { }					
Item_Attr_4 [0]		=		0						--5个附加属性      
Item_Attr_4 [1]		=		0						--4个附加属性      
Item_Attr_4 [2]		=		1						--3个附加属性      
Item_Attr_4 [3]		=		20						--2个附加属性      
Item_Attr_4 [4]		=		100						--1个附加属性      


Item_Mission_5 = { }					                                                          
Item_Mission_5 [0]		=		0						--                
Item_Mission_5 [1]		=		0						--                
Item_Mission_5 [2]		=		0						--                
Item_Mission_5 [3]		=		0						--                
Item_Mission_5 [4]		=		0						--                
Item_Mission_5 [5]		=		1						--神喻之...    
Item_Mission_5 [6]		=		15						--王者之...    
Item_Mission_5 [7]		=		100						--统帅之...    
Item_Mission_5 [8]		=		100						--卓越之...    
Item_Mission_5 [9]		=		100						--普通型...    

Item_Attr_5 = { }					
Item_Attr_5 [0]		=		0						--5个附加属性      
Item_Attr_5 [1]		=		0						--4个附加属性      
Item_Attr_5 [2]		=		1						--3个附加属性      
Item_Attr_5 [3]		=		5						--2个附加属性      
Item_Attr_5 [4]		=		100						--1个附加属性

Item_Mission_94 = { }					                                                                -----------------kokora   
Item_Mission_94 [0]		=		0						--                
Item_Mission_94 [1]		=		0						--                
Item_Mission_94 [2]		=		0						--                
Item_Mission_94 [3]		=		0						--                
Item_Mission_94 [4]		=		0						--                
Item_Mission_94 [5]		=		0						--神喻之...    
Item_Mission_94 [6]		=		1						--王者之...    
Item_Mission_94 [7]		=		100						--统帅之...    
Item_Mission_94 [8]		=		100						--卓越之...    
Item_Mission_94 [9]		=		100						--普通型...    

Item_Attr_94 = { }					
Item_Attr_94 [0]		=		0						--5个附加属性      
Item_Attr_94 [1]		=		0						--4个附加属性      
Item_Attr_94 [2]		=		1						--3个附加属性      
Item_Attr_94 [3]		=		20						--2个附加属性      
Item_Attr_94 [4]		=		90						--1个附加属性

Item_Mission_95 = { }					                                                          
Item_Mission_95 [0]		=		0						--                
Item_Mission_95 [1]		=		0						--                
Item_Mission_95 [2]		=		0						--                
Item_Mission_95 [3]		=		0						--                
Item_Mission_95 [4]		=		0						--                
Item_Mission_95 [5]		=		0						--神喻之...    
Item_Mission_95 [6]		=		0						--王者之...    
Item_Mission_95 [7]		=		100						--统帅之...    
Item_Mission_95 [8]		=		100						--卓越之...    
Item_Mission_95 [9]		=		100						--普通型...    

Item_Attr_95 = { }					
Item_Attr_95 [0]		=		0						--5个附加属性      
Item_Attr_95 [1]		=		0						--4个附加属性      
Item_Attr_95 [2]		=		1						--3个附加属性      
Item_Attr_95 [3]		=		4						--2个附加属性      
Item_Attr_95 [4]		=		50						--1个附加属性

Item_Mission_96 = { }					                                                          
Item_Mission_96 [0]		=		0						--                
Item_Mission_96 [1]		=		0						--                
Item_Mission_96 [2]		=		0						--                
Item_Mission_96 [3]		=		0						--                
Item_Mission_96 [4]		=		0						--                
Item_Mission_96 [5]		=		10						--神喻之...    
Item_Mission_96 [6]		=		20						--王者之...    
Item_Mission_96 [7]		=		50						--统帅之...    
Item_Mission_96 [8]		=		90						--卓越之...    
Item_Mission_96 [9]		=		100						--普通型...    

Item_Attr_96 = { }					
Item_Attr_96 [0]		=		0						--5个附加属性      
Item_Attr_96 [1]		=		0						--4个附加属性      
Item_Attr_96 [2]		=		2						--3个附加属性      
Item_Attr_96 [3]		=		20						--2个附加属性      
Item_Attr_96 [4]		=		100						--1个附加属性 


Item_Mission_97 = { }					                                                          
Item_Mission_97 [0]		=		0						--                
Item_Mission_97 [1]		=		0						--                
Item_Mission_97 [2]		=		0						--                
Item_Mission_97 [3]		=		0						--                
Item_Mission_97 [4]		=		0						--                
Item_Mission_97 [5]		=		0						--神喻之...    
Item_Mission_97 [6]		=		0						--王者之...    
Item_Mission_97 [7]		=		0						--统帅之...    
Item_Mission_97 [8]		=		0						--卓越之...    
Item_Mission_97 [9]		=		100						--普通型...    

Item_Attr_97 = { }					
Item_Attr_97 [0]		=		100						--5个附加属性      
Item_Attr_97 [1]		=		100						--4个附加属性      
Item_Attr_97 [2]		=		100						--3个附加属性      
Item_Attr_97 [3]		=		100						--2个附加属性      
Item_Attr_97 [4]		=		100						--1个附加属性 


Item_Mission_98 = { }					                                                          
Item_Mission_98 [0]		=		0						--                
Item_Mission_98 [1]		=		0						--                
Item_Mission_98 [2]		=		0						--                
Item_Mission_98 [3]		=		0						--                
Item_Mission_98 [4]		=		0						--                
Item_Mission_98 [5]		=		10						--神喻之...    
Item_Mission_98 [6]		=		20						--王者之...    
Item_Mission_98 [7]		=		50						--统帅之...    
Item_Mission_98 [8]		=		90						--卓越之...    
Item_Mission_98 [9]		=		100						--普通型...    

Item_Attr_98 = { }					
Item_Attr_98 [0]		=		0						--5个附加属性      
Item_Attr_98 [1]		=		0						--4个附加属性      
Item_Attr_98 [2]		=		2						--3个附加属性      
Item_Attr_98 [3]		=		20						--2个附加属性      
Item_Attr_98 [4]		=		100						--1个附加属性 



Item_Mission_99 = { }					                                                          
Item_Mission_99 [0]		=		0						--                
Item_Mission_99 [1]		=		0						--                
Item_Mission_99 [2]		=		0						--                
Item_Mission_99 [3]		=		0						--                
Item_Mission_99 [4]		=		0						--                
Item_Mission_99 [5]		=		1						--神喻之...    
Item_Mission_99 [6]		=		5						--王者之...    
Item_Mission_99 [7]		=		20						--统帅之...    
Item_Mission_99 [8]		=		50						--卓越之...    
Item_Mission_99 [9]		=		100						--普通型...    

Item_Attr_99 = { }					
Item_Attr_99 [0]		=		0						--5个附加属性      
Item_Attr_99 [1]		=		0						--4个附加属性      
Item_Attr_99 [2]		=		2						--3个附加属性      
Item_Attr_99 [3]		=		20						--2个附加属性      
Item_Attr_99 [4]		=		100						--1个附加属性      

Item_Mission_11 = { }
Item_Mission_11 [0]		=		0						--                
Item_Mission_11 [1]		=		0						--                
Item_Mission_11 [2]		=		0						--                
Item_Mission_11 [3]		=		0						--                
Item_Mission_11 [4]		=		0						--                
Item_Mission_11 [5]		=		0						--神喻之...    
Item_Mission_11 [6]		=		0						--王者之...    
Item_Mission_11 [7]		=		100						--统帅之...    
Item_Mission_11 [8]		=		100						--卓越之...    
Item_Mission_11 [9]		=		100						--普通型...    

Item_Attr_11 = { }					
Item_Attr_11 [0]		=		0						--5个附加属性
Item_Attr_11 [1]		=		0						--4个附加属性
Item_Attr_11 [2]		=		1						--3个附加属性
Item_Attr_11 [3]		=		4						--2个附加属性
Item_Attr_11 [4]		=		50						--1个附加属性    



Item_Mission_12 = { }
Item_Mission_12 [0]		=		0						--                
Item_Mission_12 [1]		=		0						--                
Item_Mission_12 [2]		=		0						--                
Item_Mission_12 [3]		=		0						--                
Item_Mission_12 [4]		=		0						--                
Item_Mission_12 [5]		=		0						--神喻之...    
Item_Mission_12 [6]		=		0						--王者之...    
Item_Mission_12 [7]		=		0						--统帅之...    
Item_Mission_12 [8]		=		0						--卓越之...    
Item_Mission_12 [9]		=		100						--普通型...    

Item_Attr_12 = { }					
Item_Attr_12 [0]		=		0						--5个附加属性
Item_Attr_12 [1]		=		0						--4个附加属性
Item_Attr_12 [2]		=		0						--3个附加属性
Item_Attr_12 [3]		=		0						--2个附加属性
Item_Attr_12 [4]		=		0						--1个附加属性    




Item_Mission_13 = { }
Item_Mission_13 [0]		=		0						--                
Item_Mission_13 [1]		=		0						--                
Item_Mission_13 [2]		=		0						--                
Item_Mission_13 [3]		=		0						--                
Item_Mission_13 [4]		=		0						--                
Item_Mission_13 [5]		=		0						--神喻之...    
Item_Mission_13 [6]		=		0						--王者之...    
Item_Mission_13 [7]		=		0						--统帅之...    
Item_Mission_13 [8]		=		100						--卓越之...    
Item_Mission_13 [9]		=		100						--普通型...    

Item_Attr_13 = { }					
Item_Attr_13 [0]		=		0						--5个附加属性
Item_Attr_13 [1]		=		0						--4个附加属性
Item_Attr_13 [2]		=		0						--3个附加属性
Item_Attr_13 [3]		=		0						--2个附加属性
Item_Attr_13 [4]		=		0						--1个附加属性   


Item_Mission_14 = { }
Item_Mission_14 [0]		=		0						--                
Item_Mission_14 [1]		=		0						--                
Item_Mission_14 [2]		=		0						--                
Item_Mission_14 [3]		=		0						--                
Item_Mission_14 [4]		=		0						--                
Item_Mission_14 [5]		=		0						--神喻之...    
Item_Mission_14 [6]		=		0						--王者之...    
Item_Mission_14 [7]		=		100						--统帅之...    
Item_Mission_14 [8]		=		100						--卓越之...    
Item_Mission_14 [9]		=		100						--普通型...    

Item_Attr_14 = { }					
Item_Attr_14 [0]		=		0						--5个附加属性
Item_Attr_14 [1]		=		0						--4个附加属性
Item_Attr_14 [2]		=		0							--3个附加属性
Item_Attr_14 [3]		=		0							--2个附加属性
Item_Attr_14 [4]		=		0						--1个附加属性   


Item_Mission_15 = { }
Item_Mission_15 [0]		=		0						--                
Item_Mission_15 [1]		=		0						--                
Item_Mission_15 [2]		=		0						--                
Item_Mission_15 [3]		=		0						--                
Item_Mission_15 [4]		=		0						--                
Item_Mission_15 [5]		=		0						--神喻之...    
Item_Mission_15 [6]		=		100						--王者之...    
Item_Mission_15 [7]		=		100						--统帅之...    
Item_Mission_15 [8]		=		100						--卓越之...    
Item_Mission_15 [9]		=		100						--普通型...    

Item_Attr_15 = { }					
Item_Attr_15 [0]		=		0						--5个附加属性
Item_Attr_15 [1]		=		0						--4个附加属性
Item_Attr_15 [2]		=		0						--3个附加属性
Item_Attr_15 [3]		=		0						--2个附加属性
Item_Attr_15 [4]		=		0						--1个附加属性  


Item_Mission_16 = { }
Item_Mission_16 [0]		=		0						--                
Item_Mission_16 [1]		=		0						--                
Item_Mission_16 [2]		=		0						--                
Item_Mission_16 [3]		=		0						--                
Item_Mission_16 [4]		=		0						--                
Item_Mission_16 [5]		=		100						--神喻之...    
Item_Mission_16 [6]		=		100						--王者之...    
Item_Mission_16 [7]		=		100						--统帅之...    
Item_Mission_16 [8]		=		100						--卓越之...    
Item_Mission_16 [9]		=		100						--普通型...    

Item_Attr_16 = { }					
Item_Attr_16 [0]		=		0					--5个附加属性
Item_Attr_16 [1]		=		0					--4个附加属性
Item_Attr_16 [2]		=		0					--3个附加属性
Item_Attr_16 [3]		=		0					--2个附加属性
Item_Attr_16 [4]		=		0						--1个附加属性  

Item_Mission_17 = { }
Item_Mission_17 [0]		=		0						--                
Item_Mission_17 [1]		=		0						--                
Item_Mission_17 [2]		=		0						--                
Item_Mission_17 [3]		=		0						--                
Item_Mission_17 [4]		=		100						--                
Item_Mission_17 [5]		=		100						--神喻之...    
Item_Mission_17 [6]		=		100						--王者之...    
Item_Mission_17 [7]		=		100						--统帅之...    
Item_Mission_17 [8]		=		100						--卓越之...    
Item_Mission_17 [9]		=		100						--普通型...    
	     
Item_Attr_17 = { }					
Item_Attr_17 [0]		=		0					--5个附加属性
Item_Attr_17 [1]		=		0					--4个附加属性
Item_Attr_17 [2]		=		0					--3个附加属性
Item_Attr_17 [3]		=		0					--2个附加属性
Item_Attr_17 [4]		=		0						--1个附加属性  


Item_Mission_18 = { }
Item_Mission_18 [0]		=		0						--                
Item_Mission_18 [1]		=		0						--                
Item_Mission_18 [2]		=		0						--                
Item_Mission_18 [3]		=		100						--                
Item_Mission_18 [4]		=		100						--                
Item_Mission_18 [5]		=		100						--神喻之...    
Item_Mission_18 [6]		=		100						--王者之...    
Item_Mission_18 [7]		=		100						--统帅之...    
Item_Mission_18 [8]		=		100						--卓越之...    
Item_Mission_18 [9]		=		100						--普通型...    
	     
Item_Attr_18 = { }					
Item_Attr_18 [0]		=		0					--5个附加属性
Item_Attr_18 [1]		=		0					--4个附加属性
Item_Attr_18 [2]		=		0					--3个附加属性
Item_Attr_18 [3]		=		0					--2个附加属性
Item_Attr_18 [4]		=		0						--1个附加属性  

Item_Mission_19 = { }
Item_Mission_19 [0]		=		0						--                
Item_Mission_19 [1]		=		0						--                
Item_Mission_19 [2]		=		100						--                
Item_Mission_19 [3]		=		100						--                
Item_Mission_19 [4]		=		100						--                
Item_Mission_19 [5]		=		100						--神喻之...    
Item_Mission_19 [6]		=		100						--王者之...    
Item_Mission_19 [7]		=		100						--统帅之...    
Item_Mission_19 [8]		=		100						--卓越之...    
Item_Mission_19 [9]		=		100						--普通型...    
	     
Item_Attr_19 = { }					
Item_Attr_19 [0]		=		0					--5个附加属性
Item_Attr_19 [1]		=		0					--4个附加属性
Item_Attr_19 [2]		=		0					--3个附加属性
Item_Attr_19 [3]		=		0					--2个附加属性
Item_Attr_19 [4]		=		0						--1个附加属性  


Item_Mission_20 = { }
Item_Mission_20 [0]		=		0						--                
Item_Mission_20 [1]		=		100						--                
Item_Mission_20 [2]		=		100						--                
Item_Mission_20 [3]		=		100						--                
Item_Mission_20 [4]		=		100						--                
Item_Mission_20 [5]		=		100						--神喻之...    
Item_Mission_20 [6]		=		100						--王者之...    
Item_Mission_20 [7]		=		100						--统帅之...    
Item_Mission_20 [8]		=		100						--卓越之...    
Item_Mission_20 [9]		=		100						--普通型...    
	     
Item_Attr_20 = { }					
Item_Attr_20 [0]		=		0						--5个附加属性
Item_Attr_20 [1]		=		0						--4个附加属性
Item_Attr_20 [2]		=		0						--3个附加属性
Item_Attr_20 [3]		=		0						--2个附加属性
Item_Attr_20 [4]		=		0						--1个附加属性

Item_Mission_22 = { }
Item_Mission_22 [0]		=		0						--                
Item_Mission_22 [1]		=		0						--                
Item_Mission_22 [2]		=		0						--                
Item_Mission_22 [3]		=		0						--                
Item_Mission_22 [4]		=		100						--                
Item_Mission_22 [5]		=		100						--神喻之...    
Item_Mission_22 [6]		=		100						--王者之...    
Item_Mission_22 [7]		=		100						--统帅之...    
Item_Mission_22 [8]		=		100						--卓越之...    
Item_Mission_22 [9]		=		100						--普通型...    
	     
Item_Attr_22 = { }					
Item_Attr_22 [0]		=		0							--5个附加属性
Item_Attr_22 [1]		=		0							--4个附加属性
Item_Attr_22 [2]		=		1							--3个附加属性
Item_Attr_22 [3]		=		4							--2个附加属性
Item_Attr_22 [4]		=		50							--1个附加属性

Item_Mission_23 = { }
Item_Mission_23 [0]		=		0							--                
Item_Mission_23 [1]		=		0							--                
Item_Mission_23 [2]		=		0							--                
Item_Mission_23 [3]		=		0							--                
Item_Mission_23 [4]		=		3							--                
Item_Mission_23 [5]		=		6							--神喻之...    
Item_Mission_23 [6]		=		25							--王者之...    
Item_Mission_23 [7]		=		50							--统帅之...    
Item_Mission_23 [8]		=		70							--卓越之...    
Item_Mission_23 [9]		=		100							--普通型...    
	     
Item_Attr_23 = { }					
Item_Attr_23 [0]		=		0							--5个附加属性
Item_Attr_23 [1]		=		0							--4个附加属性
Item_Attr_23 [2]		=		1							--3个附加属性
Item_Attr_23 [3]		=		5							--2个附加属性
Item_Attr_23 [4]		=		60							--1个附加属性

Item_Mission_24 = { }
Item_Mission_24 [0]		=		0							--                
Item_Mission_24 [1]		=		0							--                
Item_Mission_24 [2]		=		0							--                
Item_Mission_24 [3]		=		0							--                
Item_Mission_24 [4]		=		0							--                
Item_Mission_24 [5]		=		1							--神喻之...    
Item_Mission_24 [6]		=		5							--王者之...    
Item_Mission_24 [7]		=		20							--统帅之...    
Item_Mission_24 [8]		=		65							--卓越之...    
Item_Mission_24 [9]		=		99							--普通型...    
	     
Item_Attr_24 = { }					
Item_Attr_24 [0]		=		0							--5个附加属性
Item_Attr_24 [1]		=		0							--4个附加属性
Item_Attr_24 [2]		=		1							--3个附加属性
Item_Attr_24 [3]		=		4							--2个附加属性
Item_Attr_24 [4]		=		50							--1个附加属性

Item_Mission_AttrReset = { }
Item_Mission_AttrReset [0]		=		0							--                
Item_Mission_AttrReset [1]		=		0							--                
Item_Mission_AttrReset [2]		=		0							--                
Item_Mission_AttrReset [3]		=		0							--                
Item_Mission_AttrReset [4]		=		0							--                
Item_Mission_AttrReset [5]		=		10							--神喻之...    
Item_Mission_AttrReset [6]		=		25							--王者之...    
Item_Mission_AttrReset [7]		=		50							--统帅之...    
Item_Mission_AttrReset [8]		=		90							--卓越之...    
Item_Mission_AttrReset [9]		=		100							--普通型...    
	     
Item_Attr_AttrReset = { }					
Item_Attr_AttrReset [0]		=		0							--5个附加属性
Item_Attr_AttrReset [1]		=		0							--4个附加属性
Item_Attr_AttrReset [2]		=		10							--3个附加属性
Item_Attr_AttrReset [3]		=		50							--2个附加属性
Item_Attr_AttrReset [4]		=		100							--1个附加属性
--设置装备获得孔数的概率

Item_HoleNum_Monster = { }
Item_HoleNum_Monster [0]		=		75						--0个洞
Item_HoleNum_Monster [1]		=		99						--1个洞
Item_HoleNum_Monster [2]		=		100				--2个洞						
Item_HoleNum_Monster [3]		=		100						--3个洞

Item_HoleNum_Hecheng = { }
Item_HoleNum_Hecheng [0]		=		25						--0个洞
Item_HoleNum_Hecheng [1]		=		75						--1个洞
Item_HoleNum_Hecheng [2]		=		100						--2个洞						
Item_HoleNum_Hecheng [3]		=		100						--3个洞

Item_HoleNum_Mission_1 = { }
Item_HoleNum_Mission_1 [0]		=		25						--0个洞
Item_HoleNum_Mission_1 [1]		=		75						--1个洞
Item_HoleNum_Mission_1 [2]		=		100						--2个洞						
Item_HoleNum_Mission_1 [3]		=		100						--3个洞




--航海技能消耗航海经验——————————————————————————————————————————————————————————————————
--技能甲板加固————————————————————————————————
sk_jbjg = { } 
sk_jbjg [1]				=		625
sk_jbjg [2]				=		3439    
sk_jbjg [3]				=		12209  
sk_jbjg [4]				=		29679  
sk_jbjg [5]				=		58849  
sk_jbjg [6]				=		102719 
sk_jbjg [7]				=		164289 
sk_jbjg [8]				=		246559 
sk_jbjg [9]				=		352529 
sk_jbjg [10]			=		485199 

--技能火炮熟练————————————————————————————————
sk_hpsl = { } 
sk_hpsl [1]				=		671
sk_hpsl [2]				=		4641            
sk_hpsl [3]				=		14911          
sk_hpsl [4]				=		34481          
sk_hpsl [5]				=		66351          
sk_hpsl [6]				=		113521         
sk_hpsl [7]				=		178991         
sk_hpsl [8]				=		265761         
sk_hpsl [9]				=		376831         
sk_hpsl [10]			=		515201         

--技能船体强化————————————————————————————————
sk_ctqh = { } 
sk_ctqh [1]			=		1105
sk_ctqh [2]			=		6095      
sk_ctqh [3]			=		17985    
sk_ctqh [4]			=		39775    
sk_ctqh [5]			=		74465    
sk_ctqh [6]			=		125055   
sk_ctqh [7]			=		194545   
sk_ctqh [8]			=		285935   
sk_ctqh [9]			=		402225   
sk_ctqh [10]			=		546415   

--技能操帆术————————————————————————————————
sk_cfs = { } 
sk_cfs [1]				=		1695
sk_cfs [2]				=		7825         
sk_cfs [3]				=		21455       
sk_cfs [4]				=		45585       
sk_cfs [5]				=		83215       
sk_cfs [6]				=		137345      
sk_cfs [7]				=		210975      
sk_cfs [8]				=		307105      
sk_cfs [9]				=		428735      
sk_cfs [10]				=		578865      


--技能补给扩容————————————————————————————————
sk_bjkr = { } 
sk_bjkr [1]				=		2465
sk_bjkr [2]				=		9855         
sk_bjkr [3]				=		25345       
sk_bjkr [4]				=		51935       
sk_bjkr [5]				=		92625       
sk_bjkr [6]				=		150415      
sk_bjkr [7]				=		228305      
sk_bjkr [8]				=		329295      
sk_bjkr [9]				=		456385      
sk_bjkr [10]			=		612575      










--创建海军工会所需物品
Guild1_ItemMax		=	1

Guild1_item = {}
Guild1_count = {}
								Guild1_fame	=	0
								Guild1_Gold	=	100000
Guild1_item[1]	=	1780				Guild1_count[1]	=	1
Guild1_item[2]	=	-1				Guild1_count[2]	=	-1
Guild1_item[3]	=	-1				Guild1_count[3]	=	-1
Guild1_item[4]	=	-1				Guild1_count[4]	=	-1
Guild1_item[5]	=	-1				Guild1_count[5]	=	-1

--创建海盗工会所需物品
Guild2_ItemMax		=	1

Guild2_item = {}
Guild2_count = {}
								Guild2_fame	=	0
								Guild2_Gold	=	100000
Guild2_item[1]	=	1780				Guild2_count[1]	=	1
Guild2_item[2]	=	-1				Guild2_count[2]	=	-1
Guild2_item[3]	=	-1				Guild2_count[3]	=	-1
Guild2_item[4]	=	-1				Guild2_count[4]	=	-1
Guild2_item[5]	=	-1				Guild2_count[5]	=	-1

----加入海军工会所需条件
	JOINGUILD_NAVY_FAME	=	0			--加入海军名声

  --加入海盗工会所需条件
	JOINGUILD_PIRATE_FAME	=	0			--加入海盗名声
--
--


SK_DPSL		=	73					--技能盾牌熟练
SK_LZJ		=	90					--技能连击箭
SK_LXJY		=	112					--技能流星箭雨
SK_LH		=	107					--技能狼嚎
SK_SSD		=	114					--技能散射弹
SK_CTD		=	115					--技能穿透弹
SK_DZY		=	117					--技能大治愈
SK_HX		=	127					--技能虎啸
SK_RSD		=	113					--技能燃烧
SK_JJSL		=	67					--技能巨剑熟练
SK_KB		=	84					--技能狂暴
SK_FSZ		=	109					--技能双手剑加成.............
SK_XZFY		=	104					--技能贤者封印
SK_YMSL		=	108					--技能野蛮碎裂
--SK_BC		=	84					--技能背刺
SK_CLXZ		=	76					--技能丛林行者
SK_FZLZ		=	101					--技能风之领主
SK_GJSL		=	74					--技能弓箭熟练

SK_HFWQ		=	122					--技能回复温泉
SK_JSFB		=	102					--技能极速风暴
SK_JFZ		=	64					--技能疾风斩
SK_QXYJ		=	65					--技能枪械研究
SK_SHTZ		=	71					--技能兽化体质
SK_TSHD		=	103					--技能天使护盾
SK_TSQY		=	45					--技能天使祈愿
SK_TJ		=	94					--技能腿狙
SK_XZY		=	97					--技能小治愈
SK_XLZH		=	100					--技能心灵之火
SK_ZZZH		=	119					--技能诅咒之火
SK_SMYB		=	73					--技能舍命一搏
SK_YS		=	123					--技能隐身
--SK_GZ		=	86					--技能鬼斩
SK_MB		=	88					--技能麻痹
SK_DB		=	87					--技能毒镖
--SK_JD		=	78					技能解毒
--SK_ZJCM		=	79					技能终极刺盲
--SK_ZHZD		=	80					技能遮护之盾
SK_ZJFT		=	110					--技能荆棘之盾
--SK_BSHD		=	82					技能冰霜护盾
SK_HXDJ		=	111					--技能回旋盾击
SK_HXQJ		=	92					--技能彗星强击
SK_HQSL		=	78					--技能火枪熟练
--SK_JLHY		=	86					--技能精炼火药
--SK_RDGJ		=	87					--技能弱点攻击
SK_BT		=	96					--技能暴头
SK_SY		=	80					--技能神佑
--SK_QY		=	90					技能祈愿
SK_ZF		=	91					--技能祝福
SK_HFS		=	98					--技能回复术
SK_DHFS		=	118					--技能大回复术
--SK_LYZY		=	94					技能烈焰之翼
--SK_SHZG		=	95					技能圣火之光
--SK_SZWZ		=	96					技能圣职纹章
--SK_XYZG		=	97					技能幸运之光

SK_SYZY		=	116					--技能圣眼之翼
SK_AYZZ		=	105					--技能暗影之章
--SK_CLCY		=	101					技能丛林穿越
--SK_HYPS		=	102					技能火焰喷射
SK_JSSL		=	62					--技能剑术熟练
SK_GTYZ		=	63					--技能钢铁意志
SK_QHTZ		=	64					--技能强化体质
SK_LQHB		=	65					--技能灵巧回避
SK_JDZZ		=	66					--技能剑道专注
SK_HYZ		=	81					--技能幻影斩
SK_ZJ		=	82					--技能重击
SK_MNRX		=	68					--技能蛮牛热血
SK_SWZQ		=	83					--技能兽王之拳
SK_HYS		=	69					--技能幻影闪
SK_PXKG		=	70					--技能破血狂攻
SK_GWZ		=	86					--技能鬼舞斩
SK_TZHF		=	72					--技能体质回复
SK_JFB		=	75					--技能疾风步
SK_YY		=	89					--技能鹰眼
SK_LDC		=	91					--技能猎刀刺
SK_JSJC		=	79					--技能精神加持
SK_XLCZ		=	99					--技能心灵冲撞
SK_BDJ		=	93					--技能冰冻箭
SK_LRWZ		=	77					--技能猎人伪装
SK_SJ		=	95					--技能手狙
SK_SDBZ		=	120					--技能闪躲壁障
SK_SYNZ		=	121					--技能深渊泥沼
SK_XLPZ		=	106					--技能心灵屏障
SK_FH		=	124					--技能复活
ITEM_RELIFE	=	3143						--复活技能消耗物品

SK_TTCB		=	125					--技能图腾崇拜
SK_DYYJ		=	126					--技能弹药研究
SK_JR		=	210					--技能坚韧
SK_SL		=	211					--技能顺流
SK_BKZJ		=	212					--技能贝壳装甲
SK_JF		=	213					--技能飓风
SK_LJ		=	214					--技能雷击
SK_HZCR		=	215					--技能海藻缠绕
SK_BKCJ		=	216					--技能贝壳冲击
SK_SF		=	217					--技能顺风
SK_XW		=	218					--技能漩涡
SK_MW		=	219					--技能迷雾
SK_LM		=	220					--技能雷幕
SK_PJ		=	222					--技能破甲
SK_FNQ		=	223					--技能奋起
SK_DJ		=	224					--技能毒箭
SK_SHPF		=	225					--技能石化皮肤
SK_HPSL		=	226					--技能火炮熟练
SK_JBJG		=	227					--技能甲板加固
SK_CFS		=	228					--技能操帆术
SK_CTQH		=	229					--技能船体强化
SK_BJCR		=	230					--技能补给扩容
SK_BY		=	231					--技能捕鱼
SK_DL		=	232					--技能打捞
SK_SWCX		=	234					--技能死亡嘲笑
SK_XN		=	235					--技能血怒
SK_NT		=	236					--技能泥潭
SK_DIZ		=	237					--技能地震
SK_XIK		=	238					--技能凶砍
SK_BIW		=	239					--技能冰吻
SK_Fer		=	240					--技能风刃
SK_BAT		=	241					--技能摆摊
SK_CHF		=	242					--技能嘲讽
SK_PAX		=	243					--技能咆哮
SK_FUZ		=	244					--技能复制
SK_HZTX		=	245					--技能海藻突袭
SK_SMDJ		=	246					--技能水母电击
SK_WZXF		=	247					--技能乌贼旋风
SK_SYZM		=	248					--技能鲨鱼致命一击
SK_KDZB		=	249					--技能蝌蚪自爆
SK_SHJNY	=	250					--技能上古1
SK_SHJNE	=	251					--技能上古2
SK_BOMB  	=	252					--技能爆炸

SK_BLYZ		=	255					--冰灵佑佐
SK_MLCH		=	256					--魔力催化


SK_JSDD		=	257					--僵尸普通攻击
SK_JSMF		=	258					--僵尸远程攻击 
SK_HDSMF	=       259					--狐道士魔法
SK_HYMF		=       260					--狐妖魔法                                                        
SK_HYMH		=	261					--狐妖魔法-魅惑                       
SK_HXMF		=	262					--狐仙魔法
SK_HXFWMF	=	263					--狐仙范围魔法
SK_TZJSMagic	=	264					--祭师魔法攻击
SK_QZMF		=	265					--酋长魔法
SK_XZSB		=	266					--旋转挥舞手臂
SK_QX		=	267					--犬啸
SK_SD		=	268					--尸毒
SK_BLGJ		=	269					--冰龙攻击

SK_JXJBFW	=	270					--机械巨兵范围
SK_CRXSF	=	271					--长蟹绒束缚
SK_SXZZZ	=	272					--水仙子诅咒
SK_XBLBD	=	273					--小冰龙冰冻
SK_BHSD		=	274					--冰龙群体冰冻
SK_HLKJ		=	275					--黑龙恐惧
SK_HLLM		=	276					--黑龙-龙鸣
SK_BlackLY	=	277					--黑龙-龙翼
SK_BlackLX	=	278					--黑龙-龙息
SK_BlackHeal	=	279					--起死回生
SK_JLFT	=	280					--精灵附体
SK_JLZB	=	311					--精灵自爆	
SK_JLTX1			=	312				--精灵特效1	
SK_JLTX2			=	313				--精灵特效2	
SK_JLTX3			=	314				--精灵特效3	
SK_JLTX4			=	315				--精灵特效4	
SK_JLTX5			=	316				--精灵特效5	
SK_JLTX6			=	317				--精灵特效6	
SK_JLTX7			=	318				--精灵特效7	
SK_JLTX8			=	319				--精灵特效8	


SK_KS			=	200					--技能砍树
SK_WK			=	201					--技能挖矿
SK_PKQX			=	254					--技能抢修
SK_ZHIZAO		=	338				----------------制造
SK_PENGREN		=	339				----------------铸造
SK_ZHUZAO		=	340				----------------烹饪
SK_FENJIE			=	341				----------------分解
SK_WYZ			=	453				----------------无影斩
SK_CYN			=	454				----------------超意念
SK_BSJ			=	455				----------------百兽击
SK_HLP			=	456				----------------红雷炮
SK_EMZZ			=	457				----------------恶魔诅咒
SK_SSSP			=	458				----------------神圣审判
SK_ZSSL			=	459				----------------转生神力
SK_DS			=	461				----------------技能读书
SK_QLZX			=	467				----------------千里追寻
SK_ZSZB			=	468				----------------宙斯自爆
SK_NEW			=	475				----------------新手出生技能
SK_WB			=	491				----------------挖宝
SK_YJWB			=	492				----------------遗迹挖宝
SK_XUNBAO		=	495				----------------寻宝（五一挖宝）

SK_FNZ		=	504				------附能斩
SK_HW		=	505				------化雾
SK_NLD		=	506				------能量盾
SK_NLSFW        =	507				------能量束缚网
SK_MLCJ		=	508				------魔力冲击


STATE_RS		=	1				--状态燃烧
STATE_HFWQ		=	2				--状态回复温泉
STATE_ZZZH		=	3				--状态诅咒之火
STATE_ZD		=	4				--状态中毒
STATE_SDBZ		=	5				--状态闪躲壁障
STATE_SYZY		=	6				--状态圣眼之翼
STATE_SYNZ		=	7				--状态深渊泥沼
STATE_LQ		=	9				--状态雷区
STATE_WQ		=	10				--状态雾区 
STATE_FQ		=	11				--状态风区
STATE_XW		=	12				--状态漩涡
STATE_MW		=	13				--状态迷雾
STATE_LM		=	14				--状态雷幕
STATE_CHF		=	15				--状态嘲讽
STATE_BOMB		=	16				--状态爆炸
STATE_PKMNYS		=	17				--状态蛮牛药水

STATE_PKZDYS		=	19				--状态战斗药水
STATE_PKKBYS		=	20				--状态狂暴药水
STATE_DPSL		=	21				--状态盾牌熟练
STATE_HX		=	22				--状态虎啸	
STATE_JJSL		=	23				--状态巨剑熟练
STATE_KB		=	24				--状态狂暴
STATE_FSZ		=	84				--状态双手武器加成
STATE_JNJZ		=	26				--状态技能禁止
STATE_ZMYJ		=	27				--状态致命一击
STATE_CLXZ		=	28				--状态丛林行者
STATE_FZLZ		=	29				--状态风之领主
STATE_GJSL		=	30				--状态弓箭熟练
STATE_HYS		=	31				--状态幻影闪

STATE_JSFB		=	33				--状态极速风暴
STATE_JFZ		=	34				--状态疾风斩
STATE_QXYJ		=	35				--状态枪械研究
STATE_SHTZ		=	36				--状态兽化体质
STATE_TSHD		=	37				--状态天使护盾
STATE_TSQY		=	38				--状态天使祈愿
STATE_TJ		=	39				--状态腿狙
STATE_XLZH		=	40				--状态心灵之火
STATE_PKJSYS		=	41				--状态精神药水
STATE_PKSFYS		=	42				--状态石肤药水
STATE_YS		=	43				--状态隐身
STATE_PKJZYS		=	44				--状态精准药水
STATE_XY		=	45				--状态眩晕
STATE_MB		=	46				--状态麻痹
STATE_PKWD		=	47				--状态无敌
STATE_SBJYGZ		=	48				--状态经验果子
STATE_SBBLGZ		=	49				--状态掉料果子
STATE_MLCH		=	50				--状态魔力催化
STATE_BSHD		=	51				--状态冰霜护盾
STATE_BD		=	52				--状态冰冻

STATE_HQSL		=	53				--状态火枪熟练
STATE_JLHY		=	54				--状态精炼火药
STATE_RDGJ		=	55				--状态弱点攻击
STATE_SY		=	56				--状态神佑
STATE_QY		=	57				--状态祈愿
STATE_ZF		=	58				--状态祝福
STATE_LYZY		=	59				--状态烈焰之翼
STATE_SHZG		=	60				--状态圣火之光
STATE_SZWZ		=	61				--状态圣职纹章
STATE_XYZG		=	62				--状态幸运之光
STATE_PKDYK		=	63				--状态弹药库没啦
STATE_PKLC		=	64				--状态粮仓没啦
STATE_GJJZ		=	65				--状态攻击禁止
STATE_CLCY		=	66				--状态丛林穿越

STATE_SJ		=	68				--状态手狙
STATE_JSSL		=	69				--状态剑术熟练
STATE_GTYZ		=	70				--状态钢铁意志
STATE_QHTZ		=	71				--状态强化体质
STATE_LQHB		=	72				--状态灵巧回避
STATE_JDZZ		=	73				--状态剑道专注
STATE_MNRX		=	74				--状态蛮牛热血
STATE_HYS		=	75				--状态幻影闪
STATE_PXKG		=	76				--状态破血狂攻
STATE_TZHF		=	77				--状态体质回复
STATE_JFB		=	78				--状态疾风步
STATE_YY		=	79				--状态鹰眼
STATE_JSJC		=	80				--状态精神加持
STATE_BDJ		=	81				--状态冰冻箭
STATE_LRWZ		=	82				--状态猎人伪装

STATE_MFD		=	83				--状态魔法盾
STATE_JY		=	85				--状态交易
STATE_JF		=	86				--状态飓风
STATE_HZCR		=	87					--状态海藻缠绕
STATE_SF		=	88				--状态顺风
STATE_PJ		=	89				--状态破甲
STATE_FNQ		=	90				--状态奋起
STATE_DJ		=	91				--状态毒箭
STATE_SHPF		=	92				--状态石化皮肤
STATE_XN		=	93				--状态血怒
STATE_NT		=	94				--状态泥潭
STATE_DIZ		=	95				--状态地震
STATE_BIW		=	96				--状态冰吻
STATE_MCK		=	97				--状态使用木材捆
STATE_SWCX		=	98				--状态死亡嘲笑
STATE_BAT		=	99				--状态摆摊

STATE_YSLLQH		=	102				--药水力量加成
STATE_YSMJQH		=	103				--药水敏捷加成
STATE_YSLQQH		=	104				--药水专注加成
STATE_YSTZQH		=	105				--药水体质加成
STATE_YSJSQH		=	106				--药水精神加成
STATE_JLGLJB		=	107				--精炼成功率加倍
STATE_HCGLJB		=	108				--合成成功率加倍
STATE_DENGLONG		=	109				--灯笼状态
STATE_MEIGUI		=	110				--玫瑰花状态
STATE_YPCXHFSM		=	111				--药品持续回复生命
STATE_CFZJiu1		=	112				--春风镇酒1
STATE_CFZJiu2		=	113				--春风镇酒2
STATE_JSDD		=	114				--僵尸带毒
STATE_HYMH		=	115				--狐妖魔法-魅惑
STATE_HLKJ		=	116				--黑龙-恐惧
STATE_HLLM		=	117				--黑龙-龙鸣
STATE_CRXSF		=	118				--长绒蟹-束缚
STATE_MarchElf		=	119				--三月精灵
STATE_YSMspd		=	120				--药水速度强化
STATE_YSBoatMspd	=	121				--药水船只速度强化
STATE_YSBoatDEF		=	122				--药水船只防御强化
STATE_TTISW		=	123				--春风镇状态
STATE_PKSBYS		=	124				--状态艾草（闪避药水）
STATE_BlackHX		=	125				--黑龙虎啸
STATE_ZDSBJYGZ		=	127				--组队经验状态
STATE_KUANGZ		=	128				--狂战术
STATE_QUANS		=	129				--全身装甲
STATE_QINGZ		=	130				--轻装药水
STATE_JLDS		=	131				--宠物毒噬
STATE_JLFT1		=	132				--精灵附体
STATE_CJBBT		=	133				--超人棒棒糖
STATE_JRQKL		=	134				--巨人巧克力
STATE_WLRSD		=	135				--亡灵燃烧弹
STATE_WLJS		=	136				--亡灵加速
STATE_YWGJ		=	142				--烟雾攻击
STATE_KLCS		=	138				--骷髅缠身
STATE_KLHD		=	139				--骷髅护盾
STATE_WLCX		=	140				--亡灵嘲笑
STATE_ZZZX		=	141				--诅咒之血
STATE_WLDB		=	142				--亡灵毒镖
STATE_WLJY		=	143				--亡灵击晕
STATE_WLXW		=	137				--亡灵漩涡
STATE_WLNH		=	146				--亡灵怒吼
STATE_JLJSGZ		=	147				--精灵双倍成长	
STATE_JLTX1		=	148				--精灵特效1	
STATE_JLTX2		=	149				--精灵特效2	
STATE_JLTX3		=	150				--精灵特效3	
STATE_JLTX4		=	151				--精灵特效4	
STATE_JLTX5		=	152				--精灵特效5	
STATE_JLTX6		=	153				--精灵特效6	
STATE_JLTX7		=	154				--精灵特效7	
STATE_JLTX8		=	155				--精灵特效8	
STATE_CZZX		=	156				--纯真之心
STATE_KALA		=	157				--卡拉的胜利
STATE_5MBS		=	158				--5秒必死
STATE_ShanGD		=	159				--闪光弹
STATE_FuShe		=	160				--辐射
STATE_PSQ		=	161				--船只喷射器
STATE_PRD		=	162				--破刃弹
STATE_CZRSD		=	163				--船只燃烧弹
STATE_XUEYU		=	165				--最大HP物理抵抗类
STATE_MANTOU		=	166				--馒头加攻类
STATE_NVER		=	167				--女儿红加精类
STATE_JLFT2		=	168				--精灵附体
STATE_JLFT3		=	169				--精灵附体
STATE_JLFT4		=	170				--精灵附体
STATE_JLFT5		=	171				--精灵附体
STATE_JLFT6		=	172				--精灵附体
STATE_JLFT7		=	173				--精灵附体
STATE_JLFT8		=	174				--精灵附体
STATE_FSZQ              =       176                             --腐蚀之球
STATE_ZYZZ              =       177                             --噪音制造器
STATE_DZFS              =       178                             --地震发生器
STATE_LD                =       179                             --链弹
STATE_HYFS              =       180                             --幻影发生器
STATE_CZQX              =       181                             --船只潜行
STATE_LEIDA             =       182                             --雷达
STATE_FSD               =       183                             --腐蚀弹
STATE_Slrs              =       184                             --水雷燃烧 
STATE_Myrs              =       185                             --绵羊燃烧
STATE_LST               =       186                             --减速塔
STATE_HFZQ              =       187                             --回复之泉
STATE_EMYY              =       188                             --恶魔诅咒
STATE_YNZL              =       189                             --意念之力
STATE_JHKML             =       190                             --军火库没啦
STATE_BDH               =       191                             --冰冻环
STATE_DHZ		=	194				--蛋黄粽加防御
STATE_DSZ		=	195				--豆沙粽加速
STATE_APPLE		=	196				--双倍读书效率
STATE_ILOVEDAD		=	197				--老子爱父亲
STATE_HPHMHF		=	198				--缓慢回复生命类
STATE_SPHMHF		=	199				--缓慢回复法力类
STATE_BBRING1		=	200				--85BB牛戒加成
STATE_BBRING2		=	201				--85BB双戒加成
STATE_BBRING3		=	202				--85BB猎戒加成
STATE_BBRING4		=	203				--85BB航戒加成
STATE_BBRING5		=	204				--85BB封戒加成
STATE_BBRING6		=	205				--85BB圣戒加成
STATE_LANTERN		=	206				--领航灯笼
STATE_RAPIDDRUG		=	207				--轻装药水
STATE_WARSIT		=	208				--战狂药剂
STATE_DARKDRESS		=	209				--玄龙装甲
STATE_DEMON		=	210				--附魔针剂
STATE_GREATSH		=	211				--巨甲针剂
STATE_MIRAGE		=	212				--幻灵针剂
STATE_DEVOTE		=	213				--专注针剂
STATE_VIGOUR		=	214				--力狂针剂
STATE_SHIPDRIVE		=	215				--船只动力帆
STATE_SHIPRECOVER	=	216				--船只防御甲
STATE_BKDB		=	217				--不可入狱
STATE_XZDLL		=	218				--心中的力量戒指
STATE_XTMFS		=	219				--夏天的魔法书        by peter 2008.7.1   精神加倍
STATE_MWMXJ		=	220				--高超的莫邪剑        by peter 2008.7.1   力量加倍
STATE_FFJGD		=	221				--丰丰的金刚盾        by peter 2008.7.1   体力加倍
STATE_YSYS		=	43				--皮特的隐身药水      by peter 2008.7.1  隐身30秒
STATE_CD		=	199				--皮特的隐身药水      by peter 2008.7.1   冷却一分钟，随便加的效果
STATE_XLTX		=	224				--项链的效果          by Chaos 2008.7.3   
STATE_ZSZB		=	225				--宙斯自爆
STATE_CJRS		=	226				--状态燃烧
STATE_JLBYS		=	227				--100%精炼
STATE_HCBYS		=	228				--100%合成
STATE_zhongshen		=	229				--95BB套装
STATE_LEIPI		=	230				--占卜雷劈
STATE_XIANRENJIAO 	= 	231				--占卜仙人脚
STATE_CUSI 		= 	232				--占卜猝死
STATE_GANMAO		=	233				--占卜状态感冒
STATE_ZBMAXHP		= 	234				--女神盾HP上限
STATE_ZBHP		= 	235				--女神盾HP上限
STATE_ZBSP		= 	236				--SP上限
STATE_ZBMOVE		= 	237				--移动上限
STATE_GUOMIN		= 	238				--占卜过敏
STATE_QB		= 	239				--情报文件
STATE_XZK1		=	240				--星座卡
STATE_XZK2		=	241
STATE_XZK3		=	242
STATE_XZK4		=	243
STATE_XZK5		=	244
STATE_XZK6		=	245
STATE_XZK7		=	246
STATE_XZK8		=	247
STATE_XZK9		=	248
STATE_XZK10		=	249
STATE_XZK11		=	250
STATE_XZK12		=	251				--星座卡
STATE_HAIDAOQI		=	253	
STATE_Abhl 		=	8 				--暗之灵
STATE_Lbhl 		=	32				--雷之灵
STATE_Gbhl 		= 	192				--光之灵
STATE_CUSI2 		= 	25				--猝死2
STATE_BHLHP 		= 	52				--背后灵回复HP
STATE_BHLZD 		= 	175				--背后灵中毒
STATE_BHLXY 		= 	193   				--背后灵眩晕
STATE_HFHP  		=  	226  
STATE_XLZD  		= 	225
STATE_EMZL 		= 	254    				--恶魔之力
STATE_KZS  		= 	255    				--狂战士的愤怒
STATE_YFZZT 		=	256    				--御风者姿态
STATE_DYMX		=	258				--点线魔眼（圣魔之血）
STATE_TKZY   		=	259   				--痛苦之印效果
STATE_ZZZY   		=   	260    				--诅咒之炎效果
STATE_XRZY   		=   	261    				--虚弱之印效果
STATE_PKRING   		=   	263    				--PK戒指


dmg = 0					--伤害
sus = 1					--攻击状态
hpdmg = 0				--hp伤害
dmgsa = 1				--伤害倍数
dis = 0					--距离
dis_eff = 0				--距离效果
sklv = 0				--技能等级

ItemAttr_Rad	=	 { } 
ItemAttr_Rad	[	0	]	=	0	--	-1	无特殊属性加成
ItemAttr_Rad	[	1	]	=	10	--	蛮力之	+str
ItemAttr_Rad	[	2	]	=	10	--	必中之	+dex
ItemAttr_Rad	[	3	]	=	10	--	强体之	+con
ItemAttr_Rad	[	4	]	=	5	--	疾风之	+agi
ItemAttr_Rad	[	5	]	=	10	--	圣贤之	+sta
ItemAttr_Rad	[	6	]	=	0	--	-1	0
ItemAttr_Rad	[	7	]	=	0	--	-1	0
ItemAttr_Rad	[	8	]	=	0	--	-1	0
ItemAttr_Rad	[	9	]	=	0	--	-1	0
ItemAttr_Rad	[	10	]	=	0	--	-1	0
ItemAttr_Rad	[	11	]	=	10	--	黑龙之	+str +dex
ItemAttr_Rad	[	12	]	=	10	--	红龙之	+str +con
ItemAttr_Rad	[	13	]	=	5	--	蓝龙之	+str +agi 
ItemAttr_Rad	[	14	]	=	10	--	银龙之	+str +sta
ItemAttr_Rad	[	15	]	=	10	--	百龙之	+dex +con
ItemAttr_Rad	[	16	]	=	5	--	绿龙之	+dex +agi
ItemAttr_Rad	[	17	]	=	10	--	黄龙之	+dex +sta
ItemAttr_Rad	[	18	]	=	5	--	金龙之	+con +agi
ItemAttr_Rad	[	19	]	=	10	--	圣龙之	+con +sta
ItemAttr_Rad	[	20	]	=	5	--	魔龙之	+agi +sta
ItemAttr_Rad	[	21	]	=	0	--	-1	0
ItemAttr_Rad	[	22	]	=	0	--	-1	0
ItemAttr_Rad	[	23	]	=	0	--	-1	0
ItemAttr_Rad	[	24	]	=	0	--	-1	0
ItemAttr_Rad	[	25	]	=	0	--	-1	0
ItemAttr_Rad	[	26	]	=	0	--	-1	0
ItemAttr_Rad	[	27	]	=	0	--	-1	0
ItemAttr_Rad	[	28	]	=	0	--	-1	0
ItemAttr_Rad	[	29	]	=	0	--	-1	0
ItemAttr_Rad	[	30	]	=	0	--	-1	0
ItemAttr_Rad	[	31	]	=	0	--	-1	0
ItemAttr_Rad	[	32	]	=	0	--	-1	0
ItemAttr_Rad	[	33	]	=	0	--	-1	0
ItemAttr_Rad	[	34	]	=	0	--	-1	0
ItemAttr_Rad	[	35	]	=	0	--	-1	0
ItemAttr_Rad	[	36	]	=	0	--	-1	0
ItemAttr_Rad	[	37	]	=	0	--	-1	0
ItemAttr_Rad	[	38	]	=	0	--	-1	0
ItemAttr_Rad	[	39	]	=	0	--	-1	0
ItemAttr_Rad	[	40	]	=	0	--	-1	0
ItemAttr_Rad	[	41	]	=	0	--	-1	0
ItemAttr_Rad	[	42	]	=	0	--	-1	0
ItemAttr_Rad	[	43	]	=	0	--	-1	0
ItemAttr_Rad	[	44	]	=	0	--	-1	0
ItemAttr_Rad	[	45	]	=	0	--	-1	0
ItemAttr_Rad	[	46	]	=	0	--	-1	0
ItemAttr_Rad	[	47	]	=	0	--	-1	0
ItemAttr_Rad	[	48	]	=	0	--	-1	0
ItemAttr_Rad	[	49	]	=	0	--	-1	0
ItemAttr_Rad	[	50	]	=	10	--	卡拉之	+str +dex +con
ItemAttr_Rad	[	51	]	=	5	--	卡拉之	+str +dex +agi
ItemAttr_Rad	[	52	]	=	10	--	卡拉之	+str +dex +sta
ItemAttr_Rad	[	53	]	=	5	--	卡拉之	+str +con +agi
ItemAttr_Rad	[	54	]	=	10	--	卡拉之	+str +con +sta
ItemAttr_Rad	[	55	]	=	5	--	卡拉之	+str +agi +sta
ItemAttr_Rad	[	56	]	=	5	--	卡拉之	+dex +con +agi
ItemAttr_Rad	[	57	]	=	10	--	卡拉之	+dex +con +sta
ItemAttr_Rad	[	58	]	=	5	--	卡拉之	+dex +agi +sta
ItemAttr_Rad	[	59	]	=	5	--	卡拉之	+con +agi +sta
ItemAttr_Rad	[	60	]	=	0	--	-1	0
ItemAttr_Rad	[	61	]	=	0	--	-1	0
ItemAttr_Rad	[	62	]	=	0	--	-1	0
ItemAttr_Rad	[	63	]	=	0	--	-1	0
ItemAttr_Rad	[	64	]	=	0	--	-1	0
ItemAttr_Rad	[	65	]	=	0	--	-1	0
ItemAttr_Rad	[	66	]	=	0	--	-1	0
ItemAttr_Rad	[	67	]	=	0	--	-1	0
ItemAttr_Rad	[	68	]	=	0	--	-1	0
ItemAttr_Rad	[	69	]	=	0	--	-1	0
ItemAttr_Rad	[	70	]	=	0	--	-1	0
ItemAttr_Rad	[	71	]	=	0	--	-1	0
ItemAttr_Rad	[	72	]	=	0	--	-1	0
ItemAttr_Rad	[	73	]	=	0	--	-1	0
ItemAttr_Rad	[	74	]	=	0	--	-1	0
ItemAttr_Rad	[	75	]	=	0	--	-1	0
ItemAttr_Rad	[	76	]	=	0	--	-1	0
ItemAttr_Rad	[	77	]	=	0	--	-1	0
ItemAttr_Rad	[	78	]	=	0	--	-1	0
ItemAttr_Rad	[	79	]	=	0	--	-1	0
ItemAttr_Rad	[	80	]	=	0	--	-1	0
ItemAttr_Rad	[	81	]	=	0	--	-1	0
ItemAttr_Rad	[	82	]	=	0	--	-1	0
ItemAttr_Rad	[	83	]	=	0	--	-1	0
ItemAttr_Rad	[	84	]	=	0	--	-1	0
ItemAttr_Rad	[	85	]	=	0	--	-1	0
ItemAttr_Rad	[	86	]	=	0	--	-1	0
ItemAttr_Rad	[	87	]	=	0	--	-1	0
ItemAttr_Rad	[	88	]	=	0	--	-1	0
ItemAttr_Rad	[	89	]	=	0	--	-1	0
ItemAttr_Rad	[	90	]	=	10	--	维尔之	 +str +dex +con +agi
ItemAttr_Rad	[	91	]	=	10	--	维尔之	 +str +dex +con +sta
ItemAttr_Rad	[	92	]	=	10	--	维尔之	 +str +dex +agi +sta
ItemAttr_Rad	[	93	]	=	10	--	维尔之	 +str +con +agi +sta
ItemAttr_Rad	[	94	]	=	10	--	维尔之	 +dex +con +agi +sta
ItemAttr_Rad	[	95	]	=	0	--	-1	0
ItemAttr_Rad	[	96	]	=	0	--	-1	0
ItemAttr_Rad	[	97	]	=	0	--	-1	0
ItemAttr_Rad	[	98	]	=	0	--	-1	0
ItemAttr_Rad	[	99	]	=	0	--	-1	0


NewBox_Maxcount = 68
NewBox_Id={}		NewBox_ItemEffect={}	
NewBox_Id[1]=	5710	NewBox_ItemEffect[1]=	ItemUse_purplebox
NewBox_Id[2]=	5711	NewBox_ItemEffect[2]=	ItemUse_greenbox
NewBox_Id[3]=	5712	NewBox_ItemEffect[3]=	ItemUse_turebox
NewBox_Id[4]=	5713	NewBox_ItemEffect[4]=	ItemUse_respectbox
NewBox_Id[5]=	5714	NewBox_ItemEffect[5]=	ItemUse_peerlessbox
NewBox_Id[6]=	0580	NewBox_ItemEffect[6]=	ItemUse_Sjz
NewBox_Id[7]=	0581	NewBox_ItemEffect[7]=	ItemUse_Sxl
NewBox_Id[8]=	0582	NewBox_ItemEffect[8]=	ItemUse_Sbk
NewBox_Id[9]=	2515	NewBox_ItemEffect[9]=	ItemUse_hjjz
NewBox_Id[10]=	2516	NewBox_ItemEffect[10]=	ItemUse_zsjz
NewBox_Id[11]=	2517	NewBox_ItemEffect[11]=	ItemUse_bjxl
NewBox_Id[12]=	2518	NewBox_ItemEffect[12]=	ItemUse_hjxl
NewBox_Id[13]=	2519	NewBox_ItemEffect[13]=	ItemUse_gjxl
NewBox_Id[14]=	6663	NewBox_ItemEffect[14]=	ItemUse_65JZDH
NewBox_Id[15]=	6664	NewBox_ItemEffect[15]=	ItemUse_75JZDH
NewBox_Id[16]=	0242	NewBox_ItemEffect[16]=	ItemUse_byjz
NewBox_Id[17]=	6719	NewBox_ItemEffect[17]=	ItemUse_XianHe1Box
NewBox_Id[18]=	6720	NewBox_ItemEffect[18]=	ItemUse_XianHe2Box
NewBox_Id[19]=	6721	NewBox_ItemEffect[19]=	ItemUse_XianHe3Box
NewBox_Id[20]=	6722	NewBox_ItemEffect[20]=	ItemUse_XianHe4Box
NewBox_Id[21]=	6723	NewBox_ItemEffect[21]=	ItemUse_XianHe5Box
NewBox_Id[22]=	6724	NewBox_ItemEffect[22]=	ItemUse_XianHe6Box
NewBox_Id[23]=	6725	NewBox_ItemEffect[23]=	ItemUse_XianHe7Box
NewBox_Id[24]=	6726	NewBox_ItemEffect[24]=	ItemUse_XianHe8Box
NewBox_Id[25]=	6727	NewBox_ItemEffect[25]=	ItemUse_XianHe9Box
NewBox_Id[26]=	6728	NewBox_ItemEffect[26]=	ItemUse_XianHe10Box
NewBox_Id[27]=	6729	NewBox_ItemEffect[27]=	ItemUse_XianHe11Box
NewBox_Id[28]=	6730	NewBox_ItemEffect[28]=	ItemUse_XianHe12Box
NewBox_Id[29]=	6731	NewBox_ItemEffect[29]=	ItemUse_XianHe13Box
NewBox_Id[30]=	6732	NewBox_ItemEffect[30]=	ItemUse_XianHe14Box
NewBox_Id[31]=	6733	NewBox_ItemEffect[31]=	ItemUse_XianHe15Box
NewBox_Id[32]=	6734	NewBox_ItemEffect[32]=	ItemUse_XianHe16Box
NewBox_Id[33]=	6735	NewBox_ItemEffect[33]=	ItemUse_XianHe17Box
NewBox_Id[34]=	6736	NewBox_ItemEffect[34]=	ItemUse_XianHe18Box
NewBox_Id[35]=	6737	NewBox_ItemEffect[35]=	ItemUse_XianHe19Box
NewBox_Id[36]=	6738	NewBox_ItemEffect[36]=	ItemUse_XianHe20Box
NewBox_Id[37]=	6739	NewBox_ItemEffect[37]=	ItemUse_XianHe21Box
NewBox_Id[38]=	6740	NewBox_ItemEffect[38]=	ItemUse_XianHe22Box
NewBox_Id[39]=	6741	NewBox_ItemEffect[39]=	ItemUse_ShenHe1Box
NewBox_Id[40]=	6742	NewBox_ItemEffect[40]=	ItemUse_ShenHe2Box
NewBox_Id[41]=	6743	NewBox_ItemEffect[41]=	ItemUse_ShenHe3Box
NewBox_Id[42]=	6744	NewBox_ItemEffect[42]=	ItemUse_ShenHe4Box
NewBox_Id[43]=	6745	NewBox_ItemEffect[43]=	ItemUse_ShenHe5Box
NewBox_Id[44]=	6746	NewBox_ItemEffect[44]=	ItemUse_ShenHe6Box
NewBox_Id[45]=	6747	NewBox_ItemEffect[45]=	ItemUse_ShenHe7Box
NewBox_Id[46]=	6748	NewBox_ItemEffect[46]=	ItemUse_ShenHe8Box
NewBox_Id[47]=	6749	NewBox_ItemEffect[47]=	ItemUse_ShenHe9Box
NewBox_Id[48]=	6750	NewBox_ItemEffect[48]=	ItemUse_ShenHe10Box
NewBox_Id[49]=	6751	NewBox_ItemEffect[49]=	ItemUse_ShenHe11Box
NewBox_Id[50]=	6752	NewBox_ItemEffect[50]=	ItemUse_ShenHe12Box
NewBox_Id[51]=	6753	NewBox_ItemEffect[51]=	ItemUse_ShenHe13Box
NewBox_Id[52]=	6754	NewBox_ItemEffect[52]=	ItemUse_ShenHe14Box
NewBox_Id[53]=	6755	NewBox_ItemEffect[53]=	ItemUse_ShenHe15Box
NewBox_Id[54]=	6756	NewBox_ItemEffect[54]=	ItemUse_ShenHe16Box
NewBox_Id[55]=	6757	NewBox_ItemEffect[55]=	ItemUse_ShenHe17Box
NewBox_Id[56]=	6758	NewBox_ItemEffect[56]=	ItemUse_ShenHe18Box
NewBox_Id[57]=	6759	NewBox_ItemEffect[57]=	ItemUse_ShenHe19Box
NewBox_Id[58]=	6760	NewBox_ItemEffect[58]=	ItemUse_ShenHe20Box
NewBox_Id[59]=	6761	NewBox_ItemEffect[59]=	ItemUse_ShenHe21Box
NewBox_Id[60]=	6762	NewBox_ItemEffect[60]=	ItemUse_ShenHe22Box
NewBox_Id[61]=	5611	NewBox_ItemEffect[61]=	ItemUse_superticket
NewBox_Id[62]=	5612	NewBox_ItemEffect[62]=	ItemUse_supergodness
NewBox_Id[63]=	5613	NewBox_ItemEffect[63]=	ItemUse_platinadress
NewBox_Id[64]=	5614	NewBox_ItemEffect[64]=	ItemUse_platinayear
NewBox_Id[65]=	5615	NewBox_ItemEffect[65]=	ItemUse_platinareful
NewBox_Id[66]=	1019	NewBox_ItemEffect[66]=	ItemUse_minibh
NewBox_Id[67]=	6808	NewBox_ItemEffect[67]=	ItemUse_MagicBox2
NewBox_Id[68]=	6472	NewBox_ItemEffect[68]=	ItemUse_MagicBox


NewKey_Id={}	
NewKey_Id[1]=	5702
NewKey_Id[2]=	5703
NewKey_Id[3]=	5704
NewKey_Id[4]=	5705
NewKey_Id[5]=	5706


	BaoXiang_HLBX_Qua	=	7	 			BaoXiang_HLBX_Mxcount	=	109										
	BaoXiang_HLBX	=	{}					BaoXiang_HLBX_Rad	=	{}					BaoXiang_HLBX_Count	=	{}			
	BaoXiang_HLBX	[	1	]	=	0004		BaoXiang_HLBX_Rad	[	1	]	=	1		BaoXiang_HLBX_Count	[	1	]	=	1
	BaoXiang_HLBX	[	2	]	=	0005		BaoXiang_HLBX_Rad	[	2	]	=	1		BaoXiang_HLBX_Count	[	2	]	=	1
	BaoXiang_HLBX	[	3	]	=	0006		BaoXiang_HLBX_Rad	[	3	]	=	1		BaoXiang_HLBX_Count	[	3	]	=	1
	BaoXiang_HLBX	[	4	]	=	0015		BaoXiang_HLBX_Rad	[	4	]	=	1		BaoXiang_HLBX_Count	[	4	]	=	1
	BaoXiang_HLBX	[	5	]	=	0016		BaoXiang_HLBX_Rad	[	5	]	=	1		BaoXiang_HLBX_Count	[	5	]	=	1
	BaoXiang_HLBX	[	6	]	=	0017		BaoXiang_HLBX_Rad	[	6	]	=	1		BaoXiang_HLBX_Count	[	6	]	=	1
	BaoXiang_HLBX	[	7	]	=	0039		BaoXiang_HLBX_Rad	[	7	]	=	1		BaoXiang_HLBX_Count	[	7	]	=	1
	BaoXiang_HLBX	[	8	]	=	0040		BaoXiang_HLBX_Rad	[	8	]	=	1		BaoXiang_HLBX_Count	[	8	]	=	1
	BaoXiang_HLBX	[	9	]	=	0041		BaoXiang_HLBX_Rad	[	9	]	=	1		BaoXiang_HLBX_Count	[	9	]	=	1
	BaoXiang_HLBX	[	10	]	=	0076		BaoXiang_HLBX_Rad	[	10	]	=	1		BaoXiang_HLBX_Count	[	10	]	=	1
	BaoXiang_HLBX	[	11	]	=	0077		BaoXiang_HLBX_Rad	[	11	]	=	1		BaoXiang_HLBX_Count	[	11	]	=	1
	BaoXiang_HLBX	[	12	]	=	0078		BaoXiang_HLBX_Rad	[	12	]	=	1		BaoXiang_HLBX_Count	[	12	]	=	1
	BaoXiang_HLBX	[	13	]	=	0100		BaoXiang_HLBX_Rad	[	13	]	=	1		BaoXiang_HLBX_Count	[	13	]	=	1
	BaoXiang_HLBX	[	14	]	=	0103		BaoXiang_HLBX_Rad	[	14	]	=	1		BaoXiang_HLBX_Count	[	14	]	=	1
	BaoXiang_HLBX	[	15	]	=	4303		BaoXiang_HLBX_Rad	[	15	]	=	1		BaoXiang_HLBX_Count	[	15	]	=	1
	BaoXiang_HLBX	[	16	]	=	0101		BaoXiang_HLBX_Rad	[	16	]	=	1		BaoXiang_HLBX_Count	[	16	]	=	1
	BaoXiang_HLBX	[	17	]	=	0102		BaoXiang_HLBX_Rad	[	17	]	=	1		BaoXiang_HLBX_Count	[	17	]	=	1
	BaoXiang_HLBX	[	18	]	=	4300		BaoXiang_HLBX_Rad	[	18	]	=	1		BaoXiang_HLBX_Count	[	18	]	=	1
	BaoXiang_HLBX	[	19	]	=	3122		BaoXiang_HLBX_Rad	[	19	]	=	15		BaoXiang_HLBX_Count	[	19	]	=	20
	BaoXiang_HLBX	[	20	]	=	3123		BaoXiang_HLBX_Rad	[	20	]	=	14		BaoXiang_HLBX_Count	[	20	]	=	15
	BaoXiang_HLBX	[	21	]	=	3124		BaoXiang_HLBX_Rad	[	21	]	=	13		BaoXiang_HLBX_Count	[	21	]	=	10
	BaoXiang_HLBX	[	22	]	=	3125		BaoXiang_HLBX_Rad	[	22	]	=	12		BaoXiang_HLBX_Count	[	22	]	=	9
	BaoXiang_HLBX	[	23	]	=	3126		BaoXiang_HLBX_Rad	[	23	]	=	11		BaoXiang_HLBX_Count	[	23	]	=	8
	BaoXiang_HLBX	[	24	]	=	3127		BaoXiang_HLBX_Rad	[	24	]	=	10		BaoXiang_HLBX_Count	[	24	]	=	7
	BaoXiang_HLBX	[	25	]	=	3128		BaoXiang_HLBX_Rad	[	25	]	=	9		BaoXiang_HLBX_Count	[	25	]	=	6
	BaoXiang_HLBX	[	26	]	=	3133		BaoXiang_HLBX_Rad	[	26	]	=	8		BaoXiang_HLBX_Count	[	26	]	=	10
	BaoXiang_HLBX	[	27	]	=	3134		BaoXiang_HLBX_Rad	[	27	]	=	7		BaoXiang_HLBX_Count	[	27	]	=	9
	BaoXiang_HLBX	[	28	]	=	3135		BaoXiang_HLBX_Rad	[	28	]	=	6		BaoXiang_HLBX_Count	[	28	]	=	8
	BaoXiang_HLBX	[	29	]	=	3136		BaoXiang_HLBX_Rad	[	29	]	=	5		BaoXiang_HLBX_Count	[	29	]	=	7
	BaoXiang_HLBX	[	30	]	=	3137		BaoXiang_HLBX_Rad	[	30	]	=	4		BaoXiang_HLBX_Count	[	30	]	=	6
	BaoXiang_HLBX	[	31	]	=	3138		BaoXiang_HLBX_Rad	[	31	]	=	3		BaoXiang_HLBX_Count	[	31	]	=	5
	BaoXiang_HLBX	[	32	]	=	3139		BaoXiang_HLBX_Rad	[	32	]	=	2		BaoXiang_HLBX_Count	[	32	]	=	4
	BaoXiang_HLBX	[	33	]	=	3140		BaoXiang_HLBX_Rad	[	33	]	=	1		BaoXiang_HLBX_Count	[	33	]	=	3
	BaoXiang_HLBX	[	34	]	=	0293		BaoXiang_HLBX_Rad	[	34	]	=	1		BaoXiang_HLBX_Count	[	34	]	=	1
	BaoXiang_HLBX	[	35	]	=	0295		BaoXiang_HLBX_Rad	[	35	]	=	1		BaoXiang_HLBX_Count	[	35	]	=	1
	BaoXiang_HLBX	[	36	]	=	0299		BaoXiang_HLBX_Rad	[	36	]	=	1		BaoXiang_HLBX_Count	[	36	]	=	1
	BaoXiang_HLBX	[	37	]	=	0300		BaoXiang_HLBX_Rad	[	37	]	=	1		BaoXiang_HLBX_Count	[	37	]	=	1
	BaoXiang_HLBX	[	38	]	=	0301		BaoXiang_HLBX_Rad	[	38	]	=	1		BaoXiang_HLBX_Count	[	38	]	=	1
	BaoXiang_HLBX	[	39	]	=	0302		BaoXiang_HLBX_Rad	[	39	]	=	1		BaoXiang_HLBX_Count	[	39	]	=	1
	BaoXiang_HLBX	[	40	]	=	0307		BaoXiang_HLBX_Rad	[	40	]	=	1		BaoXiang_HLBX_Count	[	40	]	=	1
	BaoXiang_HLBX	[	41	]	=	0310		BaoXiang_HLBX_Rad	[	41	]	=	1		BaoXiang_HLBX_Count	[	41	]	=	1
	BaoXiang_HLBX	[	42	]	=	0312		BaoXiang_HLBX_Rad	[	42	]	=	1		BaoXiang_HLBX_Count	[	42	]	=	1
	BaoXiang_HLBX	[	43	]	=	0314		BaoXiang_HLBX_Rad	[	43	]	=	1		BaoXiang_HLBX_Count	[	43	]	=	1
	BaoXiang_HLBX	[	44	]	=	0315		BaoXiang_HLBX_Rad	[	44	]	=	1		BaoXiang_HLBX_Count	[	44	]	=	1
	BaoXiang_HLBX	[	45	]	=	0316		BaoXiang_HLBX_Rad	[	45	]	=	1		BaoXiang_HLBX_Count	[	45	]	=	1
	BaoXiang_HLBX	[	46	]	=	0339		BaoXiang_HLBX_Rad	[	46	]	=	1		BaoXiang_HLBX_Count	[	46	]	=	1
	BaoXiang_HLBX	[	47	]	=	0341		BaoXiang_HLBX_Rad	[	47	]	=	1		BaoXiang_HLBX_Count	[	47	]	=	1
	BaoXiang_HLBX	[	48	]	=	0342		BaoXiang_HLBX_Rad	[	48	]	=	1		BaoXiang_HLBX_Count	[	48	]	=	1
	BaoXiang_HLBX	[	49	]	=	0343		BaoXiang_HLBX_Rad	[	49	]	=	1		BaoXiang_HLBX_Count	[	49	]	=	1
	BaoXiang_HLBX	[	50	]	=	0344		BaoXiang_HLBX_Rad	[	50	]	=	1		BaoXiang_HLBX_Count	[	50	]	=	1
	BaoXiang_HLBX	[	51	]	=	0345		BaoXiang_HLBX_Rad	[	51	]	=	1		BaoXiang_HLBX_Count	[	51	]	=	1
	BaoXiang_HLBX	[	52	]	=	0350		BaoXiang_HLBX_Rad	[	52	]	=	1		BaoXiang_HLBX_Count	[	52	]	=	1
	BaoXiang_HLBX	[	53	]	=	0353		BaoXiang_HLBX_Rad	[	53	]	=	1		BaoXiang_HLBX_Count	[	53	]	=	1
	BaoXiang_HLBX	[	54	]	=	0354		BaoXiang_HLBX_Rad	[	54	]	=	1		BaoXiang_HLBX_Count	[	54	]	=	1
	BaoXiang_HLBX	[	55	]	=	0355		BaoXiang_HLBX_Rad	[	55	]	=	1		BaoXiang_HLBX_Count	[	55	]	=	1
	BaoXiang_HLBX	[	56	]	=	0356		BaoXiang_HLBX_Rad	[	56	]	=	1		BaoXiang_HLBX_Count	[	56	]	=	1
	BaoXiang_HLBX	[	57	]	=	0357		BaoXiang_HLBX_Rad	[	57	]	=	1		BaoXiang_HLBX_Count	[	57	]	=	1
	BaoXiang_HLBX	[	58	]	=	0358		BaoXiang_HLBX_Rad	[	58	]	=	1		BaoXiang_HLBX_Count	[	58	]	=	1
	BaoXiang_HLBX	[	59	]	=	0361		BaoXiang_HLBX_Rad	[	59	]	=	1		BaoXiang_HLBX_Count	[	59	]	=	1
	BaoXiang_HLBX	[	60	]	=	0362		BaoXiang_HLBX_Rad	[	60	]	=	1		BaoXiang_HLBX_Count	[	60	]	=	1
	BaoXiang_HLBX	[	61	]	=	0363		BaoXiang_HLBX_Rad	[	61	]	=	1		BaoXiang_HLBX_Count	[	61	]	=	1
	BaoXiang_HLBX	[	62	]	=	0364		BaoXiang_HLBX_Rad	[	62	]	=	1		BaoXiang_HLBX_Count	[	62	]	=	1
	BaoXiang_HLBX	[	63	]	=	0367		BaoXiang_HLBX_Rad	[	63	]	=	1		BaoXiang_HLBX_Count	[	63	]	=	1
	BaoXiang_HLBX	[	64	]	=	0368		BaoXiang_HLBX_Rad	[	64	]	=	1		BaoXiang_HLBX_Count	[	64	]	=	1
	BaoXiang_HLBX	[	65	]	=	0369		BaoXiang_HLBX_Rad	[	65	]	=	1		BaoXiang_HLBX_Count	[	65	]	=	1
	BaoXiang_HLBX	[	66	]	=	0370		BaoXiang_HLBX_Rad	[	66	]	=	1		BaoXiang_HLBX_Count	[	66	]	=	1
	BaoXiang_HLBX	[	67	]	=	0371		BaoXiang_HLBX_Rad	[	67	]	=	1		BaoXiang_HLBX_Count	[	67	]	=	1
	BaoXiang_HLBX	[	68	]	=	0374		BaoXiang_HLBX_Rad	[	68	]	=	1		BaoXiang_HLBX_Count	[	68	]	=	1
	BaoXiang_HLBX	[	69	]	=	0375		BaoXiang_HLBX_Rad	[	69	]	=	1		BaoXiang_HLBX_Count	[	69	]	=	1
	BaoXiang_HLBX	[	70	]	=	0376		BaoXiang_HLBX_Rad	[	70	]	=	1		BaoXiang_HLBX_Count	[	70	]	=	1
	BaoXiang_HLBX	[	71	]	=	0377		BaoXiang_HLBX_Rad	[	71	]	=	1		BaoXiang_HLBX_Count	[	71	]	=	1
	BaoXiang_HLBX	[	72	]	=	0378		BaoXiang_HLBX_Rad	[	72	]	=	1		BaoXiang_HLBX_Count	[	72	]	=	1
	BaoXiang_HLBX	[	73	]	=	0379		BaoXiang_HLBX_Rad	[	73	]	=	1		BaoXiang_HLBX_Count	[	73	]	=	1
	BaoXiang_HLBX	[	74	]	=	0382		BaoXiang_HLBX_Rad	[	74	]	=	1		BaoXiang_HLBX_Count	[	74	]	=	1
	BaoXiang_HLBX	[	75	]	=	0820		BaoXiang_HLBX_Rad	[	75	]	=	1		BaoXiang_HLBX_Count	[	75	]	=	1
	BaoXiang_HLBX	[	76	]	=	0821		BaoXiang_HLBX_Rad	[	76	]	=	1		BaoXiang_HLBX_Count	[	76	]	=	1
	BaoXiang_HLBX	[	77	]	=	0870		BaoXiang_HLBX_Rad	[	77	]	=	1		BaoXiang_HLBX_Count	[	77	]	=	1
	BaoXiang_HLBX	[	78	]	=	0871		BaoXiang_HLBX_Rad	[	78	]	=	1		BaoXiang_HLBX_Count	[	78	]	=	1
	BaoXiang_HLBX	[	79	]	=	0875		BaoXiang_HLBX_Rad	[	79	]	=	1		BaoXiang_HLBX_Count	[	79	]	=	1
	BaoXiang_HLBX	[	80	]	=	0876		BaoXiang_HLBX_Rad	[	80	]	=	1		BaoXiang_HLBX_Count	[	80	]	=	1
	BaoXiang_HLBX	[	81	]	=	1787		BaoXiang_HLBX_Rad	[	81	]	=	20		BaoXiang_HLBX_Count	[	81	]	=	2
	BaoXiang_HLBX	[	82	]	=	1788		BaoXiang_HLBX_Rad	[	82	]	=	20		BaoXiang_HLBX_Count	[	82	]	=	2
	BaoXiang_HLBX	[	83	]	=	1789		BaoXiang_HLBX_Rad	[	83	]	=	20		BaoXiang_HLBX_Count	[	83	]	=	2
	BaoXiang_HLBX	[	84	]	=	1790		BaoXiang_HLBX_Rad	[	84	]	=	20		BaoXiang_HLBX_Count	[	84	]	=	2
	BaoXiang_HLBX	[	85	]	=	1791		BaoXiang_HLBX_Rad	[	85	]	=	20		BaoXiang_HLBX_Count	[	85	]	=	2
	BaoXiang_HLBX	[	86	]	=	1792		BaoXiang_HLBX_Rad	[	86	]	=	20		BaoXiang_HLBX_Count	[	86	]	=	2
	BaoXiang_HLBX	[	87	]	=	1793		BaoXiang_HLBX_Rad	[	87	]	=	20		BaoXiang_HLBX_Count	[	87	]	=	2
	BaoXiang_HLBX	[	88	]	=	1797		BaoXiang_HLBX_Rad	[	88	]	=	10		BaoXiang_HLBX_Count	[	88	]	=	1
	BaoXiang_HLBX	[	89	]	=	1798		BaoXiang_HLBX_Rad	[	89	]	=	10		BaoXiang_HLBX_Count	[	89	]	=	1
	BaoXiang_HLBX	[	90	]	=	1799		BaoXiang_HLBX_Rad	[	90	]	=	10		BaoXiang_HLBX_Count	[	90	]	=	1
	BaoXiang_HLBX	[	91	]	=	1800		BaoXiang_HLBX_Rad	[	91	]	=	10		BaoXiang_HLBX_Count	[	91	]	=	1
	BaoXiang_HLBX	[	92	]	=	1801		BaoXiang_HLBX_Rad	[	92	]	=	10		BaoXiang_HLBX_Count	[	92	]	=	1
	BaoXiang_HLBX	[	93	]	=	1802		BaoXiang_HLBX_Rad	[	93	]	=	10		BaoXiang_HLBX_Count	[	93	]	=	1
	BaoXiang_HLBX	[	94	]	=	1803		BaoXiang_HLBX_Rad	[	94	]	=	10		BaoXiang_HLBX_Count	[	94	]	=	1
	BaoXiang_HLBX	[	95	]	=	1804		BaoXiang_HLBX_Rad	[	95	]	=	10		BaoXiang_HLBX_Count	[	95	]	=	1
	BaoXiang_HLBX	[	96	]	=	1805		BaoXiang_HLBX_Rad	[	96	]	=	10		BaoXiang_HLBX_Count	[	96	]	=	1
	BaoXiang_HLBX	[	97	]	=	1806		BaoXiang_HLBX_Rad	[	97	]	=	10		BaoXiang_HLBX_Count	[	97	]	=	1
	BaoXiang_HLBX	[	98	]	=	1807		BaoXiang_HLBX_Rad	[	98	]	=	10		BaoXiang_HLBX_Count	[	98	]	=	1
	BaoXiang_HLBX	[	99	]	=	1808		BaoXiang_HLBX_Rad	[	99	]	=	10		BaoXiang_HLBX_Count	[	99	]	=	1
	BaoXiang_HLBX	[	100	]	=	1809		BaoXiang_HLBX_Rad	[	100	]	=	10		BaoXiang_HLBX_Count	[	100	]	=	1
	BaoXiang_HLBX	[	101	]	=	1810		BaoXiang_HLBX_Rad	[	101	]	=	10		BaoXiang_HLBX_Count	[	101	]	=	1
	BaoXiang_HLBX	[	102	]	=	1811		BaoXiang_HLBX_Rad	[	102	]	=	10		BaoXiang_HLBX_Count	[	102	]	=	1
	BaoXiang_HLBX	[	103	]	=	4606		BaoXiang_HLBX_Rad	[	103	]	=	10		BaoXiang_HLBX_Count	[	103	]	=	2
	BaoXiang_HLBX	[	104	]	=	4607		BaoXiang_HLBX_Rad	[	104	]	=	10		BaoXiang_HLBX_Count	[	104	]	=	1
	BaoXiang_HLBX	[	105	]	=	4608		BaoXiang_HLBX_Rad	[	105	]	=	10		BaoXiang_HLBX_Count	[	105	]	=	2
	BaoXiang_HLBX	[	106	]	=	4609		BaoXiang_HLBX_Rad	[	106	]	=	10		BaoXiang_HLBX_Count	[	106	]	=	1
	BaoXiang_HLBX	[	107	]	=	4610		BaoXiang_HLBX_Rad	[	107	]	=	10		BaoXiang_HLBX_Count	[	107	]	=	1
	BaoXiang_HLBX	[	108	]	=	0453		BaoXiang_HLBX_Rad	[	108	]	=	20 		BaoXiang_HLBX_Count	[	108	]	=	1
	BaoXiang_HLBX	[	109	]	=	0455		BaoXiang_HLBX_Rad	[	109	]	=	20 		BaoXiang_HLBX_Count	[	109	]	=	1
																			
																				
	BaoXiang_SMBX_Qua	=	7	 			BaoXiang_SMBX_Mxcount	=	166										
	BaoXiang_SMBX	=	{}					BaoXiang_SMBX_Rad	=	{}					BaoXiang_SMBX_Count	=	{}			
	BaoXiang_SMBX	[	1	]	=	4636		BaoXiang_SMBX_Rad	[	1	]	=	1		BaoXiang_SMBX_Count	[	1	]	=	1
	BaoXiang_SMBX	[	2	]	=	4637		BaoXiang_SMBX_Rad	[	2	]	=	1		BaoXiang_SMBX_Count	[	2	]	=	1
	BaoXiang_SMBX	[	3	]	=	4638		BaoXiang_SMBX_Rad	[	3	]	=	1		BaoXiang_SMBX_Count	[	3	]	=	1
	BaoXiang_SMBX	[	4	]	=	4639		BaoXiang_SMBX_Rad	[	4	]	=	1		BaoXiang_SMBX_Count	[	4	]	=	1
	BaoXiang_SMBX	[	5	]	=	4640		BaoXiang_SMBX_Rad	[	5	]	=	1		BaoXiang_SMBX_Count	[	5	]	=	1
	BaoXiang_SMBX	[	6	]	=	4691		BaoXiang_SMBX_Rad	[	6	]	=	1		BaoXiang_SMBX_Count	[	6	]	=	1
	BaoXiang_SMBX	[	7	]	=	4692		BaoXiang_SMBX_Rad	[	7	]	=	1		BaoXiang_SMBX_Count	[	7	]	=	1
	BaoXiang_SMBX	[	8	]	=	4693		BaoXiang_SMBX_Rad	[	8	]	=	1		BaoXiang_SMBX_Count	[	8	]	=	1
	BaoXiang_SMBX	[	9	]	=	4694		BaoXiang_SMBX_Rad	[	9	]	=	1		BaoXiang_SMBX_Count	[	9	]	=	1
	BaoXiang_SMBX	[	10	]	=	4695		BaoXiang_SMBX_Rad	[	10	]	=	1		BaoXiang_SMBX_Count	[	10	]	=	1
	BaoXiang_SMBX	[	11	]	=	0125		BaoXiang_SMBX_Rad	[	11	]	=	1		BaoXiang_SMBX_Count	[	11	]	=	1
	BaoXiang_SMBX	[	12	]	=	0301		BaoXiang_SMBX_Rad	[	12	]	=	1		BaoXiang_SMBX_Count	[	12	]	=	1
	BaoXiang_SMBX	[	13	]	=	0302		BaoXiang_SMBX_Rad	[	13	]	=	1		BaoXiang_SMBX_Count	[	13	]	=	1
	BaoXiang_SMBX	[	14	]	=	0315		BaoXiang_SMBX_Rad	[	14	]	=	1		BaoXiang_SMBX_Count	[	14	]	=	1
	BaoXiang_SMBX	[	15	]	=	0342		BaoXiang_SMBX_Rad	[	15	]	=	1		BaoXiang_SMBX_Count	[	15	]	=	1
	BaoXiang_SMBX	[	16	]	=	0356		BaoXiang_SMBX_Rad	[	16	]	=	1		BaoXiang_SMBX_Count	[	16	]	=	1
	BaoXiang_SMBX	[	17	]	=	0362		BaoXiang_SMBX_Rad	[	17	]	=	1		BaoXiang_SMBX_Count	[	17	]	=	1
	BaoXiang_SMBX	[	18	]	=	0375		BaoXiang_SMBX_Rad	[	18	]	=	1		BaoXiang_SMBX_Count	[	18	]	=	1
	BaoXiang_SMBX	[	19	]	=	0378		BaoXiang_SMBX_Rad	[	19	]	=	1		BaoXiang_SMBX_Count	[	19	]	=	1
	BaoXiang_SMBX	[	20	]	=	0388		BaoXiang_SMBX_Rad	[	20	]	=	1		BaoXiang_SMBX_Count	[	20	]	=	1
	BaoXiang_SMBX	[	21	]	=	0477		BaoXiang_SMBX_Rad	[	21	]	=	1		BaoXiang_SMBX_Count	[	21	]	=	1
	BaoXiang_SMBX	[	22	]	=	0478		BaoXiang_SMBX_Rad	[	22	]	=	1		BaoXiang_SMBX_Count	[	22	]	=	1
	BaoXiang_SMBX	[	23	]	=	0491		BaoXiang_SMBX_Rad	[	23	]	=	1		BaoXiang_SMBX_Count	[	23	]	=	1
	BaoXiang_SMBX	[	24	]	=	0518		BaoXiang_SMBX_Rad	[	24	]	=	1		BaoXiang_SMBX_Count	[	24	]	=	1
	BaoXiang_SMBX	[	25	]	=	0532		BaoXiang_SMBX_Rad	[	25	]	=	1		BaoXiang_SMBX_Count	[	25	]	=	1
	BaoXiang_SMBX	[	26	]	=	0538		BaoXiang_SMBX_Rad	[	26	]	=	1		BaoXiang_SMBX_Count	[	26	]	=	1
	BaoXiang_SMBX	[	27	]	=	0551		BaoXiang_SMBX_Rad	[	27	]	=	1		BaoXiang_SMBX_Count	[	27	]	=	1
	BaoXiang_SMBX	[	28	]	=	0554		BaoXiang_SMBX_Rad	[	28	]	=	1		BaoXiang_SMBX_Count	[	28	]	=	1
	BaoXiang_SMBX	[	29	]	=	0564		BaoXiang_SMBX_Rad	[	29	]	=	1		BaoXiang_SMBX_Count	[	29	]	=	1
	BaoXiang_SMBX	[	30	]	=	0653		BaoXiang_SMBX_Rad	[	30	]	=	1		BaoXiang_SMBX_Count	[	30	]	=	1
	BaoXiang_SMBX	[	31	]	=	0654		BaoXiang_SMBX_Rad	[	31	]	=	1		BaoXiang_SMBX_Count	[	31	]	=	1
	BaoXiang_SMBX	[	32	]	=	0667		BaoXiang_SMBX_Rad	[	32	]	=	1		BaoXiang_SMBX_Count	[	32	]	=	1
	BaoXiang_SMBX	[	33	]	=	0694		BaoXiang_SMBX_Rad	[	33	]	=	1		BaoXiang_SMBX_Count	[	33	]	=	1
	BaoXiang_SMBX	[	34	]	=	0708		BaoXiang_SMBX_Rad	[	34	]	=	1		BaoXiang_SMBX_Count	[	34	]	=	1
	BaoXiang_SMBX	[	35	]	=	0714		BaoXiang_SMBX_Rad	[	35	]	=	1		BaoXiang_SMBX_Count	[	35	]	=	1
	BaoXiang_SMBX	[	36	]	=	0727		BaoXiang_SMBX_Rad	[	36	]	=	1		BaoXiang_SMBX_Count	[	36	]	=	1
	BaoXiang_SMBX	[	37	]	=	0730		BaoXiang_SMBX_Rad	[	37	]	=	1		BaoXiang_SMBX_Count	[	37	]	=	1
	BaoXiang_SMBX	[	38	]	=	0740		BaoXiang_SMBX_Rad	[	38	]	=	1		BaoXiang_SMBX_Count	[	38	]	=	1
	BaoXiang_SMBX	[	39	]	=	2193		BaoXiang_SMBX_Rad	[	39	]	=	1		BaoXiang_SMBX_Count	[	39	]	=	1
	BaoXiang_SMBX	[	40	]	=	2199		BaoXiang_SMBX_Rad	[	40	]	=	1		BaoXiang_SMBX_Count	[	40	]	=	1
	BaoXiang_SMBX	[	41	]	=	2210		BaoXiang_SMBX_Rad	[	41	]	=	1		BaoXiang_SMBX_Count	[	41	]	=	1
	BaoXiang_SMBX	[	42	]	=	4301		BaoXiang_SMBX_Rad	[	42	]	=	1		BaoXiang_SMBX_Count	[	42	]	=	1
	BaoXiang_SMBX	[	43	]	=	4641		BaoXiang_SMBX_Rad	[	43	]	=	1		BaoXiang_SMBX_Count	[	43	]	=	1
	BaoXiang_SMBX	[	44	]	=	4642		BaoXiang_SMBX_Rad	[	44	]	=	1		BaoXiang_SMBX_Count	[	44	]	=	1
	BaoXiang_SMBX	[	45	]	=	4643		BaoXiang_SMBX_Rad	[	45	]	=	1		BaoXiang_SMBX_Count	[	45	]	=	1
	BaoXiang_SMBX	[	46	]	=	4644		BaoXiang_SMBX_Rad	[	46	]	=	1		BaoXiang_SMBX_Count	[	46	]	=	1
	BaoXiang_SMBX	[	47	]	=	4645		BaoXiang_SMBX_Rad	[	47	]	=	1		BaoXiang_SMBX_Count	[	47	]	=	1
	BaoXiang_SMBX	[	48	]	=	4696		BaoXiang_SMBX_Rad	[	48	]	=	1		BaoXiang_SMBX_Count	[	48	]	=	1
	BaoXiang_SMBX	[	49	]	=	4697		BaoXiang_SMBX_Rad	[	49	]	=	1		BaoXiang_SMBX_Count	[	49	]	=	1
	BaoXiang_SMBX	[	50	]	=	4698		BaoXiang_SMBX_Rad	[	50	]	=	1		BaoXiang_SMBX_Count	[	50	]	=	1
	BaoXiang_SMBX	[	51	]	=	4699		BaoXiang_SMBX_Rad	[	51	]	=	1		BaoXiang_SMBX_Count	[	51	]	=	1
	BaoXiang_SMBX	[	52	]	=	0229		BaoXiang_SMBX_Rad	[	52	]	=	1		BaoXiang_SMBX_Count	[	52	]	=	1
	BaoXiang_SMBX	[	53	]	=	0299		BaoXiang_SMBX_Rad	[	53	]	=	1		BaoXiang_SMBX_Count	[	53	]	=	1
	BaoXiang_SMBX	[	54	]	=	0312		BaoXiang_SMBX_Rad	[	54	]	=	1		BaoXiang_SMBX_Count	[	54	]	=	1
	BaoXiang_SMBX	[	55	]	=	0345		BaoXiang_SMBX_Rad	[	55	]	=	1		BaoXiang_SMBX_Count	[	55	]	=	1
	BaoXiang_SMBX	[	56	]	=	0355		BaoXiang_SMBX_Rad	[	56	]	=	1		BaoXiang_SMBX_Count	[	56	]	=	1
	BaoXiang_SMBX	[	57	]	=	0369		BaoXiang_SMBX_Rad	[	57	]	=	1		BaoXiang_SMBX_Count	[	57	]	=	1
	BaoXiang_SMBX	[	58	]	=	0371		BaoXiang_SMBX_Rad	[	58	]	=	1		BaoXiang_SMBX_Count	[	58	]	=	1
	BaoXiang_SMBX	[	59	]	=	0382		BaoXiang_SMBX_Rad	[	59	]	=	1		BaoXiang_SMBX_Count	[	59	]	=	1
	BaoXiang_SMBX	[	60	]	=	0385		BaoXiang_SMBX_Rad	[	60	]	=	1		BaoXiang_SMBX_Count	[	60	]	=	1
	BaoXiang_SMBX	[	61	]	=	0475		BaoXiang_SMBX_Rad	[	61	]	=	1		BaoXiang_SMBX_Count	[	61	]	=	1
	BaoXiang_SMBX	[	62	]	=	0488		BaoXiang_SMBX_Rad	[	62	]	=	1		BaoXiang_SMBX_Count	[	62	]	=	1
	BaoXiang_SMBX	[	63	]	=	0521		BaoXiang_SMBX_Rad	[	63	]	=	1		BaoXiang_SMBX_Count	[	63	]	=	1
	BaoXiang_SMBX	[	64	]	=	0531		BaoXiang_SMBX_Rad	[	64	]	=	1		BaoXiang_SMBX_Count	[	64	]	=	1
	BaoXiang_SMBX	[	65	]	=	0545		BaoXiang_SMBX_Rad	[	65	]	=	1		BaoXiang_SMBX_Count	[	65	]	=	1
	BaoXiang_SMBX	[	66	]	=	0547		BaoXiang_SMBX_Rad	[	66	]	=	1		BaoXiang_SMBX_Count	[	66	]	=	1
	BaoXiang_SMBX	[	67	]	=	0558		BaoXiang_SMBX_Rad	[	67	]	=	1		BaoXiang_SMBX_Count	[	67	]	=	1
	BaoXiang_SMBX	[	68	]	=	0561		BaoXiang_SMBX_Rad	[	68	]	=	1		BaoXiang_SMBX_Count	[	68	]	=	1
	BaoXiang_SMBX	[	69	]	=	0639		BaoXiang_SMBX_Rad	[	69	]	=	1		BaoXiang_SMBX_Count	[	69	]	=	1
	BaoXiang_SMBX	[	70	]	=	0651		BaoXiang_SMBX_Rad	[	70	]	=	1		BaoXiang_SMBX_Count	[	70	]	=	1
	BaoXiang_SMBX	[	71	]	=	0664		BaoXiang_SMBX_Rad	[	71	]	=	1		BaoXiang_SMBX_Count	[	71	]	=	1
	BaoXiang_SMBX	[	72	]	=	0697		BaoXiang_SMBX_Rad	[	72	]	=	1		BaoXiang_SMBX_Count	[	72	]	=	1
	BaoXiang_SMBX	[	73	]	=	0707		BaoXiang_SMBX_Rad	[	73	]	=	1		BaoXiang_SMBX_Count	[	73	]	=	1
	BaoXiang_SMBX	[	74	]	=	0721		BaoXiang_SMBX_Rad	[	74	]	=	1		BaoXiang_SMBX_Count	[	74	]	=	1
	BaoXiang_SMBX	[	75	]	=	0723		BaoXiang_SMBX_Rad	[	75	]	=	1		BaoXiang_SMBX_Count	[	75	]	=	1
	BaoXiang_SMBX	[	76	]	=	0734		BaoXiang_SMBX_Rad	[	76	]	=	1		BaoXiang_SMBX_Count	[	76	]	=	1
	BaoXiang_SMBX	[	77	]	=	0737		BaoXiang_SMBX_Rad	[	77	]	=	1		BaoXiang_SMBX_Count	[	77	]	=	1
	BaoXiang_SMBX	[	78	]	=	0821		BaoXiang_SMBX_Rad	[	78	]	=	1		BaoXiang_SMBX_Count	[	78	]	=	1
	BaoXiang_SMBX	[	79	]	=	0871		BaoXiang_SMBX_Rad	[	79	]	=	1		BaoXiang_SMBX_Count	[	79	]	=	1
	BaoXiang_SMBX	[	80	]	=	0876		BaoXiang_SMBX_Rad	[	80	]	=	1		BaoXiang_SMBX_Count	[	80	]	=	1
	BaoXiang_SMBX	[	81	]	=	2192		BaoXiang_SMBX_Rad	[	81	]	=	1		BaoXiang_SMBX_Count	[	81	]	=	1
	BaoXiang_SMBX	[	82	]	=	2204		BaoXiang_SMBX_Rad	[	82	]	=	1		BaoXiang_SMBX_Count	[	82	]	=	1
	BaoXiang_SMBX	[	83	]	=	2207		BaoXiang_SMBX_Rad	[	83	]	=	1		BaoXiang_SMBX_Count	[	83	]	=	1
	BaoXiang_SMBX	[	84	]	=	4646		BaoXiang_SMBX_Rad	[	84	]	=	1		BaoXiang_SMBX_Count	[	84	]	=	1
	BaoXiang_SMBX	[	85	]	=	4647		BaoXiang_SMBX_Rad	[	85	]	=	1		BaoXiang_SMBX_Count	[	85	]	=	1
	BaoXiang_SMBX	[	86	]	=	4648		BaoXiang_SMBX_Rad	[	86	]	=	1		BaoXiang_SMBX_Count	[	86	]	=	1
	BaoXiang_SMBX	[	87	]	=	4649		BaoXiang_SMBX_Rad	[	87	]	=	1		BaoXiang_SMBX_Count	[	87	]	=	1
	BaoXiang_SMBX	[	88	]	=	4650		BaoXiang_SMBX_Rad	[	88	]	=	1		BaoXiang_SMBX_Count	[	88	]	=	1
	BaoXiang_SMBX	[	89	]	=	4701		BaoXiang_SMBX_Rad	[	89	]	=	1		BaoXiang_SMBX_Count	[	89	]	=	1
	BaoXiang_SMBX	[	90	]	=	4702		BaoXiang_SMBX_Rad	[	90	]	=	1		BaoXiang_SMBX_Count	[	90	]	=	1
	BaoXiang_SMBX	[	91	]	=	4703		BaoXiang_SMBX_Rad	[	91	]	=	1		BaoXiang_SMBX_Count	[	91	]	=	1
	BaoXiang_SMBX	[	92	]	=	4704		BaoXiang_SMBX_Rad	[	92	]	=	1		BaoXiang_SMBX_Count	[	92	]	=	1
	BaoXiang_SMBX	[	93	]	=	4705		BaoXiang_SMBX_Rad	[	93	]	=	1		BaoXiang_SMBX_Count	[	93	]	=	1
	BaoXiang_SMBX	[	94	]	=	0021		BaoXiang_SMBX_Rad	[	94	]	=	1		BaoXiang_SMBX_Count	[	94	]	=	1
	BaoXiang_SMBX	[	95	]	=	0023		BaoXiang_SMBX_Rad	[	95	]	=	1		BaoXiang_SMBX_Count	[	95	]	=	1
	BaoXiang_SMBX	[	96	]	=	0045		BaoXiang_SMBX_Rad	[	96	]	=	1		BaoXiang_SMBX_Count	[	96	]	=	1
	BaoXiang_SMBX	[	97	]	=	0084		BaoXiang_SMBX_Rad	[	97	]	=	1		BaoXiang_SMBX_Count	[	97	]	=	1
	BaoXiang_SMBX	[	98	]	=	0108		BaoXiang_SMBX_Rad	[	98	]	=	1		BaoXiang_SMBX_Count	[	98	]	=	1
	BaoXiang_SMBX	[	99	]	=	0126		BaoXiang_SMBX_Rad	[	99	]	=	1		BaoXiang_SMBX_Count	[	99	]	=	1
	BaoXiang_SMBX	[	100	]	=	0228		BaoXiang_SMBX_Rad	[	100	]	=	1		BaoXiang_SMBX_Count	[	100	]	=	1
	BaoXiang_SMBX	[	101	]	=	0303		BaoXiang_SMBX_Rad	[	101	]	=	1		BaoXiang_SMBX_Count	[	101	]	=	1
	BaoXiang_SMBX	[	102	]	=	0316		BaoXiang_SMBX_Rad	[	102	]	=	1		BaoXiang_SMBX_Count	[	102	]	=	1
	BaoXiang_SMBX	[	103	]	=	0343		BaoXiang_SMBX_Rad	[	103	]	=	1		BaoXiang_SMBX_Count	[	103	]	=	1
	BaoXiang_SMBX	[	104	]	=	0357		BaoXiang_SMBX_Rad	[	104	]	=	1		BaoXiang_SMBX_Count	[	104	]	=	1
	BaoXiang_SMBX	[	105	]	=	0363		BaoXiang_SMBX_Rad	[	105	]	=	1		BaoXiang_SMBX_Count	[	105	]	=	1
	BaoXiang_SMBX	[	106	]	=	0376		BaoXiang_SMBX_Rad	[	106	]	=	1		BaoXiang_SMBX_Count	[	106	]	=	1
	BaoXiang_SMBX	[	107	]	=	0379		BaoXiang_SMBX_Rad	[	107	]	=	1		BaoXiang_SMBX_Count	[	107	]	=	1
	BaoXiang_SMBX	[	108	]	=	0391		BaoXiang_SMBX_Rad	[	108	]	=	1		BaoXiang_SMBX_Count	[	108	]	=	1
	BaoXiang_SMBX	[	109	]	=	0479		BaoXiang_SMBX_Rad	[	109	]	=	1		BaoXiang_SMBX_Count	[	109	]	=	1
	BaoXiang_SMBX	[	110	]	=	0492		BaoXiang_SMBX_Rad	[	110	]	=	1		BaoXiang_SMBX_Count	[	110	]	=	1
	BaoXiang_SMBX	[	111	]	=	0519		BaoXiang_SMBX_Rad	[	111	]	=	1		BaoXiang_SMBX_Count	[	111	]	=	1
	BaoXiang_SMBX	[	112	]	=	0533		BaoXiang_SMBX_Rad	[	112	]	=	1		BaoXiang_SMBX_Count	[	112	]	=	1
	BaoXiang_SMBX	[	113	]	=	0539		BaoXiang_SMBX_Rad	[	113	]	=	1		BaoXiang_SMBX_Count	[	113	]	=	1
	BaoXiang_SMBX	[	114	]	=	0552		BaoXiang_SMBX_Rad	[	114	]	=	1		BaoXiang_SMBX_Count	[	114	]	=	1
	BaoXiang_SMBX	[	115	]	=	0555		BaoXiang_SMBX_Rad	[	115	]	=	1		BaoXiang_SMBX_Count	[	115	]	=	1
	BaoXiang_SMBX	[	116	]	=	0567		BaoXiang_SMBX_Rad	[	116	]	=	1		BaoXiang_SMBX_Count	[	116	]	=	1
	BaoXiang_SMBX	[	117	]	=	0655		BaoXiang_SMBX_Rad	[	117	]	=	1		BaoXiang_SMBX_Count	[	117	]	=	1
	BaoXiang_SMBX	[	118	]	=	0668		BaoXiang_SMBX_Rad	[	118	]	=	1		BaoXiang_SMBX_Count	[	118	]	=	1
	BaoXiang_SMBX	[	119	]	=	0695		BaoXiang_SMBX_Rad	[	119	]	=	1		BaoXiang_SMBX_Count	[	119	]	=	1
	BaoXiang_SMBX	[	120	]	=	0709		BaoXiang_SMBX_Rad	[	120	]	=	1		BaoXiang_SMBX_Count	[	120	]	=	1
	BaoXiang_SMBX	[	121	]	=	0715		BaoXiang_SMBX_Rad	[	121	]	=	1		BaoXiang_SMBX_Count	[	121	]	=	1
	BaoXiang_SMBX	[	122	]	=	0728		BaoXiang_SMBX_Rad	[	122	]	=	1		BaoXiang_SMBX_Count	[	122	]	=	1
	BaoXiang_SMBX	[	123	]	=	0731		BaoXiang_SMBX_Rad	[	123	]	=	1		BaoXiang_SMBX_Count	[	123	]	=	1
	BaoXiang_SMBX	[	124	]	=	0743		BaoXiang_SMBX_Rad	[	124	]	=	1		BaoXiang_SMBX_Count	[	124	]	=	1
	BaoXiang_SMBX	[	125	]	=	2194		BaoXiang_SMBX_Rad	[	125	]	=	1		BaoXiang_SMBX_Count	[	125	]	=	1
	BaoXiang_SMBX	[	126	]	=	2200		BaoXiang_SMBX_Rad	[	126	]	=	1		BaoXiang_SMBX_Count	[	126	]	=	1
	BaoXiang_SMBX	[	127	]	=	2213		BaoXiang_SMBX_Rad	[	127	]	=	1		BaoXiang_SMBX_Count	[	127	]	=	1
	BaoXiang_SMBX	[	128	]	=	4302		BaoXiang_SMBX_Rad	[	128	]	=	1		BaoXiang_SMBX_Count	[	128	]	=	1
	BaoXiang_SMBX	[	129	]	=	4651		BaoXiang_SMBX_Rad	[	129	]	=	1		BaoXiang_SMBX_Count	[	129	]	=	1
	BaoXiang_SMBX	[	130	]	=	4652		BaoXiang_SMBX_Rad	[	130	]	=	1		BaoXiang_SMBX_Count	[	130	]	=	1
	BaoXiang_SMBX	[	131	]	=	4653		BaoXiang_SMBX_Rad	[	131	]	=	1		BaoXiang_SMBX_Count	[	131	]	=	1
	BaoXiang_SMBX	[	132	]	=	4654		BaoXiang_SMBX_Rad	[	132	]	=	1		BaoXiang_SMBX_Count	[	132	]	=	1
	BaoXiang_SMBX	[	133	]	=	4655		BaoXiang_SMBX_Rad	[	133	]	=	1		BaoXiang_SMBX_Count	[	133	]	=	1
	BaoXiang_SMBX	[	134	]	=	4706		BaoXiang_SMBX_Rad	[	134	]	=	1		BaoXiang_SMBX_Count	[	134	]	=	1
	BaoXiang_SMBX	[	135	]	=	4707		BaoXiang_SMBX_Rad	[	135	]	=	1		BaoXiang_SMBX_Count	[	135	]	=	1
	BaoXiang_SMBX	[	136	]	=	4708		BaoXiang_SMBX_Rad	[	136	]	=	1		BaoXiang_SMBX_Count	[	136	]	=	1
	BaoXiang_SMBX	[	137	]	=	4709		BaoXiang_SMBX_Rad	[	137	]	=	1		BaoXiang_SMBX_Count	[	137	]	=	1
	BaoXiang_SMBX	[	138	]	=	0230		BaoXiang_SMBX_Rad	[	138	]	=	1		BaoXiang_SMBX_Count	[	138	]	=	1
	BaoXiang_SMBX	[	139	]	=	0304		BaoXiang_SMBX_Rad	[	139	]	=	1		BaoXiang_SMBX_Count	[	139	]	=	1
	BaoXiang_SMBX	[	140	]	=	0317		BaoXiang_SMBX_Rad	[	140	]	=	1		BaoXiang_SMBX_Count	[	140	]	=	1
	BaoXiang_SMBX	[	141	]	=	0344		BaoXiang_SMBX_Rad	[	141	]	=	1		BaoXiang_SMBX_Count	[	141	]	=	1
	BaoXiang_SMBX	[	142	]	=	0358		BaoXiang_SMBX_Rad	[	142	]	=	1		BaoXiang_SMBX_Count	[	142	]	=	1
	BaoXiang_SMBX	[	143	]	=	0364		BaoXiang_SMBX_Rad	[	143	]	=	1		BaoXiang_SMBX_Count	[	143	]	=	1
	BaoXiang_SMBX	[	144	]	=	0377		BaoXiang_SMBX_Rad	[	144	]	=	1		BaoXiang_SMBX_Count	[	144	]	=	1
	BaoXiang_SMBX	[	145	]	=	0393		BaoXiang_SMBX_Rad	[	145	]	=	1		BaoXiang_SMBX_Count	[	145	]	=	1
	BaoXiang_SMBX	[	146	]	=	0394		BaoXiang_SMBX_Rad	[	146	]	=	1		BaoXiang_SMBX_Count	[	146	]	=	1
	BaoXiang_SMBX	[	147	]	=	0480		BaoXiang_SMBX_Rad	[	147	]	=	1		BaoXiang_SMBX_Count	[	147	]	=	1
	BaoXiang_SMBX	[	148	]	=	0493		BaoXiang_SMBX_Rad	[	148	]	=	1		BaoXiang_SMBX_Count	[	148	]	=	1
	BaoXiang_SMBX	[	149	]	=	0520		BaoXiang_SMBX_Rad	[	149	]	=	1		BaoXiang_SMBX_Count	[	149	]	=	1
	BaoXiang_SMBX	[	150	]	=	0534		BaoXiang_SMBX_Rad	[	150	]	=	1		BaoXiang_SMBX_Count	[	150	]	=	1
	BaoXiang_SMBX	[	151	]	=	0540		BaoXiang_SMBX_Rad	[	151	]	=	1		BaoXiang_SMBX_Count	[	151	]	=	1
	BaoXiang_SMBX	[	152	]	=	0553		BaoXiang_SMBX_Rad	[	152	]	=	1		BaoXiang_SMBX_Count	[	152	]	=	1
	BaoXiang_SMBX	[	153	]	=	0569		BaoXiang_SMBX_Rad	[	153	]	=	1		BaoXiang_SMBX_Count	[	153	]	=	1
	BaoXiang_SMBX	[	154	]	=	0570		BaoXiang_SMBX_Rad	[	154	]	=	1		BaoXiang_SMBX_Count	[	154	]	=	1
	BaoXiang_SMBX	[	155	]	=	0656		BaoXiang_SMBX_Rad	[	155	]	=	1		BaoXiang_SMBX_Count	[	155	]	=	1
	BaoXiang_SMBX	[	156	]	=	0669		BaoXiang_SMBX_Rad	[	156	]	=	1		BaoXiang_SMBX_Count	[	156	]	=	1
	BaoXiang_SMBX	[	157	]	=	0696		BaoXiang_SMBX_Rad	[	157	]	=	1		BaoXiang_SMBX_Count	[	157	]	=	1
	BaoXiang_SMBX	[	158	]	=	0710		BaoXiang_SMBX_Rad	[	158	]	=	1		BaoXiang_SMBX_Count	[	158	]	=	1
	BaoXiang_SMBX	[	159	]	=	0716		BaoXiang_SMBX_Rad	[	159	]	=	1		BaoXiang_SMBX_Count	[	159	]	=	1
	BaoXiang_SMBX	[	160	]	=	0729		BaoXiang_SMBX_Rad	[	160	]	=	1		BaoXiang_SMBX_Count	[	160	]	=	1
	BaoXiang_SMBX	[	161	]	=	0745		BaoXiang_SMBX_Rad	[	161	]	=	1		BaoXiang_SMBX_Count	[	161	]	=	1
	BaoXiang_SMBX	[	162	]	=	0746		BaoXiang_SMBX_Rad	[	162	]	=	1		BaoXiang_SMBX_Count	[	162	]	=	1
	BaoXiang_SMBX	[	163	]	=	1477		BaoXiang_SMBX_Rad	[	163	]	=	1		BaoXiang_SMBX_Count	[	163	]	=	1
	BaoXiang_SMBX	[	164	]	=	2195		BaoXiang_SMBX_Rad	[	164	]	=	1		BaoXiang_SMBX_Count	[	164	]	=	1
	BaoXiang_SMBX	[	165	]	=	2201		BaoXiang_SMBX_Rad	[	165	]	=	1		BaoXiang_SMBX_Count	[	165	]	=	1
	BaoXiang_SMBX	[	166	]	=	2215		BaoXiang_SMBX_Rad	[	166	]	=	1		BaoXiang_SMBX_Count	[	166	]	=	1
	
																			
	BaoXiang_WZX_Qua	=	98	 			BaoXiang_WZX_Mxcount	=	153									
	BaoXiang_WZX	=	{}					BaoXiang_WZX_Rad	=	{}					BaoXiang_WZX_Count	=	{}			
	BaoXiang_WZX	[	1	]	=	0004		BaoXiang_WZX_Rad	[	1	]	=	1		BaoXiang_WZX_Count	[	1	]	=	1
	BaoXiang_WZX	[	2	]	=	0005		BaoXiang_WZX_Rad	[	2	]	=	1		BaoXiang_WZX_Count	[	2	]	=	1
	BaoXiang_WZX	[	3	]	=	0006		BaoXiang_WZX_Rad	[	3	]	=	1		BaoXiang_WZX_Count	[	3	]	=	1
	BaoXiang_WZX	[	4	]	=	0015		BaoXiang_WZX_Rad	[	4	]	=	1		BaoXiang_WZX_Count	[	4	]	=	1
	BaoXiang_WZX	[	5	]	=	0016		BaoXiang_WZX_Rad	[	5	]	=	1		BaoXiang_WZX_Count	[	5	]	=	1
	BaoXiang_WZX	[	6	]	=	0017		BaoXiang_WZX_Rad	[	6	]	=	1		BaoXiang_WZX_Count	[	6	]	=	1
	BaoXiang_WZX	[	7	]	=	0039		BaoXiang_WZX_Rad	[	7	]	=	1		BaoXiang_WZX_Count	[	7	]	=	1
	BaoXiang_WZX	[	8	]	=	0040		BaoXiang_WZX_Rad	[	8	]	=	1		BaoXiang_WZX_Count	[	8	]	=	1
	BaoXiang_WZX	[	9	]	=	0041		BaoXiang_WZX_Rad	[	9	]	=	1		BaoXiang_WZX_Count	[	9	]	=	1
	BaoXiang_WZX	[	10	]	=	0076		BaoXiang_WZX_Rad	[	10	]	=	1		BaoXiang_WZX_Count	[	10	]	=	1
	BaoXiang_WZX	[	11	]	=	0077		BaoXiang_WZX_Rad	[	11	]	=	1		BaoXiang_WZX_Count	[	11	]	=	1
	BaoXiang_WZX	[	12	]	=	0078		BaoXiang_WZX_Rad	[	12	]	=	1		BaoXiang_WZX_Count	[	12	]	=	1
	BaoXiang_WZX	[	13	]	=	0100		BaoXiang_WZX_Rad	[	13	]	=	1		BaoXiang_WZX_Count	[	13	]	=	1
	BaoXiang_WZX	[	14	]	=	0103		BaoXiang_WZX_Rad	[	14	]	=	1		BaoXiang_WZX_Count	[	14	]	=	1
	BaoXiang_WZX	[	15	]	=	4303		BaoXiang_WZX_Rad	[	15	]	=	1		BaoXiang_WZX_Count	[	15	]	=	1
	BaoXiang_WZX	[	16	]	=	0101		BaoXiang_WZX_Rad	[	16	]	=	1		BaoXiang_WZX_Count	[	16	]	=	1
	BaoXiang_WZX	[	17	]	=	0102		BaoXiang_WZX_Rad	[	17	]	=	1		BaoXiang_WZX_Count	[	17	]	=	1
	BaoXiang_WZX	[	18	]	=	4300		BaoXiang_WZX_Rad	[	18	]	=	1		BaoXiang_WZX_Count	[	18	]	=	1
	BaoXiang_WZX	[	19	]	=	3122		BaoXiang_WZX_Rad	[	19	]	=	25		BaoXiang_WZX_Count	[	19	]	=	20
	BaoXiang_WZX	[	20	]	=	3123		BaoXiang_WZX_Rad	[	20	]	=	25		BaoXiang_WZX_Count	[	20	]	=	15
	BaoXiang_WZX	[	21	]	=	3124		BaoXiang_WZX_Rad	[	21	]	=	25		BaoXiang_WZX_Count	[	21	]	=	10
	BaoXiang_WZX	[	22	]	=	3125		BaoXiang_WZX_Rad	[	22	]	=	25		BaoXiang_WZX_Count	[	22	]	=	9
	BaoXiang_WZX	[	23	]	=	3126		BaoXiang_WZX_Rad	[	23	]	=	25		BaoXiang_WZX_Count	[	23	]	=	8
	BaoXiang_WZX	[	24	]	=	3127		BaoXiang_WZX_Rad	[	24	]	=	20		BaoXiang_WZX_Count	[	24	]	=	7
	BaoXiang_WZX	[	25	]	=	3128		BaoXiang_WZX_Rad	[	25	]	=	20		BaoXiang_WZX_Count	[	25	]	=	6
	BaoXiang_WZX	[	26	]	=	3133		BaoXiang_WZX_Rad	[	26	]	=	20		BaoXiang_WZX_Count	[	26	]	=	10
	BaoXiang_WZX	[	27	]	=	3134		BaoXiang_WZX_Rad	[	27	]	=	20		BaoXiang_WZX_Count	[	27	]	=	9
	BaoXiang_WZX	[	28	]	=	3135		BaoXiang_WZX_Rad	[	28	]	=	20		BaoXiang_WZX_Count	[	28	]	=	8
	BaoXiang_WZX	[	29	]	=	3136		BaoXiang_WZX_Rad	[	29	]	=	20		BaoXiang_WZX_Count	[	29	]	=	7
	BaoXiang_WZX	[	30	]	=	3137		BaoXiang_WZX_Rad	[	30	]	=	20		BaoXiang_WZX_Count	[	30	]	=	6
	BaoXiang_WZX	[	31	]	=	3138		BaoXiang_WZX_Rad	[	31	]	=	20		BaoXiang_WZX_Count	[	31	]	=	5
	BaoXiang_WZX	[	32	]	=	3139		BaoXiang_WZX_Rad	[	32	]	=	20		BaoXiang_WZX_Count	[	32	]	=	4
	BaoXiang_WZX	[	33	]	=	3140		BaoXiang_WZX_Rad	[	33	]	=	20		BaoXiang_WZX_Count	[	33	]	=	3
	BaoXiang_WZX	[	34	]	=	0293		BaoXiang_WZX_Rad	[	34	]	=	1		BaoXiang_WZX_Count	[	34	]	=	1
	BaoXiang_WZX	[	35	]	=	0295		BaoXiang_WZX_Rad	[	35	]	=	1		BaoXiang_WZX_Count	[	35	]	=	1
	BaoXiang_WZX	[	36	]	=	0299		BaoXiang_WZX_Rad	[	36	]	=	1		BaoXiang_WZX_Count	[	36	]	=	1
	BaoXiang_WZX	[	37	]	=	0300		BaoXiang_WZX_Rad	[	37	]	=	1		BaoXiang_WZX_Count	[	37	]	=	1
	BaoXiang_WZX	[	38	]	=	0301		BaoXiang_WZX_Rad	[	38	]	=	1		BaoXiang_WZX_Count	[	38	]	=	1
	BaoXiang_WZX	[	39	]	=	0302		BaoXiang_WZX_Rad	[	39	]	=	1		BaoXiang_WZX_Count	[	39	]	=	1
	BaoXiang_WZX	[	40	]	=	0307		BaoXiang_WZX_Rad	[	40	]	=	1		BaoXiang_WZX_Count	[	40	]	=	1
	BaoXiang_WZX	[	41	]	=	0310		BaoXiang_WZX_Rad	[	41	]	=	1		BaoXiang_WZX_Count	[	41	]	=	1
	BaoXiang_WZX	[	42	]	=	0312		BaoXiang_WZX_Rad	[	42	]	=	1		BaoXiang_WZX_Count	[	42	]	=	1
	BaoXiang_WZX	[	43	]	=	0314		BaoXiang_WZX_Rad	[	43	]	=	1		BaoXiang_WZX_Count	[	43	]	=	1
	BaoXiang_WZX	[	44	]	=	0315		BaoXiang_WZX_Rad	[	44	]	=	1		BaoXiang_WZX_Count	[	44	]	=	1
	BaoXiang_WZX	[	45	]	=	0316		BaoXiang_WZX_Rad	[	45	]	=	1		BaoXiang_WZX_Count	[	45	]	=	1
	BaoXiang_WZX	[	46	]	=	0339		BaoXiang_WZX_Rad	[	46	]	=	1		BaoXiang_WZX_Count	[	46	]	=	1
	BaoXiang_WZX	[	47	]	=	0341		BaoXiang_WZX_Rad	[	47	]	=	1		BaoXiang_WZX_Count	[	47	]	=	1
	BaoXiang_WZX	[	48	]	=	0342		BaoXiang_WZX_Rad	[	48	]	=	1		BaoXiang_WZX_Count	[	48	]	=	1
	BaoXiang_WZX	[	49	]	=	0343		BaoXiang_WZX_Rad	[	49	]	=	1		BaoXiang_WZX_Count	[	49	]	=	1
	BaoXiang_WZX	[	50	]	=	0344		BaoXiang_WZX_Rad	[	50	]	=	1		BaoXiang_WZX_Count	[	50	]	=	1
	BaoXiang_WZX	[	51	]	=	0345		BaoXiang_WZX_Rad	[	51	]	=	1		BaoXiang_WZX_Count	[	51	]	=	1
	BaoXiang_WZX	[	52	]	=	0350		BaoXiang_WZX_Rad	[	52	]	=	1		BaoXiang_WZX_Count	[	52	]	=	1
	BaoXiang_WZX	[	53	]	=	0353		BaoXiang_WZX_Rad	[	53	]	=	1		BaoXiang_WZX_Count	[	53	]	=	1
	BaoXiang_WZX	[	54	]	=	0354		BaoXiang_WZX_Rad	[	54	]	=	1		BaoXiang_WZX_Count	[	54	]	=	1
	BaoXiang_WZX	[	55	]	=	0355		BaoXiang_WZX_Rad	[	55	]	=	1		BaoXiang_WZX_Count	[	55	]	=	1
	BaoXiang_WZX	[	56	]	=	0356		BaoXiang_WZX_Rad	[	56	]	=	1		BaoXiang_WZX_Count	[	56	]	=	1
	BaoXiang_WZX	[	57	]	=	0357		BaoXiang_WZX_Rad	[	57	]	=	1		BaoXiang_WZX_Count	[	57	]	=	1
	BaoXiang_WZX	[	58	]	=	0358		BaoXiang_WZX_Rad	[	58	]	=	1		BaoXiang_WZX_Count	[	58	]	=	1
	BaoXiang_WZX	[	59	]	=	0361		BaoXiang_WZX_Rad	[	59	]	=	1		BaoXiang_WZX_Count	[	59	]	=	1
	BaoXiang_WZX	[	60	]	=	0362		BaoXiang_WZX_Rad	[	60	]	=	1		BaoXiang_WZX_Count	[	60	]	=	1
	BaoXiang_WZX	[	61	]	=	0363		BaoXiang_WZX_Rad	[	61	]	=	1		BaoXiang_WZX_Count	[	61	]	=	1
	BaoXiang_WZX	[	62	]	=	0364		BaoXiang_WZX_Rad	[	62	]	=	1		BaoXiang_WZX_Count	[	62	]	=	1
	BaoXiang_WZX	[	63	]	=	0367		BaoXiang_WZX_Rad	[	63	]	=	1		BaoXiang_WZX_Count	[	63	]	=	1
	BaoXiang_WZX	[	64	]	=	0368		BaoXiang_WZX_Rad	[	64	]	=	1		BaoXiang_WZX_Count	[	64	]	=	1
	BaoXiang_WZX	[	65	]	=	0369		BaoXiang_WZX_Rad	[	65	]	=	1		BaoXiang_WZX_Count	[	65	]	=	1
	BaoXiang_WZX	[	66	]	=	0370		BaoXiang_WZX_Rad	[	66	]	=	1		BaoXiang_WZX_Count	[	66	]	=	1
	BaoXiang_WZX	[	67	]	=	0371		BaoXiang_WZX_Rad	[	67	]	=	1		BaoXiang_WZX_Count	[	67	]	=	1
	BaoXiang_WZX	[	68	]	=	0374		BaoXiang_WZX_Rad	[	68	]	=	1		BaoXiang_WZX_Count	[	68	]	=	1
	BaoXiang_WZX	[	69	]	=	0375		BaoXiang_WZX_Rad	[	69	]	=	1		BaoXiang_WZX_Count	[	69	]	=	1
	BaoXiang_WZX	[	70	]	=	0376		BaoXiang_WZX_Rad	[	70	]	=	1		BaoXiang_WZX_Count	[	70	]	=	1
	BaoXiang_WZX	[	71	]	=	0377		BaoXiang_WZX_Rad	[	71	]	=	1		BaoXiang_WZX_Count	[	71	]	=	1
	BaoXiang_WZX	[	72	]	=	0378		BaoXiang_WZX_Rad	[	72	]	=	1		BaoXiang_WZX_Count	[	72	]	=	1
	BaoXiang_WZX	[	73	]	=	0379		BaoXiang_WZX_Rad	[	73	]	=	1		BaoXiang_WZX_Count	[	73	]	=	1
	BaoXiang_WZX	[	74	]	=	0382		BaoXiang_WZX_Rad	[	74	]	=	1		BaoXiang_WZX_Count	[	74	]	=	1
	BaoXiang_WZX	[	75	]	=	0820		BaoXiang_WZX_Rad	[	75	]	=	1		BaoXiang_WZX_Count	[	75	]	=	1
	BaoXiang_WZX	[	76	]	=	0821		BaoXiang_WZX_Rad	[	76	]	=	1		BaoXiang_WZX_Count	[	76	]	=	1
	BaoXiang_WZX	[	77	]	=	0870		BaoXiang_WZX_Rad	[	77	]	=	1		BaoXiang_WZX_Count	[	77	]	=	1
	BaoXiang_WZX	[	78	]	=	0871		BaoXiang_WZX_Rad	[	78	]	=	1		BaoXiang_WZX_Count	[	78	]	=	1
	BaoXiang_WZX	[	79	]	=	0875		BaoXiang_WZX_Rad	[	79	]	=	1		BaoXiang_WZX_Count	[	79	]	=	1
	BaoXiang_WZX	[	80	]	=	0876		BaoXiang_WZX_Rad	[	80	]	=	1		BaoXiang_WZX_Count	[	80	]	=	1
	BaoXiang_WZX	[	81	]	=	1787		BaoXiang_WZX_Rad	[	81	]	=	15		BaoXiang_WZX_Count	[	81	]	=	2
	BaoXiang_WZX	[	82	]	=	1788		BaoXiang_WZX_Rad	[	82	]	=	15		BaoXiang_WZX_Count	[	82	]	=	2
	BaoXiang_WZX	[	83	]	=	1789		BaoXiang_WZX_Rad	[	83	]	=	15		BaoXiang_WZX_Count	[	83	]	=	2
	BaoXiang_WZX	[	84	]	=	1790		BaoXiang_WZX_Rad	[	84	]	=	15		BaoXiang_WZX_Count	[	84	]	=	2
	BaoXiang_WZX	[	85	]	=	1791		BaoXiang_WZX_Rad	[	85	]	=	15		BaoXiang_WZX_Count	[	85	]	=	2
	BaoXiang_WZX	[	86	]	=	1792		BaoXiang_WZX_Rad	[	86	]	=	15		BaoXiang_WZX_Count	[	86	]	=	2
	BaoXiang_WZX	[	87	]	=	1793		BaoXiang_WZX_Rad	[	87	]	=	15		BaoXiang_WZX_Count	[	87	]	=	2
	BaoXiang_WZX	[	88	]	=	1797		BaoXiang_WZX_Rad	[	88	]	=	15		BaoXiang_WZX_Count	[	88	]	=	1
	BaoXiang_WZX	[	89	]	=	1798		BaoXiang_WZX_Rad	[	89	]	=	15		BaoXiang_WZX_Count	[	89	]	=	1
	BaoXiang_WZX	[	90	]	=	1799		BaoXiang_WZX_Rad	[	90	]	=	15		BaoXiang_WZX_Count	[	90	]	=	1
	BaoXiang_WZX	[	91	]	=	1800		BaoXiang_WZX_Rad	[	91	]	=	15		BaoXiang_WZX_Count	[	91	]	=	1
	BaoXiang_WZX	[	92	]	=	1801		BaoXiang_WZX_Rad	[	92	]	=	15		BaoXiang_WZX_Count	[	92	]	=	1
	BaoXiang_WZX	[	93	]	=	1802		BaoXiang_WZX_Rad	[	93	]	=	15		BaoXiang_WZX_Count	[	93	]	=	1
	BaoXiang_WZX	[	94	]	=	1803		BaoXiang_WZX_Rad	[	94	]	=	15		BaoXiang_WZX_Count	[	94	]	=	1
	BaoXiang_WZX	[	95	]	=	1804		BaoXiang_WZX_Rad	[	95	]	=	15		BaoXiang_WZX_Count	[	95	]	=	1
	BaoXiang_WZX	[	96	]	=	1805		BaoXiang_WZX_Rad	[	96	]	=	15		BaoXiang_WZX_Count	[	96	]	=	1
	BaoXiang_WZX	[	97	]	=	1806		BaoXiang_WZX_Rad	[	97	]	=	15		BaoXiang_WZX_Count	[	97	]	=	1
	BaoXiang_WZX	[	98	]	=	1807		BaoXiang_WZX_Rad	[	98	]	=	300		BaoXiang_WZX_Count	[	98	]	=	1
	BaoXiang_WZX	[	99	]	=	1808		BaoXiang_WZX_Rad	[	99	]	=	15		BaoXiang_WZX_Count	[	99	]	=	1
	BaoXiang_WZX	[	100	]	=	1809		BaoXiang_WZX_Rad	[	100	]	=	15		BaoXiang_WZX_Count	[	100	]	=	1
	BaoXiang_WZX	[	101	]	=	1810		BaoXiang_WZX_Rad	[	101	]	=	15		BaoXiang_WZX_Count	[	101	]	=	1
	BaoXiang_WZX	[	102	]	=	1811		BaoXiang_WZX_Rad	[	102	]	=	15		BaoXiang_WZX_Count	[	102	]	=	1
	BaoXiang_WZX	[	103	]	=	4606		BaoXiang_WZX_Rad	[	103	]	=	1		BaoXiang_WZX_Count	[	103	]	=	1
	BaoXiang_WZX	[	104	]	=	4607		BaoXiang_WZX_Rad	[	104	]	=	1		BaoXiang_WZX_Count	[	104	]	=	1
	BaoXiang_WZX	[	105	]	=	4608		BaoXiang_WZX_Rad	[	105	]	=	1		BaoXiang_WZX_Count	[	105	]	=	1
	BaoXiang_WZX	[	106	]	=	4609		BaoXiang_WZX_Rad	[	106	]	=	1		BaoXiang_WZX_Count	[	106	]	=	1
	BaoXiang_WZX	[	107	]	=	4610		BaoXiang_WZX_Rad	[	107	]	=	1		BaoXiang_WZX_Count	[	107	]	=	1
	BaoXiang_WZX	[	108	]	=	4636		BaoXiang_WZX_Rad	[	108	]	=	1		BaoXiang_WZX_Count	[	108	]	=	1
	BaoXiang_WZX	[	109	]	=	4637		BaoXiang_WZX_Rad	[	109	]	=	1		BaoXiang_WZX_Count	[	109	]	=	1
	BaoXiang_WZX	[	110	]	=	4638		BaoXiang_WZX_Rad	[	110	]	=	1		BaoXiang_WZX_Count	[	110	]	=	1
	BaoXiang_WZX	[	111	]	=	4639		BaoXiang_WZX_Rad	[	111	]	=	1		BaoXiang_WZX_Count	[	111	]	=	1
	BaoXiang_WZX	[	112	]	=	4640		BaoXiang_WZX_Rad	[	112	]	=	1		BaoXiang_WZX_Count	[	112	]	=	1
	BaoXiang_WZX	[	113	]	=	4691		BaoXiang_WZX_Rad	[	113	]	=	1		BaoXiang_WZX_Count	[	113	]	=	1
	BaoXiang_WZX	[	114	]	=	4692		BaoXiang_WZX_Rad	[	114	]	=	1		BaoXiang_WZX_Count	[	114	]	=	1
	BaoXiang_WZX	[	115	]	=	4693		BaoXiang_WZX_Rad	[	115	]	=	1		BaoXiang_WZX_Count	[	115	]	=	1
	BaoXiang_WZX	[	116	]	=	4694		BaoXiang_WZX_Rad	[	116	]	=	1		BaoXiang_WZX_Count	[	116	]	=	1
	BaoXiang_WZX	[	117	]	=	4695		BaoXiang_WZX_Rad	[	117	]	=	1		BaoXiang_WZX_Count	[	117	]	=	1
	BaoXiang_WZX	[	118	]	=	4641		BaoXiang_WZX_Rad	[	118	]	=	1		BaoXiang_WZX_Count	[	118	]	=	1
	BaoXiang_WZX	[	119	]	=	4642		BaoXiang_WZX_Rad	[	119	]	=	1		BaoXiang_WZX_Count	[	119	]	=	1
	BaoXiang_WZX	[	120	]	=	4643		BaoXiang_WZX_Rad	[	120	]	=	1		BaoXiang_WZX_Count	[	120	]	=	1
	BaoXiang_WZX	[	121	]	=	4644		BaoXiang_WZX_Rad	[	121	]	=	1		BaoXiang_WZX_Count	[	121	]	=	1
	BaoXiang_WZX	[	122	]	=	4645		BaoXiang_WZX_Rad	[	122	]	=	1		BaoXiang_WZX_Count	[	122	]	=	1
	BaoXiang_WZX	[	123	]	=	4696		BaoXiang_WZX_Rad	[	123	]	=	1		BaoXiang_WZX_Count	[	123	]	=	1
	BaoXiang_WZX	[	124	]	=	4697		BaoXiang_WZX_Rad	[	124	]	=	1		BaoXiang_WZX_Count	[	124	]	=	1
	BaoXiang_WZX	[	125	]	=	4698		BaoXiang_WZX_Rad	[	125	]	=	1		BaoXiang_WZX_Count	[	125	]	=	1
	BaoXiang_WZX	[	126	]	=	4699		BaoXiang_WZX_Rad	[	126	]	=	1		BaoXiang_WZX_Count	[	126	]	=	1
	BaoXiang_WZX	[	127	]	=	4646		BaoXiang_WZX_Rad	[	127	]	=	1		BaoXiang_WZX_Count	[	127	]	=	1
	BaoXiang_WZX	[	128	]	=	4647		BaoXiang_WZX_Rad	[	128	]	=	1		BaoXiang_WZX_Count	[	128	]	=	1
	BaoXiang_WZX	[	129	]	=	4648		BaoXiang_WZX_Rad	[	129	]	=	1		BaoXiang_WZX_Count	[	129	]	=	1
	BaoXiang_WZX	[	130	]	=	4649		BaoXiang_WZX_Rad	[	130	]	=	1		BaoXiang_WZX_Count	[	130	]	=	1
	BaoXiang_WZX	[	131	]	=	4650		BaoXiang_WZX_Rad	[	131	]	=	1		BaoXiang_WZX_Count	[	131	]	=	1
	BaoXiang_WZX	[	132	]	=	4701		BaoXiang_WZX_Rad	[	132	]	=	1		BaoXiang_WZX_Count	[	132	]	=	1
	BaoXiang_WZX	[	133	]	=	4702		BaoXiang_WZX_Rad	[	133	]	=	1		BaoXiang_WZX_Count	[	133	]	=	1
	BaoXiang_WZX	[	134	]	=	4703		BaoXiang_WZX_Rad	[	134	]	=	1		BaoXiang_WZX_Count	[	134	]	=	1
	BaoXiang_WZX	[	135	]	=	4704		BaoXiang_WZX_Rad	[	135	]	=	1		BaoXiang_WZX_Count	[	135	]	=	1
	BaoXiang_WZX	[	136	]	=	4705		BaoXiang_WZX_Rad	[	136	]	=	1		BaoXiang_WZX_Count	[	136	]	=	1
	BaoXiang_WZX	[	137	]	=	4651		BaoXiang_WZX_Rad	[	137	]	=	1		BaoXiang_WZX_Count	[	137	]	=	1
	BaoXiang_WZX	[	138	]	=	4652		BaoXiang_WZX_Rad	[	138	]	=	1		BaoXiang_WZX_Count	[	138	]	=	1
	BaoXiang_WZX	[	139	]	=	4653		BaoXiang_WZX_Rad	[	139	]	=	1		BaoXiang_WZX_Count	[	139	]	=	1
	BaoXiang_WZX	[	140	]	=	4654		BaoXiang_WZX_Rad	[	140	]	=	1		BaoXiang_WZX_Count	[	140	]	=	1
	BaoXiang_WZX	[	141	]	=	4655		BaoXiang_WZX_Rad	[	141	]	=	1		BaoXiang_WZX_Count	[	141	]	=	1
	BaoXiang_WZX	[	142	]	=	4706		BaoXiang_WZX_Rad	[	142	]	=	1		BaoXiang_WZX_Count	[	142	]	=	1
	BaoXiang_WZX	[	143	]	=	4707		BaoXiang_WZX_Rad	[	143	]	=	1		BaoXiang_WZX_Count	[	143	]	=	1
	BaoXiang_WZX	[	144	]	=	4708		BaoXiang_WZX_Rad	[	144	]	=	1		BaoXiang_WZX_Count	[	144	]	=	1
	BaoXiang_WZX	[	145	]	=	4709		BaoXiang_WZX_Rad	[	145	]	=	1		BaoXiang_WZX_Count	[	145	]	=	1
	BaoXiang_WZX	[	146	]	=	4543		BaoXiang_WZX_Rad	[	146	]	=	20		BaoXiang_WZX_Count	[	146	]	=	20
	BaoXiang_WZX	[	147	]	=	4544		BaoXiang_WZX_Rad	[	147	]	=	20		BaoXiang_WZX_Count	[	147	]	=	10
	BaoXiang_WZX	[	148	]	=	4545		BaoXiang_WZX_Rad	[	148	]	=	20		BaoXiang_WZX_Count	[	148	]	=	15
	BaoXiang_WZX	[	149	]	=	4546		BaoXiang_WZX_Rad	[	149	]	=	20		BaoXiang_WZX_Count	[	149	]	=	10
	BaoXiang_WZX	[	150	]	=	1478		BaoXiang_WZX_Rad	[	150	]	=	20		BaoXiang_WZX_Count	[	150	]	=	20
	BaoXiang_WZX	[	151	]	=	0227		BaoXiang_WZX_Rad	[	151	]	=	60 		BaoXiang_WZX_Count	[	151	]	=	1
	BaoXiang_WZX	[	152	]	=	0453		BaoXiang_WZX_Rad	[	152	]	=	60 		BaoXiang_WZX_Count	[	152	]	=	1
	BaoXiang_WZX	[	153	]	=	0455		BaoXiang_WZX_Rad	[	153	]	=	60 		BaoXiang_WZX_Count	[	153	]	=	1
																		
																																							
	BaoXiang_KLJS_Qua	=	5	 			BaoXiang_KLJS_Mxcount	=	4										
	BaoXiang_KLJS	=	{}					BaoXiang_KLJS_Rad	=	{}					BaoXiang_KLJS_Count	=	{}			
	BaoXiang_KLJS	[	1	]	=	1928		BaoXiang_KLJS_Rad	[	1	]	=	1		BaoXiang_KLJS_Count	[	1	]	=	1
	BaoXiang_KLJS	[	2	]	=	1935		BaoXiang_KLJS_Rad	[	2	]	=	1		BaoXiang_KLJS_Count	[	2	]	=	1
	BaoXiang_KLJS	[	3	]	=	1939		BaoXiang_KLJS_Rad	[	3	]	=	1		BaoXiang_KLJS_Count	[	3	]	=	1
	BaoXiang_KLJS	[	4	]	=	3798		BaoXiang_KLJS_Rad	[	4	]	=	1		BaoXiang_KLJS_Count	[	4	]	=	1
																				
																				
	BaoXiang_KLLR_Qua	=	5	 			BaoXiang_KLLR_Mxcount	=	4										
	BaoXiang_KLLR	=	{}					BaoXiang_KLLR_Rad	=	{}					BaoXiang_KLLR_Count	=	{}			
	BaoXiang_KLLR	[	1	]	=	1943		BaoXiang_KLLR_Rad	[	1	]	=	1		BaoXiang_KLLR_Count	[	1	]	=	1
	BaoXiang_KLLR	[	2	]	=	1947		BaoXiang_KLLR_Rad	[	2	]	=	1		BaoXiang_KLLR_Count	[	2	]	=	1
	BaoXiang_KLLR	[	3	]	=	1951		BaoXiang_KLLR_Rad	[	3	]	=	1		BaoXiang_KLLR_Count	[	3	]	=	1
	BaoXiang_KLLR	[	4	]	=	3805		BaoXiang_KLLR_Rad	[	4	]	=	1		BaoXiang_KLLR_Count	[	4	]	=	1
																				
																				
	BaoXiang_KLYS_Qua	=	5	 			BaoXiang_KLYS_Mxcount	=	4										
	BaoXiang_KLYS	=	{}					BaoXiang_KLYS_Rad	=	{}					BaoXiang_KLYS_Count	=	{}			
	BaoXiang_KLYS	[	1	]	=	1955		BaoXiang_KLYS_Rad	[	1	]	=	1		BaoXiang_KLYS_Count	[	1	]	=	1
	BaoXiang_KLYS	[	2	]	=	1962		BaoXiang_KLYS_Rad	[	2	]	=	1		BaoXiang_KLYS_Count	[	2	]	=	1
	BaoXiang_KLYS	[	3	]	=	1969		BaoXiang_KLYS_Rad	[	3	]	=	1		BaoXiang_KLYS_Count	[	3	]	=	1
	BaoXiang_KLYS	[	4	]	=	3809		BaoXiang_KLYS_Rad	[	4	]	=	1		BaoXiang_KLYS_Count	[	4	]	=	1
																				
																				
	BaoXiang_KLMX_Qua	=	5	 			BaoXiang_KLMX_Mxcount	=	4										
	BaoXiang_KLMX	=	{}					BaoXiang_KLMX_Rad	=	{}					BaoXiang_KLMX_Count	=	{}			
	BaoXiang_KLMX	[	1	]	=	1976		BaoXiang_KLMX_Rad	[	1	]	=	1		BaoXiang_KLMX_Count	[	1	]	=	1
	BaoXiang_KLMX	[	2	]	=	1980		BaoXiang_KLMX_Rad	[	2	]	=	1		BaoXiang_KLMX_Count	[	2	]	=	1
	BaoXiang_KLMX	[	3	]	=	1984		BaoXiang_KLMX_Rad	[	3	]	=	1		BaoXiang_KLMX_Count	[	3	]	=	1
	BaoXiang_KLMX	[	4	]	=	3816		BaoXiang_KLMX_Rad	[	4	]	=	1		BaoXiang_KLMX_Count	[	4	]	=	1
																				
																				
	BaoXiang_ZSSJ_Qua	=	5	 			BaoXiang_ZSSJ_Mxcount	=	4										
	BaoXiang_ZSSJ	=	{}					BaoXiang_ZSSJ_Rad	=	{}					BaoXiang_ZSSJ_Count	=	{}			
	BaoXiang_ZSSJ	[	1	]	=	1929		BaoXiang_ZSSJ_Rad	[	1	]	=	1		BaoXiang_ZSSJ_Count	[	1	]	=	1
	BaoXiang_ZSSJ	[	2	]	=	1936		BaoXiang_ZSSJ_Rad	[	2	]	=	1		BaoXiang_ZSSJ_Count	[	2	]	=	1
	BaoXiang_ZSSJ	[	3	]	=	1940		BaoXiang_ZSSJ_Rad	[	3	]	=	1		BaoXiang_ZSSJ_Count	[	3	]	=	1
	BaoXiang_ZSSJ	[	4	]	=	3799		BaoXiang_ZSSJ_Rad	[	4	]	=	1		BaoXiang_ZSSJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_ZSJS_Qua	=	5	 			BaoXiang_ZSJS_Mxcount	=	2										
	BaoXiang_ZSJS	=	{}					BaoXiang_ZSJS_Rad	=	{}					BaoXiang_ZSJS_Count	=	{}			
	BaoXiang_ZSJS	[	1	]	=	3802		BaoXiang_ZSJS_Rad	[	1	]	=	1		BaoXiang_ZSJS_Count	[	1	]	=	1
	BaoXiang_ZSJS	[	2	]	=	1932		BaoXiang_ZSJS_Rad	[	2	]	=	1		BaoXiang_ZSJS_Count	[	2	]	=	1
																				
																				
	BaoXiang_ZSJJ_Qua	=	5	 			BaoXiang_ZSJJ_Mxcount	=	4										
	BaoXiang_ZSJJ	=	{}					BaoXiang_ZSJJ_Rad	=	{}					BaoXiang_ZSJJ_Count	=	{}			
	BaoXiang_ZSJJ	[	1	]	=	1944		BaoXiang_ZSJJ_Rad	[	1	]	=	1		BaoXiang_ZSJJ_Count	[	1	]	=	1
	BaoXiang_ZSJJ	[	2	]	=	1948		BaoXiang_ZSJJ_Rad	[	2	]	=	1		BaoXiang_ZSJJ_Count	[	2	]	=	1
	BaoXiang_ZSJJ	[	3	]	=	1952		BaoXiang_ZSJJ_Rad	[	3	]	=	1		BaoXiang_ZSJJ_Count	[	3	]	=	1
	BaoXiang_ZSJJ	[	4	]	=	3806		BaoXiang_ZSJJ_Rad	[	4	]	=	1		BaoXiang_ZSJJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_ZSSZ_Qua	=	5	 			BaoXiang_ZSSZ_Mxcount	=	4										
	BaoXiang_ZSSZ	=	{}					BaoXiang_ZSSZ_Rad	=	{}					BaoXiang_ZSSZ_Count	=	{}			
	BaoXiang_ZSSZ	[	1	]	=	1959		BaoXiang_ZSSZ_Rad	[	1	]	=	1		BaoXiang_ZSSZ_Count	[	1	]	=	1
	BaoXiang_ZSSZ	[	2	]	=	1966		BaoXiang_ZSSZ_Rad	[	2	]	=	1		BaoXiang_ZSSZ_Count	[	2	]	=	1
	BaoXiang_ZSSZ	[	3	]	=	1973		BaoXiang_ZSSZ_Rad	[	3	]	=	1		BaoXiang_ZSSZ_Count	[	3	]	=	1
	BaoXiang_ZSSZ	[	4	]	=	3813		BaoXiang_ZSSZ_Rad	[	4	]	=	1		BaoXiang_ZSSZ_Count	[	4	]	=	1
																				
																				
	BaoXiang_ZSFY_Qua	=	5	 			BaoXiang_ZSFY_Mxcount	=	4										
	BaoXiang_ZSFY	=	{}					BaoXiang_ZSFY_Rad	=	{}					BaoXiang_ZSFY_Count	=	{}			
	BaoXiang_ZSFY	[	1	]	=	3810		BaoXiang_ZSFY_Rad	[	1	]	=	1		BaoXiang_ZSFY_Count	[	1	]	=	1
	BaoXiang_ZSFY	[	2	]	=	1956		BaoXiang_ZSFY_Rad	[	2	]	=	1		BaoXiang_ZSFY_Count	[	2	]	=	1
	BaoXiang_ZSFY	[	3	]	=	1963		BaoXiang_ZSFY_Rad	[	3	]	=	1		BaoXiang_ZSFY_Count	[	3	]	=	1
	BaoXiang_ZSFY	[	4	]	=	1970		BaoXiang_ZSFY_Rad	[	4	]	=	1		BaoXiang_ZSFY_Count	[	4	]	=	1
																				
																				
	BaoXiang_ZSHH_Qua	=	5	 			BaoXiang_ZSHH_Mxcount	=	4										
	BaoXiang_ZSHH	=	{}					BaoXiang_ZSHH_Rad	=	{}					BaoXiang_ZSHH_Count	=	{}			
	BaoXiang_ZSHH	[	1	]	=	1977		BaoXiang_ZSHH_Rad	[	1	]	=	1		BaoXiang_ZSHH_Count	[	1	]	=	1
	BaoXiang_ZSHH	[	2	]	=	1981		BaoXiang_ZSHH_Rad	[	2	]	=	1		BaoXiang_ZSHH_Count	[	2	]	=	1
	BaoXiang_ZSHH	[	3	]	=	1985		BaoXiang_ZSHH_Rad	[	3	]	=	1		BaoXiang_ZSHH_Count	[	3	]	=	1
	BaoXiang_ZSHH	[	4	]	=	3817		BaoXiang_ZSHH_Rad	[	4	]	=	1		BaoXiang_ZSHH_Count	[	4	]	=	1
																				
																				
	BaoXiang_HLSJ_Qua	=	5	 			BaoXiang_HLSJ_Mxcount	=	4										
	BaoXiang_HLSJ	=	{}					BaoXiang_HLSJ_Rad	=	{}					BaoXiang_HLSJ_Count	=	{}			
	BaoXiang_HLSJ	[	1	]	=	1930		BaoXiang_HLSJ_Rad	[	1	]	=	1		BaoXiang_HLSJ_Count	[	1	]	=	1
	BaoXiang_HLSJ	[	2	]	=	1937		BaoXiang_HLSJ_Rad	[	2	]	=	1		BaoXiang_HLSJ_Count	[	2	]	=	1
	BaoXiang_HLSJ	[	3	]	=	1941		BaoXiang_HLSJ_Rad	[	3	]	=	1		BaoXiang_HLSJ_Count	[	3	]	=	1
	BaoXiang_HLSJ	[	4	]	=	3800		BaoXiang_HLSJ_Rad	[	4	]	=	1		BaoXiang_HLSJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_HLJS_Qua	=	5	 			BaoXiang_HLJS_Mxcount	=	2										
	BaoXiang_HLJS	=	{}					BaoXiang_HLJS_Rad	=	{}					BaoXiang_HLJS_Count	=	{}			
	BaoXiang_HLJS	[	1	]	=	1933		BaoXiang_HLJS_Rad	[	1	]	=	1		BaoXiang_HLJS_Count	[	1	]	=	1
	BaoXiang_HLJS	[	2	]	=	3803		BaoXiang_HLJS_Rad	[	2	]	=	1		BaoXiang_HLJS_Count	[	2	]	=	1
																				
																				
	BaoXiang_HLJJ_Qua	=	5	 			BaoXiang_HLJJ_Mxcount	=	4										
	BaoXiang_HLJJ	=	{}					BaoXiang_HLJJ_Rad	=	{}					BaoXiang_HLJJ_Count	=	{}			
	BaoXiang_HLJJ	[	1	]	=	1945		BaoXiang_HLJJ_Rad	[	1	]	=	1		BaoXiang_HLJJ_Count	[	1	]	=	1
	BaoXiang_HLJJ	[	2	]	=	1949		BaoXiang_HLJJ_Rad	[	2	]	=	1		BaoXiang_HLJJ_Count	[	2	]	=	1
	BaoXiang_HLJJ	[	3	]	=	1953		BaoXiang_HLJJ_Rad	[	3	]	=	1		BaoXiang_HLJJ_Count	[	3	]	=	1
	BaoXiang_HLJJ	[	4	]	=	3807		BaoXiang_HLJJ_Rad	[	4	]	=	1		BaoXiang_HLJJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_HLSZ_Qua	=	5	 			BaoXiang_HLSZ_Mxcount	=	4										
	BaoXiang_HLSZ	=	{}					BaoXiang_HLSZ_Rad	=	{}					BaoXiang_HLSZ_Count	=	{}			
	BaoXiang_HLSZ	[	1	]	=	1960		BaoXiang_HLSZ_Rad	[	1	]	=	1		BaoXiang_HLSZ_Count	[	1	]	=	1
	BaoXiang_HLSZ	[	2	]	=	1967		BaoXiang_HLSZ_Rad	[	2	]	=	1		BaoXiang_HLSZ_Count	[	2	]	=	1
	BaoXiang_HLSZ	[	3	]	=	1974		BaoXiang_HLSZ_Rad	[	3	]	=	1		BaoXiang_HLSZ_Count	[	3	]	=	1
	BaoXiang_HLSZ	[	4	]	=	3814		BaoXiang_HLSZ_Rad	[	4	]	=	1		BaoXiang_HLSZ_Count	[	4	]	=	1
																				
																				
	BaoXiang_HLFY_Qua	=	5	 			BaoXiang_HLFY_Mxcount	=	4										
	BaoXiang_HLFY	=	{}					BaoXiang_HLFY_Rad	=	{}					BaoXiang_HLFY_Count	=	{}			
	BaoXiang_HLFY	[	1	]	=	1957		BaoXiang_HLFY_Rad	[	1	]	=	1		BaoXiang_HLFY_Count	[	1	]	=	1
	BaoXiang_HLFY	[	2	]	=	1964		BaoXiang_HLFY_Rad	[	2	]	=	1		BaoXiang_HLFY_Count	[	2	]	=	1
	BaoXiang_HLFY	[	3	]	=	1971		BaoXiang_HLFY_Rad	[	3	]	=	1		BaoXiang_HLFY_Count	[	3	]	=	1
	BaoXiang_HLFY	[	4	]	=	3811		BaoXiang_HLFY_Rad	[	4	]	=	1		BaoXiang_HLFY_Count	[	4	]	=	1
																				
																				
	BaoXiang_HLHH_Qua	=	5	 			BaoXiang_HLHH_Mxcount	=	4										
	BaoXiang_HLHH	=	{}					BaoXiang_HLHH_Rad	=	{}					BaoXiang_HLHH_Count	=	{}			
	BaoXiang_HLHH	[	1	]	=	1978		BaoXiang_HLHH_Rad	[	1	]	=	1		BaoXiang_HLHH_Count	[	1	]	=	1
	BaoXiang_HLHH	[	2	]	=	1982		BaoXiang_HLHH_Rad	[	2	]	=	1		BaoXiang_HLHH_Count	[	2	]	=	1
	BaoXiang_HLHH	[	3	]	=	1986		BaoXiang_HLHH_Rad	[	3	]	=	1		BaoXiang_HLHH_Count	[	3	]	=	1
	BaoXiang_HLHH	[	4	]	=	3818		BaoXiang_HLHH_Rad	[	4	]	=	1		BaoXiang_HLHH_Count	[	4	]	=	1
																				
																				
	BaoXiang_MSJ_Qua	=	5	 			BaoXiang_MSJ_Mxcount	=	4										
	BaoXiang_MSJ	=	{}					BaoXiang_MSJ_Rad	=	{}					BaoXiang_MSJ_Count	=	{}			
	BaoXiang_MSJ	[	1	]	=	1931		BaoXiang_MSJ_Rad	[	1	]	=	1		BaoXiang_MSJ_Count	[	1	]	=	1
	BaoXiang_MSJ	[	2	]	=	1938		BaoXiang_MSJ_Rad	[	2	]	=	1		BaoXiang_MSJ_Count	[	2	]	=	1
	BaoXiang_MSJ	[	3	]	=	1942		BaoXiang_MSJ_Rad	[	3	]	=	1		BaoXiang_MSJ_Count	[	3	]	=	1
	BaoXiang_MSJ	[	4	]	=	3801		BaoXiang_MSJ_Rad	[	4	]	=	1		BaoXiang_MSJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_MJS_Qua	=	5	 			BaoXiang_MJS_Mxcount	=	2										
	BaoXiang_MJS	=	{}					BaoXiang_MJS_Rad	=	{}					BaoXiang_MJS_Count	=	{}			
	BaoXiang_MJS	[	1	]	=	1934		BaoXiang_MJS_Rad	[	1	]	=	1		BaoXiang_MJS_Count	[	1	]	=	1
	BaoXiang_MJS	[	2	]	=	3804		BaoXiang_MJS_Rad	[	2	]	=	1		BaoXiang_MJS_Count	[	2	]	=	1
																				
																				
	BaoXiang_MJJ_Qua	=	5	 			BaoXiang_MJJ_Mxcount	=	4										
	BaoXiang_MJJ	=	{}					BaoXiang_MJJ_Rad	=	{}					BaoXiang_MJJ_Count	=	{}			
	BaoXiang_MJJ	[	1	]	=	1946		BaoXiang_MJJ_Rad	[	1	]	=	1		BaoXiang_MJJ_Count	[	1	]	=	1
	BaoXiang_MJJ	[	2	]	=	1950		BaoXiang_MJJ_Rad	[	2	]	=	1		BaoXiang_MJJ_Count	[	2	]	=	1
	BaoXiang_MJJ	[	3	]	=	1954		BaoXiang_MJJ_Rad	[	3	]	=	1		BaoXiang_MJJ_Count	[	3	]	=	1
	BaoXiang_MJJ	[	4	]	=	3808		BaoXiang_MJJ_Rad	[	4	]	=	1		BaoXiang_MJJ_Count	[	4	]	=	1
																				
																				
	BaoXiang_MSZ_Qua	=	5	 			BaoXiang_MSZ_Mxcount	=	4										
	BaoXiang_MSZ	=	{}					BaoXiang_MSZ_Rad	=	{}					BaoXiang_MSZ_Count	=	{}			
	BaoXiang_MSZ	[	1	]	=	1961		BaoXiang_MSZ_Rad	[	1	]	=	1		BaoXiang_MSZ_Count	[	1	]	=	1
	BaoXiang_MSZ	[	2	]	=	1968		BaoXiang_MSZ_Rad	[	2	]	=	1		BaoXiang_MSZ_Count	[	2	]	=	1
	BaoXiang_MSZ	[	3	]	=	1975		BaoXiang_MSZ_Rad	[	3	]	=	1		BaoXiang_MSZ_Count	[	3	]	=	1
	BaoXiang_MSZ	[	4	]	=	3815		BaoXiang_MSZ_Rad	[	4	]	=	1		BaoXiang_MSZ_Count	[	4	]	=	1
																				
																				
	BaoXiang_MFY_Qua	=	5	 			BaoXiang_MFY_Mxcount	=	4										
	BaoXiang_MFY	=	{}					BaoXiang_MFY_Rad	=	{}					BaoXiang_MFY_Count	=	{}			
	BaoXiang_MFY	[	1	]	=	1958		BaoXiang_MFY_Rad	[	1	]	=	1		BaoXiang_MFY_Count	[	1	]	=	1
	BaoXiang_MFY	[	2	]	=	1965		BaoXiang_MFY_Rad	[	2	]	=	1		BaoXiang_MFY_Count	[	2	]	=	1
	BaoXiang_MFY	[	3	]	=	1972		BaoXiang_MFY_Rad	[	3	]	=	1		BaoXiang_MFY_Count	[	3	]	=	1
	BaoXiang_MFY	[	4	]	=	3812		BaoXiang_MFY_Rad	[	4	]	=	1		BaoXiang_MFY_Count	[	4	]	=	1
																				
																				
	BaoXiang_MHH_Qua	=	5	 			BaoXiang_MHH_Mxcount	=	4										
	BaoXiang_MHH	=	{}					BaoXiang_MHH_Rad	=	{}					BaoXiang_MHH_Count	=	{}			
	BaoXiang_MHH	[	1	]	=	1979		BaoXiang_MHH_Rad	[	1	]	=	1		BaoXiang_MHH_Count	[	1	]	=	1
	BaoXiang_MHH	[	2	]	=	1983		BaoXiang_MHH_Rad	[	2	]	=	1		BaoXiang_MHH_Count	[	2	]	=	1
	BaoXiang_MHH	[	3	]	=	1987		BaoXiang_MHH_Rad	[	3	]	=	1		BaoXiang_MHH_Count	[	3	]	=	1
	BaoXiang_MHH	[	4	]	=	3819		BaoXiang_MHH_Rad	[	4	]	=	1		BaoXiang_MHH_Count	[	4	]	=	1
																				
																				
	BaoXiang_FLBX_Qua	=	5	 			BaoXiang_FLBX_Mxcount	=	8										
	BaoXiang_FLBX	=	{}					BaoXiang_FLBX_Rad	=	{}					BaoXiang_FLBX_Count	=	{}			
	BaoXiang_FLBX	[	1	]	=	1884		BaoXiang_FLBX_Rad	[	1	]	=	1		BaoXiang_FLBX_Count	[	1	]	=	1
	BaoXiang_FLBX	[	2	]	=	1891		BaoXiang_FLBX_Rad	[	2	]	=	1		BaoXiang_FLBX_Count	[	2	]	=	1
	BaoXiang_FLBX	[	3	]	=	1898		BaoXiang_FLBX_Rad	[	3	]	=	1		BaoXiang_FLBX_Count	[	3	]	=	1
	BaoXiang_FLBX	[	4	]	=	1902		BaoXiang_FLBX_Rad	[	4	]	=	1		BaoXiang_FLBX_Count	[	4	]	=	1
	BaoXiang_FLBX	[	5	]	=	1906		BaoXiang_FLBX_Rad	[	5	]	=	1		BaoXiang_FLBX_Count	[	5	]	=	1
	BaoXiang_FLBX	[	6	]	=	1910		BaoXiang_FLBX_Rad	[	6	]	=	1		BaoXiang_FLBX_Count	[	6	]	=	1
	BaoXiang_FLBX	[	7	]	=	1920		BaoXiang_FLBX_Rad	[	7	]	=	1		BaoXiang_FLBX_Count	[	7	]	=	1
	BaoXiang_FLBX	[	8	]	=	1924		BaoXiang_FLBX_Rad	[	8	]	=	1		BaoXiang_FLBX_Count	[	8	]	=	1
																				
																				
	BaoXiang_ZZBX_Qua	=	5	 			BaoXiang_ZZBX_Mxcount	=	12										
	BaoXiang_ZZBX	=	{}					BaoXiang_ZZBX_Rad	=	{}					BaoXiang_ZZBX_Count	=	{}			
	BaoXiang_ZZBX	[	1	]	=	1907		BaoXiang_ZZBX_Rad	[	1	]	=	1		BaoXiang_ZZBX_Count	[	1	]	=	1
	BaoXiang_ZZBX	[	2	]	=	1911		BaoXiang_ZZBX_Rad	[	2	]	=	1		BaoXiang_ZZBX_Count	[	2	]	=	1
	BaoXiang_ZZBX	[	3	]	=	1914		BaoXiang_ZZBX_Rad	[	3	]	=	1		BaoXiang_ZZBX_Count	[	3	]	=	1
	BaoXiang_ZZBX	[	4	]	=	1921		BaoXiang_ZZBX_Rad	[	4	]	=	1		BaoXiang_ZZBX_Count	[	4	]	=	1
	BaoXiang_ZZBX	[	5	]	=	1925		BaoXiang_ZZBX_Rad	[	5	]	=	1		BaoXiang_ZZBX_Count	[	5	]	=	1
	BaoXiang_ZZBX	[	6	]	=	1917		BaoXiang_ZZBX_Rad	[	6	]	=	1		BaoXiang_ZZBX_Count	[	6	]	=	1
	BaoXiang_ZZBX	[	7	]	=	1885		BaoXiang_ZZBX_Rad	[	7	]	=	1		BaoXiang_ZZBX_Count	[	7	]	=	1
	BaoXiang_ZZBX	[	8	]	=	1888		BaoXiang_ZZBX_Rad	[	8	]	=	1		BaoXiang_ZZBX_Count	[	8	]	=	1
	BaoXiang_ZZBX	[	9	]	=	1892		BaoXiang_ZZBX_Rad	[	9	]	=	1		BaoXiang_ZZBX_Count	[	9	]	=	1
	BaoXiang_ZZBX	[	10	]	=	1895		BaoXiang_ZZBX_Rad	[	10	]	=	1		BaoXiang_ZZBX_Count	[	10	]	=	1
	BaoXiang_ZZBX	[	11	]	=	1899		BaoXiang_ZZBX_Rad	[	11	]	=	1		BaoXiang_ZZBX_Count	[	11	]	=	1
	BaoXiang_ZZBX	[	12	]	=	1903		BaoXiang_ZZBX_Rad	[	12	]	=	1		BaoXiang_ZZBX_Count	[	12	]	=	1
																				
																				
	BaoXiang_MFBX_Qua	=	5	 			BaoXiang_MFBX_Mxcount	=	22										
	BaoXiang_MFBX	=	{}					BaoXiang_MFBX_Rad	=	{}					BaoXiang_MFBX_Count	=	{}			
	BaoXiang_MFBX	[	1	]	=	1908		BaoXiang_MFBX_Rad	[	1	]	=	1		BaoXiang_MFBX_Count	[	1	]	=	1
	BaoXiang_MFBX	[	2	]	=	1912		BaoXiang_MFBX_Rad	[	2	]	=	1		BaoXiang_MFBX_Count	[	2	]	=	1
	BaoXiang_MFBX	[	3	]	=	1915		BaoXiang_MFBX_Rad	[	3	]	=	1		BaoXiang_MFBX_Count	[	3	]	=	1
	BaoXiang_MFBX	[	4	]	=	1922		BaoXiang_MFBX_Rad	[	4	]	=	1		BaoXiang_MFBX_Count	[	4	]	=	1
	BaoXiang_MFBX	[	5	]	=	1926		BaoXiang_MFBX_Rad	[	5	]	=	1		BaoXiang_MFBX_Count	[	5	]	=	1
	BaoXiang_MFBX	[	6	]	=	1918		BaoXiang_MFBX_Rad	[	6	]	=	1		BaoXiang_MFBX_Count	[	6	]	=	1
	BaoXiang_MFBX	[	7	]	=	1886		BaoXiang_MFBX_Rad	[	7	]	=	1		BaoXiang_MFBX_Count	[	7	]	=	1
	BaoXiang_MFBX	[	8	]	=	1889		BaoXiang_MFBX_Rad	[	8	]	=	1		BaoXiang_MFBX_Count	[	8	]	=	1
	BaoXiang_MFBX	[	9	]	=	1893		BaoXiang_MFBX_Rad	[	9	]	=	1		BaoXiang_MFBX_Count	[	9	]	=	1
	BaoXiang_MFBX	[	10	]	=	1896		BaoXiang_MFBX_Rad	[	10	]	=	1		BaoXiang_MFBX_Count	[	10	]	=	1
	BaoXiang_MFBX	[	11	]	=	1900		BaoXiang_MFBX_Rad	[	11	]	=	1		BaoXiang_MFBX_Count	[	11	]	=	1
	BaoXiang_MFBX	[	12	]	=	1904		BaoXiang_MFBX_Rad	[	12	]	=	1		BaoXiang_MFBX_Count	[	12	]	=	1
	BaoXiang_MFBX	[	13	]	=	1988		BaoXiang_MFBX_Rad	[	13	]	=	1		BaoXiang_MFBX_Count	[	13	]	=	1
	BaoXiang_MFBX	[	14	]	=	1989		BaoXiang_MFBX_Rad	[	14	]	=	1		BaoXiang_MFBX_Count	[	14	]	=	1
	BaoXiang_MFBX	[	15	]	=	1990		BaoXiang_MFBX_Rad	[	15	]	=	1		BaoXiang_MFBX_Count	[	15	]	=	1
	BaoXiang_MFBX	[	16	]	=	1991		BaoXiang_MFBX_Rad	[	16	]	=	1		BaoXiang_MFBX_Count	[	16	]	=	1
	BaoXiang_MFBX	[	17	]	=	1992		BaoXiang_MFBX_Rad	[	17	]	=	1		BaoXiang_MFBX_Count	[	17	]	=	1
	BaoXiang_MFBX	[	18	]	=	1993		BaoXiang_MFBX_Rad	[	18	]	=	1		BaoXiang_MFBX_Count	[	18	]	=	1
	BaoXiang_MFBX	[	19	]	=	1994		BaoXiang_MFBX_Rad	[	19	]	=	1		BaoXiang_MFBX_Count	[	19	]	=	1
	BaoXiang_MFBX	[	20	]	=	1995		BaoXiang_MFBX_Rad	[	20	]	=	1		BaoXiang_MFBX_Count	[	20	]	=	1
	BaoXiang_MFBX	[	21	]	=	1996		BaoXiang_MFBX_Rad	[	21	]	=	1		BaoXiang_MFBX_Count	[	21	]	=	1
	BaoXiang_MFBX	[	22	]	=	1997		BaoXiang_MFBX_Rad	[	22	]	=	1		BaoXiang_MFBX_Count	[	22	]	=	1
																				
																				
	BaoXiang_MZBX_Qua	=	5	 			BaoXiang_MZBX_Mxcount	=	12										
	BaoXiang_MZBX	=	{}					BaoXiang_MZBX_Rad	=	{}					BaoXiang_MZBX_Count	=	{}			
	BaoXiang_MZBX	[	1	]	=	1887		BaoXiang_MZBX_Rad	[	1	]	=	1		BaoXiang_MZBX_Count	[	1	]	=	1
	BaoXiang_MZBX	[	2	]	=	1890		BaoXiang_MZBX_Rad	[	2	]	=	1		BaoXiang_MZBX_Count	[	2	]	=	1
	BaoXiang_MZBX	[	3	]	=	1894		BaoXiang_MZBX_Rad	[	3	]	=	1		BaoXiang_MZBX_Count	[	3	]	=	1
	BaoXiang_MZBX	[	4	]	=	1897		BaoXiang_MZBX_Rad	[	4	]	=	1		BaoXiang_MZBX_Count	[	4	]	=	1
	BaoXiang_MZBX	[	5	]	=	1901		BaoXiang_MZBX_Rad	[	5	]	=	1		BaoXiang_MZBX_Count	[	5	]	=	1
	BaoXiang_MZBX	[	6	]	=	1905		BaoXiang_MZBX_Rad	[	6	]	=	1		BaoXiang_MZBX_Count	[	6	]	=	1
	BaoXiang_MZBX	[	7	]	=	1909		BaoXiang_MZBX_Rad	[	7	]	=	1		BaoXiang_MZBX_Count	[	7	]	=	1
	BaoXiang_MZBX	[	8	]	=	1913		BaoXiang_MZBX_Rad	[	8	]	=	1		BaoXiang_MZBX_Count	[	8	]	=	1
	BaoXiang_MZBX	[	9	]	=	1916		BaoXiang_MZBX_Rad	[	9	]	=	1		BaoXiang_MZBX_Count	[	9	]	=	1
	BaoXiang_MZBX	[	10	]	=	1923		BaoXiang_MZBX_Rad	[	10	]	=	1		BaoXiang_MZBX_Count	[	10	]	=	1
	BaoXiang_MZBX	[	11	]	=	1927		BaoXiang_MZBX_Rad	[	11	]	=	1		BaoXiang_MZBX_Count	[	11	]	=	1
	BaoXiang_MZBX	[	12	]	=	1919		BaoXiang_MZBX_Rad	[	12	]	=	1		BaoXiang_MZBX_Count	[	12	]	=	1

	BaoXiang_SDWZBOX_Qua	=	5	 				BaoXiang_SDWZBOX_Mxcount	=	19										
	BaoXiang_SDWZBOX	=	{}					BaoXiang_SDWZBOX_Rad	=	{}					BaoXiang_SDWZBOX_Count	=	{}			
	BaoXiang_SDWZBOX	[	1	]	=	0863		BaoXiang_SDWZBOX_Rad	[	1	]	=	1		BaoXiang_SDWZBOX_Count	[	1	]	=	1
	BaoXiang_SDWZBOX	[	2	]	=	0862		BaoXiang_SDWZBOX_Rad	[	2	]	=	1		BaoXiang_SDWZBOX_Count	[	2	]	=	1
	BaoXiang_SDWZBOX	[	3	]	=	0861		BaoXiang_SDWZBOX_Rad	[	3	]	=	2		BaoXiang_SDWZBOX_Count	[	3	]	=	1
	BaoXiang_SDWZBOX	[	4	]	=	0860		BaoXiang_SDWZBOX_Rad	[	4	]	=	2		BaoXiang_SDWZBOX_Count	[	4	]	=	1
	BaoXiang_SDWZBOX	[	5	]	=	1012		BaoXiang_SDWZBOX_Rad	[	5	]	=	1		BaoXiang_SDWZBOX_Count	[	5	]	=	1
	BaoXiang_SDWZBOX	[	6	]	=	0899		BaoXiang_SDWZBOX_Rad	[	6	]	=	5		BaoXiang_SDWZBOX_Count	[	6	]	=	1
	BaoXiang_SDWZBOX	[	7	]	=	0900		BaoXiang_SDWZBOX_Rad	[	7	]	=	5		BaoXiang_SDWZBOX_Count	[	7	]	=	1
	BaoXiang_SDWZBOX	[	8	]	=	0901		BaoXiang_SDWZBOX_Rad	[	8	]	=	5		BaoXiang_SDWZBOX_Count	[	8	]	=	1
	BaoXiang_SDWZBOX	[	9	]	=	0902		BaoXiang_SDWZBOX_Rad	[	9	]	=	5		BaoXiang_SDWZBOX_Count	[	9	]	=	1
	BaoXiang_SDWZBOX	[	10	]	=	0903		BaoXiang_SDWZBOX_Rad	[	10	]	=	5		BaoXiang_SDWZBOX_Count	[	10	]	=	1
	BaoXiang_SDWZBOX	[	18	]	=	0885		BaoXiang_SDWZBOX_Rad	[	11	]	=	5		BaoXiang_SDWZBOX_Count	[	11	]	=	1
	BaoXiang_SDWZBOX	[	11	]	=	0878		BaoXiang_SDWZBOX_Rad	[	12	]	=	7		BaoXiang_SDWZBOX_Count	[	12	]	=	1
	BaoXiang_SDWZBOX	[	12	]	=	0879		BaoXiang_SDWZBOX_Rad	[	13	]	=	8		BaoXiang_SDWZBOX_Count	[	13	]	=	1
	BaoXiang_SDWZBOX	[	13	]	=	0880		BaoXiang_SDWZBOX_Rad	[	14	]	=	8		BaoXiang_SDWZBOX_Count	[	14	]	=	1
	BaoXiang_SDWZBOX	[	14	]	=	0881		BaoXiang_SDWZBOX_Rad	[	15	]	=	8		BaoXiang_SDWZBOX_Count	[	15	]	=	1
	BaoXiang_SDWZBOX	[	15	]	=	0882		BaoXiang_SDWZBOX_Rad	[	16	]	=	8		BaoXiang_SDWZBOX_Count	[	16	]	=	1
	BaoXiang_SDWZBOX	[	16	]	=	0883		BaoXiang_SDWZBOX_Rad	[	17	]	=	8		BaoXiang_SDWZBOX_Count	[	17	]	=	1
	BaoXiang_SDWZBOX	[	17	]	=	0884		BaoXiang_SDWZBOX_Rad	[	18	]	=	8		BaoXiang_SDWZBOX_Count	[	18	]	=	1
	BaoXiang_SDWZBOX	[	19	]	=	0887		BaoXiang_SDWZBOX_Rad	[	19	]	=	8		BaoXiang_SDWZBOX_Count	[	19	]	=	1
	
																			
	BaoXiang_SDLHBOX_Qua	=	5	 				BaoXiang_SDLHBOX_Mxcount	=	150										
	BaoXiang_SDLHBOX	=	{}					BaoXiang_SDLHBOX_Rad	=	{}					BaoXiang_SDLHBOX_Count	=	{}			
	BaoXiang_SDLHBOX	[	1	]	=	0004		BaoXiang_SDLHBOX_Rad	[	1	]	=	1		BaoXiang_SDLHBOX_Count	[	1	]	=	1
	BaoXiang_SDLHBOX	[	2	]	=	0005		BaoXiang_SDLHBOX_Rad	[	2	]	=	1		BaoXiang_SDLHBOX_Count	[	2	]	=	1
	BaoXiang_SDLHBOX	[	3	]	=	0006		BaoXiang_SDLHBOX_Rad	[	3	]	=	1		BaoXiang_SDLHBOX_Count	[	3	]	=	1
	BaoXiang_SDLHBOX	[	4	]	=	0015		BaoXiang_SDLHBOX_Rad	[	4	]	=	1		BaoXiang_SDLHBOX_Count	[	4	]	=	1
	BaoXiang_SDLHBOX	[	5	]	=	0016		BaoXiang_SDLHBOX_Rad	[	5	]	=	1		BaoXiang_SDLHBOX_Count	[	5	]	=	1
	BaoXiang_SDLHBOX	[	6	]	=	0017		BaoXiang_SDLHBOX_Rad	[	6	]	=	1		BaoXiang_SDLHBOX_Count	[	6	]	=	1
	BaoXiang_SDLHBOX	[	7	]	=	0039		BaoXiang_SDLHBOX_Rad	[	7	]	=	1		BaoXiang_SDLHBOX_Count	[	7	]	=	1
	BaoXiang_SDLHBOX	[	8	]	=	0040		BaoXiang_SDLHBOX_Rad	[	8	]	=	1		BaoXiang_SDLHBOX_Count	[	8	]	=	1
	BaoXiang_SDLHBOX	[	9	]	=	0041		BaoXiang_SDLHBOX_Rad	[	9	]	=	1		BaoXiang_SDLHBOX_Count	[	9	]	=	1
	BaoXiang_SDLHBOX	[	10	]	=	0076		BaoXiang_SDLHBOX_Rad	[	10	]	=	1		BaoXiang_SDLHBOX_Count	[	10	]	=	1
	BaoXiang_SDLHBOX	[	11	]	=	0077		BaoXiang_SDLHBOX_Rad	[	11	]	=	1		BaoXiang_SDLHBOX_Count	[	11	]	=	1
	BaoXiang_SDLHBOX	[	12	]	=	0078		BaoXiang_SDLHBOX_Rad	[	12	]	=	1		BaoXiang_SDLHBOX_Count	[	12	]	=	1
	BaoXiang_SDLHBOX	[	13	]	=	0100		BaoXiang_SDLHBOX_Rad	[	13	]	=	1		BaoXiang_SDLHBOX_Count	[	13	]	=	1
	BaoXiang_SDLHBOX	[	14	]	=	0103		BaoXiang_SDLHBOX_Rad	[	14	]	=	1		BaoXiang_SDLHBOX_Count	[	14	]	=	1
	BaoXiang_SDLHBOX	[	15	]	=	4303		BaoXiang_SDLHBOX_Rad	[	15	]	=	1		BaoXiang_SDLHBOX_Count	[	15	]	=	1
	BaoXiang_SDLHBOX	[	16	]	=	0101		BaoXiang_SDLHBOX_Rad	[	16	]	=	1		BaoXiang_SDLHBOX_Count	[	16	]	=	1
	BaoXiang_SDLHBOX	[	17	]	=	0102		BaoXiang_SDLHBOX_Rad	[	17	]	=	1		BaoXiang_SDLHBOX_Count	[	17	]	=	1
	BaoXiang_SDLHBOX	[	18	]	=	4300		BaoXiang_SDLHBOX_Rad	[	18	]	=	1		BaoXiang_SDLHBOX_Count	[	18	]	=	1
	BaoXiang_SDLHBOX	[	19	]	=	3122		BaoXiang_SDLHBOX_Rad	[	19	]	=	25		BaoXiang_SDLHBOX_Count	[	19	]	=	10
	BaoXiang_SDLHBOX	[	20	]	=	3123		BaoXiang_SDLHBOX_Rad	[	20	]	=	25		BaoXiang_SDLHBOX_Count	[	20	]	=	8
	BaoXiang_SDLHBOX	[	21	]	=	3124		BaoXiang_SDLHBOX_Rad	[	21	]	=	25		BaoXiang_SDLHBOX_Count	[	21	]	=	5
	BaoXiang_SDLHBOX	[	22	]	=	3125		BaoXiang_SDLHBOX_Rad	[	22	]	=	25		BaoXiang_SDLHBOX_Count	[	22	]	=	4
	BaoXiang_SDLHBOX	[	23	]	=	3126		BaoXiang_SDLHBOX_Rad	[	23	]	=	25		BaoXiang_SDLHBOX_Count	[	23	]	=	4
	BaoXiang_SDLHBOX	[	24	]	=	3127		BaoXiang_SDLHBOX_Rad	[	24	]	=	20		BaoXiang_SDLHBOX_Count	[	24	]	=	3
	BaoXiang_SDLHBOX	[	25	]	=	3128		BaoXiang_SDLHBOX_Rad	[	25	]	=	20		BaoXiang_SDLHBOX_Count	[	25	]	=	3
	BaoXiang_SDLHBOX	[	26	]	=	3133		BaoXiang_SDLHBOX_Rad	[	26	]	=	20		BaoXiang_SDLHBOX_Count	[	26	]	=	5
	BaoXiang_SDLHBOX	[	27	]	=	3134		BaoXiang_SDLHBOX_Rad	[	27	]	=	20		BaoXiang_SDLHBOX_Count	[	27	]	=	4
	BaoXiang_SDLHBOX	[	28	]	=	3135		BaoXiang_SDLHBOX_Rad	[	28	]	=	20		BaoXiang_SDLHBOX_Count	[	28	]	=	4
	BaoXiang_SDLHBOX	[	29	]	=	3136		BaoXiang_SDLHBOX_Rad	[	29	]	=	20		BaoXiang_SDLHBOX_Count	[	29	]	=	3
	BaoXiang_SDLHBOX	[	30	]	=	3137		BaoXiang_SDLHBOX_Rad	[	30	]	=	20		BaoXiang_SDLHBOX_Count	[	30	]	=	3
	BaoXiang_SDLHBOX	[	31	]	=	3138		BaoXiang_SDLHBOX_Rad	[	31	]	=	20		BaoXiang_SDLHBOX_Count	[	31	]	=	2
	BaoXiang_SDLHBOX	[	32	]	=	3139		BaoXiang_SDLHBOX_Rad	[	32	]	=	20		BaoXiang_SDLHBOX_Count	[	32	]	=	2
	BaoXiang_SDLHBOX	[	33	]	=	3140		BaoXiang_SDLHBOX_Rad	[	33	]	=	20		BaoXiang_SDLHBOX_Count	[	33	]	=	1
	BaoXiang_SDLHBOX	[	34	]	=	0293		BaoXiang_SDLHBOX_Rad	[	34	]	=	1		BaoXiang_SDLHBOX_Count	[	34	]	=	1
	BaoXiang_SDLHBOX	[	35	]	=	0295		BaoXiang_SDLHBOX_Rad	[	35	]	=	1		BaoXiang_SDLHBOX_Count	[	35	]	=	1
	BaoXiang_SDLHBOX	[	36	]	=	0299		BaoXiang_SDLHBOX_Rad	[	36	]	=	1		BaoXiang_SDLHBOX_Count	[	36	]	=	1
	BaoXiang_SDLHBOX	[	37	]	=	0300		BaoXiang_SDLHBOX_Rad	[	37	]	=	1		BaoXiang_SDLHBOX_Count	[	37	]	=	1
	BaoXiang_SDLHBOX	[	38	]	=	0301		BaoXiang_SDLHBOX_Rad	[	38	]	=	1		BaoXiang_SDLHBOX_Count	[	38	]	=	1
	BaoXiang_SDLHBOX	[	39	]	=	0302		BaoXiang_SDLHBOX_Rad	[	39	]	=	1		BaoXiang_SDLHBOX_Count	[	39	]	=	1
	BaoXiang_SDLHBOX	[	40	]	=	0307		BaoXiang_SDLHBOX_Rad	[	40	]	=	1		BaoXiang_SDLHBOX_Count	[	40	]	=	1
	BaoXiang_SDLHBOX	[	41	]	=	0310		BaoXiang_SDLHBOX_Rad	[	41	]	=	1		BaoXiang_SDLHBOX_Count	[	41	]	=	1
	BaoXiang_SDLHBOX	[	42	]	=	0312		BaoXiang_SDLHBOX_Rad	[	42	]	=	1		BaoXiang_SDLHBOX_Count	[	42	]	=	1
	BaoXiang_SDLHBOX	[	43	]	=	0314		BaoXiang_SDLHBOX_Rad	[	43	]	=	1		BaoXiang_SDLHBOX_Count	[	43	]	=	1
	BaoXiang_SDLHBOX	[	44	]	=	0315		BaoXiang_SDLHBOX_Rad	[	44	]	=	1		BaoXiang_SDLHBOX_Count	[	44	]	=	1
	BaoXiang_SDLHBOX	[	45	]	=	0316		BaoXiang_SDLHBOX_Rad	[	45	]	=	1		BaoXiang_SDLHBOX_Count	[	45	]	=	1
	BaoXiang_SDLHBOX	[	46	]	=	0339		BaoXiang_SDLHBOX_Rad	[	46	]	=	1		BaoXiang_SDLHBOX_Count	[	46	]	=	1
	BaoXiang_SDLHBOX	[	47	]	=	0341		BaoXiang_SDLHBOX_Rad	[	47	]	=	1		BaoXiang_SDLHBOX_Count	[	47	]	=	1
	BaoXiang_SDLHBOX	[	48	]	=	0342		BaoXiang_SDLHBOX_Rad	[	48	]	=	1		BaoXiang_SDLHBOX_Count	[	48	]	=	1
	BaoXiang_SDLHBOX	[	49	]	=	0343		BaoXiang_SDLHBOX_Rad	[	49	]	=	1		BaoXiang_SDLHBOX_Count	[	49	]	=	1
	BaoXiang_SDLHBOX	[	50	]	=	0344		BaoXiang_SDLHBOX_Rad	[	50	]	=	1		BaoXiang_SDLHBOX_Count	[	50	]	=	1
	BaoXiang_SDLHBOX	[	51	]	=	0345		BaoXiang_SDLHBOX_Rad	[	51	]	=	1		BaoXiang_SDLHBOX_Count	[	51	]	=	1
	BaoXiang_SDLHBOX	[	52	]	=	0350		BaoXiang_SDLHBOX_Rad	[	52	]	=	1		BaoXiang_SDLHBOX_Count	[	52	]	=	1
	BaoXiang_SDLHBOX	[	53	]	=	0353		BaoXiang_SDLHBOX_Rad	[	53	]	=	1		BaoXiang_SDLHBOX_Count	[	53	]	=	1
	BaoXiang_SDLHBOX	[	54	]	=	0354		BaoXiang_SDLHBOX_Rad	[	54	]	=	1		BaoXiang_SDLHBOX_Count	[	54	]	=	1
	BaoXiang_SDLHBOX	[	55	]	=	0355		BaoXiang_SDLHBOX_Rad	[	55	]	=	1		BaoXiang_SDLHBOX_Count	[	55	]	=	1
	BaoXiang_SDLHBOX	[	56	]	=	0356		BaoXiang_SDLHBOX_Rad	[	56	]	=	1		BaoXiang_SDLHBOX_Count	[	56	]	=	1
	BaoXiang_SDLHBOX	[	57	]	=	0357		BaoXiang_SDLHBOX_Rad	[	57	]	=	1		BaoXiang_SDLHBOX_Count	[	57	]	=	1
	BaoXiang_SDLHBOX	[	58	]	=	0358		BaoXiang_SDLHBOX_Rad	[	58	]	=	1		BaoXiang_SDLHBOX_Count	[	58	]	=	1
	BaoXiang_SDLHBOX	[	59	]	=	0361		BaoXiang_SDLHBOX_Rad	[	59	]	=	1		BaoXiang_SDLHBOX_Count	[	59	]	=	1
	BaoXiang_SDLHBOX	[	60	]	=	0362		BaoXiang_SDLHBOX_Rad	[	60	]	=	1		BaoXiang_SDLHBOX_Count	[	60	]	=	1
	BaoXiang_SDLHBOX	[	61	]	=	0363		BaoXiang_SDLHBOX_Rad	[	61	]	=	1		BaoXiang_SDLHBOX_Count	[	61	]	=	1
	BaoXiang_SDLHBOX	[	62	]	=	0364		BaoXiang_SDLHBOX_Rad	[	62	]	=	1		BaoXiang_SDLHBOX_Count	[	62	]	=	1
	BaoXiang_SDLHBOX	[	63	]	=	0367		BaoXiang_SDLHBOX_Rad	[	63	]	=	1		BaoXiang_SDLHBOX_Count	[	63	]	=	1
	BaoXiang_SDLHBOX	[	64	]	=	0368		BaoXiang_SDLHBOX_Rad	[	64	]	=	1		BaoXiang_SDLHBOX_Count	[	64	]	=	1
	BaoXiang_SDLHBOX	[	65	]	=	0369		BaoXiang_SDLHBOX_Rad	[	65	]	=	1		BaoXiang_SDLHBOX_Count	[	65	]	=	1
	BaoXiang_SDLHBOX	[	66	]	=	0370		BaoXiang_SDLHBOX_Rad	[	66	]	=	1		BaoXiang_SDLHBOX_Count	[	66	]	=	1
	BaoXiang_SDLHBOX	[	67	]	=	0371		BaoXiang_SDLHBOX_Rad	[	67	]	=	1		BaoXiang_SDLHBOX_Count	[	67	]	=	1
	BaoXiang_SDLHBOX	[	68	]	=	0374		BaoXiang_SDLHBOX_Rad	[	68	]	=	1		BaoXiang_SDLHBOX_Count	[	68	]	=	1
	BaoXiang_SDLHBOX	[	69	]	=	0375		BaoXiang_SDLHBOX_Rad	[	69	]	=	1		BaoXiang_SDLHBOX_Count	[	69	]	=	1
	BaoXiang_SDLHBOX	[	70	]	=	0376		BaoXiang_SDLHBOX_Rad	[	70	]	=	1		BaoXiang_SDLHBOX_Count	[	70	]	=	1
	BaoXiang_SDLHBOX	[	71	]	=	0377		BaoXiang_SDLHBOX_Rad	[	71	]	=	1		BaoXiang_SDLHBOX_Count	[	71	]	=	1
	BaoXiang_SDLHBOX	[	72	]	=	0378		BaoXiang_SDLHBOX_Rad	[	72	]	=	1		BaoXiang_SDLHBOX_Count	[	72	]	=	1
	BaoXiang_SDLHBOX	[	73	]	=	0379		BaoXiang_SDLHBOX_Rad	[	73	]	=	1		BaoXiang_SDLHBOX_Count	[	73	]	=	1
	BaoXiang_SDLHBOX	[	74	]	=	0382		BaoXiang_SDLHBOX_Rad	[	74	]	=	1		BaoXiang_SDLHBOX_Count	[	74	]	=	1
	BaoXiang_SDLHBOX	[	75	]	=	0820		BaoXiang_SDLHBOX_Rad	[	75	]	=	1		BaoXiang_SDLHBOX_Count	[	75	]	=	1
	BaoXiang_SDLHBOX	[	76	]	=	0821		BaoXiang_SDLHBOX_Rad	[	76	]	=	1		BaoXiang_SDLHBOX_Count	[	76	]	=	1
	BaoXiang_SDLHBOX	[	77	]	=	0870		BaoXiang_SDLHBOX_Rad	[	77	]	=	1		BaoXiang_SDLHBOX_Count	[	77	]	=	1
	BaoXiang_SDLHBOX	[	78	]	=	0871		BaoXiang_SDLHBOX_Rad	[	78	]	=	1		BaoXiang_SDLHBOX_Count	[	78	]	=	1
	BaoXiang_SDLHBOX	[	79	]	=	0875		BaoXiang_SDLHBOX_Rad	[	79	]	=	1		BaoXiang_SDLHBOX_Count	[	79	]	=	1
	BaoXiang_SDLHBOX	[	80	]	=	0876		BaoXiang_SDLHBOX_Rad	[	80	]	=	1		BaoXiang_SDLHBOX_Count	[	80	]	=	1
	BaoXiang_SDLHBOX	[	81	]	=	1787		BaoXiang_SDLHBOX_Rad	[	81	]	=	15		BaoXiang_SDLHBOX_Count	[	81	]	=	2
	BaoXiang_SDLHBOX	[	82	]	=	1788		BaoXiang_SDLHBOX_Rad	[	82	]	=	15		BaoXiang_SDLHBOX_Count	[	82	]	=	2
	BaoXiang_SDLHBOX	[	83	]	=	1789		BaoXiang_SDLHBOX_Rad	[	83	]	=	15		BaoXiang_SDLHBOX_Count	[	83	]	=	2
	BaoXiang_SDLHBOX	[	84	]	=	1790		BaoXiang_SDLHBOX_Rad	[	84	]	=	15		BaoXiang_SDLHBOX_Count	[	84	]	=	2
	BaoXiang_SDLHBOX	[	85	]	=	1791		BaoXiang_SDLHBOX_Rad	[	85	]	=	15		BaoXiang_SDLHBOX_Count	[	85	]	=	2
	BaoXiang_SDLHBOX	[	86	]	=	1792		BaoXiang_SDLHBOX_Rad	[	86	]	=	15		BaoXiang_SDLHBOX_Count	[	86	]	=	2
	BaoXiang_SDLHBOX	[	87	]	=	1793		BaoXiang_SDLHBOX_Rad	[	87	]	=	15		BaoXiang_SDLHBOX_Count	[	87	]	=	2
	BaoXiang_SDLHBOX	[	88	]	=	1797		BaoXiang_SDLHBOX_Rad	[	88	]	=	15		BaoXiang_SDLHBOX_Count	[	88	]	=	1
	BaoXiang_SDLHBOX	[	89	]	=	1798		BaoXiang_SDLHBOX_Rad	[	89	]	=	15		BaoXiang_SDLHBOX_Count	[	89	]	=	1
	BaoXiang_SDLHBOX	[	90	]	=	1799		BaoXiang_SDLHBOX_Rad	[	90	]	=	15		BaoXiang_SDLHBOX_Count	[	90	]	=	1
	BaoXiang_SDLHBOX	[	91	]	=	1800		BaoXiang_SDLHBOX_Rad	[	91	]	=	15		BaoXiang_SDLHBOX_Count	[	91	]	=	1
	BaoXiang_SDLHBOX	[	92	]	=	1801		BaoXiang_SDLHBOX_Rad	[	92	]	=	15		BaoXiang_SDLHBOX_Count	[	92	]	=	1
	BaoXiang_SDLHBOX	[	93	]	=	1802		BaoXiang_SDLHBOX_Rad	[	93	]	=	15		BaoXiang_SDLHBOX_Count	[	93	]	=	1
	BaoXiang_SDLHBOX	[	94	]	=	1803		BaoXiang_SDLHBOX_Rad	[	94	]	=	15		BaoXiang_SDLHBOX_Count	[	94	]	=	1
	BaoXiang_SDLHBOX	[	95	]	=	1804		BaoXiang_SDLHBOX_Rad	[	95	]	=	15		BaoXiang_SDLHBOX_Count	[	95	]	=	1
	BaoXiang_SDLHBOX	[	96	]	=	1805		BaoXiang_SDLHBOX_Rad	[	96	]	=	15		BaoXiang_SDLHBOX_Count	[	96	]	=	1
	BaoXiang_SDLHBOX	[	97	]	=	1806		BaoXiang_SDLHBOX_Rad	[	97	]	=	15		BaoXiang_SDLHBOX_Count	[	97	]	=	1
	BaoXiang_SDLHBOX	[	98	]	=	1807		BaoXiang_SDLHBOX_Rad	[	98	]	=	300		BaoXiang_SDLHBOX_Count	[	98	]	=	1
	BaoXiang_SDLHBOX	[	99	]	=	1808		BaoXiang_SDLHBOX_Rad	[	99	]	=	15		BaoXiang_SDLHBOX_Count	[	99	]	=	1
	BaoXiang_SDLHBOX	[	100	]	=	1809		BaoXiang_SDLHBOX_Rad	[	100	]	=	15		BaoXiang_SDLHBOX_Count	[	100	]	=	1
	BaoXiang_SDLHBOX	[	101	]	=	1810		BaoXiang_SDLHBOX_Rad	[	101	]	=	15		BaoXiang_SDLHBOX_Count	[	101	]	=	1
	BaoXiang_SDLHBOX	[	102	]	=	1811		BaoXiang_SDLHBOX_Rad	[	102	]	=	15		BaoXiang_SDLHBOX_Count	[	102	]	=	1
	BaoXiang_SDLHBOX	[	103	]	=	4606		BaoXiang_SDLHBOX_Rad	[	103	]	=	1		BaoXiang_SDLHBOX_Count	[	103	]	=	1
	BaoXiang_SDLHBOX	[	104	]	=	4607		BaoXiang_SDLHBOX_Rad	[	104	]	=	1		BaoXiang_SDLHBOX_Count	[	104	]	=	1
	BaoXiang_SDLHBOX	[	105	]	=	4608		BaoXiang_SDLHBOX_Rad	[	105	]	=	1		BaoXiang_SDLHBOX_Count	[	105	]	=	1
	BaoXiang_SDLHBOX	[	106	]	=	4609		BaoXiang_SDLHBOX_Rad	[	106	]	=	1		BaoXiang_SDLHBOX_Count	[	106	]	=	1
	BaoXiang_SDLHBOX	[	107	]	=	4610		BaoXiang_SDLHBOX_Rad	[	107	]	=	1		BaoXiang_SDLHBOX_Count	[	107	]	=	1
	BaoXiang_SDLHBOX	[	108	]	=	4636		BaoXiang_SDLHBOX_Rad	[	108	]	=	1		BaoXiang_SDLHBOX_Count	[	108	]	=	1
	BaoXiang_SDLHBOX	[	109	]	=	4637		BaoXiang_SDLHBOX_Rad	[	109	]	=	1		BaoXiang_SDLHBOX_Count	[	109	]	=	1
	BaoXiang_SDLHBOX	[	110	]	=	4638		BaoXiang_SDLHBOX_Rad	[	110	]	=	1		BaoXiang_SDLHBOX_Count	[	110	]	=	1
	BaoXiang_SDLHBOX	[	111	]	=	4639		BaoXiang_SDLHBOX_Rad	[	111	]	=	1		BaoXiang_SDLHBOX_Count	[	111	]	=	1
	BaoXiang_SDLHBOX	[	112	]	=	4640		BaoXiang_SDLHBOX_Rad	[	112	]	=	1		BaoXiang_SDLHBOX_Count	[	112	]	=	1
	BaoXiang_SDLHBOX	[	113	]	=	4691		BaoXiang_SDLHBOX_Rad	[	113	]	=	1		BaoXiang_SDLHBOX_Count	[	113	]	=	1
	BaoXiang_SDLHBOX	[	114	]	=	4692		BaoXiang_SDLHBOX_Rad	[	114	]	=	1		BaoXiang_SDLHBOX_Count	[	114	]	=	1
	BaoXiang_SDLHBOX	[	115	]	=	4693		BaoXiang_SDLHBOX_Rad	[	115	]	=	1		BaoXiang_SDLHBOX_Count	[	115	]	=	1
	BaoXiang_SDLHBOX	[	116	]	=	4694		BaoXiang_SDLHBOX_Rad	[	116	]	=	1		BaoXiang_SDLHBOX_Count	[	116	]	=	1
	BaoXiang_SDLHBOX	[	117	]	=	4695		BaoXiang_SDLHBOX_Rad	[	117	]	=	1		BaoXiang_SDLHBOX_Count	[	117	]	=	1
	BaoXiang_SDLHBOX	[	118	]	=	4641		BaoXiang_SDLHBOX_Rad	[	118	]	=	1		BaoXiang_SDLHBOX_Count	[	118	]	=	1
	BaoXiang_SDLHBOX	[	119	]	=	4642		BaoXiang_SDLHBOX_Rad	[	119	]	=	1		BaoXiang_SDLHBOX_Count	[	119	]	=	1
	BaoXiang_SDLHBOX	[	120	]	=	4643		BaoXiang_SDLHBOX_Rad	[	120	]	=	1		BaoXiang_SDLHBOX_Count	[	120	]	=	1
	BaoXiang_SDLHBOX	[	121	]	=	4644		BaoXiang_SDLHBOX_Rad	[	121	]	=	1		BaoXiang_SDLHBOX_Count	[	121	]	=	1
	BaoXiang_SDLHBOX	[	122	]	=	4645		BaoXiang_SDLHBOX_Rad	[	122	]	=	1		BaoXiang_SDLHBOX_Count	[	122	]	=	1
	BaoXiang_SDLHBOX	[	123	]	=	4696		BaoXiang_SDLHBOX_Rad	[	123	]	=	1		BaoXiang_SDLHBOX_Count	[	123	]	=	1
	BaoXiang_SDLHBOX	[	124	]	=	4697		BaoXiang_SDLHBOX_Rad	[	124	]	=	1		BaoXiang_SDLHBOX_Count	[	124	]	=	1
	BaoXiang_SDLHBOX	[	125	]	=	4698		BaoXiang_SDLHBOX_Rad	[	125	]	=	1		BaoXiang_SDLHBOX_Count	[	125	]	=	1
	BaoXiang_SDLHBOX	[	126	]	=	4699		BaoXiang_SDLHBOX_Rad	[	126	]	=	1		BaoXiang_SDLHBOX_Count	[	126	]	=	1
	BaoXiang_SDLHBOX	[	127	]	=	4646		BaoXiang_SDLHBOX_Rad	[	127	]	=	1		BaoXiang_SDLHBOX_Count	[	127	]	=	1
	BaoXiang_SDLHBOX	[	128	]	=	4647		BaoXiang_SDLHBOX_Rad	[	128	]	=	1		BaoXiang_SDLHBOX_Count	[	128	]	=	1
	BaoXiang_SDLHBOX	[	129	]	=	4648		BaoXiang_SDLHBOX_Rad	[	129	]	=	1		BaoXiang_SDLHBOX_Count	[	129	]	=	1
	BaoXiang_SDLHBOX	[	130	]	=	4649		BaoXiang_SDLHBOX_Rad	[	130	]	=	1		BaoXiang_SDLHBOX_Count	[	130	]	=	1
	BaoXiang_SDLHBOX	[	131	]	=	4650		BaoXiang_SDLHBOX_Rad	[	131	]	=	1		BaoXiang_SDLHBOX_Count	[	131	]	=	1
	BaoXiang_SDLHBOX	[	132	]	=	4701		BaoXiang_SDLHBOX_Rad	[	132	]	=	1		BaoXiang_SDLHBOX_Count	[	132	]	=	1
	BaoXiang_SDLHBOX	[	133	]	=	4702		BaoXiang_SDLHBOX_Rad	[	133	]	=	1		BaoXiang_SDLHBOX_Count	[	133	]	=	1
	BaoXiang_SDLHBOX	[	134	]	=	4703		BaoXiang_SDLHBOX_Rad	[	134	]	=	1		BaoXiang_SDLHBOX_Count	[	134	]	=	1
	BaoXiang_SDLHBOX	[	135	]	=	4704		BaoXiang_SDLHBOX_Rad	[	135	]	=	1		BaoXiang_SDLHBOX_Count	[	135	]	=	1
	BaoXiang_SDLHBOX	[	136	]	=	4705		BaoXiang_SDLHBOX_Rad	[	136	]	=	1		BaoXiang_SDLHBOX_Count	[	136	]	=	1
	BaoXiang_SDLHBOX	[	137	]	=	4651		BaoXiang_SDLHBOX_Rad	[	137	]	=	1		BaoXiang_SDLHBOX_Count	[	137	]	=	1
	BaoXiang_SDLHBOX	[	138	]	=	4652		BaoXiang_SDLHBOX_Rad	[	138	]	=	1		BaoXiang_SDLHBOX_Count	[	138	]	=	1
	BaoXiang_SDLHBOX	[	139	]	=	4653		BaoXiang_SDLHBOX_Rad	[	139	]	=	1		BaoXiang_SDLHBOX_Count	[	139	]	=	1
	BaoXiang_SDLHBOX	[	140	]	=	4654		BaoXiang_SDLHBOX_Rad	[	140	]	=	1		BaoXiang_SDLHBOX_Count	[	140	]	=	1
	BaoXiang_SDLHBOX	[	141	]	=	4655		BaoXiang_SDLHBOX_Rad	[	141	]	=	1		BaoXiang_SDLHBOX_Count	[	141	]	=	1
	BaoXiang_SDLHBOX	[	142	]	=	4706		BaoXiang_SDLHBOX_Rad	[	142	]	=	1		BaoXiang_SDLHBOX_Count	[	142	]	=	1
	BaoXiang_SDLHBOX	[	143	]	=	4707		BaoXiang_SDLHBOX_Rad	[	143	]	=	1		BaoXiang_SDLHBOX_Count	[	143	]	=	1
	BaoXiang_SDLHBOX	[	144	]	=	4708		BaoXiang_SDLHBOX_Rad	[	144	]	=	1		BaoXiang_SDLHBOX_Count	[	144	]	=	1
	BaoXiang_SDLHBOX	[	145	]	=	4709		BaoXiang_SDLHBOX_Rad	[	145	]	=	1		BaoXiang_SDLHBOX_Count	[	145	]	=	1
	BaoXiang_SDLHBOX	[	146	]	=	4543		BaoXiang_SDLHBOX_Rad	[	146	]	=	20		BaoXiang_SDLHBOX_Count	[	146	]	=	10
	BaoXiang_SDLHBOX	[	147	]	=	4544		BaoXiang_SDLHBOX_Rad	[	147	]	=	20		BaoXiang_SDLHBOX_Count	[	147	]	=	5
	BaoXiang_SDLHBOX	[	148	]	=	4545		BaoXiang_SDLHBOX_Rad	[	148	]	=	20		BaoXiang_SDLHBOX_Count	[	148	]	=	8
	BaoXiang_SDLHBOX	[	149	]	=	4546		BaoXiang_SDLHBOX_Rad	[	149	]	=	20		BaoXiang_SDLHBOX_Count	[	149	]	=	5
	BaoXiang_SDLHBOX	[	150	]	=	1478		BaoXiang_SDLHBOX_Rad	[	150	]	=	20		BaoXiang_SDLHBOX_Count	[	150	]	=	10


	BaoXiang_HYBOX_Qua	=	5	 			BaoXiang_HYBOX_Mxcount	=	22										
	BaoXiang_HYBOX	=	{}					BaoXiang_HYBOX_Rad	=	{}					BaoXiang_HYBOX_Count	=	{}			
	BaoXiang_HYBOX	[	1	]	=	3851		BaoXiang_HYBOX_Rad	[	1	]	=	1 		BaoXiang_HYBOX_Count	[	1	]	=	1
	BaoXiang_HYBOX	[	2	]	=	3852		BaoXiang_HYBOX_Rad	[	2	]	=	1 		BaoXiang_HYBOX_Count	[	2	]	=	1
	BaoXiang_HYBOX	[	3	]	=	3853		BaoXiang_HYBOX_Rad	[	3	]	=	1 		BaoXiang_HYBOX_Count	[	3	]	=	1
	BaoXiang_HYBOX	[	4	]	=	3855		BaoXiang_HYBOX_Rad	[	4	]	=	1 		BaoXiang_HYBOX_Count	[	4	]	=	1
	BaoXiang_HYBOX	[	5	]	=	3856		BaoXiang_HYBOX_Rad	[	5	]	=	1 		BaoXiang_HYBOX_Count	[	5	]	=	1
	BaoXiang_HYBOX	[	6	]	=	3857		BaoXiang_HYBOX_Rad	[	6	]	=	1 		BaoXiang_HYBOX_Count	[	6	]	=	1
	BaoXiang_HYBOX	[	7	]	=	3858		BaoXiang_HYBOX_Rad	[	7	]	=	1 		BaoXiang_HYBOX_Count	[	7	]	=	1
	BaoXiang_HYBOX	[	8	]	=	3859		BaoXiang_HYBOX_Rad	[	8	]	=	1 		BaoXiang_HYBOX_Count	[	8	]	=	1
	BaoXiang_HYBOX	[	9	]	=	3860		BaoXiang_HYBOX_Rad	[	9	]	=	1 		BaoXiang_HYBOX_Count	[	9	]	=	1
	BaoXiang_HYBOX	[	10	]	=	3861		BaoXiang_HYBOX_Rad	[	10	]	=	1 		BaoXiang_HYBOX_Count	[	10	]	=	1
	BaoXiang_HYBOX	[	11	]	=	3862		BaoXiang_HYBOX_Rad	[	11	]	=	1 		BaoXiang_HYBOX_Count	[	11	]	=	1
	BaoXiang_HYBOX	[	12	]	=	3863		BaoXiang_HYBOX_Rad	[	12	]	=	1 		BaoXiang_HYBOX_Count	[	12	]	=	1
	BaoXiang_HYBOX	[	13	]	=	3864		BaoXiang_HYBOX_Rad	[	13	]	=	1 		BaoXiang_HYBOX_Count	[	13	]	=	1
	BaoXiang_HYBOX	[	14	]	=	3865		BaoXiang_HYBOX_Rad	[	14	]	=	1 		BaoXiang_HYBOX_Count	[	14	]	=	1
	BaoXiang_HYBOX	[	15	]	=	3866		BaoXiang_HYBOX_Rad	[	15	]	=	1 		BaoXiang_HYBOX_Count	[	15	]	=	1
	BaoXiang_HYBOX	[	16	]	=	3869		BaoXiang_HYBOX_Rad	[	16	]	=	1 		BaoXiang_HYBOX_Count	[	16	]	=	1
	BaoXiang_HYBOX	[	17	]	=	3870		BaoXiang_HYBOX_Rad	[	17	]	=	1 		BaoXiang_HYBOX_Count	[	17	]	=	1
	BaoXiang_HYBOX	[	18	]	=	3871		BaoXiang_HYBOX_Rad	[	18	]	=	1 		BaoXiang_HYBOX_Count	[	18	]	=	1
	BaoXiang_HYBOX	[	19	]	=	3872		BaoXiang_HYBOX_Rad	[	19	]	=	1 		BaoXiang_HYBOX_Count	[	19	]	=	1
	BaoXiang_HYBOX	[	20	]	=	3873		BaoXiang_HYBOX_Rad	[	20	]	=	1 		BaoXiang_HYBOX_Count	[	20	]	=	1
	BaoXiang_HYBOX	[	21	]	=	3874		BaoXiang_HYBOX_Rad	[	21	]	=	1 		BaoXiang_HYBOX_Count	[	21	]	=	1
	BaoXiang_HYBOX	[	22	]	=	3875		BaoXiang_HYBOX_Rad	[	22	]	=	1 		BaoXiang_HYBOX_Count	[	22	]	=	1
																				
																				
	BaoXiang_HYUNBOX_Qua	=	5	 				BaoXiang_HYUNBOX_Mxcount	=	53										
	BaoXiang_HYUNBOX	=	{}					BaoXiang_HYUNBOX_Rad	=	{}					BaoXiang_HYUNBOX_Count	=	{}			
	BaoXiang_HYUNBOX	[	1	]	=	3851		BaoXiang_HYUNBOX_Rad	[	1	]	=	200 		BaoXiang_HYUNBOX_Count	[	1	]	=	1
	BaoXiang_HYUNBOX	[	2	]	=	3852		BaoXiang_HYUNBOX_Rad	[	2	]	=	300 		BaoXiang_HYUNBOX_Count	[	2	]	=	1
	BaoXiang_HYUNBOX	[	3	]	=	3853		BaoXiang_HYUNBOX_Rad	[	3	]	=	200 		BaoXiang_HYUNBOX_Count	[	3	]	=	1
	BaoXiang_HYUNBOX	[	4	]	=	3855		BaoXiang_HYUNBOX_Rad	[	4	]	=	200 		BaoXiang_HYUNBOX_Count	[	4	]	=	1
	BaoXiang_HYUNBOX	[	5	]	=	3856		BaoXiang_HYUNBOX_Rad	[	5	]	=	200 		BaoXiang_HYUNBOX_Count	[	5	]	=	1
	BaoXiang_HYUNBOX	[	6	]	=	3857		BaoXiang_HYUNBOX_Rad	[	6	]	=	200 		BaoXiang_HYUNBOX_Count	[	6	]	=	1
	BaoXiang_HYUNBOX	[	7	]	=	3858		BaoXiang_HYUNBOX_Rad	[	7	]	=	200 		BaoXiang_HYUNBOX_Count	[	7	]	=	1
	BaoXiang_HYUNBOX	[	8	]	=	3859		BaoXiang_HYUNBOX_Rad	[	8	]	=	200 		BaoXiang_HYUNBOX_Count	[	8	]	=	1
	BaoXiang_HYUNBOX	[	9	]	=	3860		BaoXiang_HYUNBOX_Rad	[	9	]	=	200 		BaoXiang_HYUNBOX_Count	[	9	]	=	1
	BaoXiang_HYUNBOX	[	10	]	=	3861		BaoXiang_HYUNBOX_Rad	[	10	]	=	200 		BaoXiang_HYUNBOX_Count	[	10	]	=	1
	BaoXiang_HYUNBOX	[	11	]	=	3862		BaoXiang_HYUNBOX_Rad	[	11	]	=	200 		BaoXiang_HYUNBOX_Count	[	11	]	=	1
	BaoXiang_HYUNBOX	[	12	]	=	3863		BaoXiang_HYUNBOX_Rad	[	12	]	=	200 		BaoXiang_HYUNBOX_Count	[	12	]	=	1
	BaoXiang_HYUNBOX	[	13	]	=	3864		BaoXiang_HYUNBOX_Rad	[	13	]	=	200 		BaoXiang_HYUNBOX_Count	[	13	]	=	1
	BaoXiang_HYUNBOX	[	14	]	=	3865		BaoXiang_HYUNBOX_Rad	[	14	]	=	200 		BaoXiang_HYUNBOX_Count	[	14	]	=	1
	BaoXiang_HYUNBOX	[	15	]	=	3866		BaoXiang_HYUNBOX_Rad	[	15	]	=	400 		BaoXiang_HYUNBOX_Count	[	15	]	=	1
	BaoXiang_HYUNBOX	[	16	]	=	3869		BaoXiang_HYUNBOX_Rad	[	16	]	=	200 		BaoXiang_HYUNBOX_Count	[	16	]	=	1
	BaoXiang_HYUNBOX	[	17	]	=	3870		BaoXiang_HYUNBOX_Rad	[	17	]	=	200 		BaoXiang_HYUNBOX_Count	[	17	]	=	1
	BaoXiang_HYUNBOX	[	18	]	=	3871		BaoXiang_HYUNBOX_Rad	[	18	]	=	200 		BaoXiang_HYUNBOX_Count	[	18	]	=	1
	BaoXiang_HYUNBOX	[	19	]	=	3872		BaoXiang_HYUNBOX_Rad	[	19	]	=	200 		BaoXiang_HYUNBOX_Count	[	19	]	=	1
	BaoXiang_HYUNBOX	[	20	]	=	3873		BaoXiang_HYUNBOX_Rad	[	20	]	=	600 		BaoXiang_HYUNBOX_Count	[	20	]	=	1
	BaoXiang_HYUNBOX	[	21	]	=	3874		BaoXiang_HYUNBOX_Rad	[	21	]	=	200 		BaoXiang_HYUNBOX_Count	[	21	]	=	1
	BaoXiang_HYUNBOX	[	22	]	=	3875		BaoXiang_HYUNBOX_Rad	[	22	]	=	200 		BaoXiang_HYUNBOX_Count	[	22	]	=	1
	BaoXiang_HYUNBOX	[	23	]	=	3828		BaoXiang_HYUNBOX_Rad	[	23	]	=	175 		BaoXiang_HYUNBOX_Count	[	23	]	=	1
	BaoXiang_HYUNBOX	[	24	]	=	3829		BaoXiang_HYUNBOX_Rad	[	24	]	=	175 		BaoXiang_HYUNBOX_Count	[	24	]	=	1
	BaoXiang_HYUNBOX	[	25	]	=	3830		BaoXiang_HYUNBOX_Rad	[	25	]	=	175 		BaoXiang_HYUNBOX_Count	[	25	]	=	1
	BaoXiang_HYUNBOX	[	26	]	=	3831		BaoXiang_HYUNBOX_Rad	[	26	]	=	175 		BaoXiang_HYUNBOX_Count	[	26	]	=	1
	BaoXiang_HYUNBOX	[	27	]	=	3832		BaoXiang_HYUNBOX_Rad	[	27	]	=	175 		BaoXiang_HYUNBOX_Count	[	27	]	=	1
	BaoXiang_HYUNBOX	[	28	]	=	3833		BaoXiang_HYUNBOX_Rad	[	28	]	=	175 		BaoXiang_HYUNBOX_Count	[	28	]	=	1
	BaoXiang_HYUNBOX	[	29	]	=	3834		BaoXiang_HYUNBOX_Rad	[	29	]	=	175 		BaoXiang_HYUNBOX_Count	[	29	]	=	1
	BaoXiang_HYUNBOX	[	30	]	=	3835		BaoXiang_HYUNBOX_Rad	[	30	]	=	175 		BaoXiang_HYUNBOX_Count	[	30	]	=	1
	BaoXiang_HYUNBOX	[	31	]	=	3836		BaoXiang_HYUNBOX_Rad	[	31	]	=	175 		BaoXiang_HYUNBOX_Count	[	31	]	=	1
	BaoXiang_HYUNBOX	[	32	]	=	3837		BaoXiang_HYUNBOX_Rad	[	32	]	=	175 		BaoXiang_HYUNBOX_Count	[	32	]	=	1
	BaoXiang_HYUNBOX	[	33	]	=	3838		BaoXiang_HYUNBOX_Rad	[	33	]	=	175 		BaoXiang_HYUNBOX_Count	[	33	]	=	1
	BaoXiang_HYUNBOX	[	34	]	=	3839		BaoXiang_HYUNBOX_Rad	[	34	]	=	175 		BaoXiang_HYUNBOX_Count	[	34	]	=	1
	BaoXiang_HYUNBOX	[	35	]	=	3840		BaoXiang_HYUNBOX_Rad	[	35	]	=	175 		BaoXiang_HYUNBOX_Count	[	35	]	=	1
	BaoXiang_HYUNBOX	[	36	]	=	3841		BaoXiang_HYUNBOX_Rad	[	36	]	=	175 		BaoXiang_HYUNBOX_Count	[	36	]	=	1
	BaoXiang_HYUNBOX	[	37	]	=	3842		BaoXiang_HYUNBOX_Rad	[	37	]	=	175 		BaoXiang_HYUNBOX_Count	[	37	]	=	1
	BaoXiang_HYUNBOX	[	38	]	=	3843		BaoXiang_HYUNBOX_Rad	[	38	]	=	175 		BaoXiang_HYUNBOX_Count	[	38	]	=	1
	BaoXiang_HYUNBOX	[	39	]	=	3844		BaoXiang_HYUNBOX_Rad	[	39	]	=	1000 		BaoXiang_HYUNBOX_Count	[	39	]	=	1
	BaoXiang_HYUNBOX	[	40	]	=	3845		BaoXiang_HYUNBOX_Rad	[	40	]	=	1000 		BaoXiang_HYUNBOX_Count	[	40	]	=	1
	BaoXiang_HYUNBOX	[	41	]	=	0899		BaoXiang_HYUNBOX_Rad	[	41	]	=	6 		BaoXiang_HYUNBOX_Count	[	41	]	=	1
	BaoXiang_HYUNBOX	[	42	]	=	0900		BaoXiang_HYUNBOX_Rad	[	42	]	=	6 		BaoXiang_HYUNBOX_Count	[	42	]	=	1
	BaoXiang_HYUNBOX	[	43	]	=	0901		BaoXiang_HYUNBOX_Rad	[	43	]	=	6 		BaoXiang_HYUNBOX_Count	[	43	]	=	1
	BaoXiang_HYUNBOX	[	44	]	=	0902		BaoXiang_HYUNBOX_Rad	[	44	]	=	6 		BaoXiang_HYUNBOX_Count	[	44	]	=	1
	BaoXiang_HYUNBOX	[	45	]	=	0903		BaoXiang_HYUNBOX_Rad	[	45	]	=	6 		BaoXiang_HYUNBOX_Count	[	45	]	=	1
	BaoXiang_HYUNBOX	[	46	]	=	3131		BaoXiang_HYUNBOX_Rad	[	46	]	=	21 		BaoXiang_HYUNBOX_Count	[	46	]	=	1
	BaoXiang_HYUNBOX	[	47	]	=	3140		BaoXiang_HYUNBOX_Rad	[	47	]	=	21 		BaoXiang_HYUNBOX_Count	[	47	]	=	1
	BaoXiang_HYUNBOX	[	48	]	=	3133		BaoXiang_HYUNBOX_Rad	[	48	]	=	21 		BaoXiang_HYUNBOX_Count	[	48	]	=	1
	BaoXiang_HYUNBOX	[	49	]	=	3139		BaoXiang_HYUNBOX_Rad	[	49	]	=	21 		BaoXiang_HYUNBOX_Count	[	49	]	=	1
	BaoXiang_HYUNBOX	[	50	]	=	3135		BaoXiang_HYUNBOX_Rad	[	50	]	=	23 		BaoXiang_HYUNBOX_Count	[	50	]	=	1
	BaoXiang_HYUNBOX	[	51	]	=	3138		BaoXiang_HYUNBOX_Rad	[	51	]	=	21 		BaoXiang_HYUNBOX_Count	[	51	]	=	1
	BaoXiang_HYUNBOX	[	52	]	=	3136		BaoXiang_HYUNBOX_Rad	[	52	]	=	21 		BaoXiang_HYUNBOX_Count	[	52	]	=	1
	BaoXiang_HYUNBOX	[	53	]	=	3137		BaoXiang_HYUNBOX_Rad	[	53	]	=	21 		BaoXiang_HYUNBOX_Count	[	53	]	=	1
																																								
																				
	BaoXiang_FGBOX_Qua	=	5	 			BaoXiang_FGBOX_Mxcount	=	41										
	BaoXiang_FGBOX	=	{}					BaoXiang_FGBOX_Rad	=	{}					BaoXiang_FGBOX_Count	=	{}			
	BaoXiang_FGBOX	[	1	]	=	3828		BaoXiang_FGBOX_Rad	[	1	]	=	32 		BaoXiang_FGBOX_Count	[	1	]	=	1
	BaoXiang_FGBOX	[	2	]	=	3829		BaoXiang_FGBOX_Rad	[	2	]	=	32 		BaoXiang_FGBOX_Count	[	2	]	=	1
	BaoXiang_FGBOX	[	3	]	=	3830		BaoXiang_FGBOX_Rad	[	3	]	=	32 		BaoXiang_FGBOX_Count	[	3	]	=	1
	BaoXiang_FGBOX	[	4	]	=	3831		BaoXiang_FGBOX_Rad	[	4	]	=	32 		BaoXiang_FGBOX_Count	[	4	]	=	1
	BaoXiang_FGBOX	[	5	]	=	3832		BaoXiang_FGBOX_Rad	[	5	]	=	32 		BaoXiang_FGBOX_Count	[	5	]	=	1
	BaoXiang_FGBOX	[	6	]	=	3833		BaoXiang_FGBOX_Rad	[	6	]	=	32 		BaoXiang_FGBOX_Count	[	6	]	=	1
	BaoXiang_FGBOX	[	7	]	=	3834		BaoXiang_FGBOX_Rad	[	7	]	=	32 		BaoXiang_FGBOX_Count	[	7	]	=	1
	BaoXiang_FGBOX	[	8	]	=	3835		BaoXiang_FGBOX_Rad	[	8	]	=	32 		BaoXiang_FGBOX_Count	[	8	]	=	1
	BaoXiang_FGBOX	[	9	]	=	3836		BaoXiang_FGBOX_Rad	[	9	]	=	32 		BaoXiang_FGBOX_Count	[	9	]	=	1
	BaoXiang_FGBOX	[	10	]	=	3837		BaoXiang_FGBOX_Rad	[	10	]	=	32 		BaoXiang_FGBOX_Count	[	10	]	=	1
	BaoXiang_FGBOX	[	11	]	=	3838		BaoXiang_FGBOX_Rad	[	11	]	=	32 		BaoXiang_FGBOX_Count	[	11	]	=	1
	BaoXiang_FGBOX	[	12	]	=	3839		BaoXiang_FGBOX_Rad	[	12	]	=	32 		BaoXiang_FGBOX_Count	[	12	]	=	1
	BaoXiang_FGBOX	[	13	]	=	3840		BaoXiang_FGBOX_Rad	[	13	]	=	32 		BaoXiang_FGBOX_Count	[	13	]	=	1
	BaoXiang_FGBOX	[	14	]	=	3841		BaoXiang_FGBOX_Rad	[	14	]	=	32 		BaoXiang_FGBOX_Count	[	14	]	=	1
	BaoXiang_FGBOX	[	15	]	=	3842		BaoXiang_FGBOX_Rad	[	15	]	=	36 		BaoXiang_FGBOX_Count	[	15	]	=	1
	BaoXiang_FGBOX	[	16	]	=	3843		BaoXiang_FGBOX_Rad	[	16	]	=	36 		BaoXiang_FGBOX_Count	[	16	]	=	1
	BaoXiang_FGBOX	[	17	]	=	1787		BaoXiang_FGBOX_Rad	[	17	]	=	42 		BaoXiang_FGBOX_Count	[	17	]	=	1
	BaoXiang_FGBOX	[	18	]	=	1788		BaoXiang_FGBOX_Rad	[	18	]	=	44 		BaoXiang_FGBOX_Count	[	18	]	=	1
	BaoXiang_FGBOX	[	19	]	=	1789		BaoXiang_FGBOX_Rad	[	19	]	=	42 		BaoXiang_FGBOX_Count	[	19	]	=	1
	BaoXiang_FGBOX	[	20	]	=	1790		BaoXiang_FGBOX_Rad	[	20	]	=	42 		BaoXiang_FGBOX_Count	[	20	]	=	1
	BaoXiang_FGBOX	[	21	]	=	1791		BaoXiang_FGBOX_Rad	[	21	]	=	44 		BaoXiang_FGBOX_Count	[	21	]	=	1
	BaoXiang_FGBOX	[	22	]	=	1792		BaoXiang_FGBOX_Rad	[	22	]	=	42 		BaoXiang_FGBOX_Count	[	22	]	=	1
	BaoXiang_FGBOX	[	23	]	=	1793		BaoXiang_FGBOX_Rad	[	23	]	=	44 		BaoXiang_FGBOX_Count	[	23	]	=	1
	BaoXiang_FGBOX	[	24	]	=	0893		BaoXiang_FGBOX_Rad	[	24	]	=	2 		BaoXiang_FGBOX_Count	[	24	]	=	1
	BaoXiang_FGBOX	[	25	]	=	0894		BaoXiang_FGBOX_Rad	[	25	]	=	4 		BaoXiang_FGBOX_Count	[	25	]	=	1
	BaoXiang_FGBOX	[	26	]	=	0895		BaoXiang_FGBOX_Rad	[	26	]	=	4 		BaoXiang_FGBOX_Count	[	26	]	=	1
	BaoXiang_FGBOX	[	27	]	=	0896		BaoXiang_FGBOX_Rad	[	27	]	=	4 		BaoXiang_FGBOX_Count	[	27	]	=	1
	BaoXiang_FGBOX	[	28	]	=	0897		BaoXiang_FGBOX_Rad	[	28	]	=	2 		BaoXiang_FGBOX_Count	[	28	]	=	1
	BaoXiang_FGBOX	[	29	]	=	0898		BaoXiang_FGBOX_Rad	[	29	]	=	4 		BaoXiang_FGBOX_Count	[	29	]	=	1
	BaoXiang_FGBOX	[	30	]	=	0878		BaoXiang_FGBOX_Rad	[	30	]	=	1 		BaoXiang_FGBOX_Count	[	30	]	=	1
	BaoXiang_FGBOX	[	31	]	=	3844		BaoXiang_FGBOX_Rad	[	31	]	=	10 		BaoXiang_FGBOX_Count	[	31	]	=	1
	BaoXiang_FGBOX	[	32	]	=	3845		BaoXiang_FGBOX_Rad	[	32	]	=	10 		BaoXiang_FGBOX_Count	[	32	]	=	1
	BaoXiang_FGBOX	[	33	]	=	3131		BaoXiang_FGBOX_Rad	[	33	]	=	174 		BaoXiang_FGBOX_Count	[	33	]	=	1
	BaoXiang_FGBOX	[	34	]	=	3132		BaoXiang_FGBOX_Rad	[	34	]	=	174 		BaoXiang_FGBOX_Count	[	34	]	=	1
	BaoXiang_FGBOX	[	35	]	=	3133		BaoXiang_FGBOX_Rad	[	35	]	=	174 		BaoXiang_FGBOX_Count	[	35	]	=	1
	BaoXiang_FGBOX	[	36	]	=	3121		BaoXiang_FGBOX_Rad	[	36	]	=	174 		BaoXiang_FGBOX_Count	[	36	]	=	1
	BaoXiang_FGBOX	[	37	]	=	3130		BaoXiang_FGBOX_Rad	[	37	]	=	174 		BaoXiang_FGBOX_Count	[	37	]	=	1
	BaoXiang_FGBOX	[	38	]	=	3119		BaoXiang_FGBOX_Rad	[	38	]	=	174 		BaoXiang_FGBOX_Count	[	38	]	=	1
	BaoXiang_FGBOX	[	39	]	=	3122		BaoXiang_FGBOX_Rad	[	39	]	=	174 		BaoXiang_FGBOX_Count	[	39	]	=	1
	BaoXiang_FGBOX	[	40	]	=	3141		BaoXiang_FGBOX_Rad	[	40	]	=	174 		BaoXiang_FGBOX_Count	[	40	]	=	1
	BaoXiang_FGBOX	[	41	]	=	3129		BaoXiang_FGBOX_Rad	[	41	]	=	174 		BaoXiang_FGBOX_Count	[	41	]	=	1
																																								
																				
	BaoXiang_ADBOX_Qua	=	5	 			BaoXiang_ADBOX_Mxcount	=	139										
	BaoXiang_ADBOX	=	{}					BaoXiang_ADBOX_Rad	=	{}					BaoXiang_ADBOX_Count	=	{}			
	BaoXiang_ADBOX	[	1	]	=	3909		BaoXiang_ADBOX_Rad	[	1	]	=	600 		BaoXiang_ADBOX_Count	[	1	]	=	1
	BaoXiang_ADBOX	[	2	]	=	3345		BaoXiang_ADBOX_Rad	[	2	]	=	300 		BaoXiang_ADBOX_Count	[	2	]	=	1
	BaoXiang_ADBOX	[	3	]	=	3346		BaoXiang_ADBOX_Rad	[	3	]	=	300 		BaoXiang_ADBOX_Count	[	3	]	=	1
	BaoXiang_ADBOX	[	4	]	=	3347		BaoXiang_ADBOX_Rad	[	4	]	=	300 		BaoXiang_ADBOX_Count	[	4	]	=	1
	BaoXiang_ADBOX	[	5	]	=	0002		BaoXiang_ADBOX_Rad	[	5	]	=	8 		BaoXiang_ADBOX_Count	[	5	]	=	1
	BaoXiang_ADBOX	[	6	]	=	0003		BaoXiang_ADBOX_Rad	[	6	]	=	8 		BaoXiang_ADBOX_Count	[	6	]	=	1
	BaoXiang_ADBOX	[	7	]	=	0004		BaoXiang_ADBOX_Rad	[	7	]	=	8 		BaoXiang_ADBOX_Count	[	7	]	=	1
	BaoXiang_ADBOX	[	8	]	=	0010		BaoXiang_ADBOX_Rad	[	8	]	=	8 		BaoXiang_ADBOX_Count	[	8	]	=	1
	BaoXiang_ADBOX	[	9	]	=	0011		BaoXiang_ADBOX_Rad	[	9	]	=	8 		BaoXiang_ADBOX_Count	[	9	]	=	1
	BaoXiang_ADBOX	[	10	]	=	0012		BaoXiang_ADBOX_Rad	[	10	]	=	8 		BaoXiang_ADBOX_Count	[	10	]	=	1
	BaoXiang_ADBOX	[	11	]	=	0013		BaoXiang_ADBOX_Rad	[	11	]	=	8 		BaoXiang_ADBOX_Count	[	11	]	=	1
	BaoXiang_ADBOX	[	12	]	=	0014		BaoXiang_ADBOX_Rad	[	12	]	=	8 		BaoXiang_ADBOX_Count	[	12	]	=	1
	BaoXiang_ADBOX	[	13	]	=	0015		BaoXiang_ADBOX_Rad	[	13	]	=	8 		BaoXiang_ADBOX_Count	[	13	]	=	1
	BaoXiang_ADBOX	[	14	]	=	0025		BaoXiang_ADBOX_Rad	[	14	]	=	8 		BaoXiang_ADBOX_Count	[	14	]	=	1
	BaoXiang_ADBOX	[	15	]	=	0026		BaoXiang_ADBOX_Rad	[	15	]	=	8 		BaoXiang_ADBOX_Count	[	15	]	=	1
	BaoXiang_ADBOX	[	16	]	=	0027		BaoXiang_ADBOX_Rad	[	16	]	=	8 		BaoXiang_ADBOX_Count	[	16	]	=	1
	BaoXiang_ADBOX	[	17	]	=	0032		BaoXiang_ADBOX_Rad	[	17	]	=	8 		BaoXiang_ADBOX_Count	[	17	]	=	1
	BaoXiang_ADBOX	[	18	]	=	0033		BaoXiang_ADBOX_Rad	[	18	]	=	8 		BaoXiang_ADBOX_Count	[	18	]	=	1
	BaoXiang_ADBOX	[	19	]	=	0034		BaoXiang_ADBOX_Rad	[	19	]	=	8 		BaoXiang_ADBOX_Count	[	19	]	=	1
	BaoXiang_ADBOX	[	20	]	=	0037		BaoXiang_ADBOX_Rad	[	20	]	=	8 		BaoXiang_ADBOX_Count	[	20	]	=	1
	BaoXiang_ADBOX	[	21	]	=	0038		BaoXiang_ADBOX_Rad	[	21	]	=	8 		BaoXiang_ADBOX_Count	[	21	]	=	1
	BaoXiang_ADBOX	[	22	]	=	0039		BaoXiang_ADBOX_Rad	[	22	]	=	8 		BaoXiang_ADBOX_Count	[	22	]	=	1
	BaoXiang_ADBOX	[	23	]	=	0074		BaoXiang_ADBOX_Rad	[	23	]	=	8 		BaoXiang_ADBOX_Count	[	23	]	=	1
	BaoXiang_ADBOX	[	24	]	=	0075		BaoXiang_ADBOX_Rad	[	24	]	=	8 		BaoXiang_ADBOX_Count	[	24	]	=	1
	BaoXiang_ADBOX	[	25	]	=	0076		BaoXiang_ADBOX_Rad	[	25	]	=	8 		BaoXiang_ADBOX_Count	[	25	]	=	1
	BaoXiang_ADBOX	[	26	]	=	0081		BaoXiang_ADBOX_Rad	[	26	]	=	8 		BaoXiang_ADBOX_Count	[	26	]	=	1
	BaoXiang_ADBOX	[	27	]	=	0082		BaoXiang_ADBOX_Rad	[	27	]	=	8 		BaoXiang_ADBOX_Count	[	27	]	=	1
	BaoXiang_ADBOX	[	28	]	=	0098		BaoXiang_ADBOX_Rad	[	28	]	=	8 		BaoXiang_ADBOX_Count	[	28	]	=	1
	BaoXiang_ADBOX	[	29	]	=	0099		BaoXiang_ADBOX_Rad	[	29	]	=	8 		BaoXiang_ADBOX_Count	[	29	]	=	1
	BaoXiang_ADBOX	[	30	]	=	0100		BaoXiang_ADBOX_Rad	[	30	]	=	8 		BaoXiang_ADBOX_Count	[	30	]	=	1
	BaoXiang_ADBOX	[	31	]	=	0101		BaoXiang_ADBOX_Rad	[	31	]	=	8 		BaoXiang_ADBOX_Count	[	31	]	=	1
	BaoXiang_ADBOX	[	32	]	=	0104		BaoXiang_ADBOX_Rad	[	32	]	=	8 		BaoXiang_ADBOX_Count	[	32	]	=	1
	BaoXiang_ADBOX	[	33	]	=	0105		BaoXiang_ADBOX_Rad	[	33	]	=	8 		BaoXiang_ADBOX_Count	[	33	]	=	1
	BaoXiang_ADBOX	[	34	]	=	0106		BaoXiang_ADBOX_Rad	[	34	]	=	8 		BaoXiang_ADBOX_Count	[	34	]	=	1
	BaoXiang_ADBOX	[	35	]	=	0122		BaoXiang_ADBOX_Rad	[	35	]	=	8 		BaoXiang_ADBOX_Count	[	35	]	=	1
	BaoXiang_ADBOX	[	36	]	=	0123		BaoXiang_ADBOX_Rad	[	36	]	=	8 		BaoXiang_ADBOX_Count	[	36	]	=	1
	BaoXiang_ADBOX	[	37	]	=	0124		BaoXiang_ADBOX_Rad	[	37	]	=	8 		BaoXiang_ADBOX_Count	[	37	]	=	1
	BaoXiang_ADBOX	[	38	]	=	0291		BaoXiang_ADBOX_Rad	[	38	]	=	8 		BaoXiang_ADBOX_Count	[	38	]	=	1
	BaoXiang_ADBOX	[	39	]	=	0293		BaoXiang_ADBOX_Rad	[	39	]	=	8 		BaoXiang_ADBOX_Count	[	39	]	=	1
	BaoXiang_ADBOX	[	40	]	=	0295		BaoXiang_ADBOX_Rad	[	40	]	=	8 		BaoXiang_ADBOX_Count	[	40	]	=	1
	BaoXiang_ADBOX	[	41	]	=	0297		BaoXiang_ADBOX_Rad	[	41	]	=	8 		BaoXiang_ADBOX_Count	[	41	]	=	1
	BaoXiang_ADBOX	[	42	]	=	0298		BaoXiang_ADBOX_Rad	[	42	]	=	8 		BaoXiang_ADBOX_Count	[	42	]	=	1
	BaoXiang_ADBOX	[	43	]	=	0300		BaoXiang_ADBOX_Rad	[	43	]	=	8 		BaoXiang_ADBOX_Count	[	43	]	=	1
	BaoXiang_ADBOX	[	44	]	=	0306		BaoXiang_ADBOX_Rad	[	44	]	=	8 		BaoXiang_ADBOX_Count	[	44	]	=	1
	BaoXiang_ADBOX	[	45	]	=	0307		BaoXiang_ADBOX_Rad	[	45	]	=	8 		BaoXiang_ADBOX_Count	[	45	]	=	1
	BaoXiang_ADBOX	[	46	]	=	0311		BaoXiang_ADBOX_Rad	[	46	]	=	8 		BaoXiang_ADBOX_Count	[	46	]	=	1
	BaoXiang_ADBOX	[	47	]	=	0313		BaoXiang_ADBOX_Rad	[	47	]	=	8 		BaoXiang_ADBOX_Count	[	47	]	=	1
	BaoXiang_ADBOX	[	48	]	=	0314		BaoXiang_ADBOX_Rad	[	48	]	=	8 		BaoXiang_ADBOX_Count	[	48	]	=	1
	BaoXiang_ADBOX	[	49	]	=	0336		BaoXiang_ADBOX_Rad	[	49	]	=	8 		BaoXiang_ADBOX_Count	[	49	]	=	1
	BaoXiang_ADBOX	[	50	]	=	0337		BaoXiang_ADBOX_Rad	[	50	]	=	8 		BaoXiang_ADBOX_Count	[	50	]	=	1
	BaoXiang_ADBOX	[	51	]	=	0338		BaoXiang_ADBOX_Rad	[	51	]	=	8 		BaoXiang_ADBOX_Count	[	51	]	=	1
	BaoXiang_ADBOX	[	52	]	=	0339		BaoXiang_ADBOX_Rad	[	52	]	=	8 		BaoXiang_ADBOX_Count	[	52	]	=	1
	BaoXiang_ADBOX	[	53	]	=	0340		BaoXiang_ADBOX_Rad	[	53	]	=	8 		BaoXiang_ADBOX_Count	[	53	]	=	1
	BaoXiang_ADBOX	[	54	]	=	0341		BaoXiang_ADBOX_Rad	[	54	]	=	8 		BaoXiang_ADBOX_Count	[	54	]	=	1
	BaoXiang_ADBOX	[	55	]	=	0352		BaoXiang_ADBOX_Rad	[	55	]	=	8 		BaoXiang_ADBOX_Count	[	55	]	=	1
	BaoXiang_ADBOX	[	56	]	=	0353		BaoXiang_ADBOX_Rad	[	56	]	=	8 		BaoXiang_ADBOX_Count	[	56	]	=	1
	BaoXiang_ADBOX	[	57	]	=	0354		BaoXiang_ADBOX_Rad	[	57	]	=	8 		BaoXiang_ADBOX_Count	[	57	]	=	1
	BaoXiang_ADBOX	[	58	]	=	0350		BaoXiang_ADBOX_Rad	[	58	]	=	8 		BaoXiang_ADBOX_Count	[	58	]	=	1
	BaoXiang_ADBOX	[	59	]	=	0360		BaoXiang_ADBOX_Rad	[	59	]	=	8 		BaoXiang_ADBOX_Count	[	59	]	=	1
	BaoXiang_ADBOX	[	60	]	=	0361		BaoXiang_ADBOX_Rad	[	60	]	=	8 		BaoXiang_ADBOX_Count	[	60	]	=	1
	BaoXiang_ADBOX	[	61	]	=	0362		BaoXiang_ADBOX_Rad	[	61	]	=	8 		BaoXiang_ADBOX_Count	[	61	]	=	1
	BaoXiang_ADBOX	[	62	]	=	0467		BaoXiang_ADBOX_Rad	[	62	]	=	8 		BaoXiang_ADBOX_Count	[	62	]	=	1
	BaoXiang_ADBOX	[	63	]	=	0469		BaoXiang_ADBOX_Rad	[	63	]	=	8 		BaoXiang_ADBOX_Count	[	63	]	=	1
	BaoXiang_ADBOX	[	64	]	=	0471		BaoXiang_ADBOX_Rad	[	64	]	=	8 		BaoXiang_ADBOX_Count	[	64	]	=	1
	BaoXiang_ADBOX	[	65	]	=	0473		BaoXiang_ADBOX_Rad	[	65	]	=	8 		BaoXiang_ADBOX_Count	[	65	]	=	1
	BaoXiang_ADBOX	[	66	]	=	0474		BaoXiang_ADBOX_Rad	[	66	]	=	8 		BaoXiang_ADBOX_Count	[	66	]	=	1
	BaoXiang_ADBOX	[	67	]	=	0476		BaoXiang_ADBOX_Rad	[	67	]	=	8 		BaoXiang_ADBOX_Count	[	67	]	=	1
	BaoXiang_ADBOX	[	68	]	=	0482		BaoXiang_ADBOX_Rad	[	68	]	=	8 		BaoXiang_ADBOX_Count	[	68	]	=	1
	BaoXiang_ADBOX	[	69	]	=	0483		BaoXiang_ADBOX_Rad	[	69	]	=	8 		BaoXiang_ADBOX_Count	[	69	]	=	1
	BaoXiang_ADBOX	[	70	]	=	0486		BaoXiang_ADBOX_Rad	[	70	]	=	8 		BaoXiang_ADBOX_Count	[	70	]	=	1
	BaoXiang_ADBOX	[	71	]	=	0487		BaoXiang_ADBOX_Rad	[	71	]	=	8 		BaoXiang_ADBOX_Count	[	71	]	=	1
	BaoXiang_ADBOX	[	72	]	=	0490		BaoXiang_ADBOX_Rad	[	72	]	=	8 		BaoXiang_ADBOX_Count	[	72	]	=	1
	BaoXiang_ADBOX	[	73	]	=	0513		BaoXiang_ADBOX_Rad	[	73	]	=	8 		BaoXiang_ADBOX_Count	[	73	]	=	1
	BaoXiang_ADBOX	[	74	]	=	0514		BaoXiang_ADBOX_Rad	[	74	]	=	8 		BaoXiang_ADBOX_Count	[	74	]	=	1
	BaoXiang_ADBOX	[	75	]	=	0515		BaoXiang_ADBOX_Rad	[	75	]	=	8 		BaoXiang_ADBOX_Count	[	75	]	=	1
	BaoXiang_ADBOX	[	76	]	=	0516		BaoXiang_ADBOX_Rad	[	76	]	=	8 		BaoXiang_ADBOX_Count	[	76	]	=	1
	BaoXiang_ADBOX	[	77	]	=	0517		BaoXiang_ADBOX_Rad	[	77	]	=	8 		BaoXiang_ADBOX_Count	[	77	]	=	1
	BaoXiang_ADBOX	[	78	]	=	0536		BaoXiang_ADBOX_Rad	[	78	]	=	8 		BaoXiang_ADBOX_Count	[	78	]	=	1
	BaoXiang_ADBOX	[	79	]	=	0537		BaoXiang_ADBOX_Rad	[	79	]	=	8 		BaoXiang_ADBOX_Count	[	79	]	=	1
	BaoXiang_ADBOX	[	80	]	=	0542		BaoXiang_ADBOX_Rad	[	80	]	=	8 		BaoXiang_ADBOX_Count	[	80	]	=	1
	BaoXiang_ADBOX	[	81	]	=	0543		BaoXiang_ADBOX_Rad	[	81	]	=	8 		BaoXiang_ADBOX_Count	[	81	]	=	1
	BaoXiang_ADBOX	[	82	]	=	0544		BaoXiang_ADBOX_Rad	[	82	]	=	8 		BaoXiang_ADBOX_Count	[	82	]	=	1
	BaoXiang_ADBOX	[	83	]	=	0546		BaoXiang_ADBOX_Rad	[	83	]	=	8 		BaoXiang_ADBOX_Count	[	83	]	=	1
	BaoXiang_ADBOX	[	84	]	=	0549		BaoXiang_ADBOX_Rad	[	84	]	=	8 		BaoXiang_ADBOX_Count	[	84	]	=	1
	BaoXiang_ADBOX	[	85	]	=	0550		BaoXiang_ADBOX_Rad	[	85	]	=	8 		BaoXiang_ADBOX_Count	[	85	]	=	1
	BaoXiang_ADBOX	[	86	]	=	0557		BaoXiang_ADBOX_Rad	[	86	]	=	8 		BaoXiang_ADBOX_Count	[	86	]	=	1
	BaoXiang_ADBOX	[	87	]	=	0562		BaoXiang_ADBOX_Rad	[	87	]	=	8 		BaoXiang_ADBOX_Count	[	87	]	=	1
	BaoXiang_ADBOX	[	88	]	=	0565		BaoXiang_ADBOX_Rad	[	88	]	=	8 		BaoXiang_ADBOX_Count	[	88	]	=	1
	BaoXiang_ADBOX	[	89	]	=	0566		BaoXiang_ADBOX_Rad	[	89	]	=	8 		BaoXiang_ADBOX_Count	[	89	]	=	1
	BaoXiang_ADBOX	[	90	]	=	0568		BaoXiang_ADBOX_Rad	[	90	]	=	8 		BaoXiang_ADBOX_Count	[	90	]	=	1
	BaoXiang_ADBOX	[	91	]	=	0649		BaoXiang_ADBOX_Rad	[	91	]	=	8 		BaoXiang_ADBOX_Count	[	91	]	=	1
	BaoXiang_ADBOX	[	92	]	=	0650		BaoXiang_ADBOX_Rad	[	92	]	=	8 		BaoXiang_ADBOX_Count	[	92	]	=	1
	BaoXiang_ADBOX	[	93	]	=	0652		BaoXiang_ADBOX_Rad	[	93	]	=	8 		BaoXiang_ADBOX_Count	[	93	]	=	1
	BaoXiang_ADBOX	[	94	]	=	0658		BaoXiang_ADBOX_Rad	[	94	]	=	8 		BaoXiang_ADBOX_Count	[	94	]	=	1
	BaoXiang_ADBOX	[	95	]	=	0659		BaoXiang_ADBOX_Rad	[	95	]	=	8 		BaoXiang_ADBOX_Count	[	95	]	=	1
	BaoXiang_ADBOX	[	96	]	=	0662		BaoXiang_ADBOX_Rad	[	96	]	=	8 		BaoXiang_ADBOX_Count	[	96	]	=	1
	BaoXiang_ADBOX	[	97	]	=	0665		BaoXiang_ADBOX_Rad	[	97	]	=	8 		BaoXiang_ADBOX_Count	[	97	]	=	1
	BaoXiang_ADBOX	[	98	]	=	0666		BaoXiang_ADBOX_Rad	[	98	]	=	8 		BaoXiang_ADBOX_Count	[	98	]	=	1
	BaoXiang_ADBOX	[	99	]	=	0689		BaoXiang_ADBOX_Rad	[	99	]	=	7 		BaoXiang_ADBOX_Count	[	99	]	=	1
	BaoXiang_ADBOX	[	100	]	=	0690		BaoXiang_ADBOX_Rad	[	100	]	=	7 		BaoXiang_ADBOX_Count	[	100	]	=	1
	BaoXiang_ADBOX	[	101	]	=	0691		BaoXiang_ADBOX_Rad	[	101	]	=	7 		BaoXiang_ADBOX_Count	[	101	]	=	1
	BaoXiang_ADBOX	[	102	]	=	0692		BaoXiang_ADBOX_Rad	[	102	]	=	7 		BaoXiang_ADBOX_Count	[	102	]	=	1
	BaoXiang_ADBOX	[	103	]	=	0693		BaoXiang_ADBOX_Rad	[	103	]	=	7 		BaoXiang_ADBOX_Count	[	103	]	=	1
	BaoXiang_ADBOX	[	104	]	=	0702		BaoXiang_ADBOX_Rad	[	104	]	=	7 		BaoXiang_ADBOX_Count	[	104	]	=	1
	BaoXiang_ADBOX	[	105	]	=	0704		BaoXiang_ADBOX_Rad	[	105	]	=	7 		BaoXiang_ADBOX_Count	[	105	]	=	1
	BaoXiang_ADBOX	[	106	]	=	0705		BaoXiang_ADBOX_Rad	[	106	]	=	7 		BaoXiang_ADBOX_Count	[	106	]	=	1
	BaoXiang_ADBOX	[	107	]	=	0706		BaoXiang_ADBOX_Rad	[	107	]	=	7 		BaoXiang_ADBOX_Count	[	107	]	=	1
	BaoXiang_ADBOX	[	108	]	=	0712		BaoXiang_ADBOX_Rad	[	108	]	=	7 		BaoXiang_ADBOX_Count	[	108	]	=	1
	BaoXiang_ADBOX	[	109	]	=	0713		BaoXiang_ADBOX_Rad	[	109	]	=	7 		BaoXiang_ADBOX_Count	[	109	]	=	1
	BaoXiang_ADBOX	[	110	]	=	0718		BaoXiang_ADBOX_Rad	[	110	]	=	7 		BaoXiang_ADBOX_Count	[	110	]	=	1
	BaoXiang_ADBOX	[	111	]	=	0719		BaoXiang_ADBOX_Rad	[	111	]	=	7 		BaoXiang_ADBOX_Count	[	111	]	=	1
	BaoXiang_ADBOX	[	112	]	=	0720		BaoXiang_ADBOX_Rad	[	112	]	=	7 		BaoXiang_ADBOX_Count	[	112	]	=	1
	BaoXiang_ADBOX	[	113	]	=	0722		BaoXiang_ADBOX_Rad	[	113	]	=	7 		BaoXiang_ADBOX_Count	[	113	]	=	1
	BaoXiang_ADBOX	[	114	]	=	0725		BaoXiang_ADBOX_Rad	[	114	]	=	7 		BaoXiang_ADBOX_Count	[	114	]	=	1
	BaoXiang_ADBOX	[	115	]	=	0726		BaoXiang_ADBOX_Rad	[	115	]	=	7 		BaoXiang_ADBOX_Count	[	115	]	=	1
	BaoXiang_ADBOX	[	116	]	=	0733		BaoXiang_ADBOX_Rad	[	116	]	=	7 		BaoXiang_ADBOX_Count	[	116	]	=	1
	BaoXiang_ADBOX	[	117	]	=	0738		BaoXiang_ADBOX_Rad	[	117	]	=	7 		BaoXiang_ADBOX_Count	[	117	]	=	1
	BaoXiang_ADBOX	[	118	]	=	0741		BaoXiang_ADBOX_Rad	[	118	]	=	7 		BaoXiang_ADBOX_Count	[	118	]	=	1
	BaoXiang_ADBOX	[	119	]	=	0742		BaoXiang_ADBOX_Rad	[	119	]	=	7 		BaoXiang_ADBOX_Count	[	119	]	=	1
	BaoXiang_ADBOX	[	120	]	=	0744		BaoXiang_ADBOX_Rad	[	120	]	=	7 		BaoXiang_ADBOX_Count	[	120	]	=	1
	BaoXiang_ADBOX	[	121	]	=	0763		BaoXiang_ADBOX_Rad	[	121	]	=	7 		BaoXiang_ADBOX_Count	[	121	]	=	1
	BaoXiang_ADBOX	[	122	]	=	0770		BaoXiang_ADBOX_Rad	[	122	]	=	7 		BaoXiang_ADBOX_Count	[	122	]	=	1
	BaoXiang_ADBOX	[	123	]	=	0777		BaoXiang_ADBOX_Rad	[	123	]	=	7 		BaoXiang_ADBOX_Count	[	123	]	=	1
	BaoXiang_ADBOX	[	124	]	=	0781		BaoXiang_ADBOX_Rad	[	124	]	=	7 		BaoXiang_ADBOX_Count	[	124	]	=	1
	BaoXiang_ADBOX	[	125	]	=	0785		BaoXiang_ADBOX_Rad	[	125	]	=	7 		BaoXiang_ADBOX_Count	[	125	]	=	1
	BaoXiang_ADBOX	[	126	]	=	0789		BaoXiang_ADBOX_Rad	[	126	]	=	7 		BaoXiang_ADBOX_Count	[	126	]	=	1
	BaoXiang_ADBOX	[	127	]	=	0799		BaoXiang_ADBOX_Rad	[	127	]	=	7 		BaoXiang_ADBOX_Count	[	127	]	=	1
	BaoXiang_ADBOX	[	128	]	=	0803		BaoXiang_ADBOX_Rad	[	128	]	=	7 		BaoXiang_ADBOX_Count	[	128	]	=	1
	BaoXiang_ADBOX	[	129	]	=	3138		BaoXiang_ADBOX_Rad	[	129	]	=	737 		BaoXiang_ADBOX_Count	[	129	]	=	1
	BaoXiang_ADBOX	[	130	]	=	3139		BaoXiang_ADBOX_Rad	[	130	]	=	737 		BaoXiang_ADBOX_Count	[	130	]	=	1
	BaoXiang_ADBOX	[	131	]	=	3136		BaoXiang_ADBOX_Rad	[	131	]	=	737 		BaoXiang_ADBOX_Count	[	131	]	=	1
	BaoXiang_ADBOX	[	132	]	=	3140		BaoXiang_ADBOX_Rad	[	132	]	=	737 		BaoXiang_ADBOX_Count	[	132	]	=	1
	BaoXiang_ADBOX	[	133	]	=	3123		BaoXiang_ADBOX_Rad	[	133	]	=	737 		BaoXiang_ADBOX_Count	[	133	]	=	1
	BaoXiang_ADBOX	[	134	]	=	3125		BaoXiang_ADBOX_Rad	[	134	]	=	737 		BaoXiang_ADBOX_Count	[	134	]	=	1
	BaoXiang_ADBOX	[	135	]	=	3122		BaoXiang_ADBOX_Rad	[	135	]	=	736 		BaoXiang_ADBOX_Count	[	135	]	=	1
	BaoXiang_ADBOX	[	136	]	=	3126		BaoXiang_ADBOX_Rad	[	136	]	=	736 		BaoXiang_ADBOX_Count	[	136	]	=	1
	BaoXiang_ADBOX	[	137	]	=	3127		BaoXiang_ADBOX_Rad	[	137	]	=	736 		BaoXiang_ADBOX_Count	[	137	]	=	1
	BaoXiang_ADBOX	[	138	]	=	3138		BaoXiang_ADBOX_Rad	[	138	]	=	736 		BaoXiang_ADBOX_Count	[	138	]	=	1
	BaoXiang_ADBOX	[	139	]	=	3135		BaoXiang_ADBOX_Rad	[	139	]	=	736 		BaoXiang_ADBOX_Count	[	139	]	=	1
																																								
																																																																																																																																																																																																							
	BaoXiang_SGBOX_Qua	=	5	 			BaoXiang_SGBOX_Mxcount	=	78										
	BaoXiang_SGBOX	=	{}					BaoXiang_SGBOX_Rad	=	{}					BaoXiang_SGBOX_Count	=	{}			
	BaoXiang_SGBOX	[	1	]	=	3909		BaoXiang_SGBOX_Rad	[	1	]	=	60000 		BaoXiang_SGBOX_Count	[	1	]	=	1
	BaoXiang_SGBOX	[	2	]	=	3345		BaoXiang_SGBOX_Rad	[	2	]	=	10000 		BaoXiang_SGBOX_Count	[	2	]	=	1
	BaoXiang_SGBOX	[	3	]	=	3346		BaoXiang_SGBOX_Rad	[	3	]	=	10000 		BaoXiang_SGBOX_Count	[	3	]	=	1
	BaoXiang_SGBOX	[	4	]	=	3347		BaoXiang_SGBOX_Rad	[	4	]	=	10000 		BaoXiang_SGBOX_Count	[	4	]	=	1
	BaoXiang_SGBOX	[	5	]	=	0006		BaoXiang_SGBOX_Rad	[	5	]	=	333 		BaoXiang_SGBOX_Count	[	5	]	=	1
	BaoXiang_SGBOX	[	6	]	=	0017		BaoXiang_SGBOX_Rad	[	6	]	=	333 		BaoXiang_SGBOX_Count	[	6	]	=	1
	BaoXiang_SGBOX	[	7	]	=	0041		BaoXiang_SGBOX_Rad	[	7	]	=	333 		BaoXiang_SGBOX_Count	[	7	]	=	1
	BaoXiang_SGBOX	[	8	]	=	0078		BaoXiang_SGBOX_Rad	[	8	]	=	333 		BaoXiang_SGBOX_Count	[	8	]	=	1
	BaoXiang_SGBOX	[	9	]	=	0230		BaoXiang_SGBOX_Rad	[	9	]	=	333 		BaoXiang_SGBOX_Count	[	9	]	=	1
	BaoXiang_SGBOX	[	10	]	=	0304		BaoXiang_SGBOX_Rad	[	10	]	=	333 		BaoXiang_SGBOX_Count	[	10	]	=	1
	BaoXiang_SGBOX	[	11	]	=	0317		BaoXiang_SGBOX_Rad	[	11	]	=	333 		BaoXiang_SGBOX_Count	[	11	]	=	1
	BaoXiang_SGBOX	[	12	]	=	0344		BaoXiang_SGBOX_Rad	[	12	]	=	333 		BaoXiang_SGBOX_Count	[	12	]	=	1
	BaoXiang_SGBOX	[	13	]	=	0358		BaoXiang_SGBOX_Rad	[	13	]	=	333 		BaoXiang_SGBOX_Count	[	13	]	=	1
	BaoXiang_SGBOX	[	14	]	=	0364		BaoXiang_SGBOX_Rad	[	14	]	=	333 		BaoXiang_SGBOX_Count	[	14	]	=	1
	BaoXiang_SGBOX	[	15	]	=	0377		BaoXiang_SGBOX_Rad	[	15	]	=	333 		BaoXiang_SGBOX_Count	[	15	]	=	1
	BaoXiang_SGBOX	[	16	]	=	0393		BaoXiang_SGBOX_Rad	[	16	]	=	333 		BaoXiang_SGBOX_Count	[	16	]	=	1
	BaoXiang_SGBOX	[	17	]	=	0394		BaoXiang_SGBOX_Rad	[	17	]	=	333 		BaoXiang_SGBOX_Count	[	17	]	=	1
	BaoXiang_SGBOX	[	18	]	=	0480		BaoXiang_SGBOX_Rad	[	18	]	=	333 		BaoXiang_SGBOX_Count	[	18	]	=	1
	BaoXiang_SGBOX	[	19	]	=	0493		BaoXiang_SGBOX_Rad	[	19	]	=	333 		BaoXiang_SGBOX_Count	[	19	]	=	1
	BaoXiang_SGBOX	[	20	]	=	0520		BaoXiang_SGBOX_Rad	[	20	]	=	333 		BaoXiang_SGBOX_Count	[	20	]	=	1
	BaoXiang_SGBOX	[	21	]	=	0534		BaoXiang_SGBOX_Rad	[	21	]	=	333 		BaoXiang_SGBOX_Count	[	21	]	=	1
	BaoXiang_SGBOX	[	22	]	=	0540		BaoXiang_SGBOX_Rad	[	22	]	=	333 		BaoXiang_SGBOX_Count	[	22	]	=	1
	BaoXiang_SGBOX	[	23	]	=	0553		BaoXiang_SGBOX_Rad	[	23	]	=	333 		BaoXiang_SGBOX_Count	[	23	]	=	1
	BaoXiang_SGBOX	[	24	]	=	0569		BaoXiang_SGBOX_Rad	[	24	]	=	333 		BaoXiang_SGBOX_Count	[	24	]	=	1
	BaoXiang_SGBOX	[	25	]	=	0570		BaoXiang_SGBOX_Rad	[	25	]	=	333 		BaoXiang_SGBOX_Count	[	25	]	=	1
	BaoXiang_SGBOX	[	26	]	=	0656		BaoXiang_SGBOX_Rad	[	26	]	=	333 		BaoXiang_SGBOX_Count	[	26	]	=	1
	BaoXiang_SGBOX	[	27	]	=	0669		BaoXiang_SGBOX_Rad	[	27	]	=	333 		BaoXiang_SGBOX_Count	[	27	]	=	1
	BaoXiang_SGBOX	[	28	]	=	0696		BaoXiang_SGBOX_Rad	[	28	]	=	333 		BaoXiang_SGBOX_Count	[	28	]	=	1
	BaoXiang_SGBOX	[	29	]	=	0710		BaoXiang_SGBOX_Rad	[	29	]	=	333 		BaoXiang_SGBOX_Count	[	29	]	=	1
	BaoXiang_SGBOX	[	30	]	=	0716		BaoXiang_SGBOX_Rad	[	30	]	=	333 		BaoXiang_SGBOX_Count	[	30	]	=	1
	BaoXiang_SGBOX	[	31	]	=	0729		BaoXiang_SGBOX_Rad	[	31	]	=	333 		BaoXiang_SGBOX_Count	[	31	]	=	1
	BaoXiang_SGBOX	[	32	]	=	0745		BaoXiang_SGBOX_Rad	[	32	]	=	333 		BaoXiang_SGBOX_Count	[	32	]	=	1
	BaoXiang_SGBOX	[	33	]	=	0746		BaoXiang_SGBOX_Rad	[	33	]	=	334 		BaoXiang_SGBOX_Count	[	33	]	=	1
	BaoXiang_SGBOX	[	34	]	=	3828		BaoXiang_SGBOX_Rad	[	34	]	=	625 		BaoXiang_SGBOX_Count	[	34	]	=	1
	BaoXiang_SGBOX	[	35	]	=	3829		BaoXiang_SGBOX_Rad	[	35	]	=	625 		BaoXiang_SGBOX_Count	[	35	]	=	1
	BaoXiang_SGBOX	[	36	]	=	3830		BaoXiang_SGBOX_Rad	[	36	]	=	625 		BaoXiang_SGBOX_Count	[	36	]	=	1
	BaoXiang_SGBOX	[	37	]	=	3831		BaoXiang_SGBOX_Rad	[	37	]	=	625 		BaoXiang_SGBOX_Count	[	37	]	=	1
	BaoXiang_SGBOX	[	38	]	=	3832		BaoXiang_SGBOX_Rad	[	38	]	=	625 		BaoXiang_SGBOX_Count	[	38	]	=	1
	BaoXiang_SGBOX	[	39	]	=	3833		BaoXiang_SGBOX_Rad	[	39	]	=	625 		BaoXiang_SGBOX_Count	[	39	]	=	1
	BaoXiang_SGBOX	[	40	]	=	3834		BaoXiang_SGBOX_Rad	[	40	]	=	625 		BaoXiang_SGBOX_Count	[	40	]	=	1
	BaoXiang_SGBOX	[	41	]	=	3835		BaoXiang_SGBOX_Rad	[	41	]	=	625 		BaoXiang_SGBOX_Count	[	41	]	=	1
	BaoXiang_SGBOX	[	42	]	=	3836		BaoXiang_SGBOX_Rad	[	42	]	=	625 		BaoXiang_SGBOX_Count	[	42	]	=	1
	BaoXiang_SGBOX	[	43	]	=	3837		BaoXiang_SGBOX_Rad	[	43	]	=	625 		BaoXiang_SGBOX_Count	[	43	]	=	1
	BaoXiang_SGBOX	[	44	]	=	3838		BaoXiang_SGBOX_Rad	[	44	]	=	625 		BaoXiang_SGBOX_Count	[	44	]	=	1
	BaoXiang_SGBOX	[	45	]	=	3839		BaoXiang_SGBOX_Rad	[	45	]	=	625 		BaoXiang_SGBOX_Count	[	45	]	=	1
	BaoXiang_SGBOX	[	46	]	=	3840		BaoXiang_SGBOX_Rad	[	46	]	=	625 		BaoXiang_SGBOX_Count	[	46	]	=	1
	BaoXiang_SGBOX	[	47	]	=	3841		BaoXiang_SGBOX_Rad	[	47	]	=	625 		BaoXiang_SGBOX_Count	[	47	]	=	1
	BaoXiang_SGBOX	[	48	]	=	3842		BaoXiang_SGBOX_Rad	[	48	]	=	625 		BaoXiang_SGBOX_Count	[	48	]	=	1
	BaoXiang_SGBOX	[	49	]	=	3843		BaoXiang_SGBOX_Rad	[	49	]	=	625 		BaoXiang_SGBOX_Count	[	49	]	=	1
	BaoXiang_SGBOX	[	50	]	=	0879		BaoXiang_SGBOX_Rad	[	50	]	=	2500 		BaoXiang_SGBOX_Count	[	50	]	=	1
	BaoXiang_SGBOX	[	51	]	=	0880		BaoXiang_SGBOX_Rad	[	51	]	=	2500 		BaoXiang_SGBOX_Count	[	51	]	=	1
	BaoXiang_SGBOX	[	52	]	=	0881		BaoXiang_SGBOX_Rad	[	52	]	=	2500 		BaoXiang_SGBOX_Count	[	52	]	=	1
	BaoXiang_SGBOX	[	53	]	=	0882		BaoXiang_SGBOX_Rad	[	53	]	=	2500 		BaoXiang_SGBOX_Count	[	53	]	=	1
	BaoXiang_SGBOX	[	54	]	=	0883		BaoXiang_SGBOX_Rad	[	54	]	=	2500 		BaoXiang_SGBOX_Count	[	54	]	=	1
	BaoXiang_SGBOX	[	55	]	=	0884		BaoXiang_SGBOX_Rad	[	55	]	=	2500 		BaoXiang_SGBOX_Count	[	55	]	=	1
	BaoXiang_SGBOX	[	56	]	=	0885		BaoXiang_SGBOX_Rad	[	56	]	=	2500 		BaoXiang_SGBOX_Count	[	56	]	=	1
	BaoXiang_SGBOX	[	57	]	=	0887		BaoXiang_SGBOX_Rad	[	57	]	=	2500 		BaoXiang_SGBOX_Count	[	57	]	=	1
	BaoXiang_SGBOX	[	58	]	=	0007		BaoXiang_SGBOX_Rad	[	58	]	=	2 		BaoXiang_SGBOX_Count	[	58	]	=	1
	BaoXiang_SGBOX	[	59	]	=	0042		BaoXiang_SGBOX_Rad	[	59	]	=	1 		BaoXiang_SGBOX_Count	[	59	]	=	1
	BaoXiang_SGBOX	[	60	]	=	0018		BaoXiang_SGBOX_Rad	[	60	]	=	1 		BaoXiang_SGBOX_Count	[	60	]	=	1
	BaoXiang_SGBOX	[	61	]	=	1375		BaoXiang_SGBOX_Rad	[	61	]	=	1 		BaoXiang_SGBOX_Count	[	61	]	=	1
	BaoXiang_SGBOX	[	62	]	=	1384		BaoXiang_SGBOX_Rad	[	62	]	=	1 		BaoXiang_SGBOX_Count	[	62	]	=	1
	BaoXiang_SGBOX	[	63	]	=	1394		BaoXiang_SGBOX_Rad	[	63	]	=	1 		BaoXiang_SGBOX_Count	[	63	]	=	1
	BaoXiang_SGBOX	[	64	]	=	1411		BaoXiang_SGBOX_Rad	[	64	]	=	1 		BaoXiang_SGBOX_Count	[	64	]	=	1
	BaoXiang_SGBOX	[	65	]	=	1421		BaoXiang_SGBOX_Rad	[	65	]	=	1 		BaoXiang_SGBOX_Count	[	65	]	=	1
	BaoXiang_SGBOX	[	66	]	=	4198		BaoXiang_SGBOX_Rad	[	66	]	=	1 		BaoXiang_SGBOX_Count	[	66	]	=	1
	BaoXiang_SGBOX	[	67	]	=	4200		BaoXiang_SGBOX_Rad	[	67	]	=	1 		BaoXiang_SGBOX_Count	[	67	]	=	1
	BaoXiang_SGBOX	[	68	]	=	4202		BaoXiang_SGBOX_Rad	[	68	]	=	1 		BaoXiang_SGBOX_Count	[	68	]	=	1
	BaoXiang_SGBOX	[	69	]	=	4204		BaoXiang_SGBOX_Rad	[	69	]	=	1 		BaoXiang_SGBOX_Count	[	69	]	=	1
	BaoXiang_SGBOX	[	70	]	=	4206		BaoXiang_SGBOX_Rad	[	70	]	=	1 		BaoXiang_SGBOX_Count	[	70	]	=	1
	BaoXiang_SGBOX	[	71	]	=	4208		BaoXiang_SGBOX_Rad	[	71	]	=	1 		BaoXiang_SGBOX_Count	[	71	]	=	1
	BaoXiang_SGBOX	[	72	]	=	3139		BaoXiang_SGBOX_Rad	[	72	]	=	12712 		BaoXiang_SGBOX_Count	[	72	]	=	1
	BaoXiang_SGBOX	[	73	]	=	3140		BaoXiang_SGBOX_Rad	[	73	]	=	12713 		BaoXiang_SGBOX_Count	[	73	]	=	1
	BaoXiang_SGBOX	[	74	]	=	3138		BaoXiang_SGBOX_Rad	[	74	]	=	12711 		BaoXiang_SGBOX_Count	[	74	]	=	1
	BaoXiang_SGBOX	[	75	]	=	3127		BaoXiang_SGBOX_Rad	[	75	]	=	12711 		BaoXiang_SGBOX_Count	[	75	]	=	1
	BaoXiang_SGBOX	[	76	]	=	3123		BaoXiang_SGBOX_Rad	[	76	]	=	12711 		BaoXiang_SGBOX_Count	[	76	]	=	1
	BaoXiang_SGBOX	[	77	]	=	3128		BaoXiang_SGBOX_Rad	[	77	]	=	12711 		BaoXiang_SGBOX_Count	[	77	]	=	1
	BaoXiang_SGBOX	[	78	]	=	3125		BaoXiang_SGBOX_Rad	[	78	]	=	12711 		BaoXiang_SGBOX_Count	[	78	]	=	1
																				

	BaoXiang_CBTBOX_Qua	=	5	 			BaoXiang_CBTBOX_Mxcount	=	222										
	BaoXiang_CBTBOX	=	{}					BaoXiang_CBTBOX_Rad	=	{}					BaoXiang_CBTBOX_Count	=	{}			
	BaoXiang_CBTBOX	[	1	]	=	0396		BaoXiang_CBTBOX_Rad	[	1	]	=	1 		BaoXiang_CBTBOX_Count	[	1	]	=	1
	BaoXiang_CBTBOX	[	2	]	=	0398		BaoXiang_CBTBOX_Rad	[	2	]	=	1 		BaoXiang_CBTBOX_Count	[	2	]	=	1
	BaoXiang_CBTBOX	[	3	]	=	0400		BaoXiang_CBTBOX_Rad	[	3	]	=	1 		BaoXiang_CBTBOX_Count	[	3	]	=	1
	BaoXiang_CBTBOX	[	4	]	=	0402		BaoXiang_CBTBOX_Rad	[	4	]	=	1 		BaoXiang_CBTBOX_Count	[	4	]	=	1
	BaoXiang_CBTBOX	[	5	]	=	0404		BaoXiang_CBTBOX_Rad	[	5	]	=	1 		BaoXiang_CBTBOX_Count	[	5	]	=	1
	BaoXiang_CBTBOX	[	6	]	=	0406		BaoXiang_CBTBOX_Rad	[	6	]	=	1 		BaoXiang_CBTBOX_Count	[	6	]	=	1
	BaoXiang_CBTBOX	[	7	]	=	0408		BaoXiang_CBTBOX_Rad	[	7	]	=	1 		BaoXiang_CBTBOX_Count	[	7	]	=	1
	BaoXiang_CBTBOX	[	8	]	=	0411		BaoXiang_CBTBOX_Rad	[	8	]	=	1 		BaoXiang_CBTBOX_Count	[	8	]	=	1
	BaoXiang_CBTBOX	[	9	]	=	0291		BaoXiang_CBTBOX_Rad	[	9	]	=	5 		BaoXiang_CBTBOX_Count	[	9	]	=	1
	BaoXiang_CBTBOX	[	10	]	=	0293		BaoXiang_CBTBOX_Rad	[	10	]	=	5 		BaoXiang_CBTBOX_Count	[	10	]	=	1
	BaoXiang_CBTBOX	[	11	]	=	0295		BaoXiang_CBTBOX_Rad	[	11	]	=	5 		BaoXiang_CBTBOX_Count	[	11	]	=	1
	BaoXiang_CBTBOX	[	12	]	=	0297		BaoXiang_CBTBOX_Rad	[	12	]	=	5 		BaoXiang_CBTBOX_Count	[	12	]	=	1
	BaoXiang_CBTBOX	[	13	]	=	0298		BaoXiang_CBTBOX_Rad	[	13	]	=	5 		BaoXiang_CBTBOX_Count	[	13	]	=	1
	BaoXiang_CBTBOX	[	14	]	=	0300		BaoXiang_CBTBOX_Rad	[	14	]	=	5 		BaoXiang_CBTBOX_Count	[	14	]	=	1
	BaoXiang_CBTBOX	[	15	]	=	0306		BaoXiang_CBTBOX_Rad	[	15	]	=	5 		BaoXiang_CBTBOX_Count	[	15	]	=	1
	BaoXiang_CBTBOX	[	16	]	=	0307		BaoXiang_CBTBOX_Rad	[	16	]	=	5 		BaoXiang_CBTBOX_Count	[	16	]	=	1
	BaoXiang_CBTBOX	[	17	]	=	0311		BaoXiang_CBTBOX_Rad	[	17	]	=	5 		BaoXiang_CBTBOX_Count	[	17	]	=	1
	BaoXiang_CBTBOX	[	18	]	=	0313		BaoXiang_CBTBOX_Rad	[	18	]	=	5 		BaoXiang_CBTBOX_Count	[	18	]	=	1
	BaoXiang_CBTBOX	[	19	]	=	0314		BaoXiang_CBTBOX_Rad	[	19	]	=	5 		BaoXiang_CBTBOX_Count	[	19	]	=	1
	BaoXiang_CBTBOX	[	20	]	=	0336		BaoXiang_CBTBOX_Rad	[	20	]	=	5 		BaoXiang_CBTBOX_Count	[	20	]	=	1
	BaoXiang_CBTBOX	[	21	]	=	0337		BaoXiang_CBTBOX_Rad	[	21	]	=	5 		BaoXiang_CBTBOX_Count	[	21	]	=	1
	BaoXiang_CBTBOX	[	22	]	=	0338		BaoXiang_CBTBOX_Rad	[	22	]	=	5 		BaoXiang_CBTBOX_Count	[	22	]	=	1
	BaoXiang_CBTBOX	[	23	]	=	0339		BaoXiang_CBTBOX_Rad	[	23	]	=	5 		BaoXiang_CBTBOX_Count	[	23	]	=	1
	BaoXiang_CBTBOX	[	24	]	=	0340		BaoXiang_CBTBOX_Rad	[	24	]	=	5 		BaoXiang_CBTBOX_Count	[	24	]	=	1
	BaoXiang_CBTBOX	[	25	]	=	0341		BaoXiang_CBTBOX_Rad	[	25	]	=	5 		BaoXiang_CBTBOX_Count	[	25	]	=	1
	BaoXiang_CBTBOX	[	26	]	=	0352		BaoXiang_CBTBOX_Rad	[	26	]	=	5 		BaoXiang_CBTBOX_Count	[	26	]	=	1
	BaoXiang_CBTBOX	[	27	]	=	0353		BaoXiang_CBTBOX_Rad	[	27	]	=	5 		BaoXiang_CBTBOX_Count	[	27	]	=	1
	BaoXiang_CBTBOX	[	28	]	=	0354		BaoXiang_CBTBOX_Rad	[	28	]	=	5 		BaoXiang_CBTBOX_Count	[	28	]	=	1
	BaoXiang_CBTBOX	[	29	]	=	0350		BaoXiang_CBTBOX_Rad	[	29	]	=	5 		BaoXiang_CBTBOX_Count	[	29	]	=	1
	BaoXiang_CBTBOX	[	30	]	=	0360		BaoXiang_CBTBOX_Rad	[	30	]	=	5 		BaoXiang_CBTBOX_Count	[	30	]	=	1
	BaoXiang_CBTBOX	[	31	]	=	0361		BaoXiang_CBTBOX_Rad	[	31	]	=	5 		BaoXiang_CBTBOX_Count	[	31	]	=	1
	BaoXiang_CBTBOX	[	32	]	=	0362		BaoXiang_CBTBOX_Rad	[	32	]	=	5 		BaoXiang_CBTBOX_Count	[	32	]	=	1
	BaoXiang_CBTBOX	[	33	]	=	0467		BaoXiang_CBTBOX_Rad	[	33	]	=	5 		BaoXiang_CBTBOX_Count	[	33	]	=	1
	BaoXiang_CBTBOX	[	34	]	=	0469		BaoXiang_CBTBOX_Rad	[	34	]	=	5 		BaoXiang_CBTBOX_Count	[	34	]	=	1
	BaoXiang_CBTBOX	[	35	]	=	0471		BaoXiang_CBTBOX_Rad	[	35	]	=	5 		BaoXiang_CBTBOX_Count	[	35	]	=	1
	BaoXiang_CBTBOX	[	36	]	=	0473		BaoXiang_CBTBOX_Rad	[	36	]	=	5 		BaoXiang_CBTBOX_Count	[	36	]	=	1
	BaoXiang_CBTBOX	[	37	]	=	0474		BaoXiang_CBTBOX_Rad	[	37	]	=	5 		BaoXiang_CBTBOX_Count	[	37	]	=	1
	BaoXiang_CBTBOX	[	38	]	=	0476		BaoXiang_CBTBOX_Rad	[	38	]	=	5 		BaoXiang_CBTBOX_Count	[	38	]	=	1
	BaoXiang_CBTBOX	[	39	]	=	0482		BaoXiang_CBTBOX_Rad	[	39	]	=	5 		BaoXiang_CBTBOX_Count	[	39	]	=	1
	BaoXiang_CBTBOX	[	40	]	=	0483		BaoXiang_CBTBOX_Rad	[	40	]	=	5 		BaoXiang_CBTBOX_Count	[	40	]	=	1
	BaoXiang_CBTBOX	[	41	]	=	0486		BaoXiang_CBTBOX_Rad	[	41	]	=	5 		BaoXiang_CBTBOX_Count	[	41	]	=	1
	BaoXiang_CBTBOX	[	42	]	=	0487		BaoXiang_CBTBOX_Rad	[	42	]	=	5 		BaoXiang_CBTBOX_Count	[	42	]	=	1
	BaoXiang_CBTBOX	[	43	]	=	0490		BaoXiang_CBTBOX_Rad	[	43	]	=	5 		BaoXiang_CBTBOX_Count	[	43	]	=	1
	BaoXiang_CBTBOX	[	44	]	=	0513		BaoXiang_CBTBOX_Rad	[	44	]	=	5 		BaoXiang_CBTBOX_Count	[	44	]	=	1
	BaoXiang_CBTBOX	[	45	]	=	0514		BaoXiang_CBTBOX_Rad	[	45	]	=	5 		BaoXiang_CBTBOX_Count	[	45	]	=	1
	BaoXiang_CBTBOX	[	46	]	=	0515		BaoXiang_CBTBOX_Rad	[	46	]	=	5 		BaoXiang_CBTBOX_Count	[	46	]	=	1
	BaoXiang_CBTBOX	[	47	]	=	0516		BaoXiang_CBTBOX_Rad	[	47	]	=	5 		BaoXiang_CBTBOX_Count	[	47	]	=	1
	BaoXiang_CBTBOX	[	48	]	=	0517		BaoXiang_CBTBOX_Rad	[	48	]	=	5 		BaoXiang_CBTBOX_Count	[	48	]	=	1
	BaoXiang_CBTBOX	[	49	]	=	0536		BaoXiang_CBTBOX_Rad	[	49	]	=	5 		BaoXiang_CBTBOX_Count	[	49	]	=	1
	BaoXiang_CBTBOX	[	50	]	=	0537		BaoXiang_CBTBOX_Rad	[	50	]	=	5 		BaoXiang_CBTBOX_Count	[	50	]	=	1
	BaoXiang_CBTBOX	[	51	]	=	0542		BaoXiang_CBTBOX_Rad	[	51	]	=	5 		BaoXiang_CBTBOX_Count	[	51	]	=	1
	BaoXiang_CBTBOX	[	52	]	=	0543		BaoXiang_CBTBOX_Rad	[	52	]	=	5 		BaoXiang_CBTBOX_Count	[	52	]	=	1
	BaoXiang_CBTBOX	[	53	]	=	0544		BaoXiang_CBTBOX_Rad	[	53	]	=	5 		BaoXiang_CBTBOX_Count	[	53	]	=	1
	BaoXiang_CBTBOX	[	54	]	=	0546		BaoXiang_CBTBOX_Rad	[	54	]	=	5 		BaoXiang_CBTBOX_Count	[	54	]	=	1
	BaoXiang_CBTBOX	[	55	]	=	0549		BaoXiang_CBTBOX_Rad	[	55	]	=	5 		BaoXiang_CBTBOX_Count	[	55	]	=	1
	BaoXiang_CBTBOX	[	56	]	=	0550		BaoXiang_CBTBOX_Rad	[	56	]	=	5 		BaoXiang_CBTBOX_Count	[	56	]	=	1
	BaoXiang_CBTBOX	[	57	]	=	0557		BaoXiang_CBTBOX_Rad	[	57	]	=	5 		BaoXiang_CBTBOX_Count	[	57	]	=	1
	BaoXiang_CBTBOX	[	58	]	=	0562		BaoXiang_CBTBOX_Rad	[	58	]	=	5 		BaoXiang_CBTBOX_Count	[	58	]	=	1
	BaoXiang_CBTBOX	[	59	]	=	0565		BaoXiang_CBTBOX_Rad	[	59	]	=	5 		BaoXiang_CBTBOX_Count	[	59	]	=	1
	BaoXiang_CBTBOX	[	60	]	=	0566		BaoXiang_CBTBOX_Rad	[	60	]	=	5 		BaoXiang_CBTBOX_Count	[	60	]	=	1
	BaoXiang_CBTBOX	[	61	]	=	0568		BaoXiang_CBTBOX_Rad	[	61	]	=	5 		BaoXiang_CBTBOX_Count	[	61	]	=	1
	BaoXiang_CBTBOX	[	62	]	=	0649		BaoXiang_CBTBOX_Rad	[	62	]	=	5 		BaoXiang_CBTBOX_Count	[	62	]	=	1
	BaoXiang_CBTBOX	[	63	]	=	0650		BaoXiang_CBTBOX_Rad	[	63	]	=	5 		BaoXiang_CBTBOX_Count	[	63	]	=	1
	BaoXiang_CBTBOX	[	64	]	=	0652		BaoXiang_CBTBOX_Rad	[	64	]	=	5 		BaoXiang_CBTBOX_Count	[	64	]	=	1
	BaoXiang_CBTBOX	[	65	]	=	0658		BaoXiang_CBTBOX_Rad	[	65	]	=	5 		BaoXiang_CBTBOX_Count	[	65	]	=	1
	BaoXiang_CBTBOX	[	66	]	=	0659		BaoXiang_CBTBOX_Rad	[	66	]	=	5 		BaoXiang_CBTBOX_Count	[	66	]	=	1
	BaoXiang_CBTBOX	[	67	]	=	0662		BaoXiang_CBTBOX_Rad	[	67	]	=	5 		BaoXiang_CBTBOX_Count	[	67	]	=	1
	BaoXiang_CBTBOX	[	68	]	=	0665		BaoXiang_CBTBOX_Rad	[	68	]	=	5 		BaoXiang_CBTBOX_Count	[	68	]	=	1
	BaoXiang_CBTBOX	[	69	]	=	0666		BaoXiang_CBTBOX_Rad	[	69	]	=	5 		BaoXiang_CBTBOX_Count	[	69	]	=	1
	BaoXiang_CBTBOX	[	70	]	=	0689		BaoXiang_CBTBOX_Rad	[	70	]	=	5 		BaoXiang_CBTBOX_Count	[	70	]	=	1
	BaoXiang_CBTBOX	[	71	]	=	0690		BaoXiang_CBTBOX_Rad	[	71	]	=	5 		BaoXiang_CBTBOX_Count	[	71	]	=	1
	BaoXiang_CBTBOX	[	72	]	=	0691		BaoXiang_CBTBOX_Rad	[	72	]	=	5 		BaoXiang_CBTBOX_Count	[	72	]	=	1
	BaoXiang_CBTBOX	[	73	]	=	0692		BaoXiang_CBTBOX_Rad	[	73	]	=	5 		BaoXiang_CBTBOX_Count	[	73	]	=	1
	BaoXiang_CBTBOX	[	74	]	=	0693		BaoXiang_CBTBOX_Rad	[	74	]	=	5 		BaoXiang_CBTBOX_Count	[	74	]	=	1
	BaoXiang_CBTBOX	[	75	]	=	0702		BaoXiang_CBTBOX_Rad	[	75	]	=	5 		BaoXiang_CBTBOX_Count	[	75	]	=	1
	BaoXiang_CBTBOX	[	76	]	=	0704		BaoXiang_CBTBOX_Rad	[	76	]	=	5 		BaoXiang_CBTBOX_Count	[	76	]	=	1
	BaoXiang_CBTBOX	[	77	]	=	0705		BaoXiang_CBTBOX_Rad	[	77	]	=	5 		BaoXiang_CBTBOX_Count	[	77	]	=	1
	BaoXiang_CBTBOX	[	78	]	=	0706		BaoXiang_CBTBOX_Rad	[	78	]	=	5 		BaoXiang_CBTBOX_Count	[	78	]	=	1
	BaoXiang_CBTBOX	[	79	]	=	0712		BaoXiang_CBTBOX_Rad	[	79	]	=	5 		BaoXiang_CBTBOX_Count	[	79	]	=	1
	BaoXiang_CBTBOX	[	80	]	=	0713		BaoXiang_CBTBOX_Rad	[	80	]	=	5 		BaoXiang_CBTBOX_Count	[	80	]	=	1
	BaoXiang_CBTBOX	[	81	]	=	0718		BaoXiang_CBTBOX_Rad	[	81	]	=	5 		BaoXiang_CBTBOX_Count	[	81	]	=	1
	BaoXiang_CBTBOX	[	82	]	=	0719		BaoXiang_CBTBOX_Rad	[	82	]	=	5 		BaoXiang_CBTBOX_Count	[	82	]	=	1
	BaoXiang_CBTBOX	[	83	]	=	0720		BaoXiang_CBTBOX_Rad	[	83	]	=	5 		BaoXiang_CBTBOX_Count	[	83	]	=	1
	BaoXiang_CBTBOX	[	84	]	=	0722		BaoXiang_CBTBOX_Rad	[	84	]	=	5 		BaoXiang_CBTBOX_Count	[	84	]	=	1
	BaoXiang_CBTBOX	[	85	]	=	0725		BaoXiang_CBTBOX_Rad	[	85	]	=	5 		BaoXiang_CBTBOX_Count	[	85	]	=	1
	BaoXiang_CBTBOX	[	86	]	=	0726		BaoXiang_CBTBOX_Rad	[	86	]	=	5 		BaoXiang_CBTBOX_Count	[	86	]	=	1
	BaoXiang_CBTBOX	[	87	]	=	0733		BaoXiang_CBTBOX_Rad	[	87	]	=	5 		BaoXiang_CBTBOX_Count	[	87	]	=	1
	BaoXiang_CBTBOX	[	88	]	=	0738		BaoXiang_CBTBOX_Rad	[	88	]	=	5 		BaoXiang_CBTBOX_Count	[	88	]	=	1
	BaoXiang_CBTBOX	[	89	]	=	0741		BaoXiang_CBTBOX_Rad	[	89	]	=	5 		BaoXiang_CBTBOX_Count	[	89	]	=	1
	BaoXiang_CBTBOX	[	90	]	=	0742		BaoXiang_CBTBOX_Rad	[	90	]	=	5 		BaoXiang_CBTBOX_Count	[	90	]	=	1
	BaoXiang_CBTBOX	[	91	]	=	0744		BaoXiang_CBTBOX_Rad	[	91	]	=	5 		BaoXiang_CBTBOX_Count	[	91	]	=	1
	BaoXiang_CBTBOX	[	92	]	=	0763		BaoXiang_CBTBOX_Rad	[	92	]	=	5 		BaoXiang_CBTBOX_Count	[	92	]	=	1
	BaoXiang_CBTBOX	[	93	]	=	0770		BaoXiang_CBTBOX_Rad	[	93	]	=	5 		BaoXiang_CBTBOX_Count	[	93	]	=	1
	BaoXiang_CBTBOX	[	94	]	=	0777		BaoXiang_CBTBOX_Rad	[	94	]	=	5 		BaoXiang_CBTBOX_Count	[	94	]	=	1
	BaoXiang_CBTBOX	[	95	]	=	0781		BaoXiang_CBTBOX_Rad	[	95	]	=	5 		BaoXiang_CBTBOX_Count	[	95	]	=	1
	BaoXiang_CBTBOX	[	96	]	=	0785		BaoXiang_CBTBOX_Rad	[	96	]	=	5 		BaoXiang_CBTBOX_Count	[	96	]	=	1
	BaoXiang_CBTBOX	[	97	]	=	0789		BaoXiang_CBTBOX_Rad	[	97	]	=	5 		BaoXiang_CBTBOX_Count	[	97	]	=	1
	BaoXiang_CBTBOX	[	98	]	=	0799		BaoXiang_CBTBOX_Rad	[	98	]	=	5 		BaoXiang_CBTBOX_Count	[	98	]	=	1
	BaoXiang_CBTBOX	[	99	]	=	0803		BaoXiang_CBTBOX_Rad	[	99	]	=	5 		BaoXiang_CBTBOX_Count	[	99	]	=	1
	BaoXiang_CBTBOX	[	100	]	=	0230		BaoXiang_CBTBOX_Rad	[	100	]	=	5 		BaoXiang_CBTBOX_Count	[	100	]	=	1
	BaoXiang_CBTBOX	[	101	]	=	0304		BaoXiang_CBTBOX_Rad	[	101	]	=	5 		BaoXiang_CBTBOX_Count	[	101	]	=	1
	BaoXiang_CBTBOX	[	102	]	=	0317		BaoXiang_CBTBOX_Rad	[	102	]	=	5 		BaoXiang_CBTBOX_Count	[	102	]	=	1
	BaoXiang_CBTBOX	[	103	]	=	0344		BaoXiang_CBTBOX_Rad	[	103	]	=	5 		BaoXiang_CBTBOX_Count	[	103	]	=	1
	BaoXiang_CBTBOX	[	104	]	=	0358		BaoXiang_CBTBOX_Rad	[	104	]	=	5 		BaoXiang_CBTBOX_Count	[	104	]	=	1
	BaoXiang_CBTBOX	[	105	]	=	0364		BaoXiang_CBTBOX_Rad	[	105	]	=	5 		BaoXiang_CBTBOX_Count	[	105	]	=	1
	BaoXiang_CBTBOX	[	106	]	=	0377		BaoXiang_CBTBOX_Rad	[	106	]	=	5 		BaoXiang_CBTBOX_Count	[	106	]	=	1
	BaoXiang_CBTBOX	[	107	]	=	0393		BaoXiang_CBTBOX_Rad	[	107	]	=	5 		BaoXiang_CBTBOX_Count	[	107	]	=	1
	BaoXiang_CBTBOX	[	108	]	=	0394		BaoXiang_CBTBOX_Rad	[	108	]	=	5 		BaoXiang_CBTBOX_Count	[	108	]	=	1
	BaoXiang_CBTBOX	[	109	]	=	0480		BaoXiang_CBTBOX_Rad	[	109	]	=	5 		BaoXiang_CBTBOX_Count	[	109	]	=	1
	BaoXiang_CBTBOX	[	110	]	=	0493		BaoXiang_CBTBOX_Rad	[	110	]	=	5 		BaoXiang_CBTBOX_Count	[	110	]	=	1
	BaoXiang_CBTBOX	[	111	]	=	0520		BaoXiang_CBTBOX_Rad	[	111	]	=	5 		BaoXiang_CBTBOX_Count	[	111	]	=	1
	BaoXiang_CBTBOX	[	112	]	=	0534		BaoXiang_CBTBOX_Rad	[	112	]	=	5 		BaoXiang_CBTBOX_Count	[	112	]	=	1
	BaoXiang_CBTBOX	[	113	]	=	0540		BaoXiang_CBTBOX_Rad	[	113	]	=	5 		BaoXiang_CBTBOX_Count	[	113	]	=	1
	BaoXiang_CBTBOX	[	114	]	=	0553		BaoXiang_CBTBOX_Rad	[	114	]	=	5 		BaoXiang_CBTBOX_Count	[	114	]	=	1
	BaoXiang_CBTBOX	[	115	]	=	0569		BaoXiang_CBTBOX_Rad	[	115	]	=	5 		BaoXiang_CBTBOX_Count	[	115	]	=	1
	BaoXiang_CBTBOX	[	116	]	=	0570		BaoXiang_CBTBOX_Rad	[	116	]	=	5 		BaoXiang_CBTBOX_Count	[	116	]	=	1
	BaoXiang_CBTBOX	[	117	]	=	0656		BaoXiang_CBTBOX_Rad	[	117	]	=	5 		BaoXiang_CBTBOX_Count	[	117	]	=	1
	BaoXiang_CBTBOX	[	118	]	=	0669		BaoXiang_CBTBOX_Rad	[	118	]	=	5 		BaoXiang_CBTBOX_Count	[	118	]	=	1
	BaoXiang_CBTBOX	[	119	]	=	0696		BaoXiang_CBTBOX_Rad	[	119	]	=	5 		BaoXiang_CBTBOX_Count	[	119	]	=	1
	BaoXiang_CBTBOX	[	120	]	=	0710		BaoXiang_CBTBOX_Rad	[	120	]	=	5 		BaoXiang_CBTBOX_Count	[	120	]	=	1
	BaoXiang_CBTBOX	[	121	]	=	0716		BaoXiang_CBTBOX_Rad	[	121	]	=	5 		BaoXiang_CBTBOX_Count	[	121	]	=	1
	BaoXiang_CBTBOX	[	122	]	=	0729		BaoXiang_CBTBOX_Rad	[	122	]	=	5 		BaoXiang_CBTBOX_Count	[	122	]	=	1
	BaoXiang_CBTBOX	[	123	]	=	0745		BaoXiang_CBTBOX_Rad	[	123	]	=	5 		BaoXiang_CBTBOX_Count	[	123	]	=	1
	BaoXiang_CBTBOX	[	124	]	=	0746		BaoXiang_CBTBOX_Rad	[	124	]	=	5 		BaoXiang_CBTBOX_Count	[	124	]	=	1
	BaoXiang_CBTBOX	[	125	]	=	3425		BaoXiang_CBTBOX_Rad	[	125	]	=	5 		BaoXiang_CBTBOX_Count	[	125	]	=	1
	BaoXiang_CBTBOX	[	126	]	=	3426		BaoXiang_CBTBOX_Rad	[	126	]	=	5 		BaoXiang_CBTBOX_Count	[	126	]	=	1
	BaoXiang_CBTBOX	[	127	]	=	3427		BaoXiang_CBTBOX_Rad	[	127	]	=	5 		BaoXiang_CBTBOX_Count	[	127	]	=	1
	BaoXiang_CBTBOX	[	128	]	=	3428		BaoXiang_CBTBOX_Rad	[	128	]	=	5 		BaoXiang_CBTBOX_Count	[	128	]	=	1
	BaoXiang_CBTBOX	[	129	]	=	3429		BaoXiang_CBTBOX_Rad	[	129	]	=	5 		BaoXiang_CBTBOX_Count	[	129	]	=	1
	BaoXiang_CBTBOX	[	130	]	=	3430		BaoXiang_CBTBOX_Rad	[	130	]	=	5 		BaoXiang_CBTBOX_Count	[	130	]	=	1
	BaoXiang_CBTBOX	[	131	]	=	3431		BaoXiang_CBTBOX_Rad	[	131	]	=	5 		BaoXiang_CBTBOX_Count	[	131	]	=	1
	BaoXiang_CBTBOX	[	132	]	=	3432		BaoXiang_CBTBOX_Rad	[	132	]	=	5 		BaoXiang_CBTBOX_Count	[	132	]	=	1
	BaoXiang_CBTBOX	[	133	]	=	3433		BaoXiang_CBTBOX_Rad	[	133	]	=	5 		BaoXiang_CBTBOX_Count	[	133	]	=	1
	BaoXiang_CBTBOX	[	134	]	=	3138		BaoXiang_CBTBOX_Rad	[	134	]	=	15 		BaoXiang_CBTBOX_Count	[	134	]	=	1
	BaoXiang_CBTBOX	[	135	]	=	3139		BaoXiang_CBTBOX_Rad	[	135	]	=	15 		BaoXiang_CBTBOX_Count	[	135	]	=	1
	BaoXiang_CBTBOX	[	136	]	=	3136		BaoXiang_CBTBOX_Rad	[	136	]	=	15 		BaoXiang_CBTBOX_Count	[	136	]	=	1
	BaoXiang_CBTBOX	[	137	]	=	3140		BaoXiang_CBTBOX_Rad	[	137	]	=	15 		BaoXiang_CBTBOX_Count	[	137	]	=	1
	BaoXiang_CBTBOX	[	138	]	=	3123		BaoXiang_CBTBOX_Rad	[	138	]	=	15 		BaoXiang_CBTBOX_Count	[	138	]	=	1
	BaoXiang_CBTBOX	[	139	]	=	3125		BaoXiang_CBTBOX_Rad	[	139	]	=	15 		BaoXiang_CBTBOX_Count	[	139	]	=	1
	BaoXiang_CBTBOX	[	140	]	=	3122		BaoXiang_CBTBOX_Rad	[	140	]	=	15 		BaoXiang_CBTBOX_Count	[	140	]	=	1
	BaoXiang_CBTBOX	[	141	]	=	3126		BaoXiang_CBTBOX_Rad	[	141	]	=	15 		BaoXiang_CBTBOX_Count	[	141	]	=	1
	BaoXiang_CBTBOX	[	142	]	=	3127		BaoXiang_CBTBOX_Rad	[	142	]	=	15 		BaoXiang_CBTBOX_Count	[	142	]	=	1
	BaoXiang_CBTBOX	[	143	]	=	3138		BaoXiang_CBTBOX_Rad	[	143	]	=	15 		BaoXiang_CBTBOX_Count	[	143	]	=	1
	BaoXiang_CBTBOX	[	144	]	=	3135		BaoXiang_CBTBOX_Rad	[	144	]	=	15 		BaoXiang_CBTBOX_Count	[	144	]	=	1
	BaoXiang_CBTBOX	[	145	]	=	3828		BaoXiang_CBTBOX_Rad	[	145	]	=	25 		BaoXiang_CBTBOX_Count	[	145	]	=	1
	BaoXiang_CBTBOX	[	146	]	=	3829		BaoXiang_CBTBOX_Rad	[	146	]	=	25 		BaoXiang_CBTBOX_Count	[	146	]	=	1
	BaoXiang_CBTBOX	[	147	]	=	3830		BaoXiang_CBTBOX_Rad	[	147	]	=	25 		BaoXiang_CBTBOX_Count	[	147	]	=	1
	BaoXiang_CBTBOX	[	148	]	=	3831		BaoXiang_CBTBOX_Rad	[	148	]	=	25 		BaoXiang_CBTBOX_Count	[	148	]	=	1
	BaoXiang_CBTBOX	[	149	]	=	3832		BaoXiang_CBTBOX_Rad	[	149	]	=	25 		BaoXiang_CBTBOX_Count	[	149	]	=	1
	BaoXiang_CBTBOX	[	150	]	=	3833		BaoXiang_CBTBOX_Rad	[	150	]	=	25 		BaoXiang_CBTBOX_Count	[	150	]	=	1
	BaoXiang_CBTBOX	[	151	]	=	3834		BaoXiang_CBTBOX_Rad	[	151	]	=	25 		BaoXiang_CBTBOX_Count	[	151	]	=	1
	BaoXiang_CBTBOX	[	152	]	=	3835		BaoXiang_CBTBOX_Rad	[	152	]	=	25 		BaoXiang_CBTBOX_Count	[	152	]	=	1
	BaoXiang_CBTBOX	[	153	]	=	3836		BaoXiang_CBTBOX_Rad	[	153	]	=	25 		BaoXiang_CBTBOX_Count	[	153	]	=	1
	BaoXiang_CBTBOX	[	154	]	=	3837		BaoXiang_CBTBOX_Rad	[	154	]	=	25 		BaoXiang_CBTBOX_Count	[	154	]	=	1
	BaoXiang_CBTBOX	[	155	]	=	3838		BaoXiang_CBTBOX_Rad	[	155	]	=	25 		BaoXiang_CBTBOX_Count	[	155	]	=	1
	BaoXiang_CBTBOX	[	156	]	=	3839		BaoXiang_CBTBOX_Rad	[	156	]	=	25 		BaoXiang_CBTBOX_Count	[	156	]	=	1
	BaoXiang_CBTBOX	[	157	]	=	3840		BaoXiang_CBTBOX_Rad	[	157	]	=	25 		BaoXiang_CBTBOX_Count	[	157	]	=	1
	BaoXiang_CBTBOX	[	158	]	=	3841		BaoXiang_CBTBOX_Rad	[	158	]	=	25 		BaoXiang_CBTBOX_Count	[	158	]	=	1
	BaoXiang_CBTBOX	[	159	]	=	3842		BaoXiang_CBTBOX_Rad	[	159	]	=	25 		BaoXiang_CBTBOX_Count	[	159	]	=	1
	BaoXiang_CBTBOX	[	160	]	=	3843		BaoXiang_CBTBOX_Rad	[	160	]	=	25 		BaoXiang_CBTBOX_Count	[	160	]	=	1
	BaoXiang_CBTBOX	[	161	]	=	0899		BaoXiang_CBTBOX_Rad	[	161	]	=	5 		BaoXiang_CBTBOX_Count	[	161	]	=	1
	BaoXiang_CBTBOX	[	162	]	=	0900		BaoXiang_CBTBOX_Rad	[	162	]	=	5 		BaoXiang_CBTBOX_Count	[	162	]	=	1
	BaoXiang_CBTBOX	[	163	]	=	0901		BaoXiang_CBTBOX_Rad	[	163	]	=	5 		BaoXiang_CBTBOX_Count	[	163	]	=	1
	BaoXiang_CBTBOX	[	164	]	=	0902		BaoXiang_CBTBOX_Rad	[	164	]	=	5 		BaoXiang_CBTBOX_Count	[	164	]	=	1
	BaoXiang_CBTBOX	[	165	]	=	0903		BaoXiang_CBTBOX_Rad	[	165	]	=	5 		BaoXiang_CBTBOX_Count	[	165	]	=	1
	BaoXiang_CBTBOX	[	166	]	=	3846		BaoXiang_CBTBOX_Rad	[	166	]	=	8 		BaoXiang_CBTBOX_Count	[	166	]	=	1
	BaoXiang_CBTBOX	[	167	]	=	3462		BaoXiang_CBTBOX_Rad	[	167	]	=	70 		BaoXiang_CBTBOX_Count	[	167	]	=	1
	BaoXiang_CBTBOX	[	168	]	=	0860		BaoXiang_CBTBOX_Rad	[	168	]	=	5 		BaoXiang_CBTBOX_Count	[	168	]	=	1
	BaoXiang_CBTBOX	[	169	]	=	0861		BaoXiang_CBTBOX_Rad	[	169	]	=	5 		BaoXiang_CBTBOX_Count	[	169	]	=	1
	BaoXiang_CBTBOX	[	170	]	=	0862		BaoXiang_CBTBOX_Rad	[	170	]	=	5 		BaoXiang_CBTBOX_Count	[	170	]	=	1
	BaoXiang_CBTBOX	[	171	]	=	0863		BaoXiang_CBTBOX_Rad	[	171	]	=	5 		BaoXiang_CBTBOX_Count	[	171	]	=	1
	BaoXiang_CBTBOX	[	172	]	=	3463		BaoXiang_CBTBOX_Rad	[	172	]	=	70 		BaoXiang_CBTBOX_Count	[	172	]	=	1
	BaoXiang_CBTBOX	[	173	]	=	3844		BaoXiang_CBTBOX_Rad	[	173	]	=	31 		BaoXiang_CBTBOX_Count	[	173	]	=	1
	BaoXiang_CBTBOX	[	174	]	=	3845		BaoXiang_CBTBOX_Rad	[	174	]	=	31 		BaoXiang_CBTBOX_Count	[	174	]	=	1
	BaoXiang_CBTBOX	[	175	]	=	0413		BaoXiang_CBTBOX_Rad	[	175	]	=	1 		BaoXiang_CBTBOX_Count	[	175	]	=	1
	BaoXiang_CBTBOX	[	176	]	=	0588		BaoXiang_CBTBOX_Rad	[	176	]	=	1 		BaoXiang_CBTBOX_Count	[	176	]	=	1
	BaoXiang_CBTBOX	[	177	]	=	0590		BaoXiang_CBTBOX_Rad	[	177	]	=	1 		BaoXiang_CBTBOX_Count	[	177	]	=	1
	BaoXiang_CBTBOX	[	178	]	=	0592		BaoXiang_CBTBOX_Rad	[	178	]	=	1 		BaoXiang_CBTBOX_Count	[	178	]	=	1
	BaoXiang_CBTBOX	[	179	]	=	0594		BaoXiang_CBTBOX_Rad	[	179	]	=	1 		BaoXiang_CBTBOX_Count	[	179	]	=	1
	BaoXiang_CBTBOX	[	180	]	=	0596		BaoXiang_CBTBOX_Rad	[	180	]	=	1 		BaoXiang_CBTBOX_Count	[	180	]	=	1
	BaoXiang_CBTBOX	[	181	]	=	0598		BaoXiang_CBTBOX_Rad	[	181	]	=	1 		BaoXiang_CBTBOX_Count	[	181	]	=	1
	BaoXiang_CBTBOX	[	182	]	=	0600		BaoXiang_CBTBOX_Rad	[	182	]	=	1 		BaoXiang_CBTBOX_Count	[	182	]	=	1
	BaoXiang_CBTBOX	[	183	]	=	0602		BaoXiang_CBTBOX_Rad	[	183	]	=	1 		BaoXiang_CBTBOX_Count	[	183	]	=	1
	BaoXiang_CBTBOX	[	184	]	=	0604		BaoXiang_CBTBOX_Rad	[	184	]	=	1 		BaoXiang_CBTBOX_Count	[	184	]	=	1
	BaoXiang_CBTBOX	[	185	]	=	0748		BaoXiang_CBTBOX_Rad	[	185	]	=	1 		BaoXiang_CBTBOX_Count	[	185	]	=	1
	BaoXiang_CBTBOX	[	186	]	=	0750		BaoXiang_CBTBOX_Rad	[	186	]	=	1 		BaoXiang_CBTBOX_Count	[	186	]	=	1
	BaoXiang_CBTBOX	[	187	]	=	0752		BaoXiang_CBTBOX_Rad	[	187	]	=	1 		BaoXiang_CBTBOX_Count	[	187	]	=	1
	BaoXiang_CBTBOX	[	188	]	=	0754		BaoXiang_CBTBOX_Rad	[	188	]	=	1 		BaoXiang_CBTBOX_Count	[	188	]	=	1
	BaoXiang_CBTBOX	[	189	]	=	0756		BaoXiang_CBTBOX_Rad	[	189	]	=	1 		BaoXiang_CBTBOX_Count	[	189	]	=	1
	BaoXiang_CBTBOX	[	190	]	=	0758		BaoXiang_CBTBOX_Rad	[	190	]	=	1 		BaoXiang_CBTBOX_Count	[	190	]	=	1
	BaoXiang_CBTBOX	[	191	]	=	0760		BaoXiang_CBTBOX_Rad	[	191	]	=	1 		BaoXiang_CBTBOX_Count	[	191	]	=	1
	BaoXiang_CBTBOX	[	192	]	=	0824		BaoXiang_CBTBOX_Rad	[	192	]	=	1 		BaoXiang_CBTBOX_Count	[	192	]	=	1
	BaoXiang_CBTBOX	[	193	]	=	0830		BaoXiang_CBTBOX_Rad	[	193	]	=	1 		BaoXiang_CBTBOX_Count	[	193	]	=	1
	BaoXiang_CBTBOX	[	194	]	=	2219		BaoXiang_CBTBOX_Rad	[	194	]	=	1 		BaoXiang_CBTBOX_Count	[	194	]	=	1
	BaoXiang_CBTBOX	[	195	]	=	2221		BaoXiang_CBTBOX_Rad	[	195	]	=	1 		BaoXiang_CBTBOX_Count	[	195	]	=	1
	BaoXiang_CBTBOX	[	196	]	=	2223		BaoXiang_CBTBOX_Rad	[	196	]	=	1 		BaoXiang_CBTBOX_Count	[	196	]	=	1
	BaoXiang_CBTBOX	[	197	]	=	0878		BaoXiang_CBTBOX_Rad	[	197	]	=	8 		BaoXiang_CBTBOX_Count	[	197	]	=	1
	BaoXiang_CBTBOX	[	198	]	=	0879		BaoXiang_CBTBOX_Rad	[	198	]	=	8 		BaoXiang_CBTBOX_Count	[	198	]	=	1
	BaoXiang_CBTBOX	[	199	]	=	0880		BaoXiang_CBTBOX_Rad	[	199	]	=	8 		BaoXiang_CBTBOX_Count	[	199	]	=	1
	BaoXiang_CBTBOX	[	200	]	=	0881		BaoXiang_CBTBOX_Rad	[	200	]	=	8 		BaoXiang_CBTBOX_Count	[	200	]	=	1
	BaoXiang_CBTBOX	[	201	]	=	0882		BaoXiang_CBTBOX_Rad	[	201	]	=	8 		BaoXiang_CBTBOX_Count	[	201	]	=	1
	BaoXiang_CBTBOX	[	202	]	=	0883		BaoXiang_CBTBOX_Rad	[	202	]	=	8 		BaoXiang_CBTBOX_Count	[	202	]	=	1
	BaoXiang_CBTBOX	[	203	]	=	0884		BaoXiang_CBTBOX_Rad	[	203	]	=	8 		BaoXiang_CBTBOX_Count	[	203	]	=	1
	BaoXiang_CBTBOX	[	204	]	=	0885		BaoXiang_CBTBOX_Rad	[	204	]	=	8 		BaoXiang_CBTBOX_Count	[	204	]	=	1
	BaoXiang_CBTBOX	[	205	]	=	0887		BaoXiang_CBTBOX_Rad	[	205	]	=	8 		BaoXiang_CBTBOX_Count	[	205	]	=	1
	BaoXiang_CBTBOX	[	206	]	=	0893		BaoXiang_CBTBOX_Rad	[	206	]	=	20 		BaoXiang_CBTBOX_Count	[	206	]	=	1
	BaoXiang_CBTBOX	[	207	]	=	0894		BaoXiang_CBTBOX_Rad	[	207	]	=	20 		BaoXiang_CBTBOX_Count	[	207	]	=	1
	BaoXiang_CBTBOX	[	208	]	=	0895		BaoXiang_CBTBOX_Rad	[	208	]	=	20 		BaoXiang_CBTBOX_Count	[	208	]	=	1
	BaoXiang_CBTBOX	[	209	]	=	0896		BaoXiang_CBTBOX_Rad	[	209	]	=	20 		BaoXiang_CBTBOX_Count	[	209	]	=	1
	BaoXiang_CBTBOX	[	210	]	=	0897		BaoXiang_CBTBOX_Rad	[	210	]	=	20 		BaoXiang_CBTBOX_Count	[	210	]	=	1
        BaoXiang_CBTBOX	[	211	]	=	0243		BaoXiang_CBTBOX_Rad	[	211	]	=	10 		BaoXiang_CBTBOX_Count	[	211	]	=	1
	BaoXiang_CBTBOX	[	212	]	=	0244		BaoXiang_CBTBOX_Rad	[	212	]	=	5 		BaoXiang_CBTBOX_Count	[	212	]	=	1
	BaoXiang_CBTBOX	[	213	]	=	0246		BaoXiang_CBTBOX_Rad	[	213	]	=	10 		BaoXiang_CBTBOX_Count	[	213	]	=	1
	BaoXiang_CBTBOX	[	214	]	=	0247		BaoXiang_CBTBOX_Rad	[	214	]	=	5 		BaoXiang_CBTBOX_Count	[	214	]	=	1
	BaoXiang_CBTBOX	[	215	]	=	0249		BaoXiang_CBTBOX_Rad	[	215	]	=	10 		BaoXiang_CBTBOX_Count	[	215	]	=	1
	BaoXiang_CBTBOX	[	216	]	=	0250		BaoXiang_CBTBOX_Rad	[	216	]	=	5 		BaoXiang_CBTBOX_Count	[	216	]	=	1
	BaoXiang_CBTBOX	[	217	]	=	0252		BaoXiang_CBTBOX_Rad	[	217	]	=	10 		BaoXiang_CBTBOX_Count	[	217	]	=	1
	BaoXiang_CBTBOX	[	218	]	=	0253		BaoXiang_CBTBOX_Rad	[	218	]	=	5 		BaoXiang_CBTBOX_Count	[	218	]	=	1
	BaoXiang_CBTBOX	[	219	]	=	0259		BaoXiang_CBTBOX_Rad	[	219	]	=	10 		BaoXiang_CBTBOX_Count	[	219	]	=	1
	BaoXiang_CBTBOX	[	220	]	=	0260		BaoXiang_CBTBOX_Rad	[	220	]	=	5 		BaoXiang_CBTBOX_Count	[	220	]	=	1
	BaoXiang_CBTBOX	[	221	]	=	0453		BaoXiang_CBTBOX_Rad	[	221	]	=	25 		BaoXiang_CBTBOX_Count	[	221	]	=	1
	BaoXiang_CBTBOX	[	222	]	=	0455		BaoXiang_CBTBOX_Rad	[	222	]	=	25 		BaoXiang_CBTBOX_Count	[	222	]	=	1


	BaoXiang_SYBOX_Qua	=	5				BaoXiang_SYBOX_Mxcount	=	15										
	BaoXiang_SYBOX	=	{}					BaoXiang_SYBOX_Rad	=	{}					BaoXiang_SYBOX_Count	=	{}			
	BaoXiang_SYBOX	[	1	]	=	0183		BaoXiang_SYBOX_Rad	[	1	]	=	1 		BaoXiang_SYBOX_Count	[	1	]	=	1
	BaoXiang_SYBOX	[	2	]	=	0184		BaoXiang_SYBOX_Rad	[	2	]	=	1 		BaoXiang_SYBOX_Count	[	2	]	=	1
	BaoXiang_SYBOX	[	3	]	=	0185		BaoXiang_SYBOX_Rad	[	3	]	=	1 		BaoXiang_SYBOX_Count	[	3	]	=	1
	BaoXiang_SYBOX	[	4	]	=	0186		BaoXiang_SYBOX_Rad	[	4	]	=	1 		BaoXiang_SYBOX_Count	[	4	]	=	1
	BaoXiang_SYBOX	[	5	]	=	0187		BaoXiang_SYBOX_Rad	[	5	]	=	1 		BaoXiang_SYBOX_Count	[	5	]	=	1
	BaoXiang_SYBOX	[	6	]	=	0188		BaoXiang_SYBOX_Rad	[	6	]	=	1 		BaoXiang_SYBOX_Count	[	6	]	=	1
	BaoXiang_SYBOX	[	7	]	=	0189		BaoXiang_SYBOX_Rad	[	7	]	=	1 		BaoXiang_SYBOX_Count	[	7	]	=	1
	BaoXiang_SYBOX	[	8	]	=	0190		BaoXiang_SYBOX_Rad	[	8	]	=	1 		BaoXiang_SYBOX_Count	[	8	]	=	1
	BaoXiang_SYBOX	[	9	]	=	0191		BaoXiang_SYBOX_Rad	[	9	]	=	1 		BaoXiang_SYBOX_Count	[	9	]	=	1
	BaoXiang_SYBOX	[	10	]	=	0199		BaoXiang_SYBOX_Rad	[	10	]	=	1 		BaoXiang_SYBOX_Count	[	10	]	=	1
	BaoXiang_SYBOX	[	11	]	=	3336		BaoXiang_SYBOX_Rad	[	11	]	=	15 		BaoXiang_SYBOX_Count	[	11	]	=	1
	BaoXiang_SYBOX	[	12	]	=	3885		BaoXiang_SYBOX_Rad	[	12	]	=	25 		BaoXiang_SYBOX_Count	[	12	]	=	1
	BaoXiang_SYBOX	[	13	]	=	3339		BaoXiang_SYBOX_Rad	[	13	]	=	100 		BaoXiang_SYBOX_Count	[	13	]	=	1
	BaoXiang_SYBOX	[	14	]	=	3340		BaoXiang_SYBOX_Rad	[	14	]	=	150 		BaoXiang_SYBOX_Count	[	14	]	=	1
	BaoXiang_SYBOX	[	15	]	=	3342		BaoXiang_SYBOX_Rad	[	15	]	=	200 		BaoXiang_SYBOX_Count	[	15	]	=	1


	BaoXiang_JingLingBOX_Qua	=	5				BaoXiang_JingLingBOX_Mxcount	=	7											
	BaoXiang_JingLingBOX	=	{}					BaoXiang_JingLingBOX_Rad	=	{}					BaoXiang_JingLingBOX_Count	=	{}				
	BaoXiang_JingLingBOX	[	1	]	=	0183		BaoXiang_JingLingBOX_Rad	[	1	]	=	32		BaoXiang_JingLingBOX_Count	[	1	]	=	1	
	BaoXiang_JingLingBOX	[	2	]	=	0189		BaoXiang_JingLingBOX_Rad	[	2	]	=	32		BaoXiang_JingLingBOX_Count	[	2	]	=	1	
	BaoXiang_JingLingBOX	[	3	]	=	0185		BaoXiang_JingLingBOX_Rad	[	3	]	=	32		BaoXiang_JingLingBOX_Count	[	3	]	=	1	
	BaoXiang_JingLingBOX	[	4	]	=	0186		BaoXiang_JingLingBOX_Rad	[	4	]	=	1		BaoXiang_JingLingBOX_Count	[	4	]	=	1	
	BaoXiang_JingLingBOX	[	5	]	=	0187		BaoXiang_JingLingBOX_Rad	[	5	]	=	1		BaoXiang_JingLingBOX_Count	[	5	]	=	1	
	BaoXiang_JingLingBOX	[	6	]	=	0188		BaoXiang_JingLingBOX_Rad	[	6	]	=	1		BaoXiang_JingLingBOX_Count	[	6	]	=	1	
	BaoXiang_JingLingBOX	[	7	]	=	0184		BaoXiang_JingLingBOX_Rad	[	7	]	=	1		BaoXiang_JingLingBOX_Count	[	7	]	=	1	


	BoxXiang_FLeiBOX_Qua	=	5					BoxXiang_FLeiBOX_Mxcount	=	12										
	BoxXiang_FLeiBOX	=	{}	 	 	 		BoxXiang_FLeiBOX_Rad	=	{}	 	 			BoxXiang_FLeiBOX_Count	=	{}			
	BoxXiang_FLeiBOX	[	1	]	=	5001		BoxXiang_FLeiBOX_Rad	[	1	]	=	1		BoxXiang_FLeiBOX_Count	[	1	]	=	1
	BoxXiang_FLeiBOX	[	2	]	=	5002		BoxXiang_FLeiBOX_Rad	[	2	]	=	1		BoxXiang_FLeiBOX_Count	[	2	]	=	1
	BoxXiang_FLeiBOX	[	3	]	=	5003		BoxXiang_FLeiBOX_Rad	[	3	]	=	1		BoxXiang_FLeiBOX_Count	[	3	]	=	1
	BoxXiang_FLeiBOX	[	4	]	=	5004		BoxXiang_FLeiBOX_Rad	[	4	]	=	1		BoxXiang_FLeiBOX_Count	[	4	]	=	1
	BoxXiang_FLeiBOX	[	5	]	=	5005		BoxXiang_FLeiBOX_Rad	[	5	]	=	1		BoxXiang_FLeiBOX_Count	[	5	]	=	1
	BoxXiang_FLeiBOX	[	6	]	=	5006		BoxXiang_FLeiBOX_Rad	[	6	]	=	1		BoxXiang_FLeiBOX_Count	[	6	]	=	1
	BoxXiang_FLeiBOX	[	7	]	=	5007		BoxXiang_FLeiBOX_Rad	[	7	]	=	1		BoxXiang_FLeiBOX_Count	[	7	]	=	1
	BoxXiang_FLeiBOX	[	8	]	=	5008		BoxXiang_FLeiBOX_Rad	[	8	]	=	1		BoxXiang_FLeiBOX_Count	[	8	]	=	1
	BoxXiang_FLeiBOX	[	9	]	=	5009		BoxXiang_FLeiBOX_Rad	[	9	]	=	1		BoxXiang_FLeiBOX_Count	[	9	]	=	1
	BoxXiang_FLeiBOX	[	10	]	=	5010		BoxXiang_FLeiBOX_Rad	[	10	]	=	1		BoxXiang_FLeiBOX_Count	[	10	]	=	1
	BoxXiang_FLeiBOX	[	11	]	=	5011		BoxXiang_FLeiBOX_Rad	[	11	]	=	1		BoxXiang_FLeiBOX_Count	[	11	]	=	1
	BoxXiang_FLeiBOX	[	12	]	=	5012		BoxXiang_FLeiBOX_Rad	[	12	]	=	1		BoxXiang_FLeiBOX_Count	[	12	]	=	1

																				
	BoxXiang_YiYuanBOX_Qua	=	5					BoxXiang_YiYuanBOX_Mxcount	=	32										
	BoxXiang_YiYuanBOX	=	{}					BoxXiang_YiYuanBOX_Rad	=	{}					BoxXiang_YiYuanBOX_Count	=	{}			
	BoxXiang_YiYuanBOX	[	1	]	=	3098		BoxXiang_YiYuanBOX_Rad	[	1	]	=	150 		BoxXiang_YiYuanBOX_Count	[	1	]	=	4
	BoxXiang_YiYuanBOX	[	2	]	=	3054		BoxXiang_YiYuanBOX_Rad	[	2	]	=	150 		BoxXiang_YiYuanBOX_Count	[	2	]	=	4
	BoxXiang_YiYuanBOX	[	3	]	=	3049		BoxXiang_YiYuanBOX_Rad	[	3	]	=	150 		BoxXiang_YiYuanBOX_Count	[	3	]	=	4
	BoxXiang_YiYuanBOX	[	4	]	=	3048		BoxXiang_YiYuanBOX_Rad	[	4	]	=	150 		BoxXiang_YiYuanBOX_Count	[	4	]	=	4
	BoxXiang_YiYuanBOX	[	5	]	=	3051		BoxXiang_YiYuanBOX_Rad	[	5	]	=	150 		BoxXiang_YiYuanBOX_Count	[	5	]	=	4
	BoxXiang_YiYuanBOX	[	6	]	=	3076		BoxXiang_YiYuanBOX_Rad	[	6	]	=	150 		BoxXiang_YiYuanBOX_Count	[	6	]	=	4
	BoxXiang_YiYuanBOX	[	7	]	=	3106		BoxXiang_YiYuanBOX_Rad	[	7	]	=	150 		BoxXiang_YiYuanBOX_Count	[	7	]	=	4
	BoxXiang_YiYuanBOX	[	8	]	=	3050		BoxXiang_YiYuanBOX_Rad	[	8	]	=	180 		BoxXiang_YiYuanBOX_Count	[	8	]	=	4
	BoxXiang_YiYuanBOX	[	9	]	=	227		BoxXiang_YiYuanBOX_Rad	[	9	]	=	180 		BoxXiang_YiYuanBOX_Count	[	9	]	=	4
	BoxXiang_YiYuanBOX	[	10	]	=	3096		BoxXiang_YiYuanBOX_Rad	[	10	]	=	180 		BoxXiang_YiYuanBOX_Count	[	10	]	=	4
	BoxXiang_YiYuanBOX	[	11	]	=	3300		BoxXiang_YiYuanBOX_Rad	[	11	]	=	180 		BoxXiang_YiYuanBOX_Count	[	11	]	=	4
	BoxXiang_YiYuanBOX	[	12	]	=	3301		BoxXiang_YiYuanBOX_Rad	[	12	]	=	180 		BoxXiang_YiYuanBOX_Count	[	12	]	=	4
	BoxXiang_YiYuanBOX	[	13	]	=	3114		BoxXiang_YiYuanBOX_Rad	[	13	]	=	180 		BoxXiang_YiYuanBOX_Count	[	13	]	=	2
	BoxXiang_YiYuanBOX	[	14	]	=	3094		BoxXiang_YiYuanBOX_Rad	[	14	]	=	180 		BoxXiang_YiYuanBOX_Count	[	14	]	=	2
	BoxXiang_YiYuanBOX	[	15	]	=	3909		BoxXiang_YiYuanBOX_Rad	[	15	]	=	180 		BoxXiang_YiYuanBOX_Count	[	15	]	=	2
	BoxXiang_YiYuanBOX	[	16	]	=	222		BoxXiang_YiYuanBOX_Rad	[	16	]	=	180 		BoxXiang_YiYuanBOX_Count	[	16	]	=	2
	BoxXiang_YiYuanBOX	[	17	]	=	225		BoxXiang_YiYuanBOX_Rad	[	17	]	=	180 		BoxXiang_YiYuanBOX_Count	[	17	]	=	2
	BoxXiang_YiYuanBOX	[	18	]	=	3336		BoxXiang_YiYuanBOX_Rad	[	18	]	=	180 		BoxXiang_YiYuanBOX_Count	[	18	]	=	1
	BoxXiang_YiYuanBOX	[	19	]	=	3885		BoxXiang_YiYuanBOX_Rad	[	19	]	=	50 		BoxXiang_YiYuanBOX_Count	[	19	]	=	1
	BoxXiang_YiYuanBOX	[	20	]	=	430		BoxXiang_YiYuanBOX_Rad	[	20	]	=	50 		BoxXiang_YiYuanBOX_Count	[	20	]	=	1
	BoxXiang_YiYuanBOX	[	21	]	=	3886		BoxXiang_YiYuanBOX_Rad	[	21	]	=	50 		BoxXiang_YiYuanBOX_Count	[	21	]	=	1
	BoxXiang_YiYuanBOX	[	22	]	=	3113		BoxXiang_YiYuanBOX_Rad	[	22	]	=	50 		BoxXiang_YiYuanBOX_Count	[	22	]	=	1
	BoxXiang_YiYuanBOX	[	23	]	=	3111		BoxXiang_YiYuanBOX_Rad	[	23	]	=	50 		BoxXiang_YiYuanBOX_Count	[	23	]	=	1
	BoxXiang_YiYuanBOX	[	24	]	=	3093		BoxXiang_YiYuanBOX_Rad	[	24	]	=	50 		BoxXiang_YiYuanBOX_Count	[	24	]	=	1
	BoxXiang_YiYuanBOX	[	25	]	=	3090		BoxXiang_YiYuanBOX_Rad	[	25	]	=	50 		BoxXiang_YiYuanBOX_Count	[	25	]	=	1
	BoxXiang_YiYuanBOX	[	26	]	=	0860		BoxXiang_YiYuanBOX_Rad	[	26	]	=	10 		BoxXiang_YiYuanBOX_Count	[	26	]	=	1
	BoxXiang_YiYuanBOX	[	27	]	=	0861		BoxXiang_YiYuanBOX_Rad	[	27	]	=	10 		BoxXiang_YiYuanBOX_Count	[	27	]	=	1
	BoxXiang_YiYuanBOX	[	28	]	=	0862		BoxXiang_YiYuanBOX_Rad	[	28	]	=	10 		BoxXiang_YiYuanBOX_Count	[	28	]	=	1
	BoxXiang_YiYuanBOX	[	29	]	=	0863		BoxXiang_YiYuanBOX_Rad	[	29	]	=	10 		BoxXiang_YiYuanBOX_Count	[	29	]	=	1
	BoxXiang_YiYuanBOX	[	30	]	=	179		BoxXiang_YiYuanBOX_Rad	[	30	]	=	1 		BoxXiang_YiYuanBOX_Count	[	30	]	=	1
	BoxXiang_YiYuanBOX	[	31	]	=	3084		BoxXiang_YiYuanBOX_Rad	[	31	]	=	1 		BoxXiang_YiYuanBOX_Count	[	31	]	=	1
	BoxXiang_YiYuanBOX	[	32	]	=	3085		BoxXiang_YiYuanBOX_Rad	[	32	]	=	1 		BoxXiang_YiYuanBOX_Count	[	32	]	=	1


	BoxXiang_baozhabao_Qua	=	5					BoxXiang_baozhabao_Mxcount	=	35										
	BoxXiang_BaoZhaBOX	=	{}					BoxXiang_BaoZhaBOX_Rad	=	{}					BoxXiang_BaoZhaBOX_Count	=	{}			
	BoxXiang_BaoZhaBOX	[	1	]	=	3077		BoxXiang_BaoZhaBOX_Rad	[	1	]	=	566 		BoxXiang_BaoZhaBOX_Count	[	1	]	=	10
	BoxXiang_BaoZhaBOX	[	2	]	=	3094		BoxXiang_BaoZhaBOX_Rad	[	2	]	=	566 		BoxXiang_BaoZhaBOX_Count	[	2	]	=	2
	BoxXiang_BaoZhaBOX	[	3	]	=	3096		BoxXiang_BaoZhaBOX_Rad	[	3	]	=	566 		BoxXiang_BaoZhaBOX_Count	[	3	]	=	4
	BoxXiang_BaoZhaBOX	[	4	]	=	3107		BoxXiang_BaoZhaBOX_Rad	[	4	]	=	566 		BoxXiang_BaoZhaBOX_Count	[	4	]	=	3
	BoxXiang_BaoZhaBOX	[	5	]	=	4272		BoxXiang_BaoZhaBOX_Rad	[	5	]	=	566 		BoxXiang_BaoZhaBOX_Count	[	5	]	=	8
	BoxXiang_BaoZhaBOX	[	6	]	=	4273		BoxXiang_BaoZhaBOX_Rad	[	6	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	6	]	=	8
	BoxXiang_BaoZhaBOX	[	7	]	=	4270		BoxXiang_BaoZhaBOX_Rad	[	7	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	7	]	=	8
	BoxXiang_BaoZhaBOX	[	8	]	=	4271		BoxXiang_BaoZhaBOX_Rad	[	8	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	8	]	=	8
	BoxXiang_BaoZhaBOX	[	9	]	=	227		BoxXiang_BaoZhaBOX_Rad	[	9	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	9	]	=	4
	BoxXiang_BaoZhaBOX	[	10	]	=	0905		BoxXiang_BaoZhaBOX_Rad	[	10	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	10	]	=	1
	BoxXiang_BaoZhaBOX	[	11	]	=	3047		BoxXiang_BaoZhaBOX_Rad	[	11	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	11	]	=	1
	BoxXiang_BaoZhaBOX	[	12	]	=	0932		BoxXiang_BaoZhaBOX_Rad	[	12	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	12	]	=	1
	BoxXiang_BaoZhaBOX	[	13	]	=	0931		BoxXiang_BaoZhaBOX_Rad	[	13	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	13	]	=	1
	BoxXiang_BaoZhaBOX	[	14	]	=	0933		BoxXiang_BaoZhaBOX_Rad	[	14	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	14	]	=	1
	BoxXiang_BaoZhaBOX	[	15	]	=	0934		BoxXiang_BaoZhaBOX_Rad	[	15	]	=	567 		BoxXiang_BaoZhaBOX_Count	[	15	]	=	1
	BoxXiang_BaoZhaBOX	[	16	]	=	3111		BoxXiang_BaoZhaBOX_Rad	[	16	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	16	]	=	1
	BoxXiang_BaoZhaBOX	[	17	]	=	3110		BoxXiang_BaoZhaBOX_Rad	[	17	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	17	]	=	1
	BoxXiang_BaoZhaBOX	[	18	]	=	3112		BoxXiang_BaoZhaBOX_Rad	[	18	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	18	]	=	1
	BoxXiang_BaoZhaBOX	[	19	]	=	3886		BoxXiang_BaoZhaBOX_Rad	[	19	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	19	]	=	1
	BoxXiang_BaoZhaBOX	[	20	]	=	3093		BoxXiang_BaoZhaBOX_Rad	[	20	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	20	]	=	1
	BoxXiang_BaoZhaBOX	[	21	]	=	3090		BoxXiang_BaoZhaBOX_Rad	[	21	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	21	]	=	1
	BoxXiang_BaoZhaBOX	[	22	]	=	430		BoxXiang_BaoZhaBOX_Rad	[	22	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	22	]	=	1
	BoxXiang_BaoZhaBOX	[	23	]	=	179		BoxXiang_BaoZhaBOX_Rad	[	23	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	23	]	=	1
	BoxXiang_BaoZhaBOX	[	24	]	=	3084		BoxXiang_BaoZhaBOX_Rad	[	24	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	24	]	=	1
	BoxXiang_BaoZhaBOX	[	25	]	=	3085		BoxXiang_BaoZhaBOX_Rad	[	25	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	25	]	=	1
	BoxXiang_BaoZhaBOX	[	26	]	=	0244		BoxXiang_BaoZhaBOX_Rad	[	26	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	26	]	=	1
	BoxXiang_BaoZhaBOX	[	27	]	=	0250		BoxXiang_BaoZhaBOX_Rad	[	27	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	27	]	=	1
	BoxXiang_BaoZhaBOX	[	28	]	=	0253		BoxXiang_BaoZhaBOX_Rad	[	28	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	28	]	=	1
	BoxXiang_BaoZhaBOX	[	29	]	=	0260		BoxXiang_BaoZhaBOX_Rad	[	29	]	=	100 		BoxXiang_BaoZhaBOX_Count	[	29	]	=	1
	BoxXiang_BaoZhaBOX	[	30	]	=	3458		BoxXiang_BaoZhaBOX_Rad	[	30	]	=	22 		BoxXiang_BaoZhaBOX_Count	[	30	]	=	1
	BoxXiang_BaoZhaBOX	[	31	]	=	3458		BoxXiang_BaoZhaBOX_Rad	[	31	]	=	23 		BoxXiang_BaoZhaBOX_Count	[	31	]	=	1
	BoxXiang_BaoZhaBOX	[	32	]	=	3458		BoxXiang_BaoZhaBOX_Rad	[	32	]	=	22 		BoxXiang_BaoZhaBOX_Count	[	32	]	=	1
	BoxXiang_BaoZhaBOX	[	33	]	=	3458		BoxXiang_BaoZhaBOX_Rad	[	33	]	=	22 		BoxXiang_BaoZhaBOX_Count	[	33	]	=	1
	BoxXiang_BaoZhaBOX	[	34	]	=	0247		BoxXiang_BaoZhaBOX_Rad	[	34	]	=	11 		BoxXiang_BaoZhaBOX_Count	[	34	]	=	1
	BoxXiang_BaoZhaBOX	[	35	]	=	271		BoxXiang_BaoZhaBOX_Rad	[	35	]	=	5 		BoxXiang_BaoZhaBOX_Count	[	35	]	=	1


	BoxXiang_ZhouSui_Qua	=	5					BoxXiang_ZhouSui_Mxcount	=	16										
	BoxXiang_ZhousSuiBOX	=	{}					BoxXiang_ZhousSuiBOX_Rad	=	{}					BoxXiang_ZhousSuiBOX_Count	=	{}			
	BoxXiang_ZhousSuiBOX	[	1	]	=	0853		BoxXiang_ZhousSuiBOX_Rad	[	1	]	=	2 		BoxXiang_ZhousSuiBOX_Count	[	1	]	=	1
	BoxXiang_ZhousSuiBOX	[	2	]	=	3047		BoxXiang_ZhousSuiBOX_Rad	[	2	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	2	]	=	5
	BoxXiang_ZhousSuiBOX	[	3	]	=	3112		BoxXiang_ZhousSuiBOX_Rad	[	3	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	3	]	=	1
	BoxXiang_ZhousSuiBOX	[	4	]	=	3110		BoxXiang_ZhousSuiBOX_Rad	[	4	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	4	]	=	1
	BoxXiang_ZhousSuiBOX	[	5	]	=	3111		BoxXiang_ZhousSuiBOX_Rad	[	5	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	5	]	=	1
	BoxXiang_ZhousSuiBOX	[	6	]	=	3113		BoxXiang_ZhousSuiBOX_Rad	[	6	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	6	]	=	1
	BoxXiang_ZhousSuiBOX	[	7	]	=	3109		BoxXiang_ZhousSuiBOX_Rad	[	7	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	7	]	=	1
	BoxXiang_ZhousSuiBOX	[	8	]	=	3092		BoxXiang_ZhousSuiBOX_Rad	[	8	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	8	]	=	1
	BoxXiang_ZhousSuiBOX	[	9	]	=	3089		BoxXiang_ZhousSuiBOX_Rad	[	9	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	9	]	=	1
	BoxXiang_ZhousSuiBOX	[	10	]	=	430		BoxXiang_ZhousSuiBOX_Rad	[	10	]	=	5 		BoxXiang_ZhousSuiBOX_Count	[	10	]	=	1
	BoxXiang_ZhousSuiBOX	[	11	]	=	4273		BoxXiang_ZhousSuiBOX_Rad	[	11	]	=	9 		BoxXiang_ZhousSuiBOX_Count	[	11	]	=	20
	BoxXiang_ZhousSuiBOX	[	12	]	=	4271		BoxXiang_ZhousSuiBOX_Rad	[	12	]	=	9 		BoxXiang_ZhousSuiBOX_Count	[	12	]	=	20
	BoxXiang_ZhousSuiBOX	[	13	]	=	3096		BoxXiang_ZhousSuiBOX_Rad	[	13	]	=	9 		BoxXiang_ZhousSuiBOX_Count	[	13	]	=	10
	BoxXiang_ZhousSuiBOX	[	14	]	=	0227		BoxXiang_ZhousSuiBOX_Rad	[	14	]	=	9 		BoxXiang_ZhousSuiBOX_Count	[	14	]	=	10
	BoxXiang_ZhousSuiBOX	[	15	]	=	0937		BoxXiang_ZhousSuiBOX_Rad	[	15	]	=	9 		BoxXiang_ZhousSuiBOX_Count	[	15	]	=	1
	BoxXiang_ZhousSuiBOX	[	16	]	=	3094		BoxXiang_ZhousSuiBOX_Rad	[	16	]	=	8 		BoxXiang_ZhousSuiBOX_Count	[	16	]	=	10


	BaoXiang_JLBCBTBOX_Qua	=	5	 				BaoXiang_JLBCBTBOX_Mxcount	=	183										
	BaoXiang_JLBCBTBOX	=	{}					BaoXiang_JLBCBTBOX_Rad	=	{}					BaoXiang_JLBCBTBOX_Count	=	{}			
	BaoXiang_JLBCBTBOX	[	1	]	=	0291		BaoXiang_JLBCBTBOX_Rad	[	1	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	1	]	=	1
	BaoXiang_JLBCBTBOX	[	2	]	=	0293		BaoXiang_JLBCBTBOX_Rad	[	2	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	2	]	=	1
	BaoXiang_JLBCBTBOX	[	3	]	=	0295		BaoXiang_JLBCBTBOX_Rad	[	3	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	3	]	=	1
	BaoXiang_JLBCBTBOX	[	4	]	=	0297		BaoXiang_JLBCBTBOX_Rad	[	4	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	4	]	=	1
	BaoXiang_JLBCBTBOX	[	5	]	=	0298		BaoXiang_JLBCBTBOX_Rad	[	5	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	5	]	=	1
	BaoXiang_JLBCBTBOX	[	6	]	=	0300		BaoXiang_JLBCBTBOX_Rad	[	6	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	6	]	=	1
	BaoXiang_JLBCBTBOX	[	7	]	=	0306		BaoXiang_JLBCBTBOX_Rad	[	7	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	7	]	=	1
	BaoXiang_JLBCBTBOX	[	8	]	=	0307		BaoXiang_JLBCBTBOX_Rad	[	8	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	8	]	=	1
	BaoXiang_JLBCBTBOX	[	9	]	=	0311		BaoXiang_JLBCBTBOX_Rad	[	9	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	9	]	=	1
	BaoXiang_JLBCBTBOX	[	10	]	=	0313		BaoXiang_JLBCBTBOX_Rad	[	10	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	10	]	=	1
	BaoXiang_JLBCBTBOX	[	11	]	=	0314		BaoXiang_JLBCBTBOX_Rad	[	11	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	11	]	=	1
	BaoXiang_JLBCBTBOX	[	12	]	=	0336		BaoXiang_JLBCBTBOX_Rad	[	12	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	12	]	=	1
	BaoXiang_JLBCBTBOX	[	13	]	=	0337		BaoXiang_JLBCBTBOX_Rad	[	13	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	13	]	=	1
	BaoXiang_JLBCBTBOX	[	14	]	=	0338		BaoXiang_JLBCBTBOX_Rad	[	14	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	14	]	=	1
	BaoXiang_JLBCBTBOX	[	15	]	=	0339		BaoXiang_JLBCBTBOX_Rad	[	15	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	15	]	=	1
	BaoXiang_JLBCBTBOX	[	16	]	=	0340		BaoXiang_JLBCBTBOX_Rad	[	16	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	16	]	=	1
	BaoXiang_JLBCBTBOX	[	17	]	=	0341		BaoXiang_JLBCBTBOX_Rad	[	17	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	17	]	=	1
	BaoXiang_JLBCBTBOX	[	18	]	=	0352		BaoXiang_JLBCBTBOX_Rad	[	18	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	18	]	=	1
	BaoXiang_JLBCBTBOX	[	19	]	=	0353		BaoXiang_JLBCBTBOX_Rad	[	19	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	19	]	=	1
	BaoXiang_JLBCBTBOX	[	20	]	=	0354		BaoXiang_JLBCBTBOX_Rad	[	20	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	20	]	=	1
	BaoXiang_JLBCBTBOX	[	21	]	=	0350		BaoXiang_JLBCBTBOX_Rad	[	21	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	21	]	=	1
	BaoXiang_JLBCBTBOX	[	22	]	=	0360		BaoXiang_JLBCBTBOX_Rad	[	22	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	22	]	=	1
	BaoXiang_JLBCBTBOX	[	23	]	=	0361		BaoXiang_JLBCBTBOX_Rad	[	23	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	23	]	=	1
	BaoXiang_JLBCBTBOX	[	24	]	=	0362		BaoXiang_JLBCBTBOX_Rad	[	24	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	24	]	=	1
	BaoXiang_JLBCBTBOX	[	25	]	=	0467		BaoXiang_JLBCBTBOX_Rad	[	25	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	25	]	=	1
	BaoXiang_JLBCBTBOX	[	26	]	=	0469		BaoXiang_JLBCBTBOX_Rad	[	26	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	26	]	=	1
	BaoXiang_JLBCBTBOX	[	27	]	=	0471		BaoXiang_JLBCBTBOX_Rad	[	27	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	27	]	=	1
	BaoXiang_JLBCBTBOX	[	28	]	=	0473		BaoXiang_JLBCBTBOX_Rad	[	28	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	28	]	=	1
	BaoXiang_JLBCBTBOX	[	29	]	=	0474		BaoXiang_JLBCBTBOX_Rad	[	29	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	29	]	=	1
	BaoXiang_JLBCBTBOX	[	30	]	=	0476		BaoXiang_JLBCBTBOX_Rad	[	30	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	30	]	=	1
	BaoXiang_JLBCBTBOX	[	31	]	=	0482		BaoXiang_JLBCBTBOX_Rad	[	31	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	31	]	=	1
	BaoXiang_JLBCBTBOX	[	32	]	=	0483		BaoXiang_JLBCBTBOX_Rad	[	32	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	32	]	=	1
	BaoXiang_JLBCBTBOX	[	33	]	=	0486		BaoXiang_JLBCBTBOX_Rad	[	33	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	33	]	=	1
	BaoXiang_JLBCBTBOX	[	34	]	=	0487		BaoXiang_JLBCBTBOX_Rad	[	34	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	34	]	=	1
	BaoXiang_JLBCBTBOX	[	35	]	=	0490		BaoXiang_JLBCBTBOX_Rad	[	35	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	35	]	=	1
	BaoXiang_JLBCBTBOX	[	36	]	=	0513		BaoXiang_JLBCBTBOX_Rad	[	36	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	36	]	=	1
	BaoXiang_JLBCBTBOX	[	37	]	=	0514		BaoXiang_JLBCBTBOX_Rad	[	37	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	37	]	=	1
	BaoXiang_JLBCBTBOX	[	38	]	=	0515		BaoXiang_JLBCBTBOX_Rad	[	38	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	38	]	=	1
	BaoXiang_JLBCBTBOX	[	39	]	=	0516		BaoXiang_JLBCBTBOX_Rad	[	39	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	39	]	=	1
	BaoXiang_JLBCBTBOX	[	40	]	=	0517		BaoXiang_JLBCBTBOX_Rad	[	40	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	40	]	=	1
	BaoXiang_JLBCBTBOX	[	41	]	=	0536		BaoXiang_JLBCBTBOX_Rad	[	41	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	41	]	=	1
	BaoXiang_JLBCBTBOX	[	42	]	=	0537		BaoXiang_JLBCBTBOX_Rad	[	42	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	42	]	=	1
	BaoXiang_JLBCBTBOX	[	43	]	=	0542		BaoXiang_JLBCBTBOX_Rad	[	43	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	43	]	=	1
	BaoXiang_JLBCBTBOX	[	44	]	=	0543		BaoXiang_JLBCBTBOX_Rad	[	44	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	44	]	=	1
	BaoXiang_JLBCBTBOX	[	45	]	=	0544		BaoXiang_JLBCBTBOX_Rad	[	45	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	45	]	=	1
	BaoXiang_JLBCBTBOX	[	46	]	=	0546		BaoXiang_JLBCBTBOX_Rad	[	46	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	46	]	=	1
	BaoXiang_JLBCBTBOX	[	47	]	=	0549		BaoXiang_JLBCBTBOX_Rad	[	47	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	47	]	=	1
	BaoXiang_JLBCBTBOX	[	48	]	=	0550		BaoXiang_JLBCBTBOX_Rad	[	48	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	48	]	=	1
	BaoXiang_JLBCBTBOX	[	49	]	=	0557		BaoXiang_JLBCBTBOX_Rad	[	49	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	49	]	=	1
	BaoXiang_JLBCBTBOX	[	50	]	=	0562		BaoXiang_JLBCBTBOX_Rad	[	50	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	50	]	=	1
	BaoXiang_JLBCBTBOX	[	51	]	=	0565		BaoXiang_JLBCBTBOX_Rad	[	51	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	51	]	=	1
	BaoXiang_JLBCBTBOX	[	52	]	=	0566		BaoXiang_JLBCBTBOX_Rad	[	52	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	52	]	=	1
	BaoXiang_JLBCBTBOX	[	53	]	=	0568		BaoXiang_JLBCBTBOX_Rad	[	53	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	53	]	=	1
	BaoXiang_JLBCBTBOX	[	54	]	=	0649		BaoXiang_JLBCBTBOX_Rad	[	54	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	54	]	=	1
	BaoXiang_JLBCBTBOX	[	55	]	=	0650		BaoXiang_JLBCBTBOX_Rad	[	55	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	55	]	=	1
	BaoXiang_JLBCBTBOX	[	56	]	=	0652		BaoXiang_JLBCBTBOX_Rad	[	56	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	56	]	=	1
	BaoXiang_JLBCBTBOX	[	57	]	=	0658		BaoXiang_JLBCBTBOX_Rad	[	57	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	57	]	=	1
	BaoXiang_JLBCBTBOX	[	58	]	=	0659		BaoXiang_JLBCBTBOX_Rad	[	58	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	58	]	=	1
	BaoXiang_JLBCBTBOX	[	59	]	=	0662		BaoXiang_JLBCBTBOX_Rad	[	59	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	59	]	=	1
	BaoXiang_JLBCBTBOX	[	60	]	=	0665		BaoXiang_JLBCBTBOX_Rad	[	60	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	60	]	=	1
	BaoXiang_JLBCBTBOX	[	61	]	=	0666		BaoXiang_JLBCBTBOX_Rad	[	61	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	61	]	=	1
	BaoXiang_JLBCBTBOX	[	62	]	=	0689		BaoXiang_JLBCBTBOX_Rad	[	62	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	62	]	=	1
	BaoXiang_JLBCBTBOX	[	63	]	=	0690		BaoXiang_JLBCBTBOX_Rad	[	63	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	63	]	=	1
	BaoXiang_JLBCBTBOX	[	64	]	=	0691		BaoXiang_JLBCBTBOX_Rad	[	64	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	64	]	=	1
	BaoXiang_JLBCBTBOX	[	65	]	=	0692		BaoXiang_JLBCBTBOX_Rad	[	65	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	65	]	=	1
	BaoXiang_JLBCBTBOX	[	66	]	=	0693		BaoXiang_JLBCBTBOX_Rad	[	66	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	66	]	=	1
	BaoXiang_JLBCBTBOX	[	67	]	=	0702		BaoXiang_JLBCBTBOX_Rad	[	67	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	67	]	=	1
	BaoXiang_JLBCBTBOX	[	68	]	=	0704		BaoXiang_JLBCBTBOX_Rad	[	68	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	68	]	=	1
	BaoXiang_JLBCBTBOX	[	69	]	=	0705		BaoXiang_JLBCBTBOX_Rad	[	69	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	69	]	=	1
	BaoXiang_JLBCBTBOX	[	70	]	=	0706		BaoXiang_JLBCBTBOX_Rad	[	70	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	70	]	=	1
	BaoXiang_JLBCBTBOX	[	71	]	=	0712		BaoXiang_JLBCBTBOX_Rad	[	71	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	71	]	=	1
	BaoXiang_JLBCBTBOX	[	72	]	=	0713		BaoXiang_JLBCBTBOX_Rad	[	72	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	72	]	=	1
	BaoXiang_JLBCBTBOX	[	73	]	=	0718		BaoXiang_JLBCBTBOX_Rad	[	73	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	73	]	=	1
	BaoXiang_JLBCBTBOX	[	74	]	=	0719		BaoXiang_JLBCBTBOX_Rad	[	74	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	74	]	=	1
	BaoXiang_JLBCBTBOX	[	75	]	=	0720		BaoXiang_JLBCBTBOX_Rad	[	75	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	75	]	=	1
	BaoXiang_JLBCBTBOX	[	76	]	=	0722		BaoXiang_JLBCBTBOX_Rad	[	76	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	76	]	=	1
	BaoXiang_JLBCBTBOX	[	77	]	=	0725		BaoXiang_JLBCBTBOX_Rad	[	77	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	77	]	=	1
	BaoXiang_JLBCBTBOX	[	78	]	=	0726		BaoXiang_JLBCBTBOX_Rad	[	78	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	78	]	=	1
	BaoXiang_JLBCBTBOX	[	79	]	=	0733		BaoXiang_JLBCBTBOX_Rad	[	79	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	79	]	=	1
	BaoXiang_JLBCBTBOX	[	80	]	=	0738		BaoXiang_JLBCBTBOX_Rad	[	80	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	80	]	=	1
	BaoXiang_JLBCBTBOX	[	81	]	=	0741		BaoXiang_JLBCBTBOX_Rad	[	81	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	81	]	=	1
	BaoXiang_JLBCBTBOX	[	82	]	=	0742		BaoXiang_JLBCBTBOX_Rad	[	82	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	82	]	=	1
	BaoXiang_JLBCBTBOX	[	83	]	=	0744		BaoXiang_JLBCBTBOX_Rad	[	83	]	=	50 		BaoXiang_JLBCBTBOX_Count	[	83	]	=	1
	BaoXiang_JLBCBTBOX	[	84	]	=	0763		BaoXiang_JLBCBTBOX_Rad	[	84	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	84	]	=	1
	BaoXiang_JLBCBTBOX	[	85	]	=	0770		BaoXiang_JLBCBTBOX_Rad	[	85	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	85	]	=	1
	BaoXiang_JLBCBTBOX	[	86	]	=	0777		BaoXiang_JLBCBTBOX_Rad	[	86	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	86	]	=	1
	BaoXiang_JLBCBTBOX	[	87	]	=	0781		BaoXiang_JLBCBTBOX_Rad	[	87	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	87	]	=	1
	BaoXiang_JLBCBTBOX	[	88	]	=	0785		BaoXiang_JLBCBTBOX_Rad	[	88	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	88	]	=	1
	BaoXiang_JLBCBTBOX	[	89	]	=	0789		BaoXiang_JLBCBTBOX_Rad	[	89	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	89	]	=	1
	BaoXiang_JLBCBTBOX	[	90	]	=	0799		BaoXiang_JLBCBTBOX_Rad	[	90	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	90	]	=	1
	BaoXiang_JLBCBTBOX	[	91	]	=	0803		BaoXiang_JLBCBTBOX_Rad	[	91	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	91	]	=	1
	BaoXiang_JLBCBTBOX	[	92	]	=	0230		BaoXiang_JLBCBTBOX_Rad	[	92	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	92	]	=	1
	BaoXiang_JLBCBTBOX	[	93	]	=	0304		BaoXiang_JLBCBTBOX_Rad	[	93	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	93	]	=	1
	BaoXiang_JLBCBTBOX	[	94	]	=	0317		BaoXiang_JLBCBTBOX_Rad	[	94	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	94	]	=	1
	BaoXiang_JLBCBTBOX	[	95	]	=	0344		BaoXiang_JLBCBTBOX_Rad	[	95	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	95	]	=	1
	BaoXiang_JLBCBTBOX	[	96	]	=	0358		BaoXiang_JLBCBTBOX_Rad	[	96	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	96	]	=	1
	BaoXiang_JLBCBTBOX	[	97	]	=	0364		BaoXiang_JLBCBTBOX_Rad	[	97	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	97	]	=	1
	BaoXiang_JLBCBTBOX	[	98	]	=	0377		BaoXiang_JLBCBTBOX_Rad	[	98	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	98	]	=	1
	BaoXiang_JLBCBTBOX	[	99	]	=	0393		BaoXiang_JLBCBTBOX_Rad	[	99	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	99	]	=	1
	BaoXiang_JLBCBTBOX	[	100	]	=	0394		BaoXiang_JLBCBTBOX_Rad	[	100	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	100	]	=	1
	BaoXiang_JLBCBTBOX	[	101	]	=	0480		BaoXiang_JLBCBTBOX_Rad	[	101	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	101	]	=	1
	BaoXiang_JLBCBTBOX	[	102	]	=	0493		BaoXiang_JLBCBTBOX_Rad	[	102	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	102	]	=	1
	BaoXiang_JLBCBTBOX	[	103	]	=	0520		BaoXiang_JLBCBTBOX_Rad	[	103	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	103	]	=	1
	BaoXiang_JLBCBTBOX	[	104	]	=	0534		BaoXiang_JLBCBTBOX_Rad	[	104	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	104	]	=	1
	BaoXiang_JLBCBTBOX	[	105	]	=	0540		BaoXiang_JLBCBTBOX_Rad	[	105	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	105	]	=	1
	BaoXiang_JLBCBTBOX	[	106	]	=	0553		BaoXiang_JLBCBTBOX_Rad	[	106	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	106	]	=	1
	BaoXiang_JLBCBTBOX	[	107	]	=	0569		BaoXiang_JLBCBTBOX_Rad	[	107	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	107	]	=	1
	BaoXiang_JLBCBTBOX	[	108	]	=	0570		BaoXiang_JLBCBTBOX_Rad	[	108	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	108	]	=	1
	BaoXiang_JLBCBTBOX	[	109	]	=	0656		BaoXiang_JLBCBTBOX_Rad	[	109	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	109	]	=	1
	BaoXiang_JLBCBTBOX	[	110	]	=	0669		BaoXiang_JLBCBTBOX_Rad	[	110	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	110	]	=	1
	BaoXiang_JLBCBTBOX	[	111	]	=	0696		BaoXiang_JLBCBTBOX_Rad	[	111	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	111	]	=	1
	BaoXiang_JLBCBTBOX	[	112	]	=	0710		BaoXiang_JLBCBTBOX_Rad	[	112	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	112	]	=	1
	BaoXiang_JLBCBTBOX	[	113	]	=	0716		BaoXiang_JLBCBTBOX_Rad	[	113	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	113	]	=	1
	BaoXiang_JLBCBTBOX	[	114	]	=	0729		BaoXiang_JLBCBTBOX_Rad	[	114	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	114	]	=	1
	BaoXiang_JLBCBTBOX	[	115	]	=	0745		BaoXiang_JLBCBTBOX_Rad	[	115	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	115	]	=	1
	BaoXiang_JLBCBTBOX	[	116	]	=	0746		BaoXiang_JLBCBTBOX_Rad	[	116	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	116	]	=	1
	BaoXiang_JLBCBTBOX	[	117	]	=	3425		BaoXiang_JLBCBTBOX_Rad	[	117	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	117	]	=	1
	BaoXiang_JLBCBTBOX	[	118	]	=	3426		BaoXiang_JLBCBTBOX_Rad	[	118	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	118	]	=	1
	BaoXiang_JLBCBTBOX	[	119	]	=	3427		BaoXiang_JLBCBTBOX_Rad	[	119	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	119	]	=	1
	BaoXiang_JLBCBTBOX	[	120	]	=	3428		BaoXiang_JLBCBTBOX_Rad	[	120	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	120	]	=	1
	BaoXiang_JLBCBTBOX	[	121	]	=	3429		BaoXiang_JLBCBTBOX_Rad	[	121	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	121	]	=	1
	BaoXiang_JLBCBTBOX	[	122	]	=	3430		BaoXiang_JLBCBTBOX_Rad	[	122	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	122	]	=	1
	BaoXiang_JLBCBTBOX	[	123	]	=	3431		BaoXiang_JLBCBTBOX_Rad	[	123	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	123	]	=	1
	BaoXiang_JLBCBTBOX	[	124	]	=	3432		BaoXiang_JLBCBTBOX_Rad	[	124	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	124	]	=	1
	BaoXiang_JLBCBTBOX	[	125	]	=	3433		BaoXiang_JLBCBTBOX_Rad	[	125	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	125	]	=	1
	BaoXiang_JLBCBTBOX	[	126	]	=	3138		BaoXiang_JLBCBTBOX_Rad	[	126	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	126	]	=	1
	BaoXiang_JLBCBTBOX	[	127	]	=	3139		BaoXiang_JLBCBTBOX_Rad	[	127	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	127	]	=	1
	BaoXiang_JLBCBTBOX	[	128	]	=	3136		BaoXiang_JLBCBTBOX_Rad	[	128	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	128	]	=	1
	BaoXiang_JLBCBTBOX	[	129	]	=	3140		BaoXiang_JLBCBTBOX_Rad	[	129	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	129	]	=	1
	BaoXiang_JLBCBTBOX	[	130	]	=	3123		BaoXiang_JLBCBTBOX_Rad	[	130	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	130	]	=	1
	BaoXiang_JLBCBTBOX	[	131	]	=	3125		BaoXiang_JLBCBTBOX_Rad	[	131	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	131	]	=	1
	BaoXiang_JLBCBTBOX	[	132	]	=	3122		BaoXiang_JLBCBTBOX_Rad	[	132	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	132	]	=	1
	BaoXiang_JLBCBTBOX	[	133	]	=	3126		BaoXiang_JLBCBTBOX_Rad	[	133	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	133	]	=	1
	BaoXiang_JLBCBTBOX	[	134	]	=	3127		BaoXiang_JLBCBTBOX_Rad	[	134	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	134	]	=	1
	BaoXiang_JLBCBTBOX	[	135	]	=	3138		BaoXiang_JLBCBTBOX_Rad	[	135	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	135	]	=	1
	BaoXiang_JLBCBTBOX	[	136	]	=	3135		BaoXiang_JLBCBTBOX_Rad	[	136	]	=	30 		BaoXiang_JLBCBTBOX_Count	[	136	]	=	1
	BaoXiang_JLBCBTBOX	[	137	]	=	3828		BaoXiang_JLBCBTBOX_Rad	[	137	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	137	]	=	1
	BaoXiang_JLBCBTBOX	[	138	]	=	3829		BaoXiang_JLBCBTBOX_Rad	[	138	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	138	]	=	1
	BaoXiang_JLBCBTBOX	[	139	]	=	3830		BaoXiang_JLBCBTBOX_Rad	[	139	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	139	]	=	1
	BaoXiang_JLBCBTBOX	[	140	]	=	3831		BaoXiang_JLBCBTBOX_Rad	[	140	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	140	]	=	1
	BaoXiang_JLBCBTBOX	[	141	]	=	3832		BaoXiang_JLBCBTBOX_Rad	[	141	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	141	]	=	1
	BaoXiang_JLBCBTBOX	[	142	]	=	3833		BaoXiang_JLBCBTBOX_Rad	[	142	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	142	]	=	1
	BaoXiang_JLBCBTBOX	[	143	]	=	3834		BaoXiang_JLBCBTBOX_Rad	[	143	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	143	]	=	1
	BaoXiang_JLBCBTBOX	[	144	]	=	3835		BaoXiang_JLBCBTBOX_Rad	[	144	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	144	]	=	1
	BaoXiang_JLBCBTBOX	[	145	]	=	3836		BaoXiang_JLBCBTBOX_Rad	[	145	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	145	]	=	1
	BaoXiang_JLBCBTBOX	[	146	]	=	3837		BaoXiang_JLBCBTBOX_Rad	[	146	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	146	]	=	1
	BaoXiang_JLBCBTBOX	[	147	]	=	3838		BaoXiang_JLBCBTBOX_Rad	[	147	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	147	]	=	1
	BaoXiang_JLBCBTBOX	[	148	]	=	3839		BaoXiang_JLBCBTBOX_Rad	[	148	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	148	]	=	1
	BaoXiang_JLBCBTBOX	[	149	]	=	3840		BaoXiang_JLBCBTBOX_Rad	[	149	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	149	]	=	1
	BaoXiang_JLBCBTBOX	[	150	]	=	3841		BaoXiang_JLBCBTBOX_Rad	[	150	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	150	]	=	1
	BaoXiang_JLBCBTBOX	[	151	]	=	3842		BaoXiang_JLBCBTBOX_Rad	[	151	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	151	]	=	1
	BaoXiang_JLBCBTBOX	[	152	]	=	3843		BaoXiang_JLBCBTBOX_Rad	[	152	]	=	25 		BaoXiang_JLBCBTBOX_Count	[	152	]	=	1
	BaoXiang_JLBCBTBOX	[	153	]	=	0899		BaoXiang_JLBCBTBOX_Rad	[	153	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	153	]	=	1
	BaoXiang_JLBCBTBOX	[	154	]	=	0900		BaoXiang_JLBCBTBOX_Rad	[	154	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	154	]	=	1
	BaoXiang_JLBCBTBOX	[	155	]	=	0901		BaoXiang_JLBCBTBOX_Rad	[	155	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	155	]	=	1
	BaoXiang_JLBCBTBOX	[	156	]	=	0902		BaoXiang_JLBCBTBOX_Rad	[	156	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	156	]	=	1
	BaoXiang_JLBCBTBOX	[	157	]	=	0903		BaoXiang_JLBCBTBOX_Rad	[	157	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	157	]	=	1
	BaoXiang_JLBCBTBOX	[	158	]	=	3846		BaoXiang_JLBCBTBOX_Rad	[	158	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	158	]	=	1
	BaoXiang_JLBCBTBOX	[	159	]	=	3462		BaoXiang_JLBCBTBOX_Rad	[	159	]	=	20 		BaoXiang_JLBCBTBOX_Count	[	159	]	=	1
	BaoXiang_JLBCBTBOX	[	160	]	=	0860		BaoXiang_JLBCBTBOX_Rad	[	160	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	160	]	=	1
	BaoXiang_JLBCBTBOX	[	161	]	=	0861		BaoXiang_JLBCBTBOX_Rad	[	161	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	161	]	=	1
	BaoXiang_JLBCBTBOX	[	162	]	=	0862		BaoXiang_JLBCBTBOX_Rad	[	162	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	162	]	=	1
	BaoXiang_JLBCBTBOX	[	163	]	=	0863		BaoXiang_JLBCBTBOX_Rad	[	163	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	163	]	=	1
	BaoXiang_JLBCBTBOX	[	164	]	=	3463		BaoXiang_JLBCBTBOX_Rad	[	164	]	=	20 		BaoXiang_JLBCBTBOX_Count	[	164	]	=	1
	BaoXiang_JLBCBTBOX	[	165	]	=	3844		BaoXiang_JLBCBTBOX_Rad	[	165	]	=	10 		BaoXiang_JLBCBTBOX_Count	[	165	]	=	1
	BaoXiang_JLBCBTBOX	[	166	]	=	3845		BaoXiang_JLBCBTBOX_Rad	[	166	]	=	10 		BaoXiang_JLBCBTBOX_Count	[	166	]	=	1
	BaoXiang_JLBCBTBOX	[	167	]	=	0878		BaoXiang_JLBCBTBOX_Rad	[	167	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	167	]	=	1
	BaoXiang_JLBCBTBOX	[	168	]	=	0879		BaoXiang_JLBCBTBOX_Rad	[	168	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	168	]	=	1
	BaoXiang_JLBCBTBOX	[	169	]	=	0880		BaoXiang_JLBCBTBOX_Rad	[	169	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	169	]	=	1
	BaoXiang_JLBCBTBOX	[	170	]	=	0881		BaoXiang_JLBCBTBOX_Rad	[	170	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	170	]	=	1
	BaoXiang_JLBCBTBOX	[	171	]	=	0882		BaoXiang_JLBCBTBOX_Rad	[	171	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	171	]	=	1
	BaoXiang_JLBCBTBOX	[	172	]	=	0883		BaoXiang_JLBCBTBOX_Rad	[	172	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	172	]	=	1
	BaoXiang_JLBCBTBOX	[	173	]	=	0884		BaoXiang_JLBCBTBOX_Rad	[	173	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	173	]	=	1
	BaoXiang_JLBCBTBOX	[	174	]	=	0885		BaoXiang_JLBCBTBOX_Rad	[	174	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	174	]	=	1
	BaoXiang_JLBCBTBOX	[	175	]	=	0887		BaoXiang_JLBCBTBOX_Rad	[	175	]	=	1 		BaoXiang_JLBCBTBOX_Count	[	175	]	=	1
	BaoXiang_JLBCBTBOX	[	176	]	=	0893		BaoXiang_JLBCBTBOX_Rad	[	176	]	=	5 		BaoXiang_JLBCBTBOX_Count	[	176	]	=	1
	BaoXiang_JLBCBTBOX	[	177	]	=	0894		BaoXiang_JLBCBTBOX_Rad	[	177	]	=	5 		BaoXiang_JLBCBTBOX_Count	[	177	]	=	1
	BaoXiang_JLBCBTBOX	[	178	]	=	0895		BaoXiang_JLBCBTBOX_Rad	[	178	]	=	5 		BaoXiang_JLBCBTBOX_Count	[	178	]	=	1
	BaoXiang_JLBCBTBOX	[	179	]	=	0896		BaoXiang_JLBCBTBOX_Rad	[	179	]	=	5 		BaoXiang_JLBCBTBOX_Count	[	179	]	=	1
	BaoXiang_JLBCBTBOX	[	180	]	=	0897		BaoXiang_JLBCBTBOX_Rad	[	180	]	=	5 		BaoXiang_JLBCBTBOX_Count	[	180	]	=	1
	BaoXiang_JLBCBTBOX	[	181	]	=	0453		BaoXiang_JLBCBTBOX_Rad	[	181	]	=	100 		BaoXiang_JLBCBTBOX_Count	[	181	]	=	1
	BaoXiang_JLBCBTBOX	[	182	]	=	0455		BaoXiang_JLBCBTBOX_Rad	[	182	]	=	100 		BaoXiang_JLBCBTBOX_Count	[	182	]	=	1
	BaoXiang_JLBCBTBOX	[	183	]	=	0938		BaoXiang_JLBCBTBOX_Rad	[	183	]	=	100 		BaoXiang_JLBCBTBOX_Count	[	183	]	=	1


	BaoXiang_98BOX_Qua	=	5	 			BaoXiang_98BOX_Mxcount	=	22										
	BaoXiang_98BOX	=	{}					BaoXiang_98BOX_Rad	=	{}					BaoXiang_98BOX_Count	=	{}			
	BaoXiang_98BOX	[	1	]	=	2440		BaoXiang_98BOX_Rad	[	1	]	=	100 		BaoXiang_98BOX_Count	[	1	]	=	30
	BaoXiang_98BOX	[	2	]	=	3098		BaoXiang_98BOX_Rad	[	2	]	=	100 		BaoXiang_98BOX_Count	[	2	]	=	6
	BaoXiang_98BOX	[	3	]	=	3096		BaoXiang_98BOX_Rad	[	3	]	=	50 		BaoXiang_98BOX_Count	[	3	]	=	3
	BaoXiang_98BOX	[	4	]	=	0227		BaoXiang_98BOX_Rad	[	4	]	=	50 		BaoXiang_98BOX_Count	[	4	]	=	3
	BaoXiang_98BOX	[	5	]	=	3105		BaoXiang_98BOX_Rad	[	5	]	=	100 		BaoXiang_98BOX_Count	[	5	]	=	2
	BaoXiang_98BOX	[	6	]	=	3107		BaoXiang_98BOX_Rad	[	6	]	=	100 		BaoXiang_98BOX_Count	[	6	]	=	2
	BaoXiang_98BOX	[	7	]	=	0563		BaoXiang_98BOX_Rad	[	7	]	=	100 		BaoXiang_98BOX_Count	[	7	]	=	2
	BaoXiang_98BOX	[	8	]	=	0583		BaoXiang_98BOX_Rad	[	8	]	=	100 		BaoXiang_98BOX_Count	[	8	]	=	2
	BaoXiang_98BOX	[	9	]	=	2445		BaoXiang_98BOX_Rad	[	9	]	=	100 		BaoXiang_98BOX_Count	[	9	]	=	2
	BaoXiang_98BOX	[	10	]	=	0455		BaoXiang_98BOX_Rad	[	10	]	=	100 		BaoXiang_98BOX_Count	[	10	]	=	2
	BaoXiang_98BOX	[	11	]	=	3094		BaoXiang_98BOX_Rad	[	11	]	=	80 		BaoXiang_98BOX_Count	[	11	]	=	2
	BaoXiang_98BOX	[	12	]	=	0849		BaoXiang_98BOX_Rad	[	12	]	=	70 		BaoXiang_98BOX_Count	[	12	]	=	1
	BaoXiang_98BOX	[	13	]	=	3074		BaoXiang_98BOX_Rad	[	13	]	=	20 		BaoXiang_98BOX_Count	[	13	]	=	1
	BaoXiang_98BOX	[	14	]	=	3075		BaoXiang_98BOX_Rad	[	14	]	=	10 		BaoXiang_98BOX_Count	[	14	]	=	1
	BaoXiang_98BOX	[	15	]	=	0937		BaoXiang_98BOX_Rad	[	15	]	=	10 		BaoXiang_98BOX_Count	[	15	]	=	1
	BaoXiang_98BOX	[	16	]	=	3885		BaoXiang_98BOX_Rad	[	16	]	=	5 		BaoXiang_98BOX_Count	[	16	]	=	1
	BaoXiang_98BOX	[	17	]	=	0680		BaoXiang_98BOX_Rad	[	17	]	=	5 		BaoXiang_98BOX_Count	[	17	]	=	1
	BaoXiang_98BOX	[	18	]	=	0938		BaoXiang_98BOX_Rad	[	18	]	=	1 		BaoXiang_98BOX_Count	[	18	]	=	1
	BaoXiang_98BOX	[	19	]	=	2488		BaoXiang_98BOX_Rad	[	19	]	=	2 		BaoXiang_98BOX_Count	[	19	]	=	1
	BaoXiang_98BOX	[	20	]	=	2489		BaoXiang_98BOX_Rad	[	20	]	=	2 		BaoXiang_98BOX_Count	[	20	]	=	1
	BaoXiang_98BOX	[	21	]	=	2490		BaoXiang_98BOX_Rad	[	21	]	=	2 		BaoXiang_98BOX_Count	[	21	]	=	1
	BaoXiang_98BOX	[	22	]	=	2436		BaoXiang_98BOX_Rad	[	22	]	=	2 		BaoXiang_98BOX_Count	[	22	]	=	1
																																																															
																																											
	BaoXiang_jsyla_Qua	=	24	 			BaoXiang_jsyla_Mxcount	=	19												
	BaoXiang_jsyla	=	{}					BaoXiang_jsyla_Rad	=	{}					BaoXiang_jsyla_Count	=	{}					
	BaoXiang_jsyla	[	1	]	=	0114		BaoXiang_jsyla_Rad	[	1	]	=	1 		BaoXiang_jsyla_Count	[	1	]	=	1	--	游龙
	BaoXiang_jsyla	[	2	]	=	3302		BaoXiang_jsyla_Rad	[	2	]	=	30 		BaoXiang_jsyla_Count	[	2	]	=	1	--	游龙宝箱24型
	BaoXiang_jsyla	[	3	]	=	0007		BaoXiang_jsyla_Rad	[	3	]	=	30 		BaoXiang_jsyla_Count	[	3	]	=	1	--	圣剑
	BaoXiang_jsyla	[	4	]	=	1394		BaoXiang_jsyla_Rad	[	4	]	=	30 		BaoXiang_jsyla_Count	[	4	]	=	1	--	黎明剑
	BaoXiang_jsyla	[	5	]	=	0006		BaoXiang_jsyla_Rad	[	5	]	=	180 		BaoXiang_jsyla_Count	[	5	]	=	1	--	斩龙剑
	BaoXiang_jsyla	[	6	]	=	1393		BaoXiang_jsyla_Rad	[	6	]	=	180 		BaoXiang_jsyla_Count	[	6	]	=	1	--	龙鸣剑
	BaoXiang_jsyla	[	7	]	=	3801		BaoXiang_jsyla_Rad	[	7	]	=	180 		BaoXiang_jsyla_Count	[	7	]	=	1	--	麒麟剑
	BaoXiang_jsyla	[	8	]	=	4212		BaoXiang_jsyla_Rad	[	8	]	=	180 		BaoXiang_jsyla_Count	[	8	]	=	1	--	火痕
	BaoXiang_jsyla	[	9	]	=	4213		BaoXiang_jsyla_Rad	[	9	]	=	180 		BaoXiang_jsyla_Count	[	9	]	=	1	--	追电
	BaoXiang_jsyla	[	10	]	=	0003		BaoXiang_jsyla_Rad	[	10	]	=	9000 		BaoXiang_jsyla_Count	[	10	]	=	1	--	西洋剑
	BaoXiang_jsyla	[	11	]	=	0004		BaoXiang_jsyla_Rad	[	11	]	=	9000 		BaoXiang_jsyla_Count	[	11	]	=	1	--	蛇剑
	BaoXiang_jsyla	[	12	]	=	0005		BaoXiang_jsyla_Rad	[	12	]	=	9000 		BaoXiang_jsyla_Count	[	12	]	=	1	--	精钢剑
	BaoXiang_jsyla	[	13	]	=	1390		BaoXiang_jsyla_Rad	[	13	]	=	9000 		BaoXiang_jsyla_Count	[	13	]	=	1	--	细刺剑
	BaoXiang_jsyla	[	14	]	=	1391		BaoXiang_jsyla_Rad	[	14	]	=	9000 		BaoXiang_jsyla_Count	[	14	]	=	1	--	碧光刺刃
	BaoXiang_jsyla	[	15	]	=	1392		BaoXiang_jsyla_Rad	[	15	]	=	9000 		BaoXiang_jsyla_Count	[	15	]	=	1	--	钢制佩剑
	BaoXiang_jsyla	[	16	]	=	1397		BaoXiang_jsyla_Rad	[	16	]	=	9000 		BaoXiang_jsyla_Count	[	16	]	=	1	--	刺杀剑
	BaoXiang_jsyla	[	17	]	=	1398		BaoXiang_jsyla_Rad	[	17	]	=	9000 		BaoXiang_jsyla_Count	[	17	]	=	1	--	异族剑
	BaoXiang_jsyla	[	18	]	=	1399		BaoXiang_jsyla_Rad	[	18	]	=	9000 		BaoXiang_jsyla_Count	[	18	]	=	1	--	琥珀剑
	BaoXiang_jsyla	[	19	]	=	0022		BaoXiang_jsyla_Rad	[	19	]	=	9000 		BaoXiang_jsyla_Count	[	19	]	=	1	--	弯刃剑
																						
																						
	BaoXiang_jsylb_Qua	=	23	 				BaoXiang_jsylb_Mxcount	=	19												
	BaoXiang_jsylb	=	{}					BaoXiang_jsylb_Rad	=	{}					BaoXiang_jsylb_Count	=	{}					
	BaoXiang_jsylb	[	1	]	=	0114		BaoXiang_jsylb_Rad	[	1	]	=	5 		BaoXiang_jsylb_Count	[	1	]	=	1	--	游龙
	BaoXiang_jsylb	[	2	]	=	3303		BaoXiang_jsylb_Rad	[	2	]	=	15 		BaoXiang_jsylb_Count	[	2	]	=	1	--	游龙宝箱23型
	BaoXiang_jsylb	[	3	]	=	0007		BaoXiang_jsylb_Rad	[	3	]	=	15 		BaoXiang_jsylb_Count	[	3	]	=	1	--	圣剑
	BaoXiang_jsylb	[	4	]	=	1394		BaoXiang_jsylb_Rad	[	4	]	=	15 		BaoXiang_jsylb_Count	[	4	]	=	1	--	黎明剑
	BaoXiang_jsylb	[	5	]	=	0006		BaoXiang_jsylb_Rad	[	5	]	=	150 		BaoXiang_jsylb_Count	[	5	]	=	1	--	斩龙剑
	BaoXiang_jsylb	[	6	]	=	1393		BaoXiang_jsylb_Rad	[	6	]	=	150 		BaoXiang_jsylb_Count	[	6	]	=	1	--	龙鸣剑
	BaoXiang_jsylb	[	7	]	=	3801		BaoXiang_jsylb_Rad	[	7	]	=	150 		BaoXiang_jsylb_Count	[	7	]	=	1	--	麒麟剑
	BaoXiang_jsylb	[	8	]	=	4212		BaoXiang_jsylb_Rad	[	8	]	=	150 		BaoXiang_jsylb_Count	[	8	]	=	1	--	火痕
	BaoXiang_jsylb	[	9	]	=	4213		BaoXiang_jsylb_Rad	[	9	]	=	150 		BaoXiang_jsylb_Count	[	9	]	=	1	--	追电
	BaoXiang_jsylb	[	10	]	=	0003		BaoXiang_jsylb_Rad	[	10	]	=	9200 		BaoXiang_jsylb_Count	[	10	]	=	1	--	西洋剑
	BaoXiang_jsylb	[	11	]	=	0004		BaoXiang_jsylb_Rad	[	11	]	=	9200 		BaoXiang_jsylb_Count	[	11	]	=	1	--	蛇剑
	BaoXiang_jsylb	[	12	]	=	0005		BaoXiang_jsylb_Rad	[	12	]	=	9200 		BaoXiang_jsylb_Count	[	12	]	=	1	--	精钢剑
	BaoXiang_jsylb	[	13	]	=	1390		BaoXiang_jsylb_Rad	[	13	]	=	9200 		BaoXiang_jsylb_Count	[	13	]	=	1	--	细刺剑
	BaoXiang_jsylb	[	14	]	=	1391		BaoXiang_jsylb_Rad	[	14	]	=	9200 		BaoXiang_jsylb_Count	[	14	]	=	1	--	碧光刺刃
	BaoXiang_jsylb	[	15	]	=	1392		BaoXiang_jsylb_Rad	[	15	]	=	9200 		BaoXiang_jsylb_Count	[	15	]	=	1	--	钢制佩剑
	BaoXiang_jsylb	[	16	]	=	1397		BaoXiang_jsylb_Rad	[	16	]	=	9200 		BaoXiang_jsylb_Count	[	16	]	=	1	--	刺杀剑
	BaoXiang_jsylb	[	17	]	=	1398		BaoXiang_jsylb_Rad	[	17	]	=	9200 		BaoXiang_jsylb_Count	[	17	]	=	1	--	异族剑
	BaoXiang_jsylb	[	18	]	=	1399		BaoXiang_jsylb_Rad	[	18	]	=	9200 		BaoXiang_jsylb_Count	[	18	]	=	1	--	琥珀剑
	BaoXiang_jsylb	[	19	]	=	0022		BaoXiang_jsylb_Rad	[	19	]	=	9200 		BaoXiang_jsylb_Count	[	19	]	=	1	--	弯刃剑

																					
	BaoXiang_jsmzlra_Qua	=	24	 				BaoXiang_jsmzlra_Mxcount	=	18												
	BaoXiang_jsmzlra	=	{}					BaoXiang_jsmzlra_Rad	=	{}					BaoXiang_jsmzlra_Count	=	{}					
	BaoXiang_jsmzlra	[	1	]	=	1895		BaoXiang_jsmzlra_Rad	[	1	]	=	30 		BaoXiang_jsmzlra_Count	[	1	]	=	1	--	污泥封印的咒纹刺剑
	BaoXiang_jsmzlra	[	2	]	=	1896		BaoXiang_jsmzlra_Rad	[	2	]	=	20 		BaoXiang_jsmzlra_Count	[	2	]	=	1	--	烈焰封印的幻灵之舞
	BaoXiang_jsmzlra	[	3	]	=	1897		BaoXiang_jsmzlra_Rad	[	3	]	=	1 		BaoXiang_jsmzlra_Count	[	3	]	=	1	--	寒冰封印的迷之利刃
	BaoXiang_jsmzlra	[	4	]	=	0006		BaoXiang_jsmzlra_Rad	[	4	]	=	200 		BaoXiang_jsmzlra_Count	[	4	]	=	1	--	斩龙剑
	BaoXiang_jsmzlra	[	5	]	=	1393		BaoXiang_jsmzlra_Rad	[	5	]	=	200 		BaoXiang_jsmzlra_Count	[	5	]	=	1	--	龙鸣剑
	BaoXiang_jsmzlra	[	6	]	=	3801		BaoXiang_jsmzlra_Rad	[	6	]	=	200 		BaoXiang_jsmzlra_Count	[	6	]	=	1	--	麒麟剑
	BaoXiang_jsmzlra	[	7	]	=	4212		BaoXiang_jsmzlra_Rad	[	7	]	=	200 		BaoXiang_jsmzlra_Count	[	7	]	=	1	--	火痕
	BaoXiang_jsmzlra	[	8	]	=	4213		BaoXiang_jsmzlra_Rad	[	8	]	=	200 		BaoXiang_jsmzlra_Count	[	8	]	=	1	--	追电
	BaoXiang_jsmzlra	[	9	]	=	0003		BaoXiang_jsmzlra_Rad	[	9	]	=	9000		BaoXiang_jsmzlra_Count	[	9	]	=	1	--	西洋剑
	BaoXiang_jsmzlra	[	10	]	=	0004		BaoXiang_jsmzlra_Rad	[	10	]	=	9000 		BaoXiang_jsmzlra_Count	[	10	]	=	1	--	蛇剑
	BaoXiang_jsmzlra	[	11	]	=	0005		BaoXiang_jsmzlra_Rad	[	11	]	=	9000 		BaoXiang_jsmzlra_Count	[	11	]	=	1	--	精钢剑
	BaoXiang_jsmzlra	[	12	]	=	1390		BaoXiang_jsmzlra_Rad	[	12	]	=	9000 		BaoXiang_jsmzlra_Count	[	12	]	=	1	--	细刺剑
	BaoXiang_jsmzlra	[	13	]	=	1391		BaoXiang_jsmzlra_Rad	[	13	]	=	9000 		BaoXiang_jsmzlra_Count	[	13	]	=	1	--	碧光刺刃
	BaoXiang_jsmzlra	[	14	]	=	1392		BaoXiang_jsmzlra_Rad	[	14	]	=	9000 		BaoXiang_jsmzlra_Count	[	14	]	=	1	--	钢制佩剑
	BaoXiang_jsmzlra	[	15	]	=	1397		BaoXiang_jsmzlra_Rad	[	15	]	=	9000 		BaoXiang_jsmzlra_Count	[	15	]	=	1	--	刺杀剑
	BaoXiang_jsmzlra	[	16	]	=	1398		BaoXiang_jsmzlra_Rad	[	16	]	=	9000 		BaoXiang_jsmzlra_Count	[	16	]	=	1	--	异族剑
	BaoXiang_jsmzlra	[	17	]	=	1399		BaoXiang_jsmzlra_Rad	[	17	]	=	9000		BaoXiang_jsmzlra_Count	[	17	]	=	1	--	琥珀剑
	BaoXiang_jsmzlra	[	18	]	=	0022		BaoXiang_jsmzlra_Rad	[	18	]	=	9000 		BaoXiang_jsmzlra_Count	[	18	]	=	1	--	弯刃剑

																						
	BaoXiang_jsmzlrb_Qua	=	23	 				BaoXiang_jsmzlrb_Mxcount	=	18												
	BaoXiang_jsmzlrb	=	{}					BaoXiang_jsmzlrb_Rad	=	{}					BaoXiang_jsmzlrb_Count	=	{}					
	BaoXiang_jsmzlrb	[	1	]	=	1895		BaoXiang_jsmzlrb_Rad	[	1	]	=	30 		BaoXiang_jsmzlrb_Count	[	1	]	=	1	--	污泥封印的咒纹刺剑
	BaoXiang_jsmzlrb	[	2	]	=	1896		BaoXiang_jsmzlrb_Rad	[	2	]	=	10 		BaoXiang_jsmzlrb_Count	[	2	]	=	1	--	烈焰封印的幻灵之舞
	BaoXiang_jsmzlrb	[	3	]	=	1897		BaoXiang_jsmzlrb_Rad	[	3	]	=	5 		BaoXiang_jsmzlrb_Count	[	3	]	=	1	--	寒冰封印的迷之利刃
	BaoXiang_jsmzlrb	[	4	]	=	0006		BaoXiang_jsmzlrb_Rad	[	4	]	=	175 		BaoXiang_jsmzlrb_Count	[	4	]	=	1	--	斩龙剑
	BaoXiang_jsmzlrb	[	5	]	=	1393		BaoXiang_jsmzlrb_Rad	[	5	]	=	175 		BaoXiang_jsmzlrb_Count	[	5	]	=	1	--	龙鸣剑
	BaoXiang_jsmzlrb	[	6	]	=	3801		BaoXiang_jsmzlrb_Rad	[	6	]	=	175 		BaoXiang_jsmzlrb_Count	[	6	]	=	1	--	麒麟剑
	BaoXiang_jsmzlrb	[	7	]	=	4212		BaoXiang_jsmzlrb_Rad	[	7	]	=	175 		BaoXiang_jsmzlrb_Count	[	7	]	=	1	--	火痕
	BaoXiang_jsmzlrb	[	8	]	=	4213		BaoXiang_jsmzlrb_Rad	[	8	]	=	175 		BaoXiang_jsmzlrb_Count	[	8	]	=	1	--	追电
	BaoXiang_jsmzlrb	[	9	]	=	0003		BaoXiang_jsmzlrb_Rad	[	9	]	=	9100 		BaoXiang_jsmzlrb_Count	[	9	]	=	1	--	西洋剑
	BaoXiang_jsmzlrb	[	10	]	=	0004		BaoXiang_jsmzlrb_Rad	[	10	]	=	9100 		BaoXiang_jsmzlrb_Count	[	10	]	=	1	--	蛇剑
	BaoXiang_jsmzlrb	[	11	]	=	0005		BaoXiang_jsmzlrb_Rad	[	11	]	=	9100 		BaoXiang_jsmzlrb_Count	[	11	]	=	1	--	精钢剑
	BaoXiang_jsmzlrb	[	12	]	=	1390		BaoXiang_jsmzlrb_Rad	[	12	]	=	9100 		BaoXiang_jsmzlrb_Count	[	12	]	=	1	--	细刺剑
	BaoXiang_jsmzlrb	[	13	]	=	1391		BaoXiang_jsmzlrb_Rad	[	13	]	=	9100 		BaoXiang_jsmzlrb_Count	[	13	]	=	1	--	碧光刺刃
	BaoXiang_jsmzlrb	[	14	]	=	1392		BaoXiang_jsmzlrb_Rad	[	14	]	=	9100 		BaoXiang_jsmzlrb_Count	[	14	]	=	1	--	钢制佩剑
	BaoXiang_jsmzlrb	[	15	]	=	1397		BaoXiang_jsmzlrb_Rad	[	15	]	=	9100 		BaoXiang_jsmzlrb_Count	[	15	]	=	1	--	刺杀剑
	BaoXiang_jsmzlrb	[	16	]	=	1398		BaoXiang_jsmzlrb_Rad	[	16	]	=	9100 		BaoXiang_jsmzlrb_Count	[	16	]	=	1	--	异族剑
	BaoXiang_jsmzlrb	[	17	]	=	1399		BaoXiang_jsmzlrb_Rad	[	17	]	=	9100 		BaoXiang_jsmzlrb_Count	[	17	]	=	1	--	琥珀剑
	BaoXiang_jsmzlrb	[	18	]	=	0022		BaoXiang_jsmzlrb_Rad	[	18	]	=	9100 		BaoXiang_jsmzlrb_Count	[	18	]	=	1	--	弯刃剑


																						
	BaoXiang_jsjqa_Qua	=	24	 			BaoXiang_jsjqa_Mxcount	=	17												
	BaoXiang_jsjqa	=	{}					BaoXiang_jsjqa_Rad	=	{}					BaoXiang_jsjqa_Count	=	{}					
	BaoXiang_jsjqa	[	1	]	=	0116		BaoXiang_jsjqa_Rad	[	1	]	=	1 		BaoXiang_jsjqa_Count	[	1	]	=	1	--	--巨阙
	BaoXiang_jsjqa	[	2	]	=	3306		BaoXiang_jsjqa_Rad	[	2	]	=	23 		BaoXiang_jsjqa_Count	[	2	]	=	1	--	巨阙宝箱24型
	BaoXiang_jsjqa	[	3	]	=	1375		BaoXiang_jsjqa_Rad	[	3	]	=	23 		BaoXiang_jsjqa_Count	[	3	]	=	1	--	兽王斧
	BaoXiang_jsjqa	[	4	]	=	1384		BaoXiang_jsjqa_Rad	[	4	]	=	23 		BaoXiang_jsjqa_Count	[	4	]	=	1	--	死亡之风
	BaoXiang_jsjqa	[	5	]	=	0018		BaoXiang_jsjqa_Rad	[	5	]	=	23 		BaoXiang_jsjqa_Count	[	5	]	=	1	--	雷刃
	BaoXiang_jsjqa	[	6	]	=	1374		BaoXiang_jsjqa_Rad	[	6	]	=	180 		BaoXiang_jsjqa_Count	[	6	]	=	1	--	苍龙剑
	BaoXiang_jsjqa	[	7	]	=	0017		BaoXiang_jsjqa_Rad	[	7	]	=	180 		BaoXiang_jsjqa_Count	[	7	]	=	1	--	龙骨剑
	BaoXiang_jsjqa	[	8	]	=	1383		BaoXiang_jsjqa_Rad	[	8	]	=	180 		BaoXiang_jsjqa_Count	[	8	]	=	1	--	龙魂剑
	BaoXiang_jsjqa	[	9	]	=	0021		BaoXiang_jsjqa_Rad	[	9	]	=	180 		BaoXiang_jsjqa_Count	[	9	]	=	1	--	冲锋剑
	BaoXiang_jsjqa	[	10	]	=	1378		BaoXiang_jsjqa_Rad	[	10	]	=	180 		BaoXiang_jsjqa_Count	[	10	]	=	1	--	火龙剑
	BaoXiang_jsjqa	[	11	]	=	0020		BaoXiang_jsjqa_Rad	[	11	]	=	1300 		BaoXiang_jsjqa_Count	[	11	]	=	1	--	战士剑
	BaoXiang_jsjqa	[	12	]	=	1372		BaoXiang_jsjqa_Rad	[	12	]	=	1300 		BaoXiang_jsjqa_Count	[	12	]	=	1	--	虔诚剑
	BaoXiang_jsjqa	[	13	]	=	1373		BaoXiang_jsjqa_Rad	[	13	]	=	1300 		BaoXiang_jsjqa_Count	[	13	]	=	1	--	骑兵佩剑
	BaoXiang_jsjqa	[	14	]	=	1377		BaoXiang_jsjqa_Rad	[	14	]	=	1300 		BaoXiang_jsjqa_Count	[	14	]	=	1	--	量产战士剑
	BaoXiang_jsjqa	[	15	]	=	1381		BaoXiang_jsjqa_Rad	[	15	]	=	1300 		BaoXiang_jsjqa_Count	[	15	]	=	1	--	圣者剑
	BaoXiang_jsjqa	[	16	]	=	1382		BaoXiang_jsjqa_Rad	[	16	]	=	1300 		BaoXiang_jsjqa_Count	[	16	]	=	1	--	退敌剑
	BaoXiang_jsjqa	[	17	]	=	1386		BaoXiang_jsjqa_Rad	[	17	]	=	1300 		BaoXiang_jsjqa_Count	[	17	]	=	1	--	强化战士剑
																						
																					
	BaoXiang_jsjqb_Qua	=	23	 			BaoXiang_jsjqb_Mxcount	=	17												
	BaoXiang_jsjqb	=	{}					BaoXiang_jsjqb_Rad	=	{}					BaoXiang_jsjqb_Count	=	{}					
	BaoXiang_jsjqb	[	1	]	=	0116		BaoXiang_jsjqb_Rad	[	1	]	=	5 		BaoXiang_jsjqb_Count	[	1	]	=	1	--	--巨阙
	BaoXiang_jsjqb	[	2	]	=	3307		BaoXiang_jsjqb_Rad	[	2	]	=	10 		BaoXiang_jsjqb_Count	[	2	]	=	1	--	巨阙宝箱24型
	BaoXiang_jsjqb	[	3	]	=	1375		BaoXiang_jsjqb_Rad	[	3	]	=	10 		BaoXiang_jsjqb_Count	[	3	]	=	1	--	兽王斧
	BaoXiang_jsjqb	[	4	]	=	1384		BaoXiang_jsjqb_Rad	[	4	]	=	10 		BaoXiang_jsjqb_Count	[	4	]	=	1	--	死亡之风
	BaoXiang_jsjqb	[	5	]	=	0018		BaoXiang_jsjqb_Rad	[	5	]	=	10 		BaoXiang_jsjqb_Count	[	5	]	=	1	--	雷刃
	BaoXiang_jsjqb	[	6	]	=	1374		BaoXiang_jsjqb_Rad	[	6	]	=	155 		BaoXiang_jsjqb_Count	[	6	]	=	1	--	苍龙剑
	BaoXiang_jsjqb	[	7	]	=	0017		BaoXiang_jsjqb_Rad	[	7	]	=	155 		BaoXiang_jsjqb_Count	[	7	]	=	1	--	龙骨剑
	BaoXiang_jsjqb	[	8	]	=	1383		BaoXiang_jsjqb_Rad	[	8	]	=	155 		BaoXiang_jsjqb_Count	[	8	]	=	1	--	龙魂剑
	BaoXiang_jsjqb	[	9	]	=	0021		BaoXiang_jsjqb_Rad	[	9	]	=	155 		BaoXiang_jsjqb_Count	[	9	]	=	1	--	冲锋剑
	BaoXiang_jsjqb	[	10	]	=	1378		BaoXiang_jsjqb_Rad	[	10	]	=	155 		BaoXiang_jsjqb_Count	[	10	]	=	1	--	火龙剑
	BaoXiang_jsjqb	[	11	]	=	0020		BaoXiang_jsjqb_Rad	[	11	]	=	14000 		BaoXiang_jsjqb_Count	[	11	]	=	1	--	战士剑
	BaoXiang_jsjqb	[	12	]	=	1372		BaoXiang_jsjqb_Rad	[	12	]	=	14000 		BaoXiang_jsjqb_Count	[	12	]	=	1	--	虔诚剑
	BaoXiang_jsjqb	[	13	]	=	1373		BaoXiang_jsjqb_Rad	[	13	]	=	14000 		BaoXiang_jsjqb_Count	[	13	]	=	1	--	骑兵佩剑
	BaoXiang_jsjqb	[	14	]	=	1377		BaoXiang_jsjqb_Rad	[	14	]	=	14000 		BaoXiang_jsjqb_Count	[	14	]	=	1	--	量产战士剑
	BaoXiang_jsjqb	[	15	]	=	1381		BaoXiang_jsjqb_Rad	[	15	]	=	14000 		BaoXiang_jsjqb_Count	[	15	]	=	1	--	圣者剑
	BaoXiang_jsjqb	[	16	]	=	1382		BaoXiang_jsjqb_Rad	[	16	]	=	14000 		BaoXiang_jsjqb_Count	[	16	]	=	1	--	退敌剑
	BaoXiang_jsjqb	[	17	]	=	1386		BaoXiang_jsjqb_Rad	[	17	]	=	14000 		BaoXiang_jsjqb_Count	[	17	]	=	1	--	强化战士剑
																						
																						
	BaoXiang_jsmzcja_Qua	=	24	 				BaoXiang_jsmzcja_Mxcount	=	19																																		
	BaoXiang_jsmzcja	=	{}					BaoXiang_jsmzcja_Rad	=	{}					BaoXiang_jsmzcja_Count	=	{}					
	BaoXiang_jsmzcja	[	1	]	=	1892		BaoXiang_jsmzcja_Rad	[	1	]	=	30 		BaoXiang_jsmzcja_Count	[	1	]	=	1	--	--污泥封印的咒纹重剑
	BaoXiang_jsmzcja	[	2	]	=	1893		BaoXiang_jsmzcja_Rad	[	2	]	=	20 		BaoXiang_jsmzcja_Count	[	2	]	=	1	--	--烈焰封印的幻灵之咆哮
	BaoXiang_jsmzcja	[	3	]	=	1894		BaoXiang_jsmzcja_Rad	[	3	]	=	1 		BaoXiang_jsmzcja_Count	[	3	]	=	1	--	寒冰封印的迷之裁决
	BaoXiang_jsmzcja	[	4	]	=	3308		BaoXiang_jsmzcja_Rad	[	4	]	=	23 		BaoXiang_jsmzcja_Count	[	4	]	=	1	--	迷之裁决宝箱24型
	BaoXiang_jsmzcja	[	5	]	=	1375		BaoXiang_jsmzcja_Rad	[	5	]	=	23 		BaoXiang_jsmzcja_Count	[	5	]	=	1	--	兽王斧
	BaoXiang_jsmzcja	[	6	]	=	1384		BaoXiang_jsmzcja_Rad	[	6	]	=	23 		BaoXiang_jsmzcja_Count	[	6	]	=	1	--	死亡之风
	BaoXiang_jsmzcja	[	7	]	=	0018		BaoXiang_jsmzcja_Rad	[	7	]	=	23 		BaoXiang_jsmzcja_Count	[	7	]	=	1	--	雷刃
	BaoXiang_jsmzcja	[	8	]	=	1374		BaoXiang_jsmzcja_Rad	[	8	]	=	180 		BaoXiang_jsmzcja_Count	[	8	]	=	1	--	苍龙剑
	BaoXiang_jsmzcja	[	9	]	=	0017		BaoXiang_jsmzcja_Rad	[	9	]	=	180 		BaoXiang_jsmzcja_Count	[	9	]	=	1	--	龙骨剑
	BaoXiang_jsmzcja	[	10	]	=	1383		BaoXiang_jsmzcja_Rad	[	10	]	=	180 		BaoXiang_jsmzcja_Count	[	10	]	=	1	--	龙魂剑
	BaoXiang_jsmzcja	[	11	]	=	0021		BaoXiang_jsmzcja_Rad	[	11	]	=	180 		BaoXiang_jsmzcja_Count	[	11	]	=	1	--	冲锋剑
	BaoXiang_jsmzcja	[	12	]	=	1378		BaoXiang_jsmzcja_Rad	[	12	]	=	180 		BaoXiang_jsmzcja_Count	[	12	]	=	1	--	火龙剑
	BaoXiang_jsmzcja	[	13	]	=	0020		BaoXiang_jsmzcja_Rad	[	13	]	=	13000 		BaoXiang_jsmzcja_Count	[	13	]	=	1	--	战士剑
	BaoXiang_jsmzcja	[	14	]	=	1372		BaoXiang_jsmzcja_Rad	[	14	]	=	13000 		BaoXiang_jsmzcja_Count	[	14	]	=	1	--	虔诚剑
	BaoXiang_jsmzcja	[	15	]	=	1373		BaoXiang_jsmzcja_Rad	[	15	]	=	13000 		BaoXiang_jsmzcja_Count	[	15	]	=	1	--	骑兵佩剑
	BaoXiang_jsmzcja	[	16	]	=	1377		BaoXiang_jsmzcja_Rad	[	16	]	=	13000 		BaoXiang_jsmzcja_Count	[	16	]	=	1	--	量产战士剑
	BaoXiang_jsmzcja	[	17	]	=	1381		BaoXiang_jsmzcja_Rad	[	17	]	=	13000 		BaoXiang_jsmzcja_Count	[	17	]	=	1	--	圣者剑
	BaoXiang_jsmzcja	[	18	]	=	1382		BaoXiang_jsmzcja_Rad	[	18	]	=	13000 		BaoXiang_jsmzcja_Count	[	18	]	=	1	--	退敌剑
	BaoXiang_jsmzcja	[	19	]	=	1386		BaoXiang_jsmzcja_Rad	[	19	]	=	13000 		BaoXiang_jsmzcja_Count	[	19	]	=	1	--	强化战士剑

																						
	BaoXiang_jsmzcjb_Qua	=	23	 				BaoXiang_jsmzcjb_Mxcount	=	19												
	BaoXiang_jsmzcjb	=	{}					BaoXiang_jsmzcjb_Rad	=	{}					BaoXiang_jsmzcjb_Count	=	{}					
	BaoXiang_jsmzcjb	[	1	]	=	1892		BaoXiang_jsmzcjb_Rad	[	1	]	=	30 		BaoXiang_jsmzcjb_Count	[	1	]	=	1	--	--污泥封印的咒纹重剑
	BaoXiang_jsmzcjb	[	2	]	=	1893		BaoXiang_jsmzcjb_Rad	[	2	]	=	10 		BaoXiang_jsmzcjb_Count	[	2	]	=	1	--	--烈焰封印的幻灵之咆哮
	BaoXiang_jsmzcjb	[	3	]	=	1894		BaoXiang_jsmzcjb_Rad	[	3	]	=	5 		BaoXiang_jsmzcjb_Count	[	3	]	=	1	--	寒冰封印的迷之裁决
	BaoXiang_jsmzcjb	[	4	]	=	3309		BaoXiang_jsmzcjb_Rad	[	4	]	=	15 		BaoXiang_jsmzcjb_Count	[	4	]	=	1	--	迷之裁决宝箱23型
	BaoXiang_jsmzcjb	[	5	]	=	1375		BaoXiang_jsmzcjb_Rad	[	5	]	=	15 		BaoXiang_jsmzcjb_Count	[	5	]	=	1	--	兽王斧
	BaoXiang_jsmzcjb	[	6	]	=	1384		BaoXiang_jsmzcjb_Rad	[	6	]	=	15 		BaoXiang_jsmzcjb_Count	[	6	]	=	1	--	死亡之风
	BaoXiang_jsmzcjb	[	7	]	=	0018		BaoXiang_jsmzcjb_Rad	[	7	]	=	15 		BaoXiang_jsmzcjb_Count	[	7	]	=	1	--	雷刃
	BaoXiang_jsmzcjb	[	8	]	=	1374		BaoXiang_jsmzcjb_Rad	[	8	]	=	155 		BaoXiang_jsmzcjb_Count	[	8	]	=	1	--	苍龙剑
	BaoXiang_jsmzcjb	[	9	]	=	0017		BaoXiang_jsmzcjb_Rad	[	9	]	=	155 		BaoXiang_jsmzcjb_Count	[	9	]	=	1	--	龙骨剑
	BaoXiang_jsmzcjb	[	10	]	=	1383		BaoXiang_jsmzcjb_Rad	[	10	]	=	155 		BaoXiang_jsmzcjb_Count	[	10	]	=	1	--	龙魂剑
	BaoXiang_jsmzcjb	[	11	]	=	0021		BaoXiang_jsmzcjb_Rad	[	11	]	=	155 		BaoXiang_jsmzcjb_Count	[	11	]	=	1	--	冲锋剑
	BaoXiang_jsmzcjb	[	12	]	=	1378		BaoXiang_jsmzcjb_Rad	[	12	]	=	155 		BaoXiang_jsmzcjb_Count	[	12	]	=	1	--	火龙剑
	BaoXiang_jsmzcjb	[	13	]	=	0020		BaoXiang_jsmzcjb_Rad	[	13	]	=	14000 		BaoXiang_jsmzcjb_Count	[	13	]	=	1	--	战士剑
	BaoXiang_jsmzcjb	[	14	]	=	1372		BaoXiang_jsmzcjb_Rad	[	14	]	=	14000 		BaoXiang_jsmzcjb_Count	[	14	]	=	1	--	虔诚剑
	BaoXiang_jsmzcjb	[	15	]	=	1373		BaoXiang_jsmzcjb_Rad	[	15	]	=	14000 		BaoXiang_jsmzcjb_Count	[	15	]	=	1	--	骑兵佩剑
	BaoXiang_jsmzcjb	[	16	]	=	1377		BaoXiang_jsmzcjb_Rad	[	16	]	=	14000 		BaoXiang_jsmzcjb_Count	[	16	]	=	1	--	量产战士剑
	BaoXiang_jsmzcjb	[	17	]	=	1381		BaoXiang_jsmzcjb_Rad	[	17	]	=	14000 		BaoXiang_jsmzcjb_Count	[	17	]	=	1	--	圣者剑
	BaoXiang_jsmzcjb	[	18	]	=	1382		BaoXiang_jsmzcjb_Rad	[	18	]	=	14000 		BaoXiang_jsmzcjb_Count	[	18	]	=	1	--	退敌剑
	BaoXiang_jsmzcjb	[	19	]	=	1386		BaoXiang_jsmzcjb_Rad	[	19	]	=	14000 		BaoXiang_jsmzcjb_Count	[	19	]	=	1	--	强化战士剑

																						
	BaoXiang_jssjkja_Qua	=	24	 				BaoXiang_jssjkja_Mxcount	=	12																																		
	BaoXiang_jssjkja	=	{}					BaoXiang_jssjkja_Rad	=	{}					BaoXiang_jssjkja_Count	=	{}					
	BaoXiang_jssjkja	[	1	]	=	1884		BaoXiang_jssjkja_Rad	[	1	]	=	10 		BaoXiang_jssjkja_Count	[	1	]	=	1	--	不死封印的幽灵铠甲
	BaoXiang_jssjkja	[	2	]	=	1888		BaoXiang_jssjkja_Rad	[	2	]	=	30 		BaoXiang_jssjkja_Count	[	2	]	=	1	--	污泥封印的诅咒之灵钢甲
	BaoXiang_jssjkja	[	3	]	=	1889		BaoXiang_jssjkja_Rad	[	3	]	=	20 		BaoXiang_jssjkja_Count	[	3	]	=	1	--	烈焰封印的幻灵战甲
	BaoXiang_jssjkja	[	4	]	=	1890		BaoXiang_jssjkja_Rad	[	4	]	=	1 		BaoXiang_jssjkja_Count	[	4	]	=	1	--	寒冰封印的迷之战甲
	BaoXiang_jssjkja	[	5	]	=	0396		BaoXiang_jssjkja_Rad	[	5	]	=	2000		BaoXiang_jssjkja_Count	[	5	]	=	1	--	隐秘之甲
	BaoXiang_jssjkja	[	6	]	=	4150		BaoXiang_jssjkja_Rad	[	6	]	=	2000 		BaoXiang_jssjkja_Count	[	6	]	=	1	--	神圣战甲
	BaoXiang_jssjkja	[	7	]	=	0304		BaoXiang_jssjkja_Rad	[	7	]	=	2500		BaoXiang_jssjkja_Count	[	7	]	=	1	--	典礼钢甲
	BaoXiang_jssjkja	[	8	]	=	1931		BaoXiang_jssjkja_Rad	[	8	]	=	2500 		BaoXiang_jssjkja_Count	[	8	]	=	1	--	麒麟战甲
	BaoXiang_jssjkja	[	9	]	=	0302		BaoXiang_jssjkja_Rad	[	9	]	=	22400 		BaoXiang_jssjkja_Count	[	9	]	=	1	--	轻便钢甲
	BaoXiang_jssjkja	[	10	]	=	0303		BaoXiang_jssjkja_Rad	[	10	]	=	22400 		BaoXiang_jssjkja_Count	[	10	]	=	1	--	镀银钢甲
	BaoXiang_jssjkja	[	11	]	=	1929		BaoXiang_jssjkja_Rad	[	11	]	=	22400 		BaoXiang_jssjkja_Count	[	11	]	=	1	--	疾风战甲
	BaoXiang_jssjkja	[	12	]	=	1930		BaoXiang_jssjkja_Rad	[	12	]	=	22400 		BaoXiang_jssjkja_Count	[	12	]	=	1	--	西斯战甲

																						
--	双剑盔甲宝箱23型												e0106									
--	物品质量							宝箱物品上限														
	BaoXiang_jssjkjb_Qua	=	23	 				BaoXiang_jssjkjb_Mxcount	=	12												
																						
--	物品种类							物品概率														
	BaoXiang_jssjkjb	=	{}					BaoXiang_jssjkjb_Rad	=	{}					BaoXiang_jssjkjb_Count	=	{}					
	BaoXiang_jssjkjb	[	1	]	=	1884		BaoXiang_jssjkjb_Rad	[	1	]	=	10 		BaoXiang_jssjkjb_Count	[	1	]	=	1	--	不死封印的幽灵铠甲
	BaoXiang_jssjkjb	[	2	]	=	1888		BaoXiang_jssjkjb_Rad	[	2	]	=	30 		BaoXiang_jssjkjb_Count	[	2	]	=	1	--	污泥封印的诅咒之灵钢甲
	BaoXiang_jssjkjb	[	3	]	=	1889		BaoXiang_jssjkjb_Rad	[	3	]	=	10 		BaoXiang_jssjkjb_Count	[	3	]	=	1	--	烈焰封印的幻灵战甲
	BaoXiang_jssjkjb	[	4	]	=	1890		BaoXiang_jssjkjb_Rad	[	4	]	=	5 		BaoXiang_jssjkjb_Count	[	4	]	=	1	--	寒冰封印的迷之战甲
	BaoXiang_jssjkjb	[	5	]	=	0396		BaoXiang_jssjkjb_Rad	[	5	]	=	1000 		BaoXiang_jssjkjb_Count	[	5	]	=	1	--	隐秘之甲
	BaoXiang_jssjkjb	[	6	]	=	4150		BaoXiang_jssjkjb_Rad	[	6	]	=	1000 		BaoXiang_jssjkjb_Count	[	6	]	=	1	--	神圣战甲
	BaoXiang_jssjkjb	[	7	]	=	0304		BaoXiang_jssjkjb_Rad	[	7	]	=	2000		BaoXiang_jssjkjb_Count	[	7	]	=	1	--	典礼钢甲
	BaoXiang_jssjkjb	[	8	]	=	1931		BaoXiang_jssjkjb_Rad	[	8	]	=	2000 		BaoXiang_jssjkjb_Count	[	8	]	=	1	--	麒麟战甲
	BaoXiang_jssjkjb	[	9	]	=	0302		BaoXiang_jssjkjb_Rad	[	9	]	=	23000 		BaoXiang_jssjkjb_Count	[	9	]	=	1	--	轻便钢甲
	BaoXiang_jssjkjb	[	10	]	=	0303		BaoXiang_jssjkjb_Rad	[	10	]	=	23000 		BaoXiang_jssjkjb_Count	[	10	]	=	1	--	镀银钢甲
	BaoXiang_jssjkjb	[	11	]	=	1929		BaoXiang_jssjkjb_Rad	[	11	]	=	23000 		BaoXiang_jssjkjb_Count	[	11	]	=	1	--	疾风战甲
	BaoXiang_jssjkjb	[	12	]	=	1930		BaoXiang_jssjkjb_Rad	[	12	]	=	23000 		BaoXiang_jssjkjb_Count	[	12	]	=	1	--	西斯战甲
																						
																						
	BaoXiang_jszjkja_Qua	=	24	 				BaoXiang_jszjkja_Mxcount	=	13												
	BaoXiang_jszjkja	=	{}					BaoXiang_jszjkja_Rad	=	{}					BaoXiang_jszjkja_Count	=	{}					
	BaoXiang_jszjkja	[	1	]	=	1898		BaoXiang_jszjkja_Rad	[	1	]	=	10 		BaoXiang_jszjkja_Count	[	1	]	=	1	--	不死封印的亡灵短袍
	BaoXiang_jszjkja	[	2	]	=	1899		BaoXiang_jszjkja_Rad	[	2	]	=	30 		BaoXiang_jszjkja_Count	[	2	]	=	1	--	污泥封印的咒纹紧身衣
	BaoXiang_jszjkja	[	3	]	=	1900		BaoXiang_jszjkja_Rad	[	3	]	=	20 		BaoXiang_jszjkja_Count	[	3	]	=	1	--	烈焰封印的幻灵外套
	BaoXiang_jszjkja	[	4	]	=	1901		BaoXiang_jszjkja_Rad	[	4	]	=	1 		BaoXiang_jszjkja_Count	[	4	]	=	1	--	寒冰封印的迷之斗篷
	BaoXiang_jszjkja	[	5	]	=	3312		BaoXiang_jszjkja_Rad	[	5	]	=	1330 		BaoXiang_jszjkja_Count	[	5	]	=	1	--	狙击盔甲宝箱24型
	BaoXiang_jszjkja	[	6	]	=	0400		BaoXiang_jszjkja_Rad	[	6	]	=	1330 		BaoXiang_jszjkja_Count	[	6	]	=	1	--	射日外套
	BaoXiang_jszjkja	[	7	]	=	4152		BaoXiang_jszjkja_Rad	[	7	]	=	1330 		BaoXiang_jszjkja_Count	[	7	]	=	1	--	狮鹫衣服
	BaoXiang_jszjkja	[	8	]	=	0316		BaoXiang_jszjkja_Rad	[	8	]	=	2500 		BaoXiang_jszjkja_Count	[	8	]	=	1	--	斑鸠衣服
	BaoXiang_jszjkja	[	9	]	=	0317		BaoXiang_jszjkja_Rad	[	9	]	=	2500 		BaoXiang_jszjkja_Count	[	9	]	=	1	--	猛禽衣服
	BaoXiang_jszjkja	[	10	]	=	4151		BaoXiang_jszjkja_Rad	[	10	]	=	5000 		BaoXiang_jszjkja_Count	[	10	]	=	1	--	迅鹰衣服
	BaoXiang_jszjkja	[	11	]	=	0317		BaoXiang_jszjkja_Rad	[	11	]	=	5000 		BaoXiang_jszjkja_Count	[	11	]	=	1	--	猛禽衣服
	BaoXiang_jszjkja	[	12	]	=	0314		BaoXiang_jszjkja_Rad	[	12	]	=	40000 		BaoXiang_jszjkja_Count	[	12	]	=	1	--	敏捷衣服
	BaoXiang_jszjkja	[	13	]	=	0315		BaoXiang_jszjkja_Rad	[	13	]	=	40000		BaoXiang_jszjkja_Count	[	13	]	=	1	--	山雀衣服
																																											
																						
	BaoXiang_jszjkjb_Qua	=	23	 				BaoXiang_jszjkjb_Mxcount	=	13												
	BaoXiang_jszjkjb	=	{}					BaoXiang_jszjkjb_Rad	=	{}					BaoXiang_jszjkjb_Count	=	{}					
	BaoXiang_jszjkjb	[	1	]	=	1898		BaoXiang_jszjkjb_Rad	[	1	]	=	10		BaoXiang_jszjkjb_Count	[	1	]	=	1	--	不死封印的亡灵短袍
	BaoXiang_jszjkjb	[	2	]	=	1899		BaoXiang_jszjkjb_Rad	[	2	]	=	30 		BaoXiang_jszjkjb_Count	[	2	]	=	1	--	污泥封印的咒纹紧身衣
	BaoXiang_jszjkjb	[	3	]	=	1900		BaoXiang_jszjkjb_Rad	[	3	]	=	10 		BaoXiang_jszjkjb_Count	[	3	]	=	1	--	烈焰封印的幻灵外套
	BaoXiang_jszjkjb	[	4	]	=	1901		BaoXiang_jszjkjb_Rad	[	4	]	=	5 		BaoXiang_jszjkjb_Count	[	4	]	=	1	--	寒冰封印的迷之斗篷
	BaoXiang_jszjkjb	[	5	]	=	3313		BaoXiang_jszjkjb_Rad	[	5	]	=	700 		BaoXiang_jszjkjb_Count	[	5	]	=	1	--	狙击盔甲宝箱23型
	BaoXiang_jszjkjb	[	6	]	=	0400		BaoXiang_jszjkjb_Rad	[	6	]	=	700 		BaoXiang_jszjkjb_Count	[	6	]	=	1	--	射日外套
	BaoXiang_jszjkjb	[	7	]	=	4152		BaoXiang_jszjkjb_Rad	[	7	]	=	700 		BaoXiang_jszjkjb_Count	[	7	]	=	1	--	狮鹫衣服
	BaoXiang_jszjkjb	[	8	]	=	0316		BaoXiang_jszjkjb_Rad	[	8	]	=	2000 		BaoXiang_jszjkjb_Count	[	8	]	=	1	--	斑鸠衣服
	BaoXiang_jszjkjb	[	9	]	=	0317		BaoXiang_jszjkjb_Rad	[	9	]	=	2000 		BaoXiang_jszjkjb_Count	[	9	]	=	1	--	猛禽衣服
	BaoXiang_jszjkjb	[	10	]	=	4151		BaoXiang_jszjkjb_Rad	[	10	]	=	5000 		BaoXiang_jszjkjb_Count	[	10	]	=	1	--	迅鹰衣服
	BaoXiang_jszjkjb	[	11	]	=	0317		BaoXiang_jszjkjb_Rad	[	11	]	=	5000 		BaoXiang_jszjkjb_Count	[	11	]	=	1	--	猛禽衣服
	BaoXiang_jszjkjb	[	12	]	=	0314		BaoXiang_jszjkjb_Rad	[	12	]	=	42000 		BaoXiang_jszjkjb_Count	[	12	]	=	1	--	敏捷衣服
	BaoXiang_jszjkjb	[	13	]	=	0315		BaoXiang_jszjkjb_Rad	[	13	]	=	42000		BaoXiang_jszjkjb_Count	[	13	]	=	1	--	山雀衣服

																																												
	BaoXiang_jsszkja_Qua	=	24	 				BaoXiang_jsszkja_Mxcount	=	19												
	BaoXiang_jsszkja	=	{}					BaoXiang_jsszkja_Rad	=	{}					BaoXiang_jsszkja_Count	=	{}					
	BaoXiang_jsszkja	[	1	]	=	1910		BaoXiang_jsszkja_Rad	[	1	]	=	10 		BaoXiang_jsszkja_Count	[	1	]	=	1	--	不死封印的巫毒法袍
	BaoXiang_jsszkja	[	2	]	=	1911		BaoXiang_jsszkja_Rad	[	2	]	=	30 		BaoXiang_jsszkja_Count	[	2	]	=	1	--	污泥封印的符文外衣
	BaoXiang_jsszkja	[	3	]	=	1912		BaoXiang_jsszkja_Rad	[	3	]	=	20 		BaoXiang_jsszkja_Count	[	3	]	=	1	--	烈焰封印的幻法之袍
	BaoXiang_jsszkja	[	4	]	=	1913		BaoXiang_jsszkja_Rad	[	4	]	=	1 		BaoXiang_jsszkja_Count	[	4	]	=	1	--	寒冰封印的迷之法袍
	BaoXiang_jsszkja	[	5	]	=	0406		BaoXiang_jsszkja_Rad	[	5	]	=	700 		BaoXiang_jsszkja_Count	[	5	]	=	1	--	飞天衣服
	BaoXiang_jsszkja	[	6	]	=	4158		BaoXiang_jsszkja_Rad	[	6	]	=	700 		BaoXiang_jsszkja_Count	[	6	]	=	1	--	魔力兔子衣服
	BaoXiang_jsszkja	[	7	]	=	4159		BaoXiang_jsszkja_Rad	[	7	]	=	700 		BaoXiang_jsszkja_Count	[	7	]	=	1	--	圣光衣服
	BaoXiang_jsszkja	[	8	]	=	4160		BaoXiang_jsszkja_Rad	[	8	]	=	700 		BaoXiang_jsszkja_Count	[	8	]	=	1	--	觉醒兔子衣服
	BaoXiang_jsszkja	[	9	]	=	4157		BaoXiang_jsszkja_Rad	[	9	]	=	700 		BaoXiang_jsszkja_Count	[	9	]	=	1	--	圣音衣服
	BaoXiang_jsszkja	[	10	]	=	0391		BaoXiang_jsszkja_Rad	[	10	]	=	2500 		BaoXiang_jsszkja_Count	[	10	]	=	1	--	高级兔衣服
	BaoXiang_jsszkja	[	11	]	=	0392		BaoXiang_jsszkja_Rad	[	11	]	=	2500 		BaoXiang_jsszkja_Count	[	11	]	=	1	--	宝贝兔衣服
	BaoXiang_jsszkja	[	12	]	=	0393		BaoXiang_jsszkja_Rad	[	12	]	=	2500 		BaoXiang_jsszkja_Count	[	12	]	=	1	--	祝福兔衣服
	BaoXiang_jsszkja	[	13	]	=	0394		BaoXiang_jsszkja_Rad	[	13	]	=	2500 		BaoXiang_jsszkja_Count	[	13	]	=	1	--	天赐衣服
	BaoXiang_jsszkja	[	14	]	=	1960		BaoXiang_jsszkja_Rad	[	14	]	=	2500 		BaoXiang_jsszkja_Count	[	14	]	=	1	--	希尔外套
	BaoXiang_jsszkja	[	15	]	=	1961		BaoXiang_jsszkja_Rad	[	15	]	=	2500 		BaoXiang_jsszkja_Count	[	15	]	=	1	--	鸾凤外套
	BaoXiang_jsszkja	[	16	]	=	1959		BaoXiang_jsszkja_Rad	[	16	]	=	20000 		BaoXiang_jsszkja_Count	[	16	]	=	1	--	耀日外衣
	BaoXiang_jsszkja	[	17	]	=	0382		BaoXiang_jsszkja_Rad	[	17	]	=	20000 		BaoXiang_jsszkja_Count	[	17	]	=	1	--	长耳兔衣服
	BaoXiang_jsszkja	[	18	]	=	0388		BaoXiang_jsszkja_Rad	[	18	]	=	20000 		BaoXiang_jsszkja_Count	[	18	]	=	1	--	快乐兔衣服
	BaoXiang_jsszkja	[	19	]	=	0392		BaoXiang_jsszkja_Rad	[	19	]	=	20000 		BaoXiang_jsszkja_Count	[	19	]	=	1	--	宝贝兔衣服

																						
	BaoXiang_jsszkjb_Qua	=	23	 				BaoXiang_jsszkjb_Mxcount	=	19												
	BaoXiang_jsszkjb	=	{}					BaoXiang_jsszkjb_Rad	=	{}					BaoXiang_jsszkjb_Count	=	{}					
	BaoXiang_jsszkjb	[	1	]	=	1910		BaoXiang_jsszkjb_Rad	[	1	]	=	10 		BaoXiang_jsszkjb_Count	[	1	]	=	1	--	不死封印的巫毒法袍
	BaoXiang_jsszkjb	[	2	]	=	1911		BaoXiang_jsszkjb_Rad	[	2	]	=	30 		BaoXiang_jsszkjb_Count	[	2	]	=	1	--	污泥封印的符文外衣
	BaoXiang_jsszkjb	[	3	]	=	1912		BaoXiang_jsszkjb_Rad	[	3	]	=	10 		BaoXiang_jsszkjb_Count	[	3	]	=	1	--	烈焰封印的幻法之袍
	BaoXiang_jsszkjb	[	4	]	=	1913		BaoXiang_jsszkjb_Rad	[	4	]	=	5 		BaoXiang_jsszkjb_Count	[	4	]	=	1	--	寒冰封印的迷之法袍
	BaoXiang_jsszkjb	[	5	]	=	0406		BaoXiang_jsszkjb_Rad	[	5	]	=	400 		BaoXiang_jsszkjb_Count	[	5	]	=	1	--	飞天衣服
	BaoXiang_jsszkjb	[	6	]	=	4158		BaoXiang_jsszkjb_Rad	[	6	]	=	400 		BaoXiang_jsszkjb_Count	[	6	]	=	1	--	魔力兔子衣服
	BaoXiang_jsszkjb	[	7	]	=	4159		BaoXiang_jsszkjb_Rad	[	7	]	=	400 		BaoXiang_jsszkjb_Count	[	7	]	=	1	--	圣光衣服
	BaoXiang_jsszkjb	[	8	]	=	4160		BaoXiang_jsszkjb_Rad	[	8	]	=	400 		BaoXiang_jsszkjb_Count	[	8	]	=	1	--	觉醒兔子衣服
	BaoXiang_jsszkjb	[	9	]	=	4157		BaoXiang_jsszkjb_Rad	[	9	]	=	400 		BaoXiang_jsszkjb_Count	[	9	]	=	1	--	圣音衣服
	BaoXiang_jsszkjb	[	10	]	=	0391		BaoXiang_jsszkjb_Rad	[	10	]	=	2000 		BaoXiang_jsszkjb_Count	[	10	]	=	1	--	高级兔衣服
	BaoXiang_jsszkjb	[	11	]	=	0392		BaoXiang_jsszkjb_Rad	[	11	]	=	2000 		BaoXiang_jsszkjb_Count	[	11	]	=	1	--	宝贝兔衣服
	BaoXiang_jsszkjb	[	12	]	=	0393		BaoXiang_jsszkjb_Rad	[	12	]	=	2000 		BaoXiang_jsszkjb_Count	[	12	]	=	1	--	祝福兔衣服
	BaoXiang_jsszkjb	[	13	]	=	0394		BaoXiang_jsszkjb_Rad	[	13	]	=	2000 		BaoXiang_jsszkjb_Count	[	13	]	=	1	--	天赐衣服
	BaoXiang_jsszkjb	[	14	]	=	1960		BaoXiang_jsszkjb_Rad	[	14	]	=	2000		BaoXiang_jsszkjb_Count	[	14	]	=	1	--	希尔外套
	BaoXiang_jsszkjb	[	15	]	=	1961		BaoXiang_jsszkjb_Rad	[	15	]	=	2000 		BaoXiang_jsszkjb_Count	[	15	]	=	1	--	鸾凤外套
	BaoXiang_jsszkjb	[	16	]	=	1959		BaoXiang_jsszkjb_Rad	[	16	]	=	21110 		BaoXiang_jsszkjb_Count	[	16	]	=	1	--	耀日外衣
	BaoXiang_jsszkjb	[	17	]	=	0382		BaoXiang_jsszkjb_Rad	[	17	]	=	21110 		BaoXiang_jsszkjb_Count	[	17	]	=	1	--	长耳兔衣服
	BaoXiang_jsszkjb	[	18	]	=	0388		BaoXiang_jsszkjb_Rad	[	18	]	=	21110 		BaoXiang_jsszkjb_Count	[	18	]	=	1	--	快乐兔衣服
	BaoXiang_jsszkjb	[	19	]	=	0392		BaoXiang_jsszkjb_Rad	[	19	]	=	21110 		BaoXiang_jsszkjb_Count	[	19	]	=	1	--	宝贝兔衣服

																						
	BaoXiang_jsfykja_Qua	=	24	 				BaoXiang_jsfykja_Mxcount	=	21												
	BaoXiang_jsfykja	=	{}					BaoXiang_jsfykja_Rad	=	{}					BaoXiang_jsfykja_Count	=	{}					
	BaoXiang_jsfykja	[	1	]	=	1910		BaoXiang_jsfykja_Rad	[	1	]	=	10 		BaoXiang_jsfykja_Count	[	1	]	=	1	--	不死封印的巫毒法袍
	BaoXiang_jsfykja	[	2	]	=	1917		BaoXiang_jsfykja_Rad	[	2	]	=	30 		BaoXiang_jsfykja_Count	[	2	]	=	1	--	污泥封印的咒文之袍
	BaoXiang_jsfykja	[	3	]	=	1918		BaoXiang_jsfykja_Rad	[	3	]	=	20 		BaoXiang_jsfykja_Count	[	3	]	=	1	--	烈焰封印的幻咒之袍
	BaoXiang_jsfykja	[	4	]	=	1919		BaoXiang_jsfykja_Rad	[	4	]	=	1 		BaoXiang_jsfykja_Count	[	4	]	=	1	--	寒冰封印的迷咒法袍
	BaoXiang_jsfykja	[	5	]	=	0402		BaoXiang_jsfykja_Rad	[	5	]	=	700 		BaoXiang_jsfykja_Count	[	5	]	=	1	--	神士衣服
	BaoXiang_jsfykja	[	6	]	=	0404		BaoXiang_jsfykja_Rad	[	6	]	=	700 		BaoXiang_jsfykja_Count	[	6	]	=	1	--	神奇熊猫衣服
	BaoXiang_jsfykja	[	7	]	=	4161		BaoXiang_jsfykja_Rad	[	7	]	=	700 		BaoXiang_jsfykja_Count	[	7	]	=	1	--	复仇衣服
	BaoXiang_jsfykja	[	8	]	=	4162		BaoXiang_jsfykja_Rad	[	8	]	=	700		BaoXiang_jsfykja_Count	[	8	]	=	1	--	魔力海獭衣服
	BaoXiang_jsfykja	[	9	]	=	4163		BaoXiang_jsfykja_Rad	[	9	]	=	700 		BaoXiang_jsfykja_Count	[	9	]	=	1	--	惩罚者衣服
	BaoXiang_jsfykja	[	10	]	=	4164		BaoXiang_jsfykja_Rad	[	10	]	=	700 		BaoXiang_jsfykja_Count	[	10	]	=	1	--	觉醒海獭衣服
	BaoXiang_jsfykja	[	11	]	=	0363		BaoXiang_jsfykja_Rad	[	11	]	=	2500 		BaoXiang_jsfykja_Count	[	11	]	=	1	--	高级海獭衣服
	BaoXiang_jsfykja	[	12	]	=	0364		BaoXiang_jsfykja_Rad	[	12	]	=	2500 		BaoXiang_jsfykja_Count	[	12	]	=	1	--	祝福海獭衣服
	BaoXiang_jsfykja	[	13	]	=	0376		BaoXiang_jsfykja_Rad	[	13	]	=	2500 		BaoXiang_jsfykja_Count	[	13	]	=	1	--	治疗者衣服
	BaoXiang_jsfykja	[	14	]	=	0377		BaoXiang_jsfykja_Rad	[	14	]	=	2500 		BaoXiang_jsfykja_Count	[	14	]	=	1	--	保护者衣服
	BaoXiang_jsfykja	[	15	]	=	1957		BaoXiang_jsfykja_Rad	[	15	]	=	2500 		BaoXiang_jsfykja_Count	[	15	]	=	1	--	尤迪安外套
	BaoXiang_jsfykja	[	16	]	=	1958		BaoXiang_jsfykja_Rad	[	16	]	=	2500 		BaoXiang_jsfykja_Count	[	16	]	=	1	--	朱雀外套
	BaoXiang_jsfykja	[	17	]	=	1956		BaoXiang_jsfykja_Rad	[	17	]	=	16000 		BaoXiang_jsfykja_Count	[	17	]	=	1	--	冷月外衣
	BaoXiang_jsfykja	[	18	]	=	0385		BaoXiang_jsfykja_Rad	[	18	]	=	16000 		BaoXiang_jsfykja_Count	[	18	]	=	1	--	海獭衣服
	BaoXiang_jsfykja	[	19	]	=	0375		BaoXiang_jsfykja_Rad	[	19	]	=	16000 		BaoXiang_jsfykja_Count	[	19	]	=	1	--	远行衣服
	BaoXiang_jsfykja	[	20	]	=	0369		BaoXiang_jsfykja_Rad	[	20	]	=	16000 		BaoXiang_jsfykja_Count	[	20	]	=	1	--	侍者衣服
	BaoXiang_jsfykja	[	21	]	=	0362		BaoXiang_jsfykja_Rad	[	21	]	=	16000 		BaoXiang_jsfykja_Count	[	21	]	=	1	--	蹦蹦鼠衣服

																						
	BaoXiang_jsfykjb_Qua	=	23	 				BaoXiang_jsfykjb_Mxcount	=	21												
	BaoXiang_jsfykjb	=	{}					BaoXiang_jsfykjb_Rad	=	{}					BaoXiang_jsfykjb_Count	=	{}					
	BaoXiang_jsfykjb	[	1	]	=	1910		BaoXiang_jsfykjb_Rad	[	1	]	=	10 		BaoXiang_jsfykjb_Count	[	1	]	=	1	--	不死封印的巫毒法袍
	BaoXiang_jsfykjb	[	2	]	=	1917		BaoXiang_jsfykjb_Rad	[	2	]	=	30 		BaoXiang_jsfykjb_Count	[	2	]	=	1	--	污泥封印的咒文之袍
	BaoXiang_jsfykjb	[	3	]	=	1918		BaoXiang_jsfykjb_Rad	[	3	]	=	10 		BaoXiang_jsfykjb_Count	[	3	]	=	1	--	烈焰封印的幻咒之袍
	BaoXiang_jsfykjb	[	4	]	=	1919		BaoXiang_jsfykjb_Rad	[	4	]	=	5 		BaoXiang_jsfykjb_Count	[	4	]	=	1	--	寒冰封印的迷咒法袍
	BaoXiang_jsfykjb	[	5	]	=	0402		BaoXiang_jsfykjb_Rad	[	5	]	=	400 		BaoXiang_jsfykjb_Count	[	5	]	=	1	--	神士衣服
	BaoXiang_jsfykjb	[	6	]	=	0404		BaoXiang_jsfykjb_Rad	[	6	]	=	400 		BaoXiang_jsfykjb_Count	[	6	]	=	1	--	神奇熊猫衣服
	BaoXiang_jsfykjb	[	7	]	=	4161		BaoXiang_jsfykjb_Rad	[	7	]	=	400 		BaoXiang_jsfykjb_Count	[	7	]	=	1	--	复仇衣服
	BaoXiang_jsfykjb	[	8	]	=	4162		BaoXiang_jsfykjb_Rad	[	8	]	=	400 		BaoXiang_jsfykjb_Count	[	8	]	=	1	--	魔力海獭衣服
	BaoXiang_jsfykjb	[	9	]	=	4163		BaoXiang_jsfykjb_Rad	[	9	]	=	400 		BaoXiang_jsfykjb_Count	[	9	]	=	1	--	惩罚者衣服
	BaoXiang_jsfykjb	[	10	]	=	4164		BaoXiang_jsfykjb_Rad	[	10	]	=	400 		BaoXiang_jsfykjb_Count	[	10	]	=	1	--	觉醒海獭衣服
	BaoXiang_jsfykjb	[	11	]	=	0363		BaoXiang_jsfykjb_Rad	[	11	]	=	2000 		BaoXiang_jsfykjb_Count	[	11	]	=	1	--	高级海獭衣服
	BaoXiang_jsfykjb	[	12	]	=	0364		BaoXiang_jsfykjb_Rad	[	12	]	=	2000 		BaoXiang_jsfykjb_Count	[	12	]	=	1	--	祝福海獭衣服
	BaoXiang_jsfykjb	[	13	]	=	0376		BaoXiang_jsfykjb_Rad	[	13	]	=	2000 		BaoXiang_jsfykjb_Count	[	13	]	=	1	--	治疗者衣服
	BaoXiang_jsfykjb	[	14	]	=	0377		BaoXiang_jsfykjb_Rad	[	14	]	=	2000 		BaoXiang_jsfykjb_Count	[	14	]	=	1	--	保护者衣服
	BaoXiang_jsfykjb	[	15	]	=	1957		BaoXiang_jsfykjb_Rad	[	15	]	=	2000 		BaoXiang_jsfykjb_Count	[	15	]	=	1	--	尤迪安外套
	BaoXiang_jsfykjb	[	16	]	=	1958		BaoXiang_jsfykjb_Rad	[	16	]	=	2000 		BaoXiang_jsfykjb_Count	[	16	]	=	1	--	朱雀外套
	BaoXiang_jsfykjb	[	17	]	=	1956		BaoXiang_jsfykjb_Rad	[	17	]	=	17000 		BaoXiang_jsfykjb_Count	[	17	]	=	1	--	冷月外衣
	BaoXiang_jsfykjb	[	18	]	=	0385		BaoXiang_jsfykjb_Rad	[	18	]	=	17000 		BaoXiang_jsfykjb_Count	[	18	]	=	1	--	海獭衣服
	BaoXiang_jsfykjb	[	19	]	=	0375		BaoXiang_jsfykjb_Rad	[	19	]	=	17000 		BaoXiang_jsfykjb_Count	[	19	]	=	1	--	远行衣服
	BaoXiang_jsfykjb	[	20	]	=	0369		BaoXiang_jsfykjb_Rad	[	20	]	=	17000 		BaoXiang_jsfykjb_Count	[	20	]	=	1	--	侍者衣服
	BaoXiang_jsfykjb	[	21	]	=	0362		BaoXiang_jsfykjb_Rad	[	21	]	=	17000 		BaoXiang_jsfykjb_Count	[	21	]	=	1	--	蹦蹦鼠衣服


																						
	BaoXiang_jshhkja_Qua	=	24	 				BaoXiang_jshhkja_Mxcount	=	20																																		
	BaoXiang_jshhkja	=	{}					BaoXiang_jshhkja_Rad	=	{}					BaoXiang_jshhkja_Count	=	{}					
	BaoXiang_jshhkja	[	1	]	=	1924		BaoXiang_jshhkja_Rad	[	1	]	=	10 		BaoXiang_jshhkja_Count	[	1	]	=	1	--	不死封印的海妖披风
	BaoXiang_jshhkja	[	2	]	=	1925		BaoXiang_jshhkja_Rad	[	2	]	=	30 		BaoXiang_jshhkja_Count	[	2	]	=	1	--	污泥封印的咒火斗篷
	BaoXiang_jshhkja	[	3	]	=	1926		BaoXiang_jshhkja_Rad	[	3	]	=	20 		BaoXiang_jshhkja_Count	[	3	]	=	1	--	烈焰封印的幻灵披风
	BaoXiang_jshhkja	[	4	]	=	1927		BaoXiang_jshhkja_Rad	[	4	]	=	1 		BaoXiang_jshhkja_Count	[	4	]	=	1	--	寒冰封印的迷幻斗篷
	BaoXiang_jshhkja	[	5	]	=	0411		BaoXiang_jshhkja_Rad	[	5	]	=	700 		BaoXiang_jshhkja_Count	[	5	]	=	1	--	怒涛衣服
	BaoXiang_jshhkja	[	6	]	=	0413		BaoXiang_jshhkja_Rad	[	6	]	=	700 		BaoXiang_jshhkja_Count	[	6	]	=	1	--	瑞兽衣服
	BaoXiang_jshhkja	[	7	]	=	4153		BaoXiang_jshhkja_Rad	[	7	]	=	700 		BaoXiang_jshhkja_Count	[	7	]	=	1	--	领航衣服
	BaoXiang_jshhkja	[	8	]	=	4154		BaoXiang_jshhkja_Rad	[	8	]	=	700 		BaoXiang_jshhkja_Count	[	8	]	=	1	--	魔力龙虾衣服
	BaoXiang_jshhkja	[	9	]	=	4155		BaoXiang_jshhkja_Rad	[	9	]	=	700 		BaoXiang_jshhkja_Count	[	9	]	=	1	--	踏浪衣服
	BaoXiang_jshhkja	[	10	]	=	4156		BaoXiang_jshhkja_Rad	[	10	]	=	700 		BaoXiang_jshhkja_Count	[	10	]	=	1	--	觉醒巨虾衣服
	BaoXiang_jshhkja	[	11	]	=	0357		BaoXiang_jshhkja_Rad	[	11	]	=	3000 		BaoXiang_jshhkja_Count	[	11	]	=	1	--	大海虾衣服
	BaoXiang_jshhkja	[	12	]	=	0358		BaoXiang_jshhkja_Rad	[	12	]	=	3000 		BaoXiang_jshhkja_Count	[	12	]	=	1	--	巨钳海虾衣服
	BaoXiang_jshhkja	[	13	]	=	0343		BaoXiang_jshhkja_Rad	[	13	]	=	3000 		BaoXiang_jshhkja_Count	[	13	]	=	1	--	飓风衣服
	BaoXiang_jshhkja	[	14	]	=	0344		BaoXiang_jshhkja_Rad	[	14	]	=	3000 		BaoXiang_jshhkja_Count	[	14	]	=	1	--	漩涡衣服
	BaoXiang_jshhkja	[	15	]	=	0345		BaoXiang_jshhkja_Rad	[	15	]	=	3000 		BaoXiang_jshhkja_Count	[	15	]	=	1	--	风之衣服
	BaoXiang_jshhkja	[	16	]	=	0341		BaoXiang_jshhkja_Rad	[	16	]	=	16000 		BaoXiang_jshhkja_Count	[	16	]	=	1	--	甲板衣服
	BaoXiang_jshhkja	[	17	]	=	0342		BaoXiang_jshhkja_Rad	[	17	]	=	16000 		BaoXiang_jshhkja_Count	[	17	]	=	1	--	桅杆衣服
	BaoXiang_jshhkja	[	18	]	=	0353		BaoXiang_jshhkja_Rad	[	18	]	=	16000 		BaoXiang_jshhkja_Count	[	18	]	=	1	--	小鸭衣服
	BaoXiang_jshhkja	[	19	]	=	0356		BaoXiang_jshhkja_Rad	[	19	]	=	16000 		BaoXiang_jshhkja_Count	[	19	]	=	1	--	摇摆鸭衣服
	BaoXiang_jshhkja	[	20	]	=	1977		BaoXiang_jshhkja_Rad	[	20	]	=	16000 		BaoXiang_jshhkja_Count	[	20	]	=	1	--	风暴外套

																						
	BaoXiang_jshhkjb_Qua	=	23	 				BaoXiang_jshhkjb_Mxcount	=	20												
	BaoXiang_jshhkjb	=	{}					BaoXiang_jshhkjb_Rad	=	{}					BaoXiang_jshhkjb_Count	=	{}					
	BaoXiang_jshhkjb	[	1	]	=	1924		BaoXiang_jshhkjb_Rad	[	1	]	=	10 		BaoXiang_jshhkjb_Count	[	1	]	=	1	--	不死封印的海妖披风
	BaoXiang_jshhkjb	[	2	]	=	1925		BaoXiang_jshhkjb_Rad	[	2	]	=	30 		BaoXiang_jshhkjb_Count	[	2	]	=	1	--	污泥封印的咒火斗篷
	BaoXiang_jshhkjb	[	3	]	=	1926		BaoXiang_jshhkjb_Rad	[	3	]	=	10 		BaoXiang_jshhkjb_Count	[	3	]	=	1	--	烈焰封印的幻灵披风
	BaoXiang_jshhkjb	[	4	]	=	1927		BaoXiang_jshhkjb_Rad	[	4	]	=	5 		BaoXiang_jshhkjb_Count	[	4	]	=	1	--	寒冰封印的迷幻斗篷
	BaoXiang_jshhkjb	[	5	]	=	0411		BaoXiang_jshhkjb_Rad	[	5	]	=	400 		BaoXiang_jshhkjb_Count	[	5	]	=	1	--	怒涛衣服
	BaoXiang_jshhkjb	[	6	]	=	0413		BaoXiang_jshhkjb_Rad	[	6	]	=	400 		BaoXiang_jshhkjb_Count	[	6	]	=	1	--	瑞兽衣服
	BaoXiang_jshhkjb	[	7	]	=	4153		BaoXiang_jshhkjb_Rad	[	7	]	=	400 		BaoXiang_jshhkjb_Count	[	7	]	=	1	--	领航衣服
	BaoXiang_jshhkjb	[	8	]	=	4154		BaoXiang_jshhkjb_Rad	[	8	]	=	400 		BaoXiang_jshhkjb_Count	[	8	]	=	1	--	魔力龙虾衣服
	BaoXiang_jshhkjb	[	9	]	=	4155		BaoXiang_jshhkjb_Rad	[	9	]	=	400 		BaoXiang_jshhkjb_Count	[	9	]	=	1	--	踏浪衣服
	BaoXiang_jshhkjb	[	10	]	=	4156		BaoXiang_jshhkjb_Rad	[	10	]	=	400 		BaoXiang_jshhkjb_Count	[	10	]	=	1	--	觉醒巨虾衣服
	BaoXiang_jshhkjb	[	11	]	=	0357		BaoXiang_jshhkjb_Rad	[	11	]	=	2500 		BaoXiang_jshhkjb_Count	[	11	]	=	1	--	大海虾衣服
	BaoXiang_jshhkjb	[	12	]	=	0358		BaoXiang_jshhkjb_Rad	[	12	]	=	2500 		BaoXiang_jshhkjb_Count	[	12	]	=	1	--	巨钳海虾衣服
	BaoXiang_jshhkjb	[	13	]	=	0343		BaoXiang_jshhkjb_Rad	[	13	]	=	2500 		BaoXiang_jshhkjb_Count	[	13	]	=	1	--	飓风衣服
	BaoXiang_jshhkjb	[	14	]	=	0344		BaoXiang_jshhkjb_Rad	[	14	]	=	2500 		BaoXiang_jshhkjb_Count	[	14	]	=	1	--	漩涡衣服
	BaoXiang_jshhkjb	[	15	]	=	0345		BaoXiang_jshhkjb_Rad	[	15	]	=	2500 		BaoXiang_jshhkjb_Count	[	15	]	=	1	--	风之衣服
	BaoXiang_jshhkjb	[	16	]	=	0341		BaoXiang_jshhkjb_Rad	[	16	]	=	17000 		BaoXiang_jshhkjb_Count	[	16	]	=	1	--	甲板衣服
	BaoXiang_jshhkjb	[	17	]	=	0342		BaoXiang_jshhkjb_Rad	[	17	]	=	17000 		BaoXiang_jshhkjb_Count	[	17	]	=	1	--	桅杆衣服
	BaoXiang_jshhkjb	[	18	]	=	0353		BaoXiang_jshhkjb_Rad	[	18	]	=	17000 		BaoXiang_jshhkjb_Count	[	18	]	=	1	--	小鸭衣服
	BaoXiang_jshhkjb	[	19	]	=	0356		BaoXiang_jshhkjb_Rad	[	19	]	=	17000 		BaoXiang_jshhkjb_Count	[	19	]	=	1	--	摇摆鸭衣服
	BaoXiang_jshhkjb	[	20	]	=	1977		BaoXiang_jshhkjb_Rad	[	20	]	=	17000 		BaoXiang_jshhkjb_Count	[	20	]	=	1	--	风暴外套

																						
	BaoXiang_jsjjkja_Qua	=	24	 				BaoXiang_jsjjkja_Mxcount	=	9												
	BaoXiang_jsjjkja	=	{}					BaoXiang_jsjjkja_Rad	=	{}					BaoXiang_jsjjkja_Count	=	{}					
	BaoXiang_jsjjkja	[	1	]	=	1885		BaoXiang_jsjjkja_Rad	[	1	]	=	50		BaoXiang_jsjjkja_Count	[	1	]	=	1	--	污泥封印的武士诅咒纹身
	BaoXiang_jsjjkja	[	2	]	=	1886		BaoXiang_jsjjkja_Rad	[	2	]	=	20		BaoXiang_jsjjkja_Count	[	2	]	=	1	--	烈焰封印的幻灵纹身
	BaoXiang_jsjjkja	[	3	]	=	1887		BaoXiang_jsjjkja_Rad	[	3	]	=	1 		BaoXiang_jsjjkja_Count	[	3	]	=	1	--	寒冰封印的迷之纹身
	BaoXiang_jsjjkja	[	4	]	=	0398		BaoXiang_jsjjkja_Rad	[	4	]	=	1660 		BaoXiang_jsjjkja_Count	[	4	]	=	1	--	灵神铠甲
	BaoXiang_jsjjkja	[	5	]	=	4148		BaoXiang_jsjjkja_Rad	[	5	]	=	1660 		BaoXiang_jsjjkja_Count	[	5	]	=	1	--	幻兽纹身
	BaoXiang_jsjjkja	[	6	]	=	4147		BaoXiang_jsjjkja_Rad	[	6	]	=	1660 		BaoXiang_jsjjkja_Count	[	6	]	=	1	--	灵兽纹身
	BaoXiang_jsjjkja	[	7	]	=	0228		BaoXiang_jsjjkja_Rad	[	7	]	=	32000		BaoXiang_jsjjkja_Count	[	7	]	=	1	--	怒牛纹身
	BaoXiang_jsjjkja	[	8	]	=	0230		BaoXiang_jsjjkja_Rad	[	8	]	=	32000		BaoXiang_jsjjkja_Count	[	8	]	=	1	--	兽王纹身
	BaoXiang_jsjjkja	[	9	]	=	0229		BaoXiang_jsjjkja_Rad	[	9	]	=	32000		BaoXiang_jsjjkja_Count	[	9	]	=	1	--	蛮牛纹身

																						
	BaoXiang_jsjjkjb_Qua	=	23	 				BaoXiang_jsjjkjb_Mxcount	=	9												
	BaoXiang_jsjjkjb	=	{}					BaoXiang_jsjjkjb_Rad	=	{}					BaoXiang_jsjjkjb_Count	=	{}					
	BaoXiang_jsjjkjb	[	1	]	=	1885		BaoXiang_jsjjkjb_Rad	[	1	]	=	50 		BaoXiang_jsjjkjb_Count	[	1	]	=	1	--	污泥封印的武士诅咒纹身
	BaoXiang_jsjjkjb	[	2	]	=	1886		BaoXiang_jsjjkjb_Rad	[	2	]	=	10 		BaoXiang_jsjjkjb_Count	[	2	]	=	1	--	烈焰封印的幻灵纹身
	BaoXiang_jsjjkjb	[	3	]	=	1887		BaoXiang_jsjjkjb_Rad	[	3	]	=	5 		BaoXiang_jsjjkjb_Count	[	3	]	=	1	--	寒冰封印的迷之纹身
	BaoXiang_jsjjkjb	[	4	]	=	0398		BaoXiang_jsjjkjb_Rad	[	4	]	=	900 		BaoXiang_jsjjkjb_Count	[	4	]	=	1	--	灵神铠甲
	BaoXiang_jsjjkjb	[	5	]	=	4148		BaoXiang_jsjjkjb_Rad	[	5	]	=	900 		BaoXiang_jsjjkjb_Count	[	5	]	=	1	--	幻兽纹身
	BaoXiang_jsjjkjb	[	6	]	=	4147		BaoXiang_jsjjkjb_Rad	[	6	]	=	900 		BaoXiang_jsjjkjb_Count	[	6	]	=	1	--	灵兽纹身
	BaoXiang_jsjjkjb	[	7	]	=	0228		BaoXiang_jsjjkjb_Rad	[	7	]	=	32500		BaoXiang_jsjjkjb_Count	[	7	]	=	1	--	怒牛纹身
	BaoXiang_jsjjkjb	[	8	]	=	0230		BaoXiang_jsjjkjb_Rad	[	8	]	=	32500		BaoXiang_jsjjkjb_Count	[	8	]	=	1	--	兽王纹身
	BaoXiang_jsjjkjb	[	9	]	=	0229		BaoXiang_jsjjkjb_Rad	[	9	]	=	32500		BaoXiang_jsjjkjb_Count	[	9	]	=	1	--	蛮牛纹身

																						
	BaoXiang_jshlza_Qua	=	24	 			BaoXiang_jshlza_Mxcount	=	70												
	BaoXiang_jshlza	=	{}					BaoXiang_jshlza_Rad	=	{}					BaoXiang_jshlza_Count	=	{}					
	BaoXiang_jshlza	[	1	]	=	0845		BaoXiang_jshlza_Rad	[	1	]	=	1 		BaoXiang_jshlza_Count	[	1	]	=	1	--	黑龙之躯
	BaoXiang_jshlza	[	2	]	=	0398		BaoXiang_jshlza_Rad	[	2	]	=	160 		BaoXiang_jshlza_Count	[	2	]	=	1	--	灵神铠甲
	BaoXiang_jshlza	[	3	]	=	4148		BaoXiang_jshlza_Rad	[	3	]	=	160 		BaoXiang_jshlza_Count	[	3	]	=	1	--	幻兽纹身
	BaoXiang_jshlza	[	4	]	=	4147		BaoXiang_jshlza_Rad	[	4	]	=	160 		BaoXiang_jshlza_Count	[	4	]	=	1	--	灵兽纹身
	BaoXiang_jshlza	[	5	]	=	0411		BaoXiang_jshlza_Rad	[	5	]	=	160 		BaoXiang_jshlza_Count	[	5	]	=	1	--	怒涛衣服
	BaoXiang_jshlza	[	6	]	=	0413		BaoXiang_jshlza_Rad	[	6	]	=	160 		BaoXiang_jshlza_Count	[	6	]	=	1	--	瑞兽衣服
	BaoXiang_jshlza	[	7	]	=	4153		BaoXiang_jshlza_Rad	[	7	]	=	160 		BaoXiang_jshlza_Count	[	7	]	=	1	--	领航衣服
	BaoXiang_jshlza	[	8	]	=	4154		BaoXiang_jshlza_Rad	[	8	]	=	160 		BaoXiang_jshlza_Count	[	8	]	=	1	--	魔力龙虾衣服
	BaoXiang_jshlza	[	9	]	=	4155		BaoXiang_jshlza_Rad	[	9	]	=	160 		BaoXiang_jshlza_Count	[	9	]	=	1	--	踏浪衣服
	BaoXiang_jshlza	[	10	]	=	4156		BaoXiang_jshlza_Rad	[	10	]	=	160 		BaoXiang_jshlza_Count	[	10	]	=	1	--	觉醒巨虾衣服
	BaoXiang_jshlza	[	11	]	=	0402		BaoXiang_jshlza_Rad	[	11	]	=	160 		BaoXiang_jshlza_Count	[	11	]	=	1	--	神士衣服
	BaoXiang_jshlza	[	12	]	=	0404		BaoXiang_jshlza_Rad	[	12	]	=	160 		BaoXiang_jshlza_Count	[	12	]	=	1	--	神奇熊猫衣服
	BaoXiang_jshlza	[	13	]	=	4161		BaoXiang_jshlza_Rad	[	13	]	=	160 		BaoXiang_jshlza_Count	[	13	]	=	1	--	复仇衣服
	BaoXiang_jshlza	[	14	]	=	4162		BaoXiang_jshlza_Rad	[	14	]	=	160 		BaoXiang_jshlza_Count	[	14	]	=	1	--	魔力海獭衣服
	BaoXiang_jshlza	[	15	]	=	4163		BaoXiang_jshlza_Rad	[	15	]	=	160 		BaoXiang_jshlza_Count	[	15	]	=	1	--	惩罚者衣服
	BaoXiang_jshlza	[	16	]	=	4164		BaoXiang_jshlza_Rad	[	16	]	=	160 		BaoXiang_jshlza_Count	[	16	]	=	1	--	觉醒海獭衣服
	BaoXiang_jshlza	[	17	]	=	0406		BaoXiang_jshlza_Rad	[	17	]	=	160		BaoXiang_jshlza_Count	[	17	]	=	1	--	飞天衣服
	BaoXiang_jshlza	[	18	]	=	4158		BaoXiang_jshlza_Rad	[	18	]	=	160 		BaoXiang_jshlza_Count	[	18	]	=	1	--	魔力兔子衣服
	BaoXiang_jshlza	[	19	]	=	4159		BaoXiang_jshlza_Rad	[	19	]	=	160 		BaoXiang_jshlza_Count	[	19	]	=	1	--	圣光衣服
	BaoXiang_jshlza	[	20	]	=	4160		BaoXiang_jshlza_Rad	[	20	]	=	160 		BaoXiang_jshlza_Count	[	20	]	=	1	--	觉醒兔子衣服
	BaoXiang_jshlza	[	21	]	=	4157		BaoXiang_jshlza_Rad	[	21	]	=	160		BaoXiang_jshlza_Count	[	21	]	=	1	--	圣音衣服
	BaoXiang_jshlza	[	22	]	=	3322		BaoXiang_jshlza_Rad	[	22	]	=	160		BaoXiang_jshlza_Count	[	22	]	=	1	--	黑龙之躯宝箱24型
	BaoXiang_jshlza	[	23	]	=	0400		BaoXiang_jshlza_Rad	[	23	]	=	160		BaoXiang_jshlza_Count	[	23	]	=	1	--	射日外套
	BaoXiang_jshlza	[	24	]	=	4152		BaoXiang_jshlza_Rad	[	24	]	=	160		BaoXiang_jshlza_Count	[	24	]	=	1	--	狮鹫衣服
	BaoXiang_jshlza	[	25	]	=	0396		BaoXiang_jshlza_Rad	[	25	]	=	160 		BaoXiang_jshlza_Count	[	25	]	=	1	--	隐秘之甲
	BaoXiang_jshlza	[	26	]	=	3322		BaoXiang_jshlza_Rad	[	26	]	=	160 		BaoXiang_jshlza_Count	[	26	]	=	1	--	黑龙之躯宝箱24型
	BaoXiang_jshlza	[	27	]	=	0228		BaoXiang_jshlza_Rad	[	27	]	=	500		BaoXiang_jshlza_Count	[	27	]	=	1	--	怒牛纹身
	BaoXiang_jshlza	[	28	]	=	0230		BaoXiang_jshlza_Rad	[	28	]	=	500		BaoXiang_jshlza_Count	[	28	]	=	1	--	兽王纹身
	BaoXiang_jshlza	[	29	]	=	0765		BaoXiang_jshlza_Rad	[	29	]	=	500		BaoXiang_jshlza_Count	[	29	]	=	1	--	幻灵纹身
	BaoXiang_jshlza	[	30	]	=	0357		BaoXiang_jshlza_Rad	[	30	]	=	500		BaoXiang_jshlza_Count	[	30	]	=	1	--	大海虾衣服
	BaoXiang_jshlza	[	31	]	=	0358		BaoXiang_jshlza_Rad	[	31	]	=	500		BaoXiang_jshlza_Count	[	31	]	=	1	--	巨钳海虾衣服
	BaoXiang_jshlza	[	32	]	=	0343		BaoXiang_jshlza_Rad	[	32	]	=	500		BaoXiang_jshlza_Count	[	32	]	=	1	--	飓风衣服
	BaoXiang_jshlza	[	33	]	=	0344		BaoXiang_jshlza_Rad	[	33	]	=	500		BaoXiang_jshlza_Count	[	33	]	=	1	--	漩涡衣服
	BaoXiang_jshlza	[	34	]	=	0345		BaoXiang_jshlza_Rad	[	34	]	=	500		BaoXiang_jshlza_Count	[	34	]	=	1	--	风之衣服
	BaoXiang_jshlza	[	35	]	=	0363		BaoXiang_jshlza_Rad	[	35	]	=	500		BaoXiang_jshlza_Count	[	35	]	=	1	--	高级海獭衣服
	BaoXiang_jshlza	[	36	]	=	0364		BaoXiang_jshlza_Rad	[	36	]	=	500		BaoXiang_jshlza_Count	[	36	]	=	1	--	祝福海獭衣服
	BaoXiang_jshlza	[	37	]	=	0376		BaoXiang_jshlza_Rad	[	37	]	=	500		BaoXiang_jshlza_Count	[	37	]	=	1	--	治疗者衣服
	BaoXiang_jshlza	[	38	]	=	0377		BaoXiang_jshlza_Rad	[	38	]	=	500		BaoXiang_jshlza_Count	[	38	]	=	1	--	保护者衣服
	BaoXiang_jshlza	[	39	]	=	1957		BaoXiang_jshlza_Rad	[	39	]	=	500		BaoXiang_jshlza_Count	[	39	]	=	1	--	尤迪安外套
	BaoXiang_jshlza	[	40	]	=	1958		BaoXiang_jshlza_Rad	[	40	]	=	500		BaoXiang_jshlza_Count	[	40	]	=	1	--	朱雀外套
	BaoXiang_jshlza	[	41	]	=	0391		BaoXiang_jshlza_Rad	[	41	]	=	500		BaoXiang_jshlza_Count	[	41	]	=	1	--	高级兔衣服
	BaoXiang_jshlza	[	42	]	=	0392		BaoXiang_jshlza_Rad	[	42	]	=	500		BaoXiang_jshlza_Count	[	42	]	=	1	--	宝贝兔衣服
	BaoXiang_jshlza	[	43	]	=	0393		BaoXiang_jshlza_Rad	[	43	]	=	500		BaoXiang_jshlza_Count	[	43	]	=	1	--	祝福兔衣服
	BaoXiang_jshlza	[	44	]	=	0394		BaoXiang_jshlza_Rad	[	44	]	=	500		BaoXiang_jshlza_Count	[	44	]	=	1	--	天赐衣服
	BaoXiang_jshlza	[	45	]	=	1960		BaoXiang_jshlza_Rad	[	45	]	=	500		BaoXiang_jshlza_Count	[	45	]	=	1	--	希尔外套
	BaoXiang_jshlza	[	46	]	=	1961		BaoXiang_jshlza_Rad	[	46	]	=	500		BaoXiang_jshlza_Count	[	46	]	=	1	--	鸾凤外套
	BaoXiang_jshlza	[	47	]	=	0316		BaoXiang_jshlza_Rad	[	47	]	=	500		BaoXiang_jshlza_Count	[	47	]	=	1	--	斑鸠衣服
	BaoXiang_jshlza	[	48	]	=	0317		BaoXiang_jshlza_Rad	[	48	]	=	500		BaoXiang_jshlza_Count	[	48	]	=	1	--	猛禽衣服
	BaoXiang_jshlza	[	49	]	=	0304		BaoXiang_jshlza_Rad	[	49	]	=	500		BaoXiang_jshlza_Count	[	49	]	=	1	--	典礼钢甲
	BaoXiang_jshlza	[	50	]	=	1931		BaoXiang_jshlza_Rad	[	50	]	=	500		BaoXiang_jshlza_Count	[	50	]	=	1	--	麒麟战甲
	BaoXiang_jshlza	[	51	]	=	0341		BaoXiang_jshlza_Rad	[	51	]	=	4200 		BaoXiang_jshlza_Count	[	51	]	=	1	--	甲板衣服
	BaoXiang_jshlza	[	52	]	=	0342		BaoXiang_jshlza_Rad	[	52	]	=	4200 		BaoXiang_jshlza_Count	[	52	]	=	1	--	桅杆衣服
	BaoXiang_jshlza	[	53	]	=	0353		BaoXiang_jshlza_Rad	[	53	]	=	4200 		BaoXiang_jshlza_Count	[	53	]	=	1	--	小鸭衣服
	BaoXiang_jshlza	[	54	]	=	0356		BaoXiang_jshlza_Rad	[	54	]	=	4200 		BaoXiang_jshlza_Count	[	54	]	=	1	--	摇摆鸭衣服
	BaoXiang_jshlza	[	55	]	=	1977		BaoXiang_jshlza_Rad	[	55	]	=	4200 		BaoXiang_jshlza_Count	[	55	]	=	1	--	风暴外套
	BaoXiang_jshlza	[	56	]	=	1956		BaoXiang_jshlza_Rad	[	56	]	=	4200 		BaoXiang_jshlza_Count	[	56	]	=	1	--	冷月外衣
	BaoXiang_jshlza	[	57	]	=	0385		BaoXiang_jshlza_Rad	[	57	]	=	4200 		BaoXiang_jshlza_Count	[	57	]	=	1	--	海獭衣服
	BaoXiang_jshlza	[	58	]	=	0375		BaoXiang_jshlza_Rad	[	58	]	=	4200 		BaoXiang_jshlza_Count	[	58	]	=	1	--	远行衣服
	BaoXiang_jshlza	[	59	]	=	0369		BaoXiang_jshlza_Rad	[	59	]	=	4200 		BaoXiang_jshlza_Count	[	59	]	=	1	--	侍者衣服
	BaoXiang_jshlza	[	60	]	=	0362		BaoXiang_jshlza_Rad	[	60	]	=	4200 		BaoXiang_jshlza_Count	[	60	]	=	1	--	蹦蹦鼠衣服
	BaoXiang_jshlza	[	61	]	=	1959		BaoXiang_jshlza_Rad	[	61	]	=	4200 		BaoXiang_jshlza_Count	[	61	]	=	1	--	耀日外衣
	BaoXiang_jshlza	[	62	]	=	0382		BaoXiang_jshlza_Rad	[	62	]	=	4200 		BaoXiang_jshlza_Count	[	62	]	=	1	--	长耳兔衣服
	BaoXiang_jshlza	[	63	]	=	0388		BaoXiang_jshlza_Rad	[	63	]	=	4200 		BaoXiang_jshlza_Count	[	63	]	=	1	--	快乐兔衣服
	BaoXiang_jshlza	[	64	]	=	0392		BaoXiang_jshlza_Rad	[	64	]	=	4200 		BaoXiang_jshlza_Count	[	64	]	=	1	--	宝贝兔衣服
	BaoXiang_jshlza	[	65	]	=	0314		BaoXiang_jshlza_Rad	[	65	]	=	4200 		BaoXiang_jshlza_Count	[	65	]	=	1	--	敏捷衣服
	BaoXiang_jshlza	[	66	]	=	0315		BaoXiang_jshlza_Rad	[	66	]	=	4200 		BaoXiang_jshlza_Count	[	66	]	=	1	--	山雀衣服
	BaoXiang_jshlza	[	67	]	=	0302		BaoXiang_jshlza_Rad	[	67	]	=	4200 		BaoXiang_jshlza_Count	[	67	]	=	1	--	轻便钢甲
	BaoXiang_jshlza	[	68	]	=	0303		BaoXiang_jshlza_Rad	[	68	]	=	4200 		BaoXiang_jshlza_Count	[	68	]	=	1	--	镀银钢甲
	BaoXiang_jshlza	[	69	]	=	1929		BaoXiang_jshlza_Rad	[	69	]	=	4200 		BaoXiang_jshlza_Count	[	69	]	=	1	--	疾风战甲
	BaoXiang_jshlza	[	70	]	=	1930		BaoXiang_jshlza_Rad	[	70	]	=	4200 		BaoXiang_jshlza_Count	[	70	]	=	1	--	西斯战甲

																						
	BaoXiang_jshlzb_Qua	=	23	 			BaoXiang_jshlzb_Mxcount	=	70												
	BaoXiang_jshlzb	=	{}					BaoXiang_jshlzb_Rad	=	{}					BaoXiang_jshlzb_Count	=	{}					
	BaoXiang_jshlzb	[	1	]	=	845		BaoXiang_jshlzb_Rad	[	1	]	=	1		BaoXiang_jshlzb_Count	[	1	]	=	1	--	黑龙之躯
	BaoXiang_jshlzb	[	2	]	=	398		BaoXiang_jshlzb_Rad	[	2	]	=	100		BaoXiang_jshlzb_Count	[	2	]	=	1	--	灵神铠甲
	BaoXiang_jshlzb	[	3	]	=	4148		BaoXiang_jshlzb_Rad	[	3	]	=	100		BaoXiang_jshlzb_Count	[	3	]	=	1	--	幻兽纹身
	BaoXiang_jshlzb	[	4	]	=	4147		BaoXiang_jshlzb_Rad	[	4	]	=	100		BaoXiang_jshlzb_Count	[	4	]	=	1	--	灵兽纹身
	BaoXiang_jshlzb	[	5	]	=	411		BaoXiang_jshlzb_Rad	[	5	]	=	100		BaoXiang_jshlzb_Count	[	5	]	=	1	--	怒涛衣服
	BaoXiang_jshlzb	[	6	]	=	413		BaoXiang_jshlzb_Rad	[	6	]	=	100		BaoXiang_jshlzb_Count	[	6	]	=	1	--	瑞兽衣服
	BaoXiang_jshlzb	[	7	]	=	4153		BaoXiang_jshlzb_Rad	[	7	]	=	100		BaoXiang_jshlzb_Count	[	7	]	=	1	--	领航衣服
	BaoXiang_jshlzb	[	8	]	=	4154		BaoXiang_jshlzb_Rad	[	8	]	=	100		BaoXiang_jshlzb_Count	[	8	]	=	1	--	魔力龙虾衣服
	BaoXiang_jshlzb	[	9	]	=	4155		BaoXiang_jshlzb_Rad	[	9	]	=	100		BaoXiang_jshlzb_Count	[	9	]	=	1	--	踏浪衣服
	BaoXiang_jshlzb	[	10	]	=	4156		BaoXiang_jshlzb_Rad	[	10	]	=	100		BaoXiang_jshlzb_Count	[	10	]	=	1	--	觉醒巨虾衣服
	BaoXiang_jshlzb	[	11	]	=	402		BaoXiang_jshlzb_Rad	[	11	]	=	100		BaoXiang_jshlzb_Count	[	11	]	=	1	--	神士衣服
	BaoXiang_jshlzb	[	12	]	=	404		BaoXiang_jshlzb_Rad	[	12	]	=	100		BaoXiang_jshlzb_Count	[	12	]	=	1	--	神奇熊猫衣服
	BaoXiang_jshlzb	[	13	]	=	4161		BaoXiang_jshlzb_Rad	[	13	]	=	100		BaoXiang_jshlzb_Count	[	13	]	=	1	--	复仇衣服
	BaoXiang_jshlzb	[	14	]	=	4162		BaoXiang_jshlzb_Rad	[	14	]	=	100		BaoXiang_jshlzb_Count	[	14	]	=	1	--	魔力海獭衣服
	BaoXiang_jshlzb	[	15	]	=	4163		BaoXiang_jshlzb_Rad	[	15	]	=	100		BaoXiang_jshlzb_Count	[	15	]	=	1	--	惩罚者衣服
	BaoXiang_jshlzb	[	16	]	=	4164		BaoXiang_jshlzb_Rad	[	16	]	=	100		BaoXiang_jshlzb_Count	[	16	]	=	1	--	觉醒海獭衣服
	BaoXiang_jshlzb	[	17	]	=	406		BaoXiang_jshlzb_Rad	[	17	]	=	100		BaoXiang_jshlzb_Count	[	17	]	=	1	--	飞天衣服
	BaoXiang_jshlzb	[	18	]	=	4158		BaoXiang_jshlzb_Rad	[	18	]	=	100		BaoXiang_jshlzb_Count	[	18	]	=	1	--	魔力兔子衣服
	BaoXiang_jshlzb	[	19	]	=	4159		BaoXiang_jshlzb_Rad	[	19	]	=	100		BaoXiang_jshlzb_Count	[	19	]	=	1	--	圣光衣服
	BaoXiang_jshlzb	[	20	]	=	4160		BaoXiang_jshlzb_Rad	[	20	]	=	100		BaoXiang_jshlzb_Count	[	20	]	=	1	--	觉醒兔子衣服
	BaoXiang_jshlzb	[	21	]	=	4157		BaoXiang_jshlzb_Rad	[	21	]	=	100		BaoXiang_jshlzb_Count	[	21	]	=	1	--	圣音衣服
	BaoXiang_jshlzb	[	22	]	=	3323		BaoXiang_jshlzb_Rad	[	22	]	=	100		BaoXiang_jshlzb_Count	[	22	]	=	1	--	黑龙之躯宝箱23型
	BaoXiang_jshlzb	[	23	]	=	400		BaoXiang_jshlzb_Rad	[	23	]	=	100		BaoXiang_jshlzb_Count	[	23	]	=	1	--	射日外套
	BaoXiang_jshlzb	[	24	]	=	4152		BaoXiang_jshlzb_Rad	[	24	]	=	100		BaoXiang_jshlzb_Count	[	24	]	=	1	--	狮鹫衣服
	BaoXiang_jshlzb	[	25	]	=	396		BaoXiang_jshlzb_Rad	[	25	]	=	100		BaoXiang_jshlzb_Count	[	25	]	=	1	--	隐秘之甲
	BaoXiang_jshlzb	[	26	]	=	3323		BaoXiang_jshlzb_Rad	[	26	]	=	100		BaoXiang_jshlzb_Count	[	26	]	=	1	--	黑龙之躯宝箱23型
	BaoXiang_jshlzb	[	27	]	=	228		BaoXiang_jshlzb_Rad	[	27	]	=	400		BaoXiang_jshlzb_Count	[	27	]	=	1	--	怒牛纹身
	BaoXiang_jshlzb	[	28	]	=	230		BaoXiang_jshlzb_Rad	[	28	]	=	400		BaoXiang_jshlzb_Count	[	28	]	=	1	--	兽王纹身
	BaoXiang_jshlzb	[	29	]	=	765		BaoXiang_jshlzb_Rad	[	29	]	=	400		BaoXiang_jshlzb_Count	[	29	]	=	1	--	幻灵纹身
	BaoXiang_jshlzb	[	30	]	=	357		BaoXiang_jshlzb_Rad	[	30	]	=	400		BaoXiang_jshlzb_Count	[	30	]	=	1	--	大海虾衣服
	BaoXiang_jshlzb	[	31	]	=	358		BaoXiang_jshlzb_Rad	[	31	]	=	400		BaoXiang_jshlzb_Count	[	31	]	=	1	--	巨钳海虾衣服
	BaoXiang_jshlzb	[	32	]	=	343		BaoXiang_jshlzb_Rad	[	32	]	=	400		BaoXiang_jshlzb_Count	[	32	]	=	1	--	飓风衣服
	BaoXiang_jshlzb	[	33	]	=	344		BaoXiang_jshlzb_Rad	[	33	]	=	400		BaoXiang_jshlzb_Count	[	33	]	=	1	--	漩涡衣服
	BaoXiang_jshlzb	[	34	]	=	345		BaoXiang_jshlzb_Rad	[	34	]	=	400		BaoXiang_jshlzb_Count	[	34	]	=	1	--	风之衣服
	BaoXiang_jshlzb	[	35	]	=	363		BaoXiang_jshlzb_Rad	[	35	]	=	400		BaoXiang_jshlzb_Count	[	35	]	=	1	--	高级海獭衣服
	BaoXiang_jshlzb	[	36	]	=	364		BaoXiang_jshlzb_Rad	[	36	]	=	400		BaoXiang_jshlzb_Count	[	36	]	=	1	--	祝福海獭衣服
	BaoXiang_jshlzb	[	37	]	=	376		BaoXiang_jshlzb_Rad	[	37	]	=	400		BaoXiang_jshlzb_Count	[	37	]	=	1	--	治疗者衣服
	BaoXiang_jshlzb	[	38	]	=	377		BaoXiang_jshlzb_Rad	[	38	]	=	400		BaoXiang_jshlzb_Count	[	38	]	=	1	--	保护者衣服
	BaoXiang_jshlzb	[	39	]	=	1957		BaoXiang_jshlzb_Rad	[	39	]	=	400		BaoXiang_jshlzb_Count	[	39	]	=	1	--	尤迪安外套
	BaoXiang_jshlzb	[	40	]	=	1958		BaoXiang_jshlzb_Rad	[	40	]	=	400		BaoXiang_jshlzb_Count	[	40	]	=	1	--	朱雀外套
	BaoXiang_jshlzb	[	41	]	=	391		BaoXiang_jshlzb_Rad	[	41	]	=	400		BaoXiang_jshlzb_Count	[	41	]	=	1	--	高级兔衣服
	BaoXiang_jshlzb	[	42	]	=	392		BaoXiang_jshlzb_Rad	[	42	]	=	400		BaoXiang_jshlzb_Count	[	42	]	=	1	--	宝贝兔衣服
	BaoXiang_jshlzb	[	43	]	=	393		BaoXiang_jshlzb_Rad	[	43	]	=	400		BaoXiang_jshlzb_Count	[	43	]	=	1	--	祝福兔衣服
	BaoXiang_jshlzb	[	44	]	=	394		BaoXiang_jshlzb_Rad	[	44	]	=	400		BaoXiang_jshlzb_Count	[	44	]	=	1	--	天赐衣服
	BaoXiang_jshlzb	[	45	]	=	1960		BaoXiang_jshlzb_Rad	[	45	]	=	400		BaoXiang_jshlzb_Count	[	45	]	=	1	--	希尔外套
	BaoXiang_jshlzb	[	46	]	=	1961		BaoXiang_jshlzb_Rad	[	46	]	=	400		BaoXiang_jshlzb_Count	[	46	]	=	1	--	鸾凤外套
	BaoXiang_jshlzb	[	47	]	=	316		BaoXiang_jshlzb_Rad	[	47	]	=	400		BaoXiang_jshlzb_Count	[	47	]	=	1	--	斑鸠衣服
	BaoXiang_jshlzb	[	48	]	=	317		BaoXiang_jshlzb_Rad	[	48	]	=	400		BaoXiang_jshlzb_Count	[	48	]	=	1	--	猛禽衣服
	BaoXiang_jshlzb	[	49	]	=	304		BaoXiang_jshlzb_Rad	[	49	]	=	400		BaoXiang_jshlzb_Count	[	49	]	=	1	--	典礼钢甲
	BaoXiang_jshlzb	[	50	]	=	1931		BaoXiang_jshlzb_Rad	[	50	]	=	400		BaoXiang_jshlzb_Count	[	50	]	=	1	--	麒麟战甲
	BaoXiang_jshlzb	[	51	]	=	341		BaoXiang_jshlzb_Rad	[	51	]	=	4400		BaoXiang_jshlzb_Count	[	51	]	=	1	--	甲板衣服
	BaoXiang_jshlzb	[	52	]	=	342		BaoXiang_jshlzb_Rad	[	52	]	=	4400		BaoXiang_jshlzb_Count	[	52	]	=	1	--	桅杆衣服
	BaoXiang_jshlzb	[	53	]	=	353		BaoXiang_jshlzb_Rad	[	53	]	=	4400		BaoXiang_jshlzb_Count	[	53	]	=	1	--	小鸭衣服
	BaoXiang_jshlzb	[	54	]	=	356		BaoXiang_jshlzb_Rad	[	54	]	=	4400		BaoXiang_jshlzb_Count	[	54	]	=	1	--	摇摆鸭衣服
	BaoXiang_jshlzb	[	55	]	=	1977		BaoXiang_jshlzb_Rad	[	55	]	=	4400		BaoXiang_jshlzb_Count	[	55	]	=	1	--	风暴外套
	BaoXiang_jshlzb	[	56	]	=	1956		BaoXiang_jshlzb_Rad	[	56	]	=	4400		BaoXiang_jshlzb_Count	[	56	]	=	1	--	冷月外衣
	BaoXiang_jshlzb	[	57	]	=	385		BaoXiang_jshlzb_Rad	[	57	]	=	4400		BaoXiang_jshlzb_Count	[	57	]	=	1	--	海獭衣服
	BaoXiang_jshlzb	[	58	]	=	375		BaoXiang_jshlzb_Rad	[	58	]	=	4400		BaoXiang_jshlzb_Count	[	58	]	=	1	--	远行衣服
	BaoXiang_jshlzb	[	59	]	=	369		BaoXiang_jshlzb_Rad	[	59	]	=	4400		BaoXiang_jshlzb_Count	[	59	]	=	1	--	侍者衣服
	BaoXiang_jshlzb	[	60	]	=	362		BaoXiang_jshlzb_Rad	[	60	]	=	4400		BaoXiang_jshlzb_Count	[	60	]	=	1	--	蹦蹦鼠衣服
	BaoXiang_jshlzb	[	61	]	=	1959		BaoXiang_jshlzb_Rad	[	61	]	=	4400		BaoXiang_jshlzb_Count	[	61	]	=	1	--	耀日外衣
	BaoXiang_jshlzb	[	62	]	=	382		BaoXiang_jshlzb_Rad	[	62	]	=	4400		BaoXiang_jshlzb_Count	[	62	]	=	1	--	长耳兔衣服
	BaoXiang_jshlzb	[	63	]	=	388		BaoXiang_jshlzb_Rad	[	63	]	=	4400		BaoXiang_jshlzb_Count	[	63	]	=	1	--	快乐兔衣服
	BaoXiang_jshlzb	[	64	]	=	392		BaoXiang_jshlzb_Rad	[	64	]	=	4400		BaoXiang_jshlzb_Count	[	64	]	=	1	--	宝贝兔衣服
	BaoXiang_jshlzb	[	65	]	=	314		BaoXiang_jshlzb_Rad	[	65	]	=	4400		BaoXiang_jshlzb_Count	[	65	]	=	1	--	敏捷衣服
	BaoXiang_jshlzb	[	66	]	=	315		BaoXiang_jshlzb_Rad	[	66	]	=	4400		BaoXiang_jshlzb_Count	[	66	]	=	1	--	山雀衣服
	BaoXiang_jshlzb	[	67	]	=	302		BaoXiang_jshlzb_Rad	[	67	]	=	4400		BaoXiang_jshlzb_Count	[	67	]	=	1	--	轻便钢甲
	BaoXiang_jshlzb	[	68	]	=	303		BaoXiang_jshlzb_Rad	[	68	]	=	4400		BaoXiang_jshlzb_Count	[	68	]	=	1	--	镀银钢甲
	BaoXiang_jshlzb	[	69	]	=	1929		BaoXiang_jshlzb_Rad	[	69	]	=	4400		BaoXiang_jshlzb_Count	[	69	]	=	1	--	疾风战甲
	BaoXiang_jshlzb	[	70	]	=	1930		BaoXiang_jshlzb_Rad	[	70	]	=	4400		BaoXiang_jshlzb_Count	[	70	]	=	1	--	西斯战甲

																						
	BaoXiang_jshlta_Qua	=	24	 			BaoXiang_jshlta_Mxcount	=	9												
	BaoXiang_jshlta	=	{}					BaoXiang_jshlta_Rad	=	{}					BaoXiang_jshlta_Count	=	{}					
	BaoXiang_jshlta	[	1	]	=	0848		BaoXiang_jshlta_Rad	[	1	]	=	1 		BaoXiang_jshlta_Count	[	1	]	=	1	--	黑龙之首
	BaoXiang_jshlta	[	2	]	=	2215		BaoXiang_jshlta_Rad	[	2	]	=	1000		BaoXiang_jshlta_Count	[	2	]	=	1	--	祝福兔帽子
	BaoXiang_jshlta	[	3	]	=	2201		BaoXiang_jshlta_Rad	[	3	]	=	1000		BaoXiang_jshlta_Count	[	3	]	=	1	--	祝福海獭帽子
	BaoXiang_jshlta	[	4	]	=	2200		BaoXiang_jshlta_Rad	[	4	]	=	4000		BaoXiang_jshlta_Count	[	4	]	=	1	--	高级海獭帽子
	BaoXiang_jshlta	[	5	]	=	2213		BaoXiang_jshlta_Rad	[	5	]	=	4000		BaoXiang_jshlta_Count	[	5	]	=	1	--	高级兔帽子
	BaoXiang_jshlta	[	6	]	=	2207		BaoXiang_jshlta_Rad	[	6	]	=	22500	BaoXiang_jshlta_Count	[	6	]	=	1	--	海獭帽子
	BaoXiang_jshlta	[	7	]	=	2210		BaoXiang_jshlta_Rad	[	7	]	=	22500	BaoXiang_jshlta_Count	[	7	]	=	1	--	快乐兔帽子
	BaoXiang_jshlta	[	8	]	=	2214		BaoXiang_jshlta_Rad	[	8	]	=	22500	BaoXiang_jshlta_Count	[	8	]	=	1	--	宝贝兔帽子
	BaoXiang_jshlta	[	9	]	=	2212		BaoXiang_jshlta_Rad	[	9	]	=	22500	BaoXiang_jshlta_Count	[	9	]	=	1	--	袋鼠帽子
																						
																						
	BaoXiang_jshlsa_Qua	=	24	 			BaoXiang_jshlsa_Mxcount	=	43												
	BaoXiang_jshlsa	=	{}					BaoXiang_jshlsa_Rad	=	{}					BaoXiang_jshlsa_Count	=	{}					
	BaoXiang_jshlsa	[	1	]	=	0846		BaoXiang_jshlsa_Rad	[	1	]	=	1 		BaoXiang_jshlsa_Count	[	1	]	=	1	--	黑龙之爪
	BaoXiang_jshlsa	[	2	]	=	1988		BaoXiang_jshlsa_Rad	[	2	]	=	20 		BaoXiang_jshlsa_Count	[	2	]	=	1	--	烈焰封印的幻灵战甲手套
	BaoXiang_jshlsa	[	3	]	=	1990		BaoXiang_jshlsa_Rad	[	3	]	=	20 		BaoXiang_jshlsa_Count	[	3	]	=	1	--	烈焰封印的幻灵护手
	BaoXiang_jshlsa	[	4	]	=	1992		BaoXiang_jshlsa_Rad	[	4	]	=	20 		BaoXiang_jshlsa_Count	[	4	]	=	1	--	烈焰封印的幻咒手套
	BaoXiang_jshlsa	[	5	]	=	1993		BaoXiang_jshlsa_Rad	[	5	]	=	20 		BaoXiang_jshlsa_Count	[	5	]	=	1	--	烈焰封印的幻法手套
	BaoXiang_jshlsa	[	6	]	=	1996		BaoXiang_jshlsa_Rad	[	6	]	=	20 		BaoXiang_jshlsa_Count	[	6	]	=	1	--	烈焰封印的幻灵皮手套
	BaoXiang_jshlsa	[	7	]	=	0588		BaoXiang_jshlsa_Rad	[	7	]	=	450 		BaoXiang_jshlsa_Count	[	7	]	=	1	--	隐秘手套
	BaoXiang_jshlsa	[	8	]	=	0590		BaoXiang_jshlsa_Rad	[	8	]	=	450 		BaoXiang_jshlsa_Count	[	8	]	=	1	--	射日手套
	BaoXiang_jshlsa	[	9	]	=	0592		BaoXiang_jshlsa_Rad	[	9	]	=	450 		BaoXiang_jshlsa_Count	[	9	]	=	1	--	神士手套
	BaoXiang_jshlsa	[	10	]	=	0594		BaoXiang_jshlsa_Rad	[	10	]	=	450 		BaoXiang_jshlsa_Count	[	10	]	=	1	--	神奇熊猫手套
	BaoXiang_jshlsa	[	11	]	=	0596		BaoXiang_jshlsa_Rad	[	11	]	=	450 		BaoXiang_jshlsa_Count	[	11	]	=	1	--	飞天手套
	BaoXiang_jshlsa	[	12	]	=	0598		BaoXiang_jshlsa_Rad	[	12	]	=	450 		BaoXiang_jshlsa_Count	[	12	]	=	1	--	鱼仙子手套
	BaoXiang_jshlsa	[	13	]	=	0600		BaoXiang_jshlsa_Rad	[	13	]	=	450 		BaoXiang_jshlsa_Count	[	13	]	=	1	--	怒涛手套
	BaoXiang_jshlsa	[	14	]	=	1938		BaoXiang_jshlsa_Rad	[	14	]	=	750 		BaoXiang_jshlsa_Count	[	14	]	=	1	--	麒麟手套
	BaoXiang_jshlsa	[	15	]	=	1950		BaoXiang_jshlsa_Rad	[	15	]	=	750 		BaoXiang_jshlsa_Count	[	15	]	=	1	--	白虎手套
	BaoXiang_jshlsa	[	16	]	=	1965		BaoXiang_jshlsa_Rad	[	16	]	=	750		BaoXiang_jshlsa_Count	[	16	]	=	1	--	朱雀手套
	BaoXiang_jshlsa	[	17	]	=	1968		BaoXiang_jshlsa_Rad	[	17	]	=	750 		BaoXiang_jshlsa_Count	[	17	]	=	1	--	鸾凤手套
	BaoXiang_jshlsa	[	18	]	=	1983		BaoXiang_jshlsa_Rad	[	18	]	=	750 		BaoXiang_jshlsa_Count	[	18	]	=	1	--	青龙手套
	BaoXiang_jshlsa	[	19	]	=	0540		BaoXiang_jshlsa_Rad	[	19	]	=	750 		BaoXiang_jshlsa_Count	[	19	]	=	1	--	祝福海獭手套
	BaoXiang_jshlsa	[	20	]	=	0539		BaoXiang_jshlsa_Rad	[	20	]	=	750 		BaoXiang_jshlsa_Count	[	20	]	=	1	--	高级海獭手套
	BaoXiang_jshlsa	[	21	]	=	0555		BaoXiang_jshlsa_Rad	[	21	]	=	750 		BaoXiang_jshlsa_Count	[	21	]	=	1	--	祈愿手套		
	BaoXiang_jshlsa	[	22	]	=	0567		BaoXiang_jshlsa_Rad	[	22	]	=	750 		BaoXiang_jshlsa_Count	[	22	]	=	1	--	高级兔手套		
	BaoXiang_jshlsa	[	23	]	=	0569		BaoXiang_jshlsa_Rad	[	23	]	=	750 		BaoXiang_jshlsa_Count	[	23	]	=	1	--	祝福兔手套		
	BaoXiang_jshlsa	[	24	]	=	0570		BaoXiang_jshlsa_Rad	[	24	]	=	750 		BaoXiang_jshlsa_Count	[	24	]	=	1	--	天赐手套		
	BaoXiang_jshlsa	[	25	]	=	0545		BaoXiang_jshlsa_Rad	[	25	]	=	3400		BaoXiang_jshlsa_Count	[	25	]	=	1	--	侍者手套		
	BaoXiang_jshlsa	[	26	]	=	0547		BaoXiang_jshlsa_Rad	[	26	]	=	3400		BaoXiang_jshlsa_Count	[	26	]	=	1	--	信仰手套		
	BaoXiang_jshlsa	[	27	]	=	0551		BaoXiang_jshlsa_Rad	[	27	]	=	3400		BaoXiang_jshlsa_Count	[	27	]	=	1	--	远行手套		
	BaoXiang_jshlsa	[	28	]	=	0554		BaoXiang_jshlsa_Rad	[	28	]	=	3400		BaoXiang_jshlsa_Count	[	28	]	=	1	--	虔诚手套		
	BaoXiang_jshlsa	[	29	]	=	0558		BaoXiang_jshlsa_Rad	[	29	]	=	3400		BaoXiang_jshlsa_Count	[	29	]	=	1	--	长耳兔手套		
	BaoXiang_jshlsa	[	30	]	=	0561		BaoXiang_jshlsa_Rad	[	30	]	=	3400		BaoXiang_jshlsa_Count	[	30	]	=	1	--	海獭手套		
	BaoXiang_jshlsa	[	31	]	=	0564		BaoXiang_jshlsa_Rad	[	31	]	=	3400		BaoXiang_jshlsa_Count	[	31	]	=	1	--	快乐兔手套		
	BaoXiang_jshlsa	[	32	]	=	0471		BaoXiang_jshlsa_Rad	[	32	]	=	5400		BaoXiang_jshlsa_Count	[	32	]	=	1	--	铁手套		
	BaoXiang_jshlsa	[	33	]	=	0476		BaoXiang_jshlsa_Rad	[	33	]	=	5400		BaoXiang_jshlsa_Count	[	33	]	=	1	--	锁手套		
	BaoXiang_jshlsa	[	34	]	=	0486		BaoXiang_jshlsa_Rad	[	34	]	=	5400		BaoXiang_jshlsa_Count	[	34	]	=	1	--	短羽手套		
	BaoXiang_jshlsa	[	35	]	=	0517		BaoXiang_jshlsa_Rad	[	35	]	=	5400		BaoXiang_jshlsa_Count	[	35	]	=	1	--	甲板手套		
	BaoXiang_jshlsa	[	36	]	=	0529		BaoXiang_jshlsa_Rad	[	36	]	=	5400		BaoXiang_jshlsa_Count	[	36	]	=	1	--	小鸭手套		
	BaoXiang_jshlsa	[	37	]	=	0543		BaoXiang_jshlsa_Rad	[	37	]	=	5400		BaoXiang_jshlsa_Count	[	37	]	=	1	--	旅者手套		
	BaoXiang_jshlsa	[	38	]	=	0566		BaoXiang_jshlsa_Rad	[	38	]	=	5400		BaoXiang_jshlsa_Count	[	38	]	=	1	--	袋鼠手套		
	BaoXiang_jshlsa	[	39	]	=	1936		BaoXiang_jshlsa_Rad	[	39	]	=	5400		BaoXiang_jshlsa_Count	[	39	]	=	1	--	疾风手套		
	BaoXiang_jshlsa	[	40	]	=	1948		BaoXiang_jshlsa_Rad	[	40	]	=	5400		BaoXiang_jshlsa_Count	[	40	]	=	1	--	烈火手套		
	BaoXiang_jshlsa	[	41	]	=	1963		BaoXiang_jshlsa_Rad	[	41	]	=	5400		BaoXiang_jshlsa_Count	[	41	]	=	1	--	冷月手套		
	BaoXiang_jshlsa	[	42	]	=	1966		BaoXiang_jshlsa_Rad	[	42	]	=	5400		BaoXiang_jshlsa_Count	[	42	]	=	1	--	耀日手套		
	BaoXiang_jshlsa	[	43	]	=	1981		BaoXiang_jshlsa_Rad	[	43	]	=	5400		BaoXiang_jshlsa_Count	[	43	]	=	1	--	风暴手套		
																								
																								
																								
	BaoXiang_jshlsb_Qua	=	23	 			BaoXiang_jshlsb_Mxcount	=	43												
	BaoXiang_jshlsb	=	{}					BaoXiang_jshlsb_Rad	=	{}					BaoXiang_jshlsb_Count	=	{}					
	BaoXiang_jshlsb	[	1	]	=	846		BaoXiang_jshlsb_Rad	[	1	]	=	1		BaoXiang_jshlsb_Count	[	1	]	=	1	--	黑龙之爪
	BaoXiang_jshlsb	[	2	]	=	1988		BaoXiang_jshlsb_Rad	[	2	]	=	60		BaoXiang_jshlsb_Count	[	2	]	=	1	--	烈焰封印的幻灵战甲手套
	BaoXiang_jshlsb	[	3	]	=	1990		BaoXiang_jshlsb_Rad	[	3	]	=	60		BaoXiang_jshlsb_Count	[	3	]	=	1	--	烈焰封印的幻灵护手
	BaoXiang_jshlsb	[	4	]	=	1992		BaoXiang_jshlsb_Rad	[	4	]	=	60		BaoXiang_jshlsb_Count	[	4	]	=	1	--	烈焰封印的幻咒手套
	BaoXiang_jshlsb	[	5	]	=	1993		BaoXiang_jshlsb_Rad	[	5	]	=	60		BaoXiang_jshlsb_Count	[	5	]	=	1	--	烈焰封印的幻法手套
	BaoXiang_jshlsb	[	6	]	=	1996		BaoXiang_jshlsb_Rad	[	6	]	=	60		BaoXiang_jshlsb_Count	[	6	]	=	1	--	烈焰封印的幻灵皮手套
	BaoXiang_jshlsb	[	7	]	=	588		BaoXiang_jshlsb_Rad	[	7	]	=	400		BaoXiang_jshlsb_Count	[	7	]	=	1	--	隐秘手套
	BaoXiang_jshlsb	[	8	]	=	590		BaoXiang_jshlsb_Rad	[	8	]	=	400		BaoXiang_jshlsb_Count	[	8	]	=	1	--	射日手套
	BaoXiang_jshlsb	[	9	]	=	592		BaoXiang_jshlsb_Rad	[	9	]	=	400		BaoXiang_jshlsb_Count	[	9	]	=	1	--	神士手套
	BaoXiang_jshlsb	[	10	]	=	594		BaoXiang_jshlsb_Rad	[	10	]	=	400		BaoXiang_jshlsb_Count	[	10	]	=	1	--	神奇熊猫手套
	BaoXiang_jshlsb	[	11	]	=	596		BaoXiang_jshlsb_Rad	[	11	]	=	400		BaoXiang_jshlsb_Count	[	11	]	=	1	--	飞天手套
	BaoXiang_jshlsb	[	12	]	=	598		BaoXiang_jshlsb_Rad	[	12	]	=	400		BaoXiang_jshlsb_Count	[	12	]	=	1	--	鱼仙子手套
	BaoXiang_jshlsb	[	13	]	=	600		BaoXiang_jshlsb_Rad	[	13	]	=	400		BaoXiang_jshlsb_Count	[	13	]	=	1	--	怒涛手套
	BaoXiang_jshlsb	[	14	]	=	1938		BaoXiang_jshlsb_Rad	[	14	]	=	700		BaoXiang_jshlsb_Count	[	14	]	=	1	--	麒麟手套
	BaoXiang_jshlsb	[	15	]	=	1950		BaoXiang_jshlsb_Rad	[	15	]	=	700		BaoXiang_jshlsb_Count	[	15	]	=	1	--	白虎手套
	BaoXiang_jshlsb	[	16	]	=	1965		BaoXiang_jshlsb_Rad	[	16	]	=	700		BaoXiang_jshlsb_Count	[	16	]	=	1	--	朱雀手套
	BaoXiang_jshlsb	[	17	]	=	1968		BaoXiang_jshlsb_Rad	[	17	]	=	700		BaoXiang_jshlsb_Count	[	17	]	=	1	--	鸾凤手套
	BaoXiang_jshlsb	[	18	]	=	1983		BaoXiang_jshlsb_Rad	[	18	]	=	700		BaoXiang_jshlsb_Count	[	18	]	=	1	--	青龙手套
	BaoXiang_jshlsb	[	19	]	=	540		BaoXiang_jshlsb_Rad	[	19	]	=	700		BaoXiang_jshlsb_Count	[	19	]	=	1	--	祝福海獭手套
	BaoXiang_jshlsb	[	20	]	=	539		BaoXiang_jshlsb_Rad	[	20	]	=	700		BaoXiang_jshlsb_Count	[	20	]	=	1	--	高级海獭手套
	BaoXiang_jshlsb	[	21	]	=	555		BaoXiang_jshlsb_Rad	[	21	]	=	700		BaoXiang_jshlsb_Count	[	21	]	=	1	--	祈愿手套
	BaoXiang_jshlsb	[	22	]	=	567		BaoXiang_jshlsb_Rad	[	22	]	=	700		BaoXiang_jshlsb_Count	[	22	]	=	1	--	高级兔手套
	BaoXiang_jshlsb	[	23	]	=	569		BaoXiang_jshlsb_Rad	[	23	]	=	700		BaoXiang_jshlsb_Count	[	23	]	=	1	--	祝福兔手套
	BaoXiang_jshlsb	[	24	]	=	570		BaoXiang_jshlsb_Rad	[	24	]	=	700		BaoXiang_jshlsb_Count	[	24	]	=	1	--	天赐手套
	BaoXiang_jshlsb	[	25	]	=	545		BaoXiang_jshlsb_Rad	[	25	]	=	3000		BaoXiang_jshlsb_Count	[	25	]	=	1	--	侍者手套
	BaoXiang_jshlsb	[	26	]	=	547		BaoXiang_jshlsb_Rad	[	26	]	=	3000		BaoXiang_jshlsb_Count	[	26	]	=	1	--	信仰手套
	BaoXiang_jshlsb	[	27	]	=	551		BaoXiang_jshlsb_Rad	[	27	]	=	3000		BaoXiang_jshlsb_Count	[	27	]	=	1	--	远行手套
	BaoXiang_jshlsb	[	28	]	=	554		BaoXiang_jshlsb_Rad	[	28	]	=	3000		BaoXiang_jshlsb_Count	[	28	]	=	1	--	虔诚手套
	BaoXiang_jshlsb	[	29	]	=	558		BaoXiang_jshlsb_Rad	[	29	]	=	3000		BaoXiang_jshlsb_Count	[	29	]	=	1	--	长耳兔手套
	BaoXiang_jshlsb	[	30	]	=	561		BaoXiang_jshlsb_Rad	[	30	]	=	3000		BaoXiang_jshlsb_Count	[	30	]	=	1	--	海獭手套
	BaoXiang_jshlsb	[	31	]	=	564		BaoXiang_jshlsb_Rad	[	31	]	=	3000		BaoXiang_jshlsb_Count	[	31	]	=	1	--	快乐兔手套
	BaoXiang_jshlsb	[	32	]	=	471		BaoXiang_jshlsb_Rad	[	32	]	=	6000		BaoXiang_jshlsb_Count	[	32	]	=	1	--	铁手套
	BaoXiang_jshlsb	[	33	]	=	476		BaoXiang_jshlsb_Rad	[	33	]	=	6000		BaoXiang_jshlsb_Count	[	33	]	=	1	--	锁手套
	BaoXiang_jshlsb	[	34	]	=	486		BaoXiang_jshlsb_Rad	[	34	]	=	6000		BaoXiang_jshlsb_Count	[	34	]	=	1	--	短羽手套
	BaoXiang_jshlsb	[	35	]	=	517		BaoXiang_jshlsb_Rad	[	35	]	=	6000		BaoXiang_jshlsb_Count	[	35	]	=	1	--	甲板手套
	BaoXiang_jshlsb	[	36	]	=	529		BaoXiang_jshlsb_Rad	[	36	]	=	6000		BaoXiang_jshlsb_Count	[	36	]	=	1	--	小鸭手套
	BaoXiang_jshlsb	[	37	]	=	543		BaoXiang_jshlsb_Rad	[	37	]	=	6000		BaoXiang_jshlsb_Count	[	37	]	=	1	--	旅者手套
	BaoXiang_jshlsb	[	38	]	=	566		BaoXiang_jshlsb_Rad	[	38	]	=	6000		BaoXiang_jshlsb_Count	[	38	]	=	1	--	袋鼠手套
	BaoXiang_jshlsb	[	39	]	=	1936		BaoXiang_jshlsb_Rad	[	39	]	=	6000		BaoXiang_jshlsb_Count	[	39	]	=	1	--	疾风手套
	BaoXiang_jshlsb	[	40	]	=	1948		BaoXiang_jshlsb_Rad	[	40	]	=	6000		BaoXiang_jshlsb_Count	[	40	]	=	1	--	烈火手套
	BaoXiang_jshlsb	[	41	]	=	1963		BaoXiang_jshlsb_Rad	[	41	]	=	6000		BaoXiang_jshlsb_Count	[	41	]	=	1	--	冷月手套
	BaoXiang_jshlsb	[	42	]	=	1966		BaoXiang_jshlsb_Rad	[	42	]	=	6000		BaoXiang_jshlsb_Count	[	42	]	=	1	--	耀日手套
	BaoXiang_jshlsb	[	43	]	=	1981		BaoXiang_jshlsb_Rad	[	43	]	=	6000		BaoXiang_jshlsb_Count	[	43	]	=	1	--	风暴手套


	BaoXiang_jshlya_Qua	=	24	 			BaoXiang_jshlya_Mxcount	=	65												
	BaoXiang_jshlya	=	{}					BaoXiang_jshlya_Rad	=	{}					BaoXiang_jshlya_Count	=	{}					
	BaoXiang_jshlya	[	1	]	=	847		BaoXiang_jshlya_Rad	[	1	]	=	1		BaoXiang_jshlya_Count	[	1	]	=	1	--	黑龙之翼
	BaoXiang_jshlya	[	2	]	=	1989		BaoXiang_jshlya_Rad	[	2	]	=	120		BaoXiang_jshlya_Count	[	2	]	=	1	--	烈焰封印的幻灵战甲靴
	BaoXiang_jshlya	[	3	]	=	1991		BaoXiang_jshlya_Rad	[	3	]	=	120		BaoXiang_jshlya_Count	[	3	]	=	1	--	烈焰封印的幻灵护腿
	BaoXiang_jshlya	[	4	]	=	1994		BaoXiang_jshlya_Rad	[	4	]	=	120		BaoXiang_jshlya_Count	[	4	]	=	1	--	烈焰封印的幻咒靴
	BaoXiang_jshlya	[	5	]	=	1995		BaoXiang_jshlya_Rad	[	5	]	=	120		BaoXiang_jshlya_Count	[	5	]	=	1	--	烈焰封印的幻法靴
	BaoXiang_jshlya	[	6	]	=	1997		BaoXiang_jshlya_Rad	[	6	]	=	120		BaoXiang_jshlya_Count	[	6	]	=	1	--	烈焰封印的幻灵皮靴
	BaoXiang_jshlya	[	7	]	=	748		BaoXiang_jshlya_Rad	[	7	]	=	100		BaoXiang_jshlya_Count	[	7	]	=	1	--	隐秘靴
	BaoXiang_jshlya	[	8	]	=	750		BaoXiang_jshlya_Rad	[	8	]	=	100		BaoXiang_jshlya_Count	[	8	]	=	1	--	射日靴
	BaoXiang_jshlya	[	9	]	=	752		BaoXiang_jshlya_Rad	[	9	]	=	100		BaoXiang_jshlya_Count	[	9	]	=	1	--	神士靴
	BaoXiang_jshlya	[	10	]	=	754		BaoXiang_jshlya_Rad	[	10	]	=	100		BaoXiang_jshlya_Count	[	10	]	=	1	--	神奇熊猫靴
	BaoXiang_jshlya	[	11	]	=	756		BaoXiang_jshlya_Rad	[	11	]	=	100		BaoXiang_jshlya_Count	[	11	]	=	1	--	飞天靴
	BaoXiang_jshlya	[	12	]	=	758		BaoXiang_jshlya_Rad	[	12	]	=	100		BaoXiang_jshlya_Count	[	12	]	=	1	--	鱼仙子靴
	BaoXiang_jshlya	[	13	]	=	760		BaoXiang_jshlya_Rad	[	13	]	=	100		BaoXiang_jshlya_Count	[	13	]	=	1	--	怒涛靴
	BaoXiang_jshlya	[	14	]	=	830		BaoXiang_jshlya_Rad	[	14	]	=	100		BaoXiang_jshlya_Count	[	14	]	=	1	--	灵神靴
	BaoXiang_jshlya	[	15	]	=	669		BaoXiang_jshlya_Rad	[	15	]	=	450		BaoXiang_jshlya_Count	[	15	]	=	1	--	猛禽靴
	BaoXiang_jshlya	[	16	]	=	696		BaoXiang_jshlya_Rad	[	16	]	=	450		BaoXiang_jshlya_Count	[	16	]	=	1	--	漩涡靴
	BaoXiang_jshlya	[	17	]	=	710		BaoXiang_jshlya_Rad	[	17	]	=	450		BaoXiang_jshlya_Count	[	17	]	=	1	--	巨钳海虾靴
	BaoXiang_jshlya	[	18	]	=	716		BaoXiang_jshlya_Rad	[	18	]	=	450		BaoXiang_jshlya_Count	[	18	]	=	1	--	祝福海獭靴
	BaoXiang_jshlya	[	19	]	=	729		BaoXiang_jshlya_Rad	[	19	]	=	450		BaoXiang_jshlya_Count	[	19	]	=	1	--	保护者靴
	BaoXiang_jshlya	[	20	]	=	746		BaoXiang_jshlya_Rad	[	20	]	=	450		BaoXiang_jshlya_Count	[	20	]	=	1	--	天赐靴
	BaoXiang_jshlya	[	21	]	=	1942		BaoXiang_jshlya_Rad	[	21	]	=	450		BaoXiang_jshlya_Count	[	21	]	=	1	--	麒麟靴
	BaoXiang_jshlya	[	22	]	=	1954		BaoXiang_jshlya_Rad	[	22	]	=	450		BaoXiang_jshlya_Count	[	22	]	=	1	--	白虎靴
	BaoXiang_jshlya	[	23	]	=	1972		BaoXiang_jshlya_Rad	[	23	]	=	450		BaoXiang_jshlya_Count	[	23	]	=	1	--	朱雀靴
	BaoXiang_jshlya	[	24	]	=	1975		BaoXiang_jshlya_Rad	[	24	]	=	450		BaoXiang_jshlya_Count	[	24	]	=	1	--	鸾凤靴
	BaoXiang_jshlya	[	25	]	=	1987		BaoXiang_jshlya_Rad	[	25	]	=	450		BaoXiang_jshlya_Count	[	25	]	=	1	--	青龙靴
	BaoXiang_jshlya	[	26	]	=	651		BaoXiang_jshlya_Rad	[	26	]	=	900		BaoXiang_jshlya_Count	[	26	]	=	1	--	金刚靴
	BaoXiang_jshlya	[	27	]	=	655		BaoXiang_jshlya_Rad	[	27	]	=	900		BaoXiang_jshlya_Count	[	27	]	=	1	--	镀银钢靴
	BaoXiang_jshlya	[	28	]	=	668		BaoXiang_jshlya_Rad	[	28	]	=	900		BaoXiang_jshlya_Count	[	28	]	=	1	--	斑鸠靴
	BaoXiang_jshlya	[	29	]	=	695		BaoXiang_jshlya_Rad	[	29	]	=	900		BaoXiang_jshlya_Count	[	29	]	=	1	--	飓风靴
	BaoXiang_jshlya	[	30	]	=	707		BaoXiang_jshlya_Rad	[	30	]	=	900		BaoXiang_jshlya_Count	[	30	]	=	1	--	龙虾靴
	BaoXiang_jshlya	[	31	]	=	709		BaoXiang_jshlya_Rad	[	31	]	=	900		BaoXiang_jshlya_Count	[	31	]	=	1	--	大海虾靴
	BaoXiang_jshlya	[	32	]	=	715		BaoXiang_jshlya_Rad	[	32	]	=	900		BaoXiang_jshlya_Count	[	32	]	=	1	--	高级海獭靴
	BaoXiang_jshlya	[	33	]	=	728		BaoXiang_jshlya_Rad	[	33	]	=	900		BaoXiang_jshlya_Count	[	33	]	=	1	--	治疗者靴
	BaoXiang_jshlya	[	34	]	=	731		BaoXiang_jshlya_Rad	[	34	]	=	900		BaoXiang_jshlya_Count	[	34	]	=	1	--	祈愿靴
	BaoXiang_jshlya	[	35	]	=	734		BaoXiang_jshlya_Rad	[	35	]	=	900		BaoXiang_jshlya_Count	[	35	]	=	1	--	长耳兔靴
	BaoXiang_jshlya	[	36	]	=	737		BaoXiang_jshlya_Rad	[	36	]	=	900		BaoXiang_jshlya_Count	[	36	]	=	1	--	海獭靴
	BaoXiang_jshlya	[	37	]	=	743		BaoXiang_jshlya_Rad	[	37	]	=	900		BaoXiang_jshlya_Count	[	37	]	=	1	--	高级兔靴
	BaoXiang_jshlya	[	38	]	=	1941		BaoXiang_jshlya_Rad	[	38	]	=	900		BaoXiang_jshlya_Count	[	38	]	=	1	--	西斯靴
	BaoXiang_jshlya	[	39	]	=	1953		BaoXiang_jshlya_Rad	[	39	]	=	900		BaoXiang_jshlya_Count	[	39	]	=	1	--	迪尔瓦娜靴
	BaoXiang_jshlya	[	40	]	=	1971		BaoXiang_jshlya_Rad	[	40	]	=	900		BaoXiang_jshlya_Count	[	40	]	=	1	--	尤迪安靴
	BaoXiang_jshlya	[	41	]	=	1974		BaoXiang_jshlya_Rad	[	41	]	=	900		BaoXiang_jshlya_Count	[	41	]	=	1	--	希尔靴
	BaoXiang_jshlya	[	42	]	=	1986		BaoXiang_jshlya_Rad	[	42	]	=	900		BaoXiang_jshlya_Count	[	42	]	=	1	--	弗利安靴
	BaoXiang_jshlya	[	43	]	=	652		BaoXiang_jshlya_Rad	[	43	]	=	3500		BaoXiang_jshlya_Count	[	43	]	=	1	--	锁靴
	BaoXiang_jshlya	[	44	]	=	653		BaoXiang_jshlya_Rad	[	44	]	=	3500		BaoXiang_jshlya_Count	[	44	]	=	1	--	重型钢靴
	BaoXiang_jshlya	[	45	]	=	654		BaoXiang_jshlya_Rad	[	45	]	=	3500		BaoXiang_jshlya_Count	[	45	]	=	1	--	轻便钢靴
	BaoXiang_jshlya	[	46	]	=	662		BaoXiang_jshlya_Rad	[	46	]	=	3500		BaoXiang_jshlya_Count	[	46	]	=	1	--	短羽靴
	BaoXiang_jshlya	[	47	]	=	667		BaoXiang_jshlya_Rad	[	47	]	=	3500		BaoXiang_jshlya_Count	[	47	]	=	1	--	山雀靴
	BaoXiang_jshlya	[	48	]	=	693		BaoXiang_jshlya_Rad	[	48	]	=	3500		BaoXiang_jshlya_Count	[	48	]	=	1	--	甲板靴
	BaoXiang_jshlya	[	49	]	=	694		BaoXiang_jshlya_Rad	[	49	]	=	3500		BaoXiang_jshlya_Count	[	49	]	=	1	--	桅杆靴
	BaoXiang_jshlya	[	50	]	=	705		BaoXiang_jshlya_Rad	[	50	]	=	3500		BaoXiang_jshlya_Count	[	50	]	=	1	--	小鸭靴
	BaoXiang_jshlya	[	51	]	=	708		BaoXiang_jshlya_Rad	[	51	]	=	3500		BaoXiang_jshlya_Count	[	51	]	=	1	--	摇摆鸭靴
	BaoXiang_jshlya	[	52	]	=	714		BaoXiang_jshlya_Rad	[	52	]	=	3500		BaoXiang_jshlya_Count	[	52	]	=	1	--	蹦蹦鼠靴
	BaoXiang_jshlya	[	53	]	=	719		BaoXiang_jshlya_Rad	[	53	]	=	3500		BaoXiang_jshlya_Count	[	53	]	=	1	--	旅者靴
	BaoXiang_jshlya	[	54	]	=	720		BaoXiang_jshlya_Rad	[	54	]	=	3500		BaoXiang_jshlya_Count	[	54	]	=	1	--	护士靴
	BaoXiang_jshlya	[	55	]	=	722		BaoXiang_jshlya_Rad	[	55	]	=	3500		BaoXiang_jshlya_Count	[	55	]	=	1	--	圣职靴
	BaoXiang_jshlya	[	56	]	=	727		BaoXiang_jshlya_Rad	[	56	]	=	3500		BaoXiang_jshlya_Count	[	56	]	=	1	--	远行靴
	BaoXiang_jshlya	[	57	]	=	730		BaoXiang_jshlya_Rad	[	57	]	=	3500		BaoXiang_jshlya_Count	[	57	]	=	1	--	虔诚靴
	BaoXiang_jshlya	[	58	]	=	740		BaoXiang_jshlya_Rad	[	58	]	=	3500		BaoXiang_jshlya_Count	[	58	]	=	1	--	快乐兔靴
	BaoXiang_jshlya	[	59	]	=	742		BaoXiang_jshlya_Rad	[	59	]	=	3500		BaoXiang_jshlya_Count	[	59	]	=	1	--	袋鼠靴
	BaoXiang_jshlya	[	60	]	=	744		BaoXiang_jshlya_Rad	[	60	]	=	3500		BaoXiang_jshlya_Count	[	60	]	=	1	--	宝贝兔靴
	BaoXiang_jshlya	[	61	]	=	1940		BaoXiang_jshlya_Rad	[	61	]	=	3500		BaoXiang_jshlya_Count	[	61	]	=	1	--	疾风靴
	BaoXiang_jshlya	[	62	]	=	1952		BaoXiang_jshlya_Rad	[	62	]	=	3500		BaoXiang_jshlya_Count	[	62	]	=	1	--	烈火靴
	BaoXiang_jshlya	[	63	]	=	1970		BaoXiang_jshlya_Rad	[	63	]	=	3500		BaoXiang_jshlya_Count	[	63	]	=	1	--	冷月靴
	BaoXiang_jshlya	[	64	]	=	1973		BaoXiang_jshlya_Rad	[	64	]	=	3500		BaoXiang_jshlya_Count	[	64	]	=	1	--	耀日靴
	BaoXiang_jshlya	[	65	]	=	1985		BaoXiang_jshlya_Rad	[	65	]	=	3500		BaoXiang_jshlya_Count	[	65	]	=	1	--	风暴靴


	BaoXiang_jshlyb_Qua	=	23	 			BaoXiang_jshlyb_Mxcount	=	65												
	BaoXiang_jshlyb	=	{}					BaoXiang_jshlyb_Rad	=	{}					BaoXiang_jshlyb_Count	=	{}					
	BaoXiang_jshlyb	[	1	]	=	847		BaoXiang_jshlyb_Rad	[	1	]	=	1		BaoXiang_jshlyb_Count	[	1	]	=	1	--	黑龙之翼
	BaoXiang_jshlyb	[	2	]	=	1989		BaoXiang_jshlyb_Rad	[	2	]	=	80		BaoXiang_jshlyb_Count	[	2	]	=	1	--	烈焰封印的幻灵战甲靴
	BaoXiang_jshlyb	[	3	]	=	1991		BaoXiang_jshlyb_Rad	[	3	]	=	80		BaoXiang_jshlyb_Count	[	3	]	=	1	--	烈焰封印的幻灵护腿
	BaoXiang_jshlyb	[	4	]	=	1994		BaoXiang_jshlyb_Rad	[	4	]	=	80		BaoXiang_jshlyb_Count	[	4	]	=	1	--	烈焰封印的幻咒靴
	BaoXiang_jshlyb	[	5	]	=	1995		BaoXiang_jshlyb_Rad	[	5	]	=	80		BaoXiang_jshlyb_Count	[	5	]	=	1	--	烈焰封印的幻法靴
	BaoXiang_jshlyb	[	6	]	=	1997		BaoXiang_jshlyb_Rad	[	6	]	=	80		BaoXiang_jshlyb_Count	[	6	]	=	1	--	烈焰封印的幻灵皮靴
	BaoXiang_jshlyb	[	7	]	=	748		BaoXiang_jshlyb_Rad	[	7	]	=	60		BaoXiang_jshlyb_Count	[	7	]	=	1	--	隐秘靴
	BaoXiang_jshlyb	[	8	]	=	750		BaoXiang_jshlyb_Rad	[	8	]	=	60		BaoXiang_jshlyb_Count	[	8	]	=	1	--	射日靴
	BaoXiang_jshlyb	[	9	]	=	752		BaoXiang_jshlyb_Rad	[	9	]	=	60		BaoXiang_jshlyb_Count	[	9	]	=	1	--	神士靴
	BaoXiang_jshlyb	[	10	]	=	754		BaoXiang_jshlyb_Rad	[	10	]	=	60		BaoXiang_jshlyb_Count	[	10	]	=	1	--	神奇熊猫靴
	BaoXiang_jshlyb	[	11	]	=	756		BaoXiang_jshlyb_Rad	[	11	]	=	60		BaoXiang_jshlyb_Count	[	11	]	=	1	--	飞天靴
	BaoXiang_jshlyb	[	12	]	=	758		BaoXiang_jshlyb_Rad	[	12	]	=	60		BaoXiang_jshlyb_Count	[	12	]	=	1	--	鱼仙子靴
	BaoXiang_jshlyb	[	13	]	=	760		BaoXiang_jshlyb_Rad	[	13	]	=	60		BaoXiang_jshlyb_Count	[	13	]	=	1	--	怒涛靴
	BaoXiang_jshlyb	[	14	]	=	830		BaoXiang_jshlyb_Rad	[	14	]	=	60		BaoXiang_jshlyb_Count	[	14	]	=	1	--	灵神靴
	BaoXiang_jshlyb	[	15	]	=	669		BaoXiang_jshlyb_Rad	[	15	]	=	300		BaoXiang_jshlyb_Count	[	15	]	=	1	--	猛禽靴
	BaoXiang_jshlyb	[	16	]	=	696		BaoXiang_jshlyb_Rad	[	16	]	=	300		BaoXiang_jshlyb_Count	[	16	]	=	1	--	漩涡靴
	BaoXiang_jshlyb	[	17	]	=	710		BaoXiang_jshlyb_Rad	[	17	]	=	300		BaoXiang_jshlyb_Count	[	17	]	=	1	--	巨钳海虾靴
	BaoXiang_jshlyb	[	18	]	=	716		BaoXiang_jshlyb_Rad	[	18	]	=	300		BaoXiang_jshlyb_Count	[	18	]	=	1	--	祝福海獭靴
	BaoXiang_jshlyb	[	19	]	=	729		BaoXiang_jshlyb_Rad	[	19	]	=	300		BaoXiang_jshlyb_Count	[	19	]	=	1	--	保护者靴
	BaoXiang_jshlyb	[	20	]	=	746		BaoXiang_jshlyb_Rad	[	20	]	=	300		BaoXiang_jshlyb_Count	[	20	]	=	1	--	天赐靴
	BaoXiang_jshlyb	[	21	]	=	1942		BaoXiang_jshlyb_Rad	[	21	]	=	300		BaoXiang_jshlyb_Count	[	21	]	=	1	--	麒麟靴
	BaoXiang_jshlyb	[	22	]	=	1954		BaoXiang_jshlyb_Rad	[	22	]	=	300		BaoXiang_jshlyb_Count	[	22	]	=	1	--	白虎靴
	BaoXiang_jshlyb	[	23	]	=	1972		BaoXiang_jshlyb_Rad	[	23	]	=	300		BaoXiang_jshlyb_Count	[	23	]	=	1	--	朱雀靴
	BaoXiang_jshlyb	[	24	]	=	1975		BaoXiang_jshlyb_Rad	[	24	]	=	300		BaoXiang_jshlyb_Count	[	24	]	=	1	--	鸾凤靴
	BaoXiang_jshlyb	[	25	]	=	1987		BaoXiang_jshlyb_Rad	[	25	]	=	300		BaoXiang_jshlyb_Count	[	25	]	=	1	--	青龙靴
	BaoXiang_jshlyb	[	26	]	=	651		BaoXiang_jshlyb_Rad	[	26	]	=	900		BaoXiang_jshlyb_Count	[	26	]	=	1	--	金刚靴
	BaoXiang_jshlyb	[	27	]	=	655		BaoXiang_jshlyb_Rad	[	27	]	=	900		BaoXiang_jshlyb_Count	[	27	]	=	1	--	镀银钢靴
	BaoXiang_jshlyb	[	28	]	=	668		BaoXiang_jshlyb_Rad	[	28	]	=	900		BaoXiang_jshlyb_Count	[	28	]	=	1	--	斑鸠靴
	BaoXiang_jshlyb	[	29	]	=	695		BaoXiang_jshlyb_Rad	[	29	]	=	900		BaoXiang_jshlyb_Count	[	29	]	=	1	--	飓风靴
	BaoXiang_jshlyb	[	30	]	=	707		BaoXiang_jshlyb_Rad	[	30	]	=	900		BaoXiang_jshlyb_Count	[	30	]	=	1	--	龙虾靴
	BaoXiang_jshlyb	[	31	]	=	709		BaoXiang_jshlyb_Rad	[	31	]	=	900		BaoXiang_jshlyb_Count	[	31	]	=	1	--	大海虾靴
	BaoXiang_jshlyb	[	32	]	=	715		BaoXiang_jshlyb_Rad	[	32	]	=	900		BaoXiang_jshlyb_Count	[	32	]	=	1	--	高级海獭靴
	BaoXiang_jshlyb	[	33	]	=	728		BaoXiang_jshlyb_Rad	[	33	]	=	900		BaoXiang_jshlyb_Count	[	33	]	=	1	--	治疗者靴
	BaoXiang_jshlyb	[	34	]	=	731		BaoXiang_jshlyb_Rad	[	34	]	=	900		BaoXiang_jshlyb_Count	[	34	]	=	1	--	祈愿靴
	BaoXiang_jshlyb	[	35	]	=	734		BaoXiang_jshlyb_Rad	[	35	]	=	900		BaoXiang_jshlyb_Count	[	35	]	=	1	--	长耳兔靴
	BaoXiang_jshlyb	[	36	]	=	737		BaoXiang_jshlyb_Rad	[	36	]	=	900		BaoXiang_jshlyb_Count	[	36	]	=	1	--	海獭靴
	BaoXiang_jshlyb	[	37	]	=	743		BaoXiang_jshlyb_Rad	[	37	]	=	900		BaoXiang_jshlyb_Count	[	37	]	=	1	--	高级兔靴
	BaoXiang_jshlyb	[	38	]	=	1941		BaoXiang_jshlyb_Rad	[	38	]	=	900		BaoXiang_jshlyb_Count	[	38	]	=	1	--	西斯靴
	BaoXiang_jshlyb	[	39	]	=	1953		BaoXiang_jshlyb_Rad	[	39	]	=	900		BaoXiang_jshlyb_Count	[	39	]	=	1	--	迪尔瓦娜靴
	BaoXiang_jshlyb	[	40	]	=	1971		BaoXiang_jshlyb_Rad	[	40	]	=	900		BaoXiang_jshlyb_Count	[	40	]	=	1	--	尤迪安靴
	BaoXiang_jshlyb	[	41	]	=	1974		BaoXiang_jshlyb_Rad	[	41	]	=	900		BaoXiang_jshlyb_Count	[	41	]	=	1	--	希尔靴
	BaoXiang_jshlyb	[	42	]	=	1986		BaoXiang_jshlyb_Rad	[	42	]	=	900		BaoXiang_jshlyb_Count	[	42	]	=	1	--	弗利安靴
	BaoXiang_jshlyb	[	43	]	=	652		BaoXiang_jshlyb_Rad	[	43	]	=	3700		BaoXiang_jshlyb_Count	[	43	]	=	1	--	锁靴
	BaoXiang_jshlyb	[	44	]	=	653		BaoXiang_jshlyb_Rad	[	44	]	=	3700		BaoXiang_jshlyb_Count	[	44	]	=	1	--	重型钢靴
	BaoXiang_jshlyb	[	45	]	=	654		BaoXiang_jshlyb_Rad	[	45	]	=	3700		BaoXiang_jshlyb_Count	[	45	]	=	1	--	轻便钢靴
	BaoXiang_jshlyb	[	46	]	=	662		BaoXiang_jshlyb_Rad	[	46	]	=	3700		BaoXiang_jshlyb_Count	[	46	]	=	1	--	短羽靴
	BaoXiang_jshlyb	[	47	]	=	667		BaoXiang_jshlyb_Rad	[	47	]	=	3700		BaoXiang_jshlyb_Count	[	47	]	=	1	--	山雀靴
	BaoXiang_jshlyb	[	48	]	=	693		BaoXiang_jshlyb_Rad	[	48	]	=	3700		BaoXiang_jshlyb_Count	[	48	]	=	1	--	甲板靴
	BaoXiang_jshlyb	[	49	]	=	694		BaoXiang_jshlyb_Rad	[	49	]	=	3700		BaoXiang_jshlyb_Count	[	49	]	=	1	--	桅杆靴
	BaoXiang_jshlyb	[	50	]	=	705		BaoXiang_jshlyb_Rad	[	50	]	=	3700		BaoXiang_jshlyb_Count	[	50	]	=	1	--	小鸭靴
	BaoXiang_jshlyb	[	51	]	=	708		BaoXiang_jshlyb_Rad	[	51	]	=	3700		BaoXiang_jshlyb_Count	[	51	]	=	1	--	摇摆鸭靴
	BaoXiang_jshlyb	[	52	]	=	714		BaoXiang_jshlyb_Rad	[	52	]	=	3700		BaoXiang_jshlyb_Count	[	52	]	=	1	--	蹦蹦鼠靴
	BaoXiang_jshlyb	[	53	]	=	719		BaoXiang_jshlyb_Rad	[	53	]	=	3700		BaoXiang_jshlyb_Count	[	53	]	=	1	--	旅者靴
	BaoXiang_jshlyb	[	54	]	=	720		BaoXiang_jshlyb_Rad	[	54	]	=	3700		BaoXiang_jshlyb_Count	[	54	]	=	1	--	护士靴
	BaoXiang_jshlyb	[	55	]	=	722		BaoXiang_jshlyb_Rad	[	55	]	=	3700		BaoXiang_jshlyb_Count	[	55	]	=	1	--	圣职靴
	BaoXiang_jshlyb	[	56	]	=	727		BaoXiang_jshlyb_Rad	[	56	]	=	3700		BaoXiang_jshlyb_Count	[	56	]	=	1	--	远行靴
	BaoXiang_jshlyb	[	57	]	=	730		BaoXiang_jshlyb_Rad	[	57	]	=	3700		BaoXiang_jshlyb_Count	[	57	]	=	1	--	虔诚靴
	BaoXiang_jshlyb	[	58	]	=	740		BaoXiang_jshlyb_Rad	[	58	]	=	3700		BaoXiang_jshlyb_Count	[	58	]	=	1	--	快乐兔靴
	BaoXiang_jshlyb	[	59	]	=	742		BaoXiang_jshlyb_Rad	[	59	]	=	3700		BaoXiang_jshlyb_Count	[	59	]	=	1	--	袋鼠靴
	BaoXiang_jshlyb	[	60	]	=	744		BaoXiang_jshlyb_Rad	[	60	]	=	3700		BaoXiang_jshlyb_Count	[	60	]	=	1	--	宝贝兔靴
	BaoXiang_jshlyb	[	61	]	=	1940		BaoXiang_jshlyb_Rad	[	61	]	=	3700		BaoXiang_jshlyb_Count	[	61	]	=	1	--	疾风靴
	BaoXiang_jshlyb	[	62	]	=	1952		BaoXiang_jshlyb_Rad	[	62	]	=	3700		BaoXiang_jshlyb_Count	[	62	]	=	1	--	烈火靴
	BaoXiang_jshlyb	[	63	]	=	1970		BaoXiang_jshlyb_Rad	[	63	]	=	3700		BaoXiang_jshlyb_Count	[	63	]	=	1	--	冷月靴
	BaoXiang_jshlyb	[	64	]	=	1973		BaoXiang_jshlyb_Rad	[	64	]	=	3700		BaoXiang_jshlyb_Count	[	64	]	=	1	--	耀日靴
	BaoXiang_jshlyb	[	65	]	=	1985		BaoXiang_jshlyb_Rad	[	65	]	=	3700		BaoXiang_jshlyb_Count	[	65	]	=	1	--	风暴靴
																								
																								
	BaoXiang_jsmhzca_Qua	=	24	 				BaoXiang_jsmhzca_Mxcount	=	19												
	BaoXiang_jsmhzca	=	{}					BaoXiang_jsmhzca_Rad	=	{}					BaoXiang_jsmhzca_Count	=	{}					
	BaoXiang_jsmhzca	[	1	]	=	1920		BaoXiang_jsmhzca_Rad	[	1	]	=	10 		BaoXiang_jsmhzca_Count	[	1	]	=	1	--	不死封印的暗影之牙
	BaoXiang_jsmhzca	[	2	]	=	1921		BaoXiang_jsmhzca_Rad	[	2	]	=	30		BaoXiang_jsmhzca_Count	[	2	]	=	1	--	污泥封印的诅咒之刺
	BaoXiang_jsmhzca	[	3	]	=	1922		BaoXiang_jsmhzca_Rad	[	3	]	=	20		BaoXiang_jsmhzca_Count	[	3	]	=	1	--	烈焰封印的幻灵之牙
	BaoXiang_jsmhzca	[	4	]	=	1923		BaoXiang_jsmhzca_Rad	[	4	]	=	1		BaoXiang_jsmhzca_Count	[	4	]	=	1	--	寒冰封印的迷幻之刺
	BaoXiang_jsmhzca	[	5	]	=	0151		BaoXiang_jsmhzca_Rad	[	5	]	=	50		BaoXiang_jsmhzca_Count	[	5	]	=	1	--	断魂
	BaoXiang_jsmhzca	[	6	]	=	0079		BaoXiang_jsmhzca_Rad	[	6	]	=	50		BaoXiang_jsmhzca_Count	[	6	]	=	1	--	海神戟
	BaoXiang_jsmhzca	[	7	]	=	0078		BaoXiang_jsmhzca_Rad	[	7	]	=	100		BaoXiang_jsmhzca_Count	[	7	]	=	1	--	龙王匕首
	BaoXiang_jsmhzca	[	8	]	=	1448		BaoXiang_jsmhzca_Rad	[	8	]	=	100		BaoXiang_jsmhzca_Count	[	8	]	=	1	--	君王匕首
	BaoXiang_jsmhzca	[	9	]	=	0077		BaoXiang_jsmhzca_Rad	[	9	]	=	110		BaoXiang_jsmhzca_Count	[	9	]	=	1	--	狼牙刺
	BaoXiang_jsmhzca	[	10	]	=	0084		BaoXiang_jsmhzca_Rad	[	10	]	=	110		BaoXiang_jsmhzca_Count	[	10	]	=	1	--	嗜血利刃
	BaoXiang_jsmhzca	[	11	]	=	1419		BaoXiang_jsmhzca_Rad	[	11	]	=	110		BaoXiang_jsmhzca_Count	[	11	]	=	1	--	杀伤刃
	BaoXiang_jsmhzca	[	12	]	=	1426		BaoXiang_jsmhzca_Rad	[	12	]	=	110		BaoXiang_jsmhzca_Count	[	12	]	=	1	--	噩梦匕首
	BaoXiang_jsmhzca	[	13	]	=	1447		BaoXiang_jsmhzca_Rad	[	13	]	=	110		BaoXiang_jsmhzca_Count	[	13	]	=	1	--	海盗匕首
	BaoXiang_jsmhzca	[	14	]	=	1461		BaoXiang_jsmhzca_Rad	[	14	]	=	110		BaoXiang_jsmhzca_Count	[	14	]	=	1	--	诅咒匕首
	BaoXiang_jsmhzca	[	15	]	=	0076		BaoXiang_jsmhzca_Rad	[	15	]	=	18000		BaoXiang_jsmhzca_Count	[	15	]	=	1	--	月牙刺
	BaoXiang_jsmhzca	[	16	]	=	1418		BaoXiang_jsmhzca_Rad	[	16	]	=	18000		BaoXiang_jsmhzca_Count	[	16	]	=	1	--	星光刺
	BaoXiang_jsmhzca	[	17	]	=	1425		BaoXiang_jsmhzca_Rad	[	17	]	=	18000		BaoXiang_jsmhzca_Count	[	17	]	=	1	--	石英匕首
	BaoXiang_jsmhzca	[	18	]	=	1446		BaoXiang_jsmhzca_Rad	[	18	]	=	18000		BaoXiang_jsmhzca_Count	[	18	]	=	1	--	闪烁刺
	BaoXiang_jsmhzca	[	19	]	=	1460		BaoXiang_jsmhzca_Rad	[	19	]	=	18000		BaoXiang_jsmhzca_Count	[	19	]	=	1	--	宝石匕首

																						
	BaoXiang_jsmhzcb_Qua	=	23	 				BaoXiang_jsmhzcb_Mxcount	=	19												
	BaoXiang_jsmhzcb	=	{}					BaoXiang_jsmhzcb_Rad	=	{}					BaoXiang_jsmhzcb_Count	=	{}					
	BaoXiang_jsmhzcb	[	1	]	=	1920		BaoXiang_jsmhzcb_Rad	[	1	]	=	20 		BaoXiang_jsmhzcb_Count	[	1	]	=	1	--	不死封印的暗影之牙
	BaoXiang_jsmhzcb	[	2	]	=	1921		BaoXiang_jsmhzcb_Rad	[	2	]	=	30		BaoXiang_jsmhzcb_Count	[	2	]	=	1	--	污泥封印的诅咒之刺
	BaoXiang_jsmhzcb	[	3	]	=	1922		BaoXiang_jsmhzcb_Rad	[	3	]	=	10		BaoXiang_jsmhzcb_Count	[	3	]	=	1	--	烈焰封印的幻灵之牙
	BaoXiang_jsmhzcb	[	4	]	=	1923		BaoXiang_jsmhzcb_Rad	[	4	]	=	5		BaoXiang_jsmhzcb_Count	[	4	]	=	1	--	寒冰封印的迷幻之刺
	BaoXiang_jsmhzcb	[	5	]	=	0151		BaoXiang_jsmhzcb_Rad	[	5	]	=	30		BaoXiang_jsmhzcb_Count	[	5	]	=	1	--	断魂
	BaoXiang_jsmhzcb	[	6	]	=	0079		BaoXiang_jsmhzcb_Rad	[	6	]	=	30		BaoXiang_jsmhzcb_Count	[	6	]	=	1	--	海神戟
	BaoXiang_jsmhzcb	[	7	]	=	0078		BaoXiang_jsmhzcb_Rad	[	7	]	=	70		BaoXiang_jsmhzcb_Count	[	7	]	=	1	--	龙王匕首
	BaoXiang_jsmhzcb	[	8	]	=	1448		BaoXiang_jsmhzcb_Rad	[	8	]	=	70		BaoXiang_jsmhzcb_Count	[	8	]	=	1	--	君王匕首
	BaoXiang_jsmhzcb	[	9	]	=	0077		BaoXiang_jsmhzcb_Rad	[	9	]	=	100		BaoXiang_jsmhzcb_Count	[	9	]	=	1	--	狼牙刺
	BaoXiang_jsmhzcb	[	10	]	=	0084		BaoXiang_jsmhzcb_Rad	[	10	]	=	100		BaoXiang_jsmhzcb_Count	[	10	]	=	1	--	嗜血利刃
	BaoXiang_jsmhzcb	[	11	]	=	1419		BaoXiang_jsmhzcb_Rad	[	11	]	=	100		BaoXiang_jsmhzcb_Count	[	11	]	=	1	--	杀伤刃
	BaoXiang_jsmhzcb	[	12	]	=	1426		BaoXiang_jsmhzcb_Rad	[	12	]	=	100		BaoXiang_jsmhzcb_Count	[	12	]	=	1	--	噩梦匕首
	BaoXiang_jsmhzcb	[	13	]	=	1447		BaoXiang_jsmhzcb_Rad	[	13	]	=	100		BaoXiang_jsmhzcb_Count	[	13	]	=	1	--	海盗匕首
	BaoXiang_jsmhzcb	[	14	]	=	1461		BaoXiang_jsmhzcb_Rad	[	14	]	=	100		BaoXiang_jsmhzcb_Count	[	14	]	=	1	--	诅咒匕首
	BaoXiang_jsmhzcb	[	15	]	=	0076		BaoXiang_jsmhzcb_Rad	[	15	]	=	18500		BaoXiang_jsmhzcb_Count	[	15	]	=	1	--	月牙刺
	BaoXiang_jsmhzcb	[	16	]	=	1418		BaoXiang_jsmhzcb_Rad	[	16	]	=	18500		BaoXiang_jsmhzcb_Count	[	16	]	=	1	--	星光刺
	BaoXiang_jsmhzcb	[	17	]	=	1425		BaoXiang_jsmhzcb_Rad	[	17	]	=	18500		BaoXiang_jsmhzcb_Count	[	17	]	=	1	--	石英匕首
	BaoXiang_jsmhzcb	[	18	]	=	1446		BaoXiang_jsmhzcb_Rad	[	18	]	=	18500		BaoXiang_jsmhzcb_Count	[	18	]	=	1	--	闪烁刺
	BaoXiang_jsmhzcb	[	19	]	=	1460		BaoXiang_jsmhzcb_Rad	[	19	]	=	18500		BaoXiang_jsmhzcb_Count	[	19	]	=	1	--	宝石匕首

																						
	BaoXiang_jsmzfza_Qua	=	24	 				BaoXiang_jsmzfza_Mxcount	=	18												
	BaoXiang_jsmzfza	=	{}					BaoXiang_jsmzfza_Rad	=	{}					BaoXiang_jsmzfza_Count	=	{}					
	BaoXiang_jsmzfza	[	1	]	=	1906		BaoXiang_jsmzfza_Rad	[	1	]	=	10 		BaoXiang_jsmzfza_Count	[	1	]	=	1	--	不死封印的破魔法杖
	BaoXiang_jsmzfza	[	2	]	=	1914		BaoXiang_jsmzfza_Rad	[	2	]	=	30		BaoXiang_jsmzfza_Count	[	2	]	=	1	--	污泥封印的咒文法杖
	BaoXiang_jsmzfza	[	3	]	=	1915		BaoXiang_jsmzfza_Rad	[	3	]	=	20		BaoXiang_jsmzfza_Count	[	3	]	=	1	--	烈焰封印的幻化之杖
	BaoXiang_jsmzfza	[	4	]	=	1916		BaoXiang_jsmzfza_Rad	[	4	]	=	1		BaoXiang_jsmzfza_Count	[	4	]	=	1	--	寒冰封印的迷咒法杖
	BaoXiang_jsmzfza	[	5	]	=	0112		BaoXiang_jsmzfza_Rad	[	5	]	=	50		BaoXiang_jsmzfza_Count	[	5	]	=	1	--	试炼之杵
	BaoXiang_jsmzfza	[	6	]	=	1439		BaoXiang_jsmzfza_Rad	[	6	]	=	100		BaoXiang_jsmzfza_Count	[	6	]	=	1	--	神谴之杖
	BaoXiang_jsmzfza	[	7	]	=	1474		BaoXiang_jsmzfza_Rad	[	7	]	=	100		BaoXiang_jsmzfza_Count	[	7	]	=	1	--	晴天之杖
	BaoXiang_jsmzfza	[	8	]	=	3812		BaoXiang_jsmzfza_Rad	[	8	]	=	100		BaoXiang_jsmzfza_Count	[	8	]	=	1	--	朱雀法杖
	BaoXiang_jsmzfza	[	9	]	=	4300		BaoXiang_jsmzfza_Rad	[	9	]	=	100		BaoXiang_jsmzfza_Count	[	9	]	=	1	--	惩罚之杖
	BaoXiang_jsmzfza	[	10	]	=	1432		BaoXiang_jsmzfza_Rad	[	10	]	=	200		BaoXiang_jsmzfza_Count	[	10	]	=	1	--	霹雳法杖
	BaoXiang_jsmzfza	[	11	]	=	1438		BaoXiang_jsmzfza_Rad	[	11	]	=	200		BaoXiang_jsmzfza_Count	[	11	]	=	1	--	怒炎法杖
	BaoXiang_jsmzfza	[	12	]	=	1467		BaoXiang_jsmzfza_Rad	[	12	]	=	200		BaoXiang_jsmzfza_Count	[	12	]	=	1	--	圣者法杖
	BaoXiang_jsmzfza	[	13	]	=	1473		BaoXiang_jsmzfza_Rad	[	13	]	=	200		BaoXiang_jsmzfza_Count	[	13	]	=	1	--	烈火法杖
	BaoXiang_jsmzfza	[	14	]	=	3811		BaoXiang_jsmzfza_Rad	[	14	]	=	200		BaoXiang_jsmzfza_Count	[	14	]	=	1	--	尤迪安之杖
	BaoXiang_jsmzfza	[	15	]	=	1431		BaoXiang_jsmzfza_Rad	[	15	]	=	2100		BaoXiang_jsmzfza_Count	[	15	]	=	1	--	野性权杖
	BaoXiang_jsmzfza	[	16	]	=	1437		BaoXiang_jsmzfza_Rad	[	16	]	=	2100		BaoXiang_jsmzfza_Count	[	16	]	=	1	--	压制之杖
	BaoXiang_jsmzfza	[	17	]	=	1466		BaoXiang_jsmzfza_Rad	[	17	]	=	2100		BaoXiang_jsmzfza_Count	[	17	]	=	1	--	活力权杖
	BaoXiang_jsmzfza	[	18	]	=	1472		BaoXiang_jsmzfza_Rad	[	18	]	=	2100		BaoXiang_jsmzfza_Count	[	18	]	=	1	--	努力之杖

																						
	BaoXiang_jsmzfzb_Qua	=	23	 				BaoXiang_jsmzfza_Mxcount	=	18																																		
	BaoXiang_jsmzfzb	=	{}					BaoXiang_jsmzfzb_Rad	=	{}					BaoXiang_jsmzfzb_Count	=	{}					
	BaoXiang_jsmzfzb	[	1	]	=	1906		BaoXiang_jsmzfzb_Rad	[	1	]	=	100 		BaoXiang_jsmzfzb_Count	[	1	]	=	1	--	不死封印的破魔法杖
	BaoXiang_jsmzfzb	[	2	]	=	1914		BaoXiang_jsmzfzb_Rad	[	2	]	=	30		BaoXiang_jsmzfzb_Count	[	2	]	=	1	--	污泥封印的咒文法杖
	BaoXiang_jsmzfzb	[	3	]	=	1915		BaoXiang_jsmzfzb_Rad	[	3	]	=	10		BaoXiang_jsmzfzb_Count	[	3	]	=	1	--	烈焰封印的幻化之杖
	BaoXiang_jsmzfzb	[	4	]	=	1916		BaoXiang_jsmzfzb_Rad	[	4	]	=	5		BaoXiang_jsmzfzb_Count	[	4	]	=	1	--	寒冰封印的迷咒法杖
	BaoXiang_jsmzfzb	[	5	]	=	0112		BaoXiang_jsmzfzb_Rad	[	5	]	=	40		BaoXiang_jsmzfzb_Count	[	5	]	=	1	--	试炼之杵
	BaoXiang_jsmzfzb	[	6	]	=	1439		BaoXiang_jsmzfzb_Rad	[	6	]	=	80		BaoXiang_jsmzfzb_Count	[	6	]	=	1	--	神谴之杖
	BaoXiang_jsmzfzb	[	7	]	=	1474		BaoXiang_jsmzfzb_Rad	[	7	]	=	80		BaoXiang_jsmzfzb_Count	[	7	]	=	1	--	晴天之杖
	BaoXiang_jsmzfzb	[	8	]	=	3812		BaoXiang_jsmzfzb_Rad	[	8	]	=	80		BaoXiang_jsmzfzb_Count	[	8	]	=	1	--	朱雀法杖
	BaoXiang_jsmzfzb	[	9	]	=	4300		BaoXiang_jsmzfzb_Rad	[	9	]	=	80		BaoXiang_jsmzfzb_Count	[	9	]	=	1	--	惩罚之杖
	BaoXiang_jsmzfzb	[	10	]	=	1432		BaoXiang_jsmzfzb_Rad	[	10	]	=	200		BaoXiang_jsmzfzb_Count	[	10	]	=	1	--	霹雳法杖
	BaoXiang_jsmzfzb	[	11	]	=	1438		BaoXiang_jsmzfzb_Rad	[	11	]	=	200		BaoXiang_jsmzfzb_Count	[	11	]	=	1	--	怒炎法杖
	BaoXiang_jsmzfzb	[	12	]	=	1467		BaoXiang_jsmzfzb_Rad	[	12	]	=	200		BaoXiang_jsmzfzb_Count	[	12	]	=	1	--	圣者法杖
	BaoXiang_jsmzfzb	[	13	]	=	1473		BaoXiang_jsmzfzb_Rad	[	13	]	=	200		BaoXiang_jsmzfzb_Count	[	13	]	=	1	--	烈火法杖
	BaoXiang_jsmzfzb	[	14	]	=	3811		BaoXiang_jsmzfzb_Rad	[	14	]	=	200		BaoXiang_jsmzfzb_Count	[	14	]	=	1	--	尤迪安之杖
	BaoXiang_jsmzfzb	[	15	]	=	1431		BaoXiang_jsmzfzb_Rad	[	15	]	=	21500		BaoXiang_jsmzfzb_Count	[	15	]	=	1	--	野性权杖
	BaoXiang_jsmzfzb	[	16	]	=	1437		BaoXiang_jsmzfzb_Rad	[	16	]	=	21500		BaoXiang_jsmzfzb_Count	[	16	]	=	1	--	压制之杖
	BaoXiang_jsmzfzb	[	17	]	=	1466		BaoXiang_jsmzfzb_Rad	[	17	]	=	21500		BaoXiang_jsmzfzb_Count	[	17	]	=	1	--	活力权杖
	BaoXiang_jsmzfzb	[	18	]	=	1472		BaoXiang_jsmzfzb_Rad	[	18	]	=	21500		BaoXiang_jsmzfzb_Count	[	18	]	=	1	--	努力之杖
																						
																						
	BaoXiang_jsmfzza_Qua	=	24	 				BaoXiang_jsmfzza_Mxcount	=	25												
	BaoXiang_jsmfzza	=	{}					BaoXiang_jsmfzza_Rad	=	{}					BaoXiang_jsmfzza_Count	=	{}					
	BaoXiang_jsmfzza	[	1	]	=	1906		BaoXiang_jsmfzza_Rad	[	1	]	=	100 		BaoXiang_jsmfzza_Count	[	1	]	=	1	--	不死封印的破魔法杖
	BaoXiang_jsmfzza	[	2	]	=	1907		BaoXiang_jsmfzza_Rad	[	2	]	=	30		BaoXiang_jsmfzza_Count	[	2	]	=	1	--	污泥封印的咒术之杖
	BaoXiang_jsmfzza	[	3	]	=	1908		BaoXiang_jsmfzza_Rad	[	3	]	=	20		BaoXiang_jsmfzza_Count	[	3	]	=	1	--	烈焰封印的幻灵精神法杖
	BaoXiang_jsmfzza	[	4	]	=	1909		BaoXiang_jsmfzza_Rad	[	4	]	=	1		BaoXiang_jsmfzza_Count	[	4	]	=	1	--	寒冰封印的迷法之杖
	BaoXiang_jsmfzza	[	5	]	=	0110		BaoXiang_jsmfzza_Rad	[	5	]	=	50		BaoXiang_jsmfzza_Count	[	5	]	=	1	--	补天之杖
	BaoXiang_jsmfzza	[	6	]	=	4198		BaoXiang_jsmfzza_Rad	[	6	]	=	50		BaoXiang_jsmfzza_Count	[	6	]	=	1	--	灵魂源泉
	BaoXiang_jsmfzza	[	7	]	=	1442		BaoXiang_jsmfzza_Rad	[	7	]	=	60		BaoXiang_jsmfzza_Count	[	7	]	=	1	--	天使之泪
	BaoXiang_jsmfzza	[	8	]	=	1477		BaoXiang_jsmfzza_Rad	[	8	]	=	60		BaoXiang_jsmfzza_Count	[	8	]	=	1	--	悲哀之眼
	BaoXiang_jsmfzza	[	9	]	=	3815		BaoXiang_jsmfzza_Rad	[	9	]	=	60		BaoXiang_jsmfzza_Count	[	9	]	=	1	--	鸾凤法杖
	BaoXiang_jsmfzza	[	10	]	=	4197		BaoXiang_jsmfzza_Rad	[	10	]	=	60		BaoXiang_jsmfzza_Count	[	10	]	=	1	--	极寒之火
	BaoXiang_jsmfzza	[	11	]	=	4303		BaoXiang_jsmfzza_Rad	[	11	]	=	60		BaoXiang_jsmfzza_Count	[	11	]	=	1	--	神之指引
	BaoXiang_jsmfzza	[	12	]	=	4303		BaoXiang_jsmfzza_Rad	[	12	]	=	60		BaoXiang_jsmfzza_Count	[	12	]	=	1	--	神之指引
	BaoXiang_jsmfzza	[	13	]	=	0103		BaoXiang_jsmfzza_Rad	[	13	]	=	130		BaoXiang_jsmfzza_Count	[	13	]	=	1	--	生命之光
	BaoXiang_jsmfzza	[	14	]	=	1433		BaoXiang_jsmfzza_Rad	[	14	]	=	130		BaoXiang_jsmfzza_Count	[	14	]	=	1	--	倾听神杖
	BaoXiang_jsmfzza	[	15	]	=	1441		BaoXiang_jsmfzza_Rad	[	15	]	=	130		BaoXiang_jsmfzza_Count	[	15	]	=	1	--	盖雅神杖
	BaoXiang_jsmfzza	[	16	]	=	1468		BaoXiang_jsmfzza_Rad	[	16	]	=	130		BaoXiang_jsmfzza_Count	[	16	]	=	1	--	神官之杖
	BaoXiang_jsmfzza	[	17	]	=	1476		BaoXiang_jsmfzza_Rad	[	17	]	=	130		BaoXiang_jsmfzza_Count	[	17	]	=	1	--	束缚之杖
	BaoXiang_jsmfzza	[	18	]	=	0103		BaoXiang_jsmfzza_Rad	[	18	]	=	130		BaoXiang_jsmfzza_Count	[	18	]	=	1	--	生命之光
	BaoXiang_jsmfzza	[	19	]	=	3814		BaoXiang_jsmfzza_Rad	[	19	]	=	130		BaoXiang_jsmfzza_Count	[	19	]	=	1	--	希望之杖
	BaoXiang_jsmfzza	[	20	]	=	1430		BaoXiang_jsmfzza_Rad	[	20	]	=	14500		BaoXiang_jsmfzza_Count	[	20	]	=	1	--	神圣权杖
	BaoXiang_jsmfzza	[	21	]	=	1437		BaoXiang_jsmfzza_Rad	[	21	]	=	14500		BaoXiang_jsmfzza_Count	[	21	]	=	1	--	压制之杖
	BaoXiang_jsmfzza	[	22	]	=	1465		BaoXiang_jsmfzza_Rad	[	22	]	=	14500		BaoXiang_jsmfzza_Count	[	22	]	=	1	--	光华权杖
	BaoXiang_jsmfzza	[	23	]	=	1475		BaoXiang_jsmfzza_Rad	[	23	]	=	14500		BaoXiang_jsmfzza_Count	[	23	]	=	1	--	通灵之杖
	BaoXiang_jsmfzza	[	24	]	=	3813		BaoXiang_jsmfzza_Rad	[	24	]	=	14500		BaoXiang_jsmfzza_Count	[	24	]	=	1	--	耀日印记
	BaoXiang_jsmfzza	[	25	]	=	4301		BaoXiang_jsmfzza_Rad	[	25	]	=	14500		BaoXiang_jsmfzza_Count	[	25	]	=	1	--	智慧之杖


	BaoXiang_jsmfzzb_Qua	=	23	 				BaoXiang_jsmfzzb_Mxcount	=	25												
	BaoXiang_jsmfzzb	=	{}					BaoXiang_jsmfzzb_Rad	=	{}					BaoXiang_jsmfzzb_Count	=	{}					
	BaoXiang_jsmfzzb	[	1	]	=	1906		BaoXiang_jsmfzzb_Rad	[	1	]	=	100 		BaoXiang_jsmfzzb_Count	[	1	]	=	1	--	不死封印的破魔法杖
	BaoXiang_jsmfzzb	[	2	]	=	1907		BaoXiang_jsmfzzb_Rad	[	2	]	=	30		BaoXiang_jsmfzzb_Count	[	2	]	=	1	--	污泥封印的咒术之杖
	BaoXiang_jsmfzzb	[	3	]	=	1908		BaoXiang_jsmfzzb_Rad	[	3	]	=	10		BaoXiang_jsmfzzb_Count	[	3	]	=	1	--	烈焰封印的幻灵精神法杖
	BaoXiang_jsmfzzb	[	4	]	=	1909		BaoXiang_jsmfzzb_Rad	[	4	]	=	5		BaoXiang_jsmfzzb_Count	[	4	]	=	1	--	寒冰封印的迷法之杖
	BaoXiang_jsmfzzb	[	5	]	=	0110		BaoXiang_jsmfzzb_Rad	[	5	]	=	40		BaoXiang_jsmfzzb_Count	[	5	]	=	1	--	补天之杖
	BaoXiang_jsmfzzb	[	6	]	=	4198		BaoXiang_jsmfzzb_Rad	[	6	]	=	40		BaoXiang_jsmfzzb_Count	[	6	]	=	1	--	灵魂源泉
	BaoXiang_jsmfzzb	[	7	]	=	1442		BaoXiang_jsmfzzb_Rad	[	7	]	=	50		BaoXiang_jsmfzzb_Count	[	7	]	=	1	--	天使之泪
	BaoXiang_jsmfzzb	[	8	]	=	1477		BaoXiang_jsmfzzb_Rad	[	8	]	=	50		BaoXiang_jsmfzzb_Count	[	8	]	=	1	--	悲哀之眼
	BaoXiang_jsmfzzb	[	9	]	=	3815		BaoXiang_jsmfzzb_Rad	[	9	]	=	50		BaoXiang_jsmfzzb_Count	[	9	]	=	1	--	鸾凤法杖
	BaoXiang_jsmfzzb	[	10	]	=	4197		BaoXiang_jsmfzzb_Rad	[	10	]	=	50		BaoXiang_jsmfzzb_Count	[	10	]	=	1	--	极寒之火
	BaoXiang_jsmfzzb	[	11	]	=	4303		BaoXiang_jsmfzzb_Rad	[	11	]	=	50		BaoXiang_jsmfzzb_Count	[	11	]	=	1	--	神之指引
	BaoXiang_jsmfzzb	[	12	]	=	4303		BaoXiang_jsmfzzb_Rad	[	12	]	=	50		BaoXiang_jsmfzzb_Count	[	12	]	=	1	--	神之指引
	BaoXiang_jsmfzzb	[	13	]	=	0103		BaoXiang_jsmfzzb_Rad	[	13	]	=	130		BaoXiang_jsmfzzb_Count	[	13	]	=	1	--	生命之光
	BaoXiang_jsmfzzb	[	14	]	=	1433		BaoXiang_jsmfzzb_Rad	[	14	]	=	130		BaoXiang_jsmfzzb_Count	[	14	]	=	1	--	倾听神杖
	BaoXiang_jsmfzzb	[	15	]	=	1441		BaoXiang_jsmfzzb_Rad	[	15	]	=	130		BaoXiang_jsmfzzb_Count	[	15	]	=	1	--	盖雅神杖
	BaoXiang_jsmfzzb	[	16	]	=	1468		BaoXiang_jsmfzzb_Rad	[	16	]	=	130		BaoXiang_jsmfzzb_Count	[	16	]	=	1	--	神官之杖
	BaoXiang_jsmfzzb	[	17	]	=	1476		BaoXiang_jsmfzzb_Rad	[	17	]	=	130		BaoXiang_jsmfzzb_Count	[	17	]	=	1	--	束缚之杖
	BaoXiang_jsmfzzb	[	18	]	=	0103		BaoXiang_jsmfzzb_Rad	[	18	]	=	130		BaoXiang_jsmfzzb_Count	[	18	]	=	1	--	生命之光
	BaoXiang_jsmfzzb	[	19	]	=	3814		BaoXiang_jsmfzzb_Rad	[	19	]	=	130		BaoXiang_jsmfzzb_Count	[	19	]	=	1	--	希望之杖
	BaoXiang_jsmfzzb	[	20	]	=	1430		BaoXiang_jsmfzzb_Rad	[	20	]	=	14500		BaoXiang_jsmfzzb_Count	[	20	]	=	1	--	神圣权杖
	BaoXiang_jsmfzzb	[	21	]	=	1437		BaoXiang_jsmfzzb_Rad	[	21	]	=	14500		BaoXiang_jsmfzzb_Count	[	21	]	=	1	--	压制之杖
	BaoXiang_jsmfzzb	[	22	]	=	1465		BaoXiang_jsmfzzb_Rad	[	22	]	=	14500		BaoXiang_jsmfzzb_Count	[	22	]	=	1	--	光华权杖
	BaoXiang_jsmfzzb	[	23	]	=	1475		BaoXiang_jsmfzzb_Rad	[	23	]	=	14500		BaoXiang_jsmfzzb_Count	[	23	]	=	1	--	通灵之杖
	BaoXiang_jsmfzzb	[	24	]	=	3813		BaoXiang_jsmfzzb_Rad	[	24	]	=	14500		BaoXiang_jsmfzzb_Count	[	24	]	=	1	--	耀日印记
	BaoXiang_jsmfzzb	[	25	]	=	4301		BaoXiang_jsmfzzb_Rad	[	25	]	=	14500		BaoXiang_jsmfzzb_Count	[	25	]	=	1	--	智慧之杖

																						
	BaoXiang_jsmzcqa_Qua	=	24	 				BaoXiang_jsmzcqa_Mxcount	=	20												
	BaoXiang_jsmzcqa	=	{}					BaoXiang_jsmzcqa_Rad	=	{}					BaoXiang_jsmzcqa_Count	=	{}					
	BaoXiang_jsmzcqa	[	1	]	=	1902		BaoXiang_jsmzcqa_Rad	[	1	]	=	100 		BaoXiang_jsmzcqa_Count	[	1	]	=	1	--	不死封印的亡灵之触
	BaoXiang_jsmzcqa	[	2	]	=	1903		BaoXiang_jsmzcqa_Rad	[	2	]	=	30 		BaoXiang_jsmzcqa_Count	[	2	]	=	1	--	污泥封印的诅咒之吻
	BaoXiang_jsmzcqa	[	3	]	=	1904		BaoXiang_jsmzcqa_Rad	[	3	]	=	20 		BaoXiang_jsmzcqa_Count	[	3	]	=	1	--	烈焰封印的幻灵之怒吼
	BaoXiang_jsmzcqa	[	4	]	=	1905		BaoXiang_jsmzcqa_Rad	[	4	]	=	1 		BaoXiang_jsmzcqa_Count	[	4	]	=	1	--	寒冰封印的迷之长枪
	BaoXiang_jsmzcqa	[	5	]	=	0120		BaoXiang_jsmzcqa_Rad	[	5	]	=	50		BaoXiang_jsmzcqa_Count	[	5	]	=	1	--	霹雳神雷
	BaoXiang_jsmzcqa	[	6	]	=	0042		BaoXiang_jsmzcqa_Rad	[	6	]	=	50		BaoXiang_jsmzcqa_Count	[	6	]	=	1	--	毒星枪
	BaoXiang_jsmzcqa	[	7	]	=	0041		BaoXiang_jsmzcqa_Rad	[	7	]	=	60		BaoXiang_jsmzcqa_Count	[	7	]	=	1	--	圣光枪
	BaoXiang_jsmzcqa	[	8	]	=	1410		BaoXiang_jsmzcqa_Rad	[	8	]	=	60		BaoXiang_jsmzcqa_Count	[	8	]	=	1	--	天神之罚
	BaoXiang_jsmzcqa	[	9	]	=	3808		BaoXiang_jsmzcqa_Rad	[	9	]	=	60		BaoXiang_jsmzcqa_Count	[	9	]	=	1	--	白虎猎枪
	BaoXiang_jsmzcqa	[	10	]	=	4214		BaoXiang_jsmzcqa_Rad	[	10	]	=	60		BaoXiang_jsmzcqa_Count	[	10	]	=	1	--	响尾蛇
	BaoXiang_jsmzcqa	[	11	]	=	4215		BaoXiang_jsmzcqa_Rad	[	11	]	=	60		BaoXiang_jsmzcqa_Count	[	11	]	=	1	--	蛇鸣枪
	BaoXiang_jsmzcqa	[	12	]	=	0040		BaoXiang_jsmzcqa_Rad	[	12	]	=	2500		BaoXiang_jsmzcqa_Count	[	12	]	=	1	--	精致猎枪
	BaoXiang_jsmzcqa	[	13	]	=	0045		BaoXiang_jsmzcqa_Rad	[	13	]	=	2500		BaoXiang_jsmzcqa_Count	[	13	]	=	1	--	速射火枪
	BaoXiang_jsmzcqa	[	14	]	=	1409		BaoXiang_jsmzcqa_Rad	[	14	]	=	2500		BaoXiang_jsmzcqa_Count	[	14	]	=	1	--	战斗长枪
	BaoXiang_jsmzcqa	[	15	]	=	1414		BaoXiang_jsmzcqa_Rad	[	15	]	=	2500		BaoXiang_jsmzcqa_Count	[	15	]	=	1	--	幽灵火枪
	BaoXiang_jsmzcqa	[	16	]	=	0039		BaoXiang_jsmzcqa_Rad	[	16	]	=	17000		BaoXiang_jsmzcqa_Count	[	16	]	=	1	--	精致手枪
	BaoXiang_jsmzcqa	[	17	]	=	0044		BaoXiang_jsmzcqa_Rad	[	17	]	=	17000		BaoXiang_jsmzcqa_Count	[	17	]	=	1	--	礼品手枪
	BaoXiang_jsmzcqa	[	18	]	=	1408		BaoXiang_jsmzcqa_Rad	[	18	]	=	17000		BaoXiang_jsmzcqa_Count	[	18	]	=	1	--	袖珍手枪
	BaoXiang_jsmzcqa	[	19	]	=	1413		BaoXiang_jsmzcqa_Rad	[	19	]	=	17000		BaoXiang_jsmzcqa_Count	[	19	]	=	1	--	银制手枪
	BaoXiang_jsmzcqa	[	20	]	=	3806		BaoXiang_jsmzcqa_Rad	[	20	]	=	17000		BaoXiang_jsmzcqa_Count	[	20	]	=	1	--	烈火手枪

																																			
	BaoXiang_jsmzcqa_Qua	=	23	 				BaoXiang_jsmzcqa_Mxcount	=	20																																															
	BaoXiang_jsmzcqa	=	{}					BaoXiang_jsmzcqa_Rad	=	{}					BaoXiang_jsmzcqa_Count	=	{}					
	BaoXiang_jsmzcqa	[	1	]	=	1902		BaoXiang_jsmzcqa_Rad	[	1	]	=	100 		BaoXiang_jsmzcqa_Count	[	1	]	=	1	--	不死封印的亡灵之触
	BaoXiang_jsmzcqa	[	2	]	=	1903		BaoXiang_jsmzcqa_Rad	[	2	]	=	30 		BaoXiang_jsmzcqa_Count	[	2	]	=	1	--	污泥封印的诅咒之吻
	BaoXiang_jsmzcqa	[	3	]	=	1904		BaoXiang_jsmzcqa_Rad	[	3	]	=	10 		BaoXiang_jsmzcqa_Count	[	3	]	=	1	--	烈焰封印的幻灵之怒吼
	BaoXiang_jsmzcqa	[	4	]	=	1905		BaoXiang_jsmzcqa_Rad	[	4	]	=	5 		BaoXiang_jsmzcqa_Count	[	4	]	=	1	--	寒冰封印的迷之长枪
	BaoXiang_jsmzcqa	[	5	]	=	0120		BaoXiang_jsmzcqa_Rad	[	5	]	=	40		BaoXiang_jsmzcqa_Count	[	5	]	=	1	--	霹雳神雷
	BaoXiang_jsmzcqa	[	6	]	=	0042		BaoXiang_jsmzcqa_Rad	[	6	]	=	40		BaoXiang_jsmzcqa_Count	[	6	]	=	1	--	毒星枪
	BaoXiang_jsmzcqa	[	7	]	=	0041		BaoXiang_jsmzcqa_Rad	[	7	]	=	50		BaoXiang_jsmzcqa_Count	[	7	]	=	1	--	圣光枪
	BaoXiang_jsmzcqa	[	8	]	=	1410		BaoXiang_jsmzcqa_Rad	[	8	]	=	50		BaoXiang_jsmzcqa_Count	[	8	]	=	1	--	天神之罚
	BaoXiang_jsmzcqa	[	9	]	=	3808		BaoXiang_jsmzcqa_Rad	[	9	]	=	50		BaoXiang_jsmzcqa_Count	[	9	]	=	1	--	白虎猎枪
	BaoXiang_jsmzcqa	[	10	]	=	4214		BaoXiang_jsmzcqa_Rad	[	10	]	=	50		BaoXiang_jsmzcqa_Count	[	10	]	=	1	--	响尾蛇
	BaoXiang_jsmzcqa	[	11	]	=	4215		BaoXiang_jsmzcqa_Rad	[	11	]	=	50		BaoXiang_jsmzcqa_Count	[	11	]	=	1	--	蛇鸣枪
	BaoXiang_jsmzcqa	[	12	]	=	0040		BaoXiang_jsmzcqa_Rad	[	12	]	=	2500		BaoXiang_jsmzcqa_Count	[	12	]	=	1	--	精致猎枪
	BaoXiang_jsmzcqa	[	13	]	=	0045		BaoXiang_jsmzcqa_Rad	[	13	]	=	2500		BaoXiang_jsmzcqa_Count	[	13	]	=	1	--	速射火枪
	BaoXiang_jsmzcqa	[	14	]	=	1409		BaoXiang_jsmzcqa_Rad	[	14	]	=	2500		BaoXiang_jsmzcqa_Count	[	14	]	=	1	--	战斗长枪
	BaoXiang_jsmzcqa	[	15	]	=	1414		BaoXiang_jsmzcqa_Rad	[	15	]	=	2500		BaoXiang_jsmzcqa_Count	[	15	]	=	1	--	幽灵火枪
	BaoXiang_jsmzcqa	[	16	]	=	0039		BaoXiang_jsmzcqa_Rad	[	16	]	=	17500		BaoXiang_jsmzcqa_Count	[	16	]	=	1	--	精致手枪
	BaoXiang_jsmzcqa	[	17	]	=	0044		BaoXiang_jsmzcqa_Rad	[	17	]	=	17500		BaoXiang_jsmzcqa_Count	[	17	]	=	1	--	礼品手枪
	BaoXiang_jsmzcqa	[	18	]	=	1408		BaoXiang_jsmzcqa_Rad	[	18	]	=	17500		BaoXiang_jsmzcqa_Count	[	18	]	=	1	--	袖珍手枪
	BaoXiang_jsmzcqa	[	19	]	=	1413		BaoXiang_jsmzcqa_Rad	[	19	]	=	17500		BaoXiang_jsmzcqa_Count	[	19	]	=	1	--	银制手枪
	BaoXiang_jsmzcqa	[	20	]	=	3806		BaoXiang_jsmzcqa_Rad	[	20	]	=	17500		BaoXiang_jsmzcqa_Count	[	20	]	=	1	--	烈火手枪


xingZuoTime={}
xingZuoTime[1]=120								
xingZuoTime[2]=219	
xingZuoTime[3]=321	
xingZuoTime[4]=421	
xingZuoTime[5]=521	
xingZuoTime[6]=622	
xingZuoTime[7]=723	
xingZuoTime[8]=823		
xingZuoTime[9]=923		
xingZuoTime[10]=1023 	
xingZuoTime[11]=1122	
xingZuoTime[12]=1222	

						
GMSendANotice_Num= 52
GMSendANotice={}
CALCULATE_VARIABLE_LUA_000046 = GetResString("CALCULATE_VARIABLE_LUA_000046")
GMSendANotice[1]=	CALCULATE_VARIABLE_LUA_000046
CALCULATE_VARIABLE_LUA_000047 = GetResString("CALCULATE_VARIABLE_LUA_000047")
GMSendANotice[2]=	CALCULATE_VARIABLE_LUA_000047
CALCULATE_VARIABLE_LUA_000048 = GetResString("CALCULATE_VARIABLE_LUA_000048")
GMSendANotice[3]=	CALCULATE_VARIABLE_LUA_000048
CALCULATE_VARIABLE_LUA_000049 = GetResString("CALCULATE_VARIABLE_LUA_000049")
GMSendANotice[4]=	CALCULATE_VARIABLE_LUA_000049
CALCULATE_VARIABLE_LUA_000050 = GetResString("CALCULATE_VARIABLE_LUA_000050")
GMSendANotice[5]=	CALCULATE_VARIABLE_LUA_000050
CALCULATE_VARIABLE_LUA_000051 = GetResString("CALCULATE_VARIABLE_LUA_000051")
GMSendANotice[6]=	CALCULATE_VARIABLE_LUA_000051
CALCULATE_VARIABLE_LUA_000052 = GetResString("CALCULATE_VARIABLE_LUA_000052")
GMSendANotice[7]=	CALCULATE_VARIABLE_LUA_000052
CALCULATE_VARIABLE_LUA_000053 = GetResString("CALCULATE_VARIABLE_LUA_000053")
GMSendANotice[8]=	CALCULATE_VARIABLE_LUA_000053
CALCULATE_VARIABLE_LUA_000054 = GetResString("CALCULATE_VARIABLE_LUA_000054")
GMSendANotice[9]=	CALCULATE_VARIABLE_LUA_000054
CALCULATE_VARIABLE_LUA_000055 = GetResString("CALCULATE_VARIABLE_LUA_000055")
GMSendANotice[10]=	CALCULATE_VARIABLE_LUA_000055
CALCULATE_VARIABLE_LUA_000056 = GetResString("CALCULATE_VARIABLE_LUA_000056")
GMSendANotice[11]=	CALCULATE_VARIABLE_LUA_000056
CALCULATE_VARIABLE_LUA_000057 = GetResString("CALCULATE_VARIABLE_LUA_000057")
GMSendANotice[12]=	CALCULATE_VARIABLE_LUA_000057
CALCULATE_VARIABLE_LUA_000058 = GetResString("CALCULATE_VARIABLE_LUA_000058")
GMSendANotice[13]=	CALCULATE_VARIABLE_LUA_000058
CALCULATE_VARIABLE_LUA_000059 = GetResString("CALCULATE_VARIABLE_LUA_000059")
GMSendANotice[14]=	CALCULATE_VARIABLE_LUA_000059
CALCULATE_VARIABLE_LUA_000060 = GetResString("CALCULATE_VARIABLE_LUA_000060")
GMSendANotice[15]=	CALCULATE_VARIABLE_LUA_000060
CALCULATE_VARIABLE_LUA_000061 = GetResString("CALCULATE_VARIABLE_LUA_000061")
GMSendANotice[16]=	CALCULATE_VARIABLE_LUA_000061
CALCULATE_VARIABLE_LUA_000062 = GetResString("CALCULATE_VARIABLE_LUA_000062")
GMSendANotice[17]=	CALCULATE_VARIABLE_LUA_000062
CALCULATE_VARIABLE_LUA_000063 = GetResString("CALCULATE_VARIABLE_LUA_000063")
GMSendANotice[18]=	CALCULATE_VARIABLE_LUA_000063
CALCULATE_VARIABLE_LUA_000064 = GetResString("CALCULATE_VARIABLE_LUA_000064")
GMSendANotice[19]=	CALCULATE_VARIABLE_LUA_000064
CALCULATE_VARIABLE_LUA_000065 = GetResString("CALCULATE_VARIABLE_LUA_000065")
GMSendANotice[20]=	CALCULATE_VARIABLE_LUA_000065
CALCULATE_VARIABLE_LUA_000066 = GetResString("CALCULATE_VARIABLE_LUA_000066")
GMSendANotice[21]=	CALCULATE_VARIABLE_LUA_000066
CALCULATE_VARIABLE_LUA_000067 = GetResString("CALCULATE_VARIABLE_LUA_000067")
GMSendANotice[22]=	CALCULATE_VARIABLE_LUA_000067
CALCULATE_VARIABLE_LUA_000068 = GetResString("CALCULATE_VARIABLE_LUA_000068")
GMSendANotice[23]=	CALCULATE_VARIABLE_LUA_000068
CALCULATE_VARIABLE_LUA_000069 = GetResString("CALCULATE_VARIABLE_LUA_000069")
GMSendANotice[24]=	CALCULATE_VARIABLE_LUA_000069
CALCULATE_VARIABLE_LUA_000070 = GetResString("CALCULATE_VARIABLE_LUA_000070")
GMSendANotice[25]=	CALCULATE_VARIABLE_LUA_000070
CALCULATE_VARIABLE_LUA_000071 = GetResString("CALCULATE_VARIABLE_LUA_000071")
GMSendANotice[26]=	CALCULATE_VARIABLE_LUA_000071
CALCULATE_VARIABLE_LUA_000072 = GetResString("CALCULATE_VARIABLE_LUA_000072")
GMSendANotice[27]=	CALCULATE_VARIABLE_LUA_000072
CALCULATE_VARIABLE_LUA_000073 = GetResString("CALCULATE_VARIABLE_LUA_000073")
GMSendANotice[28]=	CALCULATE_VARIABLE_LUA_000073
CALCULATE_VARIABLE_LUA_000074 = GetResString("CALCULATE_VARIABLE_LUA_000074")
GMSendANotice[29]=	CALCULATE_VARIABLE_LUA_000074                        
CALCULATE_VARIABLE_LUA_000075 = GetResString("CALCULATE_VARIABLE_LUA_000075")
GMSendANotice[30]=	CALCULATE_VARIABLE_LUA_000075
CALCULATE_VARIABLE_LUA_000076 = GetResString("CALCULATE_VARIABLE_LUA_000076")
GMSendANotice[31]=	CALCULATE_VARIABLE_LUA_000076 
CALCULATE_VARIABLE_LUA_000077 = GetResString("CALCULATE_VARIABLE_LUA_000077")
GMSendANotice[32]=	CALCULATE_VARIABLE_LUA_000077 
CALCULATE_VARIABLE_LUA_000078 = GetResString("CALCULATE_VARIABLE_LUA_000078")
GMSendANotice[33]=	CALCULATE_VARIABLE_LUA_000078 
CALCULATE_VARIABLE_LUA_000079 = GetResString("CALCULATE_VARIABLE_LUA_000079")
GMSendANotice[34]=	CALCULATE_VARIABLE_LUA_000079
CALCULATE_VARIABLE_LUA_000080 = GetResString("CALCULATE_VARIABLE_LUA_000080")
GMSendANotice[35]=	CALCULATE_VARIABLE_LUA_000080
CALCULATE_VARIABLE_LUA_000081 = GetResString("CALCULATE_VARIABLE_LUA_000081")
GMSendANotice[36]=	CALCULATE_VARIABLE_LUA_000081
CALCULATE_VARIABLE_LUA_000082 = GetResString("CALCULATE_VARIABLE_LUA_000082")
GMSendANotice[37]=	CALCULATE_VARIABLE_LUA_000082
CALCULATE_VARIABLE_LUA_000083 = GetResString("CALCULATE_VARIABLE_LUA_000083")
GMSendANotice[38]=	CALCULATE_VARIABLE_LUA_000083
CALCULATE_VARIABLE_LUA_000084 = GetResString("CALCULATE_VARIABLE_LUA_000084")
GMSendANotice[39]=	CALCULATE_VARIABLE_LUA_000084
CALCULATE_VARIABLE_LUA_000085 = GetResString("CALCULATE_VARIABLE_LUA_000085")
GMSendANotice[40]=	CALCULATE_VARIABLE_LUA_000085
CALCULATE_VARIABLE_LUA_000086 = GetResString("CALCULATE_VARIABLE_LUA_000086")
GMSendANotice[41]=	CALCULATE_VARIABLE_LUA_000086
CALCULATE_VARIABLE_LUA_000087 = GetResString("CALCULATE_VARIABLE_LUA_000087")
GMSendANotice[42]=	CALCULATE_VARIABLE_LUA_000087
CALCULATE_VARIABLE_LUA_000088 = GetResString("CALCULATE_VARIABLE_LUA_000088")
GMSendANotice[43]=	CALCULATE_VARIABLE_LUA_000089
CALCULATE_VARIABLE_LUA_000090 = GetResString("CALCULATE_VARIABLE_LUA_000090")
GMSendANotice[44]=	CALCULATE_VARIABLE_LUA_000090
CALCULATE_VARIABLE_LUA_000091 = GetResString("CALCULATE_VARIABLE_LUA_000091")
GMSendANotice[45]=	CALCULATE_VARIABLE_LUA_000091
CALCULATE_VARIABLE_LUA_000092 = GetResString("CALCULATE_VARIABLE_LUA_000092")
GMSendANotice[46]=	CALCULATE_VARIABLE_LUA_000092
CALCULATE_VARIABLE_LUA_000093 = GetResString("CALCULATE_VARIABLE_LUA_000093")
GMSendANotice[47]=	CALCULATE_VARIABLE_LUA_000093
CALCULATE_VARIABLE_LUA_000094 = GetResString("CALCULATE_VARIABLE_LUA_000094")
GMSendANotice[48]=	CALCULATE_VARIABLE_LUA_000094
CALCULATE_VARIABLE_LUA_000095 = GetResString("CALCULATE_VARIABLE_LUA_000095")
GMSendANotice[49]=	CALCULATE_VARIABLE_LUA_000095
CALCULATE_VARIABLE_LUA_000096 = GetResString("CALCULATE_VARIABLE_LUA_000096")
GMSendANotice[50]=	CALCULATE_VARIABLE_LUA_000096
CALCULATE_VARIABLE_LUA_000097 = GetResString("CALCULATE_VARIABLE_LUA_000097")
GMSendANotice[51]=	CALCULATE_VARIABLE_LUA_000097
CALCULATE_VARIABLE_LUA_000098 = GetResString("CALCULATE_VARIABLE_LUA_000098")
GMSendANotice[52]=	CALCULATE_VARIABLE_LUA_000098


Player_Can_Do={}
CALCULATE_FUNCTIONS_LUA_000233 = GetResString("CALCULATE_FUNCTIONS_LUA_000233")
Player_Can_Do[1] = {Event_Name = CALCULATE_FUNCTIONS_LUA_000233 , Value = { Player_Name = "GMEric" , Do_Day = 152 , Has_Record = true } }


SBStateNUM=14
SBStateBS={}		SBStateYXJ={}		SBStateYXJxinyun={}		
SBStateBS[0]=1 		SBStateYXJ[0]=0		SBStateYXJxinyun[0]=0
SBStateBS[1]=2 		SBStateYXJ[1]=1		SBStateYXJxinyun[1]=0 		
SBStateBS[2]=2 		SBStateYXJ[2]=2		SBStateYXJxinyun[2]=1 	
SBStateBS[3]=2.5 	SBStateYXJ[3]=4		SBStateYXJxinyun[3]=2 	
SBStateBS[4]=2 		SBStateYXJ[4]=3		SBStateYXJxinyun[4]=1 	
SBStateBS[5]=3 		SBStateYXJ[5]=5		SBStateYXJxinyun[5]=1 	
SBStateBS[6]=4 		SBStateYXJ[6]=99	SBStateYXJxinyun[6]=0 	
SBStateBS[7]=5 		SBStateYXJ[7]=7		SBStateYXJxinyun[7]=1 	
SBStateBS[8]=7 		SBStateYXJ[8]=100	SBStateYXJxinyun[8]=0 	
SBStateBS[9]=10 	SBStateYXJ[9]=10	SBStateYXJxinyun[9]=1 	
SBStateBS[10]=20 	SBStateYXJ[10]=20	SBStateYXJxinyun[10]=1	
SBStateBS[11]=2  	SBStateYXJ[11]=97	SBStateYXJxinyun[11]=0 	
SBStateBS[12]=2  	SBStateYXJ[12]=98	SBStateYXJxinyun[12]=0 	
SBStateBS[13]=2  	SBStateYXJ[13]=96	SBStateYXJxinyun[13]=0 	
SBStateBS[14]=4  	SBStateYXJ[14]=6	SBStateYXJxinyun[14]=0 	
SBStateBS[15]=3 	SBStateYXJ[15]=5	SBStateYXJxinyun[15]=0 	
SBStateBS[16]=10 	SBStateYXJ[16]=10	SBStateYXJxinyun[16]=0 

	
BLStateNUM=6 
BLStateBS={}		BLStateYXJ={}			
BLStateBS[0]=1 		BLStateYXJ[0]=0			
BLStateBS[1]=2 		BLStateYXJ[1]=1			
BLStateBS[2]=2 		BLStateYXJ[2]=80		
BLStateBS[3]=2 		BLStateYXJ[3]=81		
BLStateBS[4]=2.5 	BLStateYXJ[4]=2		 	
BLStateBS[5]=3 		BLStateYXJ[5]=3		 	
BLStateBS[6]=2 		BLStateYXJ[6]=79		


BaoXiang_65JZDH_Mxcount = 20 
BaoXiang_65JZDH ={}					BaoXiang_65JZDH_Rad = {}					BaoXiang_65JZDH_Count = {}
BaoXiang_65JZDH	[	1	]	=	6618	BaoXiang_65JZDH_Rad	[	1	]	=	5	BaoXiang_65JZDH_Count	[	1	]	=	1
BaoXiang_65JZDH	[	2	]	=	6619	BaoXiang_65JZDH_Rad	[	2	]	=	5	BaoXiang_65JZDH_Count	[	2	]	=	1
BaoXiang_65JZDH	[	3	]	=	6620	BaoXiang_65JZDH_Rad	[	3	]	=	5	BaoXiang_65JZDH_Count	[	3	]	=	1
BaoXiang_65JZDH	[	4	]	=	6621	BaoXiang_65JZDH_Rad	[	4	]	=	5	BaoXiang_65JZDH_Count	[	4	]	=	1
BaoXiang_65JZDH	[	5	]	=	6622	BaoXiang_65JZDH_Rad	[	5	]	=	5	BaoXiang_65JZDH_Count	[	5	]	=	1
BaoXiang_65JZDH	[	6	]	=	6623	BaoXiang_65JZDH_Rad	[	6	]	=	5	BaoXiang_65JZDH_Count	[	6	]	=	1
BaoXiang_65JZDH	[	7	]	=	6624	BaoXiang_65JZDH_Rad	[	7	]	=	5	BaoXiang_65JZDH_Count	[	7	]	=	1
BaoXiang_65JZDH	[	8	]	=	6625	BaoXiang_65JZDH_Rad	[	8	]	=	5	BaoXiang_65JZDH_Count	[	8	]	=	1
BaoXiang_65JZDH	[	9	]	=	6626	BaoXiang_65JZDH_Rad	[	9	]	=	5	BaoXiang_65JZDH_Count	[	9	]	=	1
BaoXiang_65JZDH	[	10	]	=	6627	BaoXiang_65JZDH_Rad	[	10	]	=	5	BaoXiang_65JZDH_Count	[	10	]	=	1
BaoXiang_65JZDH	[	11	]	=	6628	BaoXiang_65JZDH_Rad	[	11	]	=	5	BaoXiang_65JZDH_Count	[	11	]	=	1
BaoXiang_65JZDH	[	12	]	=	6629	BaoXiang_65JZDH_Rad	[	12	]	=	5	BaoXiang_65JZDH_Count	[	12	]	=	1
BaoXiang_65JZDH	[	13	]	=	6630	BaoXiang_65JZDH_Rad	[	13	]	=	5	BaoXiang_65JZDH_Count	[	13	]	=	1
BaoXiang_65JZDH	[	14	]	=	6631	BaoXiang_65JZDH_Rad	[	14	]	=	5	BaoXiang_65JZDH_Count	[	14	]	=	1
BaoXiang_65JZDH	[	15	]	=	6632	BaoXiang_65JZDH_Rad	[	15	]	=	5	BaoXiang_65JZDH_Count	[	15	]	=	1
BaoXiang_65JZDH	[	16	]	=	6633	BaoXiang_65JZDH_Rad	[	16	]	=	5	BaoXiang_65JZDH_Count	[	16	]	=	1
BaoXiang_65JZDH	[	17	]	=	6634	BaoXiang_65JZDH_Rad	[	17	]	=	5	BaoXiang_65JZDH_Count	[	17	]	=	1
BaoXiang_65JZDH	[	18	]	=	6635	BaoXiang_65JZDH_Rad	[	18	]	=	5	BaoXiang_65JZDH_Count	[	18	]	=	1
BaoXiang_65JZDH	[	19	]	=	6636	BaoXiang_65JZDH_Rad	[	19	]	=	5	BaoXiang_65JZDH_Count	[	19	]	=	1
BaoXiang_65JZDH	[	20	]	=	6637	BaoXiang_65JZDH_Rad	[	20	]	=	5	BaoXiang_65JZDH_Count	[	20	]	=	1


BaoXiang_75JZDH_Mxcount = 25
BaoXiang_75JZDH = {}					BaoXiang_75JZDH_Rad = {}					BaoXiang_75JZDH_Count = {}
BaoXiang_75JZDH	[	1	]	=	6638	BaoXiang_75JZDH_Rad	[	1	]	=	3	BaoXiang_75JZDH_Count	[	1	]	=	1
BaoXiang_75JZDH	[	2	]	=	6639	BaoXiang_75JZDH_Rad	[	2	]	=	5	BaoXiang_75JZDH_Count	[	2	]	=	1
BaoXiang_75JZDH	[	3	]	=	6640	BaoXiang_75JZDH_Rad	[	3	]	=	5	BaoXiang_75JZDH_Count	[	3	]	=	1
BaoXiang_75JZDH	[	4	]	=	6641	BaoXiang_75JZDH_Rad	[	4	]	=	3	BaoXiang_75JZDH_Count	[	4	]	=	1
BaoXiang_75JZDH	[	5	]	=	6642	BaoXiang_75JZDH_Rad	[	5	]	=	2	BaoXiang_75JZDH_Count	[	5	]	=	1
BaoXiang_75JZDH	[	6	]	=	6643	BaoXiang_75JZDH_Rad	[	6	]	=	3	BaoXiang_75JZDH_Count	[	6	]	=	1
BaoXiang_75JZDH	[	7	]	=	6644	BaoXiang_75JZDH_Rad	[	7	]	=	5	BaoXiang_75JZDH_Count	[	7	]	=	1
BaoXiang_75JZDH	[	8	]	=	6645	BaoXiang_75JZDH_Rad	[	8	]	=	5	BaoXiang_75JZDH_Count	[	8	]	=	1
BaoXiang_75JZDH	[	9	]	=	6646	BaoXiang_75JZDH_Rad	[	9	]	=	3	BaoXiang_75JZDH_Count	[	9	]	=	1
BaoXiang_75JZDH	[	10	]	=	6647	BaoXiang_75JZDH_Rad	[	10	]	=	2	BaoXiang_75JZDH_Count	[	10	]	=	1
BaoXiang_75JZDH	[	11	]	=	6648	BaoXiang_75JZDH_Rad	[	11	]	=	3	BaoXiang_75JZDH_Count	[	11	]	=	1
BaoXiang_75JZDH	[	12	]	=	6649	BaoXiang_75JZDH_Rad	[	12	]	=	5	BaoXiang_75JZDH_Count	[	12	]	=	1
BaoXiang_75JZDH	[	13	]	=	6650	BaoXiang_75JZDH_Rad	[	13	]	=	5	BaoXiang_75JZDH_Count	[	13	]	=	1
BaoXiang_75JZDH	[	14	]	=	6651	BaoXiang_75JZDH_Rad	[	14	]	=	3	BaoXiang_75JZDH_Count	[	14	]	=	1
BaoXiang_75JZDH	[	15	]	=	6652	BaoXiang_75JZDH_Rad	[	15	]	=	2	BaoXiang_75JZDH_Count	[	15	]	=	1
BaoXiang_75JZDH	[	16	]	=	6653	BaoXiang_75JZDH_Rad	[	16	]	=	5	BaoXiang_75JZDH_Count	[	16	]	=	1
BaoXiang_75JZDH	[	17	]	=	6654	BaoXiang_75JZDH_Rad	[	17	]	=	5	BaoXiang_75JZDH_Count	[	17	]	=	1
BaoXiang_75JZDH	[	18	]	=	6655	BaoXiang_75JZDH_Rad	[	18	]	=	5	BaoXiang_75JZDH_Count	[	18	]	=	1
BaoXiang_75JZDH	[	19	]	=	6656	BaoXiang_75JZDH_Rad	[	19	]	=	5	BaoXiang_75JZDH_Count	[	19	]	=	1
BaoXiang_75JZDH	[	20	]	=	6657	BaoXiang_75JZDH_Rad	[	20	]	=	2	BaoXiang_75JZDH_Count	[	20	]	=	1
BaoXiang_75JZDH	[	21	]	=	6658	BaoXiang_75JZDH_Rad	[	21	]	=	5	BaoXiang_75JZDH_Count	[	21	]	=	1
BaoXiang_75JZDH	[	22	]	=	6659	BaoXiang_75JZDH_Rad	[	22	]	=	5	BaoXiang_75JZDH_Count	[	22	]	=	1
BaoXiang_75JZDH	[	23	]	=	6660	BaoXiang_75JZDH_Rad	[	23	]	=	5	BaoXiang_75JZDH_Count	[	23	]	=	1
BaoXiang_75JZDH	[	24	]	=	6661	BaoXiang_75JZDH_Rad	[	24	]	=	5	BaoXiang_75JZDH_Count	[	24	]	=	1
BaoXiang_75JZDH	[	25	]	=	6662	BaoXiang_75JZDH_Rad	[	25	]	=	2	BaoXiang_75JZDH_Count	[	25	]	=	1
