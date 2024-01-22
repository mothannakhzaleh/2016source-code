//
#include "stdafx.h"
#include "drGuidObj.h"
#include "drIFunc.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drShaderMgr.h"
#include "drGraphicsUtil.h"
#include "drShaderTypes.h"
#include "drPreDefinition.h"
#include "drxRenderCtrlVS.h"


DR_BEGIN

static drISystem* g_system = 0;
static drISysGraphics* g_sys_graphics = 0;

struct drLoseResetDevInfo
{
    drOutputLoseDeviceProc lose_proc;
    drOutputResetDeviceProc reset_proc;
};


#define MAX_LOSE_RESET_DEV_PROC_NUM 8
static DR_RESULT __global_lose_dev_entry();
static DR_RESULT __global_reset_dev_entry();
static drOutputLoseDeviceProc g_lose_dev_seq[MAX_LOSE_RESET_DEV_PROC_NUM];
static drOutputResetDeviceProc g_reset_dev_seq[MAX_LOSE_RESET_DEV_PROC_NUM];


static DR_RESULT __global_lose_dev_entry()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_lose_dev_seq[i])
        {
            if(DR_FAILED((*g_lose_dev_seq[i])()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
};

static DR_RESULT __global_reset_dev_entry()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_reset_dev_seq[i])
        {
            if(DR_FAILED((*g_reset_dev_seq[i])()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
};

DR_RESULT drRegisterOutputLoseDeviceProc(drOutputLoseDeviceProc proc)
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_lose_dev_seq[i])
            continue;

        g_lose_dev_seq[i] = proc;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

DR_RESULT drRegisterOutputResetDeviceProc(drOutputResetDeviceProc proc)
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_reset_dev_seq[i])
            continue;

        g_reset_dev_seq[i] = proc;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

DR_RESULT drUnregisterOutputLoseDeviceProc(drOutputLoseDeviceProc proc)
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_lose_dev_seq[i] != proc)
            continue;

        g_lose_dev_seq[i] = 0;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}
DR_RESULT drUnregisterOutputResetDeviceProc(drOutputResetDeviceProc proc)
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_LOSE_RESET_DEV_PROC_NUM; i++)
    {
        if(g_reset_dev_seq[i] != proc)
            continue;

        g_reset_dev_seq[i] = 0;
        ret = DR_RET_OK;
        break;
    }

    return ret;
}

void drSetActiveIGraphicsSystem(drISysGraphics* sys_graphics)
{
    drSysGraphics::SetActiveIGraphicsSystem(sys_graphics);
}

drISysGraphics* drGetActiveIGraphicsSystem()
{
    return drSysGraphics::GetActiveIGraphicsSystem();
}

//
DR_RESULT drAdjustD3DCreateParam(IDirect3DX* d3d, drD3DCreateParam* param, drD3DCreateParamAdjustInfo* adjust_info)
{
    if(param->present_param.BackBufferFormat == D3DFMT_UNKNOWN)
    {
        D3DDISPLAYMODE d3ddm;
        d3d->GetAdapterDisplayMode(param->adapter, &d3ddm);
        param->present_param.BackBufferFormat = d3ddm.Format;
    }

    if(adjust_info->multi_sample_type)
    {
        while(adjust_info->multi_sample_type > 0)
        {
            if(SUCCEEDED(d3d->CheckDeviceMultiSampleTypeX(
                param->adapter, 
                param->dev_type, 
                param->present_param.BackBufferFormat,
                param->present_param.Windowed, 
                adjust_info->multi_sample_type, 
                NULL
                )))
            {
                param->present_param.MultiSampleType = adjust_info->multi_sample_type;
                param->present_param.SwapEffect = D3DSWAPEFFECT_DISCARD;
                break;
            }

            adjust_info->multi_sample_type = (D3DMULTISAMPLE_TYPE)((DWORD)adjust_info->multi_sample_type - 1);
        }
    }

    return DR_RET_OK;
}

