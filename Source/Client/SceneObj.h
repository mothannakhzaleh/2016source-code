#pragma once

#include "SceneNode.h"
#include "LightEngine.h"
#include "SceneLight.h"
#include "SceneObjSet.h"

class CEffectObj;

class CSceneObj : public LESceneObject, public CSceneNode, public SceneLight
{
  private:
  BOOL _Create(int nObjTypeID, int nType);

  public:
  CSceneObj();
  virtual ~CSceneObj() {}

  virtual void FrameMove(DWORD dwTimeParam);
  virtual void Render();

  D3DXVECTOR3& getPos() { return _vPos; }
  void		   setSection(int nSectionNO) { _nSectionNO = nSectionNO; }
  int		   getSection() { return _nSectionNO; }
  void		   setObjType(DWORD type) { _dwObjType = type; }
  DWORD		   getObjType() const { return _dwObjType; }

  void SetSceneLightInfo(int type);
  //lemon add@2004.10.20 for light
  void UpdateLight();
  void ClearLight();
  void MoveLight(D3DXVECTOR3* SVerPos);

  // lh add@2004.10.20 for music
  int  GetMusicID() { return _nMusicID; }
  void SetMusicID(int nMusicID) { _nMusicID = nMusicID; }

  //lemon add@2004.10.28 for effect light
  void setChaID(int iId) { _iChaID = iId; }
  int  getChaID() { return _iChaID; }
  void setChaType(int iType) { _iOwerType = iType; }
  int  getChaType() { return _iOwerType; }

  public:
  bool	IsBoxVisible(drVector3 vecMin, drVector3 vecMax, DWORD& index);
  bool	IsBoxVisible_LineWithPlane(drVector3 vecMin, drVector3 vecMax, DWORD& index);
  void	SetMaterial(const D3DMATERIALX* mtl);
  void	SetCullingFlag(DWORD flag) { _dwCullingFlag = flag; }
  int	HitTestForInfluence(int* flag, D3DXVECTOR3* t_pos, const D3DXVECTOR3* nPos);
  DWORD GetObjTileColor();
  int	UpdateObjFadeInFadeOut(const MPVector3* org, const MPVector3* ray);

  protected:
  virtual void _UpdateYaw();
  virtual void _UpdatePitch();
  virtual void _UpdateRoll();
  virtual void _UpdateHeight();
  virtual void _UpdatePos();
  virtual void _UpdateValid(BOOL bValid);

  D3DXVECTOR3 _vPos;
  int		  _nSectionNO;
  DWORD		  _dwObjType;
  DWORD		  _dwItemType;

  float _fTerrainHeight;

  //lemon add@2004.10.20 for light
  LETerrain* _pTerrain;
  int		 _iChaID; //有可能是角色，或物件，或武器或特效的ID
  int		 _iOwerType;
  float		 _fRange;
  D3DXCOLOR	 _dwcolor;
  float		 _fx, _fy, _ftx, _fty;

  // lh add@2004.10.20 for music
  int	_nMusicID;
  DWORD _dwLastUpdateTime;

  // by lsh
  DWORD _dwCullingFlag;
  DWORD _dwTranspFlag;
  DWORD _dwTranspState;
  float _fTranspValue;

  // by clp
  public:
  void setRBOHeight(float height)
  {
	mRBOHeight = height;
  }
  float getRBOHeight()
  {
	return mRBOHeight;
  }
  BOOL _isRBO()
  {
	CSceneObjInfo* info = GetSceneObjInfo(this->getTypeID());
	if(info)
	{
	  return info->bIsReallyBig;
	}
	return FALSE;
  }

  private:
  float mRBOHeight;
};

inline void CSceneObj::_UpdateYaw()
{
  SetYaw(Angle2Radian((float)_nYaw));
  UpdateYawPitchRoll();
}

inline void CSceneObj::_UpdatePitch()
{
  SetPitch(Angle2Radian((float)_nPitch));
}

inline void CSceneObj::_UpdateRoll()
{
  SetRoll(Angle2Radian((float)_nRoll));
}
