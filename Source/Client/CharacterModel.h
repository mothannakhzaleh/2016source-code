#pragma once

// CharacterModel 为直接与LECharacter打交道的类
// 它的主要作用包含模型的创建, 与外形有关的所有操作接口
// 以及相关数据的保存, 同时也有动作的播放和管理
// Character将继承CharacterModel
// Character将保持纯游戏逻辑数据相关
// 其继承关系为:

// CCharacter: public CCharacterModel, public CActor
// 此类的主要负责人为Jack Li

// 它对外提供的接口包括

// Load(类型ID)

// ChangePart(PartInfo)

// PlayPose(PoseID, LoopFlag)

// AttachItem(道具ID, 部位标记)

// AttachEffect(EffectID, 部位标记)

/*
	dummy_0		脚基座
	dummy_1		头顶
	dummy_2		胸部
	dummy_3		丹田
	dummy_4		左肩
	dummy_5		左臂
	dummy_6		左手
	dummy_7		右肩
	dummy_8		右臂
	dummy_9		右手
	dummy_10	左腿
	dummy_11	左膝
	dummy_12	左脚
	dummy_13	右腿
	dummy_14	右膝
	dummy_15	右脚
*/

enum
{
  LINK_ID_BASE			= 0,
  LINK_ID_HEAD			= 1,
  LINK_ID_CHEST			= 2,
  LINK_ID_PELVIS		= 3,
  LINK_ID_LEFTCLAVICLE	= 4,
  LINK_ID_LEFTARM		= 5,
  LINK_ID_LEFTHAND		= 6,
  LINK_ID_RIGHTCLAVICLE = 7,
  LINK_ID_RIGHTARM		= 8,
  LINK_ID_RIGHTHAND		= 9,
  LINK_ID_LEFTTHIGH		= 10,
  LINK_ID_LEFTCALF		= 11,
  LINK_ID_LEFTFOOT		= 12,
  LINK_ID_RIGHTTHIGH	= 13,
  LINK_ID_RIGHTCALF		= 14,
  LINK_ID_RIGHTFOOT		= 15,

  LINK_ID_NUM = 24,
};

class CSceneItem;
struct ItemLinkInfo
{
  CSceneItem* obj;
  DWORD		  link_item_id;
  DWORD		  link_parent_id;
  DWORD		  data;
};

class MPDrunkCtrl
{
  private:
  LESceneItem* dummy_obj;
  LECharacter* cha_obj;
  drMatrix44   cha_mat_save;
  drMatrix44   cha_mat;

  public:
  MPDrunkCtrl() :
	  dummy_obj(0), cha_obj(0)
  {}
  ~MPDrunkCtrl()
  {
	DR_SAFE_DELETE(dummy_obj);
  }
  BOOL CreateDrunkDummy(const char* file)
  {
	dummy_obj = DR_NEW(LESceneItem);
	dummy_obj->Load(file);
	dummy_obj->PlayDefaultAnimation();
	return 1;
  }
  void Attach(LECharacter* cha)
  {
	if(cha)
	{
	  cha_obj	   = cha;
	  cha_mat_save = *cha_obj->GetMatrix();
	  cha_mat	   = *cha_obj->GetMatrix();
	  dummy_obj->PlayObjImpPose(ANIM_CTRL_TYPE_MAT, 0, PLAY_LOOP);
	}
  }
  LECharacter* Detach()
  {
	if(cha_obj == 0)
	  return 0;

	//cha_obj->SetMatrix(&cha_mat_save);
	LECharacter* cha = cha_obj;
	cha_obj			 = 0;
	return cha;
  }
  void UpdateChaMatrix()
  {
	cha_mat = *cha_obj->GetMatrix();
  }
  void Update()
  {
	if(cha_obj)
	{
	  drMatrix44 mat;
	  dummy_obj->FrameMove();
	  drMatrix44* rot_mat = dummy_obj->GetObject()->GetPrimitive()->GetRenderCtrlAgent()->GetGlobalMatrix();
	  //drMatrix44Multiply(&mat, rot_mat, &cha_mat_save);
	  cha_obj->UpdateYawPitchRoll();
	  drMatrix44Multiply(&mat, rot_mat, cha_obj->GetMatrix());
	  cha_obj->SetMatrix(&mat);
	}
  }
};

