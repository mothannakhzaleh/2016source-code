USE gamedbnew
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadAllData]
@charID INT
AS
SET NOCOUNT ON
SELECT act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version,
pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp,
live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, 
kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend 
FROM character
WHERE cha_id = @charID
GO


CREATE PROCEDURE [dbo].[SaveAllData]
@_HP INT,@_SP   INT,@_EXP VARCHAR(32),@_MAP  VARCHAR(50),@_MAIN_MAP  VARCHAR(50),
@_MAP_X  INT,@_MAP_Y  INT,@_RADIUS INT,@_ANGLE SMALLINT,@_PK_CTRL TINYINT,@_DEGREE SMALLINT,@_JOB SMALLINT,@_GD INT,
@_AP INT,@_TP INT,@_STR INT,@_DEX INT,@_AGI INT,@_CON INT,@_STA INT,@_LUK INT,@_LOOK VARCHAR(2000),@_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200),@_MISSION VARCHAR(2048),@_MISRECORD VARCHAR(2048),@_MISTRIGGER VARCHAR(2048),@_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50),@_LOGIN_CHA VARCHAR(50),@_SAIL_LV INT,@_SAIL_EXP INT,@_SAIL_LEFT_EXP INT,@_LIVE_LV INT,@_LIVE_EXP INT,
@_LIVE_TP INT,@_KB_LOCKED INT,@_CREDIT INT,@_STORE_ITEM INT,@_SKILL_STATE VARCHAR(1024),@_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp = @_HP, sp=@_SP, [exp]=CAST(@_EXP AS BIGINT), map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, radius=@_RADIUS, angle=@_ANGLE, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveAllDataWithoutPos]
@_HP INT,@_SP   INT,@_EXP VARCHAR(32),
@_RADIUS INT,@_PK_CTRL TINYINT,@_DEGREE SMALLINT,@_JOB SMALLINT,@_GD INT,
@_AP INT,@_TP INT,@_STR INT,@_DEX INT,@_AGI INT,@_CON INT,@_STA INT,@_LUK INT,@_LOOK VARCHAR(2000),@_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200),@_MISSION VARCHAR(2048),@_MISRECORD VARCHAR(2048),@_MISTRIGGER VARCHAR(2048),@_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50),@_LOGIN_CHA VARCHAR(50),@_SAIL_LV INT,@_SAIL_EXP INT,@_SAIL_LEFT_EXP INT,@_LIVE_LV INT,@_LIVE_EXP INT,
@_LIVE_TP INT,@_KB_LOCKED INT,@_CREDIT INT,@_STORE_ITEM INT,@_SKILL_STATE VARCHAR(1024),@_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp = @_HP, sp=@_SP, [exp]=CAST(@_EXP AS BIGINT),radius=@_RADIUS, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[OnlySavePosWhenBeSaved]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50),
@_MAP_X INT, @_MAP_Y INT, @_ANGLE INT,
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
map = @_MAP, main_map = @_MAIN_MAP, map_x = @_MAP_X, map_y = @_MAP_Y,
angle = @_ANGLE
WHERE cha_id = @_CHA_ID
GO 

CREATE PROCEDURE [dbo].[SaveAllDataExWithPos]
@_HP INT, @_SP INT, @_EXP BIGINT, @_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50),
@_MAP_X INT, @_MAP_Y INT, @_RADIUS INT, @_ANGLE SMALLINT, @_PK_CTRL TINYINT, @_DEGREE SMALLINT, @_JOB SMALLINT, @_GD INT,
@_AP INT, @_TP INT, @_STR INT, @_DEX INT, @_AGI INT, @_CON INT, @_STA INT, @_LUK INT, @_LOOK VARCHAR(2000), @_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200), @_MISSION VARCHAR(2048), @_MISRECORD VARCHAR(2048), @_MISTRIGGER VARCHAR(2048), @_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50), @_LOGIN_CHA VARCHAR(50), @_SAIL_LV INT, @_SAIL_EXP INT, @_SAIL_LEFT_EXP INT, @_LIVE_LV INT, @_LIVE_EXP INT,
@_LIVE_TP INT, @_KB_LOCKED INT, @_CREDIT INT, @_STORE_ITEM INT, @_SKILL_STATE VARCHAR(1024), @_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp=@_HP, sp=@_SP, [exp]=@_EXP, map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, radius=@_RADIUS, angle=@_ANGLE, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveAllDataExWithoutPos]

