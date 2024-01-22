//=============================================================================
// FileName: Character.h
// Creater: ZhangXuedong
// Date: 2004.10.19
// Comment: CCharacter class
//=============================================================================

#ifndef CHARACTER_H
#define CHARACTER_H

#include "MoveAble.h"
#include "GameCommon.h"
#include "Mission.h"
#include "Timer.h"
#include "Kitbag.h"
#include "ShipSet.h"
#include "Action.h"
#include "StringPoolL.h"

#define ALL_HAS_KITBAG

#define defMAX_ITEM_NUM			10
#define defCHA_SCRIPT_TIMER		1 * 1000
#define defDEFAULT_PING_VAL		500
#define defPING_RECORD_NUM		6
#define defPING_INTERVAL		20 * 1000
#define defCHA_SCRIPT_PARAM_NUM	1
#define MAX_TRADE_MONEY			2000000000
#define def_TAXBASE				10000
#define def_BASENUM				400

extern CCharacter*		g_pCSystemCha;		// 系统角色

struct SLean // 倚靠
{
	dbc::uLong	ulPacketID; // 数据包的ID
	dbc::Char	chState;	// 0，倚靠中.1，停止依靠
	dbc::Long	lPose;
	dbc::Long	lAngle;
	dbc::Long	lPosX, lPosY;
	dbc::Long	lHeight;
};

struct SSeat
{
	dbc::Char	chIsSeat;
	dbc::Short	sAngle;
	dbc::Short	sPose;
};

struct STempChaPart
{
	short	sPartID;
	short	sItemID;
};

struct SCheatX
{
	uInt Xtype;			//1:答题完成后 2:提问后
	uInt Xerror;		//错误次数
	uInt Xright;		//连续答对的次数
	uInt Xcount;		//答题的次数
	uInt Xn;
	DWORD dwLastTime;	//上一次的时间
	DWORD dwInterval;	//时间间隔
	string Xnum;		//X number
};

enum EActControl
{
	enumACTCONTROL_MOVE,		// 移动位
	enumACTCONTROL_USE_GSKILL,	// 使用普通技能位
	enumACTCONTROL_USE_MSKILL,	// 使用魔法技能位
	enumACTCONTROL_BEUSE_SKILL,	// 被使用技能位
	enumACTCONTROL_TRADE,		// 交易位
	enumACTCONTROL_USE_ITEM,	// 使用物品位
	enumACTCONTROL_BEUSE_ITEM,	// 被使用物品位
	enumACTCONTROL_INVINCIBLE,	// 无敌位
	enumACTCONTROL_EYESHOT,		// 视野位（可以看到视野内可见的实体）
	enumACTCONTROL_NOHIDE,		// 不隐形（可以被看见）
	enumACTCONTROL_NOSHOW,		// 不被强制现形（如果有强制现形，则隐形被屏蔽）
	enumACTCONTROL_ITEM_OPT,	// 道具操作位
	enumACTCONTROL_TALKTO_NPC,	// 和NPC对话位
	enumACTCONTROL_MAX,
};

enum ESwitchMapType
{
	enumSWITCHMAP_CARRY,	// 传送
	enumSWITCHMAP_DIE,		// 死亡
};

enum ELogAssetsType	// 此枚举值对应数组下标
{
	enumLASSETS_INIT,		// 初始化
	enumLASSETS_TRADE,		// 交易
	enumLASSETS_BANK,		// 银行
	enumLASSETS_PICKUP,		// 拾取
	enumLASSETS_THROW,		// 丢弃
	enumLASSETS_DELETE,		// 删除
};

namespace mission
{
	class CStallData;
	class CTradeData;
	class CTalkNpc;
}

#define LOOK_SELF   0
#define LOOK_OTHER  1
#define LOOK_TEAM   2

class CHateMgr;
class CAction;
class CActionCache;

class CCharacter : public CMoveAble
{
	friend class CChaSpawn;
	friend class CTableCha;
	friend class Guild;
	friend class CTableGuild;
	friend class CTableMaster;
public:
	CCharacter();
	~CCharacter();

	void	Initially();
	void	Finally();

	bool	IsPlayerCha(void); // 是否玩家角色
	bool	IsGMCha(); // GM等级在0-10的GM角色
	bool	IsGMCha2(); // GM角色
	bool	IsPlayerCtrlCha(void); // 玩家当前控制的角色
	bool	IsPlayerMainCha(void); // 玩家的人角色
	bool	IsPlayerFocusCha(void); // 玩家当前控制的角色， 同IsPlayerCtrlCha例程
	bool	IsPlayerOwnCha(void); // 玩家角色，且其控制类型是玩家
	CCharacter	*GetPlyCtrlCha(void);
	CCharacter	*GetPlyMainCha(void);

	void	WritePK(WPACKET& wpk);			//写入玩家本身及其所有附加结构(如召唤兽等)的所有数据
	void	WriteCharPartInfo(WPACKET& packet);
	void	ReadPK(RPACKET& rpk);			//重构玩家本身及其所有附加结构(如召唤兽等)
	void	SwitchMap(SubMap *pCSrcMap, cChar *szTarMapName, Long lTarX, Long lTarY, bool bNeedOutSrcMap = true, Char chSwitchType = enumSWITCHMAP_CARRY, Long lTMapCpyNO = -1);

	virtual void	ProcessPacket(uShort usCmd, RPACKET pk);
	virtual void	Run(uLong ulCurTick);
	virtual	void	RunEnd( DWORD dwCurTime );
	virtual void	OnScriptTimer(DWORD dwExecTime, bool bNotice = false);
	virtual void	StartExit();
	virtual void	CancelExit();
	virtual void	Exit();

	void	CheatRun(DWORD dwCurTime);
	void	CheatCheck(cChar *answer);
	void	CheatConfirm();
	void	InitCheatX();
	DWORD	GetCheatInterval(int state);
#ifdef XTRAP_S
	//Add by sunny.sun 20090728
	void	Session();
	void	MapFileChange();
#endif

