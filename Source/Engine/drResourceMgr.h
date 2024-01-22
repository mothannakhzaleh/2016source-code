#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drObjectPool.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drDirectX.h"
#include "drExpObj.h"
#include "drGraphicsUtil.h"
#include "drInterfaceExt.h"
#include "drShaderMgr.h"
#include "drPreDefinition.h"
#include "drMisc.h"
#include "drPathInfo.h"
#include "drSyncObj.h"

#include <map>
#include <string>


DR_BEGIN

enum drResStateEnum
{
    RES_STATE_INVALID =         0x000,
    RES_STATE_INIT =            0x0001,
    RES_STATE_SYSTEMMEMORY =    0x0002,
    RES_STATE_VIDEOMEMORY =     0x0004,
    RES_STATE_LOADTEST =        0x0010,
    RES_STATE_LOADTEST_0 =      0x0020,
    RES_STATE_LOADING_VM =         0x1000,
};

#if 0
struct drTexLogInfo
{
    char file[DR_MAX_PATH];
    DWORD width;
    DWORD height;
    D3DFORMAT fmt;
    DWORD devmem_size;

    void Save(FILE* fp)
    {
        char buf[512];
        _snprintf_s(buf, 512,_TRUNCATE,"file:%s\nwidth: %d\theight: %d\tformat: %d\tmem_size:%d\n\n",
            file, width, height, fmt, devmem_size);

        fwrite(buf, strlen(buf), 1, fp);
    }
};

class drTexLogMgr
{
    typedef list<drTexLogInfo*> drListTexLog;
private:
    drListTexLog _list_texlog;

public:
    drTexLogMgr()
    {};
    ~drTexLogMgr()
    {
        drListTexLog::iterator it = _list_texlog.begin();
        for(; it != _list_texlog.end(); ++it)
        {
            DR_DELETE((*it));
        }
    }

    void Add(const char* file, DWORD width, DWORD height, D3DFORMAT fmt, DWORD devmem_size)
    {
        drTexLogInfo* info = DR_NEW(drTexLogInfo);
        _tcsncpy_s(info->file, file);
        info->width = width;
        info->height = height;
        info->fmt = fmt;
        info->devmem_size = devmem_size;

        _list_texlog.push_back(info);
    }

    void Save(const char* file)
    {
        drListTexLog::iterator it;
        FILE* fp;
		foepn_s( &fp, file, "wt");
        if(fp == 0)
            goto __ret;

        it = _list_texlog.begin();
        for(; it != _list_texlog.end(); ++it)
        {
            (*it)->Save(fp);
        }

        DWORD total_size = 0;
        DWORD scene_size = 0;
        DWORD terrain_size = 0;
        DWORD ui_size = 0;
        DWORD mini_map = 0;

        it = _list_texlog.begin();
        for(; it != _list_texlog.end(); ++it)
        {
            total_size += (*it)->devmem_size;

            if(_tcsstr((*it)->file, "scene"))
            {
                scene_size += (*it)->devmem_size;
            }
            else if(_tcsstr((*it)->file, "terrain"))
            {
                terrain_size += (*it)->devmem_size;
            }
            else if(_tcsstr((*it)->file, "ui"))
            {
                ui_size += (*it)->devmem_size;
            }
            else if(_tcsstr((*it)->file, "minimap"))
            {
                mini_map += (*it)->devmem_size;
            }
        }

        char buf[256];
        _snprintf_s(buf, 256,_TRUNCATE,"total: %d, scene: %d, terrain: %d, ui: %d, map: %d\n",
            total_size, scene_size, terrain_size, ui_size, mini_map);
        fwrite(buf, strlen(buf), 1, fp);

__ret:
        if(fp)
        {
            fclose(fp);
        }
    }
};
#else

