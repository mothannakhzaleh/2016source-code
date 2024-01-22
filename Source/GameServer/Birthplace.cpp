#include "StdAfx.h"
#include "Birthplace.h"


void CBirthMgr::ClearAll()
{
	for(map<string, SBirthplace*>::iterator it = _LocIdx.begin(); it!= _LocIdx.end(); it++)
	{
		SBirthplace *p = (*it).second;
		SAFE_DELETE(p);
	}

	_LocIdx.clear();
}


CBirthMgr::~CBirthMgr()
{
	ClearAll();
}

CBirthMgr g_BirthMgr;
