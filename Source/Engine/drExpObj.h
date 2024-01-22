//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drMath.h"
#include "drDirectX.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drITypes2.h"
#include "drInterfaceExt.h"
#include "drPoseCtrl.h"

DR_BEGIN


//#define USE_ANIM_QUAT
#define USE_ANIM_MAT43
//#define USE_ANIM_MAT44

//#define USE_ANIMKEY_PRS

// begin version define
// --------------------------------
const DWORD EXP_OBJ_VERSION_0_0_0_0 = 0x0000;
// new verson
const DWORD EXP_OBJ_VERSION_1_0_0_0 = 0x1000;
const DWORD EXP_OBJ_VERSION_1_0_0_1 = 0x1001;
const DWORD EXP_OBJ_VERSION_1_0_0_2 = 0x1002;

// 调整导出bone使用quaternion方式保存信息时，保存每一帧的pos信息而不是第一帧
const DWORD EXP_OBJ_VERSION_1_0_0_3 = 0x1003;
// 调整drMeshInfo结构，增加bone_infl_factor和vertex_decl_seq变量
const DWORD EXP_OBJ_VERSION_1_0_0_4 = 0x1004;
// 增加新的动画类型drAnimDataMtlOpacty
const DWORD EXP_OBJ_VERSION_1_0_0_5 = 0x1005;

const DWORD EXP_OBJ_VERSION = EXP_OBJ_VERSION_1_0_0_5;

const DWORD MTLTEX_VERSION0000 = 0x0000;
const DWORD MTLTEX_VERSION0001 = 0x0001;
const DWORD MTLTEX_VERSION0002 = 0x0002;
const DWORD MTLTEX_VERSION = MTLTEX_VERSION0002;

const DWORD MESH_VERSION0000 = 0x0000;
const DWORD MESH_VERSION0001 = 0x0001;
const DWORD MESH_VERSION = MESH_VERSION0001;

struct drTexInfo_0000
{
    DWORD stage;
    DWORD colorkey_type;
    drColorValue4b colorkey;
    D3DFORMAT format;
    char file_name[DR_MAX_NAME];

    drTextureStageStateSetTex2 tss_set;
};

struct drTexInfo_0001
{
    DWORD stage;
    DWORD level;
    DWORD usage;
    D3DFORMAT format;
    D3DPOOL pool;
    DWORD byte_alignment_flag;
    DWORD type; // file texture or user-defined texture
    // user-defined texture
    DWORD width;
    DWORD height;
    // file texture
    DWORD colorkey_type;
    drColorValue4b colorkey;
    char file_name[DR_MAX_NAME];
    void* data;

    drTextureStageStateSetTex2 tss_set;
};

struct drMtlTexInfo_0000
{
    drMaterial mtl;
    drRenderStateSetMtl2 rs_set;
    drTexInfo tex_seq[DR_MAX_TEXTURESTAGE_NUM];

    drMtlTexInfo_0000()
    {
        drMaterial_Construct(&mtl);
        drRenderStateSetTemplate_Construct(&rs_set);

        drTexInfo_Construct(&tex_seq[0]);
        drTexInfo_Construct(&tex_seq[1]);
        drTexInfo_Construct(&tex_seq[2]);
        drTexInfo_Construct(&tex_seq[3]);
    }     
};

struct drMtlTexInfo_0001
{
    float opacity;
    DWORD transp_type;
    drMaterial mtl;
    drRenderStateSetMtl2 rs_set;
    drTexInfo tex_seq[DR_MAX_TEXTURESTAGE_NUM];

    drMtlTexInfo_0001()
    {
        opacity = 1.0f;
        transp_type = MTLTEX_TRANSP_FILTER;
        drMaterial_Construct(&mtl);
        drRenderStateSetTemplate_Construct(&rs_set);

        drTexInfo_Construct(&tex_seq[0]);
        drTexInfo_Construct(&tex_seq[1]);
        drTexInfo_Construct(&tex_seq[2]);
        drTexInfo_Construct(&tex_seq[3]);
    }     
};

struct drMeshInfo_0000
{
    struct drMeshInfoHeader
    {
        DWORD fvf;
        D3DPRIMITIVETYPE pt_type;

        DWORD vertex_num;
        DWORD index_num;
        DWORD subset_num;
        DWORD bone_index_num;

