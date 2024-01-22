//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drMath.h"
#include "drErrorCode.h"

struct drColorValue4b
{
	union 
	{
		struct 
		{
			BYTE b;
			BYTE g;
			BYTE r;
			BYTE a;
		};

		DWORD color;
	};
};

DR_BEGIN

#define DR_MAX_SUBSET_NUM                   16
#define DR_MAX_BLENDWEIGHT_NUM              4
#define DR_MAX_BONE_NUM                     25
#define DR_MAX_BONEDUMMY_NUM                64
#define DR_MAX_MODEL_GEOM_OBJ_NUM           32
#define DR_MAX_MODEL_OBJ_NUM                DR_MAX_MODEL_GEOM_OBJ_NUM + 1 // geometry_num + helper
#define DR_MAX_GEOM_DUMMY_NUM               8
#define DR_MAX_OBJDUMMY_NUM                 8
#define DR_MAX_HELPER_MESH_NUM              8
#define DR_MAX_HELPER_BOX_NUM               8
#define DR_MAX_LINK_ITEM_NUM                16

#define DR_MAX_RENDERSTATE_NUM          210 // dx9
#define DR_MAX_TEXTURESTAGE_NUM         4   // max 8
#define DR_MAX_SAMPLESTAGE_NUM          4 
#define DR_MAX_TEXTURESTAGESTATE_NUM    33
#define DR_MAX_SAMPLESTATE_NUM          14

#define DR_INVALID_RS_VALUE             D3DRS_FORCE_DWORD
#define DR_INVALID_TSS_VALUE            D3DTSS_FORCE_DWORD
#define DR_INVALID_SS_VALUE             D3DSALE_FORCE_DWORD

#define DR_TEX_TSS_NUM                  8
#define DR_TEX_RS_NUM                   2
#define DR_MTL_RS_NUM                   8
#define DR_MESH_RS_NUM                  8
#define DR_TEX_DTSS_NUM                 4
#define DR_TEX_DRS_NUM                  4
#define DR_MESH_DRS_NUM                 4
#define DR_MTL_RSA_NUM                  4
#define DR_MAX_STREAM_NUM               8
#define DR_MAX_LIGHT_NUM                8
#define DR_MAX_SUBSKIN_NUM              10
#define DR_MAX_MTL_TEX_NUM              4


#define DR_MAX_BOUNDING_OBJ_NUM         4
#define DR_MAX_BOUNDING_BOX_NUM         8
#define DR_MAX_BOUNDING_SPHERE_NUM      8


#define DR_MAX_ITEM_LINK_NUM            8

#define DR_RENDER_CTRL_PROC_NUM         512

// 每个Primitive最多可以有DR_MAX_OBJ_DUMMY_NUM个Dummy，其中用于得到逆矩阵的Dummy个数为
// DR_MAX_OBJ_DUMMY_INV_NUM个，所以这里规定在max中制作dummy的时候dummy的id具有范围限制
// 具体数值如下：dummy_0 - dummy_3用来作为DR_MAX_OBJ_DUMMY_INV_NUM
//               dummy_4 - dummy_7用来作为特效或者其他不需要Inverse Matrix的链接id
#define DR_MAX_OBJ_DUMMY_NUM            16
#define DR_MAX_OBJ_DUMMY_INV_NUM        4

// Pose Ctrl Info
#define MAX_KEY_FRAME_NUM           8

enum
{
    HELPER_TYPE_DUMMY =                 0x0001,
    HELPER_TYPE_BOX =                   0x0002,
    HELPER_TYPE_MESH =                  0x0004,
    HELPER_TYPE_BOUNDINGBOX =           0x0010,
    HELPER_TYPE_BOUNDINGSPHERE =        0x0020,
    HELPER_TYPE_INVALID =               0x0000
};

enum
{
    GEOMOBJ_TYPE_GENERIC =              0,
    GEOMOBJ_TYPE_CHECK_BB =             1, //无方向判断
    GEOMOBJ_TYPE_CHECK_BB2 =            2, //有方向判断，这里定义有效方向为( 0, 1, 0 )
};

