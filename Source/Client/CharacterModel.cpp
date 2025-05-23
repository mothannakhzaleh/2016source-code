#include "Stdafx.h"
//#include "CharacterSet.h"
#include "CharacterAction.h"
#include "CharacterPoseSet.h"
#include "CharacterModel.h"
#include "SceneItem.h"
#include "EffectObj.h"
#include "ItemRecord.h"
#include "CharacterRecord.h"
#include "LitLoad.h"
#include "RenderStateMgr.h"
#include "GameApp.h"
#include "CPerformance.h"

enum
{
  S_MELEE  = 0, // 单手近战 空手，拳套，钱袋
  S_MELEE2 = 1, // 单手近战 长刀，长剑，剑盾，杖
  D_MELEE  = 2, // 双手近战
  D_WEAPON = 3, // 双手武器
  S_GUN	   = 4, // 单手持枪
  D_BOW	   = 5, // 双手弓箭
  S_DAGGER = 6, // 匕首
};

enum
{
  LINK_ITEM_NULL	  = 0,	// 空
  LINK_ITEM_SWORD	  = 1,	// 剑
  LINK_ITEM_HUGESWORD = 2,	// 巨剑
  LINK_ITEM_BOW		  = 3,	// 弓
  LINK_ITEM_GUN		  = 4,	// 枪
  LINK_ITEM_BLADE	  = 5,	// 刀
  LINK_ITEM_GLOVE	  = 6,	// 拳套
  LINK_ITEM_DAGGER	  = 7,	// 匕首
  LINK_ITEM_BURSE	  = 8,	// 钱包
  LINK_ITEM_STICK	  = 9,	// 短棒
  LINK_ITEM_HAMMER	  = 10, // 锤
  LINK_ITEM_SHIELD	  = 11, // 盾
  LINK_ITEM_AX		  = 18, //斧头
  LINK_ITEM_SHOVEL	  = 19, //铁锹
};

struct wield_state
{
  BYTE mode;
  BYTE left;
  BYTE right;

  wield_state(BYTE m, BYTE l, BYTE r) :
	  mode(m), left(l), right(r)
  {}

  inline int Check(BYTE l, BYTE r) const { return (left == l && right == r); }
};

const static int		 __wield_state_num = 15;
const static wield_state __wield_state[__wield_state_num] =
	{
		wield_state(S_MELEE, LINK_ITEM_NULL, LINK_ITEM_BURSE),
		wield_state(S_MELEE, LINK_ITEM_NULL, LINK_ITEM_GLOVE),
		wield_state(S_MELEE, LINK_ITEM_SHIELD, LINK_ITEM_NULL),

		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_SWORD),
		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_BLADE),
		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_STICK),
		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_HAMMER),
		wield_state(S_MELEE2, LINK_ITEM_SHIELD, LINK_ITEM_SWORD),

		wield_state(D_MELEE, LINK_ITEM_NULL, LINK_ITEM_HUGESWORD),

		wield_state(D_WEAPON, LINK_ITEM_SWORD, LINK_ITEM_SWORD),

		wield_state(D_BOW, LINK_ITEM_BOW, LINK_ITEM_NULL),

		wield_state(S_GUN, LINK_ITEM_NULL, LINK_ITEM_GUN),

		wield_state(S_DAGGER, LINK_ITEM_NULL, LINK_ITEM_DAGGER),

		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_AX),
		wield_state(S_MELEE2, LINK_ITEM_NULL, LINK_ITEM_SHOVEL),

		//wield_state( D_WEAPON, LINK_ITEM_SWORD, LINK_ITEM_BLADE ),
		//wield_state( D_WEAPON, LINK_ITEM_SWORD, LINK_ITEM_DAGGER ),
		//wield_state( D_WEAPON, LINK_ITEM_BLADE, LINK_ITEM_BLADE ),
		//wield_state( D_WEAPON, LINK_ITEM_BLADE, LINK_ITEM_SWORD ),
		//wield_state( D_WEAPON, LINK_ITEM_BLADE, LINK_ITEM_DAGGER ),
		//wield_state( D_WEAPON, LINK_ITEM_DAGGER, LINK_ITEM_DAGGER ),
		//wield_state( D_WEAPON, LINK_ITEM_DAGGER, LINK_ITEM_SWORD ),
		//wield_state( D_WEAPON, LINK_ITEM_DAGGER, LINK_ITEM_BLADE ),

};

//#define DYNAMIC_LOADING

inline void _SetItemScale(CCharacterModel* model, CSceneItem* item)
{
  item->SetScale(model->GetScale());
}

// ==================================
CCharacterModel::CCharacterModel() :
	_TypeID(0), _ModelType(MODEL_INVALID), _PoseType(0), cha_type_id(-1)
{
  _UIScaleDis = 20.0f;
  _UIYaw	  = 0;
  _UIPitch	  = 0;
  _UIColor[0] = 255;
  _UIColor[1] = 255;
  _UIColor[2] = 255;

  _SmallPoseID = 0xffffffff;
  _PoseTabID   = 0xffffffff;
  _BoneID	   = 0;

  _KeyFrameProc = 0;
  _ProcParam	= 0;

  memset(_PartID, 0, sizeof(_PartID));
  memset(_LinkItem, 0, sizeof(_LinkItem));
  memset(&_mtl, 0, sizeof(_mtl));
  memset(_PartFile, 0, sizeof(_PartFile));

  _mtl.Ambient.a = _mtl.Ambient.r = _mtl.Ambient.g = _mtl.Ambient.b = 1.0f;
  _mtl.Diffuse														= _mtl.Ambient;

  _EmiColor = 0;

  _DrunkState = 0;
  _DrunkCtrl  = 0;

  _color[0] = _color[1] = _color[2] = 255;
}

