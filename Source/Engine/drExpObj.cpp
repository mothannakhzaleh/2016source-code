//


#include "drExpObj.h"
#include "drErrorCode.h"
#include "drTreeNode.h"
#include "drAnimKeySetPRS.h"
#include "drIUtil.h"
DR_BEGIN

#define VERSION_BONESKIN            0x0001

/*
DR_STD_ILELEMENTATION(drMtlTexInfo)
DWORD drMtlTexInfo::version = VERSION;

DR_RESULT drMtlTexInfo::Load(FILE* fp)
{
    fread(&mtl, sizeof(mtl), 1, fp);
    fread(&rs_set, sizeof(rs_set), 1, fp);
    fread(&tex_seq[0], sizeof(tex_seq), 1, fp);

    return DR_RET_OK;
}

DR_RESULT drMtlTexInfo::Save(FILE* fp) const
{ 
    fwrite(&mtl, sizeof(mtl), 1, fp);
    fwrite(&rs_set, sizeof(rs_set), 1, fp);
    fwrite(&tex_seq[0], sizeof(tex_seq), 1, fp);

    return DR_RET_OK;
}
*/

// drMtlTexInfo io method
DR_RESULT drMtlTexInfo_Load(drMtlTexInfo* info, FILE* fp, DWORD version)
{
    if(version >= EXP_OBJ_VERSION_1_0_0_0)
    {
        fread(&info->opacity, sizeof(info->opacity), 1, fp);
        fread(&info->transp_type, sizeof(info->transp_type), 1, fp);
        fread(&info->mtl, sizeof(drMaterial), 1, fp);
        fread(&info->rs_set[0], sizeof(info->rs_set), 1, fp);
        fread(&info->tex_seq[0], sizeof(info->tex_seq), 1, fp);
    }
    else if(version == MTLTEX_VERSION0002)
    {
        fread(&info->opacity, sizeof(info->opacity), 1, fp);
        fread(&info->transp_type, sizeof(info->transp_type), 1, fp);
        fread(&info->mtl, sizeof(drMaterial), 1, fp);
        fread(&info->rs_set[0], sizeof(info->rs_set), 1, fp);
        fread(&info->tex_seq[0], sizeof(info->tex_seq), 1, fp);
    }
    else if(version == MTLTEX_VERSION0001)
    {
        drRenderStateSetMtl2 rsm;
        drTexInfo_0001 tex_info[DR_MAX_TEXTURESTAGE_NUM];

        fread(&info->opacity, sizeof(info->opacity), 1, fp);
        fread(&info->transp_type, sizeof(info->transp_type), 1, fp);
        fread(&info->mtl, sizeof(drMaterial), 1, fp);
        fread(&rsm, sizeof(rsm), 1, fp);
        fread(&tex_info[0], sizeof(tex_info), 1, fp);

        drRenderStateValue* rsv;
        for(DWORD i = 0; i < rsm.SEQUENCE_SIZE; i++)
        {
            rsv = &rsm.rsv_seq[0][i];
            if(rsv->state == DR_INVALID_INDEX)
                break;

            DWORD v;
            switch(rsv->state)
            {
            case D3DRS_ALPHAFUNC:
                v = D3DCMP_GREATER;
                break;
            case D3DRS_ALPHAREF:
                v = 129;
                break;
            default:
                v = rsv->value;
            }

            info->rs_set[i].state = rsv->state;
            info->rs_set[i].value0 = v;
            info->rs_set[i].value1 = v;
        }

        drTexInfo* t;
        drTexInfo_0001* p;
        for(DWORD i = 0; i < DR_MAX_TEXTURESTAGE_NUM; i++)
        {
            p = &tex_info[i];

            if(p->stage == DR_INVALID_INDEX)
                break;

            t = &info->tex_seq[i];

            t->level = p->level;
            t->usage = p->usage;
            t->pool = p->pool;
            t->type = p->type;

            t->width = p->width;
            t->height = p->height;

            t->stage = p->stage;
            t->format = p->format;
            t->colorkey = p->colorkey;
            t->colorkey_type = p->colorkey_type;
            t->byte_alignment_flag = p->byte_alignment_flag;
            _tcsncpy_s(t->file_name, p->file_name, _TRUNCATE );

            drRenderStateValue* rsv;
            for(DWORD j = 0; j < p->tss_set.SEQUENCE_SIZE; j++)
            {
                rsv = &p->tss_set.rsv_seq[0][j];
                if(rsv->state == DR_INVALID_INDEX)
                    break;

                t->tss_set[j].state = rsv->state;
                t->tss_set[j].value0 = rsv->value;
                t->tss_set[j].value1 = rsv->value;
            }
        }
    }
    else if(version == MTLTEX_VERSION0000)
    {
        drRenderStateSetMtl2 rsm;

        fread(&info->mtl, sizeof(drMaterial), 1, fp);
        fread(&rsm, sizeof(drRenderStateSetMtl2), 1, fp);
        drTexInfo_0000 tex_info[DR_MAX_TEXTURESTAGE_NUM];
        fread(&tex_info[0], sizeof(tex_info), 1, fp);

        drRenderStateValue* rsv;
        for(DWORD i = 0; i < rsm.SEQUENCE_SIZE; i++)
        {
            rsv = &rsm.rsv_seq[0][i];
            if(rsv->state == DR_INVALID_INDEX)
                break;

            DWORD v;
            switch(rsv->state)
            {
            case D3DRS_ALPHAFUNC:
                v = D3DCMP_GREATER;
                break;
            case D3DRS_ALPHAREF:
                v = 129;
                break;
            default:
                v = rsv->value;
            }

            info->rs_set[i].state = rsv->state;
            info->rs_set[i].value0 = v;
            info->rs_set[i].value1 = v;
        }

        drTexInfo* t;
        drTexInfo_0000* p;
        for(DWORD i = 0; i < DR_MAX_TEXTURESTAGE_NUM; i++)
        {
            p = &tex_info[i];

            if(p->stage == DR_INVALID_INDEX)
                break;

            t = &info->tex_seq[i];
            t->level = D3DX_DEFAULT;
            t->usage = 0;
            t->pool = D3DPOOL_DEFAULT;
            t->type = TEX_TYPE_FILE;

            t->stage = p->stage;
            t->format = p->format;
            t->colorkey = p->colorkey;
            t->colorkey_type = p->colorkey_type;
            t->byte_alignment_flag = 0;
            _tcsncpy_s(t->file_name, p->file_name, _TRUNCATE);

            drRenderStateValue* rsv;
            for(DWORD j = 0; j < p->tss_set.SEQUENCE_SIZE; j++)
            {
                rsv = &p->tss_set.rsv_seq[0][j];
                if(rsv->state == DR_INVALID_INDEX)
                    break;

                t->tss_set[j].state = rsv->state;
                t->tss_set[j].value0 = rsv->value;
                t->tss_set[j].value1 = rsv->value;
            }
        }
        //兼容旧版本的文件导出
        if(info->tex_seq[0].format == D3DFMT_A4R4G4B4)
        {
            info->tex_seq[0].format = D3DFMT_A1R5G5B5;
        }
    }
    else
    {
        MessageBox(NULL, "invalid file version", "error", MB_OK);
        return DR_RET_FAILED;
    }

    // 这里指定mipmap level = 3
    //if(info->tex_seq[0].colorkey_type == COLORKEY_TYPE_NONE)
    {
        info->tex_seq[0].pool = D3DPOOL_MANAGED;
        info->tex_seq[0].level = D3DX_DEFAULT;
    }

    // 兼容版本设置
    BOOL transp_flag = 0;
    drRenderStateAtom* rsa;

	DWORD i = 0;
    for(DWORD i = 0; i < DR_MTL_RS_NUM; i++)
    {
        rsa = &info->rs_set[i];

        if(rsa->state == DR_INVALID_INDEX)
            break;

        if(rsa->state == D3DRS_DESTBLEND && (rsa->value0 == D3DBLEND_ONE || rsa->value0 == D3DBLEND_INVSRCCOLOR))
        {
            transp_flag = 1;
        }
        if(rsa->state == D3DRS_LIGHTING && rsa->value0 == FALSE)
        {
            transp_flag += 1;
        }

    }

    if(transp_flag == 1 && i < (DR_MTL_RS_NUM - 1))
    {
        RSA_VALUE(&info->rs_set[i], D3DRS_LIGHTING, 0);
    }

    // warning:
//enum drMtlTexInfoTransparencyTypeEnum
//{
//    MTLTEX_TRANSP_FILTER =          0,
//    MTLTEX_TRANSP_ADDITIVE =        1,
//    MTLTEX_TRANSP_SUBTRACTIVE =     2,
//};
    if(info->transp_type == 1)
        info->transp_type = MTLTEX_TRANSP_ADDITIVE;
    else if(info->transp_type == 2)
        info->transp_type = MTLTEX_TRANSP_SUBTRACTIVE;
    // end

    return DR_RET_OK;
}

DR_RESULT drMtlTexInfo_Save(drMtlTexInfo* info, FILE* fp, DWORD version)
{ 
    fwrite(&info->opacity, sizeof(info->opacity), 1, fp);
    fwrite(&info->transp_type, sizeof(info->transp_type), 1, fp);
    fwrite(&info->mtl, sizeof(drMaterial), 1, fp);
    fwrite(&info->rs_set[0], sizeof(info->rs_set), 1, fp);
    fwrite(&info->tex_seq[0], sizeof(info->tex_seq), 1, fp);

    return DR_RET_OK;
}

DR_RESULT drLoadMtlTexInfo(drMtlTexInfo** out_buf, DWORD* out_num, FILE* fp, DWORD version)
{
    drMtlTexInfo* buf = 0;
    DWORD num = 0;

    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        DWORD old_version;
        fread(&old_version, sizeof(old_version), 1, fp);
        version = old_version;
    }

    fread(&num, sizeof(num), 1, fp);
    buf = DR_NEW(drMtlTexInfo[num]);

    for(DWORD i = 0; i < num; i++)
    {
        drMtlTexInfo_Load(&buf[i], fp, version);
    }

    *out_buf = buf;
    *out_num = num;

    return DR_RET_OK;
}
DR_RESULT drSaveMtlTexInfo(FILE* fp, const drMtlTexInfo* info, DWORD num)
{
    //fwrite(&MTLTEX_VERSION, sizeof(MTLTEX_VERSION), 1, fp);

    fwrite(&num, sizeof(DWORD), 1, fp);
    
    for(DWORD i = 0; i < num; i++)
    {
        drMtlTexInfo_Save((drMtlTexInfo*)&info[i], fp, MTLTEX_VERSION);
    }

    return DR_RET_OK;
}
DWORD drMtlTexInfo_GetDataSize(drMtlTexInfo* info)
{ 
    return sizeof(info->opacity) + sizeof(info->transp_type) 
        + sizeof(info->mtl) + sizeof(info->rs_set)
        + sizeof(info->tex_seq); 
}


// drAnimDataTexUV
///////////////////////
DR_STD_ILELEMENTATION(drAnimDataTexUV)

DR_RESULT drAnimDataTexUV::Load(FILE* fp, DWORD version)
{
    fread(&_frame_num, sizeof(DWORD), 1, fp);

    _mat_seq = DR_NEW(drMatrix44[_frame_num]);
    fread(&_mat_seq[0], sizeof(drMatrix44), _frame_num, fp);

    // pose_ctrl
    //_pose_ctrl.Load(fp);

    return DR_RET_OK;

}

DR_RESULT drAnimDataTexUV::Save(FILE* fp) const
{
    fwrite(&_frame_num, sizeof(DWORD), 1, fp);
    fwrite(&_mat_seq[0], sizeof(drMatrix44), _frame_num, fp);

    // pose_ctrl
    //_pose_ctrl.Save(fp);

    return DR_RET_OK;
}
DR_RESULT drAnimDataTexUV::Load(const char* file)
{
    return DR_RET_OK;
}
DR_RESULT drAnimDataTexUV::Save(const char* file) const
{
    return DR_RET_OK;
}

DR_RESULT drAnimDataTexUV::Copy(const drAnimDataTexUV* src)
{
    _frame_num = src->_frame_num;
    if(_frame_num > 0)
    {
        _mat_seq = DR_NEW(drMatrix44[_frame_num]);
        memcpy(&_mat_seq[0], &src->_mat_seq[0], sizeof(drMatrix44) * _frame_num);
    }

    //_pose_ctrl.Copy(&src->_pose_ctrl);

    return DR_RET_OK;
}

DWORD drAnimDataTexUV::GetDataSize() const
{
    DWORD size = 0;

    if(_frame_num > 0)
    {
        size += sizeof(_frame_num);
        size += sizeof(drMatrix44) * _frame_num;
        //size += _pose_ctrl.GetDataSize();
    }

    return size;

}