	// 指令函数
	bool		Cmd_EnterMap(dbc::cChar* l_map, dbc::Long lMapCopyNO, dbc::uLong l_x, dbc::uLong l_y, dbc::Char chLogin = 1);
	void		Cmd_BeginMove(dbc::Short sPing, Point *pPath, dbc::Char chPointNum, dbc::Char chStopState = enumEXISTS_WAITING);
	void		Cmd_BeginMoveDirect(Entity *pTar);
	void		Cmd_BeginSkill(dbc::Short sPing, Point *pPath, dbc::Char chPointNum,
				CSkillRecord *pSkill, dbc::Long lSkillLv, dbc::Long lTarInfo1, dbc::Long lTarInfo2, dbc::Char chStopState = enumEXISTS_WAITING);
	void		Cmd_BeginSkillDirect(dbc::Long lSkillNo, Entity *pTar, bool bIntelligent = true);
	void		Cmd_BeginSkillDirect2(dbc::Long lSkillNo, dbc::Long lSkillLv, dbc::Long lPosX, dbc::Long lPosY);
	dbc::Short	Cmd_UseItem(dbc::Short sSrcKbGrid, dbc::Short sTarKbGrid);
	dbc::Short	Cmd_UseEquipItem(dbc::Short sKbGrid, bool bRefresh = true);
	dbc::Short	Cmd_UseExpendItem(dbc::Short sSrcKbGrid, dbc::Short sTarKbGrid, bool bRefresh = true);
	dbc::Short	Cmd_UnfixItem(dbc::Char chLinkID, dbc::Short *psItemNum, dbc::Char chDir, dbc::Long lParam1, dbc::Long lParam2, bool bPriority = true, bool bRefresh = true, bool bForcible = false);
	dbc::Short	Cmd_PickupItem(dbc::uLong ulID, dbc::Long lHandle);
	dbc::Short	Cmd_ThrowItem(dbc::Short sKbGrid, dbc::Short *psThrowNum, dbc::Long lPosX, dbc::Long lPosY, bool bRefresh = true, bool bForcible = false);
	dbc::Short	Cmd_ItemSwitchPos(dbc::Short sKbPage, dbc::Short sSrcGrid, dbc::Short sSrcNum, dbc::Short sTarGrid);
	dbc::Short	Cmd_DelItem(dbc::Short sKbGrid, dbc::Short *psThrowNum, bool bRefresh = true, bool bForcible = false);
	dbc::Short	Cmd_BankOper(dbc::Char chSrcType, dbc::Short sSrcGridID, dbc::Short sSrcNum, dbc::Char chTarType, dbc::Short sTarGridID);

    //拖放临时背包的道具(sSrcGrid:临时背包的位置   sSrcNum:数量   sTarGrid:道具栏位置)
    dbc::Short  Cmd_DragItem(dbc::Short sSrcGrid, dbc::Short sSrcNum, dbc::Short sTarGrid);
    
	void		Cmd_SetInPK(bool bInPK = true) {if (m_chPKCtrl & 0x02) return; if (bInPK) m_chPKCtrl |= 0x01; else m_chPKCtrl &= 0xfe;}
	void		Cmd_SetInGymkhana(bool bInGymkhana = true) {if (bInGymkhana) m_chPKCtrl |= 0x02; else m_chPKCtrl &= 0xfd;}
	void		Cmd_ReassignAttr(RPACKET &pk);
	dbc::Short	Cmd_RemoveItem(dbc::Long lItemID, dbc::Long lItemNum, dbc::Char chFromType, dbc::Short sFromID, dbc::Char chToType, dbc::Short sToID, bool bRefresh = true, bool bForcible = true);

	void		Cmd_ChangeHair(RPACKET &pk);											// 处理更换发型
	void		Prl_ChangeHairResult(int nScriptID, const char* szReason, BOOL bNoticeAll = FALSE); // 更换发型的消息反馈
	void		Prl_OpenHair();															// 通知客户端打开理发界面	

	void		Cmd_FightAsk(dbc::Char chType, dbc::Long lTarID, dbc::Long lTarHandle);
	void		Cmd_FightAnswer(bool bFight);
	void		Cmd_ItemRepairAsk(dbc::Char chPosType, dbc::Char chPosID);
	void		Cmd_ItemRepairAnswer(bool bRepair);
	void		Cmd_ItemForgeAsk(dbc::Char chType, SForgeItem *pSItem);
	void		Cmd_ItemForgeAnswer(bool bForge);

#ifdef NEW_MAPCOPY
	BOOL		Cmd_TeamFightMapCopy( int m_nMapID, short m_nMemberNum, int &m_nMapCopyID );//Add by sunny.sun 20090812
	void		g_SetTeamFightMapName(const char *cszMapName);
#endif

	void		Cmd_SelectTimeExperience_Ask( char cIsGet,short sSeltime, short sGridPos, short sNum);//Add by sunny.sun 20090316
	void		Cmd_SelectCoinAsk( short sBottonNo, short sNum);
	void		Cmd_SelectJewelryupAsk( short sIsGet, short sItemPos, short sSelNO );//Add by sunny.sun 20090402

#ifdef SHUI_JING
	//水晶兑换平台
	DWORD		GetFlatMoney(){ return m_lFlatMoney;}
	void		SetFlatMoney(long lFlatMoney){ m_lFlatMoney = lFlatMoney; }

	void		Cmd_CrystalBuyAndSaleList();
	void		Cmd_CrystalBuyAsk( DWORD iCslPrice, DWORD iCslNum, char quicktype );
	void		Cmd_CrystalSaleAsk( DWORD iCslPrice, DWORD iCslNum, char quicktype );
	void		Cmd_CrystalCancelAsk( int type );
	void		Cmd_GetCrystalFlatMoneyTOGD( DWORD takemoney );
	BOOL		Cmd_ChangeFlatAfterTrade( DWORD iCslNum, DWORD dcslnum, int type, char* act_name, DWORD cha_id );		
	void		Cmd_CancelPlayerSaleTrade( BOOL result );
	void		Cmd_CheckHasAccordForTrade( DWORD iCslNum, DWORD iCslPrice, int type, char quicktype );
	void		Cmd_TradeInfoAsr( int type, BOOL result, DWORD tradeNum,DWORD iCslPrice );
	BOOL		Cmd_ChangeFlatForTradeFailed( DWORD iCslNum, DWORD dcslnum, int type, char* act_name, DWORD cha_id );
	void		Cmd_ResetHangTrade( int type );
#endif

	// Add by lark.li 20080707 begin
	void		Cmd_CaptainConfirmAsk(int teamID);
	void		Cmd_CaptainConfirmAnswer(short ret, DWORD dwTeamID);
	// End
	
	//反斗白银
	void		Cmd_Garner2_Reorder(short index);

	//生活技能
	void		Cmd_LifeSkillItemAsk(long dwType, SLifeSkillItem *pSItem);
	void		Cmd_LifeSkillItemAsR(long dwType,SLifeSkillItem *pSItem);
    //背包锁定
    void        Cmd_LockKitbag();
    void        Cmd_UnlockKitbag(const char szPassword[]);
    void        Cmd_CheckKitbagState();
    void        Cmd_SetKitbagAutoLock(Char cAuto);

	//老手带新手
	BOOL		Cmd_AddVolunteer();
	BOOL		Cmd_DelVolunteer();
	void		Cmd_ListVolunteer(short sPage, short sNum);
	BOOL		Cmd_ApplyVolunteer(const char *szName);
	CCharacter	*FindVolunteer(const char *szName);
	