void CCharacterModel::FrameMove()
{
#ifdef DYNAMIC_LOADING
  if(cha_type_id != -1 && IsLoaded())
  {
	LoadPose();
  }
#endif
  LECharacter::FrameMove();

  if(_DrunkCtrl)
  {
	_DrunkCtrl->Update();
  }
}
void CCharacterModel::Render()
{
  if(Cull())
	return;

  LECharacter::Render();

  _EmiColor = 0;
}
void CCharacterModel::Destroy()
{
  _PoseType		= 0;
  _ModelType	= MODEL_INVALID;
  _BoneID		= 0;
  _PoseTabID	= -1;
  _SmallPoseID	= -1;
  _KeyFrameProc = 0;
  _ProcParam	= 0;
  cha_type_id	= -1;
  memset(_PartID, 0, sizeof(_PartID));
  memset(_PartFile, 0, sizeof(_PartFile));

  LECharacter::Destroy();
}
int CCharacterModel::LoadCha(const LEChaLoadInfo* info)
{
  _ModelType = strlen(info->bone) > 0 ? MODEL_CHARACTER : MODEL_WARSHIP;

  if(strlen(info->bone) > 0)
  {
	StartLoad();
	//TInit
	//TBegin
	if(FAILED(LECharacter::LoadBone(info->bone)))
	  return 0;
	//TEnd
	for(DWORD i = 0; i < 8; i++)
	{
	  if(strlen(info->part[i]) == 0)
		continue;
	  //TBegin
	  if(FAILED(LoadPart(i, info->part[i])))
		return 0;
	  //TEnd
	}
	EndLoad();
  }
  //if( FAILED( LECharacter::Load( info ) ) )
  //{
  //    return 0;
  //}

  return 1;
}

int CCharacterModel::LoadCha(DWORD type_id, DWORD bone_id, const DWORD* part_buf)
{
  _TypeID	 = type_id;
  _ModelType = MODEL_CHARACTER;

  // load bone
  StartLoad();
  char str[260];
  _snprintf_s(str, _countof(str), _TRUNCATE, "%04d.lab", bone_id);
  if(FAILED(LoadBone(str)))
	return 0;

  _BoneID = bone_id;

  // load skin model
#ifdef _KOSDEMO_
  for(DWORD i = 0; i < 6; i++)
  {
	ChangePart(i, part_buf[i]);
  }
#else
  for(DWORD i = 0; i < 5; i++)
  {
	ChangePart(i, part_buf[i]);
  }
#endif

  EndLoad();
  return 1;
}

int CCharacterModel::LoadShip(DWORD type_id, DWORD ship_type, DWORD* part_buf)
{
  _TypeID	 = type_id;
  _ModelType = MODEL_WARSHIP;
  _ShipType	 = ship_type;

  StartLoad();
  ChangePart(0, part_buf[0]);
  ChangePart(1, part_buf[1]);
  ChangePart(2, part_buf[2]);
  EndLoad();
  return 1;
}
int CCharacterModel::LoadShip(DWORD type_id, DWORD* part_buf)
{
  _ModelType = MODEL_WARSHIP;
  _TypeID	 = type_id;
  _ShipType	 = 0;

  StartLoad();
  for(int i = 0; i < 8; i++)
  {
	if(part_buf[i] > 0)
	{
	  if(LoadPart(i, part_buf[i]) == 0)
		return 0;
	}
  }

  if(LoadPose(_TypeID) == 0)
	return 0;
  EndLoad();
  return 1;
}
int CCharacterModel::LoadTower(DWORD type_id, DWORD* part_buf)
{
  _TypeID	 = type_id;
  _ModelType = MODEL_TOWER;

  StartLoad();
  ChangePart(0, part_buf[0]);
  ChangePart(1, part_buf[1]);
  ChangePart(2, part_buf[2]);
  EndLoad();
  return 1;
}

int CCharacterModel::ReCreate(DWORD type_id)
{
  CChaRecord* pInfo = GetChaRecordInfo(type_id);

  if(!pInfo)
	return 0;

  if(pInfo->chModalType == enumMODAL_MAIN_CHA)
  {
#if 1 // 读id的表格
	DWORD part_buf[5] =
		{
			pInfo->sSkinInfo[0],
			pInfo->sSkinInfo[1],
			pInfo->sSkinInfo[2],
			pInfo->sSkinInfo[3],
			pInfo->sSkinInfo[4],
		};

	if(LoadCha(pInfo->chModalType, pInfo->sModel, part_buf) == 0)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_26), type_id, pInfo->szDataName);
	  return NULL;
	}
#endif
#if 0 // 读掩码的表格 \
	// 主角创建
		LEChaLoadInfo load_info;

		_snprintf_s( load_info.bone, _countof( load_info.bone ), _TRUNCATE, "%04d.lab", pInfo->sModel );        

		for( DWORD i = 0; i < 5; i++ )
		{
			if( pInfo->sSkinInfo[i] == 0 )
				continue;

			DWORD file_id = pInfo->sModel * 1000000 + pInfo->sSuitID * 10000 + i;
			_snprintf_s( load_info.part[i], _countof( load_info.part[i] ), _TRUNCATE, "%010d.lgo", file_id );
		}

		if( LoadCha( &load_info ) == 0 )
		{
			LG("error", RES_STRING(CL_LANGUAGE_MATCH_26), type_id, pInfo->szDataName);  
			return NULL;
		}
