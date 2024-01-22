//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drExpObj.h"
#include "drITypes.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drHelperBase
{
protected:
    int _visible_flag;
    drMatrix44 _mat_parent;

public:
    drHelperBase()
        : _visible_flag(0)
    {}

    void SetMatrixParent( const drMatrix44* mat ) { _mat_parent = *mat; }
    
};

class drBoundingBox : public drHelperBase, public drIBoundingBox
{

DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIPrimitive* _obj;
    drBoundingBoxInfo* _obj_seq;
    DWORD _obj_num;
    DWORD _data;

public:
    drBoundingBox();
    ~drBoundingBox();

    void SetResourceMgr( drIResourceMgr* mgr ) { _res_mgr = mgr; }
    DR_RESULT CreateInstance();
    DR_RESULT Clone( const drBoundingBox* src );

    DR_RESULT SetDataInfo( const drBoundingBoxInfo* obj_seq, DWORD obj_num );

    virtual int IsVisible() const { return _visible_flag; }
    virtual void SetVisible( int flag ) { _visible_flag = flag; }
    virtual int IsValidObject() const { return _obj_num > 0; }
    virtual drBoundingBoxInfo* GetDataInfoWithID( DWORD obj_id );
    virtual drBoundingBoxInfo* GetDataInfo( DWORD id ) { return &_obj_seq[ id ]; }
    virtual DWORD GetObjNum() const { return _obj_num; }
    drMatrix44* GetMatrixParent() { return &_mat_parent; }

    virtual DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent );
    virtual DR_RESULT Render();
    void SetData( DWORD data ) { _data = data; }
    DWORD GetData() const { return _data; }

};

class drBoundingSphere : public drHelperBase, public drIBoundingSphere
{

DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIPrimitive* _obj;

    drBoundingSphereInfo* _obj_seq;
    DWORD _obj_num;

    DWORD _data;
public:
    drBoundingSphere();
    ~drBoundingSphere();

    void SetResourceMgr( drIResourceMgr* mgr ) { _res_mgr = mgr; }
    DR_RESULT CreateInstance();
    DR_RESULT Clone( const drBoundingSphere* src );

    DR_RESULT SetDataInfo( const drBoundingSphereInfo* obj_seq, DWORD obj_num );
    virtual drBoundingSphereInfo* GetDataInfoWithID( DWORD obj_id );
    virtual DWORD GetObjNum() const { return _obj_num; }
    virtual drBoundingSphereInfo* GetDataInfo( DWORD id ) { return &_obj_seq[ id ]; }
    drMatrix44* GetMatrixParent() { return &_mat_parent; }

    virtual int IsVisible() const { return _visible_flag; }
    virtual void SetVisible( int flag ) { _visible_flag = flag; }
    virtual int IsValidObject() const { return _obj_num > 0; }

    virtual DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent );
    virtual DR_RESULT Render();

    void SetData( DWORD data ) { _data = data; }
    DWORD GetData() const { return _data; }
};


class drHelperDummy : public drHelperBase, public drIHelperDummy
{

DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIPrimitive* _obj;

    drHelperDummyInfo* _obj_seq;
    DWORD _obj_num;

public:
    drHelperDummy();
    ~drHelperDummy();

    DR_RESULT SetDataInfo( const drHelperDummyInfo* obj_seq, DWORD obj_num );

    DR_RESULT Clone( const drHelperDummy* src );

    DR_RESULT CreateInstance();
    DR_RESULT Render();


    void SetResourceMgr( drIResourceMgr* mgr ) { _res_mgr = mgr; }
    virtual int IsVisible() const { return _visible_flag; }
    virtual void SetVisible( int flag ) { _visible_flag = flag; }
    virtual int IsValidObject() const { return _obj_num > 0; }
    virtual drMatrix44* GetMatrixParent() { return &_mat_parent; }
    DWORD GetObjNum() { return _obj_num; }
    drHelperDummyInfo* GetDataInfo(DWORD id) { return &_obj_seq[id]; }
    drHelperDummyInfo* GetDataInfoWithID(DWORD obj_id);
};

class drHelperMesh : public drHelperBase, public drIHelperMesh
{
DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIPrimitive* _obj;

    drHelperMeshInfo* _obj_seq;
    DWORD _obj_num;

public:
    drHelperMesh();
    ~drHelperMesh();

    void SetResourceMgr( drIResourceMgr* mgr ) { _res_mgr = mgr; }
    void SetDataInfo( const drHelperMeshInfo* obj_seq, DWORD obj_num );
    virtual drHelperMeshInfo* GetDataInfoWithID( DWORD obj_id );
    drHelperMeshInfo* GetDataInfo(DWORD id) { return &_obj_seq[id]; }
    DWORD GetObjNum() { return _obj_num; }

    DR_RESULT Clone( const drHelperMesh* src );

    DR_RESULT CreateInstance();
    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent, const char* type_name );
    DR_RESULT Render();

    virtual int IsVisible() const { return _visible_flag; }
    virtual void SetVisible( int flag ) { _visible_flag = flag; }
    virtual int IsValidObject() const { return _obj_num > 0; }

};

class drHelperBox : public drHelperBase, public drIHelperBox
{

DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIPrimitive* _obj;

    drHelperBoxInfo* _obj_seq;
    DWORD _obj_num;

public:
    drHelperBox();
    ~drHelperBox();

    void SetResourceMgr( drIResourceMgr* mgr ) { _res_mgr = mgr; }
    DR_RESULT SetDataInfo( const drHelperBoxInfo* obj_seq, DWORD obj_num );
    virtual drHelperBoxInfo* GetDataInfoWithID( DWORD obj_id );
    drHelperBoxInfo* GetDataInfo(DWORD id) { return &_obj_seq[id]; }
    DWORD GetObjNum() { return _obj_num; }

    DR_RESULT Clone( const drHelperBox* src );

   DR_RESULT CreateInstance();
   DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent, const char* type_name );
   DR_RESULT Render();

    virtual int IsVisible() const { return _visible_flag; }
    virtual void SetVisible( int flag ) { _visible_flag = flag; }
    virtual int IsValidObject() const { return _obj_num > 0; }

};


class drHelperObject : public drIHelperObject
{
DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;

    drHelperDummy* _obj_dummy;
    drHelperBox* _obj_box;
    drHelperMesh* _obj_mesh;

    drBoundingBox* _obj_boundingbox;
    drBoundingSphere* _obj_boundingsphere;

public:

    drHelperObject( drIResourceMgr* mgr );
    ~drHelperObject();

    DR_RESULT LoadHelperInfo( const drHelperInfo* info, int create_instance_flag );
    DR_RESULT Copy( const drIHelperObject* src );
    DR_RESULT Clone(drIHelperObject** ret_obj);

    void SetParentMatrix(const drMatrix44* mat);
    DR_RESULT Update();
    DR_RESULT Render();

    void SetVisible( int flag );
    drIHelperDummy* GetHelperDummy() { return _obj_dummy; }
    drIHelperBox* GetHelperBox() { return _obj_box; }
    drIHelperMesh* GetHelperMesh() { return _obj_mesh; }
    drIBoundingBox* GetBoundingBox() { return _obj_boundingbox; }
    drIBoundingSphere* GetBoundingSphere() { return _obj_boundingsphere; }

    DR_RESULT ExtractHelperInfo(drIHelperInfo* out_info);

};

DR_END