	virtual void	ReflectINFof(Entity *srcent, WPACKET chginf);
	virtual CCharacter *IsCharacter(){return this;}

	void	TradeClear( CPlayer& player );
	bool	TradeAction(bool bLock = true) {return SetNarmalSkillState(bLock, SSTATE_TRADE, 1);}
	bool	StallAction(bool bLock = true);
	bool	HairAction(bool bLock = true) {return SetNarmalSkillState(bLock, SSTATE_HAIR, 1);}
	bool	RepairAction(bool bLock = true) {return SetNarmalSkillState(bLock, SSTATE_FORGE, 1);}
	bool	ForgeAction(bool bLock = true) {return SetNarmalSkillState(bLock, SSTATE_FORGE, 1);}

	void	BickerNotice( const char szData[], ... );
	void	SystemNotice( const char szData[], ... );
	void	PopupNotice( const char szData[], ... );

	// 设置交易信息
	void	SetTradeData( mission::CTradeData* pData ) { m_pTradeData = pData; }
	mission::CTradeData* GetTradeData() { return m_pTradeData; }
	
	// 船只
	void	SetBoat( CCharacter* pBoat );
	CCharacter* GetBoat();
	bool	IsBoat(void) 
	{
		if(m_pCChaRecord == NULL)
			return false;

		return m_pCChaRecord->chModalType == enumMODAL_BOAT;
	}
	
	// 与npc交易
	BOOL	SafeSale( BYTE byIndex, BYTE byCount, WORD& wItemID, DWORD& dwMoney );
	BOOL	SafeBuy( WORD wItemID, BYTE byCount, BYTE byIndex, DWORD& dwMoney );
	BOOL	SafeSaleGoods( DWORD dwBoatID, BYTE byIndex, BYTE byCount, WORD& wItemID, DWORD& dwMoney );
	BOOL	SafeBuyGoods( DWORD dwBoatID, WORD wItemID, BYTE byCount, BYTE byIndex, DWORD& dwMoney );
	BOOL	GetSaleGoodsItem( DWORD dwBoatID, BYTE byIndex, WORD& wItemID );

	BOOL	ExchangeReq(short sSrcID, short sSrcNum, short sTarID, short sTarNum);

	bool	SetNarmalSkillState(bool bAdd = true, dbc::uChar uchStateID = 1, dbc::uChar uchStateLv = 1);
	bool	HasTradeAction(void) {return m_CSkillState.HasState(85);}
	//
	BOOL	SetMissionPage( DWORD dwNpcID, BYTE byPrev, BYTE byNext, BYTE byState );
	BOOL	GetMissionPage( DWORD dwNpcID, BYTE& byPrev, BYTE& byNext, BYTE& byState );
	BOOL	SetTempData( DWORD dwNpcID, WORD wID, BYTE byState, BYTE byType );
	BOOL	GetTempData( DWORD dwNpcID, WORD& wID, BYTE& byState, BYTE& byType );

	// 任务系统接口函数
	BOOL	SaveMissionData();	// 角色任务信息存盘

	BOOL	AddMissionState( DWORD dwNpcID, BYTE byID, BYTE byState );
	BOOL	ResetMissionState( mission::CTalkNpc& npc );
	
	BOOL	GetMissionState( DWORD dwNpcID, BYTE& byState );
	BOOL	GetNumMission( DWORD dwNpcID, BYTE& byNum );
	BOOL	GetMissionInfo( DWORD dwNpcID, BYTE byIndex, BYTE& byID, BYTE& byState );
	BOOL	GetCharMission( DWORD dwNpcID, BYTE byID, BYTE& byState );
	BOOL	GetNextMission( DWORD dwNpcID, BYTE& byIndex, BYTE& byID, BYTE& byState );
	BOOL	ClearMissionState( DWORD dwNpcID );
	
	BOOL	AddTrigger( const mission::TRIGGER_DATA& Data );
	BOOL	ClearTrigger( WORD wTriggerID );
	BOOL	DeleteTrigger( WORD wTriggerID );
	BOOL	GetMisScriptID( WORD wID, WORD& wScriptID );
	BOOL	AddRole( WORD wID, WORD wParam );
	BOOL	HasRole( WORD wID );
	BOOL	ClearRole( WORD wID );
	BOOL	IsRoleFull();
	BOOL	SetFlag( WORD wID, WORD wFlag );
	BOOL	ClearFlag( WORD wID, WORD wFlag );
	BOOL	IsFlag( WORD wID, WORD wFlag );
	BOOL	IsValidFlag( WORD wFlag );
	BOOL	SetRecord( WORD wRec );
	BOOL	ClearRecord( WORD wRec );
	BOOL	IsRecord( WORD wRec );
	BOOL	IsValidRecord( WORD wRec );

	// 随机任务接口操作信息
	BOOL	HasRandMission( WORD wRoleID );
	BOOL	AddRandMission( WORD wRoleID, WORD wScriptID, BYTE byType, BYTE byLevel, DWORD dwExp, DWORD dwMoney, USHORT sPrizeData, USHORT sPrizeType, BYTE byNumData );
	BOOL	SetRandMissionData( WORD wRoleID, BYTE byIndex, const mission::MISSION_DATA& RandData );
	BOOL	GetRandMission( WORD wRoleID, BYTE& byType, BYTE& byLevel, DWORD& dwExp, DWORD& dwMoney, USHORT& sPrizeData, USHORT& sPrizeType, BYTE& byNumData );
	BOOL	GetRandMissionData( WORD wRoleID, BYTE byIndex, mission::MISSION_DATA& RandData );

	// 检测送给npc的物品(接受物品的NPC取走物品后，记录一个标记，是否取走用该标记标识)
	BOOL	HasSendNpcItemFlag( WORD wRoleID, WORD wNpcID );
	BOOL	NoSendNpcItemFlag( WORD wRoleID, WORD wNpcID );
	BOOL	HasRandMissionNpc( WORD wRoleID, WORD wNpcID, WORD wAreaID );

	// 取走随机任务物品
	BOOL	TakeRandNpcItem( WORD wRoleID, WORD wNpcID, const char szNpc[] );
	BOOL	TakeAllRandItem( WORD wRoleID );

	// 是否任务需要的物品
	BOOL	IsMisNeedItem( USHORT sItemID );
	BOOL	GetMisNeedItemCount( WORD wRoleID, USHORT sItemID, USHORT& sCount );
	void	RefreshNeedItem( USHORT sItemID );

	// 任务日志
	void	MisLog();
	void	MisLogInfo( WORD wMisID );
	void	MisLogClear( WORD wMisID );

