#include "StdAfx.h"
#include ".\npcobject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CNPCObject::CNPCObject(void)
{
	SetType(CRoleObject::eNPC);
}

CNPCObject::~CNPCObject(void)
{
}
