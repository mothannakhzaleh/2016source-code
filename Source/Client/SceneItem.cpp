#include "stdafx.h"
#include "SceneItem.h"
#include "SceneItemSet.h"
#include "Scene.h"
#include "Character.h"
#include "LitLoad.h"
#include "UIFont.h"
#include "arctrack.h"
#include "event.h"
#include "sceneheight.h"
#include "ItemLit.h"
#include "ItemLitAnim.h"
#include "StoneSet.h"
#include "GameApp.h"
#include "ItemRefineSet.h"
#include "ItemRefineEffectSet.h"
#include "EffectObj.h"
#include "UIItemCommand.h"

lwItemLit g_il;
BOOL	  InitItemLit(const char* file)
{
  ClearItemLit();
  return DR_SUCCEEDED(g_il.Load(file));
}
BOOL ClearItemLit()
{
  g_il.Clear();
  return TRUE;
}

CSceneItem::CSceneItem() :
	CSceneNode(), _nCharacterID(-1), _fTerrainHeight(0.0f), _IsSystem(false), _IsShowName(false), _IsAlpha(false), _pItemInfo(NULL), _pArcTrack(NULL), _pEvent(NULL), _dwForgeValue(0),
	mParentCharacter(0), mEffect(0)
{
  _vPos			= D3DXVECTOR3(0, 0, 0);
  _pSceneHeight = new CSceneHeight(this);
}

CSceneItem::~CSceneItem()
{
  if(_pArcTrack) delete _pArcTrack;
  delete _pSceneHeight;
}

BOOL CSceneItem::_Create(int nObjTypeID, int nType)
{
  _pItemInfo = GetItemRecordInfo(nObjTypeID);
  if(_pItemInfo == NULL)
  {
	LG("error", RES_STRING(CL_LANGUAGE_MATCH_349), nObjTypeID);
	return FALSE;
  }

  char str[260];
  _snprintf_s(str, _countof(str), _TRUNCATE, "%s.lgo", _pItemInfo->chModule[nType]);

  if(Load(str) == -1)
  {
	LG("error", RES_STRING(CL_LANGUAGE_MATCH_350), nObjTypeID, _pItemInfo->szName, str);
	return FALSE;
  }

  SetValid(TRUE);

  // ShowBoundingObject( 1 );
  //ShowHelperMesh( 1 );

  //PlayDefaultAnimation();

  //if( pInfo->nCharacterID != -1 )
  //{
  //    CCharacter* c = this->GetScene()->GetCha( pInfo->nCharacterID );
  //    if( c )
  //    {
  //        if( c->IsBoat() && pInfo->nShipLinkID != -1 )
  //        {
  //            lwSceneItemLinkInfo ili;
  //            ili.id = 0;
  //            ili.obj = this;
  //            ili.link_item_id = pInfo->nItemLinkID;
  //            ili.link_parent_id = pInfo->nShipLinkID;

  //            c->SetSubObjItemLink( 2, &ili );
  //        }
  //    }
  //}

  _IsSystem		  = false;
  _IsShowName	  = false;
  _nCharacterID	  = -1;
  _fTerrainHeight = 0.0f;

  // debug by lsh
  extern LitMgr g_lit_mgr;
  LitInfo*		l = g_lit_mgr.Lit(2, 0, str);
  if(l)
  {
	drIPrimitive* p = GetPrimitive();
	drPrimitiveTexLit(p, l->str_buf[0], ".\\texture\\lit\\", l->color_op, l->anim_type);
  }
  // end

  if(_pArcTrack)
  {
	delete _pArcTrack;
	_pArcTrack = NULL;
  }

  LitUnresetTexture();

  _pSceneHeight->Reset();
  return TRUE;
}