// struct drTexLogFilterInfo
// {
//     char filter_str[DR_MAX_PATH];
//     DWORD size;
//     DWORD num;
// 
//     BOOL Filter(DWORD op_type, const char* file, DWORD file_size)
//     {
//         if(_tcsstr(file, filter_str) == 0)
//             return 0;
// 
//         if(op_type == 1)
//         {
//             size += file_size;
//             num += 1;
//         }
//         else
//         {
//             size -= file_size;
//             num -= 1;
//         }
// 
//         return 1;
//     }
// };
// class drTexLogMgr
// {
//     typedef vector<drTexLogFilterInfo> drTexLogFilterInfoSeq;
// private:
//     FILE* _fp;
//     DWORD _total_size;
//     DWORD _total_num;
//     drTexLogFilterInfoSeq _v_filter_entity;
// 
// public:
//     drTexLogMgr()
//     {
//         _fp = 0;
//         _total_size = 0;
//         _total_num = 0;
//         _v_filter_entity.reserve(20);
//     };
//     ~drTexLogMgr()
//     {
//         if(_fp)
//         {
//             char buf[256];
//             drTexLogFilterInfoSeq::iterator it = _v_filter_entity.begin();
//             for(; it != _v_filter_entity.end(); ++it)
//             {
//                 _snprintf_s(buf, 256 ,_TRUNCATE,"type: %s, num: %d, size: %d\n", (*it).filter_str, (*it).num, (*it).size);
//                 fwrite(buf, strlen(buf), 1, _fp);
//             }
// 
//             _snprintf_s(buf,  256 ,_TRUNCATE,"Total num: %d, Total size: %d\n", _total_num, _total_size);
//             fwrite(buf, strlen(buf), 1, _fp);
// 
// 
//             fclose(_fp);
//         }
//     }
// 
//     DR_RESULT OpenLogFile(const char* file)
//     {
// 		fopen_s( &_fp, file, "wt");
//         return _fp ? DR_RET_OK : DR_RET_FAILED;
//     }
//     DR_RESULT AddTexType(const char* name)
//     {
//         drTexLogFilterInfo info;
//         info.num = 0;
//         info.size = 0;
//         _tcsncpy_s(info.filter_str, name, _TRUNCATE );
// 
//         _v_filter_entity.push_back(info);
//         return DR_RET_OK;
//     }
// 
//     DR_RESULT Log(DWORD op_type, const char* file, DWORD width, DWORD height, D3DFORMAT fmt, DWORD devmem_size)
//     {
//         if(_fp == 0)
//             return DR_RET_FAILED;
// 
//         char op[2][64] =
//         {
//             "Load",
//             "Release"
//         };
//         char* p;
// 
//         if(op_type == 1)
//         {
//             _total_size += devmem_size;
//             _total_num += 1;
//             p = op[0];
//         }
//         else
//         {
//             _total_size -= devmem_size;
//             _total_num -= 1;
//             p = op[1];
//         }
// 
//         char buf[512];
//         _snprintf_s(buf, 512, _TRUNCATE,"%s file:%s\nwidth: %d\theight: %d\tformat: %d\tmem_size:%d\n",
//             p, file, width, height, fmt, devmem_size);
// 
//         fwrite(buf, strlen(buf), 1, _fp);
// 
// 
//         drTexLogFilterInfoSeq::iterator it = _v_filter_entity.begin();
//         for(; it != _v_filter_entity.end(); ++it)
//         {
//             if((*it).Filter(op_type, file, devmem_size))
//             {
//                 //break;
//             }
//             _snprintf_s(buf, 512, _TRUNCATE, "[%s]: num: %d, size: %d\t[%d]\n", (*it).filter_str, (*it).num, (*it).size, _total_size);
//             fwrite(buf, strlen(buf), 1, _fp);
//         }
// 
//         return DR_RET_OK;
//     }
// };

#endif


class drTex : public drITex
{
DR_STD_DECLARATION()

public:
    drIResourceMgr* _res_mgr;
    int _ref;

    DWORD _reg_id;
    DWORD _state; //...
    DWORD _tex_type; // file texture or user-defined texture

    DWORD _level;
    DWORD _usage;
    DWORD _format;
    D3DPOOL _pool;
    void* _data;
    DWORD _data_size;

    DWORD _stage;
    DWORD _byte_alignment_flag;
    DWORD _colorkey_type;
    drColorValue4b _colorkey;
    char _file_name [ DR_MAX_PATH ];

