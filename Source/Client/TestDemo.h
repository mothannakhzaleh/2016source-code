#pragma once

#include "Character.h"

#include "SceneObj.h"
#include "SceneObjFile.h"

#ifdef TESTDEMO

class CTestDemo
{
  private:
  drIResourceMgr* _res_mgr;
  drIModel*		  _skybox;

  public:
  CTestDemo();
  ~CTestDemo();

  BOOL Init();
  void FrameMove();
  void Render();
};

extern CTestDemo* g_pTestDemo;
void			  InitTestDemo();
void			  ReleaseTestDemo();

#endif