#endif
  } else if(pInfo->chModalType == enumMODAL_BOAT)
  {
	DWORD part_buf[3] =
		{
			pInfo->sSkinInfo[0],
			pInfo->sSkinInfo[1],
			pInfo->sSkinInfo[2],
		};

	if(LoadShip(pInfo->chModalType, pInfo->sModel, part_buf) == 0)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_26), type_id, pInfo->szDataName);
	  return NULL;
	}
  } else if(pInfo->chModalType == enumMODAL_EMPL)
  {
	DWORD part_buf[5] =
		{
			pInfo->sSkinInfo[0],
			pInfo->sSkinInfo[1],
			pInfo->sSkinInfo[2],
			pInfo->sSkinInfo[3],
		};

	if(LoadTower(pInfo->chModalType, part_buf) == 0)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_26), type_id, pInfo->szDataName);
	  return NULL;
	}
  } else
  {
	// 主角创建
	LEChaLoadInfo load_info;

	_snprintf_s(load_info.bone, _countof(load_info.bone), _TRUNCATE, "%04d.lab", pInfo->sModel);

#ifdef _KOSDEMO_
	for(DWORD i = 0; i < 6; i++)
#else
	for(DWORD i = 0; i < 5; i++)
#endif
	{
	  if(pInfo->sSkinInfo[i] == 0)
		continue;

	  DWORD file_id = pInfo->sModel * 1000000 + pInfo->sSuitID * 10000 + i;
	  _snprintf_s(load_info.part[i], _countof(load_info.part[i]), _TRUNCATE, "%010d.lgo", file_id);
	}

	if(LoadCha(&load_info) == 0)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_26), type_id, pInfo->szDataName);
	  return NULL;
	}
  }

  _PoseTabID = -1;

  if(LoadPose(type_id) == 0)
  {
	LG("error", RES_STRING(CL_LANGUAGE_MATCH_27), type_id, pInfo->szDataName);
	return NULL;
  }

  PlayPose(POSE_WAITING, PLAY_LOOP);

  return 1;
}
int CCharacterModel::LoadPart(DWORD part_id, DWORD id)
{
  if(_PartID[part_id] == id)
	return 1;

  char file[260];
  _snprintf_s(file, _countof(file), _TRUNCATE, "%010d.lgo", id);

  if(LoadPart(part_id, file) == 0)
	return 0;

  _PartID[part_id] = id;

  return 1;
}

int CCharacterModel::LoadPart(DWORD part_id, const char* file)
{
  if(FAILED(LECharacter::LoadPart(part_id, file)))
	return 0;

  Lit(part_id, 0);

  /*
	extern LitMgr g_lit_mgr;

	if(_ModelType == MODEL_CHARACTER)
	{
	D3DCAPSX* caps = g_Render.GetInterfaceMgr()->dev_obj->GetDeviceCaps();
	if(caps->MaxTextureBlendStages < 4 || caps->MaxSimultaneousTextures < 4)
	return 1;

	LitInfo* l = g_lit_mgr.Lit(0, 0, file);
	if(l == 0)
	return 1;

	MPIPrimitive* p = LECharacter::GetPhysique()->GetPrimitive(part_id);
	drPrimitiveTexLitA(p, l->str_buf[0], l->str_buf[1], ".\\texture\\lit\\", l->anim_type);
	//drPrimitiveTexLit(p, l->str_buf[0], ".\\texture\\lit\\");
	DWORD vst = p->GetRenderCtrlAgent()->GetVertexShader();
	DWORD new_vst;
	switch(vst)
	{
	case VST_PU4NT0_LD:
	new_vst = VSTU_SKINMESH0_TT3;
	break;
	case VST_PB1U4NT0_LD:
	new_vst = VSTU_SKINMESH1_TT3;
	break;
	default:
	MessageBox(NULL,"Crash, call jack", 0, 0);
	}

	drPrimitiveSetVertexShader(p, new_vst);
	}*/

  return 1;
}

int CCharacterModel::ChangePart(DWORD tab_id)
{
  if(_ModelType != MODEL_CHARACTER)
  {
	return 0;
  }

  CItemRecord* ir = GetItemRecordInfo(tab_id);
  if(!ir)
  {
	LG("xXx", "invalid table id");
	return 0;
  }

  DWORD id_id[][2] =
	  {
		  {20, 1},
		  {21, 0},
		  {22, 2},
		  {23, 3},
		  {24, 4},
	  };
  DWORD i;
#ifdef _KOSDEMO_
  for(i = 0; i < 6; i++)
  {
	if(ir->sType == id_id[i][0])
	  break;
  }
  if(i == 6)
  {
	return 0;
  }
#else
  for(i = 0; i < 5; i++)
  {
	if(ir->sType == id_id[i][0])
	  break;
  }
  if(i == 5)
  {
	return 0;
  }
#endif

  return ChangePart(id_id[i][1], tab_id);
}

int CCharacterModel::ChangePart(DWORD part_id, DWORD tab_id)
{
  //if(_PartID[part_id] == tab_id)
  //    return 1;

  CItemRecord* ir = GetItemRecordInfo(tab_id);
  if(!ir) return 0;

  char* sx = 0;

#ifdef _KOSDEMO_
  DWORD file_id;
#endif

  switch(_ModelType)
  {
  case MODEL_CHARACTER:
	// 有问题，找robin
#ifdef _KOSDEMO_
	if(part_id < 6)
	{
	  file_id = _BoneID * 1000000 + part_id;
	  if(part_id == 3 && !(strcmp(ir->chModule[1], "500000000")))
	  {
		sx = ir->chModule[1];
	  } else
	  {
		sx = new char[16];
		_snprintf_s(sx, size_t(16), _TRUNCATE, "%010d", file_id);
	  }
	} else
	{
	  sx = ir->chModule[1];
	}
#else
	sx = ir->chModule[_BoneID + 1];
#endif
	break;
  case MODEL_WARSHIP:
	sx = ir->chModule[0];
	break;
  case MODEL_TOWER:
	sx = ir->chModule[0];
	break;
  default:
	return 0;
  }

  if(strcmp(sx, "0") == 0)
  {
	LG("xXx", "msgLoadPart error with Invalid ID: %d, call robin!", tab_id);
	return 0;
  }

  if(sx == _PartFile[part_id])
	return 1;

  char str[260];
  _snprintf_s(str, _countof(str), _TRUNCATE, "%s.lgo", sx);
  if(FAILED(LoadPart(part_id, str)))
  {
	LG("xXx", "msgLoadPart Failed with file: %s, call sean!", str);
	return 0;
  }

  if(_ModelType == MODEL_WARSHIP)
  {
	if(part_id == 0)
	{
	  //if(ir->sShipFlag > 0)
	  //{
	  //	// logo
	  //	ir = GetItemRecordInfo( ir->sShipFlag );
	  //	_snprintf_s( str, _countof( str ), _TRUNCATE,  "%s.lgo", ir->chModule[0] );
	  //	LoadPart( 3, str );

	  //	_PartID[ 3 ] = ir->sShipFlag;
	  //}

	} else if(part_id == 2)
	{
	  // 螺旋桨!!!
	  for(DWORD i = 0; i < 4; i++)
	  {
		DestroyPart(4 + i);

		DWORD o = atoi(ir->chModule[i + 1]);
		if(o == 0)
		  continue;
		CItemRecord* iiir = GetItemRecordInfo(o);
		if(iiir == 0 || iiir->chModule[0] == 0)
		{
		  LG("xXx", "msgLoadPart no model file exists: %d, call robin", o);
		  return 0;
		}

		_snprintf_s(str, _countof(str), _TRUNCATE, "%s.lgo", iiir->chModule[0]);

		if(FAILED(LoadPart(4 + i, str)))
		{
		  LG("xXx", "msgLoadPart no model file: %s, call sean!", str);
		  return 0;
		}

		_PartID[4 + i] = o;
	  }
	}
  }

  if(_PoseTabID != 0xffffffff)
  {
	if((_ModelType == MODEL_WARSHIP && part_id == 0) ||
	   (_ModelType == MODEL_TOWER && part_id == 1))
	{
	  //需要重新load pose
	  LoadPose(_PoseTabID);
	  SetPoseKeyFrameProc(_KeyFrameProc, _ProcParam);
	  CCharacterModel::PlayPose(POSE_WAITING, PLAY_LOOP);
	}
  }

  _PartID[part_id]	 = tab_id;
  _PartFile[part_id] = sx;

  return 1;
}