enum
{
    TSS_BEGIN =         0,
    TSS_END =           1,
    RS_BEGIN =          0,
    RS_END =            1,
};

enum 
{
    ANIM_CTRL_TYPE_MATRIX =             0,
    ANIM_CTRL_TYPE_BONE =               1,
    ANIM_CTRL_TYPE_TEXCOORD =           2,
    ANIM_CTRL_TYPE_TEXIMG =             3,
    ANIM_CTRL_TYPE_MTLOPACITY =         4,

    ANIM_CTRL_TYPE_NUM,     

    ANIM_CTRL_TYPE_MAT =                ANIM_CTRL_TYPE_MATRIX,
    ANIM_CTRL_TYPE_TEXUV =              ANIM_CTRL_TYPE_TEXCOORD,

    ANIM_CTRL_TYPE_INVALID =        0xffffffff
};

// resource file type enumulation
// *.lmo, *.lgo, *.lab, *.lam, *.lat
enum drResourceFileType
{
    RES_FILE_TYPE_GENERIC =         0,
    RES_FILE_TYPE_MODEL =           1,
    RES_FILE_TYPE_GEOMETRY =        2,
    RES_FILE_TYPE_INVALID =         0xffffffff
};

struct drRenderCtrlCreateInfo
{
    DWORD ctrl_id;
    DWORD decl_id;
    DWORD vs_id;
    DWORD ps_id;
};
inline void drRenderCtrlCreateInfo_Construct( drRenderCtrlCreateInfo* info )
{
    info->ctrl_id = DR_INVALID_INDEX;
    info->decl_id = DR_INVALID_INDEX;
    info->vs_id = DR_INVALID_INDEX;
    info->ps_id = DR_INVALID_INDEX;
}

class drIRenderCtrlVS;
typedef drIRenderCtrlVS* ( *drRenderCtrlVSCreateProc )();

enum drPathInfoType
{
    PATH_TYPE_DEFAULT =             0x0000,
    PATH_TYPE_WORKINGDIRECTORY ,
    PATH_TYPE_DATA ,

    PATH_TYPE_SCRIPT ,
    PATH_TYPE_SOUND ,
    PATH_TYPE_SHADER ,

    PATH_TYPE_ANIMATION ,

    PATH_TYPE_MODEL ,
    PATH_TYPE_MODEL_CHARACTER ,
    PATH_TYPE_MODEL_SCENE ,
    PATH_TYPE_MODEL_ITEM ,

    PATH_TYPE_TEXTURE ,
    PATH_TYPE_TEXTURE_CHARACTER ,
    PATH_TYPE_TEXTURE_SCENE ,
    PATH_TYPE_TEXTURE_ITEM ,

    PATH_TYPE_NUM ,
};

enum drColorKeyTypeEnum
{
    COLORKEY_TYPE_NONE =        0,
    COLORKEY_TYPE_COLOR =       1,
    COLORKEY_TYPE_PIXEL =       2,
};


#define DR_COLOR_R( c ) (BYTE)( (c) & 0xff )
#define DR_COLOR_G( c ) (BYTE)( ((c) >> 8) & 0xff )
#define DR_COLOR_B( c ) (BYTE)( ((c) >> 16) & 0xff )
#define DR_COLOR_A( c ) (BYTE)( ((c) >> 24) & 0xff )

enum drPlayPoseEnum 
{
    PLAY_ONCE = 1, 
    PLAY_LOOP = 2,
    PLAY_FRAME = 3,
    PLAY_ONCE_SMOOTH = 4,
    PLAY_LOOP_SMOOTH = 5,
    PLAY_PAUSE = 6,
    PLAY_CONTINUE = 7,
    PLAY_INVALID = 0,
};

enum
{
    KEYFRAME_TYPE_BEGIN =   0,
    KEYFRAME_TYPE_END =     1,
    KEYFRAME_TYPE_KEY =     2,
    KEYFRAME_TYPE_INVALID = 0xffffffff,
};

enum
{
    OBJ_TYPE_MODEL =        0,
    OBJ_TYPE_CHARACTER =    1,
    OBJ_TYPE_ITEM =         2,
    OBJ_TYPE_INVALID =      0xffffffff,
};