        drRenderStateSetMesh2 rs_set;
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

            drRenderStateSetMesh2 rs_set;
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
    drBlendInfo* blend_seq;


    drSubsetInfo subset_seq[DR_MAX_SUBSET_NUM];
    BYTE bone_index_seq[DR_MAX_BONE_NUM];
   

    drMeshInfo_0000()
        : vertex_seq(0), normal_seq(0), vercol_seq(0), index_seq(0), blend_seq(0),
        texcoord0_seq(0), texcoord1_seq(0), texcoord2_seq(0), texcoord3_seq(0),
        vertex_num(0), index_num(0), subset_num(0), bone_index_num(0)
    {
        memset(subset_seq, 0, sizeof(drSubsetInfo) * DR_MAX_SUBSET_NUM);
        memset(bone_index_seq, 0, sizeof(BYTE) * DR_MAX_BONE_NUM);
        drRenderStateSetTemplate_Construct(&rs_set);
    }

    ~drMeshInfo_0000()
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
    }

};

struct drMeshInfo_0003
{
    struct drMeshInfoHeader
    {
        DWORD fvf;
        D3DPRIMITIVETYPE pt_type;

        DWORD vertex_num;
        DWORD index_num;
        DWORD subset_num;
        DWORD bone_index_num;

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
    drBlendInfo* blend_seq;


    drSubsetInfo subset_seq[DR_MAX_SUBSET_NUM];
    BYTE bone_index_seq[DR_MAX_BONE_NUM];
   

    drMeshInfo_0003()
        : vertex_seq(0), normal_seq(0), vercol_seq(0), index_seq(0), blend_seq(0),
        texcoord0_seq(0), texcoord1_seq(0), texcoord2_seq(0), texcoord3_seq(0),
        vertex_num(0), index_num(0), subset_num(0), bone_index_num(0)
    {
        memset(subset_seq, 0, sizeof(drSubsetInfo) * DR_MAX_SUBSET_NUM);
        memset(bone_index_seq, 0, sizeof(BYTE) * DR_MAX_BONE_NUM);
        drRenderStateAtom_Construct_A(rs_set, DR_MESH_RS_NUM);
    }

    ~drMeshInfo_0003()
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
    }

};

struct drHelperDummyInfo_1000
{
    DWORD id;
    drMatrix44 mat;
};

class drBox_1001
{
public:
    drVector3 p;
    drVector3 s;

public:
    drBox_1001() {}
    drBox_1001(float x,float y,float z,float sx,float sy,float sz)
        : p(x,y,z), s(sx,sy,sz) 
    {}
    drBox_1001(const drVector3& pos,const drVector3& size)
        : p(pos), s(size) 
    {}
    drBox_1001(const drBox_1001& box)
        : p(box.p),s(box.s) 
    {}

    drVector3* GetPointWithMask(drVector3* out_v, DWORD mask) const
    {
        out_v->x = (mask & 0x100) ? (p.x + s.x) : p.x;
        out_v->y = (mask & 0x010) ? (p.y + s.y) : p.y;
        out_v->z = (mask & 0x001) ? (p.z + s.z) : p.z;

        return out_v;
    }
};

// --------------------------------
// end
enum 
{
    MODEL_OBJ_TYPE_GEOMETRY =   1,
    MODEL_OBJ_TYPE_HELPER =     2,
};
// material and texture struct definition

enum drBoneKeyInfoType
{
    BONE_KEY_TYPE_MAT43 =       1,
    BONE_KEY_TYPE_MAT44 =       2,
    BONE_KEY_TYPE_QUAT =        3,
    BONE_KEY_TYPE_INVALID =     DR_INVALID_INDEX,
};

struct drPoseInfoSet
{
    drPoseInfoSet()
        : pose_seq(0), pose_num(0)
    {}

    ~drPoseInfoSet()
    {
        DR_SAFE_DELETE_A(pose_seq);
    }