DR_RESULT drInitMeshLibSystem(drISystem** ret_sys, drISysGraphics** ret_sys_graphics)
{
    DR_RESULT ret = DR_RET_FAILED;
    drISystem* sys = 0;
    drISysGraphics* sys_graphics = 0;
    drIDeviceObject* dev_obj = 0;

    if(DR_FAILED(drCreateObjectGUID((DR_VOID**)&sys, DR_GUID_SYSTEM)))
        goto __ret;

    if(DR_FAILED(sys->Initialize()))
        goto __ret;


    // begin init path info
    drIPathInfo* path_info = 0;

    if(DR_FAILED(sys->GetInterface((DR_VOID**)&path_info, DR_GUID_PATHINFO)))
        goto __ret;

    path_info->SetPath(PATH_TYPE_WORKINGDIRECTORY, ".\\");

    path_info->SetPath(PATH_TYPE_MODEL, ".\\model\\");
    path_info->SetPath(PATH_TYPE_MODEL_CHARACTER, ".\\model\\character\\");
    path_info->SetPath(PATH_TYPE_MODEL_SCENE, ".\\model\\scene\\");
    path_info->SetPath(PATH_TYPE_MODEL_ITEM, ".\\model\\item\\");

    path_info->SetPath(PATH_TYPE_TEXTURE, ".\\texture\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_CHARACTER, ".\\texture\\character\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_SCENE, ".\\texture\\scene\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_ITEM, ".\\texture\\item\\");

    path_info->SetPath(PATH_TYPE_ANIMATION, ".\\animation\\");
#if(defined DR_USE_DX8)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx8\\");
#endif
#if(defined DR_USE_DX9)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx9\\");
#endif

    // end

    if(DR_FAILED(sys->CreateGraphicsSystem(&sys_graphics)))
        goto __ret;

    drInitUserRenderCtrlVSProc(sys_graphics->GetResourceMgr());

    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    opt_mgr->SetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE, 0);

    // begin set default active system
    drSetActiveISystem(sys);
    drSetActiveIGraphicsSystem(sys_graphics);
    // end
       

    g_system = sys;
    g_sys_graphics = sys_graphics;

    if(ret_sys)
    {
        *ret_sys = sys;
    }

    if(ret_sys_graphics)
    {
        *ret_sys_graphics = sys_graphics;
    }

    sys = 0;
    sys_graphics = 0;

    ret = DR_RET_OK;

__ret:
    DR_SAFE_RELEASE(sys);
    DR_SAFE_RELEASE(sys_graphics);

    return ret;

}