    drTexDataInfo _data_info;

    IDirect3DTextureX* _tex;

    //drTextureStageStateSetTex2 _tss_set;
    //drRenderStateSetTex2 _rs_set;
    drRenderStateAtomSet _rsa_0;

    DWORD _load_type;
    DWORD _load_mask;
    DWORD _load_flag;
    DWORD _mt_flag;

public:
    drTex(drIResourceMgr* res_mgr);
    ~drTex();

    int AddRef(int i) { return _ref += i; }
    int GetRef() { return _ref; }

    DR_RESULT LoadTexInfo( const drTexInfo* info, const char* tex_path );
    DR_RESULT LoadSystemMemory();
    DR_RESULT LoadVideoMemory();
    DR_RESULT LoadVideoMemoryMT();
    DR_RESULT LoadVideoMemoryEx();
    DR_RESULT LoadVideoMemoryDirect();
    DR_RESULT UnloadSystemMemory();
    DR_RESULT UnloadVideoMemory();
    DR_RESULT Unload();

    void SetRegisterID( DWORD id ) { _reg_id = id; }
    DWORD GetRegisterID() const { return _reg_id; }

    char* GetFileName() { return _file_name; }
    DWORD GetStage() const { return _stage; }
    DWORD GetState() const { return _state; }
    IDirect3DTextureX* GetTex() { return _tex; }
    drTexDataInfo* GetDataInfo() { return &_data_info; }
    drColorValue4b GetColorKey() const { return _colorkey; }
    void GetTexInfo(drTexInfo* info);

    void SetFileName( const char* file ) { _tcsncpy_s( _file_name, file, _TRUNCATE  ); }
    void SetState( DWORD state ) { _state = state; }
    void SetStage( DWORD stage ) { _stage = stage; }
    void SetTexFormat( DWORD fmt ) { _format = fmt; }
    void SetColorKeyType( DWORD type, const drColorValue4b* c ) { _colorkey_type = type; if( c ) { _colorkey = *c; } }
    DWORD SetLOD(DWORD level);
    void SetLoadFlag(DWORD flag) { _load_flag = flag; }

    void SetMTFlag(DWORD flag) { _mt_flag = flag; }
    DWORD GetMTFlag() { return _mt_flag; }
    BOOL IsLoadingOK() const;

    DR_RESULT Register();
    DR_RESULT Unregister();

    DR_RESULT BeginPass();
    DR_RESULT EndPass();
    DR_RESULT BeginSet();
    DR_RESULT EndSet();
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    void SetLoadResType(DWORD type) { _load_type = type; }
    void SetLoadResMask(DWORD add_mask, DWORD remove_mask);
    DWORD GetLoadResMask() { return _load_mask; }
    DWORD GetLoadResType() { return _load_type; }    

};

// 有关drMesh和drMeshInfo之间的关系
// 1。drMeshInfo作为纯粹的C类型结构体，再关联一组construct和destruct等的辅助函数。
//    drMesh聚合该结构体
// 2。drMeshInfo是一个class，同时拥有drIMeshInfo的接口方式
//    drMesh继承（或引用接口指针）该类，在效率上不能接受
// 
class drMesh : public drIMesh
{

DR_STD_DECLARATION()

private:
public:
    drIResourceMgr* _res_mgr;

    DWORD _reg_id;
    DWORD _state; //...

    DWORD _stream_type;
    DWORD _colorkey;
    DR_HANDLE _vb_id;
    DR_HANDLE _ib_id;
    drIVertexBuffer* _svb;
    drIIndexBuffer* _sib;

    drResFileMesh _res_file;

    drMeshDataInfo _data_info;
    drMeshInfo _mesh_info;
    drMeshInfo* _mesh_info_ptr;

    drRenderStateAtomSet _rsa_0;

    DWORD _mt_flag;

public:
    drMesh( drIResourceMgr* res_mgr );
    ~drMesh();