    drPoseInfo* pose_seq;
    DWORD pose_num;
};
/*
struct drMtlTexInfo : public drIMtlTexInfo
{

DR_STD_DECLARATION()

    enum
    {
        VERSION_00 =     0x0000, // start version
    };

    const static DWORD VERSION = VERSION_00;
    static DWORD version;
    static DWORD GetVersionSize() { return sizeof(version); }
    static void LoadVersionMask(FILE* fp) { fread(&version, sizeof(version), 1, fp); }
    static void SaveVersionMask(FILE* fp) { fwrite(&VERSION, sizeof(version), 1, fp); }

    drMaterial mtl;
    drRenderStateSetMtl2 rs_set;

    drTexInfo tex_seq[DR_MAX_TEXTURESTAGE_NUM];

public:
    drMtlTexInfo()
    {
        drRenderStateSetTemplate_Construct(&rs_set);

        drTexInfo_Construct(&tex_seq[0]);
        drTexInfo_Construct(&tex_seq[1]);
        drTexInfo_Construct(&tex_seq[2]);
        drTexInfo_Construct(&tex_seq[3]);
    }
     
    DR_RESULT Load(FILE* fp);
    DR_RESULT Save(FILE* fp) const;
    DWORD GetDataSize() const { return sizeof(mtl) + sizeof(rs_set) + sizeof(tex_seq); }

};
*/

struct drHelperInfo : public drIHelperInfo
{
DR_STD_DECLARATION()

    drHelperInfo()
        : type(HELPER_TYPE_INVALID), mesh_seq(0), box_seq(0), dummy_seq(0), bbox_seq(0), bsphere_seq(0),
        mesh_num(0), box_num(0), dummy_num(0), bbox_num(0), bsphere_num(0)
    {}
    ~drHelperInfo()
    {
        DR_SAFE_DELETE_A(dummy_seq);
        DR_SAFE_DELETE_A(box_seq);
        DR_SAFE_DELETE_A(mesh_seq);

        DR_SAFE_DELETE_A(bbox_seq);
        DR_SAFE_DELETE_A(bsphere_seq);
    }

    DWORD type;

    drHelperDummyInfo* dummy_seq;
    drHelperBoxInfo* box_seq;
    drHelperMeshInfo* mesh_seq;
    drBoundingBoxInfo* bbox_seq;
    drBoundingSphereInfo* bsphere_seq;

    DWORD dummy_num;
    DWORD box_num;
    DWORD mesh_num;
    DWORD bbox_num;
    DWORD bsphere_num;

    // begin load item
    DR_RESULT _LoadHelperDummyInfo(FILE* fp, DWORD version);
    DR_RESULT _LoadHelperBoxInfo(FILE* fp, DWORD version);
    DR_RESULT _LoadHelperMeshInfo(FILE* fp, DWORD version);
    DR_RESULT _LoadBoundingBoxInfo(FILE* fp, DWORD version);
    DR_RESULT _LoadBoundingSphereInfo(FILE* fp, DWORD version);

    DR_RESULT _SaveHelperDummyInfo(FILE* fp) const;
    DR_RESULT _SaveHelperBoxInfo(FILE* fp) const;
    DR_RESULT _SaveHelperMeshInfo(FILE* fp) const;
    DR_RESULT _SaveBoundingBoxInfo(FILE* fp) const;
    DR_RESULT _SaveBoundingSphereInfo(FILE* fp) const;
    // end

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp) const;

    DR_RESULT Copy(const drHelperInfo* src);
    DWORD GetDataSize() const;
};


// bone-skin struct definition
struct drBoneBaseInfo
{
    char name[DR_MAX_NAME];
    DWORD id;
    DWORD parent_id;

};

struct drBoneDummyInfo
{
    DWORD id;
    DWORD parent_bone_id;
    drMatrix44 mat;
};

struct drBoneKeyInfo
{
    drMatrix43* mat43_seq;
    drMatrix44* mat44_seq;
    struct {
        drVector3* pos_seq;
        drQuaternion* quat_seq;
    };

    drBoneKeyInfo()
        : mat43_seq(0), mat44_seq(0), quat_seq(0), pos_seq(0)
    {}

    ~drBoneKeyInfo()
    {
        DR_SAFE_DELETE_A(mat43_seq);
        DR_SAFE_DELETE_A(mat44_seq);
        DR_SAFE_DELETE_A(quat_seq);
        DR_SAFE_DELETE_A(pos_seq);
    }
};


class drAnimDataBone : public drIAnimDataBone
{

DR_STD_DECLARATION()

protected:
public:
    struct drBoneInfoHeader
    {
        DWORD bone_num;
        DWORD frame_num;
        DWORD dummy_num;
        DWORD key_type;
    };