int CSceneItem::Load(const char* file)
{
  _IsSystem		  = false;
  _IsShowName	  = false;
  _nCharacterID	  = -1;
  _fTerrainHeight = 0.0f;

  _dwTypeID = 0;

  _nHeightOff	  = 0;
  _nPoseHeightOff = 0;
  _bHide		  = FALSE;
  _dwAttachID	  = 0;
  _nSize		  = 0;
  _dwFrameCnt	  = 0;
  _dwRenderCnt	  = 0;
  _nCurX		  = 0;
  _nCurY		  = 0;
  _Attr.clear();

  if(LESceneItem::Load(file) == -1)
	return -1;

  // debug by lsh
  extern LitMgr g_lit_mgr;
  LitInfo*		l = g_lit_mgr.Lit(2, 0, file);
  if(l)
  {
	drIPrimitive* p = GetPrimitive();
	//drPrimitiveTexLit(p, l->str_buf[0], ".\\texture\\lit\\", l->color_op, l->anim_type);
  }
  // end

  return 1;
}
HRESULT CSceneItem::LitResetTexture(DWORD item_id, DWORD lit_id)
{
  HRESULT ret = DR_RET_FAILED;

  int				   flag = 0;
  drIMtlTexAgent*	   mtltex_agent;
  drIAnimCtrlAgent*	   anim_agent;
  drIAnimCtrlObjTexUV* ctrlobj_tc;
  drIAnimCtrlTexUV*	   ctrl_tc;
  drIAnimKeySetPRS*	   aks;
  drIResourceMgr*	   res_mgr;
  MPIPrimitive*		   pri;
  lwItemLit*		   il = &g_il;

  lwItemLitInfo*			item_info = 0;
  lwLitInfo*				lit_info;
  lwItemLitInfo::_LitBuf_It lit_it;

  DR_FAILED_RET(il->FindItem(item_id, &item_info));
  lit_it = item_info->FindLitWithId(lit_id);
  if(lit_it == item_info->lit.end())
	goto __ret;
  lit_info = (*lit_it);

  pri		   = LESceneItem::GetObject()->GetPrimitive();
  mtltex_agent = pri->GetMtlTexAgent(1);
  if(mtltex_agent == 0)
	goto __ret;

  res_mgr = pri->GetResourceMgr();
  mtltex_agent->SetRenderFlag(TRUE);
  mtltex_agent->SetOpacity(lit_info->opacity);
  mtltex_agent->SetTranspType(lit_info->transp_type);

  if(_tcslen(lit_info->file) > 0)
  {
	drIPathInfo* path_info = res_mgr->GetSysGraphics()->GetSystem()->GetPathInfo();
	DR_FAILED_RET(pri->ResetTexture(1, 0, lit_info->file, path_info->GetPath(PATH_TYPE_TEXTURE_ITEM)));
  }
  if(lit_info->anim_type > 0)
  {
	anim_agent = pri->GetAnimAgent();
	if(anim_agent == 0)
	{
	  flag = 1;
	  res_mgr->CreateAnimCtrlAgent(&anim_agent);
	}
	res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrlobj_tc, ANIM_CTRL_TYPE_TEXCOORD);
	res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_tc, ANIM_CTRL_TYPE_TEXCOORD);
	drGUIDCreateObject((lxvoid**)&aks, DR_GUID_ANIMKEYSETPRS);

	(*__lit_proc[lit_info->anim_type])(aks);

	drAnimCtrlTypeInfo acti;
	acti.type	 = ANIM_CTRL_TYPE_TEXCOORD;
	acti.data[0] = 1;
	acti.data[1] = 0;

	ctrl_tc->SetAnimKeySetPRS(aks);
	ctrlobj_tc->AttachAnimCtrl(ctrl_tc);
	ctrlobj_tc->SetTypeInfo(&acti);
	anim_agent->AddAnimCtrlObj(ctrlobj_tc);

	if(flag == 1)
	  pri->SetAnimCtrlAgent(anim_agent);

	drPlayPoseInfo ppi;
	memset(&ppi, 0, sizeof(ppi));
	ppi.bit_mask = PPI_MASK_DEFAULT;
	ppi.type	 = PLAY_LOOP;
	ppi.pose	 = 0;
	ppi.velocity = 1.0f;
	ctrlobj_tc->PlayPose(&ppi);
  }

  ret = DR_RET_OK;
__ret:
  return ret;
}
HRESULT CSceneItem::LitUnresetTexture()
{
  HRESULT ret = DR_RET_FAILED;

  drIMtlTexAgent* mtltex_agent;
  drIResourceMgr* res_mgr;
  MPIPrimitive*	  pri;

  pri		   = LESceneItem::GetObject()->GetPrimitive();

  mtltex_agent = pri->GetMtlTexAgent(1);
  if(mtltex_agent == 0)
	goto __ret;

  res_mgr = pri->GetResourceMgr();
  mtltex_agent->SetRenderFlag(FALSE);

  ret = DR_RET_OK;
__ret:
  return ret;
}

void CSceneItem::Render()
{
  if(GetScene()->GetTerrain())
  {
	if(!GetScene()->GetTerrain()->IsPointVisible((float)_nCurX / 100.0f, (float)_nCurY / 100.0f))
	  return;
  }

  CSceneNode::Render();

  // g_Render.EnableMipmap(FALSE);

  LESceneItem::Render();
}