class CCharacterModel : public LECharacter
{
  public:
  enum
  {
	MODEL_INVALID	= 0,
	MODEL_CHARACTER = 1,
	MODEL_WARSHIP	= 2,
	MODEL_TOWER		= 3,
  };

  protected:
  DWORD		  _ModelType;
  CSceneItem* _LinkItem[LINK_ID_NUM];

  float _UIScaleDis;
  int	_UIYaw;
  int	_UIPitch;
  BYTE	_UIColor[3]; // r, g, b

  DWORD				 _TypeID; // 人，船，炮塔类型判断
  DWORD				 _BoneID;
  DWORD				 _PartID[8];
  const char*		 _PartFile[8];
  DWORD				 _ShipType; //攻击船，运输船类型判断
  DWORD				 _SmallPoseID;
  DWORD				 _PoseType;
  DWORD				 _PoseTabID;
  D3DMATERIALX		 _mtl;
  drPoseKeyFrameProc _KeyFrameProc;
  void*				 _ProcParam;
  BOOL				 _EmiColor;

  BOOL		   _DrunkState;
  MPDrunkCtrl* _DrunkCtrl;

  BYTE _color[3];

  private:
  int	GetBoatPart(int dummy);
  DWORD _BigPose2SmallPose(DWORD pose_id);
  int	cha_type_id;

  public:
  CCharacterModel();
  ~CCharacterModel()
  {
	DR_SAFE_DELETE(_DrunkCtrl);
  }

  void FrameMove();
  void Render();
  void RenderForUI(int x, int y, bool bShowLingItem = true);
  void RenderUI(int x, int y);

  void		  Destroy();
  virtual int LoadCha(DWORD type_id, DWORD bone_id, const DWORD* part_buf);
  virtual int LoadCha(const LEChaLoadInfo* info);
  virtual int ChangePart(DWORD id, const char* file);
  virtual int ChangePart(DWORD part_id, DWORD tab_id);
  virtual int ChangePart(DWORD tab_id);
  virtual int ReCreate(DWORD type_id);
  virtual int LoadPart(DWORD part_id, const char* file);
  virtual int LoadPart(DWORD part_id, DWORD id);
  int		  LoadPose();
  virtual int DestroyPart(DWORD id);
  virtual int LoadShip(DWORD type_id, DWORD ship_type, DWORD* part_buf);
  virtual int LoadShip(DWORD type_id, DWORD* part_buf);
  virtual int LoadTower(DWORD type_id, DWORD* part_buf);

  int	LoadPose(int cha_type);
  void	PlayPose(DWORD pose, DWORD type = PLAY_ONCE, int time = -1, int fps = 32, DWORD blend_flag = 1, DWORD blend_src_num = 5); // LoopSpeed,多少毫秒Pose循环一次
  void	PlayPose(const MPPlayPoseInfo* info);
  void	PlayPosePause();
  void	PlayPoseContinue();
  DWORD GetCurPoseID();	  // 实际的pose ， 小pose
  DWORD GetCurPoseType(); // pose的类型, 参考 enum EActionNumber

  int IsPosePlaying(DWORD pose);
  int IsCurPosePlaying();

  // link_id:参考上面的LINK_ID_XXX; obj:道具对象，需要先通过Scene->AddSceneItem，
  // part_type：人物为-1，船只为部位索引
  int		  AttachItem(DWORD link_id, CSceneItem* obj, DWORD part_type, DWORD item_link_id = 0);
  int		  AttachItem(DWORD link_id, const ItemLinkInfo* info);
  CSceneItem* DetachItem(CSceneItem* obj);
  CSceneItem* DetachItem(DWORD link_id);
  CSceneItem* GetLinkItem(DWORD link_id) { return link_id < 0 || link_id >= LINK_ID_NUM ? 0 : _LinkItem[link_id]; }