    union
    {
        drBoneInfoHeader _header;

        struct {
            DWORD _bone_num;
            DWORD _frame_num;
            DWORD _dummy_num;
            DWORD _key_type;
        };
    };

    drBoneBaseInfo* _base_seq;
    drBoneDummyInfo* _dummy_seq;
    drBoneKeyInfo* _key_seq;
    drMatrix44* _invmat_seq;

    //DWORD _subset_type;

public:
    drAnimDataBone();
    virtual ~drAnimDataBone();

    //DWORD GetAnimDataType() const { return ANIM_CTRL_TYPE_BONE; }
    //DWORD GetSubsetType() const { return _subset_type; }
    //void SetSubsetType(DWORD subset_type) { _subset_type = subset_type; }

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp) const;
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file) const;
    DR_RESULT Destroy();

    DR_RESULT Copy(const drAnimDataBone* src);

    DWORD GetDataSize() const;

    // start_frame,end_frame 用来标明frame取插值计算时候的边界
    // 如果start_frame == DR_INVALID_INDEX和end_frame == DR_INVALID_INDEX
    // 则不作帧边界裁减
    DR_RESULT GetValue(drMatrix44* mat, DWORD bone_id, float frame, DWORD start_frame, DWORD end_frame);

    inline void SetBoneNum(DWORD num) { _bone_num = num; }
    inline void SetFrameNum(DWORD num) { _frame_num = num; }
    inline void SetKeyType(DWORD type) { _key_type = type; }

    inline DWORD GetBoneNum() const { return _bone_num; }
    inline DWORD GetFrameNum() const { return _frame_num; }
    inline DWORD GetDummyNum() const { return _dummy_num; }
    inline DWORD GetKeyType() const { return _key_type; };
    inline drBoneBaseInfo* GetBaseInfo() { return _base_seq; }
    inline drBoneKeyInfo* GetKeyInfo() { return _key_seq; }
    inline drMatrix44* GetInitInvMat() { return _invmat_seq; }
    inline drBoneDummyInfo* GetDummyInfo() { return _dummy_seq; }
};


class drAnimDataMatrix : public drIAnimDataMatrix
{

DR_STD_DECLARATION()

public:

    drMatrix43* _mat_seq;
    DWORD _frame_num;

    //DWORD _subset_type;

public:
    drAnimDataMatrix();
    virtual ~drAnimDataMatrix(); 

    //DWORD GetAnimDataType() const { return ANIM_CTRL_TYPE_BONE; }
    //DWORD GetSubsetType() const { return _subset_type; }
    //void SetSubsetType(DWORD subset_type) { _subset_type = subset_type; }

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp) const;
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file) const;
    DR_RESULT Copy(const drAnimDataMatrix* src);

    DWORD GetDataSize() const;

    DWORD GetFrameNum() { return _frame_num; }
    DR_RESULT GetValue(drMatrix44* mat, float frame);
};

struct drKeyDataVector3
{
    DWORD key;
    drVector3 data;
};

struct drKeyDataQuaternion
{
    DWORD key;
    drQuaternion data;
};
struct drKeyDataMatrix43
{
    DWORD key;
    drMatrix43 data;
};

struct drAnimKeySetPRS
{

    DWORD _interpolate_type;

    drKeyDataVector3* pos_seq;
    drKeyDataQuaternion* rot_seq;
    drKeyDataVector3* sca_seq;
    DWORD pos_num;
    DWORD rot_num;
    DWORD sca_num;
    DWORD frame_num;

    drAnimKeySetPRS()
        : pos_seq(0), rot_seq(0), sca_seq(0), pos_num(0), rot_num(0), sca_num(0), frame_num(0)
    {}

    virtual ~drAnimKeySetPRS()
    {
        DR_SAFE_DELETE_A(pos_seq);
        DR_SAFE_DELETE_A(rot_seq);
        DR_SAFE_DELETE_A(sca_seq);
    }

    DR_RESULT GetValue(drMatrix44* mat, float frame);
};

struct drKeyDataTexUV
{
    float u;
    float v;
    float w_angle;
};

struct drAnimDataTexUV : public drIAnimDataTexUV
{

DR_STD_DECLARATION()

public:
    drMatrix44* _mat_seq;
    DWORD _frame_num;