int CCharacterModel::LoadPose(int cha_type)
{
#ifdef DYNAMIC_LOADING
  cha_type_id = cha_type;
  return 1;
}

int CCharacterModel::LoadPose()
{
  int cha_type = cha_type_id;
  cha_type_id  = -1;
#endif

  MPPoseInfo*  buf;
  MPPoseInfo*  p;
  SActionInfo* s;
  MPIPoseCtrl* pose_ctrl;
  DWORD		   num;

  pose_ctrl = GetPoseCtrl();

  if(pose_ctrl == 0)
	return 0;

  if(pose_ctrl->GetPoseNum() > 1)
	return 1;

  SCharacterAction SCharAct;
  if(false == GetCharacterAction(cha_type, &SCharAct)) // 没有在文件中找到对应的ID
  {
	LG("default", "msgInvalid LoadPose call");
	return 0;
  }

  num = SCharAct.m_iMaxActionNum;
  buf = new MPPoseInfo[num];

  for(DWORD i = 0; i < num; i++)
  {
	s = &SCharAct.m_SActionInfo[i];

	if(s->m_sActionNO < 1)
	  continue;

	p  = &buf[i];
	*p = s->info;
  }

  MPIPoseCtrl* c = GetPoseCtrl();
  if(c)
  {
	if(DR_FAILED(c->InsertPose(c->GetPoseNum(), buf, num)))
	{
	  LG("error", "msgCharacter Insert Pose Error: %d", cha_type);
	  return 0;
	}
  }

  _PoseTabID = cha_type;

  //delete[] buf;
  //buf = 0;
  SAFE_DELETE_ARRAY(buf); // UI当机处理

  // if this object is main character, then we use pose bone matrices buffer
#if 1
  if(_TypeID == 1)
  {
	MPIAnimCtrlAgent* anim_agent = GetPhysique()->GetAnimCtrlAgent();
	if(anim_agent)
	{
	  MPAnimCtrlObjTypeInfo type_info;
	  type_info.type					= ANIM_CTRL_TYPE_BONE;
	  type_info.data[0]					= DR_INVALID_INDEX;
	  type_info.data[1]					= DR_INVALID_INDEX;
	  MPIAnimCtrlObjBone* ctrl_obj_bone = (MPIAnimCtrlObjBone*)anim_agent->GetAnimCtrlObj(&type_info);
	  MPIAnimCtrlBone*	  ctrl_bone		= (MPIAnimCtrlBone*)ctrl_obj_bone->GetAnimCtrl();
	  MPIPoseCtrl*		  pc			= ctrl_bone->GetPoseCtrl();
	  MPPoseInfo*		  pi			= pc->GetPoseInfo(0);

	  ctrl_bone->CreateRunTimeDataBuffer();
	  for(DWORD i = pi->start; i <= pi->end; i++)
	  {
		ctrl_bone->EnableRunTimeFrameBuffer(i, 1);
	  }
	}
  }
#endif

  return 1;
}

int CCharacterModel::ChangePart(DWORD id, const char* file)
{
  return SUCCEEDED(LoadPart(id, file)) ? 1 : 0;
}

int CCharacterModel::DestroyPart(DWORD id)
{
  return SUCCEEDED(LECharacter::DestroyPart(id)) ? 1 : 0;
}

DWORD CCharacterModel::_BigPose2SmallPose(DWORD pose_id)
{
  DWORD p	= 0;
  _PoseType = pose_id;

  CItemRecord* ir;

  int		 iii  = 0;
  CPoseInfo* info = ::GetPoseInfo((short)pose_id);
  if(info == NULL)
  {
	LG("pose_id", RES_STRING(CL_LANGUAGE_MATCH_28), pose_id);
	return -1;
  }

  CSceneItem* left_item	 = GetLinkItem(LINK_ID_LEFTHAND);
  CSceneItem* right_item = GetLinkItem(LINK_ID_RIGHTHAND);

  BYTE l = 0;
  BYTE r = 0;

  if(left_item)
  {
	ir = left_item->GetItemInfo();
	l  = (BYTE)ir->sType;
  }
  if(right_item)
  {
	ir = right_item->GetItemInfo();
	r  = (BYTE)ir->sType;
  }

  for(DWORD i = 0; i < __wield_state_num; i++)
  {
	if(__wield_state[i].Check(l, r) == 1)
	{
	  iii = __wield_state[i].mode;
	  break;
	}
  }

  p = info->sRealPoseID[iii];

  return p;
}