	// 设置任务已经处于完成状态
	BOOL	SetMissionPending(WORD wRoleID);
	BOOL	SetMissionComplete( WORD wRoleID );
	BOOL	SetMissionFailure( WORD wRoleID );
	BOOL	HasMissionFailure( WORD wRoleID );

	// 随机任务完成计数接口
	BOOL	CompleteRandMission( WORD wRoleID );
	BOOL	FailureRandMission( WORD wRoleID );
	BOOL	AddRandMissionNum( WORD wRoleID );
	BOOL	ResetRandMission( WORD wRoleID );
	BOOL	ResetRandMissionNum( WORD wRoleID );
	BOOL	HasRandMissionCount( WORD wRoleID, WORD wCount );
	BOOL	GetRandMissionCount( WORD wRoleID, WORD& wCount );
	BOOL	GetRandMissionNum( WORD wRoleID, WORD& wNum );

	// 召唤一个被护送NPC
	BOOL	ConvoyNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID, BYTE byAiType );
	BOOL	ClearConvoyNpc( WORD wRoleID, BYTE byIndex );
	BOOL	ClearAllConvoyNpc( WORD wRoleID );
	BOOL	HasConvoyNpc( WORD wRoleID, BYTE byIndex );
	BOOL	IsConvoyNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID );

	// 角色金钱和物品操作函数
	void	AddMoney( const char szName[], DWORD dwMoney, const char* szData="" );
	BOOL	TakeMoney( const char szName[], DWORD dwMoney, const char* szNotice="" );
	BOOL	HasMoney( DWORD dwMoney );
	BOOL	AddItem( USHORT sItemID, USHORT sCount, const char szName[], BYTE byAddType = enumITEM_INST_TASK, BYTE bySoundType = enumSYN_KITBAG_FROM_NPC );
	BOOL	TakeItem( USHORT sItemID, USHORT sCount, const char szName[] );
	BOOL	GiveItem( USHORT sItemID, USHORT sCount, BYTE byAddType, BYTE bySoundType );
	BOOL	MakeItem( USHORT sItemID, USHORT sCount, USHORT& sItemPos, BYTE byAddType = enumITEM_INST_TASK, BYTE bySoundType = enumSYN_KITBAG_FROM_NPC );
	BOOL	HasItem( USHORT sItemID, USHORT sCount );
	BOOL	GetNumItem( USHORT sItemID, USHORT& sCount );
	BOOL	HasLeaveBagGrid( USHORT sNum );
	BOOL	HasLeaveBagTempGrid( USHORT sNum );
	BOOL	HasItemBagTemp(USHORT sItemID, USHORT sCount);
	BOOL	TakeItemBagTemp(USHORT sItemID, USHORT sCount, const char szName[]);
	BOOL	UpdateChaDisTime( int iSelTime );//Add by sunny.sun 20090316


	//添加物品到临时背包
	BOOL	AddItem2KitbagTemp( USHORT sItemID, USHORT sCount, ItemInfo *pItemAttr, BYTE bySoundType = enumSYN_KITBAG_FROM_NPC );
	BOOL	AddItem2KitbagTemp( USHORT sItemID, USHORT sCount, const char szName[], BYTE byAddType = enumITEM_INST_TASK, BYTE bySoundType = enumSYN_KITBAG_FROM_NPC );
	BOOL	GiveItem2KitbagTemp( USHORT sItemID, USHORT sCount, ItemInfo *pItemAttr, BYTE bySoundType );
	BOOL	GiveItem2KitbagTemp( USHORT sItemID, USHORT sCount, BYTE byAddType, BYTE bySoundType );

	// 重设角色职业属性
	BOOL	SetProfession( BYTE byPf );

	bool	LearnSkill(dbc::Short sSkillID, dbc::Char chLv, bool bSetLv = true, bool bUsePoint = true, bool bLimit = true); // 学习技能（通告）
	bool	AddSkillState(dbc::uChar uchFightID, dbc::uLong ulSrcWorldID, dbc::Long lSrcHandle, dbc::Char chObjType, dbc::Char chObjHabitat, dbc::Char chEffType,
			dbc::uChar uchStateID, dbc::uChar uchStateLv, dbc::Long lOnTick, dbc::Char chType = enumSSTATE_ADD_UNDEFINED, bool bNotice = true); // 增加技能状态
#ifdef COMPACT_MEM_2
	virtual bool	DelSkillState(map<unsigned char, SSkillStateUnit>::iterator& pUnit, bool bNotice = true);