void CSceneItem::PlayArcAni(D3DXVECTOR3 vStart, D3DXVECTOR3 vEnd, float fVel, float fHei)
{
  if(!_pArcTrack) _pArcTrack = new CArcTrack;
  _pArcTrack->Start(vStart, vEnd, fVel, fHei);
}

void CSceneItem::FrameMove(DWORD dwTimeParam)
{
  CSceneNode::FrameMove(dwTimeParam);

  if(_pArcTrack)
  {
	_pArcTrack->FrameMove();

	SetPos((float*)_pArcTrack->GetPos());

	if(_pArcTrack->IsEnd())
	{
	  delete _pArcTrack;
	  _pArcTrack = NULL;

	  setPos(_nCurX, _nCurY);
	}
  } else if(!IsHide())
  {
	if(_nCharacterID == -1)
	{
	  // 更新高度
	  if(_pSceneHeight->FrameMove(dwTimeParam))
	  {
		_UpdatePos();
	  }
	} else
	{
	  _nCurX = (int)(LESceneItem::GetMatrix()->_41 * 100);
	  _nCurY = (int)(LESceneItem::GetMatrix()->_42 * 100);
	}

	if(_IsAlpha)
	{
	  float f = GetOpacity() + 0.03f;
	  if(f >= 1.0f)
	  {
		f		 = 1.0f;
		_IsAlpha = false;
	  }
	  SetOpacity(f);
	}
  }

  //if(IsValid())
  //GetScene()->HandleSceneMsg(SCENEMSG_SCENEOBJ_MOVE,_nEffID,getID());
  //else
  //	_pCurScene->HandleSceneMsg(SCENEMSG_SCENEOBJ_DESTROY,_nEffID,getID());

  // by lsh
  // 注意，这里的FrameMove必需放在最后调用，否则会有位置误差
  LESceneItem::FrameMove();
}

void CSceneItem::_UpdateValid(BOOL bValid)
{
  if(bValid == FALSE)
  {
	SetForgeEffect(0);
	if(_pEvent)
	{
	  _pEvent->SetIsValid(false);
	  _pEvent = NULL;
	}
	GetScene()->HandleSceneMsg(SCENEMSG_SCENEITEM_DESTROY, getID());
  }
}

void CSceneItem::_UpdatePos()
{
  _vPos.x = (float)_nCurX / 100.0f;
  _vPos.y = (float)_nCurY / 100.0f;

  _fTerrainHeight = _pScene->GetGridHeight(_vPos.x, _vPos.y);
  if(_fTerrainHeight < 0.0f) _fTerrainHeight = 0.0f;

  _vPos.z = _fTerrainHeight + (float)_nHeightOff / 100.0f;
  SetPos((float*)_vPos);
}

void CSceneItem::_UpdateHeight()
{
  _vPos.x = (float)_nCurX / 100.0f;
  _vPos.y = (float)_nCurY / 100.0f;

  _fTerrainHeight = _pScene->GetGridHeight(_vPos.x, _vPos.y);
  if(_fTerrainHeight < 0.0f) _fTerrainHeight = 0.0f;

  _vPos.z = _fTerrainHeight + (float)_nHeightOff / 100.0f;
  SetPos((float*)_vPos);
}

void CSceneItem::setAlpla(float alpha)
{
  SetOpacity(alpha);
  _IsAlpha = true;
}

void CSceneItem::setIsShowName(bool v)
{
  _IsShowName = v;
  if(v)
  {
	CGuiFont::s_Font.GetSize(_pItemInfo->szName, _nNameW, _nNameH);
  }
}

bool CSceneItem::IsHitText(int x, int y)
{
  if(_IsShowName)
  {
	static int nX, nY;
	g_Render.WorldToScreen(_vPos.x, _vPos.y, _vPos.z, &nX, &nY);

	nX -= _nNameW / 2;
	return x >= nX && x <= nX + _nNameW && y >= nY && y <= nY + _nNameH;
  }
  return false;
}

void CSceneItem::RenderUI()
{
  if(_IsShowName)
  {
	static int nX, nY;
	g_Render.WorldToScreen(_vPos.x, _vPos.y, _vPos.z, &nX, &nY);

	nX -= _nNameW / 2;
	GetRender().FillFrame(nX, nY, nX + _nNameW, nY + _nNameH, 0x90000000);
	CGuiFont::s_Font.Render(_pItemInfo->szName, nX, nY, 0xffffffff);
  }
}