    //DWORD _subset_type;

public:
    drAnimDataTexUV() : _mat_seq(0), _frame_num(0)/*, _subset_type(DR_INVALID_INDEX)*/ {}
    virtual ~drAnimDataTexUV() { DR_SAFE_DELETE_A(_mat_seq); }

    //DWORD GetAnimDataType() const { return ANIM_CTRL_TYPE_BONE; }
    //DWORD GetSubsetType() const { return _subset_type; }
    //void SetSubsetType(DWORD subset_type) { _subset_type = subset_type; }

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp) const;
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file) const;

    DR_RESULT Copy(const drAnimDataTexUV* src);

    DWORD GetDataSize() const;

    DR_RESULT GetValue(drMatrix44* mat, float frame);
    DR_RESULT SetData(const drMatrix44* mat_seq, DWORD mat_num)
    {
        DR_SAFE_DELETE_A(_mat_seq);
        _frame_num = mat_num;
        _mat_seq = DR_NEW(drMatrix44[_frame_num]);
        memcpy(_mat_seq, mat_seq, sizeof(drMatrix44) * _frame_num);
        return DR_RET_OK;
    }
};

class drAnimDataTexImg : public drIAnimDataTexImg
{
    DR_STD_DECLARATION();

public:
    drTexInfo* _data_seq;
    DWORD _data_num;
    char _tex_path[DR_MAX_PATH];

public:
    drAnimDataTexImg()
        : _data_seq(0), _data_num(0)
    {}

    virtual ~drAnimDataTexImg()
    {
        DR_IF_DELETE_A(_data_seq);
    }


    DR_RESULT Copy(const drAnimDataTexImg* src);

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp) const;
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file) const;

    DWORD GetDataSize() const;

};


struct drAnimDataMtlOpacity : public drIAnimDataMtlOpacity
{

    DR_STD_DECLARATION();

private:
    drIAnimKeySetFloat* _aks_ctrl;

public:
    drAnimDataMtlOpacity() : _aks_ctrl(0) {}
    virtual ~drAnimDataMtlOpacity() { DR_SAFE_RELEASE(_aks_ctrl); }

    DR_RESULT Clone(drIAnimDataMtlOpacity** obj);
    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp);
    DWORD GetDataSize();
    drIAnimKeySetFloat* GetAnimKeySet() { return _aks_ctrl; }
    void SetAnimKeySet(drIAnimKeySetFloat* aks_ctrl) { _aks_ctrl = aks_ctrl; }
};


enum
{
    ANIM_DATA_BONE =                0,
    ANIM_DATA_MAT =                 1,
    ANIM_DATA_SUBMTL0_TEXUV =       2,
    ANIM_DATA_SUBMTL0_TEXIMG =      66,
};

class drAnimDataInfo : public drIAnimDataInfo
{
DR_STD_DECLARATION()

    enum { ANIM_DATA_NUM = 2 + DR_MAX_SUBSET_NUM + DR_MAX_SUBSET_NUM * DR_MAX_TEXTURESTAGE_NUM * 2 };


public:
    drAnimDataBone* anim_bone;

#ifdef USE_ANIMKEY_PRS
    drAnimKeySetPRS* anim_mat;
#else
    drAnimDataMatrix* anim_mat;
#endif

    drAnimDataMtlOpacity* anim_mtlopac[DR_MAX_SUBSET_NUM];
    drAnimDataTexUV* anim_tex[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];
    drAnimDataTexImg* anim_img[DR_MAX_SUBSET_NUM][DR_MAX_TEXTURESTAGE_NUM];

public:
    drAnimDataInfo();
    virtual ~drAnimDataInfo();

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp);

    DR_RESULT GetDataSize() const;

};