#endif

	bool	DelSkillState(dbc::uChar uchStateID, bool bNotice = true); // 删除状态

	// 行为控制
	bool	GetActControl(dbc::Char chCtrlType) {return m_ActContrl[chCtrlType];}
	void	Hide();
	void	Show();

	// 恢复角色属性
	void	RestoreHp( BYTE byHpRate );
	void	RestoreSp( BYTE bySpRate );
	void	RestoreAllHp();
	void	RestoreAllSp();
	void	RestoreAll();

	BOOL	ViewItemInfo( RPACKET& pk );

	BOOL	AddAttr( int nIndex, DWORD dwValue, dbc::Short sNotiType = enumATTRSYN_TASK ); // 若要增加ATTR_CEXP属性，请使用CFightAble::AddExp
	BOOL	TakeAttr( int nIndex, DWORD dwValue, dbc::Short sNotiType = enumATTRSYN_TASK );

	bool	IsInPK(void) {return m_chPKCtrl & 0x01 ? true : false;}
	bool	IsInGymkhana(void) {return m_chPKCtrl & 0x02 ? true : false;}
	void	SetPKCtrl(dbc::Char chCtrl) {m_chPKCtrl = chCtrl;}
	dbc::Char	GetPKCtrl(void) {return m_chPKCtrl;}
	bool	CanPK(void) {return IsInPK() || IsInGymkhana();}
	bool	IsInArea(dbc::Short sAreaMask) {return GetAreaAttr() & sAreaMask ? true : false;}
	void	SetRelive(Char chType = enumEPLAYER_RELIVE_ORIGIN, Char chLv = 0, cChar *szInfo = 0);
	void	Reset(void);

	virtual void BreakAction(RPACKET pk = NULL);
	virtual void EndAction(RPACKET pk = NULL);
	// 角色事件处理函数
	virtual void AfterObjDie(CCharacter *pCAtk, CCharacter *pCDead);
	virtual void AfterPeekItem(dbc::Short sItemID, dbc::Short sNum);
	virtual void AfterEquipItem(dbc::Short sItemID, dbc::uShort sTriID);
	virtual void EntryMapUnit( BYTE byMapID, WORD wxPos, WORD wyPos );
	virtual void OnMissionTime(); // 任务时间触发器事件
	virtual void OnLevelUp( USHORT sLevel );
	virtual void OnSailLvUp( USHORT sLevel );
	virtual void OnLifeLvUp( USHORT sLevel );
	virtual void OnCharBorn();

	// 船只处理接口函数
	BOOL	IsNeedRepair();
	BOOL	IsNeedSupply();
	void	RepairBoat();
	void	SupplyBoat();
	void	BoatDie( CCharacter& Attacker, CCharacter& Boat );
	BOOL	OnBoatDie( CCharacter& Attacker );
	BOOL	GetBoatID( BYTE byIndex, DWORD& dwBoatID );
	BOOL	BoatCreate( const BOAT_DATA& Data );
	BOOL	BoatUpdate( BYTE byIndex, const BOAT_DATA& Data );
	BOOL	BoatLoad( const BOAT_LOAD_INFO& Info );
	
	// 船只货物贸易
	BOOL	AdjustTradeItemCess( USHORT sLowCess, USHORT sData );
	BOOL	GetTradeItemData( BYTE& byLevel, USHORT& sCess );
	BOOL	SetTradeItemLevel( BYTE byLevel );	
	BOOL	HasTradeItemLevel( BYTE byLevel );
	BOOL	GetTradeItemLevel( BYTE& byLevel );
	BOOL	BoatTrade( USHORT sBerthID );	

	BOOL	BoatBerth( USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir );	
	BOOL	BoatLaunch( BYTE byIndex, USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir );
	BOOL	BoatBerthList( DWORD dwNpcID, BYTE byType, USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir );
	BOOL	BoatSelLuanch( BYTE byIndex );
	BOOL	BoatSelected( BYTE byType, BYTE byIndex );
	BOOL	HasAllBoatInBerth( USHORT sBerthID );
	BOOL	HasBoatInBerth( USHORT sBerthID );
	BOOL	HasDeadBoatInBerth( USHORT sBerthID );
	void	SetBoatLook( const stNetChangeChaPart& Info ) { memcpy( &m_SChaPart, &Info, sizeof(stNetChangeChaPart) ); }
	BOOL	BoatPackBagList( USHORT sBerthID, BYTE byType, BYTE byLevel );
	BOOL	BoatPackBag( BYTE byIndex );
	BOOL	PackBag( CCharacter& boat, BYTE byType, BYTE byLevel );
	BOOL	PackBag( CCharacter& Boat, USHORT sItemID, USHORT sCount, USHORT sPileID, USHORT& sNumPack );
	void	SetBoatAttrChangeFlag(bool bSet = true);
	void	SyncBoatAttr( dbc::Short sSynType, bool bAllBoat = true ); // 同步建造的船只属性

	// 船只添加删除
	BOOL	BoatAdd( CCharacter& Boat );
	BOOL	BoatClear( CCharacter& Boat );
	BOOL	BoatAdd( DWORD dwDBID );
	BOOL	BoatClear( DWORD dwDBID );

	// 事件实体交互时间记录
	BOOL	SetEntityState( DWORD dwEntityID, BYTE byState );
	void	SetEntityTime( DWORD dwTime );
	DWORD	GetEntityTime();

	// 公会判定函数
	BOOL	HasGuild();
	BOOL	IsGuildType( BYTE byType );

	// 摆摊
	void	SetStallData( mission::CStallData* pData );
	mission::CStallData* GetStallData();
	BYTE	GetStallNum();

	//add by jilinlee 2007/4/20
	//读书
	BOOL IsReadBook();
	void SetReadBookState(bool bIsReadBook = false);


	// 
	void	ChangeItem(bool bEquip, SItemGrid *pItemCont, dbc::Char chLinkID); // 计算由装备变化带来的角色属性的变化
	void	SkillRefresh(); // 道具激活技能
	// 新建角色初始化
	void	NewChaInit(void);
	// 新建角色的装备初始化
	void	ChaInitEquip(void);
	void	ResetBirthInfo(void);

	// 同步角色数据
	void	SynKitbagNew(dbc::Char chType); // 同步道具栏
	void    SynKitbagTmpNew(dbc::Char chType); // 同步临时背包
	void	SynShortcut(); // 同步快捷栏
	void	SynLook(dbc::Char chSynType = enumSYN_LOOK_SWITCH); // 同步角色外观
	bool	ItemForge(SItemGrid *pItem, dbc::Char chAddLv = 1); // 精炼道具并同步
	void	SynSkillBag(dbc::Char chType); // 同步技能栏
	void	SynPKCtrl(void); // 同步PK状态
	void	SynAddItemCha(CCharacter *pCItemCha);
	void	SynDelItemCha(CCharacter *pCItemCha);
	void	CheckPing(void);
	void	SendPreMoveTime(void);
	void	SynSideInfo(void);
	void	SynBeginItemRepair(void);
	void	SynBeginItemForge(void);

	void	SynBeginGetDisTime(void);//Add by sunny.sun 20090310
	void	SynBeginItemJewelryUp(void);//Add by sunny.sun 20090401
	void	SynGetCrystalState(void);//Add by sunny.sun 20090519
	void	SynBeginItemUnite(void);
	void	SynBeginItemMilling(void);
	void	SynBeginItemFusion();
	void    SynBeginItemUpgrade();
	void    SynBeginItemEidolonMetempsychosis();
	void	SynBeginItemEidolonFusion();
	void	SynBeginItemPurify();
	void	SynBeginItemFix();
	void	SynBeginItemEnergy();
	void	SynBeginGetStone();
	void	SynBeginTiger();
	void	SynAppendLook(void);
	void	SynItemUseSuc(dbc::Short sItemID);
	void	SynKitbagCapacity(void);
	void	SynEspeItem(void);
	void	SynVolunteerState(BOOL bState);
	void	SynTigerString(cChar *szString);
	void	SynBeginGMSend();
	void	SynBeginGMRecv(DWORD dwNpcID);

	//

	// 角色数据报组织
	void	WriteBaseInfo(WPACKET &pk);
	void	WritePKCtrl(WPACKET &pk);
	void	WriteSkillbag(WPACKET &pk, int nSynType);
	void	WriteKitbag(CKitbag *pCKb, WPACKET &pk, int nSynType);
	void	WriteLookData(WPACKET &pk, dbc::Char chLookType = LOOK_SELF, dbc::Char chSynType = enumSYN_LOOK_SWITCH);
	bool	WriteAppendLook(CKitbag *pCKb, WPACKET &pk, bool bInit = false);
	void	WriteShortcut(WPACKET &pk);
	void	WriteBoat(WPACKET &pk);
	void	WriteItemChaBoat(WPACKET &pk, CCharacter *pCBoat);
	void	WriteSideInfo(WPACKET &pk);
	//

	// 请求的行动失败
	void	FailedActionNoti(dbc::Char chType, dbc::Char chReason);
	// 终端显示信息
	void	TerminalMessage(dbc::Long lMessageID);
	// 道具操作失败
	void	ItemOprateFailed(dbc::Short sFailedID);

	void		SetMotto(dbc::cChar *szMotto) {if (szMotto) /*strncpy(m_szMotto, szMotto, defMOTTO_LEN - 1)*/strncpy_s( m_szMotto, sizeof(m_szMotto), szMotto, _TRUNCATE );}
	dbc::cChar*	GetMotto(void) {return m_szMotto;}
	void		SetIcon(dbc::uShort usIcon) {m_usIcon = usIcon;}
	dbc::uShort	GetIcon(void) {return m_usIcon;}
	void		SetGuildName(dbc::cChar *szGuildName);
	dbc::cChar*	GetGuildName(void);
	dbc::cChar*	GetValidGuildName(void);
	void		SetGuildMotto(dbc::cChar *szGuildMotto);
	dbc::cChar*	GetGuildMotto(void);
	dbc::cChar*	GetValidGuildMotto(void) ;
	void		SetGuildID( DWORD dwGuildID );
	DWORD		GetGuildID();
	DWORD		GetValidGuildID();
	void		SetGuildType( BYTE byType );
	BYTE		GetGuildType();
	void		SetGuildState( uLong lState );
	uLong		GetGuildState();
	void		SetEnterGymkhana(bool bEnter = true);
	void		SyncGuildInfo();
	void		SetStallName(dbc::cChar *szStallName);
	dbc::cChar*	GetStallName(void);
	void		SynStallName(void);

	void			AddBlockCnt()						{   _btBlockCnt++;					}
	BYTE			GetBlockCnt()						{   return _btBlockCnt;				}
	void			SetBlockCnt(BYTE cnt)				{   _btBlockCnt = cnt;				}

	virtual void	AfterAttrChange(int nIdx, LONG64 lOldVal, LONG64 lNewVal);
	virtual void	Die();	// 处理重生
	void			JustDie(CCharacter *pCSrcCha);	// 处理爆料，经验分配等
	void			MoveCity(dbc::cChar *szCityName, Long lMapCpyNO = -1, Char chSwitchType = enumSWITCHMAP_CARRY);
	void			BackToCity(bool Die = false, cChar *szCityName = 0, Long lMapCpyNO = -1, Char chSwitchType = enumSWITCHMAP_DIE);
	void			BackToCityEx(bool Die = false, cChar *szCityName = 0, Long lMapCpyNO = -1, Char chSwitchType = enumSWITCHMAP_DIE);
	void			SetToMainCha(bool bBoatDie = false);
	bool			CanSeen(CCharacter *pCCha);
	bool			CanSeen(CCharacter *pCCha, bool bThisEyeshot, bool bThisNoHide, bool bThisNoShow);
	bool			IsHide() {return !GetActControl(enumACTCONTROL_NOHIDE) && GetActControl(enumACTCONTROL_NOSHOW);}
	SItemGrid*		GetEquipItem(dbc::Char chPart) {if (chPart >= enumEQUIP_NUM || chPart < 0) return 0; if (!g_IsRealItemID(m_SChaPart.SLink[chPart].sID)) return 0; return &m_SChaPart.SLink[chPart];}
	DWORD			GetTeamID();
	bool			IsTeamLeader();
	dbc::Long		GetSideID() {return m_lSideID;}
	void			SetSideID(dbc::Long lSideID);
	SItemGrid*		GetItem(dbc::Char chPosType, dbc::Long lItemID);
	SItemGrid*		GetItem2(dbc::Char chPosType, dbc::Long lPosID);
	bool			SetEquipValid(dbc::Char chEquipPos, bool bValid, bool bSyn = true);
	bool			SetKitbagItemValid(dbc::Short sPosID, bool bValid, bool bRecheckAttr = true, bool bSyn = true);
	bool			SetKitbagItemValid(SItemGrid* pSItem, bool bValid, bool bRecheckAttr = true, bool bSyn = true);
	bool			ItemIsAppendLook(SItemGrid* pSItem);
	void			SetLookChangeFlag(bool bChange = false);
	void			SetEspeItemChangeFlag(bool bChange = false);
	dbc::Char		GetLookChangeNum(void);
	bool			CheckForgeItem(SForgeItem *pSItem = NULL);
	bool			DoForgeLikeScript(dbc::cChar *cszFunc, dbc::Long &lRet);
	bool			DoLifeSkillcript(dbc::cChar *cszFunc, dbc::Long &lRet);
	bool			DoTigerScript(dbc::cChar *cszFunc);
	void			SetInOutMapQueue(bool bOutMap = true) {m_bInOutMapQueue = bOutMap;}
	bool			InOutMapQueue(void) {return m_bInOutMapQueue;}
	bool			AddKitbagCapacity(dbc::Short sAddVal);
	void			CheckItemValid(SItemGrid* pCItem);
	void			CheckEspeItemGrid(void);
	dbc::Short		KbPushItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, dbc::Short &sPosID, bool bCommit = true, bool bSureOpr = false);
	dbc::Short		KbPopItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, dbc::Short sPosID, bool bCommit = true);
	dbc::Short		KbClearItem(bool bRecheckAttr, bool bSynAttr, dbc::Short sPosID);
	dbc::Short		KbClearItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, dbc::Short sNum = 0);
	dbc::Short		KbRegroupItem(bool bRecheckAttr, bool bSynAttr, dbc::Short sSrcPosID, dbc::Short sSrcNum, dbc::Short sTarPosID);
	void			ResetScriptParam(void) {memset(m_lScriptParam, 0, sizeof(m_lScriptParam));}
	dbc::Long		GetScriptParam(dbc::Char chID) {if (chID >= 0 && chID < defCHA_SCRIPT_PARAM_NUM) return m_lScriptParam[chID]; else return -1;}
	bool			SetScriptParam(dbc::Char chID, dbc::Long lVal) {if (chID >= 0 && chID < defCHA_SCRIPT_PARAM_NUM) {m_lScriptParam[chID] = lVal; return true;} else return false;}
	void			CheckBagItemValid(CKitbag* pCBag);
	void			CheckLookItemValid(void);
	bool			String2LookDate(std::string &strData);
	bool			String2KitbagData(std::string &strData);
    bool            String2KitbagTmpData(std::string &strData);


	void	SetKitbagRecDBID(long lDBID) {m_lKbRecDBID = lDBID;}
	long	GetKitbagRecDBID(void) {return m_lKbRecDBID;}

    //临时背包ID
    void	SetKitbagTmpRecDBID(long lDBID) {m_lKbTmpRecDBID = lDBID;}
	long	GetKitbagTmpRecDBID(void) {return m_lKbTmpRecDBID;}

	void	LogAssets(dbc::Char chLType);
	bool	SaveAssets(void);
	bool	IsRangePoint(dbc::Long lPosX, dbc::Long lPosY, dbc::Long lDist);
	bool	IsRangePoint(const Point &SPos, dbc::Long lDist) {return IsRangePoint(SPos.x, SPos.y, lDist);}
	bool	IsRangePoint2(dbc::Long lPosX, dbc::Long lPosY, dbc::Long lDist2);
	bool	IsRangePoint2(const Point &SPos, dbc::Long lDist2) {return IsRangePoint2(SPos.x, SPos.y, lDist2);}
	void	SetDBSaveInterval(long lIntl) {m_timerDBUpdate.Begin(lIntl);}
	long	GetDBSaveInterval(void) {return m_timerDBUpdate.GetInterval();}
	void	ResetPosState(void) {m_sPoseState = enumPoseStand; m_SSeat.chIsSeat = 0;}

	DWORD				m_dwBoatCtrlTick; // 熟练度记时用

	// AI使用的变量和接口函数----------------------------------------------------------------
	// 最好的方式是封装一个 CAIChaacter, 交给Character继承
	BYTE				m_AIType{};
	CCharacter*			m_AITarget{};		
	CCharacter*			m_HostCha;		  // 宠物的主人
	int					m_nPatrolX{};       // 巡逻点坐标
	int					m_nPatrolY{};
	short				m_sChaseRange{}; // 角色的追踪范围, 超过这个范围角色就会回出生点休眠
	BYTE				m_btPatrolState{}; // 巡逻状态, 0 表示停留在点1
	                                      //           1 表示停留在点2
                                          //           2 表示正从点1前往点2
	                                      //           3 表示正从点2前往点1
