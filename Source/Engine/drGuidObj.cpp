//
#include "drGuidObj.h"
#include "drSystem.h"
//#include "drSysGraphics.h"
//#include "drPhysique.h"
#include "drAnimCtrl.h"
#include "drPoseCtrl.h"
#include "drStreamObj.h"
#include "drExpObj.h"
#include "drAnimKeySetPRS.h"
#include "drTreeNode.h"
#include "drMisc.h"
#include "drTimer.h"
#include "drFile.h"
#include "drDDSFile.h"
#include "drDirectoryBrowser.h"
#include "drConsole.h"
#include "drThreadPool.h"
#include "drSystemInfo.h"
#include "drMisc.h"
#include "drHeap.h"
#include "drFileStream.h"

DR_BEGIN

typedef void* (*drCreateGuidObjProc)();


static void* __guid_proc_NULL()
{
    return DR_NULL;
}
static void* __guid_proc_drSystem()
{
    return DR_NEW(drSystem);
}
//static void* __guid_proc_drDyanmicStreamMgr()
//{
//    return DR_NEW(drDynamicStreamMgr);
//}
//static void* __guid_proc_drSysGraphics()
//{
//    return DR_NEW(drSysGraphics);
//}
//static void* __guid_proc_drAnimCtrlBone()
//{
//    return DR_NEW(drAnimCtrlBone);
//}
static void* __guid_proc_drPoseCtrl()
{
    return DR_NEW(drPoseCtrl);
}
static void* __guid_proc_drAnimDataBone()
{
    return DR_NEW(drAnimDataBone);
}
static void* __guid_proc_drAnimDataTexUV()
{
    return DR_NEW(drAnimDataTexUV);
}
static void* __guid_proc_drMeshInfo()
{
    return DR_NEW(drMeshInfo);
}
static void* __guid_proc_drAnimKeySetPRS()
{
    return DR_NEW(drAnimKeySetPRS2);
}
static void* __guid_proc_drAnimKeySetFloat()
{
    return DR_NEW(drAnimKeySetFloat);
}
static void* __guid_proc_drTreeNode()
{
    return DR_NEW(drTreeNode);
}
static void* __guid_proc_drRenderStateAtomSet()
{
    return DR_NEW(drRenderStateAtomSet);
}
static void* __guid_proc_drTimer()
{
    return DR_NEW(drTimer);
}
static void* __guid_proc_drTimerThread()
{
    return DR_NEW(drTimerThread);
}
static void* __guid_proc_drTimerPeriod()
{
    return DR_NEW(drTimerPeriod);
}
static void* __guid_proc_drFile()
{
    return DR_NEW(drFile);
}
static void* __guid_proc_drFileDialog()
{
    return DR_NEW(drFileDialog);
}
static void* __guid_proc_drFileStream()
{
    return DR_NEW(drFileStream);
}
static void* __guid_proc_drDDSFile()
{
    return DR_NEW(drDDSFile);
}
static void* __guid_proc_drDirectoryBrowser()
{
    return DR_NEW(drDirectoryBrowser);
}
static void* __guid_proc_drConsole()
{
    return DR_NEW(drConsole);
}
static void* __guid_proc_drThreadPool()
{
    return DR_NEW(drThreadPool);
}
static void* __guid_proc_drGeomObjInfo()
{
    return DR_NEW(drGeomObjInfo);
}
static void* __guid_proc_drModelObjInfo()
{
    return DR_NEW(drModelObjInfo);
}
static void* __guid_proc_drSystemInfo()
{
    return DR_NEW(drSystemInfo);
}
static void* __guid_proc_drBuffer()
{
    return DR_NEW(drBuffer);
}
static void* __guid_proc_drHeap()
{
    return DR_NEW(drHeap);
}
    
#define __guid_proc_drActionSmith __guid_proc_NULL
#define __guid_proc_drTextFileLoader __guid_proc_NULL

static drCreateGuidObjProc __guid_proc_buf[DR_GUID_NUM] =
{
    __guid_proc_drSystem,
    __guid_proc_NULL,//__guid_proc_drSysGraphics,    
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,//__guid_proc_drDyanmicStreamMgr,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL, //__guid_proc_drAnimCtrlBone, // 10
    __guid_proc_NULL,
    __guid_proc_drPoseCtrl,
    __guid_proc_drAnimDataBone,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL,
    __guid_proc_NULL, // 20
    __guid_proc_drActionSmith,

    __guid_proc_drAnimDataTexUV,
    __guid_proc_drMeshInfo,
    __guid_proc_NULL,
    __guid_proc_drAnimKeySetPRS,
    __guid_proc_drAnimKeySetFloat,
    __guid_proc_drTreeNode,
    __guid_proc_drRenderStateAtomSet,
    __guid_proc_drTimer,
    __guid_proc_drTimerThread,
    __guid_proc_drTimerPeriod,
    __guid_proc_drFile,
    __guid_proc_drFileDialog,
    __guid_proc_drFileStream,
    __guid_proc_drDDSFile,
    __guid_proc_drDirectoryBrowser,
    __guid_proc_drConsole,
    __guid_proc_drThreadPool,
    __guid_proc_drTextFileLoader,
    __guid_proc_drGeomObjInfo,
    __guid_proc_drModelObjInfo,
    __guid_proc_drSystemInfo, // 41
    __guid_proc_drBuffer,
    __guid_proc_drHeap,

};

DR_RESULT drGUIDCreateObject(DR_VOID** obj, drGUID guid)
{
    return (*obj = __guid_proc_buf[DR_LODWORD(guid)]()) ? DR_RET_OK : DR_RET_FAILED;

}

DR_END
