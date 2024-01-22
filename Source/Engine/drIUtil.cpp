//


#include "drIUtil.h"
#include "drGUIDObj.h"
#include "drNodeObject.h"

DR_BEGIN

DR_FRONT_API DR_RESULT drResetDevice(drISysGraphics* sys_graphics, const D3DPRESENT_PARAMETERS* d3dpp)
{
    return 0;
}


DR_RESULT drLoadTex(drITex** out, drIResourceMgr* res_mgr, const char* file, const char* tex_path, D3DFORMAT fmt)
{
    DR_RESULT ret = DR_RET_FAILED;

    drITex* tex;

    if(DR_FAILED(res_mgr->CreateTex(&tex)))
        goto __ret;

    drTexInfo tex_info;
    drTexInfo_Construct(&tex_info);

    tex_info.stage = 0; // default stage 0
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = fmt;
    tex_info.pool = D3DPOOL_DEFAULT;
    _tcsncpy_s(tex_info.file_name, file, _TRUNCATE);

    if(DR_FAILED(tex->LoadTexInfo(&tex_info, tex_path)))
        goto __ret;

    if(DR_FAILED(tex->LoadVideoMemory()))
        goto __ret;

    *out = tex;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drLoadTex(drITex** out, drIResourceMgr* res_mgr, const drTexInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drITex* tex;

    if(DR_FAILED(res_mgr->CreateTex(&tex)))
        goto __ret;

    if(DR_FAILED(tex->LoadTexInfo(info, 0)))
        goto __ret;

    if(DR_FAILED(tex->LoadVideoMemory()))
        goto __ret;

    *out = tex;

    ret = DR_RET_OK;
__ret:
    return ret;
}

void drPhysiqueSetMaterial(drIPhysique* phy, const drMaterial* mtl)
{
    drIPrimitive* p;

    for(DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++)
    {
        if((p = phy->GetPrimitive(i)) == 0)
            continue;

        p->SetMaterial(mtl);
    }
}

DR_FRONT_API drIAnimCtrl* drItemGetAnimCtrl(drIItem* item, DWORD ctrl_type)
{
    drIAnimCtrl* ret = 0;

    if(item == 0)
        goto __ret;

    drIPrimitive* p = item->GetPrimitive();
    if(p == 0)
        goto __ret;

    drIAnimCtrlAgent* agent = p->GetAnimAgent();
    if(agent == 0)
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* ctrl_obj = agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == 0)
        goto __ret;

    ret = ctrl_obj->GetAnimCtrl();

__ret:
    return ret;
}

DR_FRONT_API drPlayPoseInfo* drItemGetPlayPoseInfo(drIItem* item, DWORD ctrl_type)
{
    drPlayPoseInfo* ret = 0;

    if(item == 0)
        goto __ret;

    drIPrimitive* p = item->GetPrimitive();
    if(p == 0)
        goto __ret;

    drIAnimCtrlAgent* agent = p->GetAnimAgent();
    if(agent == 0)
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* ctrl_obj = agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == 0)
        goto __ret;

    ret = ctrl_obj->GetPlayPoseInfo();

__ret:
    return ret;
}