DR_RESULT drAnimDataTexUV::GetValue(drMatrix44* mat, float frame)
{
    if(frame < 0 || frame >= _frame_num)
        return ERR_INVALID_PARAM;


    // use linear interpolate
    int min_f = drFloatRoundDec(frame);
    int max_f = min_f + 1;

    if(max_f == _frame_num)
    {
        max_f = _frame_num - 1;
    }

    float ep = drFloatDecimal(frame);

    drMatrix44* mat_0 = &_mat_seq[min_f];
    drMatrix44* mat_1 = &_mat_seq[max_f];

    drMat44Slerp((drMatrix44*)mat, (drMatrix44*)mat_0, (drMatrix44*)mat_1, ep);

    return DR_RET_OK;

    //if((frame < 0) || (frame >= (int)_frame_num))
    //    return 0;


    //drMatrix44Identity(mat);

    //if(_data_seq[frame].w_angle != 0.0f) {

    //    // DirectX对于UV矩阵的的计算需要UV取负值才能得到需要的效果
    //    // 可能是某个开关没有设置正确
    //    drMatrix44 tmp;
    //    drMatrix44Identity(&tmp);

    //    tmp._31 = -_data_seq[frame].u - 0.5f;
    //    tmp._32 = _data_seq[frame].v - 0.5f;

    //    float cos_w = cosf(_data_seq[frame].w_angle);
    //    float sin_w = sinf(_data_seq[frame].w_angle);

    //    mat->_11 = cos_w;
    //    mat->_12 = -sin_w;
    //    mat->_21 = sin_w;
    //    mat->_22 = cos_w;

    //    drMatrix44Multiply(mat, &tmp, mat);

    //    mat->_31 += 0.5f;
    //    mat->_32 += 0.5f;
    //}
    //else {

    //    mat->_31 += -_data_seq[frame].u;
    //    mat->_32 += _data_seq[frame].v;
    //}

    //return 1;
}

// drAnimDataTexImg
DR_STD_ILELEMENTATION(drAnimDataTexImg);

DR_RESULT drAnimDataTexImg::Load(FILE* fp, DWORD version)
{
    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        char buf[256];
        _snprintf_s(buf, 256 ,_TRUNCATE,"old version file, need re-export it");
        MessageBox(NULL, buf, "warning", MB_OK);
        return DR_RET_FAILED;
    }
    else
    {
        fread(&_data_num, sizeof(_data_num), 1, fp);
        _data_seq = DR_NEW(drTexInfo[_data_num]);
        fread(_data_seq, sizeof(drTexInfo), _data_num, fp);
    }

    return DR_RET_OK;
}
DR_RESULT drAnimDataTexImg::Save(FILE* fp) const
{
    fwrite(&_data_num, sizeof(_data_num), 1, fp);
    fwrite(_data_seq, sizeof(drTexInfo), _data_num, fp);
    return DR_RET_OK;
}
DR_RESULT drAnimDataTexImg::Load(const char* file)
{
    return DR_RET_OK;
}
DR_RESULT drAnimDataTexImg::Save(const char* file) const
{
    return DR_RET_OK;
}


DWORD drAnimDataTexImg::GetDataSize() const
{
    DWORD size = 0;
    
    size += sizeof(drTexInfo) * _data_num;
    
    if(size > 0)
    {
        size += sizeof(_data_num);
    }

    return size;
}

DR_RESULT drAnimDataTexImg::Copy(const drAnimDataTexImg* src)
{
    _data_num = src->_data_num;
    _data_seq = DR_NEW(drTexInfo[_data_num]);
    memcpy(_data_seq, src->_data_seq, sizeof(drTexInfo) * _data_num);
    _tcsncpy_s(_tex_path, src->_tex_path, _TRUNCATE);

    return DR_RET_OK;
}

// drAnimDataMtlOpacity
DR_STD_ILELEMENTATION(drAnimDataMtlOpacity)

DR_RESULT drAnimDataMtlOpacity::Clone(drIAnimDataMtlOpacity** obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimDataMtlOpacity* o = DR_NEW(drAnimDataMtlOpacity);

    if(_aks_ctrl)
    {
        drIAnimKeySetFloat* aksf;

        if(DR_FAILED(_aks_ctrl->Clone(&aksf)))
            goto __ret;

        o->SetAnimKeySet(aksf);
    }

    *obj = o;
    o = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(o);

    return ret;
}

DR_RESULT drAnimDataMtlOpacity::Load(FILE* fp, DWORD version)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD num;
    drKeyFloat* seq;

    fread(&num, sizeof(num), 1, fp);
    assert(num > 0);

    seq = DR_NEW(drKeyFloat[num]);

    fread(seq, sizeof(drKeyFloat), num, fp);

    _aks_ctrl = DR_NEW(drAnimKeySetFloat);

    if(DR_FAILED(_aks_ctrl->SetKeySequence(seq, num)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE_A(seq);
    return ret;

}
DR_RESULT drAnimDataMtlOpacity::Save(FILE* fp)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_aks_ctrl == 0)
        goto __ret;

    DWORD num = _aks_ctrl->GetKeyNum(); 
    drKeyFloat* seq = _aks_ctrl->GetKeySequence();
    
    if(num == 0 || seq == 0)
        goto __ret;

    fwrite(&num, sizeof(num), 1, fp);
    fwrite(&seq[0], sizeof(drKeyFloat), num, fp);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DWORD drAnimDataMtlOpacity::GetDataSize()
{
    if(_aks_ctrl == 0)
        return 0;

    return (sizeof(drKeyFloat) * _aks_ctrl->GetKeyNum() + sizeof(DWORD));
}

// drAnimDataBone
DR_STD_ILELEMENTATION(drAnimDataBone)

drAnimDataBone::drAnimDataBone() 
: _key_type(BONE_KEY_TYPE_MAT43), _base_seq(0), _invmat_seq(0), _key_seq(0), _dummy_seq(0),
  _bone_num(0), _frame_num(0), _dummy_num(0)/*, _subset_type(DR_INVALID_INDEX)*/
{ 
}
drAnimDataBone::~drAnimDataBone()
{
    Destroy();
}

DR_RESULT drAnimDataBone::Destroy()
{
    DR_SAFE_DELETE_A(_base_seq);
    DR_SAFE_DELETE_A(_invmat_seq);
    DR_SAFE_DELETE_A(_key_seq);
    DR_SAFE_DELETE_A(_dummy_seq);
    _bone_num = 0;
    _frame_num = 0;
    _dummy_num = 0;
    //_subset_type = DR_INVALID_INDEX;
    _key_type = BONE_KEY_TYPE_MAT43;

    return DR_RET_OK;
}

DR_RESULT drAnimDataBone::Load(FILE* fp, DWORD version)
{
    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        DWORD old_version;
        fread(&old_version, sizeof(old_version), 1, fp);
        int x = 0;
    }
    
    // need destroy first
    if(_base_seq)
        return DR_RET_FAILED;

    fread(&_header, sizeof(drBoneInfoHeader), 1, fp);

    _base_seq = DR_NEW(drBoneBaseInfo[_bone_num]);
    _key_seq = DR_NEW(drBoneKeyInfo[_bone_num]);
    _invmat_seq = DR_NEW(drMatrix44[_bone_num]);
    _dummy_seq = DR_NEW(drBoneDummyInfo[_dummy_num]);

    fread(_base_seq, sizeof(drBoneBaseInfo), _bone_num, fp);
    fread(_invmat_seq, sizeof(drMatrix44), _bone_num, fp);
    fread(_dummy_seq, sizeof(drBoneDummyInfo), _dummy_num, fp);

    DWORD i, j;
    drBoneKeyInfo* key;

    switch(_key_type)
    {
    case BONE_KEY_TYPE_MAT43:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            key->mat43_seq = DR_NEW(drMatrix43[_frame_num]);
            fread(&key->mat43_seq[0], sizeof(drMatrix43), _frame_num, fp);
        }
        break;
    case BONE_KEY_TYPE_MAT44:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            key->mat44_seq = DR_NEW(drMatrix44[_frame_num]);
            fread(&key->mat44_seq[0], sizeof(drMatrix44), _frame_num, fp);
        }
        break;
    case BONE_KEY_TYPE_QUAT:
        if(version >= EXP_OBJ_VERSION_1_0_0_3)
        {
            for(i = 0; i < _bone_num; i++)
            {
                key = &_key_seq[i];

                key->pos_seq = DR_NEW(drVector3[_frame_num]);
                fread(&key->pos_seq[0], sizeof(drVector3), _frame_num, fp);

                key->quat_seq = DR_NEW(drQuaternion[_frame_num]);
                fread(&key->quat_seq[0], sizeof(drQuaternion), _frame_num, fp);
            }
        }
        else // old version < EXP_OBJ_VERSION_1_0_0_3
        {
            for(i = 0; i < _bone_num; i++)
            {
                key = &_key_seq[i];

                DWORD pos_num = (_base_seq[i].parent_id == DR_INVALID_INDEX) ? _frame_num : 1;

                key->pos_seq = DR_NEW(drVector3[_frame_num]);
                fread(&key->pos_seq[0], sizeof(drVector3), pos_num, fp);

                if(pos_num == 1)
                {
                    for(j = 1; j < _frame_num; j++)
                    {
                        key->pos_seq[j] = key->pos_seq[0];
                    }
                }

                key->quat_seq = DR_NEW(drQuaternion[_frame_num]);
                fread(&key->quat_seq[0], sizeof(drQuaternion), _frame_num, fp);
            }
        }
        break;
    default:
        assert(0);
    }

    // pose_ctrl
    //_pose_ctrl.Load(fp);

    return DR_RET_OK;

}
DR_RESULT drAnimDataBone::Save(FILE* fp) const
{
    //const DWORD version = VERSION_BONESKIN;
    //fwrite(&version, sizeof(DWORD), 1, fp);

    fwrite(&_header, sizeof(drBoneInfoHeader), 1, fp);

    fwrite(_base_seq, sizeof(drBoneBaseInfo), _bone_num, fp);
    fwrite(_invmat_seq, sizeof(drMatrix44), _bone_num, fp);
    fwrite(_dummy_seq, sizeof(drBoneDummyInfo), _dummy_num, fp);

    DWORD i;
    drBoneKeyInfo* key;


    switch(_key_type)
    {
    case BONE_KEY_TYPE_MAT43:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            fwrite(&key->mat43_seq[0], sizeof(drMatrix43), _frame_num, fp);
        }
        break;
    case BONE_KEY_TYPE_MAT44:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            fwrite(&key->mat44_seq[0], sizeof(drMatrix44), _frame_num, fp);
        }
        break;
    case BONE_KEY_TYPE_QUAT:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            fwrite(&key->pos_seq[0], sizeof(drVector3), _frame_num, fp);
            fwrite(&key->quat_seq[0], sizeof(drQuaternion), _frame_num, fp);
        }
        break;
    default:
        assert(0);
    }


    //_pose_ctrl.Save(fp);

    return DR_RET_OK;

}

DR_RESULT drAnimDataBone::Load(const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        goto __ret;

    DWORD version;
    fread(&version, sizeof(version), 1, fp);

    if(version < EXP_OBJ_VERSION_1_0_0_0)
    {
		goto __ret;
        version = EXP_OBJ_VERSION_0_0_0_0;
        char buf[256];
        _snprintf_s(buf, 256,_TRUNCATE,"old animation file: %s, need re-export it", file);
        MessageBox(NULL, buf, "warning", MB_OK);
    }

    if(DR_FAILED(Load(fp, version)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;

}

DR_RESULT drAnimDataBone::Save(const char* file) const
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp == NULL)
        return 0;

    DWORD version = EXP_OBJ_VERSION;
    fwrite(&version, sizeof(version), 1, fp);

    if(DR_FAILED(Save(fp)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;

}

DR_RESULT drAnimDataBone::Copy(const drAnimDataBone* src)
{
    if(src->_key_type == BONE_KEY_TYPE_INVALID)
        return DR_RET_FAILED;

    _header = src->_header;

    _base_seq = DR_NEW(drBoneBaseInfo[_bone_num]);
    _invmat_seq = DR_NEW(drMatrix44[_bone_num]);
    _key_seq = DR_NEW(drBoneKeyInfo[_bone_num]);
    _dummy_seq = DR_NEW(drBoneDummyInfo[_dummy_num]);

    memcpy(&_base_seq[0], &src->_base_seq[0], sizeof(drBoneBaseInfo) * _bone_num);
    memcpy(&_invmat_seq[0], &src->_invmat_seq[0], sizeof(drMatrix44) * _bone_num);
    memcpy(&_dummy_seq[0], &src->_dummy_seq[0], sizeof(drBoneDummyInfo) * _dummy_num);


    DWORD i;
    drBoneKeyInfo* key;

    switch(_key_type)
    {
    case BONE_KEY_TYPE_MAT43:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            key->mat43_seq = DR_NEW(drMatrix43[_frame_num]);
            memcpy(&key->mat43_seq[0], &src->_key_seq[i].mat43_seq[0], sizeof(drMatrix43) * _frame_num);
        }
        break;
    case BONE_KEY_TYPE_MAT44:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            key->mat44_seq = DR_NEW(drMatrix44[_frame_num]);
            memcpy(&key->mat44_seq[0], &src->_key_seq[i].mat44_seq[0], sizeof(drMatrix44) * _frame_num);
        }
        break;
    case BONE_KEY_TYPE_QUAT:
        for(i = 0; i < _bone_num; i++)
        {
            key = &_key_seq[i];
            key->pos_seq = DR_NEW(drVector3[_frame_num]);
            key->quat_seq = DR_NEW(drQuaternion[_frame_num]);
            memcpy(&key->pos_seq[0], &src->_key_seq[i].pos_seq[0], sizeof(drVector3) * _frame_num);
            memcpy(&key->quat_seq[0], &src->_key_seq[i].quat_seq[0], sizeof(drQuaternion) * _frame_num);
        }
        break;
    default:
        assert(0);
    }

    //_pose_ctrl.Copy(&src->_pose_ctrl);

    return DR_RET_OK;

}

