//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drDirectX.h"
#include "drITypes.h"
#include "drViewFrustum.h"
#include "drInterfaceExt.h"
DR_BEGIN

// 1。具有透明属性的物件只有在显式调用加入scene manger后才做排序
struct drSortPriProcInfo
{
    drTranspPrimitiveProc proc;
    void* param;
};
struct drSortPriInfo
{
    float d;
    drIPrimitive* obj;
    drSortPriProcInfo sppi;
};


class drSceneMgr : public drISceneMgr
{
DR_STD_DECLARATION()

private:
    drISysGraphics* _sys_graphics;
    drIResourceMgr* _res_mgr;
    drIViewFrustum* _vf;
    drSortPriInfo* _sort_obj_seq;
    drSortPriProcInfo _sppi;
    DWORD _sort_obj_seq_size;
    DWORD _sort_obj_num;
    DWORD _max_sort_num;

    
    drCullPriInfo _cull_pri_info;

    drSceneFrameInfo _frame_info;

public:
    drSceneMgr(drISysGraphics* sys_graphics);
    ~drSceneMgr();

    DR_RESULT Update();
    DR_RESULT Render();
    DR_RESULT BeginRender();
    DR_RESULT EndRender();
    DR_RESULT RenderTransparentPrimitive();
    DR_RESULT AddTransparentPrimitive(drIPrimitive* obj);
    DR_RESULT SortTransparentPrimitive();
    void SetTranspPrimitiveProc(drTranspPrimitiveProc proc, void* param) { _sppi.proc = proc; _sppi.param = param; }
    DR_RESULT CullPrimitive(drIPrimitive* obj);
    drIViewFrustum* GetViewFrustum() { return _vf; }
    DWORD GetMaxSortNum() const { return _max_sort_num; }
    void GetCullPrimitiveInfo(drCullPriInfo* info) { *info = _cull_pri_info; }
    drSceneFrameInfo* GetSceneFrameInfo() { return &_frame_info; }
};

DR_END