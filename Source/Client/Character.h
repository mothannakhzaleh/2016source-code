#pragma once
#include "Scene.h"
#include "SceneNode.h"
#include "LECharacter.h"
#include "CompCommand.h"
#include "CharacterModel.h"
#include "publicfun.h"
#include "CharacterAction.h"
#include "BoolSet.h"
#include "CharacterRecord.h"
#include "Actor.h"
#include "FindPath.h"
#include "SteadyFrame.h"

const int ITEM_FACE_MAX = 4; // 道具前4格子作为外观更新

class CShadeEff;
class CEffectObj;
class CGameScene;
class CActor;
class CSkillRecord;
class CChaRecord;
class CSkillStateRecord;
struct stSkillState;
class CEvent;
struct xShipInfo;
class CSceneHeight;

namespace GUI
{
class CHeadSay;
}

struct LoadChaInfo
{
  LoadChaInfo()
  {
	memset(this, 0, sizeof(LoadChaInfo));
  }

  DWORD cha_id;
  char	bone[32];
  char	part[5][32];
  char	prop[4][32];
};

#define ERROR_POSE_HEIGHT 9999
#define MAX_CANCELSTATE	  3

// 主角类型
enum eMainChaType
{
  enumMainNone = 0, // 非主角
  enumMainPlayer,	// 为主角的玩家
  enumMainBoat,		// 为主角的船
};

enum eChaState
{
  enumChaStateMove = 1, // 是否可移动
  enumChaStateAttack,	// 是否可以使用普通攻击
  enumChaStateUseSkill, // 是否可以使用技能
  enumChaStateTrade,	// 是否可以交易
  enumChaStateUseItem,	// 是否可以使用物品

  enumChaStateNoHide,  // 隐藏
  enumChaStateNoDizzy, // 晕眩
  enumChaStateNoAni,   // 是否有动画效果

  enumChaStateNoShop, // 当前不处于摆摊状态
};

enum eChaPkState
{
  enumChaPkSelf = 1, // 自己的PK开关
  enumChaPkScene,	 // 是否为竞技场,即是否可以操作PK开关
};

class CCharacter : public CSceneNode, public CCharacterModel
{
  friend class CHeadSay;
  friend class CChaStateMgr;

  private:
  virtual BOOL _Create(int nCharTypeID, int nType);

  public:
  virtual bool GetRunTimeMatrix(MPMatrix44* mat, DWORD dummy_id);

  public:
  void InitState(); // 将状态初始化

  void ForceMove(int nTargetX, int nTargetY); // 不改变方向的移动
  void MoveTo(int x, int y);
  int  FaceTo(int yaw);
  int  FaceTo(int x, int y) { return FaceTo(_GetTargetAngle(x, y)); }
  int  GetTargetDistance();

  void	  StopMove();
  CActor* GetActor() { return _pActor; }

  bool GetIsArrive() { return _isArrive; }
  bool GetIsFaceTo() { return !_nTurnCnt; }

  bool UpdataItem(int nItem, DWORD nLink); // 更新道具
  void UpdataFace(stNetChangeChaPart& stPart);

  bool				LoadBoat(stNetChangeChaPart& stPart);
  static xShipInfo* ConvertPartTo8DWORD(stNetChangeChaPart& stPart, DWORD* dwBuf);

  bool IsTeamLeader() { return _nLeaderID != 0 && _nLeaderID == getHumanID(); } // 是否是队长
  long GetTeamLeaderID() { return _nLeaderID; }									// 返回所属队的队长ＩＤ,没有队伍为0

  void SetTeamLeaderID(long v) { _nLeaderID = v; }

  void RefreshShadow();
  void SetHide(BOOL bHide);

  //void			SetHieght(float fhei);
  public: // 与主角的技能相关
  bool ChangeReadySkill(int nSkillID);

  static CSkillRecord* GetReadySkillInfo() { return _pReadySkillInfo; }