struct drPickInfo
{
    DWORD obj_id;
    DWORD face_id;
    float dis;
    drVector3 pos;
    DWORD data;
};

struct drPoseInfo
{
	DWORD charType;
    DWORD start;
    DWORD end;
    DWORD key_frame_seq[ MAX_KEY_FRAME_NUM ];
    DWORD key_frame_num;    
};


typedef void ( *drPoseKeyFrameProc)( DWORD type, DWORD pose_id, DWORD key_id, DWORD key_frame, void* param );

enum drPlayPoseInfoMask
{
    PPI_MASK_POSE =                 0x0001,
    PPI_MASK_TYPE =                 0x0002,
    PPI_MASK_VELOCITY =             0x0004,
    PPI_MASK_FRAME =                0x0008,
    PPI_MASK_PROC =                 0x0010,
    PPI_MASK_DATA =                 0x0020,
    PPI_MASK_BLENDINFO =            0x0100,
    PPI_MASK_BLENDINFO_SRCFRAMENUM =0x0200,
    PPI_MASK_BLENDINFO_DSTFRAMENUM =0x0400,

    PPI_MASK_INVALID =              0x0000,
    PPI_MASK_DEFAULT =              (PPI_MASK_POSE | PPI_MASK_TYPE | PPI_MASK_VELOCITY | PPI_MASK_FRAME | PPI_MASK_DATA),
    PPI_MASK_ABSOLUTE =             (PPI_MASK_DEFAULT | PPI_MASK_PROC),
};

//enum
//{
//    POSEBLEND_STATE_INVALID =       0x0000,
//    POSEBLEND_STATE_BLEND =         0x0001,
//    POSEBLEND_STATE_SRCFRAMENUM =   0x0002,
//    POSEBLEND_STATE_DSTFRAMENUM =   0x0004,
//    POSEBLEND_STATE_PARTIALBONE =   0x0008,
//};

struct drPoseBlendInfo
{
    DWORD op_state;
    float op_frame_length;
    float weight;
    float factor;
    float src_frame_num;
    float dst_frame_num;
    BYTE* bone_data;
    // 
    DWORD blend_pose;
    DWORD blend_type;
    float blend_frame;
    float blend_ret_frame;
};

struct drPlayPoseInfo
{
    DWORD bit_mask;

    DWORD pose;
    DWORD type;
    DWORD data;
    float velocity;
    float frame;
    float ret_frame;
    drPoseKeyFrameProc proc;
    void* proc_param;
    drPoseBlendInfo blend_info;
};

//struct drPoseKeyFrameInfo
//{
//    DWORD type;
//    DWORD pose_id;
//    DWORD key_id;
//    DWORD key_frame;
//    DWORD param;
//};


inline void drPlayPoseInfo_Construct( drPlayPoseInfo* info )
{    
    memset( info, 0, sizeof(drPlayPoseInfo) );
    info->bit_mask = PPI_MASK_INVALID;
}

struct drColorValue4f
{
	float r;
	float g;
	float b;
	float a;
};

inline void drColorValue4f_Construct( drColorValue4f* obj, float r, float g, float b, float a )
{
    obj->r = r;
    obj->g = g;
    obj->b = b;
    obj->a = a;
}

inline drColorValue4f drColorValue4f_Construct( float r, float g, float b, float a )
{
    drColorValue4f c;
    c.r = r;
    c.g = g;
    c.b = b;
    c.a = a;
    return c;
}

struct drMaterial
{
    drColorValue4f dif;
    drColorValue4f amb;
    drColorValue4f spe;
    drColorValue4f emi;
    float power;
};

inline void drMaterial_Construct( drMaterial* mtl )
{
    memset( mtl, 0, sizeof( drMaterial ) );
    mtl->amb.a = mtl->amb.r = mtl->amb.g = mtl->amb.b = 1.0f;
    mtl->dif.a = mtl->dif.r = mtl->dif.g = mtl->dif.b = 1.0f;
}

struct drRenderStateValue
{
    DWORD state;
    DWORD value;
};