/*
struct drMeshInfo : public drIMeshInfo
{
DR_STD_DECLARATION()

    enum
    {
        VERSION_00 =     0x0000, // start version
    };

    const static DWORD VERSION = VERSION_00;

    struct drMeshInfoHeader
    {
        DWORD fvf;
        D3DPRIMITIVETYPE pt_type;

        DWORD vertex_num;
        DWORD index_num;
        DWORD subset_num;
        DWORD bone_index_num;

        drRenderStateSetMesh2 rs_set;
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

            drRenderStateSetMesh2 rs_set;
        };
    };

    drVector3* vertex_seq;
    drVector3* normal_seq;
    union {
        drVector2* texcoord_seq[DR_MAX_TEXTURESTAGE_NUM];
        struct {
            drVector2* texcoord0_seq;
            drVector2* texcoord1_seq;
            drVector2* texcoord2_seq;
            drVector2* texcoord3_seq;
        };
    };
    DWORD* vercol_seq;
    DWORD* index_seq;
    drBlendInfo* blend_seq;


    drSubsetInfo subset_seq[DR_MAX_SUBSET_NUM];
    BYTE bone_index_seq[DR_MAX_BONE_NUM];
   

public:
    drMeshInfo()
        : vertex_seq(0), normal_seq(0), vercol_seq(0), index_seq(0), blend_seq(0),
        texcoord0_seq(0), texcoord1_seq(0), texcoord2_seq(0), texcoord3_seq(0),
        vertex_num(0), index_num(0), subset_num(0), bone_index_num(0)
    {
        memset(subset_seq, 0, sizeof(drSubsetInfo) * DR_MAX_SUBSET_NUM);
        memset(bone_index_seq, 0, sizeof(BYTE) * DR_MAX_BONE_NUM);
        drRenderStateSetTemplate_Construct(&rs_set);
    }

    ~drMeshInfo()
    {
        DR_SAFE_DELETE_A(vertex_seq);
        DR_SAFE_DELETE_A(normal_seq);
        DR_SAFE_DELETE_A(vercol_seq);
        DR_SAFE_DELETE_A(texcoord0_seq);
        DR_SAFE_DELETE_A(texcoord1_seq);
        DR_SAFE_DELETE_A(texcoord2_seq);
        DR_SAFE_DELETE_A(texcoord3_seq);
        DR_SAFE_DELETE_A(index_seq);
        DR_SAFE_DELETE_A(blend_seq);        
    }

    DR_RESULT Load(FILE* fp);
    DR_RESULT Save(FILE* fp) const;
    DWORD GetDataSize() const;

};

typedef drMeshInfo::drMeshInfoHeader drMeshInfoHeader;
*/

DR_RESULT drMeshInfo_Copy(drMeshInfo* dst, const drMeshInfo* src);
DR_RESULT drMeshInfo_Load(drMeshInfo* info, FILE* fp, DWORD version);
DR_RESULT drMeshInfo_Save(drMeshInfo* info, FILE* fp);
DWORD drMeshInfo_GetDataSize(drMeshInfo* info);

struct drGeomObjInfo : public drIGeomObjInfo
{
DR_STD_DECLARATION()

    struct drGeomObjInfoHeader
    {
        DWORD id;
        DWORD parent_id;
        DWORD type;
        drMatrix44 mat_local;
        drRenderCtrlCreateInfo rcci;
        drStateCtrl state_ctrl;

        DWORD mtl_size;
        DWORD mesh_size;
        DWORD helper_size;
        DWORD anim_size;
    };
    
    struct
    {
        DWORD id;
        DWORD parent_id;
        DWORD type;
        drMatrix44 mat_local;
        drRenderCtrlCreateInfo rcci;
        drStateCtrl state_ctrl;

        DWORD mtl_size;
        DWORD mesh_size;
        DWORD helper_size;
        DWORD anim_size;
    };

    DWORD mtl_num;
    drMtlTexInfo* mtl_seq;//[DR_MAX_SUBSET_NUM];

    drMeshInfo mesh;

    // helper data
    drHelperInfo helper_data;

    // animation data
    drAnimDataInfo anim_data;


    drGeomObjInfo()
        : id(DR_INVALID_INDEX), mtl_num(0), type(GEOMOBJ_TYPE_GENERIC),
        mtl_size(0), mesh_size(0), helper_size(0), anim_size(0),
        mtl_seq(0)
    {   
        drRenderCtrlCreateInfo_Construct(&rcci);
    }
    virtual ~drGeomObjInfo()
    {
        DR_IF_DELETE_A(mtl_seq);
    }

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp);
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file);
    DWORD GetDataSize() const;

    virtual drMeshInfo* GetMeshInfo() { return &mesh; }
    drMtlTexInfo* GetMtlTexInfo() { return mtl_seq; }    
};

typedef drGeomObjInfo::drGeomObjInfoHeader drGeomObjInfoHeader;