void CCharacterModel::PlayPose(DWORD pose, DWORD type, int time, int fps, DWORD blend_flag, DWORD blend_src_num)
{
  DWORD p	= 0;
  _PoseType = pose;

  p = _BigPose2SmallPose(pose);

  if(p == -1)
	return;

  _SmallPoseID = p;

  MPIPoseCtrl* c = GetPoseCtrl();
  if(c == 0)
  {
	//LG("error", "msgCCharacterModel::PlayPose GetPoseCtrl() error with:\n type: %d, pose:%d, SmallPoseID:%d", _TypeID, pose, _SmallPoseID );
	return;
  }

  MPPoseInfo* pi = c->GetPoseInfo(_SmallPoseID);
  if(pi == 0)
  {
	//LG("error", "msgCCharacterModel::PlayPose GetPoseInfo() error with:\n type: %d, pose:%d, SmallPoseID:%d", _TypeID, pose, _SmallPoseID);
	return;
  }
  if(pi->end - pi->start <= 0)
  {
	//LG("pose", "msgpose[%d]-小pose[%d],动作帧[%d, %d]非法\n", pose, _SmallPoseID, pi->start, pi->end );
	return;
  }

  float velocity = 1.0f;
  if(time > 0)
  {
	float v	 = 1000.0f / (float)fps / ((float)time / (float)(pi->end - pi->start));
	velocity = v;
  } else
  {
	float v = 30.0f / (float)fps;

	velocity = v;
  }

  switch(_ModelType)
  {
  case MODEL_CHARACTER:
	if(FAILED(LECharacter::PlayPose(p, type, 0.0f, velocity, blend_flag, blend_src_num)))
	{
	  //LG("xXx","msgPlay[CHARACTER:%d] pose error:%d, type:%d\n", _TypeID, p, _TypeID);
	}
	break;
  case MODEL_WARSHIP: //船只只有obj_0有外部pose，其余部分都为default pose
	if(FAILED(LECharacter::PlayObjImpPose(0, ANIM_CTRL_TYPE_MAT, p, type, 0.0f, velocity)))
	{
	  //LG("xXx","msgPlay[SHIP] pose error:%d, type:%d\n", p, _TypeID);
	}

	LECharacter::PlayObjImpPose(1, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(2, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(3, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(4, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(5, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(6, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(7, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);

	//LECharacter::PlayObjImpPose( 3, ANIM_CTRL_TYPE_TEXTURE0, 0, type, 0.0f, 1.0f );
	//LECharacter::PlayObjImpPose( 3, ANIM_CTRL_TYPE_TEXTURE1, 0, type, 0.0f, 1.0f );
	//LECharacter::PlayObjImpPose( 3, ANIM_CTRL_TYPE_TEXTURE2, 0, type, 0.0f, 1.0f );
	//LECharacter::PlayObjImpPose( 3, ANIM_CTRL_TYPE_TEXTURE3, 0, type, 0.0f, 1.0f );
	break;
  case MODEL_TOWER: //炮塔只有obj_1有外部定义的pose，其余部分都为default pose
	LECharacter::PlayObjImpPose(0, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(1, ANIM_CTRL_TYPE_MAT, p, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(2, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	LECharacter::PlayObjImpPose(3, ANIM_CTRL_TYPE_MAT, 0, type, 0.0f, velocity);
	break;
  default:;
  }
}

void CCharacterModel::PlayPose(const MPPlayPoseInfo* info)
{
  if(_ModelType != MODEL_CHARACTER)
  {
	LECharacter::PlayObjImpPose(0, ANIM_CTRL_TYPE_MAT, info);
	LECharacter::PlayObjImpPose(1, ANIM_CTRL_TYPE_MAT, info);
	LECharacter::PlayObjImpPose(2, ANIM_CTRL_TYPE_MAT, info);
	LECharacter::PlayObjImpPose(3, ANIM_CTRL_TYPE_MAT, info);
  } else
  {
	LECharacter::PlayPose(info);
  }
}
void CCharacterModel::SetPoseVelocity(float velocity)
{
  MPPlayPoseInfo ppi;
  ppi.bit_mask = PPI_MASK_VELOCITY;
  ppi.velocity = velocity;

  PlayPose(&ppi);
}

void CCharacterModel::PlayPosePause()
{
  MPPlayPoseInfo info;
  info.bit_mask = PPI_MASK_TYPE;
  info.type		= PLAY_PAUSE;
  CCharacterModel::PlayPose(&info);
}
void CCharacterModel::PlayPoseContinue()
{
  MPPlayPoseInfo info;
  info.bit_mask = PPI_MASK_TYPE;
  info.type		= PLAY_CONTINUE;
  CCharacterModel::PlayPose(&info);
}

int CCharacterModel::AttachItem(DWORD link_id, const ItemLinkInfo* info)
{
  if(link_id < 0 || link_id >= LINK_ID_NUM)
	return 0;

  if(_LinkItem[link_id])
  {
	DetachItem(link_id);
  }

  LEItemLinkInfo i;
  i.data		   = info->data;
  i.link_item_id   = info->link_item_id;
  i.link_parent_id = info->link_parent_id;
  i.obj			   = info->obj;

  if(FAILED(LECharacter::AttachItem(&i)))
  {
	return 0;
  }

  info->obj->setAttachedCharacterID(_TypeID);
  _LinkItem[link_id] = info->obj;

  _SetItemScale(this, info->obj);

  // added by clp
  info->obj->setParentCharacter(this);
  info->obj->setParentDummy(info->link_parent_id);

  return 1;
}

int CCharacterModel::AttachItem(DWORD link_id, CSceneItem* obj, DWORD part_type, DWORD item_link_id)
{
  ItemLinkInfo info;
  info.obj			  = obj;
  info.data			  = part_type;
  info.link_item_id	  = item_link_id;
  info.link_parent_id = link_id;

  if(AttachItem(link_id, &info) == 0)
  {
	LG("error", "msgType: %s, link_id: %d, item_id: %d", obj->GetItemInfo()->szName, link_id, item_link_id);
	return 0;
  }
  return 1;
}

CSceneItem* CCharacterModel::DetachItem(CSceneItem* obj)
{
  CSceneItem* ret_obj = NULL;

  for(DWORD i = 0; i < LINK_ID_NUM; i++)
  {
	if(_LinkItem[i] && _LinkItem[i] == obj)
	{
	  ret_obj = _LinkItem[i];
	  _LinkItem[i]->GetObject()->ClearLinkCtrl();
	  // added by clp
	  _LinkItem[i]->setParentCharacter(NULL);
	  _LinkItem[i]->unbindEffect();

	  _LinkItem[i] = 0;
	  break;
	}
  }

  return ret_obj;
}

CSceneItem* CCharacterModel::DetachItem(DWORD link_id)
{
  CSceneItem* ret_obj = NULL;

  if(link_id < 0 || link_id >= LINK_ID_NUM)
	return 0;

  if(_LinkItem[link_id] == 0)
	return 0;

  ret_obj = _LinkItem[link_id];
  _LinkItem[link_id]->GetObject()->ClearLinkCtrl();
  // added by clp
  _LinkItem[link_id]->setParentCharacter(NULL);
  _LinkItem[link_id]->unbindEffect();

  //_LinkItem[link_id]->SetValid( 0 );
  _LinkItem[link_id] = 0;

  return ret_obj;
}

DWORD CCharacterModel::GetCurPoseID()
{
  if(_ModelType == MODEL_CHARACTER)
  {
	MPPlayPoseInfo* info = LECharacter::GetPlayPoseInfo();
	return info ? info->pose : -1;
  } else
  {
	MPPlayPoseInfo* info = LECharacter::GetObjImpPlayPoseInfo(0, ANIM_CTRL_TYPE_MAT);
	return info ? info->pose : -1;
  }
}

int CCharacterModel::IsPosePlaying(DWORD pose)
{
  if(_ModelType == MODEL_CHARACTER)
  {
	MPPlayPoseInfo* info = LECharacter::GetPlayPoseInfo();
	MPIPoseCtrl*	ctrl = LECharacter::GetPoseCtrl();
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else if(_ModelType == MODEL_WARSHIP)
  {
	MPPlayPoseInfo* info = LECharacter::GetObjImpPlayPoseInfo(0, ANIM_CTRL_TYPE_MAT);
	MPIPoseCtrl*	ctrl = LECharacter::GetObjImpPoseCtrl(0, ANIM_CTRL_TYPE_MAT);
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else if(_ModelType == MODEL_TOWER)
  {
	MPPlayPoseInfo* info = LECharacter::GetObjImpPlayPoseInfo(1, ANIM_CTRL_TYPE_MAT);
	MPIPoseCtrl*	ctrl = LECharacter::GetObjImpPoseCtrl(1, ANIM_CTRL_TYPE_MAT);
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else
  {
	return 0;
  }
}

int CCharacterModel::IsCurPosePlaying()
{
  DWORD pose = _SmallPoseID;

  if(_ModelType == MODEL_CHARACTER)
  {
	MPPlayPoseInfo* info = LECharacter::GetPlayPoseInfo();
	MPIPoseCtrl*	ctrl = LECharacter::GetPoseCtrl();
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else if(_ModelType == MODEL_WARSHIP)
  {
	MPPlayPoseInfo* info = LECharacter::GetObjImpPlayPoseInfo(0, ANIM_CTRL_TYPE_MAT);
	MPIPoseCtrl*	ctrl = LECharacter::GetObjImpPoseCtrl(0, ANIM_CTRL_TYPE_MAT);
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else if(_ModelType == MODEL_TOWER)
  {
	MPPlayPoseInfo* info = LECharacter::GetObjImpPlayPoseInfo(1, ANIM_CTRL_TYPE_MAT);
	MPIPoseCtrl*	ctrl = LECharacter::GetObjImpPoseCtrl(1, ANIM_CTRL_TYPE_MAT);
	if(info == 0 || info->pose != pose)
	  return 0;

	return ctrl->IsPosePlaying(info);
  } else
  {
	return 0;
  }
}

void CCharacterModel::RenderForUI(int x, int y, bool bShowLingItem /*= true*/)
{
  // _nUIScale;
  // _nYaw;
  D3DXVECTOR3 org, ray;

  g_Render.SetCurrentView(LERender::VIEW_3DUI);
  g_Render.GetPickRayVector(x, y, &org, &ray);

  D3DXVECTOR3 pos;
  D3DXMATRIX  mat_inv;
  g_Render.GetInvViewMatrix(&mat_inv);

  pos = *(D3DXVECTOR3*)&mat_inv._41;
  //pos += ray * (float)_UIScaleDis;
  pos += ray * 2.0f;

  SetYaw(_UIYaw * D3DX_PI / 180.0f);
  SetRoll(_UIPitch * D3DX_PI / 180.0f);
  UpdateYawPitchRoll();
  SetPos(&pos.x);

  drMatrix44Scale(LECharacter::GetMatrix(), 1.0f / (float)_UIScaleDis);

  //g_Render.SetRenderState(D3DRS_ZENABLE,      1);
  //g_Render.SetRenderState(D3DRS_ZWRITEENABLE, 1);
  //g_Render.SetRenderState(D3DRS_ZFUNC, D3DCMP_LESSEQUAL );
  g_Render.SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);
  g_Render.SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);

  DWORD rs_amb;
  g_Render.GetRenderState(D3DRS_AMBIENT, &rs_amb);
  g_Render.SetRenderState(D3DRS_AMBIENT, 0xffffffff);

  DWORD rs_light;
  g_Render.GetRenderState(D3DRS_LIGHTING, &rs_light);
  g_Render.SetRenderState(D3DRS_LIGHTING, 0);

  //g_Render.SetRenderState(D3DRS_ZBIAS, 16 );

  SetColor(_UIColor[0], _UIColor[1], _UIColor[2]);

  LECharacter::FrameMove();

  if(bShowLingItem)
  {
	LESceneItem* pLItem = GetLinkItem(6);
	if(pLItem)
	{
	  pLItem->FrameMove();
	}
	LESceneItem* pRItem = GetLinkItem(9);
	if(pRItem)
	{
	  pRItem->FrameMove();
	}

	if(pLItem) pLItem->Render();
	if(pRItem) pRItem->Render();
  }

  LECharacter::Render();

  RenderStateMgr* rsm = g_pGameApp->GetRenderStateMgr();

  rsm->BeginTranspObject();
  drUpdateSceneTransparentObject();
  rsm->EndTranspObject();

  g_Render.SetRenderState(D3DRS_AMBIENT, rs_amb);
  g_Render.SetRenderState(D3DRS_LIGHTING, rs_light);
  //g_Render.SetRenderState(D3DRS_ZENABLE,      0);
  //g_Render.SetRenderState(D3DRS_ZWRITEENABLE, 0);
  //g_Render.SetRenderState(D3DRS_ZFUNC, D3DCMP_LESSEQUAL );
  //g_Render.SetRenderState(D3DRS_ZBIAS, 0 );

  g_Render.SetCurrentView(LERender::VIEW_WORLD);
}
void CCharacterModel::RenderUI(int x, int y)
{
  //D3DXVECTOR3 org, ray;

  //g_Render.SetCurrentView(LERender::VIEW_3DUI);
  //g_Render.GetPickRayVector( x, y, &org, &ray );

  //D3DXMATRIX mat_inv;
  //g_Render.GetInvViewMatrix( &mat_inv );

  //pos = *(D3DXVECTOR3*)&mat_inv._41;
  //pos += ray * 3.0f;

  //ray = D3DXVECTOR3(0,-1,0);
  //pos = org + ray * 2.0f;

  SetYaw(_UIYaw * D3DX_PI / 180.0f);
  UpdateYawPitchRoll();

  drMatrix44Scale(LECharacter::GetMatrix(), 1);

  g_Render.SetRenderState(D3DRS_ZENABLE, 1);
  g_Render.SetRenderState(D3DRS_ZWRITEENABLE, 1);
  g_Render.SetRenderStateForced(D3DRS_ZENABLE, 1);
  g_Render.SetRenderStateForced(D3DRS_ZWRITEENABLE, 1);

  g_Render.SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);
  g_Render.SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);

  DWORD rs_amb;
  g_Render.GetRenderState(D3DRS_AMBIENT, &rs_amb);
  g_Render.SetRenderState(D3DRS_AMBIENT, 0xffffffff);
  g_Render.SetRenderStateForced(D3DRS_AMBIENT, 0xffffffff);

  DWORD rs_light;
  g_Render.GetRenderState(D3DRS_LIGHTING, &rs_light);
  g_Render.SetRenderState(D3DRS_LIGHTING, 0);
  g_Render.SetRenderState(D3DRS_TEXTUREFACTOR, 0xffffffff);
  g_Render.SetRenderStateForced(D3DRS_TEXTUREFACTOR, 0xffffffff);

  g_Render.SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
  g_Render.SetRenderStateForced(D3DRS_ALPHATESTENABLE, FALSE);

  g_Render.SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
  g_Render.SetRenderStateForced(D3DRS_ALPHABLENDENABLE, FALSE);

  g_Render.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
  g_Render.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
  g_Render.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
  g_Render.SetTextureStageStateForced(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
  g_Render.SetTextureStageStateForced(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
  g_Render.SetTextureStageStateForced(0, D3DTSS_COLOROP, D3DTOP_MODULATE);

  SetColor(_UIColor[0], _UIColor[1], _UIColor[2]);

  LECharacter::FrameMove();
  LECharacter::Render();

  RenderStateMgr* rsm = g_pGameApp->GetRenderStateMgr();

  rsm->BeginTranspObject();
  drUpdateSceneTransparentObject();
  rsm->EndTranspObject();

  g_Render.SetRenderState(D3DRS_AMBIENT, rs_amb);
  g_Render.SetRenderState(D3DRS_LIGHTING, rs_light);

  g_Render.SetCurrentView(LERender::VIEW_WORLD);
}

void CCharacterModel::SetAmbColor(BYTE r, BYTE g, BYTE b)
{
  float ro = r / 255.0f;
  float go = g / 255.0f;
  float bo = b / 255.0f;

  _mtl.Ambient.r = ro;
  _mtl.Ambient.g = go;
  _mtl.Ambient.b = bo;

  LECharacter::SetMaterial(&_mtl);
  return;
}

void CCharacterModel::SetColor(BYTE r, BYTE g, BYTE b)
{
  _EmiColor = 1;

  float ro = r / 255.0f;
  float go = g / 255.0f;
  float bo = b / 255.0f;

  _mtl.Ambient.r = ro;
  _mtl.Ambient.g = go;
  _mtl.Ambient.b = bo;

  LECharacter::SetMaterial(&_mtl);

  _color[0] = r;
  _color[1] = g;
  _color[2] = b;
}

void CCharacterModel::SetOpaque(float opaque)
{
  if(opaque < 0.0f || opaque > 1.0f)
  {
	MessageBox(0, "msgSetOpaque Error", "error", 0);
  }

  //_mtl.Ambient.a = opaque;
  //_mtl.Diffuse.a = opaque;
  //LECharacter::SetMaterial(&_mtl);

  LECharacter::SetOpacity(opaque);
}

void CCharacterModel::SetPoseKeyFrameProc(drPoseKeyFrameProc proc, void* proc_param)
{
  _KeyFrameProc = proc;
  ;
  _ProcParam = proc_param;

  if(this->_ModelType == MODEL_CHARACTER)
  {
	LECharacter::SetPoseKeyFrameProc(proc, proc_param);
  } else if(_ModelType == MODEL_TOWER)
  {
	LECharacter::SetObjImpPoseKeyFrameProc(1, ANIM_CTRL_TYPE_MAT, proc, proc_param);
  } else
  {
	LECharacter::SetObjImpPoseKeyFrameProc(0, ANIM_CTRL_TYPE_MAT, proc, proc_param);
  }
}
DWORD CCharacterModel::GetCurPoseKeyFrameNum()
{
  MPIPoseCtrl* c = GetPoseCtrl();
  if(c == 0)
	return 0;

  MPPoseInfo* info = c->GetPoseInfo(_SmallPoseID);
  if(info == 0)
	return 0;

  return info->key_frame_num;
}

MPIPoseCtrl* CCharacterModel::GetPoseCtrl()
{
  MPIPoseCtrl* c = 0;

  switch(_ModelType)
  {
  case MODEL_CHARACTER:
	c = LECharacter::GetPoseCtrl();
	break;
  case MODEL_WARSHIP:
	c = LECharacter::GetObjImpPoseCtrl(0, ANIM_CTRL_TYPE_MAT);
	break;
  case MODEL_TOWER:
	c = LECharacter::GetObjImpPoseCtrl(1, ANIM_CTRL_TYPE_MAT);
	break;
  default:
	__asm int 3;
	break;
  }

  return c;
}

MPPoseInfo* CCharacterModel::GetPoseInfo(DWORD pose_id)
{
  MPIPoseCtrl* pose_ctrl = GetPoseCtrl();
  if(pose_ctrl == 0)
	return 0;

  return pose_ctrl->GetPoseInfo(pose_id);
}
MPPoseInfo* CCharacterModel::GetPoseInfoBig(DWORD big_pose_id)
{
  DWORD p;
  p = _BigPose2SmallPose(big_pose_id);
  if(p == -1)
	return NULL;

  MPIPoseCtrl* pose_ctrl = GetPoseCtrl();
  if(pose_ctrl == 0)
	return 0;

  return pose_ctrl->GetPoseInfo(p);
}
int CCharacterModel::Unlit(DWORD part_id)
{
  MPIPrimitive* p = GetPhysique()->GetPrimitive(part_id);
  if(p == 0)
	return 0;

  drPrimitiveTexUnLitA(p);

  DWORD vst		= p->GetRenderCtrlAgent()->GetVertexShader();
  DWORD new_vst = DR_INVALID_INDEX;
  switch(vst)
  {
  case VSTU_SKINMESH0_TT3:
	new_vst = VST_PU4NT0_LD;
	break;
  case VSTU_SKINMESH1_TT3:
	new_vst = VST_PB1U4NT0_LD;
	break;
  }

  if(new_vst != DR_INVALID_INDEX)
  {
	drPrimitiveSetVertexShader(p, new_vst);
  }

  return 1;
}
int CCharacterModel::Lit(DWORD part_id, DWORD lit_id)
{
  MPIPrimitive* p = GetPhysique()->GetPrimitive(part_id);
  if(p == 0)
	return 0;

  if(_PartFile[part_id] == 0)
	return 0;

  extern LitMgr g_lit_mgr;

  if(_ModelType == MODEL_CHARACTER)
  {
	D3DCAPSX* caps = g_Render.GetInterfaceMgr()->dev_obj->GetDeviceCaps();
	if(caps->MaxTextureBlendStages < 4 || caps->MaxSimultaneousTextures < 4)
	  return 1;

	char file[260];
	_snprintf_s(file, _countof(file), _TRUNCATE, "%s.lgo", _PartFile[part_id]);
	//sprintf_s(file, "%s.lgo", "0000810002");

	LitInfo* l = g_lit_mgr.Lit(0, 0, file);
	if(l == 0)
	  return 0;

	if(lit_id >= l->str_num)
	  return 0;

	drPrimitiveTexLitA(p, l->mask, l->str_buf[lit_id], ".\\texture\\lit\\", l->anim_type);
	DWORD vst = p->GetRenderCtrlAgent()->GetVertexShader();

	// Modified by clp 修正新手服装消失bug
	drPrimitiveSetVertexShader(p, vst);

	//DWORD new_vst;
	//switch(vst)
	//{
	//case VST_PU4NT0_LD:
	//	new_vst = VSTU_SKINMESH0_TT3;
	//	break;
	//case VST_PB1U4NT0_LD:
	//	new_vst = VSTU_SKINMESH1_TT3;
	//	break;
	//default:
	//	MessageBox(NULL,"Crash, call jack", 0, 0);
	//}

	//drPrimitiveSetVertexShader(p, new_vst);
	// Modified by clp 修正新手服装消失bug
  }

  return 1;
}

BOOL CCharacterModel::Cull()
{
  CChaRecord* pInfo = GetChaRecordInfo(_TypeID);
  if(pInfo == 0)
	return 0;

  drISceneMgr*	  scn_mgr = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr();
  drIViewFrustum* vf	  = scn_mgr->GetViewFrustum();

  DWORD i;
  if(pInfo->chModalType == enumMODAL_MAIN_CHA || pInfo->chModalType == enumMODAL_OTHER) // character
  {
	drSphere s;

	if(pInfo->fHeight < 1.0f)
	  s.r = 5.0f;
	else
	  s.r = pInfo->fHeight / 2;

	s.c = *(drVector3*)&GetMatrix()->_41;
	s.c.z += s.r;

	return !vf->IsSphereInFrustum(&s);
  } else if(pInfo->chModalType == enumMODAL_BOAT || pInfo->chModalType == enumMODAL_EMPL) // ship
  {
	MPIPhysique* p = GetPhysique();

	DWORD pri_num = 8;
	for(i = 0; i < pri_num; i++)
	{
	  MPIPrimitive* pri = p->GetPrimitive(i);
	  if(pri == 0)
		continue;

	  if(SUCCEEDED(scn_mgr->CullPrimitive(pri)))
		break;
	}

	return !(i == pri_num);
  }

  return 0;
}

BOOL CCharacterModel::SetDrunkState(BOOL flag)
{
  if(flag)
  {
	if(_DrunkCtrl == 0)
	{
	  _DrunkCtrl = DR_NEW(MPDrunkCtrl);
	  if(_DrunkCtrl->CreateDrunkDummy("rot.lgo") == 0)
		return 0;
	}

	_DrunkCtrl->Attach(this);
	//PlayPose(1, PLAY_LOOP_SMOOTH);
  } else
  {
	if(_DrunkCtrl)
	{
	  _DrunkCtrl->Detach();
	}
  }

  _DrunkState = flag;

  return 1;
}

float CCharacterModel::GetPoseVelocity()
{
  float v = 1.0f;

  switch(_ModelType)
  {
  case MODEL_CHARACTER:
	v = GetPlayPoseInfo()->velocity;
	break;
  case MODEL_WARSHIP:
	v = GetObjImpPlayPoseInfo(0, ANIM_CTRL_TYPE_MAT)->velocity;
	break;
  case MODEL_TOWER:
	v = GetObjImpPlayPoseInfo(1, ANIM_CTRL_TYPE_MAT)->velocity;
	break;
  default:
	LG("error", "msgCCharacterModel::GetPoseVelocity Type Invalid");
  }

  return v;
}