DWORD drAnimDataBone::GetDataSize() const
{
    DWORD size = 0;

    if(_bone_num > 0 && _frame_num > 0)
    {
        size += sizeof(drBoneInfoHeader);
        size += sizeof(drBoneBaseInfo) * _bone_num;
        size += sizeof(drMatrix44) * _bone_num;
        size += sizeof(drBoneDummyInfo) * _dummy_num;

        DWORD d = _bone_num * _frame_num;

        switch(_key_type)
        {
        case BONE_KEY_TYPE_MAT43:
            size += sizeof(drMatrix43) * d;
            break;
        case BONE_KEY_TYPE_MAT44:
            size += sizeof(drMatrix44) * d;
            break;
        case BONE_KEY_TYPE_QUAT:
            size += sizeof(drQuaternion) * d;
            for(DWORD i = 0; i < _bone_num; i++)
            {
                if(_base_seq[i].parent_id == DR_INVALID_INDEX)
                    size += sizeof(drVector3) * _frame_num;
                else
                    size += sizeof(drVector3) * 1;
            }
            break;
        default:
            assert(0);
        }
    }

    return size;
}

DR_RESULT drAnimDataBone::GetValue(drMatrix44* mat, DWORD bone_id, float frame, DWORD start_frame, DWORD end_frame)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(bone_id < 0 || bone_id >= _bone_num)
        goto __ret;

    // 这里frame > _frame_num 没有用">="是因为我们在考虑PLAY_LOOP的情况时
    // 需要插值第0帧和第_data._frame_num - 1帧的数据
    if(frame < 0 || frame > _frame_num)
        goto __ret;


    drBoneKeyInfo* key = &_key_seq[bone_id];   

    DWORD d_frame = (DWORD)frame;

    if((float)d_frame == frame)
    {
        if(d_frame >= _frame_num)
            goto __ret;

        switch(_key_type)
        {
        case BONE_KEY_TYPE_MAT43:
            drConvertMat43ToMat44(mat, &key->mat43_seq[d_frame]);
            break;
        case BONE_KEY_TYPE_MAT44:
            *mat = key->mat44_seq[d_frame];
            break;
        case BONE_KEY_TYPE_QUAT:
            drQuaternionToMatrix44(mat, &key->quat_seq[d_frame]);
            *(drVector3*)&mat->_41 = key->pos_seq[d_frame];
            break;
        default:
            assert(0);
            goto __ret;
        }

    }
    else // use linear interpolate
    {        
        DWORD min_f = drFloatRoundDec(frame);
        DWORD max_f = min_f + 1;

        float t = drFloatDecimal(frame);

        if(start_frame != DR_INVALID_INDEX && end_frame != DR_INVALID_INDEX)
        {
            if(max_f > end_frame)
            {
                max_f = start_frame;
            }
        }

        if(max_f == _frame_num)
        {
            // 这里我们插值第0帧和第_data._frame_num - 1帧的数据
            max_f = 0;
            //max_f = _frame_num - 1; 不作边界截断
        }

#if 0
        drMatrix44 mat_0;
        drMatrix44 mat_1;

        switch(_key_type)
        {
        case BONE_KEY_TYPE_MAT43:
            drConvertMat43ToMat44(&mat_0, &key->mat43_seq[min_f]);
            drConvertMat43ToMat44(&mat_1, &key->mat43_seq[max_f]);
            break;
        case BONE_KEY_TYPE_MAT44:
            mat_0 = key->mat44_seq[min_f];
            mat_1 = key->mat44_seq[max_f];
            break;
        case BONE_KEY_TYPE_QUAT:
            drQuaternionToMatrix44(&mat_0, &key->quat_seq[min_f]);
            *(drVector3*)&mat_0._41 = key->pos_seq[min_f];
            drQuaternionToMatrix44(&mat_1, &key->quat_seq[max_f]);
            *(drVector3*)&mat_1._41 = key->pos_seq[max_f];
            break;
        default:
            assert(0);
            goto __ret;
        }

        drMat44Slerp(mat, &mat_0, &mat_1, t);

        //drVector3 vv;
        //drQuaternion q, q0, q1;
        //drMatrix44ToQuaternion(&q0, &mat_0);
        //drMatrix44ToQuaternion(&q1, &mat_1);

        //drVector3Slerp(&vv, (drVector3*)&mat_0._41, (drVector3*)&mat_1._41, t);
        //drQuaternionSlerp(&q, &q0, &q1, t);
        //drQuaternionToMatrix44(mat, &q);
        //mat->_41 = vv.x;
        //mat->_42 = vv.y;
        //mat->_43 = vv.z;

#else
        drMatrix44 mat_0;
        drMatrix44 mat_1;

        switch(_key_type)
        {
        case BONE_KEY_TYPE_MAT43:
            drConvertMat43ToMat44(&mat_0, &key->mat43_seq[min_f]);
            drConvertMat43ToMat44(&mat_1, &key->mat43_seq[max_f]);

            drMatrix44Slerp(&mat_0, &mat_1, t, mat);
            break;
        case BONE_KEY_TYPE_MAT44:
            mat_0 = key->mat44_seq[min_f];
            mat_1 = key->mat44_seq[max_f];

            drMatrix44Slerp(&mat_0, &mat_1, t, mat);
            break;
        case BONE_KEY_TYPE_QUAT:
            //drQuaternionToMatrix44(&mat_0, &key->quat_seq[min_f]);
            //*(drVector3*)&mat_0._41 = key->pos_seq[min_f];
            //drQuaternionToMatrix44(&mat_1, &key->quat_seq[max_f]);
            //*(drVector3*)&mat_1._41 = key->pos_seq[max_f];
            drMatrix44Slerp(&key->pos_seq[min_f], &key->pos_seq[max_f], NULL, NULL, &key->quat_seq[min_f], &key->quat_seq[max_f], t, mat);
            break;
        default:
            assert(0);
            goto __ret;
        }

#endif

    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drAnimDataMatrix
DR_STD_ILELEMENTATION(drAnimDataMatrix)

drAnimDataMatrix::drAnimDataMatrix() 
: _mat_seq(0), _frame_num(0)/*, _subset_type(DR_INVALID_INDEX)*/
{
}
drAnimDataMatrix::~drAnimDataMatrix() 
{ 
    DR_SAFE_DELETE_A(_mat_seq); 
}

DR_RESULT drAnimDataMatrix::Load(FILE* fp, DWORD version)
{
    fread(&_frame_num, sizeof(DWORD), 1, fp);

    _mat_seq = DR_NEW(drMatrix43[_frame_num]);
    fread(&_mat_seq[0], sizeof(drMatrix43), _frame_num, fp);

    // pose_ctrl
    //_pose_ctrl.Load(fp);

    return DR_RET_OK;

}
DR_RESULT drAnimDataMatrix::Save(FILE* fp) const
{
    fwrite(&_frame_num, sizeof(DWORD), 1, fp);
    fwrite(&_mat_seq[0], sizeof(drMatrix43), _frame_num, fp);

    // pose_ctrl
    //_pose_ctrl.Save(fp);

    return DR_RET_OK;

}
DR_RESULT drAnimDataMatrix::Load(const char* file)
{
    assert(0);
    return DR_RET_OK;
}
DR_RESULT drAnimDataMatrix::Save(const char* file) const
{
    assert(0);
    return DR_RET_OK;
}

DR_RESULT drAnimDataMatrix::Copy(const drAnimDataMatrix* src)
{
    _frame_num = src->_frame_num;

    if(_frame_num > 0)
    {
        _mat_seq = DR_NEW(drMatrix43[_frame_num]);
        memcpy(&_mat_seq[0], &src->_mat_seq[0], sizeof(drMatrix43) * _frame_num);
    }

    //_pose_ctrl.Copy(&src->_pose_ctrl);

    return DR_RET_OK;
}

DWORD drAnimDataMatrix::GetDataSize() const
{
    DWORD size = 0;

    if(_frame_num > 0)
    {
        size += sizeof(_frame_num);
        size += sizeof(drMatrix43) * _frame_num;

        //size += _pose_ctrl.GetDataSize();
    }

    return size;

}
DR_RESULT drAnimDataMatrix::GetValue(drMatrix44* mat, float frame)
{
    if(frame < 0 || frame >= _frame_num)
        return ERR_INVALID_PARAM;


    // use linear interpolate
    int min_f = drFloatRoundDec(frame);
    int max_f = min_f + 1;

    if(max_f == _frame_num)
    {
        max_f = _frame_num - 1;
    }

    float ep = drFloatDecimal(frame);

    drMatrix44 mat_0;
    drMatrix44 mat_1;

    drConvertMat43ToMat44(&mat_0, &_mat_seq[min_f]);
    drConvertMat43ToMat44(&mat_1, &_mat_seq[max_f]);

    drMat44Slerp(mat, &mat_0, &mat_1, ep);

    return DR_RET_OK;
}

// drAnimKeySetPRS
template< class T >
DR_RESULT drKeyDataSearch(DWORD* ret_min, DWORD* ret_max, DWORD key, T* data_seq, DWORD data_num)
{
    DWORD low = 0;
    DWORD high = data_num - 1;
    DWORD k, l;

    while(high >= low)
    {
        k = (low + high) / 2;

        l = k + 1;

        if(l == data_num)
        {
            //if(key == data_seq[k].key)
            //{
            //    *ret_min = k;
            //    *ret_max = k;
            //    break;
            //}
            //else
            //{
            //    assert(0);
            //}
            *ret_min = k;
            *ret_max = k;
            break;
        }
        else
        {
            if(key >= data_seq[k].key && key < data_seq[l].key)
            {
                *ret_min = k;
                *ret_max = l;
                break;
            }
        }

        if(key < data_seq[k].key)
        {
            high = k - 1;
        }
        else
        {
            low = k + 1;
        }
    }

    return (low <= high) ? DR_RET_OK : DR_INVALID_INDEX;
}

//DWORD drKeyDataSearch< drKeyDataVector3 >;
//DWORD drKeyDataSearch< drKeyDataQuaternion >;

DR_RESULT drAnimKeySetPRS::GetValue(drMatrix44* mat, float frame)
{
    DWORD f = (DWORD)frame;

    if(f < 0 || f >= frame_num)
        return ERR_INVALID_PARAM;


    DWORD key_pos[2];
    DWORD key_rot[2];
    DWORD key_sca[2];

    if(DR_FAILED(drKeyDataSearch< drKeyDataVector3 >(&key_pos[0], &key_pos[1], f, pos_seq, pos_num)))
    {
        assert(0);
    }
    if(DR_FAILED(drKeyDataSearch< drKeyDataQuaternion >(&key_rot[0], &key_rot[1], f, rot_seq, rot_num)))
    {
        assert(0);
    }
    if(DR_FAILED(drKeyDataSearch< drKeyDataVector3 >(&key_sca[0], &key_sca[1], f, sca_seq, sca_num)))
    {
        assert(0);
    }

    drVector3 pos;
    drQuaternion quat;
    drVector3 scale;
    float t;

    if(key_pos[0] == key_pos[1])
    {
        pos = pos_seq[key_pos[0]].data;
    }
    else
    {
        drKeyDataVector3* k0 = &pos_seq[key_pos[0]];
        drKeyDataVector3* k1 = &pos_seq[key_pos[1]];

        t = (float)(f - k0->key) / (float)(k1->key - k0->key);

        drVector3Slerp(&pos, &k0->data, &k1->data, t);
    }

    if(key_rot[0] == key_rot[1])
    {
        quat = rot_seq[key_rot[0]].data;
    }
    else
    {
        drKeyDataQuaternion* k0 = &rot_seq[key_rot[0]];
        drKeyDataQuaternion* k1 = &rot_seq[key_rot[1]];

        t = (float)(f - k0->key) / (float)(k1->key - k0->key);

        drQuaternionSlerp(&quat, &k0->data, &k1->data, t);
    }

    if(key_sca[0] == key_sca[1])
    {

        scale = sca_seq[key_sca[0]].data;
    }
    else
    {
        drKeyDataVector3* k0 = &sca_seq[key_sca[0]];
        drKeyDataVector3* k1 = &sca_seq[key_sca[1]];

        t = (float)(f - k0->key) / (float)(k1->key - k0->key);

        drVector3Slerp(&scale, &k0->data, &k1->data, t);
    }

    drQuaternionToMatrix44(mat, &quat);

    drMatrix44Multiply(mat, mat, &drMatrix44Translate(pos));

    //drMatrix44Multiply(mat, &drMatrix44Scale(scale), mat);
    //drMatrix44MultiplyScale(mat, &drMatrix44Scale(scale), mat);
    mat->_11 *= scale.x;
    mat->_12 *= scale.x;
    mat->_13 *= scale.x;
    mat->_14 *= scale.x;

    mat->_21 *= scale.y;
    mat->_22 *= scale.y;
    mat->_23 *= scale.y;
    mat->_24 *= scale.y;

    mat->_31 *= scale.z;
    mat->_32 *= scale.z;
    mat->_33 *= scale.z;
    mat->_34 *= scale.z;

    //mat->_41 = pos.x;
    //mat->_42 = pos.y;
    //mat->_43 = pos.z;


    return DR_RET_OK;
}

// drMeshInfo

DR_RESULT drMeshInfo_Copy(drMeshInfo* dst, const drMeshInfo* src)
{
    dst->header = src->header;

    if(dst->vertex_num > 0)
    {
        dst->vertex_seq = DR_NEW(drVector3[dst->vertex_num]);
        memcpy(dst->vertex_seq, src->vertex_seq, sizeof(drVector3) * dst->vertex_num);
    }

    if(dst->fvf & D3DFVF_NORMAL)
    {
        dst->normal_seq = DR_NEW(drVector3[dst->vertex_num]);
        memcpy(dst->normal_seq, src->normal_seq, sizeof(drVector3) * dst->vertex_num);
    }

    if(dst->fvf & D3DFVF_TEX1)
    {
        dst->texcoord0_seq = DR_NEW(drVector2[dst->vertex_num]);
        memcpy(dst->texcoord0_seq, src->texcoord0_seq, sizeof(drVector2) * dst->vertex_num);

		//dst->texcoord1_seq = DR_NEW(drVector2[dst->vertex_num]);
		//memcpy(dst->texcoord1_seq, src->texcoord0_seq, sizeof(drVector2) * dst->vertex_num);
		//dst->fvf |= D3DFVF_TEX2;
		//dst->fvf ^= D3DFVF_TEX1;
    }
    else if(dst->fvf & D3DFVF_TEX2)
    {
        dst->texcoord0_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord1_seq = DR_NEW(drVector2[dst->vertex_num]);
        memcpy(dst->texcoord0_seq, src->texcoord0_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord1_seq, src->texcoord1_seq, sizeof(drVector2) * dst->vertex_num);
    }
    else if(dst->fvf & D3DFVF_TEX3)
    {
        dst->texcoord0_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord1_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord2_seq = DR_NEW(drVector2[dst->vertex_num]);
        memcpy(dst->texcoord0_seq, src->texcoord0_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord1_seq, src->texcoord1_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord2_seq, src->texcoord2_seq, sizeof(drVector2) * dst->vertex_num);
    }
    else if(dst->fvf & D3DFVF_TEX4)
    {
        dst->texcoord0_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord1_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord2_seq = DR_NEW(drVector2[dst->vertex_num]);
        dst->texcoord3_seq = DR_NEW(drVector2[dst->vertex_num]);
        memcpy(dst->texcoord0_seq, src->texcoord0_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord1_seq, src->texcoord1_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord2_seq, src->texcoord2_seq, sizeof(drVector2) * dst->vertex_num);
        memcpy(dst->texcoord3_seq, src->texcoord3_seq, sizeof(drVector2) * dst->vertex_num);
    }

    if(dst->fvf & D3DFVF_DIFFUSE)
    {
        dst->vercol_seq = DR_NEW(DWORD[dst->vertex_num]);
        memcpy(dst->vercol_seq, src->vercol_seq, sizeof(DWORD) * dst->vertex_num);
    }

    if(dst->bone_index_num > 0)
    {
        dst->blend_seq = DR_NEW(drBlendInfo[dst->vertex_num]);
        dst->bone_index_seq = DR_NEW(DWORD[dst->bone_index_num]);
        memcpy(dst->blend_seq, src->blend_seq, sizeof(drBlendInfo) * dst->vertex_num);
        memcpy(dst->bone_index_seq, src->bone_index_seq, sizeof(DWORD) * dst->bone_index_num);
    }

    if(dst->index_num > 0)
    {
        dst->index_seq = DR_NEW(DWORD[dst->index_num]);
        memcpy(dst->index_seq, src->index_seq, sizeof(DWORD) * dst->index_num);
    }

    if(dst->subset_num > 0)
    {
        dst->subset_seq = DR_NEW(drSubsetInfo[dst->subset_num]);
        memcpy(dst->subset_seq, src->subset_seq, sizeof(drSubsetInfo) * dst->subset_num);
    }

    return DR_RET_OK;
}

DR_RESULT drMeshInfo_Load(drMeshInfo* info, FILE* fp, DWORD version)
{
    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        DWORD old_version;
        fread(&old_version, sizeof(old_version), 1, fp);
        version = old_version;
    }

    // header
    if(version >= EXP_OBJ_VERSION_1_0_0_4)
    {
        fread(&info->header, sizeof(info->header), 1, fp);
    }
    else if(version >= EXP_OBJ_VERSION_1_0_0_3)
    {
        drMeshInfo_0003::drMeshInfoHeader header;
        fread(&header, sizeof(header), 1, fp);
        info->fvf = header.fvf;
        info->pt_type = header.pt_type;
        info->vertex_num = header.vertex_num;
        info->index_num = header.index_num;
        info->subset_num = header.subset_num;
        info->bone_index_num = header.bone_index_num;
        info->bone_infl_factor = info->bone_index_num > 0 ? 2 : 0;
        info->vertex_element_num = 0;
    }
    else if((version >= EXP_OBJ_VERSION_1_0_0_0) || (version == MESH_VERSION0001))
    {
        drMeshInfo_0003::drMeshInfoHeader header;
        fread(&header, sizeof(header), 1, fp);
        info->fvf = header.fvf;
        info->pt_type = header.pt_type;
        info->vertex_num = header.vertex_num;
        info->index_num = header.index_num;
        info->subset_num = header.subset_num;
        info->bone_index_num = header.bone_index_num;
        info->bone_infl_factor = info->bone_index_num > 0 ? 2 : 0;
        info->vertex_element_num = 0;
    }
    else if(version == MESH_VERSION0000)
    {
        drMeshInfo_0000::drMeshInfoHeader header;
        fread(&header, sizeof(header), 1, fp);
        info->header.fvf = header.fvf;
        info->header.pt_type = header.pt_type;
        info->header.vertex_num = header.vertex_num;
        info->header.index_num = header.index_num;
        info->header.subset_num = header.subset_num;
        info->header.bone_index_num = header.bone_index_num;

        drRenderStateValue* rsv;
        for(DWORD j = 0; j < header.rs_set.SEQUENCE_SIZE; j++)
        {
            rsv = &header.rs_set.rsv_seq[0][j];
            if(rsv->state == DR_INVALID_INDEX)
                break;

            DWORD v;
            switch(rsv->state)
            {
            case D3DRS_AMBIENTMATERIALSOURCE:
                v = D3DMCS_COLOR2;
                break;
            default:
                v = rsv->value;
            }

            info->header.rs_set[j].state = rsv->state;
            info->header.rs_set[j].value0 = v;
            info->header.rs_set[j].value1 = v;
        }
    }
    else
    {
        MessageBox(NULL, "invalid version", "error", MB_OK);
    }


    if(version >= EXP_OBJ_VERSION_1_0_0_4)
    {    
        if(info->vertex_element_num > 0)
        {
            info->vertex_element_seq = DR_NEW(D3DVERTEXELEMENTX[info->vertex_element_num]);
            fread(&info->vertex_element_seq[0], sizeof(D3DVERTEXELEMENTX), info->vertex_element_num, fp);
        }

        if(info->vertex_num > 0)
        {
            info->vertex_seq = DR_NEW(drVector3[info->vertex_num]);
            fread(&info->vertex_seq[0], sizeof(drVector3), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_NORMAL)
        {
            info->normal_seq = DR_NEW(drVector3[info->vertex_num]);
            fread(&info->normal_seq[0], sizeof(drVector3), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_TEX1)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);

			//info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
			//memcpy(info->texcoord1_seq, info->texcoord0_seq, sizeof(drVector2) * info->vertex_num);
			//info->fvf |= D3DFVF_TEX2;
			//info->fvf ^= D3DFVF_TEX1;
		}
		else if(info->fvf & D3DFVF_TEX2)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }
        else if(info->fvf & D3DFVF_TEX3)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord2_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }
        else if(info->fvf & D3DFVF_TEX4)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord2_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord3_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord3_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_DIFFUSE)
        {
            info->vercol_seq = DR_NEW(DWORD[info->vertex_num]);
            fread(&info->vercol_seq[0], sizeof(DWORD), info->vertex_num, fp);
        }

        if(info->bone_index_num > 0)
        {
            info->blend_seq = DR_NEW(drBlendInfo[info->vertex_num]);
            info->bone_index_seq = DR_NEW(DWORD[info->bone_index_num]);
            fread(&info->blend_seq[0], sizeof(drBlendInfo), info->vertex_num, fp);
            fread(&info->bone_index_seq[0], sizeof(DWORD), info->bone_index_num, fp);
        }

        if(info->index_num > 0)
        {
            info->index_seq = DR_NEW(DWORD[info->index_num]);
            fread(&info->index_seq[0], sizeof(DWORD), info->index_num, fp);
        }

        if(info->subset_num > 0)
        {
            info->subset_seq = DR_NEW(drSubsetInfo[info->subset_num]);
            fread(&info->subset_seq[0], sizeof(drSubsetInfo), info->subset_num, fp);
        }
    }
    else
    {
        info->subset_seq = DR_NEW(drSubsetInfo[info->subset_num]);
        fread(&info->subset_seq[0], sizeof(drSubsetInfo), info->subset_num, fp);

        info->vertex_seq = DR_NEW(drVector3[info->vertex_num]);
        fread(&info->vertex_seq[0], sizeof(drVector3), info->vertex_num, fp);

        if(info->fvf & D3DFVF_NORMAL)
        {
            info->normal_seq = DR_NEW(drVector3[info->vertex_num]);
            fread(&info->normal_seq[0], sizeof(drVector3), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_TEX1)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);

			//info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
			//memcpy(info->texcoord1_seq, info->texcoord0_seq, sizeof(drVector2) * info->vertex_num);
			//info->fvf |= D3DFVF_TEX2;
			//info->fvf ^= D3DFVF_TEX1;
        }
        else if(info->fvf & D3DFVF_TEX2)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }
        else if(info->fvf & D3DFVF_TEX3)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord2_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }
        else if(info->fvf & D3DFVF_TEX4)
        {
            info->texcoord0_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord1_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord2_seq = DR_NEW(drVector2[info->vertex_num]);
            info->texcoord3_seq = DR_NEW(drVector2[info->vertex_num]);
            fread(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
            fread(&info->texcoord3_seq[0], sizeof(drVector2), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_DIFFUSE)
        {
            info->vercol_seq = DR_NEW(DWORD[info->vertex_num]);
            fread(&info->vercol_seq[0], sizeof(DWORD), info->vertex_num, fp);
        }

        if(info->fvf & D3DFVF_LASTBETA_UBYTE4)
        {
            info->blend_seq = DR_NEW(drBlendInfo[info->vertex_num]);
            // old version use BYTE
            BYTE* byte_index_seq = DR_NEW(BYTE[info->bone_index_num]);

            fread(&info->blend_seq[0], sizeof(drBlendInfo), info->vertex_num, fp);
            fread(&byte_index_seq[0], sizeof(BYTE), info->bone_index_num, fp);

            // convert it
            info->bone_index_seq = DR_NEW(DWORD[info->bone_index_num]);
            for(DWORD i = 0; i < info->bone_index_num; i++)
            {
                info->bone_index_seq[i] = byte_index_seq[i];
            }

            DR_DELETE_A(byte_index_seq);
        }

        if(info->index_num > 0)
        {
            info->index_seq = DR_NEW(DWORD[info->index_num]);
            fread(&info->index_seq[0], sizeof(DWORD), info->index_num, fp);
        }
    }


    return DR_RET_OK;
}