  static void		   SetDefaultSkill(CSkillRecord* p) { _pDefaultSkillInfo = p; }
  static CSkillRecord* GetDefaultSkillInfo() { return _pDefaultSkillInfo; }

  static bool IsDefaultSkill();
  static void ResetReadySkill();

  static void SetIsShowShadow(bool v) { _IsShowShadow = v; }
  static bool GetIsShowShadow() { return _IsShowShadow; }

  CChaRecord* GetDefaultChaInfo() { return _pDefaultChaInfo; }
  void		  SetDefaultChaInfo(CChaRecord* pInfo);

  xShipInfo* GetShipInfo() { return _pShipInfo; }

  CBoolSet& GetPK() { return _PK; }
  bool		GetIsPK() { return _PK.IsAny(); }

  public:
  void ActionKeyFrame(DWORD key_id);

  bool		  ItemEffect(int nEffectID, int nItemDummy, int nAngle = 999);
  CEffectObj* SelfEffect(int nEffectID, int nDummy = -1, bool isLoop = false, int nSize = -1, int nAngle = 999);

  void OperatorEffect(char oper, int x, int y);

  // 释放飞行特效:从本身Dummy飞出,飞行速度,打击到某目标点pTarget,追踪目标玩家nTargetChaID
  CEffectObj* SkyEffect(int nEffectID, int nBeginDummy = 2, int nItemDummy = 0, int nSpeed = 400, D3DXVECTOR3* pTarget = NULL, int nTargetChaID = -1, CSkillRecord* pSkill = NULL);

  // 是否为可操作状态,如死亡,这个状态当服务器返回死亡时,立即置上
  bool IsEnabled() { return GetActor()->IsEnabled(); }

  // 是否可以显示在小地图
  bool IsInMiniMap() { return IsValid() && GetActor()->IsEnabled() && !IsHide(); }

  CSceneItem* GetAttackItem(); // 得到玩家手上的道具

  void PlayAni(char* pAni, int nMax); // 播放动画
  void StopAni();					  // 停止播放动画

  int GetPose(int pose);

  bool IsMainCha();
  void CheckIsFightArea();

  int GetSkillSelectType();

  void	setReliveTime(short sTime) { _sReliveTime = sTime; }
  short getReliveTime() { return _sReliveTime; }
  int	getPatrolX() { return _nPatrolX; }
  int	getPatrolY() { return _nPatrolY; }
  void	setPatrol(int x, int y) { _nPatrolX = x, _nPatrolY = y; }

  bool GetIsFight() { return this->_InFight; }
  void FightSwitch(bool isFight) { _FightSwitch(isFight); }

#ifdef _KOSDEMO_
  int		  nPetHideCount;
  int		  nMainChaChangeItemCount;
  CEffectObj* curEff;
  void		  KosDemoControl();
  void		  SetPetHideCount(int nCount) { nPetHideCount = nCount; }
  void		  SetMainChaChangeItemCount(int nCount) { nMainChaChangeItemCount = nCount; }
#endif

  bool GetIsPet(); // 是否是宠物
  bool GetIsFly(); // 是否飞行

  private: // 移动
  void _CalPos(float fProgressRate);
  int  _GetTargetAngle(int nTargetX, int nTargetY, BOOL bBack = FALSE);
  void _DetachAllItem();
  void _FightSwitch(bool isFight);

  float _fStepProgressRate;
  float _fProgressYaw;
  float _fStep;
  int	_nAngleStep;
  int	_nTurnCnt;
  int	_nTargetX, _nTargetY;
  int	_nLastPosX, _nLastPosY;

  bool			_isArrive;
  bool			_isStopMove;
  float			_fMapHeight; // 在地图上的总高度，单位：米
  CSceneHeight* _pSceneHeight;

  static bool _IsShowName;

  private:
  static void _SetReadySkill(CSkillRecord* p);