public:

	void	ResetAIState();				  // 重置AI状态, 在角色重生的时候调用

	BOOL		GetChaRelive() { return m_bRelive; }
	void		SetChaRelive() { m_bRelive = true; }
	void		ResetChaRelive() { m_bRelive = false; }

	void		SetVolunteer(BOOL bVol) { m_bVol = bVol; }
	BOOL		IsVolunteer() { return m_bVol; }
	void		SetInvited(BOOL bInvited) { m_bInvited = bInvited; }
	BOOL		IsInvited() { return m_bInvited; }

	void			SetCredit(long lCredit) { setAttr(ATTR_FAME, lCredit); }
	LONG64			GetCredit() { return getAttr(ATTR_FAME); }
	void			AddMasterCredit(long lCredit);
	unsigned long	GetMasterDBID();

	long			GetStoreItemID() { return m_lStoreItemID; }
	void			SetStoreItemID(long lStoreItemID) { m_lStoreItemID = lStoreItemID; }
	bool			IsStoreBuy() { return m_bStoreBuy; }
	void			SetStoreBuy(bool bValue) { m_bStoreBuy = bValue; }
	int				GetPetNum() { return m_nPetNum; }
	void			SetPetNum(int nPetNum) { m_nPetNum = nPetNum; }

	bool			CheckStoreTime(DWORD dwInterval) { return (GetTickCount() - m_dwStoreTime > dwInterval) ? true : false; }
	void			ResetStoreTime() { m_dwStoreTime = GetTickCount(); }

	bool			IsStoreEnable() { return m_bStoreEnable; }
	void			SetStoreEnable(bool bStoreEnable) { m_bStoreEnable = bStoreEnable; }

    //  防沉迷
    bool IsScaleFlag(){return m_expFlag;}
    void SetScaleFlag(){m_expFlag = true;}
    void SetExpScale(DWORD scale){ m_ExpScale = scale; }
    DWORD GetExpScale(){ return m_ExpScale; }

