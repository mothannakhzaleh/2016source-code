//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drMath.h"
#include "drDirectX.h"
#include "drClassDecl.h"
#include "drITypes.h"

DR_BEGIN

template< DWORD set_size, DWORD seq_size >
struct drRenderStateSetTemplate
{
    enum { 
        SET_SIZE = set_size,
        SEQUENCE_SIZE = seq_size,
    };

    drRenderStateValue rsv_seq[SET_SIZE][SEQUENCE_SIZE];
};

template< DWORD set_size, DWORD seq_size >
inline void drRenderStateSetTemplate_Construct(drRenderStateSetTemplate< set_size, seq_size >* obj)
{
    typedef drRenderStateSetTemplate<set_size, seq_size> type_value;

    for(DWORD i = 0; i < type_value::SET_SIZE; i++)
    {
        for(DWORD j = 0; j < type_value::SEQUENCE_SIZE; j++)
        {
            obj->rsv_seq[i][j].state = DR_INVALID_INDEX;
            obj->rsv_seq[i][j].state = DR_INVALID_INDEX;
        }
    }
}
template< DWORD set_size, DWORD seq_size >
DR_RESULT drSetRenderStateSet(drRenderStateSetTemplate< set_size, seq_size >* obj, DWORD set_id, DWORD state, DWORD value)
{
    typedef drRenderStateSetTemplate<set_size, seq_size> type_value;

    DWORD i;
    drRenderStateValue* rsv_seq = obj->rsv_seq[set_id];
    drRenderStateValue* rsv;
    
    for(i = 0; i < type_value::SEQUENCE_SIZE; i++)
    {
        rsv = &rsv_seq[i];

        if(rsv->state == state)
        {
            rsv->value = value;
            goto __ret;
        }
    }

    for(i = 0; i < type_value::SEQUENCE_SIZE; i++)
    {
        rsv = &rsv_seq[i];

        if(rsv->state == DR_INVALID_INDEX)
        {
            rsv->state = state;
            rsv->value = value;
            goto __ret;
        }
    }

__ret:
    return i == type_value::SEQUENCE_SIZE ? DR_RET_FAILED : DR_RET_OK;

}

template< DWORD set_size, DWORD seq_size >
DR_RESULT drClearRenderStateSet(drRenderStateSetTemplate< set_size, seq_size >* obj, DWORD set_id, DWORD state)
{
    typedef drRenderStateSetTemplate<set_size, seq_size> type_value;

    DWORD i;
    drRenderStateValue* rsv;
    drRenderStateValue* rsv_seq = obj->rsv_seq[set_id];

    for(i = 0; i < type_value::SEQUENCE_SIZE; i++)
    {
        rsv = &rsv_seq[i];

        if(rsv->state == state)
        {
            for(DWORD j = i; j < type_value::SEQUENCE_SIZE - 1; j++)
            {
                if(rsv_seq[j + 1].state == DR_INVALID_INDEX)
                    goto __ret;

                rsv_seq[j] = rsv_seq[j + 1];
            }

            goto __ret;
        }
    }

__ret:

    return i == type_value::SEQUENCE_SIZE ? DR_RET_FAILED : DR_RET_OK;


}

typedef drRenderStateSetTemplate< 2, DR_MESH_RS_NUM > drRenderStateSetMesh2;
typedef drRenderStateSetTemplate< 2, DR_MTL_RS_NUM > drRenderStateSetMtl2;
typedef drRenderStateSetTemplate< 2, DR_TEX_TSS_NUM > drTextureStageStateSetTex2;
typedef drRenderStateSetTemplate< 2, DR_TEX_RS_NUM > drRenderStateSetTex2;

typedef drRenderStateSetMtl2 drMtlDRS;
typedef drRenderStateSetTemplate< 2, DR_TEX_DTSS_NUM > drTexDTSS;
typedef drRenderStateSetTemplate< 2, DR_TEX_DRS_NUM > drTexDRS;


struct drRenderStateAtom
{
    DWORD state;
    DWORD value0;
    DWORD value1;
};
void inline drRenderStateAtom_Construct(drRenderStateAtom* obj)
{
    obj->state = DR_INVALID_INDEX;
    obj->value0 = 0;
    obj->value1 = 0;
}
void inline drRenderStateAtom_Construct_A(drRenderStateAtom* obj_seq, DWORD num)
{
    for(DWORD i = 0; i < num; i++)
    {
        drRenderStateAtom_Construct(&obj_seq[i]);
    }
}