DR_RESULT drInitMeshLibSystem(drISystem** ret_sys, drISysGraphics** ret_sys_graphics, IDirect3DX* d3d, IDirect3DDeviceX* dev, HWND hwnd)
{
    DR_RESULT ret = DR_RET_FAILED;
    drISystem* sys = 0;
    drISysGraphics* sys_graphics = 0;
    drIDeviceObject* dev_obj = 0;

    if(DR_FAILED(drCreateObjectGUID((DR_VOID**)&sys, DR_GUID_SYSTEM)))
        goto __ret;

    if(DR_FAILED(sys->Initialize()))
        goto __ret;

    // check current directx version
    {
        DWORD ver = sys->GetSystemInfo()->GetDirectXVersion();
        if(ver < DX_VERSION_8_1)
        {
            ret = INIT_ERR_DX_VERSION;
            goto __ret;
        }
    }

    // begin init path info
    drIPathInfo* path_info = 0;

    if(DR_FAILED(sys->GetInterface((DR_VOID**)&path_info, DR_GUID_PATHINFO)))
        goto __ret;

    path_info->SetPath(PATH_TYPE_WORKINGDIRECTORY, ".\\");

    path_info->SetPath(PATH_TYPE_MODEL, ".\\model\\");
    path_info->SetPath(PATH_TYPE_MODEL_CHARACTER, ".\\model\\character\\");
    path_info->SetPath(PATH_TYPE_MODEL_SCENE, ".\\model\\scene\\");
    path_info->SetPath(PATH_TYPE_MODEL_ITEM, ".\\model\\item\\");

    path_info->SetPath(PATH_TYPE_TEXTURE, ".\\texture\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_CHARACTER, ".\\texture\\character\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_SCENE, ".\\texture\\scene\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_ITEM, ".\\texture\\item\\");

    path_info->SetPath(PATH_TYPE_ANIMATION, ".\\animation\\");
#if(defined DR_USE_DX8)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx8\\");
#endif
#if(defined DR_USE_DX9)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx9\\");
#endif
    // end

    if(DR_FAILED(sys->CreateGraphicsSystem(&sys_graphics)))
        goto __ret;

    // set golbal lose-reset dev call back
    sys_graphics->SetOutputLoseDeviceProc(__global_lose_dev_entry);
    sys_graphics->SetOutputResetDeviceProc(__global_reset_dev_entry);

    dev_obj = sys_graphics->GetDeviceObject();
    dev_obj->SetDirect3D(d3d);
    dev_obj->SetDevice(dev);

    if(DR_FAILED(dev_obj->InitStateCache()))
        goto __ret;

    if(DR_FAILED(dev_obj->InitCapsInfo()))
        goto __ret;

    drIResourceMgr* res_mgr = sys_graphics->GetResourceMgr();
    drIStaticStreamMgr* ssm = res_mgr->GetStaticStreamMgr();
    ssm->CreateStreamEntitySeq(4096, 4096);
    ssm->CreateVertexBufferStream(0, 4000 * 4000);
	ssm->CreateVertexBufferStream(1, 4000 * 4000);
	ssm->CreateIndexBufferStream(0, 4000 * 4000);
    drIDynamicStreamMgr* dsm = res_mgr->GetDynamicStreamMgr();
	dsm->Create(4000 * 4000, 4000 * 4000);

    // begin set default active system
    drSetActiveISystem(sys);
    drSetActiveIGraphicsSystem(sys_graphics);
    // end

    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    opt_mgr->SetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE, 1);
#if(defined OPT_CULLPRIMITIVE)
    opt_mgr->SetByteFlag(OPTION_FLAG_CULLPRIMITIVE_MODEL, 1);
#endif

    //
    drInitUserRenderCtrlVSProc(res_mgr);

    g_system = sys;
    g_sys_graphics = sys_graphics;

    if(ret_sys)
    {
        *ret_sys = sys;
    }

    if(ret_sys_graphics)
    {
        *ret_sys_graphics = sys_graphics;
    }

    sys = 0;
    sys_graphics = 0;

    ret = DR_RET_OK;

__ret:
    DR_SAFE_RELEASE(sys);
    DR_SAFE_RELEASE(sys_graphics);

    return ret;
}

