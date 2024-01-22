#pragma once

class CCharacter;
struct stNetTeamChaPart;

namespace GUI
{

//
enum eTeamStyle
{
  enumTeamFrnd,		// 好友
  enumTeamGroup,	// 队伍
  enumTeamGuild,	// 行会
  enumTeamRoad,		// 路人
  enumTeamMaster,	// 师傅
  enumTeamPrentice, // 徒弟
};

enum eShowStyle
{
  enumShowQQName,  // 显示名字
  enumShowQQMotto, // 显示座右铭
};

class CMemberData
{
  public:
  CMemberData();
  ~CMemberData();

  DWORD GetIndex() { return _dwIndex; }
  void	SetIndex(DWORD v) { _dwIndex = v; }

  long GetHP() { return _nHp; }
  long GetSP() { return _nSp; }
  long GetLV() { return _nLv; }
  long GetMaxHP() { return _nMaxHp; }
  long GetMaxSP() { return _nMaxSp; }
  BYTE GetWork() { return _byWork; }

  void SetWork(BYTE v) { _byWork = v; }
  void SetHP(long v) { _nHp = v; }
  void SetSP(long v) { _nSp = v; }
  void SetLV(long v) { _nLv = v; }
  void SetMaxHP(long v) { _nMaxHp = v; }
  void SetMaxSP(long v) { _nMaxSp = v; }

  void SetOnline(bool isOnline) { _bOnline = isOnline; }
  bool IsOnline() { return _bOnline; }

  stNetTeamChaPart* GetFace() { return _pFace; }
  void				SetFace(const stNetTeamChaPart& pFace);

  private:
  DWORD _dwIndex;
  bool	_bOnline;
  BYTE	_byWork;
  long	_nMaxHp;
  long	_nHp; // 血
  long	_nSp; // 魔法
  long	_nLv;
  long	_nMaxSp;

  stNetTeamChaPart* _pFace;
};

class CTeam;
class CMember
{
  public:
  // Modify by lark.li 20080802 begin
  //CMember( CTeam* pTeam, unsigned long id, const char* strName , const char* strMotto, DWORD icon_id);
  CMember(CTeam* pTeam, unsigned long id, const char* strName, const char* strMotto, DWORD icon_id, const char* szGroupName = "");
  // End

  virtual ~CMember();

  void Refresh();

  void SetName(const char* str);
  void SetMotto(const char* str);
  void SetJobName(const char* str);

  void SetID(DWORD id) { _nID = id; }
  void SetIconID(DWORD iconId);
  void SetPointer(void* p) { _pPointer = p; }
  void SetOnline(bool isOnline);
  void ModifyAttr(string motto, string job, DWORD dwLv, DWORD nIcon_ID, string guildName);

  DWORD		  GetID() { return _nID; }
  const char* GetName() { return _strName.c_str(); }
  const char* GetMotto() { return _strMotto.c_str(); }
  const char* GetShowName();
  const char* GetGuildName() { return _strGuildName.c_str(); }

  // Add by lark.li 20080802 begin
  const char* GetGroupName() { return _strGroupName.c_str(); }
  void		  SetGroupName(const char* szGroupName) { _strGroupName = szGroupName; }
  // End

  DWORD		  GetIconID() { return _nIcon_id; }
  DWORD		  GetLevel() { return _dwLv; }
  const char* GetJobName() { return _strJob.c_str(); }
  // Add by rock.wang 2009.05.07 begin
  const char* GetJobNameByID();
  // End
  void*		   GetPointer() { return _pPointer; }
  CTeam*	   GetTeam() { return _pTeam; }
  CMemberData* GetData() { return _pData; }

  bool IsOnline() { return _bIsOnline; }
  void SetIsFlash(bool isFlash) { _bFlash = isFlash; }
  bool GetIsFlash() { return _bFlash; }

  static void		SetShowStyle(eShowStyle style);
  static eShowStyle _nShowStyle;

  private:
  string _strName; // 名字
  string _strMotto;
  string _strJob;
  string _strShowName;
  string _strGuildName;

  // Add by lark.li 20080802 begin
  string _strGroupName; // 分组名字
  // End

  DWORD _dwLv;
  DWORD _nID; // ID
  DWORD _nIcon_id;
  bool	_bIsOnline;
  void* _pPointer;
  bool	_bFlash;

  CMemberData* _pData;
  CTeam*	   _pTeam;
};

class CTeam
{
  public:
  CTeam(eTeamStyle nStyle, const char* szName);
  ~CTeam();

  void Clear();

  // Modify by lark.li 20080802 begin
  //CMember*    Add( unsigned long nID, const char* szName, const char* szMotto, DWORD icon_id);
  CMember* Add(unsigned long nID, const char* szName, const char* szMotto, DWORD icon_id, const char* szGroupName = "", bool onLine = false);
  // End

  bool Del(unsigned long nID);

  CMember* Find(unsigned long nID);
  CMember* GetMember(unsigned long nIndex);

  const char* GetName() { return _strName.c_str(); }
  int		  GetStyle() { return _eStyle; }
  DWORD		  GetCount() { return _nCount; }

  void	SetPointer(void* p) { _pPointer = p; }
  void* GetPointer() { return _pPointer; }

  // Add by lark.li 20080804 begin
  int		  GetGroupNum() { return (int)_groups.size(); }
  const char* GetGroupName(int index);

  void AddGroupName(const char* szGroupName);
  void DelGroupName(const char* szGroupName);
  void ChangeGroupName(const char* szOldGroupName, const char* szNewGroupName);
  void MoveGroup(unsigned long nID, const char* szOldGroupName, const char* szNewGroupName);

  void ClearGroupName();
  // End

  private:
  eTeamStyle _eStyle;
  string	 _strName;

  typedef list<CMember*> members;
  members				 _member;

  // Add by lark.li 20080804 bgein
  vector<pair<string, int>> _groups;
  // End

  DWORD _nCount;

  void* _pPointer;
};

class CTeamMgr
{
  public:
  CTeamMgr();
  ~CTeamMgr();

  CTeam* Add(eTeamStyle eTeam, const char* szName = "");
  bool	 Del(eTeamStyle eTeam, const char* szName = "");
  CTeam* Find(eTeamStyle eTeam, const char* szName = "");
  void	 ChangeStyle(eShowStyle style);

  void SceneSwitch();
  void ResetAll();

  static DWORD GetTeamLeaderID() { return _dwTeamLeaderID; }
  static void  SetTeamLeaderID(DWORD v) { _dwTeamLeaderID = v; }

  private:
  CTeam* _pFrndTeam;	 // 好友
  CTeam* _pGroupTeam;	 // 队伍
  CTeam* _pRoadTeam;	 // 路人
  CTeam* _pMasterTeam;	 // 师傅
  CTeam* _pPrenticeTeam; // 徒弟

  static DWORD _dwTeamLeaderID;
};

// 内联函数

} // namespace GUI