inline void RSA_VALUE(drRenderStateAtom* obj, DWORD state, DWORD value)
{
    obj->state = state;
    obj->value0 = value;
    obj->value1 = value;
}

enum drTexInfoTypeEnum
{
    TEX_TYPE_FILE =         0,
    TEX_TYPE_SIZE,
    TEX_TYPE_DATA,
    TEX_TYPE_INVALID =      DR_INVALID_INDEX,
};

struct drTexFileInfo
{
};
struct drTexMemInfo
{
};

struct drTexInfo
{
    DWORD stage;
    DWORD level;
    DWORD usage;
    D3DFORMAT format;
    D3DPOOL pool;
    DWORD byte_alignment_flag;
    DWORD type; // file texture or user-defined texture
    // user-defined texture
    DWORD width; // 当使用TEX_TYPE_DATA的时候，width表示data size
    DWORD height;
    // file texture
    DWORD colorkey_type;
    drColorValue4b colorkey;
    char file_name[DR_MAX_NAME];
    void* data;

    drRenderStateAtom tss_set[DR_TEX_TSS_NUM];
};

inline void drTexInfo_Construct(drTexInfo* obj)
{
    obj->stage = DR_INVALID_INDEX;
    obj->level = 0;
    obj->usage = 0;
    obj->format = D3DFMT_UNKNOWN;
    obj->pool = D3DPOOL_FORCE_DWORD;
    obj->byte_alignment_flag = 0;
    obj->type = TEX_TYPE_INVALID;

    obj->width = 0;
    obj->height = 0;

    obj->colorkey_type = COLORKEY_TYPE_NONE;
    obj->colorkey.color = 0;
    obj->file_name[0] = '\0';
    obj->data = 0;

    //drRenderStateSetTemplate_Construct(&obj->tss_set);
    drRenderStateAtom_Construct_A(obj->tss_set, DR_TEX_TSS_NUM);
}

struct drMtlInfo
{
    drMaterial mtl;

    drRenderStateSetMtl2 rs_set;
};

struct drBlendInfo
{
    union {
        BYTE index[4];
        DWORD indexd;
    };
    float weight[4];
};

struct drSubsetInfo
{
    DWORD primitive_num;
    DWORD start_index;
    DWORD vertex_num;
    DWORD min_index;
};

inline void drSubsetInfo_Construct(drSubsetInfo* obj, DWORD pri_num, DWORD start_index, DWORD vertex_num, DWORD min_index)
{
    obj->primitive_num = pri_num;
    obj->start_index = start_index;
    obj->vertex_num = vertex_num;
    obj->min_index = min_index;
}
struct drBoundingBoxInfo
{
    DWORD id;
    drBox box;
    drMatrix44 mat;
};

struct drBoundingSphereInfo
{
    DWORD id;
    drSphere sphere;
    drMatrix44 mat;
};

struct drIndexMatrix44
{
    DWORD id;
    drMatrix44 mat;
};

struct drHelperDummyInfo
{
    DWORD id;
    drMatrix44 mat;
    drMatrix44 mat_local;
    DWORD parent_type;  // 0: default, 1: bone parent, 2: bone dummy parent
    DWORD parent_id;
};

struct drHelperMeshFaceInfo
{
    DWORD vertex[3];
    DWORD adj_face[3];

    drPlane plane;
    drVector3 center;
};

struct drHelperMeshInfo
{
    drHelperMeshInfo()
        : id(DR_INVALID_INDEX), type(0), sub_type(0), state(1),
        vertex_seq(0), face_seq(0), vertex_num(0), face_num(0)
    {
        name[0] = '\0';
    }

    ~drHelperMeshInfo()
    {
        DR_SAFE_DELETE_A(vertex_seq);
        DR_SAFE_DELETE_A(face_seq);
    }

    DR_RESULT Copy(const drHelperMeshInfo* src);

    DWORD id;
    DWORD type; // helper mesh type
    char name[DR_CHAR_32];
    DWORD state;
    DWORD sub_type;
    drMatrix44 mat;
    drBox box;
    drVector3* vertex_seq;
    drHelperMeshFaceInfo* face_seq;