  static CSkillRecord* _pDefaultSkillInfo;

  static CSkillRecord* _pReadySkillInfo; // 客户端准备使用的技能

  CChaRecord* _pDefaultChaInfo;
  CActor*	  _pActor;

  private:
  char	_szName[33];		// 名字
  char	_szHumanName[33];	// 第一个角色的名字
  char	_szGuildName[33];	// 公会名称
  char	_szGuildMotto[101]; // 公会座右铭
  int	_nGuildID;			// 公会ID
  DWORD _dwGuildColor;		// 公会显示出来的颜色
  DWORD _dwNameColor;		// 名字颜色
  char	_szShopName[33];	// 商店名字

  char	_szPreName[20]; // 前缀名字，包含括号
  DWORD _szPreColor;

  long		 _lSideID;	  // 所属那一方,红方,绿方,用于两方作战时使用
  CShadeEff* _pSideShade; // 用于显示红方,绿方

  public: // 应用层
  void setSideID(long v);
  long getSideID() { return _lSideID; }

  void		  setName(const char* pszName);
  const char* getName() { return _szName; }

  void	setGuildID(int nGuildID);
  int	getGuildID() { return _nGuildID; }
  DWORD getGuildColor() { return _dwGuildColor; }

  //void			setGuildName( const char* pszName )	{ strncpy( _szGuildName, pszName, sizeof(_szGuildName) );	}
  void		  setGuildName(const char* pszName) { strncpy_s(_szGuildName, sizeof(_szGuildName), pszName, _TRUNCATE); }
  const char* getGuildName() { return _szGuildName; }

  //void			setGuildMotto( const char* pszName ){ strncpy( _szGuildMotto, pszName, sizeof(_szGuildMotto) );	}
  void		  setGuildMotto(const char* pszName) { strncpy_s(_szGuildMotto, sizeof(_szGuildMotto), pszName, _TRUNCATE); }
  const char* getGuildMotto() { return _szGuildMotto; }

  //	以下strncpy(name1,name2,sizeof(name1)) 统一替换为 strncpy_s(name1,sizeof(name1),name2,_TRUNCATE)
  void		  setHumanName(const char* pszName) { strncpy_s(_szHumanName, sizeof(_szHumanName), pszName, _TRUNCATE); }
  const char* getHumanName() { return _szHumanName; }

  void		  setShopName(const char* pszName) { strncpy_s(_szShopName, sizeof(_szShopName), pszName, _TRUNCATE); }
  const char* getShopName() { return _szShopName; }

  void	setNameColor(DWORD dwColor);
  DWORD getNameColor() { return _dwNameColor; }

  const char* GetPreName() { return _szPreName; }
  DWORD		  GetPreColor() { return _szPreColor; }

  // Game Attrib Shortcut
  void setMoveSpeed(long lSpeed) { _Attr.set(ATTR_MSPD, lSpeed); }
  long getMoveSpeed() { return (long)_Attr.get(ATTR_MSPD); }
  void setHPMax(long lValue) { _Attr.set(ATTR_MXHP, lValue); }
  long getHPMax() { return (long)_Attr.get(ATTR_MXHP); }
  void setHP(long lValue) { _Attr.set(ATTR_HP, lValue); }
  long getHP() { return (long)_Attr.get(ATTR_HP); }
  void setAttackSpeed(long lValue) { _Attr.set(ATTR_ASPD, lValue); }
  long getAttackSpeed() { return (long)_Attr.get(ATTR_ASPD); }

  void			setChaModalType(int type) { _eChaModalType = (EChaModalType)type; }
  EChaModalType getChaModalType() { return _eChaModalType; }

  void		   setChaCtrlType(int type);
  EChaCtrlType getChaCtrlType() { return _eChaCtrlType; }

  int GetDangeType() { return _nDanger; }

  int  getNpcType() { return _nNpcType; }
  void setNpcType(int type) { _nNpcType = type; }

