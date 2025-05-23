#ifndef DBCONNECT_H
#define DBCONNECT_H
#include "util.h"
/*
class TBLSystem : public cfl_rs
{
public:
	TBLSystem(cfl_db* db):cfl_rs(db,"system1",SYS_MAXCOL)
	{}
	int Increment();
	void Decrement();
private:
	enum{SYS_MAXCOL	=3};
	string m_buf[SYS_MAXCOL];
};*/

struct stPersonInfo;
struct stQueryPersonInfo;
struct stQueryResoultPersonInfo;

#define MAXORDERNUM 5
class TBLAccounts : public  cfl_rs
{
public:
	TBLAccounts(cfl_db* db):cfl_rs(db,"account",ACT_MAXCOL)
	{}
	void AddStatLog(long login,long play,long wgplay=0);

	bool IsReady();
	bool SetDiscInfo(int actid,const char *cli_ip,const char *reason);
	// Modify by lark.li 20081111 begin
	//bool InsertRow(int act_id,const char *act_name,const char *cha_ids);
	bool InsertRow(int act_id,const char *act_name,const char *cha_ids, bool equal);
	// End
	bool UpdateRow(int act_id,const char *cha_ids);
	bool UpdatePassword( int act_id, const char szPassword[] );
	int FetchRowByActID(int act_id);
	int FetchRowByActName(const char szAccount[]);
	const char *GetActName(){return m_buf[0].c_str();}
	int GetActID() {return atoi(m_buf[0].c_str());} 
	char		GetGM()		 {return atoi(m_buf[1].c_str());}
	const char *GetChaIDs() {return m_buf[2].c_str();}
	const char *GetPassword() { return m_buf[3].c_str(); }
	const char *GetLast_IP() {return m_buf[4].c_str();}
	const char *GetDisc_Reason(){return m_buf[5].c_str();}
	const char *GetLast_Leave()	{return m_buf[6].c_str();}
private:
	enum{ACT_MAXCOL	=10};
	string m_buf[ACT_MAXCOL];
};
class TBLCharacters : public cfl_rs
{
public:
	TBLCharacters(cfl_db* db):cfl_rs(db,"character",CHA_MAXCOL)
	{}
	bool ZeroAddr();
	bool SetAddr(long cha_id,unsigned long long addr);
	bool InsertRow(const char *cha_name,int act_id,const char *birth,const char * map,const char *look);
	bool UpdateInfo(unsigned long cha_id,unsigned short icon,const char * motto);
	//For创建角色
	int	FetchRowByChaName(const char *cha_name);
	int			Getcha_id()			{return atoi(m_buf[0].c_str());}
	const char *GetMottonByName()	{return		 m_buf[1].c_str() ;}
	short		GetIconByName()		{return atoi(m_buf[2].c_str());}
	//For普通登录
	int	FetchRowByChaID(int cha_id);
	//Add for frnd ablum
	int FetchActNameRowByChaID( int cha_id , string & act_nam );

	const char *GetChaName()	{return		 m_buf[0].c_str(); }	//角色名
	const char *GetMotto()		{return		 m_buf[1].c_str(); }
	short		GetIcon()		{return	atoi(m_buf[2].c_str());}	//小图标
	int			GetGuildID()	{return atoi(m_buf[3].c_str());}	//所属公会ID
	const char *GetGuildName()	{return		 m_buf[4].c_str(); }	//所属公会名
	const char *GetJob()		{return		 m_buf[5].c_str(); }	//职业
	short		GetDegree()		{return atoi(m_buf[6].c_str());}	//等级
	const char *GetMap()		{return		 m_buf[7].c_str(); }	//地图名
	int			GetMap_X()		{return atoi(m_buf[8].c_str());}
	int			GetMap_Y()		{return atoi(m_buf[9].c_str());}
	const char *GetLook()		{return		 m_buf[10].c_str(); }
	int			GetStr()		{return	atoi(m_buf[11].c_str());}
	int			GetDex()		{return atoi(m_buf[12].c_str());}
	int			GetAgi()		{return atoi(m_buf[13].c_str());}
	int			GetCon()		{return	atoi(m_buf[14].c_str());}
	int			GetSta()		{return atoi(m_buf[15].c_str());}
	int			GetLuk()		{return atoi(m_buf[16].c_str());}
	bool	BackupRow(int cha_id);
	bool		IsEstop(int char_id);
	bool		Estop( const char *cha_name, uLong lTimes );
	bool		DelEstop( const char *cha_name );
	bool		StartEstopTime( int cha_id );
	bool		EndEstopTime( int cha_id );
	bool		AddMoney( int cha_id, DWORD dwMoney );
	bool		FetchAccidByChaName(const char *cha_name, int& cha_accid );

private:
	enum{CHA_MAXCOL	=24};

	string m_buf[CHA_MAXCOL];
};

// Add by lark.li 20080806 begin
class TBLPersonInfo : public cfl_rs
{
public:
	TBLPersonInfo(cfl_db* db):cfl_rs(db,"personinfo",CHA_MAXCOL)
	{}

