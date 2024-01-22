#pragma once

#ifndef ENUMSQLSTATEMENTS_H
#define ENUMSQLSTATEMENTS_H

// Account Server Statements

#define ACCOUNT_QUERYACCOUNT "select id, password, sid, login_status, login_group, ban, datediff(s, enable_login_time, getdate()) as protect_time from account_login where name = ?"
#define ACCOUNT_ACCOUNTLOGIN_OFFLINE "update account_login set login_status = ?, login_group = ?, enable_login_time = getdate(), last_login_time = getdate(), last_login_mac = ?, last_login_ip = ? where id = ?"
#define ACCOUNT_ACCOUNTLOGIN_ONLINE "update account_login set login_status=?, login_group=?, last_login_time=getdate(), last_login_mac=?, last_login_ip=? where id=?"
#define ACCOUNT_ACCOUNTLOGIN_SAVING "update account_login set login_status=?, login_group=?, enable_login_time=getdate(), last_login_time=getdate(), last_login_mac=?, last_login_ip=? where id=?"
#define ACCOUNT_ACCOUNTLOGOUT "update account_login set login_status=?, login_group='', enable_login_time=getdate(), last_logout_time=getdate(), total_live_time=total_live_time+datediff(second, last_login_time, getdate()) where id=?"
#define ACCOUNT_CREATEOBJ_1  "select ban from account_login where 1 = 2"
#define ACCOUNT_CREATEOBJ_2 "select log_id, user_id, user_name, login_time, logout_time, login_ip from user_log where 1= 2"
#define ACCOUNT_CREATEOBJ_3 "select act_name, SessionKey, act_id, create_time, update_time from act_album where 1 = 2"
#define ACCOUNT_USERLOGIN	 "insert into user_log (user_id, user_name, login_time, login_ip) values (?, ?, getdate(), ?)"
#define ACCOUNT_USERLOGOUT  "update user_log set logout_time=getdate() where log_id=(select max(log_id) from user_log where user_id=?)"
#define ACCOUNT_KICKUSER		"select id, login_group, last_logout_time from account_login where name=?"
#define ACCOUNT_SETEXPSCALE	"select id, login_group, last_logout_time from account_login where name=?"
#define ACCOUNT_OPERACCOUNTBAN	   "update account_login set ban = ? where name = ?"


// GroupServer SQL Statements
// DBConnect.cpp
#define GROUP_ADDSTATLOG "insert stat_log (login_num , play_num, wgplay_num) values (?, ?, ?)"
#define GROUP_SETDISCINFO "update ? set last_ip=?,disc_reason =?,last_leave =getdate() where act_id =?"
#define GROUP_INSERTROW_ACCOUNT	  "insert account (act_id, act_name, cha_ids) values (?, ?, ?)" // Table name cannot be a parameter
#define GROUP_UPDATEROW_ACCOUNT	         "update account set cha_ids=? where act_id=?" // Table name cannot be a parameter
#define GROUP_UPDATEPASSWORD "update account set password=? where act_id=?" // Table name cannot be a parameter
#define GROUP_FETCHROWBYACTNAME "act_name=?" 
#define GROUP_FETCHROWBYACTID	"act_id=?"
#define GROUP_ZEROADDR			"update character set mem_addr = 0 where mem_addr != 0"
#define GROUP_SETADDR			"update character set mem_addr =? where cha_id =?"
#define GROUP_INSERTROW_CHARACTER "insert character (act_id, act_name, cha_ids) values (?, ?, ?)" // Table name cannot be a parameter
#define GROUP_UPDATEROW_CHARACTER "update character set cha_ids=? where act_id=?"				  // Table name cannot be a parameter
#define GROUP_UPDATEINFO		"update character set icon =?,motto =? where cha_id =?"           // Table name cannot be a parameter
#define GROUP_FETCHROWBYCHANAME			 "cha_name=?"
#define GROUP_FETCHACCIDBYCHANAME		 "cha_name=?"
#define GROUP_STARTESTOPTIME			 "update character set estop = getdate() where cha_id =?"  // Table name cannot be a parameter
#define GROUP_ENDESTOPTIME				"update character set estoptime = estoptime - datediff(minute, estop, getdate()) where cha_id =?"
#define GROUP_ISESTOP					 "cha_id = ? and dateadd(minute, estoptime, estop) > getdate()"
#define GROUP_ESTOP						 "update character set estop = getdate(), estoptime = ? where cha_name =?"
#define GROUP_ADDMONEY					 "update character set gd = gd + ? where cha_id =?"
#define GROUP_DELESTOP					 "update character set estoptime = ? where cha_name =?"
#define GROUP_FETCHROWBYCHAID			 "c.guild_id =g.guild_id and c.cha_id=?"    // Check this one, get_row usage
#define GROUP_FETCHACTNAMEROWBYCHAID     "c.cha_id = ? and c.act_id = a.act_id "  // Check this one, get_row usage
#define GROUP_BACKUPROW_1				 "cha_id = ?" //get_row
#define GROUP_BACKUPROW_2				 "update guild set member_total =member_total -1 where guild_id =? and member_total > 0"
#define GROUP_BACKUPROW_3				 "update guild set try_total =try_total -1 where guild_id =? and try_total > 0"
#define GROUP_BACKUPROW_4				 "update character set delflag =1,deldate =getdate() where cha_id=?"           // Can't use table as param
#define GROUP_ADDINFO_INFO		         "INSERT INTO personinfo ([cha_id],[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type] \
				 ,[birthday],[state],[city],[constellation],[career],[avatarsize],[prevent],[support],[oppose])	\
				 VALUES( ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,? , ?, ?, ?)"