inline drRenderStateValue RS_VALUE( DWORD state, DWORD value )
{
    drRenderStateValue ret = { state, value };
    return ret;
}

class drIItem;
struct drItemLinkInfo
{
    drIItem* obj;
    DWORD id;
    DWORD link_item_id;
    DWORD link_parent_id;
};

struct drResFile
{
    char file_name[ DR_MAX_PATH ];
    drResourceFileType res_type;
    DWORD obj_id;

    drResFile()
        : obj_id( 0 ), res_type( RES_FILE_TYPE_INVALID )
    { file_name[ 0 ] = '\0'; }
};

struct drResFileMesh
{
    char file_name[ DR_MAX_PATH ];
    drResourceFileType res_type;
    DWORD obj_id;

    drResFileMesh()
        : obj_id( 0 ), res_type( RES_FILE_TYPE_INVALID )
    { file_name[ 0 ] = '\0'; }

    int Compare( const drResFileMesh* src )
    {
        return (obj_id == src->obj_id) 
            && (res_type == src->res_type) 
            && (_tcscmp( file_name, src->file_name ) == 0); 
    }
};

struct drResFileAnimData
{
    char file_name[ DR_MAX_PATH ];
    drResourceFileType res_type;
    DWORD obj_id;
    DWORD anim_type;

    drResFileAnimData()
        : obj_id( 0 ), res_type( RES_FILE_TYPE_INVALID ), anim_type( ANIM_CTRL_TYPE_INVALID )
    { file_name[ 0 ] = '\0'; }

    int Compare( const drResFileAnimData* src )
    {
        return ( obj_id == src->obj_id )
            && ( anim_type == src->anim_type )
            && ( res_type == src->res_type ) 
            && ( _tcscmp( file_name, src->file_name ) == 0 ); 
    }
};


enum drAnimCtrlAgentSetType
{
    ACA_GLOBAL_SET,
    ACA_SUBSET_SET,
};

typedef DR_RESULT (*drOutputLoseDeviceProc)();
typedef DR_RESULT (*drOutputResetDeviceProc)();

// -------------------
// for drAnimKeySetPRS2
struct drKeyFloat
{
    typedef float DATA_TYPE;

    DWORD key;
    DWORD slerp_type;
    DATA_TYPE data;
};
struct drKeyVector3
{
    DWORD key;
    DWORD slerp_type;
    drVector3 data;
};

struct drKeyQuaternion
{
    DWORD key;
    DWORD slerp_type;
    drQuaternion data;
};
struct drKeyMatrix43
{
    DWORD key;
    DWORD slerp_type;
    drMatrix43 data;
};

enum drAnimKeySetMask
{
    AKSM_KEY =          0x0001,
    AKSM_DATA =         0x0002,
    AKSM_SLERPTYPE =    0x0004,
};

enum drAnimKeySetSlerpType
{
    AKST_INVALID =      0,

    __akst_begin =      0,

    AKST_LINEAR,
    AKST_SIN1, // 0 - 90
    AKST_SIN2, // 90 - 180
    AKST_SIN3, // 180 - 270
    AKST_SIN4, // 270 - 360
    AKST_COS1, // 0 - 90
    AKST_COS2, // 90 - 180
    AKST_COS3, // 180 - 270
    AKST_COS4, // 270 - 360
    AKST_TAN1, // 0 - 45
    AKST_CTAN1,// 0 - 45

    __akst_end
};
// end

enum drStreamTypeEnum
{
    STREAM_STATIC =     0,
    STREAM_DYNAMIC =    1,
    STREAM_LOCKABLE =   2,
    STREAM_GENERIC =    3,
};

struct drWndInfo
{
    HWND hwnd;
    DWORD left;
    DWORD top;
    DWORD width;
    DWORD height;
    DWORD windowed_style;
};

struct drWatchDevVideoMemInfo
{
    int alloc_vb_size;
    int alloc_ib_size;
    int alloc_tex_size;
    int alloc_vb_cnt;
    int alloc_ib_cnt;
    int alloc_tex_cnt;
};