protected:

private:

    virtual void OnBeginSee(Entity *);
	virtual void OnEndSee(Entity *);
    virtual void OnBeginSeen(CCharacter *pCCha);
	virtual void OnEndSeen(CCharacter *pCCha);
	virtual void AreaChange(void);

	virtual void OnAI(DWORD dwCurTime);
    virtual void OnAreaCheck(DWORD dwCurTime);
	virtual void OnTeamNotice(DWORD dwCurTime);
    virtual void OnDBUpdate(DWORD dwCurTime);

	virtual void BeginAction(RPACKET pk);
	virtual void AfterStepMove(void);
	virtual void SubsequenceFight();
	virtual void SubsequenceMove();

	void	OnDie(DWORD dwCurTime);
	void	SrcFightTar(CFightAble *pTar, dbc::Short sSkillID);
	
	void	DoCommand(dbc::cChar *cszCommand, dbc::uLong ulLen);
	BOOL	DoGMCommand(const char *pszCmd, const char *pszParam);
	void	DoCommand_CheckStatus(dbc::cChar *pszCommand, dbc::uLong ulLen);
	void	HandleHelp(dbc::cChar *pszCommand, dbc::uLong ulLen);

	long	ExecuteEvent(Entity *pCObj, dbc::uShort usEventID);

	void	SetActControl(dbc::Char chCtrlType, bool bSet = true) {m_ActContrl[chCtrlType] = bSet;}

	bool		CanLearnSkill(CSkillRecord *pCSkill, dbc::Char chToLv);
	dbc::Short	CanEquipItem(dbc::Short sItemID);
	dbc::Short	CanEquipItemNew(dbc::Short sItemID1, dbc::Short sItemID2 = 0 );
public:
	CKitbag*	GetKitbag() 
	{ 
#ifdef ALL_HAS_KITBAG
		return &m_CKitbag; 
#else
		if(m_pCKitbag != NULL)
		{
			return m_pCKitbag;
		}
		m_pCKitbag = new CKitbag;
		m_pCKitbag->Init(defDEF_KBITEM_NUM_PER_TYPE);
		return m_pCKitbag; 
#endif
	}
private:
#ifdef ALL_HAS_KITBAG
	CKitbag				m_CKitbag;			// 道具栏
#else
	CKitbag				*m_pCKitbag;			// 道具栏
#endif