#define GROUP_GETINFO_INFO				 "cha_id = ?"
#define GROUP_DELINFO_INFO				 "delete personinfo where (cha_id = ?)"
#define GROUP_ADDINFO_AVATAR			 "INSERT INTO personavatar ([cha_id],[avatar]) VALUES( ?, ?)"
#define GROUP_GETINFO_AVATAR			 "cha_id= ?"
#define GROUP_DELINFO_AVATAR			 "delete personavatar where (cha_id=? )"
#define GROUP_GETFRIENDSCOUNT_1			 "(cha_id1=? AND cha_id2 =?)OR(cha_id1=? AND cha_id2 =?)" // get_row
#define GROUP_GETFRIENDSCOUNT_2			 "(cha_id1=? AND cha_id2 <> -1) AND (relation=?)" // get_row
#define GROUP_GROUPISEXSIT				 "(cha_id1=? AND cha_id2 = ?) AND (relation=?)" //get_row
#define GROUP_MOVEGROUP					 "update friends set relation = ? where cha_id1 = ? and cha_id2 = ? and relation = ?"
#define GROUP_GETGROUPCOUNT				 "(select distinct friends.relation relation from friends\
						where friends.cha_id1 =? and friends.cha_id2 = -1) cc" //Check this
#define GROUP_GETFRIENDADDR				 "(friends.cha_id1=? AND friends.cha_id2 =?)"
#define GROUP_UPDATEGROUP				 "update friends set relation = ? where cha_id1 = ? AND relation = ?"
#define GROUP_DELETEGROUP				 "delete friends where cha_id1=? AND cha_id2 = -1 AND relation =?"
#define GROUP_ADDGROUP					 "insert into friends (cha_id1,cha_id2,relation,createtime) values(? , -1 , ?, getdate())"
#define GROUP_ADDFRIEND					 "insert friends (cha_id1,cha_id2,relation) values(?,?,?)"
#define GROUP_DELFRIEND					 "delete friends where (cha_id1=? AND cha_id2 =?)OR(cha_id1=? AND cha_id2 =?)"
#define GROUP_GETMASTERCOUNT			 "(cha_id1=?)"
#define GROUP_GETPRENTICECOUNT			 "(cha_id2=? AND finish=0)"
#define GROUP_HASMASTER					 "(cha_id1=? AND cha_id2=?)"
#define GROUP_ADDMASTER					 "insert master (cha_id1,cha_id2,finish) values(?,?,?)"
#define GROUP_DELMASTER				     "delete master where (cha_id1=? AND cha_id2 =?)"
#define GROUP_FINISHMASTER				 "update master set finish=1 where cha_id1=?"
#define GROUP_INITMASTERRELATION		 "select cha_id1 cha_id1,cha_id2 cha_id2 from master"
#define GROUP_GETMASTERDATA				 "select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( \
		select distinct master.relation relation from character INNER JOIN \
		master ON character.cha_id = master.cha_id2 where master.cha_id1 = ? \
		) cc union select master.relation relation,count(character.mem_addr) addr,0 \
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON \
		character.cha_id = master.cha_id2 where master.cha_id1 = ? group by relation \
		union select master.relation relation,character.mem_addr addr,character.cha_id \
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto \
		from character INNER JOIN master ON character.cha_id = master.cha_id2 \
		where master.cha_id1 = ? order by relation,cha_id,icon"
#define GROUP_GETPRENTICEDATA			 "select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( \
		select distinct master.relation relation from character INNER JOIN \
		master ON character.cha_id = master.cha_id1 where master.cha_id2 = ? \
		) cc union select master.relation relation,count(character.mem_addr) addr,0 \
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON \
		character.cha_id = master.cha_id1 where master.cha_id2 = ? group by relation \
		union select master.relation relation,character.mem_addr addr,character.cha_id \
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto \
		from character INNER JOIN master ON character.cha_id = master.cha_id1 \
		where master.cha_id2 = ? order by relation,cha_id,icon"