@_HP INT, @_SP INT, @_EXP BIGINT, @_RADIUS INT, @_PK_CTRL TINYINT, @_DEGREE SMALLINT, @_JOB SMALLINT, @_GD INT,
@_AP INT, @_TP INT, @_STR INT, @_DEX INT, @_AGI INT, @_CON INT, @_STA INT, @_LUK INT, @_LOOK VARCHAR(2000), @_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200), @_MISSION VARCHAR(2048), @_MISRECORD VARCHAR(2048), @_MISTRIGGER VARCHAR(2048), @_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50), @_LOGIN_CHA VARCHAR(50), @_SAIL_LV INT, @_SAIL_EXP INT, @_SAIL_LEFT_EXP INT, @_LIVE_LV INT, @_LIVE_EXP INT,
@_LIVE_TP INT, @_KB_LOCKED INT, @_CREDIT INT, @_STORE_ITEM INT, @_SKILL_STATE VARCHAR(1024), @_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp=@_HP, sp=@_SP, [exp]=@_EXP, radius=@_RADIUS, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SavePos]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50), @_MAP_X INT, @_MAP_Y INT, @_ANGLE INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, angle=@_ANGLE
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SavePosEx]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50), @_MAP_X INT, @_MAP_Y INT, @_ANGLE INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, angle=@_ANGLE
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveMoney]
@_GD INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
gd=@_GD
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveKBagDBIDEx]
@_ID INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
kitbag=@_ID
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveKBagTmpDBID]
@_ID INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
kitbag_tmp=@_ID
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveKBState]
@_Lock INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
kb_locked=@_Lock
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveStoreItemID]
@_ID INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
store_item=@_ID
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[AddMoney]
@_GOLD INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
gd = gd + @_GOLD
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[AddCreditByDBID]
@_CREDIT INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
credit=@_CREDIT
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[IsChaOnline]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT mem_addr FROM character
Where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveBankDBID]
@_BANK varchar(50), @_CHA_ID INT 
AS
SET NOCOUNT ON
UPDATE character set
bank=@_BANK
where cha_id=@_CHA_ID
GO

CREATE PROCEDURE [dbo].[SaveMissionData]
@_MIS_INFO varchar(2048), @_MIS_RECORD varchar(2048), @_MIS_TRIGGER varchar(2048), @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
mission=@_MIS_INFO, misrecord=@_MIS_RECORD, mistrigger=@_MIS_TRIGGER
where cha_id=@_CHA_ID
GO


CREATE PROCEDURE [dbo].[GetChallInfo]
@_CHALLLEVEL INT
AS 
SET NOCOUNT ON
SELECT guild_id, challid, challmoney FROM guild
where challlevel=@_CHALLLEVEL
GO 


