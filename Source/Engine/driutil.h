//
#pragma once

#include "drHeader.h"
#include "drInterface.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drClassDecl.h"
#include "drFrontAPI.h"

DR_BEGIN


DR_FRONT_API DR_RESULT drResetDevice(drISysGraphics* sys_graphics, const D3DPRESENT_PARAMETERS* d3dpp);
DR_FRONT_API void drPhysiqueSetMaterial(drIPhysique* phy, const drMaterial* mtl);
DR_FRONT_API drPlayPoseInfo* drItemGetPlayPoseInfo(drIItem* item, DWORD ctrl_type);
DR_FRONT_API drIAnimCtrl* drItemGetAnimCtrl(drIItem* item, DWORD ctrl_type);
DR_FRONT_API DR_RESULT drPrimitiveSetRenderCtrl(drIPrimitive* p, DWORD ctrl_type);
DR_FRONT_API DR_RESULT drPrimitiveSetVertexShader(drIPrimitive* p, DWORD shader_type);
DR_FRONT_API DR_RESULT drPrimitiveGetObjHeight(drIPrimitive* p, float* out_height);

DR_FRONT_API DR_RESULT drPrimitiveTexLit(drIPrimitive* p, const char* file, const char* tex_path, DWORD color_op, DWORD anim_type);
DR_FRONT_API DR_RESULT drPrimitiveTexLitC(drIPrimitive* p, const char* file, const char* tex_path, DWORD anim_type);
DR_FRONT_API DR_RESULT drPrimitiveTexLitA(drIPrimitive* p, const char* alpha_file, const char* tex_file, const char* tex_path, DWORD anim_type);
DR_FRONT_API DR_RESULT drPrimitiveTexLitA(drIPrimitive* p, const char* tex_file, const char* tex_path, DWORD anim_type);
DR_FRONT_API DR_RESULT drPrimitiveTexUnLitA(drIPrimitive* p);

DR_FRONT_API DR_RESULT drLoadTex(drITex** out, drIResourceMgr* res_mgr, const char* file, const char* tex_path, D3DFORMAT fmt);
DR_FRONT_API DR_RESULT drLoadTex(drITex** out, drIResourceMgr* res_mgr, const drTexInfo* info);

DR_FRONT_API drPoseInfo* drAnimCtrlAgentGetPoseInfo(drIAnimCtrlAgent* agent, DWORD subset, DWORD stage, DWORD type, DWORD id);

DR_FRONT_API void drMessageBox( const char* fmt, ... );

DR_FRONT_API void drReleaseTreeNodeList(drITreeNode* node);
DR_FRONT_API int drTreeNodeEnumPreOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param);
DR_FRONT_API int drTreeNodeEnumInOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param);
DR_FRONT_API int drTreeNodeEnumPostOrder(drITreeNode* node, drTreeNodeEnumProc proc, void* param);


class DR_FRONT_API drINodeObjectA
{
public:
    static DR_RESULT PlayDefaultPose(drINodeObject* obj);
};

DR_END
