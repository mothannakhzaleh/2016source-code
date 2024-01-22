//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drClassDecl.h"
#include "drInterface.h"
#include "drShaderTypes.h"
#include "drIUtil.h"
//#include "LECharacter.h"
//#include "LESceneObject.h"
//#include "MPSceneItem.h"
DR_USING

struct LitInfo
{
  DWORD obj_type;
  DWORD anim_type;
  DWORD sub_id;
  DWORD color_op;
  char	file[128];
  char	mask[128];
  char	str_buf[8][128];
  DWORD str_num;
};

class LitMgr
{
  private:
  LitInfo* _lit_seq;
  DWORD	   _lit_num;

  public:
  LitMgr() :
	  _lit_seq(0), _lit_num(0)
  {}
  ~LitMgr()
  {
	DR_SAFE_DELETE_A(_lit_seq);
  }

  int	   Load(const char* file);
  LitInfo* Lit(DWORD obj_type, DWORD sub_id, const char* file);
  //int Lit(MPSceneObj* obj);
  //int Lit(LECharacter* obj);
  //int Lit(MPSceneItem* obj);
};