DR_RESULT drPrimitiveSetRenderCtrl(drIPrimitive* p, DWORD ctrl_type)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrlAgent* render_agent = p->GetRenderCtrlAgent();
    if(render_agent == 0)
        goto __ret;

    if(DR_FAILED(render_agent->SetRenderCtrl(ctrl_type)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drPrimitiveSetVertexShader(drIPrimitive* p, DWORD shader_type)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrlAgent* render_agent = p->GetRenderCtrlAgent();
    if(render_agent == 0)
        goto __ret;

    render_agent->SetVertexShader(shader_type);

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drPrimitiveGetObjHeight(drIPrimitive* p, float* out_height)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIHelperObject* h_obj = p->GetHelperObject();
    if(h_obj == 0)
        goto __ret;

    //drIBoundingSphere* bs = h_obj->GetBoundingSphere();
    //if(bs)
    //{
    //    drBoundingSphereInfo* bsi = bs->GetObjInfo(0);        
    //    bsi->sphere.c
    //}

    drIBoundingBox* bb = h_obj->GetBoundingBox();
    if(bb)
    {
        drVector3 pos;
        drMatrix44 mat;
        drBoundingBoxInfo* bbi = bb->GetDataInfo(0);
        pos = bbi->box.c;
        pos.z += bbi->box.r.z;

        drMatrix44Multiply(&mat, &bbi->mat, p->GetMatrixGlobal());
        drVec3Mat44Mul(&pos, &mat);
        *out_height = pos.z;
    }
    else
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

// ======= anim proc
typedef DR_RESULT (*drTexUVAnimProc)(drIAnimCtrlTexUV* ctrl_texuv);

DR_RESULT drTexUVAnim0(drIAnimCtrlTexUV* ctrl_texuv)
{
    drIAnimKeySetPRS* keyset_prs;
    drGUIDCreateObject((DR_VOID**)&keyset_prs, DR_GUID_ANIMKEYSETPRS);

    // position
    {
        drKeyVector3 buf[2];
        buf[0].key = 0;
        buf[0].slerp_type = AKST_LINEAR;
        buf[0].data = drVector3(0.0f, 0.0f, 0.0f);
        buf[1].key = 359;
        buf[1].slerp_type = AKST_LINEAR;
        buf[1].data = drVector3(1.0f, 1.0f, 0.0f);

        keyset_prs->AddKeyPosition(0, buf, 2);
    }

    ctrl_texuv->SetAnimKeySetPRS(keyset_prs);

    //const int t = 120;
    //drMatrix44 uvmat_seq[t];
    //float u = 0.0f;
    //float v = 0.0f;
    //float x = 1.0f / t;
    //for( DWORD i = 0; i < t; i++ )
    //{
    //    drMatrix44Identity(&uvmat_seq[i]);
    //    uvmat_seq[ i ]._31 = u;
    //    uvmat_seq[ i ]._32 = v;
    //    u += x;
    //    v += x;
    //};
    //ctrl_texuv->LoadData(uvmat_seq, t);

    return DR_RET_OK;
}

DR_RESULT drTexUVAnim1(drIAnimCtrlTexUV* ctrl_texuv)
{
    drIAnimKeySetPRS* keyset_prs;
    drGUIDCreateObject((DR_VOID**)&keyset_prs, DR_GUID_ANIMKEYSETPRS);

    // rotation
    {
        drVector3 axis(0.0f, 0.0f, 1.0f);

        drKeyQuaternion buf[3];
        buf[0].key = 0;
        buf[0].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
        buf[1].key = 60;
        buf[1].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);    
        buf[2].key = 119;
        buf[2].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);    

        keyset_prs->AddKeyRotation(0, buf, 3);
    }

    ctrl_texuv->SetAnimKeySetPRS(keyset_prs);

    //const int t = 120;
    //drMatrix44 uvmat_seq[t];
    //float u = 0.0f;
    //float v = 0.0f;
    //float x = 1.0f / t;
    //float y = DR_2_PI / t;

    //for( DWORD i = 0; i < t; i++ )
    //{
    //    drMatrix44Identity(&uvmat_seq[i]);
    //    uvmat_seq[i]._11 = cosf(u);
    //    uvmat_seq[i]._12 = -sinf(v);
    //    uvmat_seq[i]._21 = sinf(u);
    //    uvmat_seq[i]._22 = cosf(v);

    //    u += y;
    //    v += y;
    //};

    //ctrl_texuv->LoadData(uvmat_seq, t);

    return DR_RET_OK;
}
DR_RESULT drTexUVAnim2(drIAnimCtrlTexUV* ctrl_texuv)
{
    drIAnimKeySetPRS* keyset_prs;
    drGUIDCreateObject((DR_VOID**)&keyset_prs, DR_GUID_ANIMKEYSETPRS);

    // position
    {
        drKeyVector3 buf[2];
        buf[0].key = 0;
        buf[0].slerp_type = AKST_LINEAR;
        buf[0].data = drVector3(0.0f, 0.0f, 0.0f);
        buf[1].key = 359;
        buf[1].slerp_type = AKST_LINEAR;
        buf[1].data = drVector3(1.0f, 1.0f, 0.0f);

        keyset_prs->AddKeyPosition(0, buf, 2);
    }

    // rotation
    {
        drVector3 axis(0.0f, 0.0f, 1.0f);

        drKeyQuaternion buf[3];
        buf[0].key = 0;
        buf[0].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
        buf[1].key = 180;
        buf[1].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);    
        buf[2].key = 359;
        buf[2].slerp_type = AKST_LINEAR;
        drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);    

        keyset_prs->AddKeyRotation(0, buf, 3);
    }

    ctrl_texuv->SetAnimKeySetPRS(keyset_prs);

    //const int t = 120;
    //drMatrix44 uvmat_seq[t];
    //float u = 0.0f;
    //float v = 0.0f;
    //float m = 0.0f;
    //float n = 0.0f;
    //float x = DR_2_PI / t;
    //for( DWORD i = 0; i < t; i++ )
    //{
    //    drMatrix44Identity(&uvmat_seq[i]);
    //    uvmat_seq[i]._31 = m;
    //    uvmat_seq[i]._32 = n;
    //    uvmat_seq[i]._11 = cosf(u);
    //    uvmat_seq[i]._12 = -sinf(v);
    //    uvmat_seq[i]._21 = sinf(u);
    //    uvmat_seq[i]._22 = cosf(v);
    //    m += x;
    //    n += x;
    //    u += x;
    //    v += x;
    //};
    //ctrl_texuv->LoadData(uvmat_seq, t);

    return DR_RET_OK;
}
DR_RESULT drTexUVAnim3(drIAnimCtrlTexUV* ctrl_texuv)
{
    drIAnimKeySetPRS* keyset_prs;
    drGUIDCreateObject((DR_VOID**)&keyset_prs, DR_GUID_ANIMKEYSETPRS);

    // rotation
    drVector3 axis(0.0f, 0.0f, 1.0f);

    drKeyQuaternion buf[3];
    buf[0].key = 0;
    buf[0].slerp_type = AKST_LINEAR;
    drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
    buf[1].key = 360;
    buf[1].slerp_type = AKST_LINEAR;
    drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);    
    buf[2].key = 719;
    buf[2].slerp_type = AKST_LINEAR;
    drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);    

    keyset_prs->AddKeyRotation(0, buf, 3);
    ctrl_texuv->SetAnimKeySetPRS(keyset_prs);

    //const int t = 360;
    //drMatrix44 uvmat_seq[t];
    //float u = 0.0f;
    //float v = 0.0f;
    //float x = 1.0f / t;
    //float y = DR_2_PI / t;

    //for( DWORD i = 0; i < t; i++ )
    //{
    //    drMatrix44Identity(&uvmat_seq[i]);
    //    uvmat_seq[i]._11 = cosf(u);
    //    uvmat_seq[i]._12 = -sinf(v);
    //    uvmat_seq[i]._21 = sinf(u);
    //    uvmat_seq[i]._22 = cosf(v);

    //    u += y;
    //    v += y;
    //};

    //ctrl_texuv->LoadData(uvmat_seq, t);

    return DR_RET_OK;
}