#define GROUP_FETCHROWBYNAME			 "guild_name = ?"
#define GROUP_DISBAND_1					 "update guild set motto ='',passwd ='',leader_id =0,stat =0,money =0,exp =0,member_total =0,try_total =0\
					where guild_id =?"
#define GROUP_DISBAND_2					 "update character set guild_id = 0, guild_stat = 0, guild_permission = 0 where guild_id = ?"
#define GROUP_INITALLGUILD				 "select g.guild_id, g.guild_name, g.motto, g.leader_id,g.type,g.stat,\
						g.money, g.exp, g.member_total, g.try_total,g.disband_date,\
						case when g.stat>0 then DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end TotalMins,\
		 case when g.stat>0 then ?*24*60 -DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end LeaveMins\
		 from guild As g where (g.guild_id > 0)"
#define GROUP_INITGUILDMEMBER			 "select c.mem_addr,c.cha_id, c.cha_name, c.motto, c.job, c.degree, c.icon, c.guild_permission\
					from character As c\
					where (c.guild_stat =0) and (c.guild_id =?) and (c.delflag = 0)"
#define GROUP_GETGUILDMEMBERNUM			 "guild_id = ?"
#define GROUP_INITPARAM_1					 "" // Constant query, no need to SQLPrepare()
#define GROUP_INITPARAM_2				 "select cha_name,job,degree from character where cha_id = ?"
#define GROUP_SAVEPARAM				     "update Param set param1 = ?,param2 = ?,param3 = ?,param4 = ?,param5 = ?,param6 = ?,param7 = ?,param8 = ?,param9 = ?,param10 = ? where id = 1"

// GameServer SQL Statements
// GameApp.cpp
#define GAME_CDBDLOGMGRLOG_1 "insert gamelog(action, c1, c2, c3, c4, content) \
	values(?, ?, ?, ?, ?, ?)"
#define GAME_CDBDLOGMGRLOG_2 "insert gamelog (action, c1, c2, c3, c4, content) \
					   values(?, ?, ?, ?, ?, ?)"

// GameDB.cpp 
#define GAME_VERIFYNAME "cha_name=?"
#define GAME_CTABLEMASTER_INIT "select \
				   cha_id1, cha_id2, finish, relation\
				   from master \
				   (nolock) where 1=2"     // Constant
#define GAME_CTABLEMASTER_GETMASTERDBID "cha_id1=?"
#define GAME_CTABLEMASTER_ISMASTERRELATION "(cha_id1=?) and (cha_id2=?)"
#define GAME_CTABLECHA_INIT				   "select \
				   cha_id, cha_name, motto, icon, version, pk_ctrl, mem_addr, act_id, guild_id, guild_stat, guild_permission, job, degree, exp, \
				   hp, sp, ap, tp, gd, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, map, main_map, map_x, map_y, radius, \
				   angle, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, birth, login_cha, live_tp, bank, \
				   delflag, operdate, skill_state, kitbag, kitbag_tmp, kb_locked, credit, store_item \
				   from character \
				   (nolock) where 1=2" // Constant
#define GAME_CTABLECHA_READALLDATA		   "cha_id=?"
#define GAME_CTABLECHA_READALLDATAEX	   "cha_id=?"
#define GAME_CTABLECHA_ONLYSAVEPOSWHENBESAVED "update character set \
				   map=?, main_map=?, map_x=?, map_y=?, angle=? \
				   where cha_id=?"

#define GAME_CTABLECHA_ONLYSAVEPOSWHENBESAVEDEX "update character set \
				   map=?, main_map=?, map_x=?, map_y=?, angle=? \
				   where cha_id=?"
#define GAME_CTABLECHA_SAVEALLDATA_1				"update character set \
					   hp=?, sp=?, exp=?, map=?, main_map=?, map_x=?, map_y=?, radius=?, angle=?, pk_ctrl=?, degree=?, job=?, gd=?, ap=?, tp=?, str=?, dex=?, agi=?, con=?, sta=?, luk=?, look=?, skillbag=?, \
					   shortcut=?, mission=?, misrecord=?, mistrigger=?, miscount=?, birth=?, login_cha=?, \
					   sail_lv=?, sail_exp=?, sail_left_exp=?, live_lv=?, live_exp=?, live_tp=?, kb_locked=?, credit=?, store_item=?, skill_state=?, extend =? \
					   where cha_id=?"
#define GAME_CTABLECHA_SAVEALLDATA_2			"update character set \
					   hp=?, sp=?, exp=?, radius=?, pk_ctrl=?, degree=?, job=?, gd=?, ap=?, tp=?, str=?, dex=?, agi=?, con=?, sta=?, luk=?, look=?, skillbag=?, \
					   shortcut=?, mission=?, misrecord=?, mistrigger=?, miscount=?, birth=?, login_cha=?, \
					   sail_lv=?, sail_exp=?, sail_left_exp=?, live_lv=?, live_exp=?, live_tp=?, kb_locked=?, credit=?, store_item=?, skill_state=?, extend =? \
					   where cha_id=?"