enum drModelEntityTypeEnum
{
    NODE_PRIMITIVE =                1,
    NODE_BONECTRL =                 2,
    NODE_DUMMY =                    3,
    NODE_HELPER =                   4,
    NODE_LIGHT =                    5,
    NODE_CAMERA =                   6,

    MODELNODE_INVALID =             DR_INVALID_INDEX,

};
enum drTreeNodeProcTypeEnum
{
    TREENODE_PROC_PREORDER,
    TREENODE_PROC_INORDER,
    TREENODE_PROC_POSTORDER,
	TREENODE_PROC_PREORDER_IGNORE,
};

enum drTreeNodeProcRetTypeEnum
{
    TREENODE_PROC_RET_CONTINUE =        0,
    TREENODE_PROC_RET_ABORT =           1,
    TREENODE_PROC_RET_IGNORECHILDREN =  2,
};

class drITreeNode;
typedef DWORD (*drTreeNodeEnumProc)(drITreeNode* node, void* param);

enum drModelObjectLoadType
{
    MODELOBJECT_LOAD_RESET,
    MODELOBJECT_LOAD_MERGE, // exclude dummy root
    MODELOBJECT_LOAD_MERGE2, // include merge dummy root
};

enum drModelNodeQueryMask
{
    MNQI_ID =           0x0001,
    MNQI_TYPE =         0x0002,
    MNQI_DATA =         0x0004,
    MNQI_DESCRIPTOR =   0x0008,
    MNQI_USERPROC =     0x0010,
};

struct drModelNodeQueryInfo
{
    DWORD mask;
    DWORD id;
    DWORD type;
    void* data;
    char descriptor[64];
    drTreeNodeEnumProc proc;
    void* proc_param;
    drITreeNode* node;
};

enum drSurfaceStreamType
{
    SURFACESTREAM_RENDERTARGET =    1,
    SURFACESTREAM_DEPTHSTENCIL =    2,
    SURFACESTREAM_INVALID =         DR_INVALID_INDEX,
};

struct drD3DCreateParam
{
    UINT adapter;
    D3DDEVTYPE dev_type;
    HWND  hwnd;
    DWORD behavior_flag;
    D3DPRESENT_PARAMETERS present_param;
};

struct drD3DCreateParamAdjustInfo
{
    D3DMULTISAMPLE_TYPE multi_sample_type;
};

enum drOptionByteFlag
{
    OPTION_FLAG_CREATEHELPERPRIMITIVE =     0,
    OPTION_FLAG_CULLPRIMITIVE_MODEL =       1,
    MAX_OPTION_BYTE_FLAG =                  64,
};

enum drRenderStateAtomType
{
    RENDERSTATE_TYPE_RS =           0,
    RENDERSTATE_TYPE_TSS =          1,
    RENDERSTATE_TYPE_SS =           2,
    RENDERSTATE_TYPE_INVALID =      DR_INVALID_INDEX,
};

typedef void (*drTimerProc) (DWORD time); // 1/1000.0f


typedef DR_RESULT (*drDirectoryBrowserProc)(const char* file_path, const WIN32_FIND_DATA* wfd, void* param);

enum drDirBrowserType
{
    DIR_BROWSE_FILE =           0x0001,
    DIR_BROWSE_DIRECTORY =      0x0002,

    DIR_BROWSE_INVALID =        0,
};

typedef unsigned int (__stdcall *drThreadProc)(void* param);

enum drThreadPoolType
{
    THREAD_POOL_LOADRES = 0,
	//THREAD_POOL_LOADPHY = 1,
    THREAD_POOL_SIZE,
};

enum drCriticalSectionType
{
    CRITICALSECTION_LOCK_SYSMEMTEX = 0,
};

struct drDwordByte4
{
    union
    {
        DWORD d;
        BYTE b[4];
    };
};

struct drVertexBufferInfo
{
    DWORD size;
    DWORD usage;
    DWORD fvf;
    DWORD stride;
    D3DPOOL pool;
};

struct drIndexBufferInfo
{
    DWORD size;
    DWORD usage;
    DWORD format;
    DWORD stride;
    D3DPOOL pool;
};

class drIPrimitive;
typedef DR_RESULT (*drTranspPrimitiveProc)(drIPrimitive* obj, void* param);


