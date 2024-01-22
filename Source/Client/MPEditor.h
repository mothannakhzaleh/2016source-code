#pragma once

#include "terrainattrib.h"

#define MAX_SWITCH_PANEL 5
#define SMOOTH_RANGER	 0.04f

enum eActType
{
  enumNull			   = 0,
  enumAddCharacter	   = 1,
  enumAddSceneObj	   = 2,
  enumAddSceneEffect   = 3,
  enumDelCharacter	   = 4,
  enumDelSceneObj	   = 5,
  enumDelSceneEffect   = 6,
  enumObjectMove	   = 7,
  enumEffectMove	   = 8,
  enumSetTerrainColor  = 9,
  enumSetTerrainColor2 = 10,
  enumModifyHeight	   = 11,
};

struct ActionStruct
{
  void*	   _ptr;
  eActType _eType;
  int	   _nType;

  int _xoffset;
  int _yoffset;

  DWORD _dwcolor;
  float _fxpos;
  float _fypos;
  int	_brushno;

  float _fStep;
  float _fResetHeight;

  vector<float> _fHeights;

  ActionStruct()
  {
	_ptr   = NULL;
	_eType = enumNull;
	_nType = 0;

	_dwcolor = 0;
	_fxpos	 = 0;
	_fypos	 = 0;
	_brushno = 0;

	_fStep		  = 0.0f;
	_fResetHeight = 0.0f;
  }
};

class CSceneObj;
class CCharacter;
class CEffectObj;
class LEMap;
class CGameScene;

class MPEditor
{
  public:
  MPEditor() :
	  _dwColor(0xffff0000)
  {
	m_bShowLightBrush = false;
	// begin by lsh
	// call 13
	_dwColor = D3DCOLOR_XRGB(89, 168, 158);
	// end
	_AttrBlockSeq	= 0;
	_AttrHeightSeq	= 0;
	_AttrBlockSeq2	= 0;
	_AttrHeightSeq2 = 0;
	_dwAttrNum		= 0;
	m_bPickByPixel	= false;

	fopen_s(&_fp, ".\\log\\fps.log", "wt");
  }
  ~MPEditor()
  {
	SAFE_DELETE_ARRAY(_AttrBlockSeq);
	SAFE_DELETE_ARRAY(_AttrHeightSeq);
	SAFE_DELETE_ARRAY(_AttrBlockSeq2);
	SAFE_DELETE_ARRAY(_AttrHeightSeq2);
	if(_fp)
	  fclose(_fp);
	_fp = 0;
  }

  void		  Init(int nMapID);
  LETerrain*  GetCurTerrain();
  CGameScene* GetCurScene();

  void FrameMove(DWORD dwTimeParam);
  void Render();

  void SystemReport(DWORD dwTimeParam);

  void PlaceTerrain(int nType, int nX, int nY, int nTexNo);
  void PlaceTerrainByBrush();
  void ModifyHeight(float fStep, float fResetHeight = -100.0f, BOOL bReturn = FALSE, BOOL bRollBack = FALSE);
  void SetTerrainColor(int nType, BOOL bReturn = FALSE, BOOL bRollBack = FALSE);
  void SetTerrainInvalid(int nType);
  void SetChaPose(int nPress, int nPoseID);

  //lemon add@2004.11.3
  void SetTerrainColor2(int nType, BOOL bReturn = FALSE, BOOL bRollBack = FALSE);

  void Enable(BOOL bEnable);
  BOOL IsEnable() { return _bEnable; }

  void HandleKeyDown();
  void HandleKeyContinue();
  BOOL MouseButtonDown(int nButton);
  BOOL MouseButtonUp(int nButton);
  void MouseMove(int nOffsetX, int nOffsetY);
  void MouseScroll(int nScroll);

  CSceneObj* GetSelectSceneObj() { return _pSelSceneObj; }
  void		 SelectSceneObj();
  void		 UnhideAllSceneObj();
  void		 HideSelectSceneObj();