  void setGMLv(char v) { _chGMLv = v; }
  char getGMLv() { return _chGMLv; }

  public:
  CCharacter();
  virtual ~CCharacter();

  void LoadingCall();

  virtual void FrameMove(DWORD dwTimeParam);
  virtual void Render();
  void		   RefreshUI(int nParam = 0);
  void		   RefreshLevel(int nMainLevel);
  void		   RefreshItem(bool isFirst = false);

  void EnableAI(BOOL bEnable) { _bEnableAI = bEnable; }
  void ResetAITick() { _dwLastAITick = GetTickCount(); }

  bool PlayPose(DWORD pose, DWORD type = PLAY_ONCE, int time = -1, int fps = DefaultFPS, bool isBlend = false);

  public:
  void setPos(int nX, int nY);

  bool IsBoat();
  bool IsPlayer();
  bool IsNPC();
  bool IsMonster();
  bool IsResource();

  void		   SetMainType(eMainChaType v) { _eMainType = v; }
  eMainChaType GetMainType() { return _eMainType; }

  CBoolSet* GetChaState() { return &_ChaState; }

  void SetCircleColor(D3DCOLOR dwColor);

  int  DistanceFrom(CCharacter* pCha);
  BOOL WieldItem(const drSceneItemLinkInfo* info);

  int ReCreate(DWORD type_id);

  public:
  GUI::CHeadSay* GetHeadSay() { return _pHeadSay; }
  void			 DestroyLinkItem();

  int LoadCha(const LoadChaInfo* info);

  void UpdateTileColor();
  // 	char*			getLogName();

  //void			setSecondName(const char *pszSecName) { strcpy(_szSecondName, pszSecName); }
  void		  setSecondName(const char* pszSecName) { strncpy_s(_szSecondName, sizeof(_szSecondName), pszSecName, _TRUNCATE); }
  const char* getSecondName() { return _szSecondName; }
  void		  ShowSecondName(BOOL bShow) { _bShowSecondName = bShow; }
  BOOL		  IsShowSecondName() { return _bShowSecondName; }
  void		  setPhotoID(short sID) { _sPhotoID = sID; }
  short		  getPhotoID() { return _sPhotoID; }

  void	setHumanID(DWORD v) { _dwHumanID = v; }
  DWORD getHumanID() { return _dwHumanID; }

  void setNpcState(DWORD dwState); // 根据标识显示当前状态

  void DieTime(); // 死亡时调用，删除所有特效，清空可能的状态，如眩晕

  void SetIsForUI(bool v) { _IsForUI = v; }
  bool GetIsForUI() { return _IsForUI; }

  void	  setEvent(CEvent* pEvent) { _pEvent = pEvent; }
  CEvent* getEvent() { return _pEvent; }

  void SwitchFightPose();

  stNetChangeChaPart& GetPart() { return _stChaPart; }

  bool IsUpdate() { return _bUpdate; }

  bool IsShop() { return _ChaState.IsFalse(enumChaStateNoShop); }

  void RefreshFog();

  CSceneItem* GetHandItem(int nEquipPos);

  void SetItemFace(unsigned int nIndex, int nItem);
  int  GetItemFace(unsigned int nIndex) { return _ItemFace[nIndex]; }

  int  GetServerX() { return _nServerX; }
  int  GetServerY() { return _nServerY; }
  void SetServerPos(int x, int y)
  {
	_nServerX = x;
	_nServerY = y;
  }

  //add by ALLEN 2007-10-16
  bool IsReadingBook();

  public: // 技能运行状态
  CChaStateMgr* GetStateMgr() { return _pChaState; }

  void SynchroSkillState(stSkillState* pState, int nCount);
  void HitEffect(int nAngle);

  void RefreshShopShop();

  private:
  CChaStateMgr* _pChaState;
  CBoolSet		_ChaState; // 玩家状态集合