  void	SetModelType(DWORD type) { _ModelType = type; }
  DWORD GetModelType() const { return _ModelType; }

  void SetUIScaleDis(float dis) { _UIScaleDis = dis; }
  void SetUIYaw(int angle) { _UIYaw = angle; }
  void SetUIPitch(int angle) { _UIPitch = angle; }
  void SetUIColor(BYTE r, BYTE g, BYTE b)
  {
	_UIColor[0] = r;
	_UIColor[1] = g;
	_UIColor[2] = b;
  }

  DWORD GetTypeID() const { return _TypeID; }
  DWORD GetPartID(DWORD id) const { return _PartID[id]; }
  DWORD GetShipType() const { return _ShipType; }
  void	SetShipType(DWORD type) { _ShipType = type; }

  HRESULT GetObjDummyRunTimeMatrix(MPMatrix44* mat, DWORD dummy_id, int type = -1);

  void	SetAmbColor(BYTE r, BYTE g, BYTE b);
  void	SetColor(BYTE r, BYTE g, BYTE b);
  void	SetOpaque(float opaque);
  float GetOpaque() const { return _mtl.Ambient.a; }
  void	GetColor(BYTE* buf3)
  {
	buf3[0] = _color[0];
	buf3[1] = _color[1];
	buf3[2] = _color[2];
  }

  void		   SetPoseKeyFrameProc(drPoseKeyFrameProc proc, void* proc_param);
  DWORD		   GetCurPoseKeyFrameNum();
  MPIPoseCtrl* GetPoseCtrl();
  MPPoseInfo*  GetPoseInfo(DWORD pose_id);
  MPPoseInfo*  GetPoseInfoBig(DWORD big_pose_id);
  float		   GetPoseVelocity(); // 数值越大越快, default: 1.0f
  void		   SetEmiColorFLag(BOOL flag) { _EmiColor = flag; }
  BOOL		   GetEmiColorFlag() { return _EmiColor; }

  int  Unlit(DWORD part_id);
  int  Lit(DWORD part_id, DWORD lit_id);
  BOOL Cull();
  BOOL SetDrunkState(BOOL flag);
  BOOL GetDrunkState() { return _DrunkState; }
  void UpdateChaMatrix() { _DrunkCtrl->UpdateChaMatrix(); }

  void SetPoseVelocity(float velocity);
};

inline int CCharacterModel::GetBoatPart(int dummy)
{
  switch(dummy)
  {
  case 0:
  case 1:
	return 1;
	break;
  case 2:
  case 3:
  case 7:
	return 0;
	break;
  case 4:
  case 5:
  case 6:
	return 2;
  default: return 0;
  }
}
inline HRESULT CCharacterModel::GetObjDummyRunTimeMatrix(MPMatrix44* mat, DWORD dummy_id, int type)
{
  if(_ModelType == MODEL_CHARACTER)
  {
	return LECharacter::GetObjDummyRunTimeMatrix(mat, dummy_id);
  } else if(_ModelType == MODEL_WARSHIP)
  {
	if(type < 0)
	  return LECharacter::GetObjDummyRunTimeMatrix(mat, GetBoatPart(dummy_id), dummy_id);
	else
	  return LECharacter::GetObjDummyRunTimeMatrix(mat, 0, dummy_id);
  } else if(_ModelType == MODEL_TOWER)
  {
	const int id[8] =
		{
			1, 2, 1, 0, 0, 0, 0, 0};

	if(dummy_id >= 8)
	{
	  //LG("error", "msgInvalid dummy id called GetObjDummyRunTimeMatrix");
	  return -1;
	}

	return LECharacter::GetObjDummyRunTimeMatrix(mat, id[dummy_id], dummy_id);
  } else
  {
	return -1;
  }
}

inline DWORD CCharacterModel::GetCurPoseType()
{
  return _PoseType;
}