DR_RESULT drMeshInfo_Save(drMeshInfo* info, FILE* fp)
{
    fwrite(&info->header, sizeof(info->header), 1, fp);

    if(info->vertex_element_num > 0)
    {
        fwrite(&info->vertex_element_seq[0], sizeof(D3DVERTEXELEMENTX), info->vertex_element_num, fp);
    }

    fwrite(&info->vertex_seq[0], sizeof(drVector3), info->vertex_num, fp);

    if(info->fvf & D3DFVF_NORMAL)
    {
        fwrite(&info->normal_seq[0], sizeof(drVector3), info->vertex_num, fp);
    }

    if(info->fvf & D3DFVF_TEX1)
    {
        fwrite(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
    }
    else if(info->fvf & D3DFVF_TEX2)
    {
        fwrite(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
    }
    else if(info->fvf & D3DFVF_TEX3)
    {
        fwrite(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
    }
    else if(info->fvf & D3DFVF_TEX4)
    {
        fwrite(&info->texcoord0_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord1_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord2_seq[0], sizeof(drVector2), info->vertex_num, fp);
        fwrite(&info->texcoord3_seq[0], sizeof(drVector2), info->vertex_num, fp);
    }

    if(info->fvf & D3DFVF_DIFFUSE)
    {
        fwrite(&info->vercol_seq[0], sizeof(DWORD), info->vertex_num, fp);
    }

    if(info->bone_index_num > 0)
    {
        fwrite(&info->blend_seq[0], sizeof(drBlendInfo), info->vertex_num, fp);
        fwrite(&info->bone_index_seq[0], sizeof(DWORD), info->bone_index_num, fp);
    }

    if(info->index_num > 0)
    {
        fwrite(&info->index_seq[0], sizeof(DWORD), info->index_num, fp);
    }

    fwrite(&info->subset_seq[0], sizeof(drSubsetInfo), info->subset_num, fp);

    return DR_RET_OK;

}


DWORD drMeshInfo_GetDataSize(drMeshInfo* info) 
{
    DWORD size = 0;
    
    //size += sizeof(MESH_VERSION);
    size += sizeof(drMeshInfoHeader);
    size += sizeof(D3DVERTEXELEMENTX) * info->vertex_element_num;
    size += sizeof(drSubsetInfo) * info->subset_num;
    size += sizeof(drVector3) * info->vertex_num;


    if(info->fvf & D3DFVF_NORMAL)
    {
        size += sizeof(drVector3) * info->vertex_num;
    }

    if(info->fvf & D3DFVF_TEX1)
    {
        size += sizeof(drVector2) * info->vertex_num;
    }
    else if(info->fvf & D3DFVF_TEX2)
    {
        size += sizeof(drVector2) * info->vertex_num * 2;
    }
    else if(info->fvf & D3DFVF_TEX3)
    {
        size += sizeof(drVector2) * info->vertex_num * 3;
    }
    else if(info->fvf & D3DFVF_TEX4)
    {
        size += sizeof(drVector2) * info->vertex_num * 4;
    }

    if(info->fvf & D3DFVF_DIFFUSE)
    {
        size += sizeof(DWORD) * info->vertex_num;
    }

    if(info->fvf & D3DFVF_LASTBETA_UBYTE4)
    {
        size += sizeof(drBlendInfo) * info->vertex_num;
        size += sizeof(DWORD) * info->bone_index_num;
    }

    if(info->index_num > 0)
    {
        size += sizeof(DWORD) * info->index_num;
    }

    return size;

}

// drAnimDataInfo
DR_STD_ILELEMENTATION(drAnimDataInfo)

drAnimDataInfo::drAnimDataInfo()
{
    anim_bone = 0;
    anim_mat = 0;

    memset(anim_mtlopac, 0, sizeof(anim_mtlopac));
    memset(anim_tex, 0, sizeof(anim_tex));
    memset(anim_img, 0, sizeof(anim_img));
}

drAnimDataInfo::~drAnimDataInfo()
{
    DR_IF_DELETE(anim_bone);
    DR_IF_DELETE(anim_mat);

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        DR_IF_DELETE(anim_mtlopac[i]);

        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            DR_IF_DELETE(anim_tex[i][j]);
            DR_IF_DELETE(anim_img[i][j]);
        }    
    }
}

DR_RESULT drAnimDataInfo::Load(FILE* fp, DWORD version)
{
    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        DWORD old_version;
        fread(&old_version, sizeof(old_version), 1, fp);
    }

    DWORD data_bone_size, data_mat_size;
    DWORD data_mtlopac_size[DR_MAX_SUBSET_NUM];
    DWORD data_texuv_size[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];
    DWORD data_teximg_size[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];

    fread(&data_bone_size, sizeof(DWORD), 1, fp);
    fread(&data_mat_size, sizeof(DWORD), 1, fp);

    if(version >= EXP_OBJ_VERSION_1_0_0_5)
    {
        fread(&data_mtlopac_size, sizeof(data_mtlopac_size), 1, fp);
    }

    fread(&data_texuv_size, sizeof(data_texuv_size), 1, fp);
    fread(&data_teximg_size, sizeof(data_teximg_size), 1, fp);

    if(data_bone_size > 0)
    {
        anim_bone = DR_NEW(drAnimDataBone);
        anim_bone->Load(fp, version);
    }

    if(data_mat_size > 0)
    {
#ifdef USE_ANIMKEY_PRS
        anim_mat = DR_NEW(drAnimKeySetPRS);
        drLoadAnimKeySetPRS(anim_mat, fp);
#else
        anim_mat = DR_NEW(drAnimDataMatrix);
        anim_mat->Load(fp, version);
#endif
    }

    if(version >= EXP_OBJ_VERSION_1_0_0_5)
    {
        for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
        {
            if(data_mtlopac_size[i] == 0)
                continue;

            anim_mtlopac[i] = DR_NEW(drAnimDataMtlOpacity);
            anim_mtlopac[i]->Load(fp, version);
        }
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(data_texuv_size[i][j] == 0)
                continue;

            anim_tex[i][j] = DR_NEW(drAnimDataTexUV);
            anim_tex[i][j]->Load(fp, version);
        }
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(data_teximg_size[i][j] == 0)
                continue;

            anim_img[i][j] = DR_NEW(drAnimDataTexImg);
            anim_img[i][j]->Load(fp, version);
        }
    }

    return DR_RET_OK;

}
DR_RESULT drAnimDataInfo::Save(FILE* fp)
{
    //fwrite(&VERSION, sizeof(VERSION), 1, fp);


    DWORD data_bone_size = 0;
    DWORD data_mat_size = 0;
    DWORD data_mtlopac_size[DR_MAX_SUBSET_NUM];
    DWORD data_texuv_size[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];
    DWORD data_teximg_size[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];
    memset(data_mtlopac_size, 0, sizeof(data_mtlopac_size));
    memset(data_texuv_size, 0, sizeof(data_texuv_size));
    memset(data_teximg_size, 0, sizeof(data_teximg_size));

    if(anim_bone)
    {
        data_bone_size = anim_bone->GetDataSize();
    }

    if(anim_mat)
    {
#ifdef USE_ANIMKEY_PRS
        data_mat_size = drGetAnimKeySetPRSSize(anim_mat);
#else
        data_mat_size = anim_mat->GetDataSize();
#endif
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(anim_mtlopac[i])
        {
            data_mtlopac_size[i] = anim_mtlopac[i]->GetDataSize();
            assert(data_mtlopac_size[i] > 0);
        }
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(anim_tex[i][j])
            {
                data_texuv_size[i][j] = anim_tex[i][j]->GetDataSize();
            }
            if(anim_img[i][j])
            {
                data_teximg_size[i][j] = anim_img[i][j]->GetDataSize();
            }
        }
    }

    fwrite(&data_bone_size, sizeof(DWORD), 1, fp);
    fwrite(&data_mat_size, sizeof(DWORD), 1, fp);
    fwrite(&data_mtlopac_size, sizeof(data_mtlopac_size), 1, fp);
    fwrite(&data_texuv_size, sizeof(data_texuv_size), 1, fp);
    fwrite(&data_teximg_size, sizeof(data_teximg_size), 1, fp);

    if(data_bone_size > 0)
    {
        anim_bone->Save(fp);
    }

    if(data_mat_size > 0)
    {
#ifdef USE_ANIMKEY_PRS
        drSaveAnimKeySetPRS(fp, anim_mat);
#else
        anim_mat->Save(fp);
#endif
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(data_mtlopac_size[i] == 0)
            continue;

        anim_mtlopac[i]->Save(fp);
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(data_texuv_size[i][j] == 0)
                continue;

            anim_tex[i][j]->Save(fp);
        }
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(data_teximg_size[i][j] == 0)
                continue;

            anim_img[i][j]->Save(fp);
        }
    }


    return DR_RET_OK;

}