	bool	AddInfo(int cha_id, stPersonInfo* pInfo);
	bool	GetInfo(int cha_id, stPersonInfo* pInfo);
	bool	DelInfo(int cha_id);
	bool	Query(stQueryPersonInfo* pQuery, stQueryResoultPersonInfo pResult[], int& num, int& totalpage, int& totalrecord);
private:
	enum{CHA_MAXCOL	=20};

	string m_buf[CHA_MAXCOL];
};

class TBLPersonAvatar : public cfl_rs
{
public:
	TBLPersonAvatar(cfl_db* db):cfl_rs(db,"personavatar",CHA_MAXCOL)
	{}

	bool	AddInfo(int cha_id, stPersonInfo* pInfo);
	bool	GetInfo(int cha_id, stPersonInfo* pInfo);
	bool	DelInfo(int cha_id);
private:
	enum{CHA_MAXCOL	=3};

	string m_buf[CHA_MAXCOL];
};
// End

class TBLFriends : public cfl_rs
{
public:
	TBLFriends(cfl_db* db):cfl_rs(db,"friends",FRD_MAXCOL)
	{}
	
	// Modify by lark.li 20080804 begin
	//int GetFriendsCount(long cha_id1,long cha_id2);
	int GetFriendsCount(long cha_id1,long cha_id2, const char* groupname=NULL);
	bool GroupIsExsit(long cha_id1,long cha_id2,const char * groupname);
	// End

	int GetGroupCount(long cha_id1);
	bool UpdateGroup(long cha_id1,const char *oldgroup,const char *newgroup);

	// Add by lark.li 20080804 begin
	bool DeleteGroup(long cha_id,const char *groupname);
	bool AddGroup(long cha_id,const char *groupname);
	bool MoveGroup(long cha_id1,long cha_id2,const char *oldgroup,const char *newgroup);
	// End

	unsigned long long GetFriendAddr(long cha_id1,long cha_id2);
	bool AddFriend(long cha_id1,long cha_id2);
	bool DelFriend(long cha_id1,long cha_id2);
private:
	enum{FRD_MAXCOL	=3};

	string m_buf[FRD_MAXCOL];
};

class TBLMaster : public cfl_rs
{
public:
	struct master_dat
	{
		unsigned long long memaddr; // VA in GameServer
		unsigned int cha_id; // id of character
		string relation; // relationship
		string cha_name; // name of character
		unsigned int icon_id;
		string motto;
	};

	TBLMaster(cfl_db* db):cfl_rs(db,"master",MASTER_MAXCOL)
	{}
	int GetMasterCount(long cha_id);
	int GetPrenticeCount(long cha_id);
	int HasMaster(long cha_id1,long cha_id2);

	bool AddMaster(long cha_id1,long cha_id2);
	bool DelMaster(long cha_id1,long cha_id2);
	bool GetMasterData(master_dat* farray, int& array_num, unsigned int cha_id);
	bool GetPrenticeData(master_dat* farray, int& array_num, unsigned int cha_id);
	bool FinishMaster(long cha_id);
	bool InitMasterRelation(map<uLong, uLong> &mapMasterRelation);

private:
	enum{MASTER_MAXCOL	=6};

	string m_buf[MASTER_MAXCOL];
};

class TBLGuilds : public cfl_rs
{
public:
	TBLGuilds(cfl_db* db):cfl_rs(db,"guild",GLD_MAXCOL)
	{}
	bool IsReady();
	int FetchRowByName(const char *guild_name);
	int  Getguild_id(){return atoi(m_buf[0].c_str());}
	bool InitAllGuilds(char disband_days);
	bool InitGuildMember(Player *ply,uLong chaid,uLong gldid,int mode);
	bool Disband(uLong gldid);
	bool GetGuildMemberNum( uLong gldid, InterLockedLong& memberNum );//Add by sunny.sun 20090611
private:
	bool SendGuildInfo(Player *ply);
	enum{GLD_MAXCOL	=50};

	string m_buf[GLD_MAXCOL];
};

#ifdef SHUI_JING
//Add by sunny.sun 20090603
class TBLCrystalTrade : public cfl_rs
{
public:
	TBLCrystalTrade( cfl_db* db ):cfl_rs(db,"crystaltrade",CRYSTAL_MAXCOL)
	{}
	bool IsHasBuyorSale( long cha_id, int type );
private:
	enum
	{CRYSTAL_MAXCOL = 3};

	string m_buf[CRYSTAL_MAXCOL];
};
#endif
//end
struct ORDERINFO
{
	long nid;
	long nfightpoint;
	char strname[20];
	long nlev;
	char strjob[100];
	ORDERINFO():nid(-1),nfightpoint(0),nlev(-1)
	{};
};


class TBLParam : public cfl_rs
{
private:
	enum{PARAM_MAXCOL=7};
	ORDERINFO m_nOrder[MAXORDERNUM];

public:
	TBLParam(cfl_db* db):cfl_rs(db,"Param",PARAM_MAXCOL)
	{};

	bool InitParam(void);

	bool SaveParam(void);
	ORDERINFO * GetOrderData(int index){return &(m_nOrder[index]);};
	void UpdateOrder(ORDERINFO &Order);
	bool IsReady();
protected:
	string m_buf[PARAM_MAXCOL];
};
///

#endif