DR_RESULT drTexUVAnim4(drIAnimCtrlTexUV* ctrl_texuv)
{
    drIAnimKeySetPRS* keyset_prs;
    drGUIDCreateObject((DR_VOID**)&keyset_prs, DR_GUID_ANIMKEYSETPRS);

    drKeyVector3 buf[2];
    buf[0].key = 0;
    buf[0].slerp_type = AKST_LINEAR;
    buf[0].data = drVector3(0.0f, 0.0f, 0.0f);
    buf[1].key = 119;
    buf[1].slerp_type = AKST_LINEAR;
    buf[1].data = drVector3(1.0f, 1.0f, 0.0f);

    keyset_prs->AddKeyPosition(0, buf, 2);
    ctrl_texuv->SetAnimKeySetPRS(keyset_prs);

    //const int t = 360;
    //drMatrix44 uvmat_seq[t];
    //float u = 0.0f;
    //float v = 0.0f;
    //float x = 1.0f / t;
    //for( DWORD i = 0; i < t; i++ )
    //{
    //    drMatrix44Identity(&uvmat_seq[i]);
    //    uvmat_seq[ i ]._31 = u;
    //    uvmat_seq[ i ]._32 = v;
    //    u += x;
    //    v += x;
    //};
    //ctrl_texuv->LoadData(uvmat_seq, t);

    return DR_RET_OK;
}

static const int __texuv_animproc_num = 5;
static drTexUVAnimProc __texuv_animproc_seq[__texuv_animproc_num] =
{
    drTexUVAnim0,
    drTexUVAnim1,
    drTexUVAnim2,
    drTexUVAnim3,
    drTexUVAnim4,
};