DR_RESULT drInitMeshLibSystem(drISystem** ret_sys, drISysGraphics** ret_sys_graphics, drD3DCreateParam* param, drD3DCreateParamAdjustInfo* param_info)
{
    DR_RESULT ret = DR_RET_FAILED;
    drISystem* sys = 0;
    drISysGraphics* sys_graphics = 0;
    drIDeviceObject* dev_obj = 0;

    if(DR_FAILED(drCreateObjectGUID((DR_VOID**)&sys, DR_GUID_SYSTEM)))
        goto __ret;

    if(DR_FAILED(sys->Initialize()))
        goto __ret;

    // check current directx version
    {
        DWORD ver = sys->GetSystemInfo()->GetDirectXVersion();
        if(ver < DX_VERSION_8_1)
        {
            ret = INIT_ERR_DX_VERSION;
            goto __ret;
        }
    }

    if(DR_FAILED(sys->CreateGraphicsSystem(&sys_graphics)))
        goto __ret;

    // set golbal lose-reset dev call back
    sys_graphics->SetOutputLoseDeviceProc(__global_lose_dev_entry);
    sys_graphics->SetOutputResetDeviceProc(__global_reset_dev_entry);


    // begin init path info
    drIPathInfo* path_info = 0;

    if(DR_FAILED(sys->GetInterface((DR_VOID**)&path_info, DR_GUID_PATHINFO)))
        goto __ret;

    path_info->SetPath(PATH_TYPE_WORKINGDIRECTORY, ".\\");

    path_info->SetPath(PATH_TYPE_MODEL, ".\\model\\");
    path_info->SetPath(PATH_TYPE_MODEL_CHARACTER, ".\\model\\character\\");
    path_info->SetPath(PATH_TYPE_MODEL_SCENE, ".\\model\\scene\\");
    path_info->SetPath(PATH_TYPE_MODEL_ITEM, ".\\model\\item\\");

    path_info->SetPath(PATH_TYPE_TEXTURE, ".\\texture\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_CHARACTER, ".\\texture\\character\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_SCENE, ".\\texture\\scene\\");
    path_info->SetPath(PATH_TYPE_TEXTURE_ITEM, ".\\texture\\item\\");

    path_info->SetPath(PATH_TYPE_ANIMATION, ".\\animation\\");
#if(defined DR_USE_DX8)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx8\\");
#endif
#if(defined DR_USE_DX9)
    path_info->SetPath(PATH_TYPE_SHADER, ".\\shader\\dx9\\");
#endif
    // end


    dev_obj = sys_graphics->GetDeviceObject();

    if(DR_FAILED(dev_obj->CreateDirect3D()))
    {
        ret = INIT_ERR_CREATE_D3D;
        goto __ret;
    }

    if(param_info)
    {
        if(DR_FAILED(drAdjustD3DCreateParam(dev_obj->GetDirect3D(), param, param_info)))
            goto __ret;
    }

    if(DR_FAILED(dev_obj->CreateDevice(param)))
    {
        ret = INIT_ERR_CREATE_DEVICE;
        goto __ret;
    }

    if(DR_FAILED(dev_obj->InitStateCache()))
        goto __ret;

    if(DR_FAILED(dev_obj->InitCapsInfo()))
        goto __ret;

    drIResourceMgr* res_mgr = sys_graphics->GetResourceMgr();
    drIStaticStreamMgr* ssm = res_mgr->GetStaticStreamMgr();
    ssm->CreateStreamEntitySeq(4096, 4096);
    ssm->CreateVertexBufferStream(0, 4000 * 4000);
	ssm->CreateVertexBufferStream(1, 4000 * 4000);
	ssm->CreateVertexBufferStream(2, 4000 * 4000);
	ssm->CreateIndexBufferStream(0, 4000 * 4000);
    drIDynamicStreamMgr* dsm = res_mgr->GetDynamicStreamMgr();
	dsm->Create(4000 * 4000, 4000 * 4000);

    // begin set default active system
    drSetActiveISystem(sys);
    drSetActiveIGraphicsSystem(sys_graphics);
    // end

    //
    drInitUserRenderCtrlVSProc(res_mgr);

    /*
    // set render state
    dev_obj->SetRenderState(D3DRS_ZENABLE, D3DZB_TRUE);
    dev_obj->SetRenderState(D3DRS_ZWRITEENABLE, TRUE);
    dev_obj->SetRenderState(D3DRS_LIGHTING, TRUE);

    ////Enable alpha blending so we can use transparent textures
    dev_obj->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
    dev_obj->SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
    //dev_obj->SetRenderState(D3DRS_ALPHAFUNC, D3DCLE_GREATEREQUAL);
    //dev_obj->SetRenderState(D3DRS_ALPHAREF, 200);

    //Set how the texture should be blended (use alpha)
    dev_obj->SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);
    dev_obj->SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);

    dev_obj->SetRenderState(D3DRS_AMBIENT, D3DCOLOR_XRGB(128, 128, 128));
    // end
    */


    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    opt_mgr->SetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE, 1);