bool CSceneItem::GetItemHeight(float* out_height)
{
  return DR_SUCCEEDED(drPrimitiveGetObjHeight(GetPrimitive(), out_height));
}

void CSceneItem::SetForgeEffect(DWORD value, int nCharID)
{
  if(_dwForgeValue == value) return;
  _dwForgeValue = value;

  nCharID--;
  if(nCharID < 0 || nCharID > 3)
	return;

  SItemForge& Forge = SItemForge::Convert(value, _pItemInfo->nID);
  if(!Forge.IsForge || !Forge.pEffectInfo)
  {
	LitUnresetTexture();

	// 卸下
	int			nCount	= GetEffectNum();
	CEffectObj* pEffect = NULL;
	for(int i = 0; i < nCount; i++)
	{
	  pEffect = _pScene->GetEffect(GetEffectID(i));
	  if(pEffect)
	  {
		pEffect->SetValid(FALSE);
	  }
	}
	return;
  }

  CItemRefineEffectInfo* pInfo = Forge.pEffectInfo;
  if(!pInfo) return;

  int Level = Forge.nEffectLevel;

  CSceneItem* pItem = this;
  if(pInfo->nLightID != 0)
	pItem->LitResetTexture(pInfo->nLightID, Level); // 加载流光
  else
	pItem->LitUnresetTexture();

  // 先取消之前的特效
  int		  nCount  = pItem->GetEffectNum();
  CEffectObj* pEffect = NULL;
  for(int i = 0; i < nCount; i++)
  {
	pEffect = _pScene->GetEffect(pItem->GetEffectID(i));
	if(pEffect)
	{
	  pEffect->SetValid(FALSE);
	}
  }

  int nEffectID = 0;
  for(int i = 0; i < pInfo->GetEffectNum(nCharID); i++)
  {
	nEffectID = pInfo->sEffectID[nCharID][i] * 10 + Level;
	pEffect	  = _pScene->GetFirstInvalidEffObj();

	if(!pEffect)
	{
	  LG("ERROR", "msgSceneItem SetForgeEffect effect fail,ID[%d]", nEffectID);
	  continue;
	}

	// 使用道具表里的dummy
	if(!pEffect->Create(nEffectID))
	{
	  LG("ERROR", "msgSceneItem SetForgeEffect effect fail,ID %d", nEffectID);
	  continue;
	}
	pEffect->setFollowObj((CSceneNode*)pItem, NODE_ITEM, pInfo->chDummy[i]);
	float fEffectScale = Forge.pRefineInfo->fChaEffectScale[nCharID];
	pEffect->SetScale(fEffectScale, fEffectScale, fEffectScale);
	pEffect->SetAlpha(SItemForge::GetAlpha(Forge.nLevel));
	pEffect->Emission(-1, NULL, NULL);
	pEffect->SetValid(TRUE);

	pItem->AddEffect(pEffect->getID());
  }
  return;
}

void CSceneItem::SetHide(BOOL bHide)
{
  if(_bHide == bHide) return;

  _bHide = bHide;
  if(_iEffNum == 0) return;

  CEffectObj* pEff = NULL;
  for(int i = 0; i < _iEffNum; i++)
  {
	pEff = GetScene()->GetEffect(_iEffID[i]);
	if(pEff && pEff->IsValid())
	{
	  pEff->SetHide(bHide);
	}
  }
}

CEffectObj* CSceneItem::bindEffect(int dummyID, int effectID, bool isLoop, int angle)
{
  if(effectID <= 0)
	return NULL;

  CEffectObj* effect = GetScene()->GetFirstInvalidEffObj();
  if(!effect)
	return NULL;

  if(!effect->Create(effectID))
	return NULL;

  if(isLoop)
	effect->setLoop(isLoop);

  MPMatrix44 matrix;

  if(dummyID >= 0 && GetRunTimeMatrix(&matrix, dummyID) >= 0)
  {
	if(angle != -1)
	  effect->SetEffectDir(angle);
	effect->setFollowObj((CSceneNode*)this, NODE_ITEM, dummyID);
	effect->Emission(-1, (D3DXVECTOR3*)&matrix._41, NULL);
  } else
  {
	if(angle != -1)
	  effect->SetEffectDir(angle);
	effect->setFollowObj((CSceneNode*)this, NODE_ITEM);
	effect->Emission(-1, &GetPos(), NULL);
  }

  effect->SetValid(TRUE);
  AddEffect(effectID);

  mEffect = effect;
  return effect;
}

void CSceneItem::unbindEffect()
{
  if(mEffect)
	mEffect->SetValid(FALSE);
  mEffect = NULL;
}