DR_RESULT drAnimDataInfo::GetDataSize() const
{
    DWORD size = 0;

    if(anim_bone)
    {
        size += anim_bone->GetDataSize();
    }

    if(anim_mat)
    {
#ifdef USE_ANIMKEY_PRS
        size += drGetAnimKeySetPRSSize(anim_mat);
#else
        size += anim_mat->GetDataSize();
#endif
    }

    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(anim_mtlopac[i])
        {
            size += anim_mtlopac[i]->GetDataSize();
        }

        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(anim_tex[i][j])
            {
                size += anim_tex[i][j]->GetDataSize();
            }
            if(anim_img[i][j])
            {
                size += anim_img[i][j]->GetDataSize();
            }
        }
    }

    if(size > 0)
    {
        size += sizeof(DWORD) * ANIM_DATA_NUM;
        //size += sizeof(VERSION);
    }

    return size;

}

// get size function
DWORD drGetMtlTexInfoSize(const drMtlTexInfo* info_seq, DWORD num)
{
    DWORD size = 0;

    for(DWORD i = 0; i < num; i++)
    {
        size += drMtlTexInfo_GetDataSize(const_cast<drMtlTexInfo*>(&info_seq[i]));
    }

    if(size > 0)
    {
        //size += sizeof(MTLTEX_VERSION);
        size += sizeof(DWORD); // number
    }

    return size;
}

DWORD drGetAnimKeySetPRSSize(const drAnimKeySetPRS* info)
{
    DWORD size = 0;

    size += sizeof(info->frame_num) + sizeof(info->pos_num) + sizeof(info->rot_num) + sizeof(info->sca_num);
    size += sizeof(drKeyDataVector3) * info->pos_num;
    size += sizeof(drKeyDataQuaternion) * info->rot_num;
    size += sizeof(drKeyDataVector3) * info->sca_num;

    return size;
}

DWORD drGetHelperMeshInfoSize(const drHelperMeshInfo* info)
{
    DWORD size = 0;

    size += sizeof(info->id);
    size += sizeof(info->type);
    size += sizeof(info->sub_type);
    size += sizeof(info->name);
    size += sizeof(info->state);
    size += sizeof(info->mat);
    size += sizeof(info->box);
    size += sizeof(info->vertex_num) + sizeof(info->face_num);
    size += sizeof(drVector3) * info->vertex_num;
    size += sizeof(drHelperMeshFaceInfo) * info->face_num;

    return size;
}
DWORD drGetHelperBoxInfoSize(const drHelperBoxInfo* info)
{
    DWORD size = 0;

    size += sizeof(info->id);
    size += sizeof(info->name);
    size += sizeof(info->type);
    size += sizeof(info->state);
    size += sizeof(info->mat);
    size += sizeof(info->box);

    return size;
}

// load atom function

DR_RESULT drLoadAnimKeySetPRS(drAnimKeySetPRS* info, FILE* fp)
{
    fread(&info->frame_num, sizeof(DWORD), 1, fp);

    fread(&info->pos_num, sizeof(DWORD), 1, fp);
    fread(&info->rot_num, sizeof(DWORD), 1, fp);
    fread(&info->sca_num, sizeof(DWORD), 1, fp);

    if(info->pos_num > 0)
    {
        info->pos_seq = DR_NEW(drKeyDataVector3[info->pos_num]);
        fread(&info->pos_seq[0], sizeof(drKeyDataVector3), info->pos_num, fp);
    }

    if(info->rot_num > 0)
    {
        info->rot_seq = DR_NEW(drKeyDataQuaternion[info->rot_num]);
        fread(&info->rot_seq[0], sizeof(drKeyDataQuaternion), info->rot_num, fp);
    }

    if(info->sca_num > 0)
    {
        info->sca_seq = DR_NEW(drKeyDataVector3[info->sca_num]);
        fread(&info->sca_seq[0], sizeof(drKeyDataVector3), info->sca_num, fp);
    }


    return DR_RET_OK;
}

// save atom function


