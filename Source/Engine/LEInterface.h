//
#pragma once


#include "drHeader.h"
#include "drStdInc.h"
#include "drInterface.h"
#include "drITypes.h"
#include "drITypes2.h"
#include "drMath.h"
#include "drShaderTypes.h"
#include "drIFunc.h"
#include "drIUtil.h"

DR_USING;

// class
typedef drAnimCtrlObjTypeInfo MPAnimCtrlObjTypeInfo;
typedef drVector2 MPVector2;
typedef drVector3 MPVector3;
typedef drMatrix44 MPMatrix44;
typedef drBoundingBoxInfo MPBoundingBoxInfo;
typedef drPickInfo MPPickInfo;
typedef drPlayPoseInfo MPPlayPoseInfo;
typedef drPoseInfo MPPoseInfo;
typedef drInterfaceMgr MPInterfaceMgr;
typedef drMeshInfo MPMeshInfo;
typedef drWatchDevVideoMemInfo MPWatchDevVideoMemInfo;

typedef drIAnimCtrl MPIAnimCtrl;
typedef drIAnimCtrlAgent MPIAnimCtrlAgent;
typedef drIAnimCtrlBone MPIAnimCtrlBone;
typedef drIAnimCtrlObjBone MPIAnimCtrlObjBone;
typedef drIBoundingBox MPIBoundingBox;
typedef drIDeviceObject MPIDeviceObject;
typedef drStaticStreamMgrDebugInfo MPStaticStreamMgrDebugInfo;
typedef drD3DCreateParamAdjustInfo MPD3DCreateParamAdjustInfo;
typedef drDwordByte4 MPDwordByte4;
typedef drIHelperObject MPIHelperObject;
typedef drIMesh MPIMesh;
typedef drIPathInfo MPIPathInfo;
typedef drIPhysique MPIPhysique;
typedef drIPoseCtrl MPIPoseCtrl;
typedef drIPrimitive MPIPrimitive;
typedef drIRenderStateAtomSet MPIRenderStateAtomSet;
typedef drIResBufMgr MPIResBufMgr;
typedef drIResourceMgr MPIResourceMgr;
typedef drISceneMgr MPISceneMgr;
typedef drIStaticStreamMgr MPIStaticStreamMgr;
typedef drISysGraphics MPISysGraphics;
typedef drISystemInfo MPISystemInfo;
typedef drISystem MPISystem;
typedef drITex MPITex;
typedef drITimer MPITimer;
typedef drITimerPeriod MPITimerPeriod;

// macro
#ifndef LE_NEW
#define LE_NEW DR_NEW
#endif

#ifndef LE_DELETE
#define LE_DELETE DR_DELETE
#endif

#ifndef LE_DELETE_A
#define LE_DELETE_A DR_DELETE_A
#endif

// method

#ifndef LEGUIDCreateObject
#define LEGUIDCreateObject drGUIDCreateObject
#endif

#ifndef LEMatrix44Multiply
#define LEMatrix44Multiply drMatrix44Multiply
#endif

#ifndef LERegisterOutputLoseDeviceProc
#define LERegisterOutputLoseDeviceProc drRegisterOutputLoseDeviceProc
#endif

#ifndef LERegisterOutputResetDeviceProc
#define LERegisterOutputResetDeviceProc drRegisterOutputResetDeviceProc
#endif

#ifndef LEVec3Mat44Mul
#define LEVec3Mat44Mul drVec3Mat44Mul
#endif

#ifndef LEVector3Normalize
#define LEVector3Normalize drVector3Normalize
#endif

#ifndef LEVector3Slerp
#define LEVector3Slerp drVector3Slerp
#endif

#ifndef LEVector3Sub
#define LEVector3Sub drVector3Sub
#endif
