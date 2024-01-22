//
#include "stdafx.h"
#include <stdio.h>
#include "LitLoad.h"

LitMgr g_lit_mgr;

int LitMgr::Load(const char* file)
{
  FILE* fp;
  fopen_s(&fp, file, "rt");
  if(fp == 0)
	return 0;

  char str[64];

  fscanf_s(fp, "%s", str, 64);
  fscanf_s(fp, "%ld", &_lit_num);

  _lit_seq = DR_NEW(LitInfo[_lit_num]);

  LitInfo* p;

  for(DWORD i = 0; i < _lit_num; i++)
  {
	p = &_lit_seq[i];

	fscanf_s(fp, "%s", str, 64);
	fscanf_s(fp, "%ld", &p->obj_type);

	switch(p->obj_type)
	{
	case 0: // character
	  fscanf_s(fp, "%ld", &p->anim_type);
	  fscanf_s(fp, "%s", &p->file, 128);
	  fscanf_s(fp, "%s", &p->mask, 128);
	  fscanf_s(fp, "%ld", &p->str_num);
	  for(DWORD j = 0; j < p->str_num; j++)
	  {
		fscanf_s(fp, " %s", p->str_buf[j], 128);
	  }
	  break;
	case 1: // scene
	case 2: // item
	  fscanf_s(fp, "%ld", &p->anim_type);
	  fscanf_s(fp, "%s", &p->file, 128);
	  fscanf_s(fp, "%ld", &p->sub_id);
	  fscanf_s(fp, "%ld", &p->color_op);
	  fscanf_s(fp, "%ld", &p->str_num);
	  for(DWORD j = 0; j < p->str_num; j++)
	  {
		fscanf_s(fp, " %s", p->str_buf[j], 128);
	  }
	  break;
	default:
	  assert(0 && "invalid lit type");
	}
  }

  fclose(fp);
  return 1;
}
LitInfo* LitMgr::Lit(DWORD obj_type, DWORD sub_id, const char* file)
{
  LitInfo* p;

  for(DWORD i = 0; i < _lit_num; i++)
  {
	p = &_lit_seq[i];

	if(p->obj_type == obj_type && _tcsicmp(p->file, file) == 0)
	{
	  return p;
	}
  }

  return 0;
}

//int LitMgr::Lit(MPSceneObj* obj)
//{
//}
//int LitMgr::Lit(LECharacter* obj)
//{
//}
//int LitMgr::Lit(LESceneItem* obj)
//{
//}