public:
	CKitbag				*m_pCKitbagTmp;       // 临时背包
	stNetShortCut		m_CShortcut;		// 快捷栏
	long				m_lKbRecDBID;		// 道具栏在资源表中的ID
	long				m_lKbTmpRecDBID;	// 临时背包在资源表中的ID
	long				m_lStoreItemID;
	bool				m_bStoreBuy;
	DWORD				m_dwStoreTime;
	bool				m_bStoreEnable;

	int					m_nPetNum;
	
	stNetChangeChaPart	m_SChaPart;
	bool				m_ActContrl[enumACTCONTROL_MAX];	// 角色的行动控制
	CTimer				m_timerScripts;						// 用于HP，SP等的恢复

	CHateMgr*			m_pHate;							// 仇恨度

	BOOL				m_bRelive;							// 是否正在被接受复活

	BOOL				m_bVol;								// 是否是志愿者
	BOOL				m_bInvited;							// 是否正在被邀请

	//SSkillGrid			*m_pSkillGridTemp;

	// 复活信息
	struct
	{
		Char	m_chSelRelive;	// 选择复活方式
		Char	m_chReliveLv;	// 复活等级，如果大于0，则表示存在非自然复活的可能.
	};

	CActionCache		m_CActCache;

	DWORD	m_dwCellRunTime[16];

	short	m_sTigerItemID[9];	// 老虎机的9个道具ID
	short	m_sTigerSel[3];		// 投注标志
#ifdef NEW_MAPCOPY
	char	g_szTFightMapName[MAX_MAPNAME_LENGTH];//Add by sunny.sun 20090812
#endif
private:
	BOOL BoatEnterMap( CCharacter& Boat, DWORD dwxPos, DWORD dwyPos, USHORT sDir );

	dbc::Char			m_szMotto[defMOTTO_LEN];
	dbc::uShort			m_usIcon;

    bool m_expFlag;
    DWORD m_ExpScale;       //  防沉迷，经验比例

	struct
	{
	  short m_sPoseState{enumPoseStand}; // 0，站.1，倚靠
	};
	//add by jilinlee 2007/4/20
	struct SReadBook
	{
		bool bIsReadState;       //0,不在读书状态.1，在读书状态.
        DWORD dwLastReadCallTick; //上次调用Reading_Book脚本函数的时间.
	};
    
	SReadBook m_SReadBook;

	CAction		        m_CAction;
	SLean		        m_SLean;
	SSeat				m_SSeat;
#ifdef SET_CHEAT
	SCheatX				m_sCheatX;
#endif
	BYTE				_btBlockCnt;
	STempChaPart        m_STempChaPart;

	// 交易信息
	mission::CTradeData*	m_pTradeData;

	#define CHAEXIT_NONE				0		// 无效状态（角色正常使用中...）
	#define CHAEXIT_BEGIN				1<<0	// 已经开始退出状态	

	BYTE				m_byExit;
	CTimer				m_timerExit;
    CTimer              m_timerAI;
    CTimer              m_timerAreaCheck;
	CTimer				m_timerDBUpdate;
	CTimer				m_timerDie;
	CTimer				m_timerMission;			// 任务系统分钟计时触发器事件
    CTimer				m_timerSkillState;		// 技能状态计时器
	CTimer              m_timerTeam;			// Team信息定时通知客户端

	struct
	{
		CTimer			m_timerPing;
		dbc::uLong		m_ulPingDataLen;
	};

	dbc::Char			m_chPKCtrl;				// 最高位表示是否在PK区域，最低位表示PK开关是否打开.当处于PK区时，系统认为开关是打开的，并禁止设置开关.当开关打开时，就可以攻击别的玩家（己方除外），此时，如果受击方的开关是关闭的，则要扣攻击方的“声望“值

	dbc::Long			m_lSideID;				// 分边编号
	bool				m_bInOutMapQueue;
	struct // Ping
	{
		DWORD	m_dwPing;
		DWORD	m_dwPingRec[defPING_RECORD_NUM];
		DWORD	m_dwPingSendTick;
	};

	struct // for test net state
	{
		dbc::uLong	m_ulNetSendLen;
		CTimer		m_timerNetSendFreq;
	};

	dbc::Long	m_lScriptParam[defCHA_SCRIPT_PARAM_NUM];

#ifdef SHUI_JING
	DWORD	m_lFlatMoney;	//平台帐户
	DWORD				m_cancelSaletick;//取消挂单时间
	DWORD				m_refreshtick;//刷新时间限制
	DWORD				m_getmoneytick;//取平台帐户时间限制
	int					m_buyNum;//买单个数
	int					m_saleNum;//卖单个数
public:
	int		GetBuyNum(){ return m_buyNum; }
	int		GetSaleNum(){ return m_saleNum; }
#endif

#ifdef XTRAP_S
private:
	CTimer		m_xdrapTime;//Add by sunny.sun 20090728
	char SessionBuf[320];
	enum XTrapReturn
	{
		XTRAP_CC_RETURN_OK,
		XTRAP_CC_RETURN_ERROR,
		XTRAP_CC_RETURN_UNKNOWN,
		XTRAP_CC_RETURN_INVALID_PARAMETER,
		XTRAP_CC_RETURN_CRC,
		XTRAP_CC_RETURN_TIMEOUT,
		XTRAP_CC_RETURN_DETECTHACK = 15
	};
#endif
protected:

    DWORD   _dwLastAreaTick;
    BYTE    _btLastAreaNo;

	DWORD	_dwLastSayTick;
	

public:
	void	ResetLifeTime(DWORD dwTime)
	{
		_dwLifeTime = dwTime;
		_dwLifeTimeTick = GetTickCount();
	}

	BOOL	CheckLifeTime()
	{
		if(_dwLifeTime==0) return FALSE; // 不需要生命时间计时
		
		if((GetTickCount() - _dwLifeTimeTick) > _dwLifeTime) // 生命时间已到
		{
			return TRUE;
		}
		return FALSE;
	}

	DWORD GetLifeTime() { return _dwLifeTime; }
	
	DWORD	_dwLifeTime;
	DWORD	_dwLifeTimeTick;

	// YATOPS

	public:
	float GetExpRate();
	float GetDropRate();

};

// 用于与脚本之间的交互
extern Point		g_SSkillPoint;
extern bool			g_bBeatBack;
extern unsigned char	g_uchFightID;
extern char			g_chUseItemFailed[2];
extern char			g_chUseItemGiveMission[2];
//

extern char*	SStateData2String(CCharacter *pCCha, char *szSStateBuf, int nLen);
extern const char*	SStateData2StringEx(CCharacter *pCCha, StringPoolL& pool, int index);
extern bool		Strin2SStateData(CCharacter *pCCha, std::string &strData);
//Add by lark.li 20080723
extern char*	ChaExtendAttr2String(CCharacter *pCCha, char *szAttrBuf, int nLen);
extern const char*	ChaExtendAttr2StringEx(CCharacter *pCCha, StringPoolL& pool, int index);
extern bool		Strin2ChaExtendAttr(CCharacter *pCCha, std::string &strAttr);
 //交易日志记录接口
extern void TL(int nType, const char *pszCha1, const char *pszCha2, const char *pszTrade);

#endif // CHARACTER_H