    DR_RESULT LoadSystemMemory( const drMeshInfo* info );
    DR_RESULT LoadSystemMemoryMT( const drMeshInfo* info );
    DR_RESULT LoadSystemMemory();
    DR_RESULT LoadVideoMemory();
    DR_RESULT LoadVideoMemoryMT();
    DR_RESULT LoadVideoMemoryEx();
    DR_RESULT UnloadSystemMemory();
    DR_RESULT UnloadVideoMemory();
    DR_RESULT Unload();
   
    DR_RESULT ExtractMesh(drMeshInfo* info);

    void SetStreamType(DWORD type) { _stream_type = type; }
    DWORD GetStreamType() const { return _stream_type; }

    DWORD GetRegisterID() const { return _reg_id; }
    drResFileMesh* GetResFileMesh() { return &_res_file; }
    DWORD GetState() const { return _state; }
    drMeshInfo* GetMeshInfo() { return &_mesh_info; }

    DR_HANDLE GetVBHandle() const { return _vb_id; }
    DR_HANDLE GetIBHandle() const { return _ib_id; }

    void SetRegisterID( DWORD id ) { _reg_id = id; }
    void SetState( DWORD state ) { _state = state; }
    void SetColorkey(DWORD key) { _colorkey = key; }
    DR_RESULT SetResFile( const drResFileMesh* info );

    DR_RESULT Register();
    DR_RESULT Unregister();

	DR_RESULT AddStateToSet(DWORD state, DWORD value); //添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
    DR_RESULT BeginSet();
    DR_RESULT EndSet();
    DR_RESULT DrawSubset( DWORD subset );
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    drILockableStreamVB* GetLockableStreamVB();
    drILockableStreamIB* GetLockableStreamIB();

    BOOL IsLoadingOK() const;
    void SetMTFlag(DWORD flag) { _mt_flag = flag; }
    DWORD GetMTFlag() { return _mt_flag; }

};

class drMtlTexAgent : public drIMtlTexAgent
{
DR_STD_DECLARATION()

    enum { RSA_SET_SIZE =       8 };
private:
public:

    drIResourceMgr* _res_mgr;

    float _opacity;
    DWORD _transp_type;
    drMaterial _mtl;
    BOOL _render_flag;

    drRenderStateAtomSet _rsa_0;


#ifdef MTLTEXAGENT_OPACITY_RSA_FLAG
    drRenderStateAtomSet _rsa_opacity;
    //drRenderStateAtom _opacity_rsa_seq[5];
#endif

    drITex* _tex_seq[ DR_MAX_MTL_TEX_NUM ]; // multi-texture blending    
    drMatrix44* _uvmat[DR_MAX_MTL_TEX_NUM];
    drITex* _tt_tex[DR_MAX_MTL_TEX_NUM];

    DWORD _opacity_reserve_rs[2]; // D3DRS_SRCBLEND, D3DRS_DESTBLEND

public:
    drMtlTexAgent( drIResourceMgr* mgr );
    ~drMtlTexAgent();

    void SetOpacity(float opacity) { _opacity = opacity; }
    void SetTranspType(DWORD type) { _transp_type = type; }
    void SetMaterial( const drMaterial* mtl ) { _mtl = *mtl; }
    void SetRenderFlag(BOOL flag) { _render_flag = flag; }
    drIRenderStateAtomSet* GetMtlRenderStateSet() { return (drIRenderStateAtomSet*)&_rsa_0; }


    float GetOpacity() const { return _opacity; }
    DWORD GetTransparencyType() const { return _transp_type; }
    drMaterial* GetMaterial() { return &_mtl; }
    drITex* GetTex( DWORD stage ) { return _tex_seq[ stage ]; }
    BOOL GetRenderFlag() { return _render_flag; }


    DR_RESULT BeginPass();
    DR_RESULT EndPass();
    DR_RESULT BeginSet();
    DR_RESULT EndSet();

    DR_RESULT SetTex(DWORD stage, drITex* obj, drITex** ret_obj);
    DR_RESULT LoadMtlTex( drMtlTexInfo* info, const char* tex_path );
    DR_RESULT LoadTextureStage(const drTexInfo* info, const char* tex_path);

    DR_RESULT ExtractMtlTex(drMtlTexInfo* info);