DR_RESULT drPrimitiveTexLit(drIPrimitive* p, const char* file, const char* tex_path, DWORD color_op, DWORD anim_type)
{
    // ----begin----
    drITex* tex;
    drIResourceMgr* res_mgr = p->GetResourceMgr();
    res_mgr->CreateTex(&tex);
    drTexInfo tex_info;
    drTexInfo_Construct(&tex_info);

    tex_info.stage = 1;
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = D3DFMT_A8R8G8B8;
    tex_info.pool = D3DPOOL_DEFAULT;
    tex_info.colorkey_type = COLORKEY_TYPE_NONE;

    //_tcsncpy_s( tex_info.file_name, "boxlight2.tga" );
    //_tcsncpy_s( tex_info.file_name, "shlight.tga" );
    //_tcsncpy_s( tex_info.file_name, "multi009.tga" );
    //@@_tcsncpy_s( tex_info.file_name, "ocean_h.08.bmp" );
    //_tcsncpy_s( tex_info.file_name, "water_gsc012.BLE" );
    _tcsncpy_s( tex_info.file_name, file, _TRUNCATE );

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, color_op);
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG1, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_COLORARG2, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAOP, D3DTOP_DISABLE );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG1, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[5], D3DTSS_TEXCOORDINDEX, 0 );

    tex->LoadTexInfo(&tex_info, tex_path);

    drIMtlTexAgent* mtltex_agent = p->GetMtlTexAgent(0);
    //mtltex_agent->LoadTextureStage(&tex_info,
    drITex* ret_tex = 0;
    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);

    // anim_ctrl
    drIAnimCtrlObjTexUV* ctrl_obj_texuv;
    drIAnimCtrlTexUV* ctrl_texuv;
    res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj_texuv, ANIM_CTRL_TYPE_TEXUV);
    res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_texuv, ANIM_CTRL_TYPE_TEXUV);

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_TEXUV;
    type_info.data[0] = 0;
    type_info.data[1] = 1;
    ctrl_obj_texuv->SetTypeInfo(&type_info);

    ctrl_obj_texuv->AttachAnimCtrl(ctrl_texuv);

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    if(anim_agent == 0)
    {
        res_mgr->CreateAnimCtrlAgent(&anim_agent);
        p->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj_texuv);


    __texuv_animproc_seq[anim_type](ctrl_texuv);

    drPlayPoseInfo ppi;
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;
    ppi.pose = 0;
    ppi.frame = 0;
    ppi.data = 0;
    ctrl_obj_texuv->PlayPose(&ppi);

    return DR_RET_OK;
}

DR_RESULT drPrimitiveTexLitC(drIPrimitive* p, const char* file, const char* tex_path, DWORD anim_type)
{
    // ----begin----
    drITex* tex;
    drIResourceMgr* res_mgr = p->GetResourceMgr();
    res_mgr->CreateTex(&tex);
    drTexInfo tex_info;
    drTexInfo_Construct(&tex_info);
    tex_info.stage = 1;
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = D3DFMT_A8R8G8B8;
    tex_info.pool = D3DPOOL_DEFAULT;
    tex_info.colorkey_type = COLORKEY_TYPE_NONE;

    //_tcsncpy_s( tex_info.file_name, "boxlight2.tga" );
    //_tcsncpy_s( tex_info.file_name, "shlight.tga" );
    //_tcsncpy_s( tex_info.file_name, "multi009.tga" );
    //@@_tcsncpy_s( tex_info.file_name, "ocean_h.08.bmp" );
    //_tcsncpy_s( tex_info.file_name, "water_gsc012.BLE" );
    _tcsncpy_s( tex_info.file_name, file, _TRUNCATE );

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, D3DTOP_MODULATE2X    );
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG1, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_COLORARG2, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAOP, D3DTOP_DISABLE );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG1, D3DTA_TEXTURE );

    tex->LoadTexInfo(&tex_info, tex_path);

    drIMtlTexAgent* mtltex_agent = p->GetMtlTexAgent(0);
    //mtltex_agent->LoadTextureStage(&tex_info,
    drITex* ret_tex = 0;
    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);

    // anim_ctrl
    drIAnimCtrlObjTexUV* ctrl_obj_texuv;
    drIAnimCtrlTexUV* ctrl_texuv;
    res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj_texuv, ANIM_CTRL_TYPE_TEXUV);
    res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_texuv, ANIM_CTRL_TYPE_TEXUV);

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_TEXUV;
    type_info.data[0] = 0;
    type_info.data[1] = 1;
    ctrl_obj_texuv->SetTypeInfo(&type_info);

    ctrl_obj_texuv->AttachAnimCtrl(ctrl_texuv);


    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    if(anim_agent == 0)
    {
        res_mgr->CreateAnimCtrlAgent(&anim_agent);
        p->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj_texuv);

    __texuv_animproc_seq[anim_type](ctrl_texuv);

    drPlayPoseInfo ppi;
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;
    ppi.pose = 0;
    ppi.frame = 0;
    ppi.data = 0;
    ctrl_obj_texuv->PlayPose(&ppi);

    return DR_RET_OK;
}