    DWORD vertex_num;
    DWORD face_num;

};

struct drHelperBoxInfo
{
    drHelperBoxInfo()
        : id(0), type(0), state(1)
    {
        name[0] = '\0';
    }

    DWORD id;
    DWORD type;
    DWORD state;
    drBox box;
    drMatrix44 mat;
    char name[DR_CHAR_32];

    DR_RESULT Copy(const drHelperBoxInfo* src) { memcpy(this, src, sizeof(drHelperBoxInfo)); return DR_RET_OK; }
};

struct drMeshInfo
{
    struct drMeshInfoHeader
    {
        DWORD fvf;
        D3DPRIMITIVETYPE pt_type;

        DWORD vertex_num;
        DWORD index_num;
        DWORD subset_num;
        DWORD bone_index_num;
        DWORD bone_infl_factor;
        DWORD vertex_element_num;

        drRenderStateAtom rs_set[DR_MESH_RS_NUM];
    };

    union
    {
        drMeshInfoHeader header;

        struct
        {
            DWORD fvf;
            D3DPRIMITIVETYPE pt_type;

            DWORD vertex_num;
            DWORD index_num;
            DWORD subset_num;
            DWORD bone_index_num;
            DWORD bone_infl_factor;
            DWORD vertex_element_num;

            drRenderStateAtom rs_set[DR_MESH_RS_NUM];
        };
    };

    drVector3* vertex_seq;
    drVector3* normal_seq;
    union 
    {
        drVector2* texcoord_seq[DR_MAX_TEXTURESTAGE_NUM];
        struct 
        {
            drVector2* texcoord0_seq;
            drVector2* texcoord1_seq;
            drVector2* texcoord2_seq;
            drVector2* texcoord3_seq;
        };
    };
    DWORD* vercol_seq;
    DWORD* index_seq;
    DWORD* bone_index_seq;
    drBlendInfo* blend_seq;
    drSubsetInfo* subset_seq;
    D3DVERTEXELEMENTX* vertex_element_seq;


    drMeshInfo()
        : vertex_seq(0), normal_seq(0), vercol_seq(0), index_seq(0), 
        subset_seq(0), blend_seq(0), bone_index_seq(0),
        texcoord0_seq(0), texcoord1_seq(0), texcoord2_seq(0), texcoord3_seq(0),
        vertex_num(0), index_num(0), subset_num(0), bone_index_num(0), 
        bone_infl_factor(0), vertex_element_seq(0), vertex_element_num(0)
    {
        drRenderStateAtom_Construct_A(rs_set, DR_MESH_RS_NUM);
    }

    ~drMeshInfo()
    {
        DR_IF_DELETE_A(vertex_seq);
        DR_IF_DELETE_A(normal_seq);
        DR_IF_DELETE_A(vercol_seq);
        DR_IF_DELETE_A(texcoord0_seq);
        DR_IF_DELETE_A(texcoord1_seq);
        DR_IF_DELETE_A(texcoord2_seq);
        DR_IF_DELETE_A(texcoord3_seq);
        DR_IF_DELETE_A(index_seq);
        DR_IF_DELETE_A(blend_seq);        
        DR_IF_DELETE_A(bone_index_seq);        
        DR_IF_DELETE_A(subset_seq);        
        DR_IF_DELETE_A(vertex_element_seq); 
    }

    void ResetIndexBuffer(const DWORD* buf)
    {
        memcpy(index_seq, buf, sizeof(DWORD) * index_num);
    }

};
typedef drMeshInfo::drMeshInfoHeader drMeshInfoHeader;

inline void drMeshInfo_Construct(drMeshInfo* obj)
{
    obj->fvf = 0;
    obj->pt_type = D3DPT_FORCE_DWORD;
    obj->vertex_num = 0;
    obj->subset_num = 0;
    obj->index_num = 0;
    obj->bone_index_num = 0;
    obj->bone_infl_factor = 0;
    obj->vertex_seq = 0;
    obj->normal_seq = 0;
    obj->vercol_seq = 0;
    obj->blend_seq = 0;
    obj->index_seq = 0;
    obj->texcoord0_seq = 0;
    obj->texcoord1_seq = 0;
    obj->texcoord2_seq = 0;
    obj->texcoord3_seq = 0;
    obj->subset_seq = 0;
    obj->bone_index_seq = 0;
    obj->vertex_element_seq = 0;
    obj->vertex_element_num = 0;
    drRenderStateAtom_Construct_A(obj->rs_set, DR_MESH_RS_NUM);
}