  struct stHit
  {
	stHit(int id, int dummy) :
		nEffectID(id), nDummy(dummy) {}

	int nEffectID;
	int nDummy;
  };
  typedef vector<stHit> hits;
  hits					_hits;

  protected:
  virtual void _UpdateYaw();
  virtual void _UpdatePitch();
  virtual void _UpdateRoll();
  virtual void _UpdateHeight();
  virtual void _UpdatePos();
  virtual void _UpdateValid(BOOL bValid);

  protected:
  BOOL	_bEnableAI;
  DWORD _dwAIInterval;
  DWORD _dwLastAITick;

  GUI::CHeadSay* _pHeadSay;
  int			 _nUIScale; // 当作为界面显示时, 缩放参数

  private:			 // 特效
  CBoolSet _Special; // 特效表现集合
  CBoolSet _PK;		 // PK开关

  // 公转时临时变量
  long _nHelixCenterX, _nHelixCenterY;
  int  _nHelixAngle; // 螺旋角度增量
  int  _nHelixRadii;

#ifdef _LOG_NAME_
  //	char			_szLogName[128];
  public:
  //	void			setLogName( const char* str )	{ strcpy_s( _szLogName, _countof(_szLogName), str);	}

  static bool IsShowLogName;
#endif

  private:
  float _fMoveSpeed;
  char* _pszFootMusic;
  char* _pszWhoopMusic;
  float _fMaxOpacity; // 客户端透明度最大值,1.0f为实心

  bool _IsFightPose;
  bool _InFight; // 是否正处在战斗区

  CSceneItem*		 _pHandItem[enumEQUIP_NUM];
  stNetChangeChaPart _stChaPart;

  CSceneItem* _pNpcStateItem;
  CSceneItem* _pShopItem;

  int  _nNpcType;
  bool _IsForUI; // 这个角色是画在UI上的

  long	_nLeaderID;		   // 所属组队的ID
  char	_szSecondName[41]; // 第二个名字,即座右铭
  BOOL	_bShowSecondName;  // 是否显示第二个名字
  short _sPhotoID;		   // 头像ID

  EChaModalType _eChaModalType; // 模型类型
  EChaCtrlType	_eChaCtrlType;	// 操作类型
  eMainChaType	_eMainType;		// 主角类型
  int			_nDanger;		// 危险程序，用于玩家鼠标选择时，按危险程序排序

  DWORD _dwHumanID; // 用于与Group Server通信的ID

  char	  _chGMLv;
  CEvent* _pEvent;

  xShipInfo*  _pShipInfo;
  bool		  _bUpdate;
  CEffectObj* _pBoatFog; // 船的烟雾,与血有关

  CEffectObj* _pItemFaceEff[ITEM_FACE_MAX];
  int		  _ItemFace[ITEM_FACE_MAX];

  private:
  bool		  _IsMoveTimeType; // 为false是帧移动(用于主角),为true是时间移动
  D3DXVECTOR2 _vMoveStart, _vMoveEnd, _vMoveDir;
  DWORD		  _dwStartTime;
  float		  _fMoveLen;

  // 怪物摆放所需要的参数记录-----------------------------------
  short _sReliveTime; // 放怪时用来记录重生时间
  int	_nPatrolX;	  // 巡逻点x
  int	_nPatrolY;	  // 巡逻点y
  // -----------------------------------------------------------

  int _nServerX, _nServerY;

  static bool _IsShowShadow;

  // Added by clp
  public:
  void linkTo(CCharacter* node, int boneID)
  {
	mParentNode	  = node;
	mParentBoneID = boneID;
  }
  void removeLink()
  {
	mParentNode = NULL;
  }

  protected:
  CCharacter* mParentNode;
  int		  mParentBoneID;

  private:
  void _computeLinkedMatrix();
};

inline void CCharacter::setNameColor(DWORD dwColor)
{
  _dwNameColor = dwColor;
}