DR_RESULT drSaveAnimKeySetPRS(FILE* fp, const drAnimKeySetPRS* info)
{
    fwrite(&info->frame_num, sizeof(DWORD), 1, fp);

    fwrite(&info->pos_num, sizeof(DWORD), 1, fp);
    fwrite(&info->rot_num, sizeof(DWORD), 1, fp);
    fwrite(&info->sca_num, sizeof(DWORD), 1, fp);

    if(info->pos_num > 0)
    {
        fwrite(&info->pos_seq[0], sizeof(drKeyDataVector3), info->pos_num, fp);
    }

    if(info->rot_num > 0)
    {
        fwrite(&info->rot_seq[0], sizeof(drKeyDataQuaternion), info->rot_num, fp);
    }

    if(info->sca_num > 0)
    {
        fwrite(&info->sca_seq[0], sizeof(drKeyDataVector3), info->sca_num, fp);
    }


    return DR_RET_OK;
}


DR_RESULT drSaveAnimDataBone(const char* file, const drAnimDataBone* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp == NULL)
        return 0;

    DWORD version = EXP_OBJ_VERSION;
    fwrite(&version, sizeof(DWORD), 1, fp);

    if(DR_FAILED(info->Save(fp)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;
}

DR_RESULT drCheckHelperMeshFaceShareSides(int* side1, int* side2, const drHelperMeshFaceInfo* p1, const drHelperMeshFaceInfo* p2)
{
	int r1 = -1;
	int r2 = -1;
	int tab[3] = { 0, 2, 1 };

	for(int i = 0; i < 3; i++) 
    {
		for(int j = 0; j < 3; j++) 
        {
			// check index
            if(p1->vertex[i] == p2->vertex[j]) 
            {
				if(r1 != -1) 
                {
					if(p1->vertex[i] == p1->vertex[r1]) 
                    {
                        MessageBox(0, "the same vertices in one triangle", "warning", MB_OK);
						continue; // in the case of p1 has 2 same vertices , we ignore it
					}

					*side1 = tab[r1 + i - 1];
					*side2 = tab[r2 + j - 1];

					return DR_RET_OK;
				}
				else 
                {
					r1 = i;
					r2 = j;
					break; // next vertex
				}
			}
		}
	}

	return DR_RET_FAILED;

}


DR_RESULT drCreateHelperMeshInfo(drHelperMeshInfo* info, const drMeshInfo* mi)
{
    if(mi->vertex_num == 0)
        return DR_RET_FAILED;

    info->vertex_num = mi->vertex_num;

    info->vertex_seq = DR_NEW(drVector3[info->vertex_num]);
    memcpy(&info->vertex_seq[0], &mi->vertex_seq[0], sizeof(drVector3) * info->vertex_num);

    info->face_num = mi->index_num / 3;
    info->face_seq = DR_NEW(drHelperMeshFaceInfo[info->face_num]);

    DWORD i, j;
    drHelperMeshFaceInfo* x, *x_i, *x_j;

    for(i = 0;i < info->face_num; i++)
    {
        x = &info->face_seq[i];

        // vertex id
        x->vertex[0] = mi->index_seq[3 * i];
        x->vertex[1] = mi->index_seq[3 * i + 1];
        x->vertex[2] = mi->index_seq[3 * i + 2];

        // plane
        drPlaneFromPoints(&x->plane, &info->vertex_seq[x->vertex[0]], &info->vertex_seq[x->vertex[1]], &info->vertex_seq[x->vertex[2]]);

        // center
        x->center = info->vertex_seq[x->vertex[0]] + info->vertex_seq[x->vertex[1]] + info->vertex_seq[x->vertex[2]];
        drVector3Scale(&x->center, 1.0f / 3);
    }

    // begin set polygon neighbour sides
    int* mark_buf = DR_NEW(int[info->face_num]);
    memset(mark_buf, 0, sizeof(int) * info->face_num);

    for(i = 0; i < info->face_num; i++) 
    {
        x = &info->face_seq[i];

        x->adj_face[0] = DR_INVALID_INDEX;
        x->adj_face[1] = DR_INVALID_INDEX;
        x->adj_face[2] = DR_INVALID_INDEX;
    }

    for(i = 0; i < info->face_num; i++) 
    {
        if(mark_buf[i] == 3)
            continue; // has been checked before

        x_i = &info->face_seq[i];

        for(j = 0; j < info->face_num; j++) 
        {
            if((i == j) || (mark_buf[j] == 3))
                continue; // has been checked before

            x_j =  &info->face_seq[j];

            if(x_i->adj_face[0] == j || x_i->adj_face[1] == j || x_i->adj_face[2] == j)
                continue; // has been checked before

            int side1, side2;

            if(DR_SUCCEEDED(drCheckHelperMeshFaceShareSides(&side1, &side2, x_i,x_j)))
            {
                // get adjacent face index
                x_i->adj_face[side1] = j; // index j
                x_j->adj_face[side2] = i; // index i

                // set mark
                mark_buf[i] += 1;
                mark_buf[j] += 1;

                assert(mark_buf[i]<= 3);
                assert(mark_buf[j]<= 3);

                if(mark_buf[i] == 3) 
                {
                    break; // topology_i has been checked completely
                }
            }
        }        
    }

    DR_DELETE_A(mark_buf);
    // end

    return DR_RET_OK;
}


DR_RESULT drCopyAnimKeySetPRS(drAnimKeySetPRS* dst, const drAnimKeySetPRS* src)
{
    dst->frame_num = src->frame_num;
    dst->pos_num = src->pos_num;
    dst->rot_num = src->rot_num;
    dst->sca_num = src->sca_num;

    if(dst->pos_num > 0)
    {
        dst->pos_seq = DR_NEW(drKeyDataVector3[dst->pos_num]);
        memcpy(&dst->pos_seq[0], &src->pos_seq[0], sizeof(drKeyDataVector3) * dst->pos_num);
    }

    if(dst->rot_num > 0)
    {
        dst->rot_seq = DR_NEW(drKeyDataQuaternion[dst->rot_num]);
        memcpy(&dst->rot_seq[0], &src->rot_seq[0], sizeof(drKeyDataQuaternion) * dst->rot_num);
    }

    if(dst->sca_num > 0)
    {
        dst->sca_seq = DR_NEW(drKeyDataVector3[dst->sca_num]);
        memcpy(&dst->sca_seq[0], &src->sca_seq[0], sizeof(drKeyDataVector3) * dst->sca_num);
    }

    return DR_RET_OK;

}

// drHelperMeshInfo
DR_RESULT drHelperMeshInfo::Copy(const drHelperMeshInfo* src)
{
    id = src->id;
    type = src->type;
    sub_type = src->sub_type;
    mat = src->mat;
    box = src->box;
    vertex_num = src->vertex_num;
    face_num = src->face_num;

    _tcsncpy_s(name, src->name, _TRUNCATE);

    vertex_seq = DR_NEW(drVector3[vertex_num]);
    face_seq = DR_NEW(drHelperMeshFaceInfo[face_num]);

    memcpy(vertex_seq, src->vertex_seq, sizeof(drVector3) * vertex_num);
    memcpy(face_seq, src->face_seq, sizeof(drHelperMeshFaceInfo) * face_num);

    return DR_RET_OK;
}

// drHelperInfo
DR_STD_ILELEMENTATION(drHelperInfo)

DR_RESULT drHelperInfo::Load(FILE* fp, DWORD version)
{
    if(version == EXP_OBJ_VERSION_0_0_0_0)
    {
        DWORD old_version;
        fread(&old_version, sizeof(old_version), 1, fp);
    }

    fread(&type, sizeof(type), 1, fp);

    if(type & HELPER_TYPE_DUMMY)
    {
        _LoadHelperDummyInfo(fp, version);
    }

    if(type & HELPER_TYPE_BOX)
    {
        _LoadHelperBoxInfo(fp, version);
    }

    if(type & HELPER_TYPE_MESH)
    {
        _LoadHelperMeshInfo(fp, version);
    }

    if(type & HELPER_TYPE_BOUNDINGBOX)
    {
        _LoadBoundingBoxInfo(fp, version);
    }

    if(type & HELPER_TYPE_BOUNDINGSPHERE)
    { 
        _LoadBoundingSphereInfo(fp, version);
    }

    return DR_RET_OK;

}
DR_RESULT drHelperInfo::Save(FILE* fp) const
{
    //fwrite(&VERSION, sizeof(VERSION), 1, fp);

    fwrite(&type, sizeof(type), 1, fp);

    if(type & HELPER_TYPE_DUMMY)
    {
        _SaveHelperDummyInfo(fp);
    }

    if(type & HELPER_TYPE_BOX)
    {
        _SaveHelperBoxInfo(fp);
    }

    if(type & HELPER_TYPE_MESH)
    {
        _SaveHelperMeshInfo(fp);
    }

    if(type & HELPER_TYPE_BOUNDINGBOX)
    {
        _SaveBoundingBoxInfo(fp);
    }

    if(type & HELPER_TYPE_BOUNDINGSPHERE)
    { 
        _SaveBoundingSphereInfo(fp);
    }

    return DR_RET_OK;

}

DR_RESULT drHelperInfo::Copy(const drHelperInfo* src)
{
    type = src->type;

    if(type & HELPER_TYPE_DUMMY)
    {
        dummy_num = src->dummy_num;
        dummy_seq = DR_NEW(drHelperDummyInfo[dummy_num]);
        memcpy(&dummy_seq[0], &src->dummy_seq[0], sizeof(drHelperDummyInfo) * dummy_num);
    }
    if(type & HELPER_TYPE_BOX)
    {
        box_num = src->box_num;
        box_seq = DR_NEW(drHelperBoxInfo[box_num]);
        memcpy(&box_seq[0], &src->box_seq[0], sizeof(drHelperBoxInfo) * box_num);
    }
    if(type & HELPER_TYPE_MESH)
    {
        mesh_num = src->mesh_num;
        mesh_seq = DR_NEW(drHelperMeshInfo[mesh_num]);

        for(DWORD i = 0; i < mesh_num; i++)
        {
            mesh_seq[i].Copy(&src->mesh_seq[i]);
        }
    }

    if(type & HELPER_TYPE_BOUNDINGBOX)
    {
        bbox_num = src->bbox_num;
        bbox_seq = DR_NEW(drBoundingBoxInfo[bbox_num]);
        memcpy(&bbox_seq[0], &src->bbox_seq[0], sizeof(drBoundingBoxInfo) * bbox_num);
    }
    if(type & HELPER_TYPE_BOUNDINGSPHERE)
    {
        bsphere_num = src->bsphere_num;
        bsphere_seq = DR_NEW(drBoundingSphereInfo[bsphere_num]);
        memcpy(&bsphere_seq[0], &src->bsphere_seq[0], sizeof(drBoundingSphereInfo) * bsphere_num);
    }

    return DR_RET_OK;
}

DWORD drHelperInfo::GetDataSize() const
{
    DWORD size = 0;

    if(type & HELPER_TYPE_DUMMY)
    {
        size += sizeof(dummy_num);
        size += sizeof(drHelperDummyInfo) * dummy_num;
    }

    if(type & HELPER_TYPE_BOX)
    {
        size += sizeof(box_num);
        for(DWORD i = 0; i < box_num; i++)
        {
            size += drGetHelperBoxInfoSize(&box_seq[i]);
        }
    }

    if(type & HELPER_TYPE_MESH)
    {
        size += sizeof(mesh_num);
        for(DWORD i = 0; i < mesh_num; i++)
        {
            size += drGetHelperMeshInfoSize(&mesh_seq[i]);
        }
    }

    if(type & HELPER_TYPE_BOUNDINGBOX)
    {
        size += sizeof(bbox_num);
        size += sizeof(drBoundingBoxInfo) * bbox_num;
    }

    if(type & HELPER_TYPE_BOUNDINGSPHERE)
    {
        size += sizeof(bsphere_num);
        size += sizeof(drBoundingSphereInfo) * bsphere_num;
    }

    if(size > 0)
    {
        size += sizeof(type);
        //size += sizeof(VERSION);
    }

    return size;

}

// begin load / save item
DR_RESULT drHelperInfo::_LoadHelperDummyInfo(FILE* fp, DWORD version)
{

    if(version >= EXP_OBJ_VERSION_1_0_0_1)
    {
        fread(&dummy_num, sizeof(dummy_num), 1, fp);
        dummy_seq = DR_NEW(drHelperDummyInfo[dummy_num]);
        fread(&dummy_seq[0], sizeof(drHelperDummyInfo), dummy_num, fp);
    }
    else if(version <= EXP_OBJ_VERSION_1_0_0_0)
    {
        fread(&dummy_num, sizeof(dummy_num), 1, fp);
        drHelperDummyInfo_1000* old_s = DR_NEW(drHelperDummyInfo_1000[dummy_num]);
        fread(&old_s[0], sizeof(drHelperDummyInfo_1000), dummy_num, fp);

        dummy_seq = DR_NEW(drHelperDummyInfo[dummy_num]);
        for(DWORD i = 0; i < dummy_num; i++)
        {
            dummy_seq[i].id = old_s[i].id;
            dummy_seq[i].mat = old_s[i].mat;
            dummy_seq[i].parent_type = 0;
            dummy_seq[i].parent_id = 0;
        }

        DR_DELETE_A(old_s);
    }

    return DR_RET_OK;
}
DR_RESULT drHelperInfo::_LoadHelperBoxInfo(FILE* fp, DWORD version)
{
    fread(&box_num, sizeof(box_num), 1, fp);

    box_seq = DR_NEW(drHelperBoxInfo[box_num]);
    fread(&box_seq[0], sizeof(drHelperBoxInfo), box_num, fp);

    if(version <= EXP_OBJ_VERSION_1_0_0_1)
    {
        drBox* b;
        drBox_1001 old_b;
        for(DWORD i = 0; i < bbox_num; i++)
        {
            b = &box_seq[i].box;
            old_b.p = b->c;
            old_b.s = b->r;

            b->r = old_b.s / 2;
            b->c = old_b.p + b->r;
        }
    }

    return DR_RET_OK;
}
DR_RESULT drHelperInfo::_LoadHelperMeshInfo(FILE* fp, DWORD version)
{
    fread(&mesh_num, sizeof(mesh_num), 1, fp);

    mesh_seq = DR_NEW(drHelperMeshInfo[mesh_num]);

    drHelperMeshInfo* info;

    for(DWORD i = 0; i < mesh_num; i++)
    {
        info = &mesh_seq[i];

        fread(&info->id, sizeof(info->id), 1, fp);
        fread(&info->type, sizeof(info->type), 1, fp);
        fread(&info->sub_type, sizeof(info->sub_type), 1, fp);
        fread(&info->name[0], sizeof(info->name), 1, fp);
        fread(&info->state, sizeof(info->state), 1, fp);
        fread(&info->mat, sizeof(info->mat), 1, fp);
        fread(&info->box, sizeof(info->box), 1, fp);
        fread(&info->vertex_num, sizeof(info->vertex_num), 1, fp);
        fread(&info->face_num, sizeof(info->face_num), 1, fp);

        info->vertex_seq = DR_NEW(drVector3[info->vertex_num]);
        info->face_seq = DR_NEW(drHelperMeshFaceInfo[info->face_num]);

        fread(&info->vertex_seq[0], sizeof(drVector3), info->vertex_num, fp);
        fread(&info->face_seq[0], sizeof(drHelperMeshFaceInfo), info->face_num, fp);
    }

    if(version <= EXP_OBJ_VERSION_1_0_0_1)
    {
        drBox* b;
        drBox_1001 old_b;
        for(DWORD i = 0; i < mesh_num; i++)
        {
            b = &mesh_seq[i].box;
            old_b.p = b->c;
            old_b.s = b->r;

            b->r = old_b.s / 2;
            b->c = old_b.p + b->r;
        }
    }

    return DR_RET_OK;
}

DR_RESULT drHelperInfo::_LoadBoundingBoxInfo(FILE* fp, DWORD version)
{
    fread(&bbox_num, sizeof(DWORD), 1, fp);

    bbox_seq = DR_NEW(drBoundingBoxInfo[bbox_num]);

    fread(&bbox_seq[0], sizeof(drBoundingBoxInfo), bbox_num, fp);

    if(version <= EXP_OBJ_VERSION_1_0_0_1)
    {
        drBox* b;
        drBox_1001 old_b;
        for(DWORD i = 0; i < bbox_num; i++)
        {
            b = &bbox_seq[i].box;
            old_b.p = b->c;
            old_b.s = b->r;

            b->r = old_b.s / 2;
            b->c = old_b.p + b->r;
        }
    }

    return DR_RET_OK;

}
DR_RESULT drHelperInfo::_LoadBoundingSphereInfo(FILE* fp, DWORD version)
{
    fread(&bsphere_num, sizeof(DWORD), 1, fp);

    bsphere_seq = DR_NEW(drBoundingSphereInfo[bsphere_num]);

    fread(&bsphere_seq[0], sizeof(drBoundingSphereInfo), bsphere_num, fp);

    return DR_RET_OK;
}

DR_RESULT drHelperInfo::_SaveHelperDummyInfo(FILE* fp) const
{
    fwrite(&dummy_num, sizeof(dummy_num), 1, fp);
    fwrite(&dummy_seq[0], sizeof(drHelperDummyInfo), dummy_num, fp);

    return DR_RET_OK;
}
DR_RESULT drHelperInfo::_SaveHelperBoxInfo(FILE* fp) const
{
    fwrite(&box_num, sizeof(box_num), 1, fp);
    fwrite(&box_seq[0], sizeof(drHelperBoxInfo), box_num, fp);

    return DR_RET_OK;
}
DR_RESULT drHelperInfo::_SaveHelperMeshInfo(FILE* fp) const
{
    fwrite(&mesh_num, sizeof(mesh_num), 1, fp);

    drHelperMeshInfo* info;
    for(DWORD i = 0; i < mesh_num; i++)
    {
        info = &mesh_seq[i];

        fwrite(&info->id, sizeof(info->id), 1, fp);
        fwrite(&info->type, sizeof(info->type), 1, fp);
        fwrite(&info->sub_type, sizeof(info->sub_type), 1, fp);
        fwrite(&info->name[0], sizeof(info->name), 1, fp);
        fwrite(&info->state, sizeof(info->state), 1, fp);
        fwrite(&info->mat, sizeof(info->mat), 1, fp);
        fwrite(&info->box, sizeof(info->box), 1, fp);
        fwrite(&info->vertex_num, sizeof(info->vertex_num), 1, fp);
        fwrite(&info->face_num, sizeof(info->face_num), 1, fp);

        fwrite(&info->vertex_seq[0], sizeof(drVector3), info->vertex_num, fp);
        fwrite(&info->face_seq[0], sizeof(drHelperMeshFaceInfo), info->face_num, fp);
    }

    return DR_RET_OK;
}

DR_RESULT drHelperInfo::_SaveBoundingBoxInfo(FILE* fp) const
{
    fwrite(&bbox_num, sizeof(DWORD), 1, fp);
    fwrite(&bbox_seq[0], sizeof(drBoundingBoxInfo), bbox_num, fp);

    return DR_RET_OK;
}
DR_RESULT drHelperInfo::_SaveBoundingSphereInfo(FILE* fp) const
{
    fwrite(&bsphere_num, sizeof(DWORD), 1, fp);
    fwrite(&bsphere_seq[0], sizeof(drBoundingSphereInfo), bsphere_num, fp);

    return DR_RET_OK;
}

// drGeomObjInfo
DR_STD_ILELEMENTATION(drGeomObjInfo)

DR_RESULT drGeomObjInfo::Load(FILE* fp, DWORD version)
{
    fread((drGeomObjInfoHeader*)&id, sizeof(drGeomObjInfoHeader), 1, fp);

    // for compatible version
    state_ctrl.SetState(STATE_FRAMECULLING, 0);
    state_ctrl.SetState(STATE_UPDATETRANSPSTATE, 1);

    // debug
    if(mtl_size> 100000)
    {
        return DR_RET_FAILED;
    }
    // end

    // read mtl data
    if(mtl_size > 0)
    {        
        drLoadMtlTexInfo(&mtl_seq, &mtl_num, fp, version);
    }

    // read mesh data
    if(mesh_size > 0)
    {
        drMeshInfo_Load(&mesh, fp, version);
    }

    // read helper datas
    if(helper_size > 0)
    {
        helper_data.Load(fp, version);
    }

    // read animation data
    if(anim_size > 0)
    {
        anim_data.Load(fp, version);
    }


    ///*
#if(defined DR_USE_DX9)
    if(mesh.fvf & D3DFVF_LASTBETA_UBYTE4)
    {
        if(mesh.fvf & D3DFVF_XYZB2)
        {
            mesh.fvf &= ~D3DFVF_XYZB2;
        }
        else if(mesh.fvf & D3DFVF_XYZB3)
        {
            mesh.fvf &= ~D3DFVF_XYZB3;
        }
        
        mesh.fvf |= D3DFVF_XYZB4;
    }
    if((rcci.vs_id == VST_PU4NT0_LD) 
        || (rcci.vs_id == VST_PB1U4NT0_LD)
        || (rcci.vs_id == VST_PB2U4NT0_LD)
        || (rcci.vs_id == VST_PB3U4NT0_LD))
    {
        rcci.ctrl_id = RENDERCTRL_VS_VERTEXBLEND_DX9;
        rcci.vs_id = VST_PB4U4NT0_LD_DX9;
        rcci.decl_id = VDT_PB4U4NT0_DX9;
    }

#endif
    //*/

    return DR_RET_OK;

}
DR_RESULT drGeomObjInfo::Save(FILE* fp)
{
    //fwrite(&VERSION, sizeof(VERSION), 1, fp);

    fwrite((drGeomObjInfoHeader*)&id, sizeof(drGeomObjInfoHeader), 1, fp);

    // save mtl data
    if(mtl_size > 0)
    {        
        drSaveMtlTexInfo(fp, &mtl_seq[0], mtl_num);
    }

    // save mesh data
    if(mesh_size > 0)
    {
        drMeshInfo_Save(&mesh, fp);
    }

    if(helper_size > 0)
    {
        helper_data.Save(fp);
    }

    if(anim_size > 0)
    {
        anim_data.Save(fp);
    }


    return DR_RET_OK;

}

DR_RESULT drGeomObjInfo::Load(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        return DR_RET_FAILED;

    DWORD version;
    fread(&version, sizeof(version), 1, fp);

    DR_RESULT ret = Load(fp, version);

    if(fp)
    {
        fclose(fp);
    }

    return ret;

}

DR_RESULT drGeomObjInfo::Save(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp == NULL)
        return DR_RET_FAILED;

    DWORD version = EXP_OBJ_VERSION;
    fwrite(&version, sizeof(version), 1, fp);

    Save(fp);

    if(fp)
    {
        fclose(fp);
    }

    return DR_RET_OK;

}