#define GAME_CTABLECHA_SAVEALLDATAEX_1 "update character set \
					   hp=?, sp=?, exp=?, map=?, main_map=?, map_x=?, map_y=?, radius=?, angle=?, pk_ctrl=?, degree=?, job=?, gd=?, ap=?, tp=?, str=?, dex=?, agi=?, con=?, sta=?, luk=?, look=?, skillbag=?, \
					   shortcut=?, mission=?, misrecord=?, mistrigger=?, miscount=?, birth=?, login_cha=?, \
					   sail_lv=?, sail_exp=?, sail_left_exp=?, live_lv=?, live_exp=?, live_tp=?, kb_locked=?, credit=?, store_item=?, skill_state=?, extend =? \
					   where cha_id=?"

#define GAME_CTABLECHA_SAVEALLDATAEX_2 "update character set \
					   hp=?, sp=?, exp=?, radius=?, pk_ctrl=?, degree=?, job=?, gd=?, ap=?, tp=?, str=?, dex=?, agi=?, con=?, sta=?, luk=?, look=?, skillbag=?, \
					   shortcut=?, mission=?, misrecord=?, mistrigger=?, miscount=?, birth=?, login_cha=?, \
					   sail_lv=?, sail_exp=?, sail_left_exp=?, live_lv=?, live_exp=?, live_tp=?, kb_locked=?, credit=?, store_item=?, skill_state=?, extend =? \
					   where cha_id=?"

#define GAME_CTABLECHA_SAVEPOS "update character set \
				   map=?, main_map=?, map_x=?, map_y=?, angle=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEPOSEX "update character set \
				   map=?, main_map=?, map_x=?, map_y=?, angle=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEMONEY "update character set \
				   gd=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEKBAGDBIDEX "update character set \
				   kitbag=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEKBAGDBID "update character set \
				   kitbag=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEKBAGTMPDBID "update character set \
				   kitbag_tmp=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEKBAGTMPDBIDEX "update character set \
				   kitbag_tmp=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEKBSTATE "update character set \
				   kb_locked=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVESTOREITEMID "update character set \
				   store_item=? \
				   where cha_id=?"

#define GAME_CTABLECHA_ADDMONEY "update character set \
				   gd=gd+? \
				   where cha_id=?"

#define GAME_CTABLECHA_ADDCREDITBYDBID "update character set \
				   credit=credit+? \
				   where cha_id=?"

#define GAME_CTABLECHA_ISCHAONLINE "select mem_addr from character where cha_id=?"

#define GAME_CTABLECHA_SAVEMMASKDBID "update character set \
				   map_mask=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEBANKDBID "update character set \
				   bank=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEBANKDBIDEX "update character set \
				   bank=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVETABLEVER "update character set \
				   version=? \
				   where cha_id=?"

#define GAME_CTABLECHA_SAVEMISSIONDATA "update character set mission=?, misrecord=?, mistrigger=? \
					where cha_id=?"

#define GAME_CTABLECHA_UPDATEENTERMAPTIME "update character set entermaptime = getdate() where cha_id = ?"

#define GAME_CTABLECHA_UPDATEOUTMAPTIME "update character set outmaptime = getdate() where cha_id = ?"

#define GAME_CTABLECHA_CALCULATEDISTIME_1 "cha_id = ?"
#define GAME_CTABLECHA_CALCULATEDISTIME_2 "cha_id = ?"
#define GAME_CTABLECHA_CALCULATEDISTIME_3 "update character set threedistime = %? where cha_id =?"
#define GAME_CTABLECHA_GETDISTIME		  "cha_id = ?"
#define GAME_CTABLECHA_UPDATEDISTIME_1	  "cha_id = ?"
#define GAME_CTABLECHA_UPDATEDISTIME_2	  "update character set threedistime = 0 where cha_id = ?"
#define GAME_CTABLECHA_UPDATEDISTIME_3	  "update character set threedistime = ? where cha_id = ?"
#define GAME_CTABLECHA_SETDISTIME		  "update character set threedistime = 0 where cha_id = ?"
#define GAME_CTABLECHA_GETDWFLATMONEY_1	  "cha_name = ?"
#define GAME_CTABLECHA_SETDWFLATMONEY_2	  "cha_id = ?"
#define GAME_CTABLECHA_SETDWFLATMONEY_3	  "update character set flatcoins = flatcoins + ? where cha_id = ?"



#define GAME_CTABLEACT_READALLDATA "act_id=?"

#endif