CREATE PROCEDURE [dbo].[ChallWin1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where guild_id=@_GUILD_ID
GO 

CREATE PROCEDURE [dbo].[ChallWin2]
@_GUILD_ID INT, @_GUILD_LV INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = 0, challstart=0, challmoney = 0, challlevel=@_GUILD_LV
where guild_id=@_GUILD_ID
GO 

CREATE PROCEDURE [dbo].[ChallWin3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = 0, challstart=0, challmoney = 0, challlevel=0
where guild_id=@_GUILD_ID
GO 

CREATE PROCEDURE [dbo].[EndChall]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challstart, guild_name, challid, challmoney, challlevel FROM guild
where guild_id=@_GUILD_ID
GO 


CREATE PROCEDURE [dbo].[StartChall1]
@_GUILD_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney FROM guild
where challlevel=@_GUILD_LV
GO 


CREATE PROCEDURE [dbo].[StartChall2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set challstart = 1
where guild_id = @_GUILD_ID and challstart = 0
GO 


CREATE PROCEDURE [dbo].[HasCall]
@_CHALL_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, challstart FROM guild
where challlevel=@_CHALL_LV
GO 


CREATE PROCEDURE [dbo].[HasGuildLevel]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where guild_id = @_GUILD_ID
GO 

CREATE PROCEDURE [dbo].[ListChallenge1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[ListChallenge2]
@_CHALL_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where challlevel = @_CHALL_LV
GO

CREATE PROCEDURE [dbo].[Challenge2]
@_CHALL_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where challid = @_CHALL_ID
GO


CREATE PROCEDURE [dbo].[Challenge4]
@_CHALL_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where challid = @_CHALL_ID
GO

CREATE PROCEDURE [dbo].[Challenge5]
@_CHALL_ID INT, @_CHALL_MONEY INT,
@_GUILD_ID INT, @_MONEY INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = @_CHALL_ID, challmoney = @_CHALL_MONEY
where challid = @_CHALL_ID and challmoney < @_MONEY and challstart = 0
GO

CREATE PROCEDURE [dbo].[GetGuildName]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_name FROM guild
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[CancelTryFor]
@_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id =0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[Motto]
@_MOTTO VARCHAR(50), @_GUILD_ID INT,
@_LEADER_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set motto = @_MOTTO
where guild_id = @_GUILD_ID and leader_id = @_LEADER_ID
GO

CREATE PROCEDURE [dbo].[Disband3]
@_GUILD_ID INT, @_PASSWD VARCHAR(20),
@_LEADER_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set motto = '', passwd='', leader_id=0, stat=0,[money]=0,[exp]=0,member_total=0,try_total=0
where guild_id = @_GUILD_ID and leader_id = @_LEADER_ID and passwd=@_PASSWD
GO

CREATE PROCEDURE [dbo].[Leave1]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID AND guild_stat =0 and cha_id not in (select leader_id from guild where guild_id = @_GUILD_ID)
GO

CREATE PROCEDURE [dbo].[Leave2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set member_total = member_total -1
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Disband4]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id =0, guild_stat =0, guild_permission = 0
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Kick1]
@_CHA_ID INT, @_GUILD_ID INT, @_GUILD_PERM1 INT,
@_GUILD_PERM2 INT
AS 
SET NOCOUNT ON
SELECT cha_id from character
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_permission & @_GUILD_PERM1 = @_GUILD_PERM2
GO

CREATE PROCEDURE [dbo].[Kick2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat =0 and cha_id not in(select leader_id from guild where guild_id = @_GUILD_ID)
GO

CREATE PROCEDURE [dbo].[Reject2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission =0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat = 1
GO

CREATE PROCEDURE [dbo].[Reject3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set try_total = try_total -1
where guild_id = @_GUILD_ID and try_total > 0
GO

CREATE PROCEDURE [dbo].[Approve2]
@_GUILD_ID INT, @_MAX_MEMBERS INT
AS 
SET NOCOUNT ON
UPDATE guild set try_total = try_total -1, member_total = member_total +1
where guild_id = @_GUILD_ID and member_total < @_MAX_MEMBERS and try_total > 0
GO

CREATE PROCEDURE [dbo].[Approve3]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat = 1 and delflag = 0
GO

CREATE PROCEDURE [dbo].[ListTryPlayer1]
@_DISBAND_DAYS INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT g.guild_id, g.guild_name, g.motto, g.[type], g.stat, c.cha_name, g.member_total, g.[exp], g.[money], 
case when g.stat>0 then @_DISBAND_DAYS*24*60 - DATEDIFF(mi, g.disband_date, GETDATE()) else 0 end disband_time1
from character c, guild g
where g.leader_id = c.cha_id and g.guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[ListTryPlayer2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT c.cha_id, c.cha_name, c.job, c.degree from character c
where c.guild_stat = 1 and c.guild_id = @_GUILD_ID and c.delflag = 0
GO

CREATE PROCEDURE [dbo].[GetTypeByID]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT type, guild_name, motto from guild
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[TryForConfirm1]
@_GUILD_ID INT, @_CHA_ID INT,
@_MAX_TRY INT, @_MAX_MEMBER INT
AS 
SET NOCOUNT ON
update character set guild_id = @_GUILD_ID, guild_stat = 1, guild_permission =0
where cha_id = @_CHA_ID and @_GUILD_ID in (select guild_id from guild where leader_id >0 and guild_id = @_GUILD_ID and try_total < @_MAX_TRY and member_total < @_MAX_MEMBER)
GO

CREATE PROCEDURE [dbo].[TryForConfirm2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set try_total = try_total +1
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[TryFor1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id from guild
where leader_id > 0 and guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[TryFor2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT c.guild_id, c.guild_stat, g.guild_name from guild g, character c
where  c.guild_id = g.guild_id and c.cha_id = @_CHA_ID and g.guild_id <> @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[TryFor3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT type, guild_name from guild
where  guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Create1]
@_GUILD_TYPE INT
AS 
SET NOCOUNT ON
SELECT isnull(min(guild_id),0) from guild
where  guild_id > 0 and leader_id = 0 and type = @_GUILD_TYPE
GO

CREATE PROCEDURE [dbo].[Create2]
@_CHA_ID INT, @_PASSWD VARCHAR(20),
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set leader_id = @_CHA_ID, passwd = @_PASSWD, stat = 0, [money] = 0, [exp] = 0,
member_total = 1, try_total = 0
where  leader_id = 0 and guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Create3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
select guild_name from guild
where  guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Create4]
@_CHA_ID INT,
@_PASSWD VARCHAR(20), @_GUILD_NAME VARCHAR(16),
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set leader_id = @_CHA_ID, passwd=@_PASSWD, guild_name = @_GUILD_NAME, stat = 0, [money] = 0, [exp] = 0,
member_total =1, try_total = 0
where leader_id = 0 and guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Create5]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
update character set guild_id = @_GUILD_ID, guild_stat = 0, guild_permission = -1
where cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[ReadCabin]
@_BOAT_ID INT
AS 
SET NOCOUNT ON
select boat_bag from boat
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveCabin]
@_KITBAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_bag = @_KITBAG 
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveBoatExWithPos]
@_BOAT_BERTH SMALLINT, @_BOAT_OWNERID INT, @_CUR_ENDURE INT,
@_MX_ENDURE INT, @_CUR_SUPPLY INT, @_MX_SUPPLY INT,
@_SKILL_STATE CHAR(400), @_MAP CHAR(50), @_MAP_X INT,
@_MAP_Y INT, @_ANGLE INT,@_DEGREE SMALLINT, @_EXP INT,
@_BOAT_BAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
UPDATE boat set boat_berth=@_BOAT_BERTH, boat_ownerid=@_BOAT_OWNERID,cur_endure = @_CUR_ENDURE,
mx_endure=@_MX_ENDURE, cur_supply=@_CUR_SUPPLY, mx_supply=@_MX_SUPPLY, skill_state =@_SKILL_STATE,
map= @_MAP, map_x = @_MAP_X, map_y = @_MAP_Y, angle=@_ANGLE, degree =@_DEGREE, [exp]=@_EXP, boat_bag=@_BOAT_BAG
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveBoatEx]
@_BOAT_BERTH SMALLINT, @_BOAT_OWNERID INT, @_CUR_ENDURE INT,
@_MX_ENDURE INT, @_CUR_SUPPLY INT, @_MX_SUPPLY INT,
@_SKILL_STATE CHAR(400), @_DEGREE SMALLINT, @_EXP INT,
@_BOAT_BAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_berth=@_BOAT_BERTH, boat_ownerid=@_BOAT_OWNERID,cur_endure = @_CUR_ENDURE,
mx_endure=@_MX_ENDURE, cur_supply=@_CUR_SUPPLY, mx_supply=@_MX_SUPPLY, skill_state =@_SKILL_STATE,
degree = @_DEGREE, [exp]=@_EXP, boat_bag=@_BOAT_BAG
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveBoatTempData]
@_BOAT_DIECOUNT SMALLINT, @_BOAT_ISDEAD CHAR(1), 
@_BOAT_OWNERID INT, @_BOAT_ISDELETED CHAR(1),
@_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_diecount= @_BOAT_DIECOUNT, boat_isdead = @_BOAT_ISDEAD, 
boat_ownerid = @_BOAT_OWNERID, boat_isdeleted = @_BOAT_ISDELETED
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveBoatDelTag]
@_BOAT_ISDEL INT, @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_isdeleted = @_BOAT_ISDEL
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[SaveBoatTempData3params]
@_BOAT_OWNERID INT, @_BOAT_ISDEL CHAR(1),
@_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_ownerid = @_BOAT_OWNERID, boat_isdeleted=@_BOAT_ISDEL
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[GetBoat]
@_BOAT_ID INT
AS 
SET NOCOUNT ON
select boat_name, boat_boatid, boat_berth, boat_header, boat_body,
boat_engine, boat_cannon, boat_equipment, boat_diecount, boat_isdead,
boat_ownerid, boat_isdeleted, cur_endure, mx_endure, cur_supply, mx_supply,
skill_state, map, map_x, map_y, angle, degree, [exp] from boat
where boat_id = @_BOAT_ID
GO

CREATE PROCEDURE [dbo].[CreateBoat]
@_BOAT_NAME CHAR(17), @_BOAT_BERTH SMALLINT,
@_BOAT_BOATID INT, @_BOAT_HEADER INT, @_BOAT_BODY INT,
@_BOAT_ENGINE INT, @_BOAT_CANNON INT, @_BOAT_EQUIP INT,
@_BOAT_BAG INT, @_BOAT_DIECOUNT INT, @_BOAT_ISDEAD INT,
@_BOAT_OWNERID INT, @_BOAT_CREATETIME CHAR(50), @_BOAT_ISDEL INT
AS 
SET NOCOUNT ON
insert boat
(boat_name, boat_berth, boat_boatid, boat_header, boat_body,
boat_engine, boat_cannon, boat_equipment, boat_bag, boat_diecount,
boat_isdead, boat_ownerid, boat_createtime, boat_isdeleted)
values(@_BOAT_NAME, @_BOAT_BERTH,
@_BOAT_BOATID, @_BOAT_HEADER, @_BOAT_BODY,
@_BOAT_ENGINE, @_BOAT_CANNON, @_BOAT_EQUIP,
@_BOAT_BAG, @_BOAT_DIECOUNT, @_BOAT_ISDEAD,
@_BOAT_OWNERID, @_BOAT_CREATETIME, @_BOAT_ISDEL)
GO

CREATE PROCEDURE [dbo].[AccReadAllData]
@_ACT_ID INT
AS 
SET NOCOUNT ON
select gm, act_name from account
where act_id = @_ACT_ID
GO

CREATE PROCEDURE [dbo].[SaveBankDataEx]
@_CONTENT CHAR(8000), @_BANK_ID INT 
AS 
SET NOCOUNT ON
update Resource set content = @_CONTENT
where id = @_BANK_ID
GO

CREATE PROCEDURE [dbo].[ReadBankDataEx]
@_BANK_ID INT 
AS 
SET NOCOUNT ON
select cha_id, type_id, content from Resource
where id = @_BANK_ID
GO

CREATE PROCEDURE [dbo].[SaveKitbagTmpDataEx]
@_CONTENT CHAR(8000), @_ID INT
AS 
SET NOCOUNT ON
update Resource set content=@_CONTENT
where id = @_ID
GO

CREATE PROCEDURE [dbo].[ReadKitbagTmpData]
@_ID INT
AS 
SET NOCOUNT ON
select content from Resource
where id = @_ID
GO

CREATE PROCEDURE [dbo].[ReadKitbagTmpDataEx]
@_ID INT
AS 
SET NOCOUNT ON
select cha_id, type_id, content from Resource
where id = @_ID
GO

CREATE PROCEDURE [dbo].[ResourceCreate]
@_ID INT, @_TYPE_ID INT
AS 
SET NOCOUNT ON
insert Resource (cha_id, type_id)
values(@_ID, @_TYPE_ID)
GO

CREATE PROCEDURE [dbo].[AddStatLog]
@_LOGIN_NUM INT, @_PLAY_NUM INT, @_WGPLAY_NUM INT
AS
SET NOCOUNT ON
INSERT INTO stat_log (login_num, play_num, wgplay_num) 
VALUES (@_LOGIN_NUM, @_PLAY_NUM, @_WGPLAY_NUM)
GO

CREATE PROCEDURE [dbo].[SetDiscInfo]
@_CLIENT_IP VARCHAR(16), 
@_REASON VARCHAR(128),
@_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET last_ip = @_CLIENT_IP, disc_reason = @_REASON 
WHERE act_id = @_ACT_ID
GO

CREATE PROCEDURE [dbo].[InsertRow1]
AS
SET NOCOUNT ON
SELECT TOP 1 act_id 
FROM account WITH(nolock)
ORDER BY act_id DESC
GO

CREATE PROCEDURE [dbo].[InsertRow2]
@_ACT_ID INT, @_ACT_NAME VARCHAR(50), @_CHA_IDS VARCHAR(80)
AS
SET NOCOUNT ON
INSERT INTO account (act_id, act_name, cha_ids)
VALUES (@_ACT_ID, @_ACT_NAME, @_CHA_IDS)
GO

CREATE PROCEDURE [dbo].[UpdateRow]
@_CHA_IDS VARCHAR(80), @_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET cha_ids = @_CHA_IDS
WHERE act_id = @_ACT_ID
GO

CREATE PROCEDURE [dbo].[UpdatePassword]
@_PASSWORD VARCHAR(50), @_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET password = @_PASSWORD
WHERE act_id = @_ACT_ID
GO

CREATE PROCEDURE [dbo].[FetchRowByActName]
@_ACT_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT act_id,gm,cha_ids,password,last_ip,disc_reason,CONVERT(varchar(20),last_leave,120)
FROM account
WHERE act_name = @_ACT_NAME
GO

CREATE PROCEDURE [dbo].[FetchRowByActID]
@_ACT_ID INT
AS
SET NOCOUNT ON
SELECT act_name,gm,cha_ids,password,last_ip,disc_reason,CONVERT(varchar(20),last_leave,120)
FROM account
WHERE act_id = @_ACT_ID
GO

CREATE PROCEDURE [dbo].[ZeroAddr]
AS 
SET NOCOUNT ON
UPDATE character
SET mem_addr = 0
WHERE mem_addr != 0
GO

CREATE PROCEDURE [dbo].[SetAddr]
@_MEM_ADDR BIGINT, @_CHA_ID INT
AS
SET NOCOUNT ON 
UPDATE character set mem_addr = @_MEM_ADDR 
where cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[InsertRow3]
@_CHA_NAME VARCHAR(50), @_ACT_ID INT,
@_BIRTH VARCHAR(50), @_MAP VARCHAR(50),
@_LOOK VARCHAR(2000)
AS
SET NOCOUNT ON 
insert character (cha_name, act_id, birth, map, look) values
(@_CHA_NAME, @_ACT_ID, @_BIRTH, @_MAP, @_LOOK)
GO

CREATE PROCEDURE [dbo].[SaveParam]
@_PARAM1 INT, @_PARAM2 INT, @_PARAM3 INT,
@_PARAM4 INT, @_PARAM5 INT, @_PARAM6 INT,
@_PARAM7 INT, @_PARAM8 INT, @_PARAM9 INT,
@_PARAM10 INT
AS
SET NOCOUNT ON 
update param set param1 = @_PARAM1, param2 = @_PARAM2, param3 = @_PARAM3,
param4=@_PARAM4, param5=@_PARAM5, param6=@_PARAM6,param7=@_PARAM7,param8=@_PARAM8,
param9=@_PARAM9, param10=@_PARAM10 where id = 1
GO

CREATE PROCEDURE [dbo].[GetGuildMemberNum]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
select member_total from guild 
where guild_id = @_GUILD_ID
GO

CREATE PROCEDURE [dbo].[InitGuildMember]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
select c.mem_addr, c.cha_id, c.cha_name, c.motto, c.job, c.degree, c.icon, c.guild_permission
from character as c where (c.guild_stat = 0) and (c.guild_id = @_GUILD_ID) and (c.delflag = 0)
GO

CREATE PROCEDURE [dbo].[UpdateInfo]
@_ICON SMALLINT, @_MOTTO VARCHAR(50), @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET icon = @_ICON, motto = @_MOTTO
WHERE cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[FetchRowByChaName]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT cha_id, motto, icon
FROM character
WHERE cha_name = @_CHA_NAME
GO

CREATE PROCEDURE [dbo].[FetchAccidByChaName]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT cha_id
FROM character
WHERE cha_name = @_CHA_NAME
GO

CREATE PROCEDURE [dbo].[StartEstopTime]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET estop = GETDATE()
WHERE cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[EndEstopTime]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET estoptime = estoptime - DATEDIFF(minute, estop, GETDATE()) 
WHERE cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[IsEstop]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT estop
FROM character
WHERE cha_id = @_CHA_ID and DATEADD(minute, estoptime, estop) > GETDATE()
GO

CREATE PROCEDURE [dbo].[EStop]
@_CHA_NAME VARCHAR(50), @_TIME INT
AS
SET NOCOUNT ON
UPDATE character
SET estop = GETDATE(), estoptime = @_TIME
WHERE cha_name = @_CHA_NAME
GO

CREATE PROCEDURE [dbo].[DelEstop]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
UPDATE character
SET estoptime = 0 
WHERE cha_name = @_CHA_NAME
GO


CREATE PROCEDURE [dbo].[FetchRowByChaID]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT c.cha_name, c.motto, c.icon,
CASE 
	WHEN c.guild_stat = 0 THEN c.guild_id ELSE 0 END,
CASE
	WHEN c.guild_stat <>0 OR c.guild_id = 0 THEN '(none]' ELSE g.guild_name END,
c.job, c.degree, c.map, c.map_x,c.map_y,c.look,c.str,c.dex,c.agi,c.con,c.sta,c.luk

FROM character c, guild g
WHERE c.guild_id = g.guild_id AND c.cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[Disband1]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
update guild set motto='', passwd='', leader_id = 0, stat = 0, money =0, [exp] = 0, member_total=0, try_total=0
where guild_id =@_GUILD_ID
GO

CREATE PROCEDURE [dbo].[Disband2]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
update character set guild_id = 0, guild_stat = 0, guild_permission = 0
where guild_id =@_GUILD_ID
GO

CREATE PROCEDURE [dbo].[GuildFetchRowByName]
@_GUILD_NAME VARCHAR(16)
AS
SET NOCOUNT ON 
select guild_id from guild
where guild_id =@_GUILD_NAME
GO


CREATE PROCEDURE [dbo].[FetchActNameRowByChaID]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT a.act_name
FROM character c, account a
WHERE c.cha_id = @_CHA_ID AND c.act_id = a.act_id
GO

CREATE PROCEDURE [dbo].[BackupRow]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT guild_id, guild_stat
FROM character
WHERE cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[BackupRow1]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET delflag = 1, deldate = GETDATE()
WHERE cha_id = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[GetPrenticeData]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from (
		select distinct master.relation relation from character INNER JOIN
		master ON character.cha_id = master.cha_id1 where master.cha_id2 = @_CHA_ID
		) cc union select master.relation relation,count(character.mem_addr) addr,0
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON
		character.cha_id = master.cha_id1 where master.cha_id2 = @_CHA_ID group by relation
		union select master.relation relation,character.mem_addr addr,character.cha_id
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto
		from character INNER JOIN master ON character.cha_id = master.cha_id1
		where master.cha_id2 = @_CHA_ID order by relation,cha_id,icon
GO

CREATE PROCEDURE [dbo].[GetMasterData]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( 
		select distinct master.relation relation from character INNER JOIN 
		master ON character.cha_id = master.cha_id2 where master.cha_id1 = @_CHA_ID 
		) cc union select master.relation relation,count(character.mem_addr) addr,0 
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON 
		character.cha_id = master.cha_id2 where master.cha_id1 = @_CHA_ID group by relation 
		union select master.relation relation,character.mem_addr addr,character.cha_id 
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto
		from character INNER JOIN master ON character.cha_id = master.cha_id2
		where master.cha_id1 = @_CHA_ID order by relation,cha_id,icon
GO

CREATE PROCEDURE [dbo].[FinishMaster]
@_CHA_ID INT
AS
SET NOCOUNT ON 
update [master] set finish = 1 where cha_id1 = @_CHA_ID
GO

CREATE PROCEDURE [dbo].[DelMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
delete [master] where (cha_id1 = @_CHA_ID and cha_id2 = @_CHA_ID2)
GO

CREATE PROCEDURE [dbo].[AddMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
insert [master] (cha_id1, cha_id2, finish) values (@_CHA_ID, @_CHA_ID2, 0)
GO

CREATE PROCEDURE [dbo].[HasMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id1=@_CHA_ID and cha_id2=@_CHA_ID2)
GO

CREATE PROCEDURE [dbo].[GetPrenticeCount]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id2=@_CHA_ID and finish = 0)
GO

CREATE PROCEDURE [dbo].[GetMasterCount]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id1=@_CHA_ID)
GO

CREATE PROCEDURE [dbo].[DelFriend]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
delete friends 
where(cha_id1=@_CHA_ID1 AND cha_id2=@_CHA_ID2) OR (cha_id1=@_CHA_ID2 and cha_id2=@_CHA_ID1)
GO

CREATE PROCEDURE [dbo].[AddFriend]
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
insert friends (cha_id1, cha_id2, relation) values
(@_CHA_ID1, @_CHA_ID2, @_RELATION)
GO

CREATE PROCEDURE [dbo].[AddGroup]
@_CHA_ID1 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
insert into friends (cha_id1, cha_id2, relation, createtime) values
(@_CHA_ID1, -1, @_RELATION, GETDATE())
GO

CREATE PROCEDURE [dbo].[DeleteGroup]
@_CHA_ID1 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
delete friends 
where cha_id1 = @_CHA_ID1 and cha_id2=-1 and relation = @_RELATION
GO

CREATE PROCEDURE [dbo].[UpdateGroup]
@_RELATION_NEW VARCHAR(50),
@_CHA_ID1 INT,
@_RELATION_OLD VARCHAR(50)
AS
SET NOCOUNT ON 
update friends set relation = @_RELATION_NEW where cha_id1=@_CHA_ID1 and relation=@_RELATION_OLD
GO

CREATE PROCEDURE [dbo].[GetFriendAddr]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select character.mem_addr addr
from character (nolock) INNER JOIN friends on character.cha_id = friends.cha_id2
where (friends.cha_id1=@_CHA_ID1 AND friends.cha_id2 = @_CHA_ID2)
GO

CREATE PROCEDURE [dbo].[GetGroupCount]
@_CHA_ID1 INT
AS
SET NOCOUNT ON 
select count(*) num 
from (select distinct friends.relation relation from friends where friends.cha_id1=@_CHA_ID1 and friends.cha_id2=-1) cc
where 1=1
GO

CREATE PROCEDURE [dbo].[MoveGroup]
@_RELATION_NEW VARCHAR(50),
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION_OLD VARCHAR(50)
AS
SET NOCOUNT ON 
update friends set relation=@_RELATION_NEW where cha_id1= @_CHA_ID1 and cha_id2=@_CHA_ID2 and relation=@_RELATION_OLD
GO

CREATE PROCEDURE [dbo].[GroupIsExsit]
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2=@_CHA_ID2) and relation=@_RELATION
GO

CREATE PROCEDURE [dbo].[GetFriendsCount1]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2 = @_CHA_ID2) OR (cha_id1=@_CHA_ID2 and cha_id2=@_CHA_ID1)
GO

CREATE PROCEDURE [dbo].[GetFriendsCount2]
@_CHA_ID1 INT, @_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2 <> -1) AND (relation=@_RELATION)
GO