inline void CCharacter::_UpdateYaw()
{
  SetYaw(Angle2Radian((float)_nYaw));
  UpdateYawPitchRoll();
  _nTurnCnt = 0;

  if(GetDrunkState())
  {
	UpdateChaMatrix();
  }
}

inline void CCharacter::_UpdatePitch()
{
  SetPitch(Angle2Radian((float)_nPitch));
  if(GetDrunkState())
  {
	UpdateChaMatrix();
  }
}

inline void CCharacter::_UpdateRoll()
{
  SetRoll(Angle2Radian((float)_nRoll));
  if(GetDrunkState())
  {
	UpdateChaMatrix();
  }
}

inline void CCharacter::_UpdatePos()
{
  _vPos.x = (float)_nCurX / 100.0f;
  _vPos.y = (float)_nCurY / 100.0f;
  SetPos((float*)&_vPos); // 子类对设置坐标的实现, _vPos.z保持不变
  if(GetDrunkState())
  {
	UpdateChaMatrix();
  }
}

inline bool CCharacter::IsPlayer()
{
  return _eChaCtrlType == enumCHACTRL_PLAYER;
}

inline bool CCharacter::IsBoat()
{
  return _eChaModalType == enumMODAL_BOAT;
}

inline bool CCharacter::IsNPC()
{
  return enumCHACTRL_NPC == _eChaCtrlType;
}

inline bool CCharacter::IsMonster()
{
  return enumCHACTRL_MONS == _eChaCtrlType;
}

inline CSceneItem* CCharacter::GetAttackItem()
{
  CSceneItem* item = GetLinkItem(LINK_ID_RIGHTHAND);
  if(!item) item = GetLinkItem(LINK_ID_LEFTHAND);
  return item;
}

inline int CCharacter::DistanceFrom(CCharacter* pCha)
{
  return (int)GetDistance(GetCurX(), GetCurY(), pCha->GetCurX(), pCha->GetCurY());
}

inline bool CCharacter::IsDefaultSkill()
{
  return _pReadySkillInfo == NULL || _pReadySkillInfo == _pDefaultSkillInfo;
}

// inline char* CCharacter::getLogName()
// {
// #ifdef _LOG_NAME_
// 	return _szLogName;
// #else
// 	return _szName;
// #endif
// }

inline void CCharacter::_CalPos(float fProgressRate)
{
  float fX = (float)_nLastPosX * (1.0f - fProgressRate) + (float)_nTargetX * fProgressRate;
  float fY = (float)_nLastPosY * (1.0f - fProgressRate) + (float)_nTargetY * fProgressRate;

  setPos((int)fX, (int)fY);
}

inline bool CCharacter::IsMainCha()
{
  return this == GetScene()->GetMainCha();
}

inline void CCharacter::_DetachAllItem()
{
  DetachItem(LINK_ID_LEFTHAND);
  DetachItem(LINK_ID_RIGHTHAND);
  DetachItem(21);
  DetachItem(22);
  DetachItem(23);
}

inline int CCharacter::ReCreate(DWORD type_id)
{
  setTypeID(type_id);
  return CCharacterModel::ReCreate(type_id);
}

inline void CCharacter::_SetReadySkill(CSkillRecord* p)
{
  _pReadySkillInfo = p;
}

inline void CCharacter::HitEffect(int nAngle)
{
  if(!_hits.empty())
  {
	for(hits::iterator it = _hits.begin(); it != _hits.end(); ++it)
	{
	  SelfEffect(it->nEffectID, it->nDummy, false, -1, nAngle);
	}
  }
}

inline void CCharacter::MoveTo(int nTargetX, int nTargetY)
{
  ForceMove(nTargetX, nTargetY);
  if(!_isArrive) FaceTo(_GetTargetAngle(nTargetX, nTargetY));
}