    DR_RESULT DestroyTextureStage( DWORD stage );
    DR_RESULT Destroy();
    DR_RESULT Clone( drIMtlTexAgent** ret_obj );
    DR_RESULT SetTextureTransformMatrix(DWORD stage, const drMatrix44* mat);
    DR_RESULT SetTextureTransformImage(DWORD stage, drITex* tex);

    DR_RESULT SetTextureLOD(DWORD level);
    BOOL IsTextureLoadingOK() const;

};


class drMeshAgent : public drIMeshAgent
{
DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIMesh* _mesh_obj;
    drRenderStateSetMesh2 _rs_set;
    DWORD _mt_flag;

public:
    drMeshAgent( drIResourceMgr* res_mgr );
    ~drMeshAgent();

    void SetRenderState( DWORD begin_end, DWORD state, DWORD value ) 
    { drSetRenderStateSet( &_rs_set, begin_end, state, value ); }
    void SetRenderState( drRenderStateSetMtl2* rs_set ) { _rs_set = *rs_set; }
    void SetMesh( drIMesh* mesh ) { _mesh_obj = mesh; }
    drIMesh* GetMesh() { return _mesh_obj; }

    void SetMTFlag(DWORD flag) { _mt_flag = flag; }
    DR_RESULT BeginSet();
    DR_RESULT EndSet();
    DR_RESULT DrawSubset( DWORD subset );    
    DR_RESULT LoadMesh( const drMeshInfo* info );
    DR_RESULT LoadMesh( const drResFileMesh* info );
    DR_RESULT DestroyMesh();
    DR_RESULT Destroy();
    DR_RESULT Clone( drIMeshAgent** ret_obj );
};


class drResBufMgr : public drIResBufMgr
{
    struct drModelObjInfoMap
    {
        drModelObjInfo info;
        char file[DR_MAX_PATH];
        DWORD size;
        DWORD hit_time;
    };

    typedef drObjectPoolVoidPtr10240 drPoolSysMemTex;
    typedef drObjectPoolVoidPtr10240 drPoolModelObj;
    
    DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drPoolSysMemTex _pool_sysmemtex;
    drPoolModelObj _pool_modelobj;
    drCriticalSection _lock_sysmemtex;

    DWORD _modelobj_data_size;
    DWORD _sysmemtex_data_size;

    DWORD _lmt_modelobj_data_size;
    DWORD _lmt_modelobj_data_time;

public:
    drResBufMgr(drIResourceMgr* res_mgr);
    ~drResBufMgr();

    DR_RESULT Destroy();
    DR_RESULT RegisterSysMemTex(DR_HANDLE* handle, const drSysMemTexInfo* info);
    DR_RESULT QuerySysMemTex(drSysMemTexInfo* info);
    DR_RESULT QuerySysMemTex(drSysMemTexInfo** info, const char* file);
    DR_RESULT GetSysMemTex(drSysMemTexInfo** info, DR_HANDLE handle);
    DR_RESULT UnregisterSysMemTex(DR_HANDLE handle);

    DR_RESULT RegisterModelObjInfo(DR_HANDLE handle, const char* file);
    DR_RESULT RegisterModelObjInfo(DR_HANDLE* handle, const char* file);
    DR_RESULT QueryModelObjInfo(drIModelObjInfo** info, const char* file);
    DR_RESULT GetModelObjInfo(drIModelObjInfo** info, DR_HANDLE handle);
    DR_RESULT UnregisterModelObjInfo(DR_HANDLE handle);

    void SetLimitModelObjInfo(DWORD lmt_size, DWORD lmt_time) { _lmt_modelobj_data_size = lmt_size;  _lmt_modelobj_data_time = lmt_time; }
    DR_RESULT FilterModelObjInfoSize();
};

class drThreadPoolMgr : public drIThreadPoolMgr
{
    DR_STD_DECLARATION()

    enum
    {
        CRITICALSECTION_SEQ_SIZE = 1,
    };

private:
    drIThreadPool* _pool_seq[THREAD_POOL_SIZE];
    CRITICAL_SECTION _cs_seq[CRITICALSECTION_SEQ_SIZE];

public:
    drThreadPoolMgr();
    ~drThreadPoolMgr();