  CEffectObj* SelectEffectObj();

  int  m_nCurShowPanel;
  BOOL m_bModifyHeight;
  BOOL m_bEditWater;
  int  m_nBrushNo;
  int  m_nSelTexNo;
  int  m_nSelectX;
  int  m_nSelectY;
  BOOL m_bEnableTextureAlphaBlend;
  BOOL m_bShowHeightmap;
  bool m_bSmooth;
  int  m_nSelTypeID;

  int  m_nSelID;
  int  m_nBrushHeight;
  bool m_bIsBrushColor;

  //lemon add@2004.11.4
  bool m_bShowLightBrush;

  public: // 用于外部界面调用
  DWORD GetColor() { return _dwColor; }
  void	SetColor(DWORD color) { _dwColor = color; }
  void	SetTerr(bool press, int num);
  void	SetCha(bool press, int num);
  void	SetObj(bool press, int num);
  void	SetEff(bool press, int num);
  void	ChangePart(bool press, int num);
  void	SetWireFrame(bool v);
  void	SmoothArea(int nPoXs, int nPosY, int nLengthX, int nLengthY, float fSize);

  void SelectProperty(int nPropertyNumber);
  void CancelProperty(void);
  void GenerateLandAttr();
  void SetTerrainBlock(BOOL bSet);
  void SetPickByPixel(bool bPickByPixel) { m_bPickByPixel = bPickByPixel; }
  bool GetPickByPixel() { return m_bPickByPixel; }
  void SwitchPickMode() { SetPickByPixel(!GetPickByPixel()); }

  BOOL IsPitchWatch() { return bPitchWatch; }

  protected:
  long		  CreateSmoothArea(int nPosX, int nPosY, int nLengthX, int nLengthY);
  void		  _RenderSelTile(int nX, int nY);
  void		  _RenderHeightmap();
  CCharacter* _GetSelectCha();
  int		  _GetSceneObjBlockInfo(LESceneObject* obj, int* x, int* y, int* width, int* height, BYTE** block_seq, float** height_seq);
  void		  _UpdateObjHeightmap(CSceneObj* pObj);

  BOOL		  _bEnable;
  CSceneObj*  _pSelSceneObj;
  CEffectObj* _pSelEff;

  DWORD	 _dwColor;
  int	 m_nStarPosX;
  int	 m_nStarPosY;
  int	 m_nEndPosX;
  int	 m_nEndPosY;
  float	 m_fAverageHight;
  BOOL	 m_bLockObj;
  bool	 m_bPickByPixel;
  BYTE*	 _AttrBlockSeq;
  float* _AttrHeightSeq;
  BYTE*	 _AttrBlockSeq2;
  float* _AttrHeightSeq2;
  DWORD	 _dwAttrNum;
  FILE*	 _fp;

  int m_oldnX;
  int m_oldnY;

  bool bPitchWatch;

  vector<ActionStruct*> _Action;
  vector<ActionStruct*> _ActionRollBack;
  void					AddAction(ActionStruct* action);
  void					AddAction(void* ptr, eActType acttype, int xoff = 0, int yoff = 0);
  void					RemoveAction();
  void					ReturnAction(BOOL bRollBack = FALSE);
  void					RollBackReturnAction();

  // add by claude for terrain attrib
  byte _AttribIndex;							  // 区域属性按钮的编号 (1...16)
  byte _getTileAttribMask(byte attrib_btn_index); // 参数是区域属性按钮的编号
  byte _IslandIndex;							  // 海岛的编号
  bool _is_erase;								  // 是添加属性还是删除属性操作

  void _renderTileAttrib(int nX, int nY, int nAttribIndex);
  void _renderTileIsland(int nX, int nY, int nIslandIndex);

  void _SetAttrib();

  public:
  // add by claude
  void selectIsland(int nIslandIndex);
  void cancelIsland();
  void enable_erase(bool erase = true) { _is_erase = erase; }
};