DWORD drGeomObjInfo::GetDataSize() const
{
    DWORD size = 0;

    //size += sizeof(VERSION);

    size += sizeof(drGeomObjInfoHeader);
    size += mtl_size;
    size += mesh_size;
    size += helper_size;
    size += anim_size;

    return size;
}

// drModelObjInfo
DR_STD_ILELEMENTATION(drModelObjInfo)

DR_RESULT drModelObjInfo::Load(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        return DR_RET_FAILED;


    DWORD version;
    fread(&version, sizeof(version), 1, fp);


    DWORD obj_num;
    fread(&obj_num, sizeof(DWORD), 1, fp);

    drModelObjInfoHeader header[DR_MAX_MODEL_OBJ_NUM];
    fread(&header[0], sizeof(drModelObjInfoHeader), obj_num, fp);

    geom_obj_num = 0;

    for(DWORD i = 0; i < obj_num; i++)
    {
        fseek(fp, header[i].addr, SEEK_SET);        

        switch(header[i].type)
        {
        case MODEL_OBJ_TYPE_GEOMETRY:
            geom_obj_seq[geom_obj_num] = DR_NEW(drGeomObjInfo());
            if(version == EXP_OBJ_VERSION_0_0_0_0)
            {
                DWORD old_version;
                fread(&old_version, sizeof(old_version), 1, fp);
            }
            geom_obj_seq[geom_obj_num]->Load(fp, version);
            geom_obj_num += 1;
            break;
        case MODEL_OBJ_TYPE_HELPER:
            helper_data.Load(fp, version);
            break;
        default:
            assert(0);
        }
    }
    

    if(fp)
    {
        fclose(fp);
    }

    return DR_RET_OK;

}
DR_RESULT drModelObjInfo::Save(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp == NULL)
        return DR_RET_FAILED;


    DWORD version = EXP_OBJ_VERSION;

    fwrite(&version, sizeof(version), 1, fp);

    DWORD obj_num = geom_obj_num;

    if(helper_data.type != HELPER_TYPE_INVALID)
    {
        obj_num += 1;
    }

    fwrite(&obj_num, sizeof(DWORD), 1, fp);

    DWORD i;
    drModelObjInfoHeader header;
    const drGeomObjInfo* goi;

    DWORD base_offset_size = sizeof(version) + sizeof(obj_num) + sizeof(header) * obj_num;

    DWORD total_obj_size = 0;

    // geomobj header
    for(i = 0; i < geom_obj_num; i++)
    {
        goi = geom_obj_seq[i];

        header.type = MODEL_OBJ_TYPE_GEOMETRY;
        header.addr = base_offset_size + total_obj_size;
        header.size = goi->GetDataSize();

        fwrite(&header, sizeof(header), 1, fp);

        total_obj_size += header.size;
    }
    

    // helper header
    if(helper_data.type != HELPER_TYPE_INVALID)
    {
        header.addr = base_offset_size + total_obj_size;
        header.size = helper_data.GetDataSize();
        header.type = MODEL_OBJ_TYPE_HELPER;

        fwrite(&header, sizeof(header), 1, fp);

        total_obj_size += header.size;
    }

    // save geometry data
    for(i = 0; i < geom_obj_num; i++)
    {
        geom_obj_seq[i]->Save(fp);
    }


    // save helper data
    if(helper_data.type != HELPER_TYPE_INVALID)
    {
        helper_data.Save(fp);
    }


    if(fp)
    {
        fclose(fp);
    }


    return DR_RET_OK;

}