#if 1
DR_RESULT drPrimitiveTexUnLitA(drIPrimitive* p)
{
    drIMtlTexAgent* mtltex_agent = p->GetMtlTexAgent(0);

#pragma message("[Waiting Note] why i=0 don't need destroy? ")
    for(DWORD i = 1; i < 4; i++)
    {
        if(DR_FAILED(mtltex_agent->DestroyTextureStage(i)))
            return DR_RET_FAILED;
    }

    return DR_RET_OK;
}

DR_RESULT drPrimitiveTexLitA(drIPrimitive* p, const char* alpha_file, const char* tex_file, const char* tex_path, DWORD anim_type)
{
    // ----begin----
    drITex* tex;
    drITex* ret_tex = 0;
    drIMtlTexAgent* mtltex_agent = 0;
    drIResourceMgr* res_mgr = p->GetResourceMgr();
    drTexInfo tex_info;

    drTexInfo_Construct(&tex_info);
    tex_info.stage = 1;
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = D3DFMT_A8R8G8B8;
    tex_info.pool = D3DPOOL_DEFAULT;


    tex_info.colorkey_type = COLORKEY_TYPE_NONE;

    _tcsncpy_s( tex_info.file_name, alpha_file, _TRUNCATE );

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, D3DTOP_SELECTARG1 );
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG1, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_ALPHAOP, D3DTOP_MODULATE );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAARG1, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG2, D3DTA_CURRENT );
    
    res_mgr->CreateTex(&tex);
    tex->LoadTexInfo(&tex_info, tex_path);

    mtltex_agent = p->GetMtlTexAgent(0);
    //mtltex_agent->LoadTextureStage(&tex_info,

    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);



    drTexInfo_Construct(&tex_info);

    tex_info.stage = 2;
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = D3DFMT_A8R8G8B8;
    tex_info.pool = D3DPOOL_DEFAULT;
    tex_info.colorkey_type = COLORKEY_TYPE_NONE;

    _tcsncpy_s( tex_info.file_name, tex_file, _TRUNCATE );

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, D3DTOP_MODULATEALPHA_ADDCOLOR);//D3DTOP_MODULATEINVALPHA_ADDCOLOR);//D3DTOP_MODULATEALPHA_ADDCOLOR );
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG2, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_COLORARG1, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAOP, D3DTOP_SELECTARG1 );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG1, D3DTA_CURRENT );

    res_mgr->CreateTex(&tex);
    tex->LoadTexInfo(&tex_info, tex_path);

    mtltex_agent = p->GetMtlTexAgent(0);
    //mtltex_agent->LoadTextureStage(&tex_info,
    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);

    // stage 3
    drTexInfo_Construct(&tex_info);

    drITex* tex_0 = mtltex_agent->GetTex(0);
    tex_0->GetTexInfo(&tex_info);
    tex_info.stage = 3;

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, D3DTOP_SELECTARG1);
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG1, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_ALPHAOP, D3DTOP_MODULATE );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAARG1, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG2, D3DTA_TFACTOR );

    res_mgr->CreateTex(&tex);
    tex->LoadTexInfo(&tex_info, NULL);
    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);

    // anim ctrl
    drIAnimCtrlObjTexUV* ctrl_obj_texuv;
    drIAnimCtrlTexUV* ctrl_texuv;
    res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj_texuv, ANIM_CTRL_TYPE_TEXUV);
    res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_texuv, ANIM_CTRL_TYPE_TEXUV);

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_TEXUV;
    type_info.data[0] = 0;
    type_info.data[1] = 2;
    ctrl_obj_texuv->SetTypeInfo(&type_info);

    ctrl_obj_texuv->AttachAnimCtrl(ctrl_texuv);

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    if(anim_agent == 0)
    {
        res_mgr->CreateAnimCtrlAgent(&anim_agent);
        p->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj_texuv);

    __texuv_animproc_seq[anim_type](ctrl_texuv);

    drPlayPoseInfo ppi;
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;
    ppi.pose = 0;
    ppi.frame = 0;
    ppi.data = 0;
    ctrl_obj_texuv->PlayPose(&ppi);

    return DR_RET_OK;
}
#endif