inline void drMeshInfo_Destruct(drMeshInfo* obj)
{
    DR_IF_DELETE_A(obj->vertex_seq);
    DR_IF_DELETE_A(obj->normal_seq);
    DR_IF_DELETE_A(obj->vercol_seq);
    DR_IF_DELETE_A(obj->texcoord0_seq);
    DR_IF_DELETE_A(obj->texcoord1_seq);
    DR_IF_DELETE_A(obj->texcoord2_seq);
    DR_IF_DELETE_A(obj->texcoord3_seq);
    DR_IF_DELETE_A(obj->index_seq);
    DR_IF_DELETE_A(obj->blend_seq);        
}

//enum drMtlTexInfoTransparencyTypeEnum
//{
//    MTLTEX_TRANSP_FILTER =          0,
//    MTLTEX_TRANSP_ADDITIVE =        1,
//    MTLTEX_TRANSP_SUBTRACTIVE =     2,
//};

enum drMtlTexInfoTransparencyTypeEnum
{
    MTLTEX_TRANSP_FILTER =          0,
    MTLTEX_TRANSP_ADDITIVE =        1,
    MTLTEX_TRANSP_ADDITIVE1 =       2,
    MTLTEX_TRANSP_ADDITIVE2 =       3,
    MTLTEX_TRANSP_ADDITIVE3 =       4,
    MTLTEX_TRANSP_SUBTRACTIVE =     5,
    MTLTEX_TRANSP_SUBTRACTIVE1 =    6,
    MTLTEX_TRANSP_SUBTRACTIVE2 =    7,
    MTLTEX_TRANSP_SUBTRACTIVE3 =    8,
};

struct drMtlTexInfo
{
    float opacity;
    DWORD transp_type;
    drMaterial mtl;
    //drRenderStateSetMtl2 rs_set;
    drRenderStateAtom rs_set[DR_MTL_RS_NUM];
    drTexInfo tex_seq[DR_MAX_TEXTURESTAGE_NUM];

    drMtlTexInfo()
    {
        opacity = 1.0f;
        transp_type = MTLTEX_TRANSP_FILTER;
        drMaterial_Construct(&mtl);
        drRenderStateAtom_Construct_A(rs_set, DR_MTL_RS_NUM);

        drTexInfo_Construct(&tex_seq[0]);
        drTexInfo_Construct(&tex_seq[1]);
        drTexInfo_Construct(&tex_seq[2]);
        drTexInfo_Construct(&tex_seq[3]);
    }     
};

enum drObjectStateEnum
{
    STATE_VISIBLE =              0,
    STATE_ENABLE =               1,
    STATE_UPDATETRANSPSTATE =    3,
    STATE_TRANSPARENT =          4,
    STATE_FRAMECULLING =         5,

    STATE_INVALID =              DR_INVALID_INDEX,
    OBJECT_STATE_NUM =                  8
};

class drStateCtrl
{
public:
    BYTE _state_seq[OBJECT_STATE_NUM];

public:
    drStateCtrl()
    {
        SetDefaultState();
    }
    void SetDefaultState()
    {
        memset(_state_seq, 0, sizeof(_state_seq));
        _state_seq[STATE_VISIBLE] = 1;
        _state_seq[STATE_ENABLE] = 1;
        _state_seq[STATE_UPDATETRANSPSTATE] = 1;
        _state_seq[STATE_TRANSPARENT] = 0;
        _state_seq[STATE_FRAMECULLING] = 0;
    }
    inline void SetState(DWORD state, BYTE value){ _state_seq[state] = value; }
    inline BYTE GetState(DWORD state) const { return _state_seq[state]; }
};

class drIBuffer;
struct drSysMemTexInfo
{
    DWORD level;
    DWORD usage;
    D3DFORMAT format;
    DWORD width;
    DWORD height;
    DWORD filter;
    DWORD mip_filter;
    DWORD colorkey;
    char file_name[DR_MAX_PATH];
    IDirect3DTextureX* sys_mem_tex;
    drIBuffer* buf;
    //BYTE* data;
    //DWORD data_size;
};


DR_END