struct drSceneFrameInfo
{
    DWORD _update_count;
    DWORD _render_count;
    DWORD _tex_cpf;
};

enum
{
    OPT_RESMGR_LOADTEXTURE_MT =     1,
    OPT_RESMGR_LOADMESH_MT =        2,
    OPT_CREATE_ASSISTANTOBJECT =          3,
    OPT_RESMGR_TEXENCODE =          5,

    OPT_RESMGR_BYTESET_SIZE
};

enum
{
    TIMER_HIT_ADDITIVE =        1,
    TIMER_HIT_FILTER =          2,
};

enum
{
    ASSOBJ_MASK_SIZE =          0x0001,
    ASSOBJ_MASK_COLOR =         0x0002,
};

struct drAssObjInfo
{
    drVector3 size;
    DWORD color;
};

struct drStaticStreamMgrDebugInfo
{
    DWORD vbs_size;
    DWORD vbs_used_size;
    DWORD vbs_free_size;
    DWORD vbs_unused_size;
    DWORD vbs_locked_size;
    DWORD ibs_size;
    DWORD ibs_used_size;
    DWORD ibs_free_size;
    DWORD ibs_unused_size;
    DWORD ibs_locked_size;
};

#define DX_VER_MAJOR(id) (id << 16)
#define DX_VER_MINOR(id) (id << 8)
enum
{
    DX_VERSION_INVALID =        0,

    DX_VERSION_8_0 =            DX_VER_MAJOR(8),
    DX_VERSION_8_1 =            DX_VER_MAJOR(8) + DX_VER_MINOR(1),
    DX_VERSION_8_1_a =          DX_VER_MAJOR(8) + DX_VER_MINOR(1) + 1,
    DX_VERSION_8_1_b =          DX_VER_MAJOR(8) + DX_VER_MINOR(1) + 2,
    DX_VERSION_8_2 =            DX_VER_MAJOR(8) + DX_VER_MINOR(2),
    
    DX_VERSION_9_0 =            DX_VER_MAJOR(9),
    DX_VERSION_9_0_a =          DX_VER_MAJOR(9) + 1,
    DX_VERSION_9_0_b =          DX_VER_MAJOR(9) + 2,
    DX_VERSION_9_0_c =          DX_VER_MAJOR(9) + 3,

    DX_VERSION_UNKNOWN =        0x0007ffff,
    DX_VERSION_X_X =            0xffffffff,

};

struct drDxVerInfo
{
    DWORD version;
    DWORD revision;
};

struct drCullPriInfo
{
    DWORD total_cnt;
    DWORD culling_cnt;
};

enum drBackBufferFormatsItemMaxType
{
    BBFI_MULTISAMPLE =          0,
    BBFI_DEPTHSTENCIL,
    BBFI_RENDERTARGET,
    BBFI_TEXTURE,
    BBFI_CUBETEXTURE,
    BBFI_VOLUMETEXTURE,

    BBFI_MAX_MULTISAMPLE =      16,
    BBFI_MAX_DEPTHSTENCIL =     8,
    BBFI_MAX_RENDERTARGET =     8,
    BBFI_MAX_TEXTURE =          32,
    BBFI_MAX_CUBETEXTURE =      32,
    BBFI_MAX_VOLUMETEXTURE =    32,
};

struct drBackBufferFormatsItemInfo
{
    BOOL windowed;
    D3DFORMAT format;
    D3DFORMAT fmt_multisample[BBFI_MAX_MULTISAMPLE];
    D3DFORMAT fmt_depthstencil[BBFI_MAX_DEPTHSTENCIL];
    D3DFORMAT fmt_rendertarget[BBFI_MAX_RENDERTARGET];
    D3DFORMAT fmt_texture[BBFI_MAX_TEXTURE];
    D3DFORMAT fmt_cubetexture[BBFI_MAX_CUBETEXTURE];
    D3DFORMAT fmt_volumetexture[BBFI_MAX_VOLUMETEXTURE];
};

struct drBackBufferFormatsInfo
{
    drBackBufferFormatsItemInfo fmt_seq[4];
};