#if 1
DR_RESULT drPrimitiveTexLitA(drIPrimitive* p, const char* tex_file, const char* tex_path, DWORD anim_type)
{
    // ----begin----
    drITex* tex;
    drITex* ret_tex = 0;
    drIMtlTexAgent* mtltex_agent = 0;
    drIResourceMgr* res_mgr = p->GetResourceMgr();
    drTexInfo tex_info;

    drTexInfo_Construct(&tex_info);

    tex_info.stage = 1;
    tex_info.type = TEX_TYPE_FILE;
    tex_info.level = D3DX_DEFAULT;
    tex_info.format = D3DFMT_A8R8G8B8;
    tex_info.pool = D3DPOOL_DEFAULT;
    tex_info.colorkey_type = COLORKEY_TYPE_NONE;

    _tcsncpy_s( tex_info.file_name, tex_file, _TRUNCATE );

    RSA_VALUE(&tex_info.tss_set[0], D3DTSS_COLOROP, D3DTOP_MODULATEALPHA_ADDCOLOR );
    RSA_VALUE(&tex_info.tss_set[1], D3DTSS_COLORARG1, D3DTA_CURRENT );
    RSA_VALUE(&tex_info.tss_set[2], D3DTSS_COLORARG2, D3DTA_TEXTURE );
    RSA_VALUE(&tex_info.tss_set[3], D3DTSS_ALPHAOP, D3DTOP_SELECTARG1 );
    RSA_VALUE(&tex_info.tss_set[4], D3DTSS_ALPHAARG1, D3DTA_DIFFUSE );

    
    res_mgr->CreateTex(&tex);
    tex->LoadTexInfo(&tex_info, tex_path);

    mtltex_agent = p->GetMtlTexAgent(0);
    //mtltex_agent->LoadTextureStage(&tex_info,

    mtltex_agent->SetTex(tex_info.stage, tex, &ret_tex);
    DR_SAFE_RELEASE(ret_tex);

    // anim_ctrl
    drIAnimCtrlObjTexUV* ctrl_obj_texuv;
    drIAnimCtrlTexUV* ctrl_texuv;
    res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj_texuv, ANIM_CTRL_TYPE_TEXUV);
    res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_texuv, ANIM_CTRL_TYPE_TEXUV);

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_TEXUV;
    type_info.data[0] = 0;
    type_info.data[1] = 1;
    ctrl_obj_texuv->SetTypeInfo(&type_info);

    ctrl_obj_texuv->AttachAnimCtrl(ctrl_texuv);

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    if(anim_agent == 0)
    {
        res_mgr->CreateAnimCtrlAgent(&anim_agent);
        p->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj_texuv);


    __texuv_animproc_seq[anim_type](ctrl_texuv);

    drPlayPoseInfo ppi;
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;
    ppi.pose = 0;
    ppi.frame = 0;
    ppi.data = 0;
    ctrl_obj_texuv->PlayPose(&ppi);

    return DR_RET_OK;
}
#endif

drPoseInfo* drAnimCtrlAgentGetPoseInfo(drIAnimCtrlAgent* agent, DWORD subset, DWORD stage, DWORD type, DWORD id)
{
    drPoseInfo* ret = 0;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = type;
    type_info.data[0] = subset;
    type_info.data[1] = stage;

    drIAnimCtrlObj* ctrl_obj = agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == 0)
        goto __ret;

    drIAnimCtrl* ctrl = ctrl_obj->GetAnimCtrl();
    if(ctrl == 0)
        goto __ret;

    drIPoseCtrl* c = ctrl->GetPoseCtrl();
    if(c == 0)
        goto __ret;

    ret = c->GetPoseInfo(id);

__ret:
    return ret;
}

static DWORD __tree_node_release_proc(drITreeNode* node, void* param)
{
    DR_RELEASE(node);
    return TREENODE_PROC_RET_CONTINUE;
}

void drReleaseTreeNodeList(drITreeNode* node)
{
    node->EnumTree(__tree_node_release_proc, 0, TREENODE_PROC_POSTORDER);
}

// drNodeObject
DR_RESULT drINodeObjectA::PlayDefaultPose(drINodeObject* obj)
{
    return drNodeObject_PlayDefaultPose(obj);
}

DR_END