#if(defined OPT_CULLPRIMITIVE)
    opt_mgr->SetByteFlag(OPTION_FLAG_CULLPRIMITIVE_MODEL, 1);
#endif

    g_system = sys;
    g_sys_graphics = sys_graphics;

    if(ret_sys)
    {
        *ret_sys = sys;
        sys = 0;
    }

    if(ret_sys_graphics)
    {
        *ret_sys_graphics = sys_graphics;
        sys_graphics = 0;
    }


    ret = DR_RET_OK;

__ret:
    DR_SAFE_RELEASE(sys);
    DR_SAFE_RELEASE(sys_graphics);

    return ret;
}

DR_RESULT drReleaseMeshLibSystem()
{
    DR_ULONG ref_cnt = 0;
    drISystem* sys = 0;
    drISysGraphics* sys_graphics = 0;

    if((sys = drGetActiveISystem()) == 0)
        goto __ret;

    if((sys_graphics = drGetActiveIGraphicsSystem()) == 0)
        goto __ret;

    sys_graphics->Release();

    sys->Release();

    return DR_RET_OK;
__ret:
    assert(0 && "release mesh lib error");
    return DR_RET_FAILED;
}

void drSetActiveISystem(drISystem* sys)
{
    drSystem::SetActiveISystem(sys);
}

drISystem* drGetActiveISystem()
{
    return drSystem::__system;
}


DR_RESULT drReleaseD3DObject(drISystem* sys, drISysGraphics* sys_graphics)
{
    sys->Release();
    sys_graphics->Release();

    return DR_RET_OK;
}

void drHelperSetForceIgnoreTexFlag(DWORD flag)
{
    drISystem* sys = drGetActiveISystem();
    if(sys == NULL)
        return;

    drIOptionMgr* opt_mgr;
    sys->GetInterface((DR_VOID**)&opt_mgr, DR_GUID_OPTIONMGR);
    opt_mgr->SetIgnoreModelTexFlag((BYTE)flag);
}

void drUpdateSceneTransparentObject()
{
    drISceneMgr* scene_mgr = g_sys_graphics->GetSceneMgr();

    //scene_mgr->Update();
    scene_mgr->SortTransparentPrimitive();
    scene_mgr->RenderTransparentPrimitive();
}

DR_RESULT LoadResBuf(drIResourceMgr* res_mgr, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIResBufMgr* buf_mgr = res_mgr->GetResBufMgr();
    drIPathInfo* path_info = 0;
    res_mgr->GetSysGraphics()->GetSystem()->GetInterface((DR_VOID**)&path_info, DR_GUID_PATHINFO);

    FILE* fp;
	fopen_s( &fp, file, "rt");
    if(fp == 0)
        goto __ret;

    char path[DR_MAX_PATH];
    char model_file[DR_MAX_PATH];
    DWORD model_num;
    DR_HANDLE handle;
    drModelObjInfo* model_info;
    drGeomObjInfo* geom_info;
    drTexInfo* tex_info;
    drSysMemTexInfo smti;

    fscanf_s(fp, "%d\n", &model_num);

    for(DWORD i = 0; i < model_num; i++)
    {
        fscanf_s(fp, "%s\n", model_file);
        _snprintf_s(path, DR_MAX_PATH, _TRUNCATE,"%s%s", path_info->GetPath(PATH_TYPE_MODEL_SCENE), model_file);

        if(DR_FAILED(buf_mgr->RegisterModelObjInfo(&handle, path)))
        {
            drMessageBox("cannot find model file: %s", path);
            continue;

            //goto __ret;
        }

        if(DR_FAILED(buf_mgr->GetModelObjInfo((drIModelObjInfo**)&model_info, handle)))
            goto __ret;

        for(DWORD j = 0; j < model_info->geom_obj_num; j++)
        {
            geom_info = model_info->geom_obj_seq[j];

            for(DWORD k = 0; k < geom_info->mtl_num; k++)
            {
                tex_info = &geom_info->mtl_seq[k].tex_seq[0];

                smti.colorkey = tex_info->colorkey.color;
                smti.level = tex_info->level;
                smti.format = tex_info->format == D3DFMT_UNKNOWN ? D3DFMT_A1R5G5B5 : tex_info->format;
                smti.filter = D3DX_DEFAULT;
                smti.mip_filter = D3DX_DEFAULT;
                _snprintf_s(smti.file_name,DR_MAX_PATH, _TRUNCATE, "%s%s", path_info->GetPath(PATH_TYPE_TEXTURE_SCENE), tex_info->file_name);

                if(DR_FAILED(buf_mgr->RegisterSysMemTex(&handle, &smti)))
                {
                    drMessageBox("cannot find texture file: %s in model file: path", smti.file_name, path);                    
                    continue;
                    //goto __ret;
                }
            }
                
        }
    }

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }
    
    return ret;
}