enum
{
    LOADINGRES_TYPE_RUNTIME =       1,
    LOADINGRES_TYPE_RUNTIME_MT =    2,

    LOADINGRES_MASK_RT0 =           0x0001,
    //
    LOADINGRES_MASK_RTMT0 =         0x0001,
    LOADINGRES_MASK_RTMT1 =         0x0002,
    LOADINGRES_MASK_LOADSM_FAILED = 0x0010,
    LOADINGRES_MASK_LOADVM_FAILED = 0x0020,

    LOADINGRES_MASK_RTMTREG_FAILED =0x0100,

};

enum
{
    RES_PASS_DEFAULT =              0,
    RES_PASS_SKIPTHISDRAW =         1,
    RES_PASS_ERROR =                -1,
};

enum drRenderCtrlVSTypesEnum
{
    RENDERCTRL_VS_FIXEDFUNCTION =           1,//RENDERCTRL_GENERIC =       0x0001,
    RENDERCTRL_VS_VERTEXBLEND =             2,//RENDERCTRL_VSBONE =        0x0002,
    RENDERCTRL_VS_VERTEXBLEND_DX9 =         3,

    // user defined render ctrl index based from 256 - 512
    RENDERCTRL_VS_USER =                    0x100,

    RENDERCTRL_VS_INVALID =       DR_INVALID_INDEX
};

#define DR_ARGB_A(v) (((v) >> 24) / 255.0f)
#define DR_ARGB_R(v) ((((v) & 0x00ff0000) >> 16) / 255.0f)
#define DR_ARGB_G(v) ((((v) & 0x0000ff00) >> 8) / 255.0f)
#define DR_ARGB_B(v) (((v) & 0x000000ff) / 255.0f)

#if(defined DR_USE_DX9)
struct drVertexShaderInfo9
{
    BYTE* data;
    DWORD size;
	IDirect3DVertexShaderX* handle;
};
typedef drVertexShaderInfo9 drVertexShaderInfo;

struct drVertDeclInfo9
{
    D3DVERTEXELEMENT9* data;
    IDirect3DVertexDeclarationX* handle;
};
typedef drVertDeclInfo9 drVertDeclInfo;

#endif


enum
{
    VS_FILE_OBJECT =        1,
    VS_FILE_ASM =           2,
    VS_FILE_HLSL =          3,
};

class drAnimCtrlTypeInfo
{
public:
    DWORD type;
    DWORD data[4];

    BOOL Check(const drAnimCtrlTypeInfo* info)
    {
        return (type == info->type 
            && data[0] == info->data[0] 
            && data[1] == info->data[1]);
    }
};
typedef drAnimCtrlTypeInfo drAnimCtrlObjTypeInfo;

typedef BOOL (*drHeapCompProc)(const void*& i, const void*& j);
typedef void (*drHeapFilterProc)(const void*& i, DWORD j);

enum drFileStreamOpenInfoType
{
    // adapter flag
    FS_ADAPTER_FILE =       0x0001,
    FS_ADAPTER_PACKET =     0x0002, // now invalid

    // access flag
    FS_ACCESS_READ =        ACCESS_READ,
    FS_ACCESS_WRITE =       ACCESS_WRITE,

    // create flag
    FS_CREATE_NEW =         CREATE_NEW,
    FS_CREATE_ALWAYS =      CREATE_ALWAYS,
    FS_OPEN_EXISTING =      OPEN_EXISTING,    
    FS_OPEN_ALWAYS =        OPEN_ALWAYS,
    FS_TRUNCATE_EXISTING =  TRUNCATE_EXISTING,

    // attributes flag
    FS_SEQUENTIAL_SCAN =    FILE_FLAG_SEQUENTIAL_SCAN,

    // seek
    FS_FILE_BEGIN =         FILE_BEGIN,
    FS_FILE_CURRENT =       FILE_CURRENT,
    FS_FILE_END =           FILE_END,

};

struct drFileStreamOpenInfo
{
    DWORD adapter_type;
    DWORD access_flag;
    DWORD create_flag;
    DWORD attributes_flag;
};


DR_END