inline void CCharacter::CheckIsFightArea()
{
  if(_pScene->GetTerrain())
  {
	_InFight = !(_pScene->GetTerrain()->GetTile(GetCurX() / 100, GetCurY() / 100)->sRegion & enumAREA_TYPE_NOT_FIGHT);
  }
}

inline int CCharacter::GetPose(int pose)
{
  if(_InFight)
  {
	switch(pose)
	{
	case POSE_WAITING:
	  return POSE_WAITING2;
	case POSE_RUN:
	  return POSE_RUN2;
	}
  } else
  {
	switch(pose)
	{
	case POSE_WAITING2:
	  return POSE_WAITING;
	case POSE_RUN2:
	  //if(g_cFindPath.LongPathFinding())
	  //	return POSE_RUN2;
	  //else
	  //	return POSE_RUN;
	  return POSE_RUN2;
	case POSE_RUN:
	  //if(g_cFindPath.LongPathFinding())
	  //	return POSE_RUN2;
	  //else
	  //	return POSE_RUN;
	  return POSE_RUN2;
	}
  }
  return pose;
}

inline void CCharacter::StopMove()
{
  if(_IsMoveTimeType)
	_isArrive = true;
  else
	_isStopMove = true;
}

inline void CCharacter::RefreshShadow()
{
  if(_IsShowShadow && (GetDefaultChaInfo()->chTerritory != defCHA_TERRITORY_SEA) && GetActor()->GetState() == enumNormal && !IsHide())
  {
	SetShadeShow(SCENENODE_SHADOW, true);
  } else
  {
	SetShadeShow(SCENENODE_SHADOW, false);
  }
}

inline void CCharacter::setGuildID(int nGuildID)
{
  _nGuildID = nGuildID;
  if(nGuildID >= 0 && nGuildID <= 99)
	_dwGuildColor = 0xffedfcca;
  else
	_dwGuildColor = 0xfffed8ef;
}

inline void CCharacter::StopAni()
{
  _Special.AllFalse();
  _nHeightOff	  = 0;
  _fMapHeight	  = 0.0f;
  _nPoseHeightOff = ERROR_POSE_HEIGHT;

  _nCurX = _nHelixCenterX;
  _nCurY = _nHelixCenterY;
}

inline bool CCharacter::IsResource()
{
  return _eChaCtrlType >= enumCHACTRL_MONS_TREE && _eChaCtrlType <= enumCHACTRL_MONS_DBOAT;
}

inline CSceneItem* CCharacter::GetHandItem(int nEquipPos)
{
  if(nEquipPos < 0 || nEquipPos >= enumEQUIP_NUM) return NULL;

  return _pHandItem[nEquipPos];
}

inline int CCharacter::GetTargetDistance()
{
  if(_isArrive)
	return 0;
  else
	return GetDistance(_nCurX, _nCurY, _nTargetX, _nTargetY);
}

inline void CCharacter::setChaCtrlType(int type)
{
  _eChaCtrlType = (EChaCtrlType)type;
  switch(type)
  {
  case enumCHACTRL_NONE: _nDanger = 0; break;
  case enumCHACTRL_PLAYER: _nDanger = 1; break;
  case enumCHACTRL_NPC: _nDanger = 2; break;

  case enumCHACTRL_NPC_EVENT: _nDanger = 7; break;
  case enumCHACTRL_MONS_TREE: _nDanger = 7; break;
  case enumCHACTRL_MONS_MINE: _nDanger = 7; break;
  case enumCHACTRL_MONS_FISH: _nDanger = 7; break;
  case enumCHACTRL_MONS_DBOAT: _nDanger = 7; break;

  case enumCHACTRL_PLAYER_PET: _nDanger = 8; break;
  case enumCHACTRL_MONS_REPAIRABLE: _nDanger = 9; break;

  case enumCHACTRL_MONS: _nDanger = 10; break;
  default: _nDanger = 0; break;
  }
}