DR_RESULT LoadResModelBuf(drIResourceMgr* res_mgr, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIResBufMgr* buf_mgr = res_mgr->GetResBufMgr();
    drIPathInfo* path_info = 0;
    res_mgr->GetSysGraphics()->GetSystem()->GetInterface((DR_VOID**)&path_info, DR_GUID_PATHINFO);

    FILE* fp;
	fopen_s( &fp, file, "rt");
    if(fp == 0)
        goto __ret;

    char path[DR_MAX_PATH];
    char model_file[DR_MAX_PATH];
    DWORD model_num;
    DR_HANDLE handle;

    fscanf_s(fp, "%d\n", &model_num);

    for(DWORD i = 0; i < model_num; i++)
    {
        fscanf_s(fp, "%d\t%s\n", &handle, model_file);
        _snprintf_s(path, DR_MAX_PATH, _TRUNCATE,"%s%s", path_info->GetPath(PATH_TYPE_MODEL_SCENE), model_file);

        if(DR_FAILED(buf_mgr->RegisterModelObjInfo(handle, path)))
        {
            drMessageBox("cannot find model file: %s", path);
            continue;
        }
    }

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }
    
    return ret;
}

// dump function
DR_RESULT drDumpMeshInfo(const char* file, const drMeshInfo* info)
{
	FILE* fp;
	fopen_s( &fp, file, "wt");
    if(fp == 0)
        return DR_RET_FAILED;

    fprintf(fp, "Dump Mesh Information\n\n\n");

    int vertex_subset_flag = info->subset_num > 0 ? 1 : 0;
    int vertex_normal_flag = info->normal_seq ? 1 : 0;
    int texture_coordinate_flag = info->texcoord0_seq ? 1 : 0;
    int vertex_color_flag = info->vercol_seq ? 1 : 0;
    int vertex_blend_flag = info->blend_seq ? 1 : 0;
    int bone_index_flag = info->bone_index_num > 0 ? 1 : 0;
    int vertex_index_flag = info->index_seq ? 1 : 0;

    fprintf(fp, "VertexSubset Flag:        %d\n", vertex_subset_flag);
    fprintf(fp, "VertexNormal Flag:        %d\n", vertex_normal_flag);
    fprintf(fp, "VertexColor Flag:         %d\n", vertex_color_flag);
    fprintf(fp, "TextureCoordinate Flag:   %d\n", texture_coordinate_flag);
    fprintf(fp, "VertexIndex Flag:         %d\n", vertex_index_flag);
    fprintf(fp, "VertexBlend Flag:         %d\n", vertex_blend_flag);
    fprintf(fp, "BoneIndex Flag:           %d\n", bone_index_flag);

    DWORD i;
    drVector2* v2;
    drVector3* v3;
    DWORD c, *n;
    const drBlendInfo* b;
    const drSubsetInfo* s;


    if(vertex_subset_flag)
    {
        fprintf(fp, "Begin VertexSubset %d\n", info->subset_num);

        for(i = 0; i < info->subset_num; i++)
        {            
            s = &info->subset_seq[i];
            fprintf(fp, "%5d\t min_index: %5d vertex_num: %5d start_index: %5d primitive_num: %5d\n", i, 
                s->min_index, s->vertex_num, s->start_index, s->primitive_num);
        }
        fprintf(fp, "End VertexSubset\n\n\n");        
    }

    fprintf(fp, "Begin Vertex %d\n", info->vertex_num);

    for(i = 0; i < info->vertex_num; i++)
    {
        v3 = &info->vertex_seq[i];
        fprintf(fp, "%5d\t %10.5f %10.5f %10.5f\n", i, v3->x, v3->y, v3->z);
    }

    fprintf(fp, "End Vertex\n\n\n");

    if(vertex_normal_flag)
    {
        fprintf(fp, "Begin VertexNormal %d\n", info->vertex_num);

        for(i = 0; i < info->vertex_num; i++)
        {
            v3 = &info->normal_seq[i];
            fprintf(fp, "%5d\t %10.5f %10.5f %10.5f\n", i, v3->x, v3->y, v3->z);
        }

        fprintf(fp, "End VertexNormal\n\n\n");
    }

    if(vertex_color_flag)
    {
        fprintf(fp, "Begin VertexColor %d\n", info->vertex_num);

        for(i = 0; i < info->vertex_num; i++)
        {
            c = info->vercol_seq[i];
            fprintf(fp, "%5d\t %03d %03d %03d %03d\n", i, 
                DR_COLOR_R(c), DR_COLOR_G(c), DR_COLOR_B(c), DR_COLOR_A(c));
        }

        fprintf(fp, "End VertexColor\n\n\n");        
    }

    if(texture_coordinate_flag)
    {
        fprintf(fp, "Begin TextureCoordinate %d\n", info->vertex_num);

        for(i = 0; i < info->vertex_num; i++)
        {
            v2 = &info->texcoord0_seq[i];
            fprintf(fp, "%5d\t %10.5f %10.5f\n", i, v2->x, v2->y);
        }

        fprintf(fp, "End TextureCoordinate\n\n\n");
    }

    if(vertex_index_flag)
    {
        fprintf(fp, "Begin VertexIndex %d\n", info->index_num);

        for(i = 0; i < info->index_num / 3; i++)
        {
            n = &info->index_seq[i * 3];
            fprintf(fp, "%5d\t %5d %5d %5d\n", i, n[0], n[1], n[2]);
        }
        fprintf(fp, "End VertexIndex\n\n\n");        
    }
    
    
    if(vertex_blend_flag)
    {
        fprintf(fp, "Begin VertexBlend %d\n", info->vertex_num);

        for(i = 0; i < info->vertex_num; i++)
        {
            b = &info->blend_seq[i];
            fprintf(fp, "%5d\t %03d %03d %03d %03d %10.5f %10.5f %10.5f %10.5f\n", i,
                b->index[0], b->index[1], b->index[2], b->index[3], 
                b->weight[0], b->weight[1], b->weight[2], b->weight[3]);
        }
        fprintf(fp, "End VertexBlend\n\n\n");        
    }

    if(bone_index_flag)
    {
        fprintf(fp, "Begin BoneIndex %d\n", info->bone_index_num);

        for(i = 0; i < info->bone_index_num; i++)
        {
            fprintf(fp, "%5d\t %03d\n", i, info->bone_index_seq[i]);
        }
        fprintf(fp, "End BoneIndex\n\n\n");        
    }
    
    
    if(fp)
    {
        fclose(fp);
    }

    return DR_RET_OK;
}


DR_END