DR_RESULT drModelObjInfo::SortGeomObjInfoWithID()
{
    drGeomObjInfo* buf;
    for(DWORD i = 0; i < geom_obj_num-1; i++)
    {
        for(DWORD j = i+1; j < geom_obj_num; j++)
        {
            if(geom_obj_seq[i]->id  > geom_obj_seq[j]->id)
            {
                buf = geom_obj_seq[i];
                geom_obj_seq[i] = geom_obj_seq[j];
                geom_obj_seq[j] = buf;
            }
        }
    }

    return 1;
}

DWORD drModelObjInfo::GetDataSize()
{
    DWORD size = 0;

    for(DWORD i = 0; i < geom_obj_num; i++)
    {
        size += geom_obj_seq[i]->GetDataSize();
    }

    size += helper_data.GetDataSize();

    return size;
}

DR_RESULT drModelObjInfo::GetHeader(drModelObjInfoHeader* header_seq, DWORD* header_num, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        goto __ret;

    DWORD version;
    fread(&version, sizeof(DWORD), 1, fp);


    fread(header_num, sizeof(DWORD), 1, fp);

    fread(&header_seq[0], sizeof(drModelObjInfoHeader), *header_num, fp);

    ret = DR_RET_OK;

__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;

}

// drHelperDummyObjInfo
DR_STD_ILELEMENTATION(drHelperDummyObjInfo)

drHelperDummyObjInfo::drHelperDummyObjInfo()
{
    _id = DR_INVALID_INDEX;
    drMatrix44Identity(&_mat);
    _anim_data = 0;
}
drHelperDummyObjInfo::~drHelperDummyObjInfo()
{
    DR_IF_RELEASE(_anim_data);
}

DR_RESULT drHelperDummyObjInfo::Load(FILE* fp, DWORD version)
{
    DR_RESULT ret = DR_RET_FAILED;

    fread(&_id, sizeof(_id), 1, fp);
    fread(&_mat, sizeof(_mat), 1, fp);

    DR_SAFE_RELEASE(_anim_data);

    DWORD anim_data_flag = 0;
    fread(&anim_data_flag, sizeof(anim_data_flag), 1, fp);
    if(anim_data_flag == 1)
    {
        drAnimDataMatrix* anim_data = DR_NEW(drAnimDataMatrix);
        if(DR_FAILED(anim_data->Load(fp, 0)))
        {
            DR_DELETE(anim_data);
            goto __ret;
        }
        _anim_data = anim_data;
    }


    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drHelperDummyObjInfo::Save(FILE* fp)
{
    DR_RESULT ret = DR_RET_FAILED;

    fwrite(&_id, sizeof(_id), 1, fp);
    fwrite(&_mat, sizeof(_mat), 1, fp);

    DWORD anim_data_flag = _anim_data ? 1 : 0;
    fwrite(&anim_data_flag, sizeof(anim_data_flag), 1, fp);
    if(_anim_data)
    {
        if(DR_FAILED(((drAnimDataMatrix*)_anim_data)->Save(fp)))
            goto __ret;
    }
    
    ret = DR_RET_OK;
__ret:
    return ret;
}

//
drModelNodeInfo::~drModelNodeInfo()
{
    if(_type == NODE_PRIMITIVE)
    {
        drGeomObjInfo* data = (drGeomObjInfo*)_data;
        DR_IF_DELETE(data);
    }
    else if(_type == NODE_BONECTRL)
    {
        drAnimDataBone* data = (drAnimDataBone*)_data;
        DR_IF_DELETE(data);
    }
    else if(_type == NODE_DUMMY)
    {
        drMatrix44* data = (drMatrix44*)_data;
        DR_IF_DELETE(data);
    }
    else if(_type == NODE_HELPER)
    {
        drHelperInfo* data = (drHelperInfo*)_data;
        DR_IF_DELETE(data);
    }
}

DR_RESULT drModelNodeInfo::Load(FILE* fp, DWORD version)
{
    DR_RESULT ret = DR_RET_FAILED;

    fread(&_head, sizeof(_head), 1, fp);

    if(_type == NODE_PRIMITIVE)
    {
        _data = DR_NEW(drGeomObjInfo);
        if(DR_FAILED(((drGeomObjInfo*)_data)->Load(fp, version)))
            goto __ret;
    }
    else if(_type == NODE_BONECTRL)
    {
        _data = DR_NEW(drAnimDataBone);
        if(DR_FAILED(((drAnimDataBone*)_data)->Load(fp, version)))
            goto __ret;
    }
    else if(_type == NODE_DUMMY)
    {
        _data = DR_NEW(drHelperDummyObjInfo);
        if(DR_FAILED(((drHelperDummyObjInfo*)_data)->Load(fp, version)))
            goto __ret;
    }
    else if(_type == NODE_HELPER)
    {
        _data = DR_NEW(drHelperInfo);
        if(DR_FAILED(((drHelperInfo*)_data)->Load(fp, version)))
            goto __ret;
    }
    else
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drModelNodeInfo::Save(FILE* fp)
{
    DR_RESULT ret = DR_RET_FAILED;

    fwrite(&_head, sizeof(_head), 1, fp);

    if(_type == NODE_PRIMITIVE)
    {
        if(DR_FAILED(((drGeomObjInfo*)_data)->Save(fp)))
            goto __ret;
    }
    else if(_type == NODE_BONECTRL)
    {
        if(DR_FAILED(((drAnimDataBone*)_data)->Save(fp)))
            goto __ret;
    }
    else if(_type == NODE_DUMMY)
    {
        if(DR_FAILED(((drHelperDummyObjInfo*)_data)->Save(fp)))
            goto __ret;
    }
    else if(_type == NODE_HELPER)
    {
        if(DR_FAILED(((drHelperInfo*)_data)->Save(fp)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drModelInfo
static DWORD __tree_proc_modlinfo_destroy(drITreeNode* node, void* param)
{
    drModelNodeInfo* data = (drModelNodeInfo*)node->GetData();
    DR_IF_DELETE(data);

    return TREENODE_PROC_RET_CONTINUE;
}
struct __load_param
{
    FILE* fp;
    DWORD version;
};

static DWORD __tree_proc_modlinfo_load(drITreeNode* node, void* param)
{
    __load_param* lp = (__load_param*)param;
    
    drModelNodeInfo* data = DR_NEW(drModelNodeInfo);

    if(DR_FAILED(data->Load(lp->fp, lp->version)))
    {
        DR_DELETE(data);
        return TREENODE_PROC_RET_ABORT;
    }

    node->SetData(data);

    return TREENODE_PROC_RET_CONTINUE;
}
static DWORD __tree_proc_modlinfo_save(drITreeNode* node, void* param)
{
    FILE* fp = (FILE*)param;
    
    drModelNodeInfo* data = (drModelNodeInfo*)node->GetData();

    if(DR_FAILED(data->Save(fp)))
    {
        return TREENODE_PROC_RET_ABORT;
    }

    return TREENODE_PROC_RET_CONTINUE;
}

drModelInfo::~drModelInfo()
{
    Destroy();
}

static DWORD __tree_node_release_proc(drITreeNode* node, void* param)
{
    DR_RELEASE(node);
    return TREENODE_PROC_RET_CONTINUE;
}

void drReleaseTreeNodeList_(drITreeNode* node)
{
    node->EnumTree(__tree_node_release_proc, 0, TREENODE_PROC_POSTORDER);
}

DR_RESULT drModelInfo::Destroy()
{
    if(_obj_tree)
    {
        _obj_tree->EnumTree(__tree_proc_modlinfo_destroy, 0, TREENODE_PROC_PREORDER);
        //drReleaseTreeNodeList(_obj_tree);
        drReleaseTreeNodeList_(_obj_tree);
    }

    return DR_RET_OK;
}

struct __find_info
{
    drITreeNode* node;
    DWORD handle;
};

static DWORD __tree_proc_find_node(drITreeNode* node, void* param)
{
    drModelNodeInfo* data = (drModelNodeInfo*)node->GetData();
    __find_info* info = (__find_info*)param;

    if(data->_handle == info->handle)
    {
        info->node = node;
        return TREENODE_PROC_RET_ABORT;
    }

    return TREENODE_PROC_RET_CONTINUE;
}

DR_RESULT drModelInfo::Load(const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;
    
    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == 0)
        goto __ret;

    fread(&_head, sizeof(_head), 1, fp);

    DWORD obj_num;
    fread(&obj_num, sizeof(obj_num), 1, fp);

    if(obj_num == 0)
        goto __addr_ret_ok;

    drITreeNode* tree_node = 0;
    drModelNodeInfo* node_info = 0;

    for(DWORD i = 0; i < obj_num; i++)
    {
        node_info = DR_NEW(drModelNodeInfo);
        if(DR_FAILED(node_info->Load(fp, _head.version)))
        {
            DR_DELETE(node_info);
            goto __ret;
        }

        tree_node = DR_NEW(drTreeNode);
        tree_node->SetData(node_info);

        // reset tree
        if(_obj_tree == 0)
        {
            _obj_tree = tree_node;
        }
        else
        {
            __find_info param;
            param.handle = node_info->_parent_handle;
            param.node = 0;
            _obj_tree->EnumTree(__tree_proc_find_node, (void*)&param, TREENODE_PROC_PREORDER);

            if(param.node == 0)
                goto __ret;

            if(DR_FAILED(param.node->InsertChild(0, tree_node)))
                goto __ret;
        }
        
    }

    //if(_obj_tree)
    //{
    //    __load_param lp;
    //    lp.fp = fp;
    //    lp.version = _head.version;

    //    DR_RESULT r = _obj_tree->EnumTree(__tree_proc_modlinfo_load, &lp, TREENODE_PROC_INORDER);
    //    if(r == TREENODE_PROC_RET_ABORT)
    //        goto __ret;
    //}

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;

}
DR_RESULT drModelInfo::Save(const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp == 0)
        goto __ret;

    _head.version = MODELINFO_VERSION;
    _tcsncpy_s(_head.decriptor, "drModelInfo", _TRUNCATE);

    fwrite(&_head, sizeof(_head), 1, fp);

    DWORD obj_num = _obj_tree ? _obj_tree->GetNodeNum() : 0;

    fwrite(&obj_num, sizeof(obj_num), 1, fp);

    if(_obj_tree == 0)
        goto __ret;    

    DR_RESULT r = _obj_tree->EnumTree(__tree_proc_modlinfo_save, fp, TREENODE_PROC_PREORDER);
    if(r == TREENODE_PROC_RET_ABORT)
        goto __ret;


    ret = DR_RET_OK;
__ret:
    if(fp)
    {
        fclose(fp);
    }

    return ret;

}

DR_RESULT drModelNodeSortChild(drITreeNode* node)
{
    DWORD child_num = node->GetChildNum();

    if(child_num < 2)
    {
        return DR_RET_OK;
    }

    drITreeNode** child_seq = DR_NEW(drITreeNode*[child_num]);


    // init buf
    DWORD i, j;
    for(i = 0; i < child_num; i++)
    {
        child_seq[i] = node->GetChild(i);
    }

    // sort
    drITreeNode* buf;
    drModelNodeInfo* node_i;
    drModelNodeInfo* node_j;

    for(i = 0; i < child_num-1; i++)
    {

        for(j = i+1; j < child_num; j++)
        {
            node_i = (drModelNodeInfo*)child_seq[i]->GetData();
            node_j = (drModelNodeInfo*)child_seq[j]->GetData();

            if(node_i->_id > node_j->_id)
            {
                buf = child_seq[i];
                child_seq[i] = child_seq[j];
                child_seq[j] = buf;
            }
        }
    }

    // reset sibling
    for(i = 0; i < child_num - 1; i++)
    {
        child_seq[i]->SetSibling(child_seq[i+1]);
    }
    child_seq[child_num-1]->SetSibling(0);

    node->SetChild(child_seq[0]);

    DR_DELETE_A(child_seq);

    return DR_RET_OK;
};

DWORD __tree_proc_sort_id(drITreeNode* node, void* param)
{
    if(DR_FAILED(drModelNodeSortChild(node)))
        return TREENODE_PROC_RET_ABORT;

    return TREENODE_PROC_RET_CONTINUE;
}

DR_RESULT drModelInfo::SortChildWithID()
{
    DWORD ret = _obj_tree->EnumTree(__tree_proc_sort_id, 0, TREENODE_PROC_PREORDER);
    
    return ret == TREENODE_PROC_RET_CONTINUE ? DR_RET_OK : DR_RET_FAILED;
}

DR_END