    DR_RESULT Create();
    DR_RESULT Destroy();

    drIThreadPool* GetThreadPool(DWORD type) { return _pool_seq[type]; }
    void LockCriticalSection(DWORD type) { ::EnterCriticalSection(&_cs_seq[type]); }
    void UnlockCriticalSection(DWORD type) { ::LeaveCriticalSection(&_cs_seq[type]); }
};

// drResourceMgr
class drResourceMgr : public drIResourceMgr
{
    typedef drObjectPoolVoidPtr10240 drPoolMesh;
    typedef drObjectPoolVoidPtr40960 drPoolTex;
    typedef drObjectPoolVoidPtr1024 drPoolMeshRender;
    typedef drObjectPoolVoidPtr1024 drPoolTexRender;
    typedef drObjectPoolVoidPtr1024 drPoolAnimCtrl;

DR_STD_DECLARATION()

private:
    drISysGraphics* _sys_graphics;
    drIDeviceObject* _dev_obj;
    drIStaticStreamMgr* _static_stream_mgr;
    drIDynamicStreamMgr* _dynamic_stream_mgr;
    drILockableStreamMgr* _lockable_stream_mgr;
    drISurfaceStreamMgr* _surface_stream_mgr;
    drIShaderMgr* _shader_mgr;
    drIResBufMgr* _resbuf_mgr;
    drIThreadPoolMgr* _thread_pool_mgr;

    drPoolMesh _pool_mesh;    
    drPoolTex _pool_tex;
    drPoolAnimCtrl _pool_animctrl;

    drObjectPoolVoidPtr10240 _pool_model;
    drObjectPoolVoidPtr1024 _pool_physique;
    drObjectPoolVoidPtr1024 _pool_item;

    
    char _texture_path[DR_MAX_PATH];

    // render ctrl proc sequence
    drRenderCtrlVSCreateProc _render_ctrl_proc_seq[ DR_RENDER_CTRL_PROC_NUM ];

    drByteSet _byte_set;
    drAssObjInfo _assobj_info;

    // begin debug information
    DR_DWORD _mesh_size_sm;
    DR_DWORD _mesh_size_vm;
    DR_DWORD _tex_size_sm;
    DR_DWORD _tex_size_vm;

public:
//  drTexLogMgr _texlog_mgr;
    // end

public:
    drResourceMgr( drISysGraphics* sys );
    ~drResourceMgr();

    drISysGraphics* GetSysGraphics() { return _sys_graphics; }
    drIDeviceObject* GetDeviceObject() { return _dev_obj; }
    drIShaderMgr* GetShaderMgr() { return _shader_mgr; }
    drIStaticStreamMgr* GetStaticStreamMgr() { return _static_stream_mgr; }
    drIDynamicStreamMgr* GetDynamicStreamMgr() { return _dynamic_stream_mgr; }
    drILockableStreamMgr* GetLockableStreamMgr() { return _lockable_stream_mgr; }
    drISurfaceStreamMgr* GetSurfaceStreamMgr() { return _surface_stream_mgr; }
    drIResBufMgr* GetResBufMgr() { return _resbuf_mgr; }
    drIThreadPoolMgr* GetThreadPoolMgr() { return _thread_pool_mgr; }
    drIByteSet* GetByteSet() { return &_byte_set; }

    DR_RESULT SetAssObjInfo(DWORD mask, const drAssObjInfo* info);
    DR_RESULT GetAssObjInfo(drAssObjInfo* info);

    DR_RESULT CreateMesh( drIMesh** ret_obj );
    DR_RESULT CreateTex( drITex** ret_obj );
    DR_RESULT CreateAnimCtrl( drIAnimCtrl** ret_obj, DWORD type );
    DR_RESULT CreateAnimCtrlObj( drIAnimCtrlObj** ret_obj, DWORD type );

    DR_RESULT CreateMeshAgent( drIMeshAgent** ret_obj );
    DR_RESULT CreateMtlTexAgent( drIMtlTexAgent** ret_obj );
    DR_RESULT CreateAnimCtrlAgent( drIAnimCtrlAgent** ret_obj );
    DR_RESULT CreateRenderCtrlAgent(drIRenderCtrlAgent** ret_obj);
    DR_RESULT CreateRenderCtrlVS( drIRenderCtrlVS** ret_obj, DWORD type );