struct drModelObjInfo : public drIModelObjInfo
{
DR_STD_DECLARATION()

    struct drModelObjInfoHeader
    {
        DWORD type; // helper or geometry;
        DWORD addr;
        DWORD size;
    };

    DWORD geom_obj_num;
    drGeomObjInfo* geom_obj_seq[DR_MAX_MODEL_GEOM_OBJ_NUM];

    // helper data
    drHelperInfo helper_data;

public:
    drModelObjInfo()
        : geom_obj_num(0)
    {
        memset(geom_obj_seq, 0, sizeof(geom_obj_seq));
    }
    virtual ~drModelObjInfo()
    {
        for(DWORD i = 0; i < DR_MAX_MODEL_GEOM_OBJ_NUM; i++)
        {
            DR_SAFE_DELETE(geom_obj_seq[i]);
        }
    }

    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file);

    DR_RESULT SortGeomObjInfoWithID();

    DWORD GetDataSize();

    static DR_RESULT GetHeader(drModelObjInfoHeader* header_seq, DWORD* header_num, const char* file);
};

typedef drModelObjInfo::drModelObjInfoHeader drModelObjInfoHeader;

class drHelperDummyObjInfo : public drIHelperDummyObjInfo
{
    DR_STD_DECLARATION()
private:
    DWORD _id;
    drMatrix44 _mat;
    drIAnimDataMatrix* _anim_data;

public:
    drHelperDummyObjInfo();
    virtual ~drHelperDummyObjInfo();

    void SetID(DWORD id) { _id = id; }
    void SetMatrix(const drMatrix44* mat) { _mat = *mat; }
    void SetAnimDataMatrix(drIAnimDataMatrix* anim_data) { _anim_data = anim_data; }

    DWORD GetID() const { return _id; }
    drMatrix44* GetMatrix() { return &_mat; }
    drIAnimDataMatrix* GetAnimDataMatrix() { return _anim_data; }

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp);

};
///
struct drModelNodeHeadInfo
{
    DWORD handle;
    DWORD type;
    DWORD id;
    char descriptor[64];
    DWORD parent_handle;
    DWORD link_parent_id;
    DWORD link_id;
};

class drModelNodeInfo
{
public:
    // base
    union
    {
        drModelNodeHeadInfo _head;

        struct
        {
            DWORD _handle;
            DWORD _type;
            DWORD _id;
            char _descriptor[64];
            DWORD _parent_handle;
            DWORD _link_parent_id;
            DWORD _link_id;

        };
    };

    void* _data;
    void* _param;

public:
    drModelNodeInfo()
        :_handle(DR_INVALID_INDEX), _type(MODELNODE_INVALID), _id(DR_INVALID_INDEX),
        _parent_handle(DR_INVALID_INDEX),
        _link_parent_id(DR_INVALID_INDEX), _link_id(DR_INVALID_INDEX), 
        _data(0), _param(0)
    {
        _descriptor[0] = '\0';
    }
    virtual ~drModelNodeInfo();

    DR_RESULT Load(FILE* fp, DWORD version);
    DR_RESULT Save(FILE* fp);
};

struct drModelHeadInfo
{
    DWORD mask;
    DWORD version;
    char decriptor[64];
};


const DWORD MODELINFO_VERSION_0001 = 0x0001;
const DWORD MODELINFO_VERSION_0002 = 0x0002;
const DWORD MODELINFO_VERSION = EXP_OBJ_VERSION;//MODELINFO_VERSION_0002;

class drModelInfo
{
public:
    drModelHeadInfo _head;
    drITreeNode* _obj_tree;

public:
    drModelInfo()
        : _obj_tree(0)
    {
        memset(&_head, 0, sizeof(_head));
    }

    virtual ~drModelInfo();

    DR_RESULT Destroy();
    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file);
    DR_RESULT SortChildWithID();
};

// =============================================


DWORD drGetMtlTexInfoSize(const drMtlTexInfo* info_seq, DWORD num);
DWORD drGetAnimKeySetPRSSize(const drAnimKeySetPRS* info);

DR_RESULT drCreateHelperMeshInfo(drHelperMeshInfo* info, const drMeshInfo* mi);

DR_RESULT drCopyAnimKeySetPRS(drAnimKeySetPRS* dst, const drAnimKeySetPRS* src);

DR_END