    DR_RESULT CreatePrimitive( drIPrimitive** ret_obj );
    DR_RESULT CreateHelperObject(drIHelperObject** ret_obj);

    DR_RESULT CreatePhysique( drIPhysique** ret_obj );
    DR_RESULT CreateModel( drIModel** ret_obj );
    DR_RESULT CreateItem( drIItem** ret_obj );

    DR_RESULT CreateNode(drINode** ret_obj, DWORD type);
    DR_RESULT CreateNodeObject(drINodeObject** ret_obj);

    DR_RESULT CreateStaticStreamMgr(drIStaticStreamMgr** mgr);
    DR_RESULT CreateDynamicStreamMgr(drIDynamicStreamMgr** mgr);

    DR_RESULT GetMesh( drIMesh** ret_obj, DWORD id );
    DR_RESULT GetTex( drITex** ret_obj, DWORD id );
    DR_RESULT GetAnimCtrl( drIAnimCtrl** ret_obj, DWORD id );

    // 直接注册，不通过文件方式查找，在这种情况下一旦内存数据被删除，显存数据将创建失败
    // 适用于一些帮助性的物体，如BoundingBox等
    DR_RESULT RegisterMesh( drIMesh* obj );
    DR_RESULT RegisterTex( drITex* obj );
    DR_RESULT RegisterAnimCtrl( drIAnimCtrl* obj );
    DR_RESULT RegisterRenderCtrlProc( DWORD id, drRenderCtrlVSCreateProc proc );

    DR_RESULT UnregisterMesh( drIMesh* obj );
    DR_RESULT UnregisterTex( drITex* obj );
    DR_RESULT UnregisterAnimCtrl( drIAnimCtrl* obj );

    DR_RESULT ClearAllMesh();
    DR_RESULT ClearAllTex();
    DR_RESULT ClearAllAnimCtrl();

    DR_RESULT AddRefMesh( drIMesh* obj, DWORD ref_cnt );
    DR_RESULT AddRefTex( drITex* obj, DWORD ref_cnt );
    DR_RESULT AddRefAnimCtrl( drIAnimCtrl* ret_obj, DWORD ref_cnt );
    
    DR_ULONG QueryTexRefCnt(drITex* obj);

    DR_RESULT QueryMesh( DWORD* ret_id, const drResFileMesh* rfm );
    DR_RESULT QueryTex( DWORD* ret_id, const char* file_name );
    // 目前只有RegisterAnimData时候使用RES_FILE_TYPE_GENERIC或RES_FILE_TYPE_GEOMETRY文件类型的资源才有效
    DR_RESULT QueryAnimCtrl( DWORD* ret_id, const drResFileAnimData* info );

    DR_VOID ReleaseObject();
    DR_RESULT RegisterObject( DWORD* ret_id, void* obj, DWORD type );
    DR_RESULT UnregisterObject( void** ret_obj, DWORD id, DWORD type );
    DR_RESULT QueryObject( void** ret_obj, DWORD type, const char* file_name );
    DR_RESULT QueryModelObject( void** ret_obj, DWORD model_id );

    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

	void SetTexturePath(const char* path) { _tcsncpy_s(_texture_path, path, _TRUNCATE ); }
	char* GetTexturePath() { return _texture_path; }

	public:
		IDirect3DTexture8* getMonochromaticTexture( D3DCOLOR colour, const std::string& filterTexture );

		const char* getTextureOperationDescription( size_t operation );

	private:
		IDirect3DTexture8* _createMonochromaticTexture(
			D3DCOLOR colour,
			const std::string& filterTexture,
			UINT width, UINT height );

		typedef std::pair < D3DCOLOR, std::string > ColourFilterPair;
		typedef std::map < ColourFilterPair, IDirect3DTexture8* > ColorFilterPairTextureList;
		ColorFilterPairTextureList mColorFilterTextureList;
};


DR_END
