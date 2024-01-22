//


#include "drPrimitiveHelper.h"
#include "drD3D.h"
#include "drRenderImp.h"
#include "drResourceMgr.h"
#include "drDeviceObject.h"
#include "drHelperGeometry.h"
//#include "drTimer.h"

#define USE_VS_INDEXED

DR_BEGIN

drVector3 getScale( const drMatrix44& matrix )
{
	drVector3 scale;
	scale.x = sqrt ( matrix._11 * matrix._11 + matrix._12 * matrix._12 + matrix._13 * matrix._13 );
	scale.y = sqrt ( matrix._21 * matrix._21 + matrix._22 * matrix._22 + matrix._23 * matrix._23 );
	scale.z = sqrt ( matrix._31 * matrix._31 + matrix._32 * matrix._32 + matrix._33 * matrix._33 );
	return scale;
}

float max3( const drVector3& vec )
{
	return vec.x >= vec.y ?
		( vec.x >= vec.z ? vec.x : vec.z ) :
		( vec.y >= vec.z ? vec.y : vec.z );
}

// drHelperDummy
DR_STD_ILELEMENTATION( drHelperDummy )

drHelperDummy::drHelperDummy()
: _obj_seq(0), _obj_num(0), _obj(0)
{
}

drHelperDummy::~drHelperDummy()
{
    DR_IF_RELEASE(_obj);
    DR_IF_DELETE_A(_obj_seq);
}

DR_RESULT drHelperDummy::SetDataInfo( const drHelperDummyInfo* obj_seq, DWORD obj_num )
{
    DR_SAFE_DELETE_A( _obj_seq );

    _obj_num = obj_num;
    _obj_seq = DR_NEW( drHelperDummyInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &obj_seq[ 0 ], sizeof( drHelperDummyInfo ) * _obj_num );

    return DR_RET_OK;

}
DR_RESULT drHelperDummy::Clone( const drHelperDummy* src )
{
    if( src->IsValidObject() == 0 )
        return DR_RET_OK;

    _res_mgr = src->_res_mgr;
    _visible_flag = src->_visible_flag;
    
    if(src->_obj)
    {
        src->_obj->Clone(&_obj);
    }

    _obj_num = src->_obj_num;
    _obj_seq = DR_NEW( drHelperDummyInfo[ _obj_num ] );

    memcpy( &_obj_seq[ 0 ], &src->_obj_seq[ 0 ], sizeof( drHelperDummyInfo ) * _obj_num );


    return DR_RET_OK;

}

DR_RESULT drHelperDummy::CreateInstance()
{
    if( _obj_num == 0 )
        return DR_RET_FAILED;

    _res_mgr->CreatePrimitive( &_obj );

    const float vert_len = 0.1f;

    drVector3 vert_buf[ 24 ] =
    {
        // bottom
        drVector3( - vert_len, - vert_len, - vert_len ),
        drVector3( - vert_len, - vert_len,   vert_len ),

        drVector3( - vert_len, - vert_len,   vert_len ),
        drVector3(   vert_len, - vert_len,   vert_len ),

        drVector3(   vert_len, - vert_len,   vert_len ),
        drVector3(   vert_len, - vert_len, - vert_len ),

        drVector3(   vert_len, - vert_len, - vert_len ),
        drVector3( - vert_len, - vert_len, - vert_len ),

        // top
        drVector3( - vert_len,   vert_len, - vert_len ),
        drVector3( - vert_len,   vert_len,   vert_len ),

        drVector3( - vert_len,   vert_len,   vert_len ),
        drVector3(   vert_len,   vert_len,   vert_len ),

        drVector3(   vert_len,   vert_len,   vert_len ),
        drVector3(   vert_len,   vert_len, - vert_len ),

        drVector3(   vert_len,   vert_len, - vert_len ),
        drVector3( - vert_len,   vert_len, - vert_len ),

        // side
        drVector3( - vert_len, - vert_len, - vert_len ),
        drVector3( - vert_len,   vert_len, - vert_len ),

        drVector3( - vert_len, - vert_len,   vert_len ),
        drVector3( - vert_len,   vert_len,   vert_len ),

        drVector3(   vert_len, - vert_len,   vert_len ),
        drVector3(   vert_len,   vert_len,   vert_len ),

        drVector3(   vert_len, - vert_len, - vert_len ),
        drVector3(   vert_len,   vert_len, - vert_len ),
    };
        

    DWORD cor_buf[ 24 ];
    DWORD c = 0xffff0000;
    for( DWORD i = 0; i < 24; i++ )
    {
        cor_buf[ i ] = c;
    }

    return drLoadPrimitiveLineList( _obj, "object_dummy", 24, vert_buf, cor_buf );
}

DR_RESULT drHelperDummy::Render()
{
    if( _obj == 0 || _visible_flag == 0 )
        return DR_RET_OK;


    for( DWORD i = 0; i < _obj_num; i++ )
    {
        drMatrix44 mat( _obj_seq[ i ].mat );
        drMatrix44Multiply( &mat, &mat, &_mat_parent );

        _obj->SetMatrixParent( &mat );
        _obj->Update();
        _obj->Render();

    }

    return DR_RET_OK;
}

drHelperDummyInfo* drHelperDummy::GetDataInfoWithID( DWORD obj_id )
{
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        if( _obj_seq[ i ].id == obj_id )
            return &_obj_seq[ i ];
    }

    return NULL;

}

// drBoundingBox
DR_STD_ILELEMENTATION( drBoundingBox )

drBoundingBox::drBoundingBox()
: _obj_seq( 0 ), _obj_num( 0 ), _data(0), _obj(0)
{
}

drBoundingBox::~drBoundingBox()
{
    DR_SAFE_DELETE_A( _obj_seq );
    DR_IF_RELEASE(_obj);
}

DR_RESULT drBoundingBox::SetDataInfo( const drBoundingBoxInfo* obj_seq, DWORD obj_num )
{

    _obj_num = obj_num;
    _obj_seq = DR_NEW( drBoundingBoxInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &obj_seq[ 0 ], sizeof( drBoundingBoxInfo ) * _obj_num );

    return DR_RET_OK;
}

DR_RESULT drBoundingBox::CreateInstance()
{
    if( _obj_num == 0 )
        return DR_RET_FAILED;

    _res_mgr->CreatePrimitive( &_obj );

    DWORD vert_num = _obj_num * 24;
    drVector3* vert_buf = DR_NEW( drVector3[ vert_num ] );

    drSubsetInfo* subset_seq = DR_NEW( drSubsetInfo[ _obj_num ] );

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        subset_seq[ i ].vertex_num = 24;
        subset_seq[ i ].primitive_num = 12;
        subset_seq[ i ].min_index = i * 24;
        subset_seq[ i ].start_index = i * 24;

        drGetBoxVertLineList( &vert_buf[ i * 24 ], &_obj_seq[ i ].box );
    }
    
    DWORD c = 0xffff0000;
    DWORD* color_buf = DR_NEW( DWORD[ vert_num ] );
    for( DWORD i = 0; i < vert_num; i++ )
    {
        color_buf[ i ] = c;
    }

    DR_RESULT ret = drLoadPrimitiveLineList( _obj, "HelperBox", vert_num, vert_buf, color_buf, subset_seq, _obj_num );

    DR_DELETE_A( vert_buf );
    DR_DELETE_A( color_buf );
    DR_DELETE_A( subset_seq );

    return ret;
}

DR_RESULT drBoundingBox::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent )
{
    DR_RESULT ret = DR_RET_FAILED;

    drMatrix44 mat;

    drPickInfo u,v;
    v.obj_id = DR_INVALID_INDEX;

    if( _obj_num == 0 )
        goto __ret;


    for( DWORD j = 0; j < _obj_num; j++ )
    {
		drBox box = _obj_seq[ j ].box;

        drMatrix44Multiply( &mat, &_obj_seq[ j ].mat, mat_parent );

		drVector3 scale = getScale( mat );
		box.r.x *= scale.x;
		box.r.y *= scale.y;
		box.r.z *= scale.z;
		

        if( DR_FAILED( drHitTestBox( &u, org, ray, &box, &mat ) ) )
            continue;

        if( v.obj_id == DR_INVALID_INDEX || v.dis > u.dis )
        {
            v = u;
            v.obj_id = _obj_seq[ j ].id;
        }

    }


    if( v.obj_id == DR_INVALID_INDEX )
        goto __ret;

    *info = v;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drBoundingBox::Render()
{
    if( _obj == 0 || _visible_flag == 0 )
        return DR_RET_OK;


    _obj->Update();

    drMatrix44 mat;

    
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        drMatrix44Multiply( &mat, &_obj_seq[i].mat, &_mat_parent );

        _obj->SetMatrixParent( &mat );

        _obj->RenderSubset( i );
    }

    return DR_RET_OK;
}

DR_RESULT drBoundingBox::Clone( const drBoundingBox* src )
{
    if( src->IsValidObject() == 0 )
        return DR_RET_OK;

    _obj_num = src->_obj_num;
    _obj_seq = DR_NEW( drBoundingBoxInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &src->_obj_seq[ 0 ], sizeof( drBoundingBoxInfo ) * _obj_num );

    _res_mgr = src->_res_mgr;
    _visible_flag = src->_visible_flag;
    
    if(src->_obj)
    {
        src->_obj->Clone(&_obj);
    }

    return DR_RET_OK;
}

drBoundingBoxInfo* drBoundingBox::GetDataInfoWithID( DWORD obj_id )
{
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        if( _obj_seq[ i ].id == obj_id )
            return &_obj_seq[ i ];
    }

    return NULL;
}

// drBoundingSphere
DR_STD_ILELEMENTATION( drBoundingSphere )

drBoundingSphere::drBoundingSphere()
: _obj_seq(0), _obj_num(0), _obj(0), _data(0)
{
}

drBoundingSphere::~drBoundingSphere()
{
    DR_SAFE_DELETE_A(_obj_seq);
    DR_IF_RELEASE(_obj);
}

DR_RESULT drBoundingSphere::SetDataInfo( const drBoundingSphereInfo* obj_seq, DWORD obj_num )
{

    _obj_num = obj_num;
    _obj_seq = DR_NEW( drBoundingSphereInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &obj_seq[ 0 ], sizeof( drBoundingSphereInfo ) * _obj_num );

    return DR_RET_OK;
}

DR_RESULT drBoundingSphere::CreateInstance()
{
    if( _obj_num == 0 )
        return DR_RET_FAILED;

    const DWORD default_ring = 4;
    const DWORD default_seg = 4;
    const DWORD default_sphere_vert_num = default_ring * default_seg * 2 * 2;

    DWORD vert_num = _obj_num * default_sphere_vert_num;

    drVector3* vert_buf = DR_NEW( drVector3[ vert_num ] );

    drSubsetInfo* subset_seq = DR_NEW( drSubsetInfo[ _obj_num ] );

    int index;
    float xo, yo, zo, ro;

    DWORD i, j, k;

    float seg_ang = DR_2_PI / default_seg;
    float rin_ang = DR_PI / default_ring;
    float radius;

    drVector3* sp_buf = DR_NEW( drVector3[ ( default_ring + 1 ) * ( default_seg + 1 ) ] );

    for( k = 0; k < _obj_num; k++ )
    {
        radius = _obj_seq[ k ].sphere.r;

        for( i = 0; i <= default_ring; i++ )
        {
            ro = radius * sinf( i * rin_ang );
            yo = radius * cosf( i * rin_ang );

            for( DWORD j = 0; j <= default_seg; j++ ) 
            {
                xo = ro * cosf( j * (-seg_ang) );
                zo = ro * sinf( j * (-seg_ang) );

                index = i * (default_seg + 1) + j;

                sp_buf[ index ].x = xo;
                sp_buf[ index ].y = yo;
                sp_buf[ index ].z = zo;
            }
        }

        drVector3* p = vert_buf + k * default_sphere_vert_num;

        // lat. line list
        for( i = 0; i < default_ring; i++ )
        {
            for( j = 0; j < default_seg; j++ )
            {
                *p++ = sp_buf[ i * (default_seg + 1) + j ];
                *p++ = sp_buf[ i * (default_seg + 1) + j + 1 ];
            }
        }

        // long. line list
        for( i = 0; i < default_ring; i++ )
        {
            for( j = 0; j < default_seg; j++ )
            {
                *p++ = sp_buf[ i * (default_seg + 1) + j ];
                *p++ = sp_buf[ ( i + 1 ) * (default_seg + 1) + j ];
            }
        }

        subset_seq[ k ].start_index = default_sphere_vert_num * k;
        subset_seq[ k ].vertex_num = default_sphere_vert_num;
        subset_seq[ k ].primitive_num = default_sphere_vert_num / 2;

    }

    DR_DELETE_A( sp_buf );
    
    DWORD c = 0xffff0000;
    DWORD* color_buf = DR_NEW( DWORD[ vert_num ] );
    for( DWORD i = 0; i < vert_num; i++ )
    {
        color_buf[ i ] = c;
    }

    _res_mgr->CreatePrimitive( &_obj );

    DR_RESULT ret = drLoadPrimitiveLineList( _obj, "BoundingSphere", vert_num, vert_buf, color_buf, subset_seq, _obj_num );

    DR_DELETE_A( vert_buf );
    DR_DELETE_A( color_buf );
    DR_DELETE_A( subset_seq );

    return ret;
}

DR_RESULT drBoundingSphere::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent )
{
    DR_RESULT ret = DR_RET_FAILED;

    drMatrix44 mat;

    drPickInfo u,v;
    v.obj_id = DR_INVALID_INDEX;

    drSphere s;

    if( _obj_num == 0 )
        goto __ret;


    for( DWORD j = 0; j < _obj_num; j++ )
    {

        s = _obj_seq[ j ].sphere;

        drMatrix44Multiply( &mat, &_obj_seq[ j ].mat, mat_parent );

        drVec3Mat44Mul( &s.c, &mat );

		drVector3 scale = getScale( mat );
		s.r *= max3( scale );

        if( drIntersectRaySphere( &u.pos, &s, org, ray ) == 0 )
            continue;

        u.dis = drVector3Magnitude( &u.pos, org );

        if( v.obj_id == DR_INVALID_INDEX || v.dis > u.dis )
        {
            v = u;
            v.obj_id = _obj_seq[ j ].id;
        }

    }


    if( v.obj_id == DR_INVALID_INDEX )
        goto __ret;

    *info = v;

    ret = DR_RET_OK;

__ret:
    return ret;

}

DR_RESULT drBoundingSphere::Render()
{
    if( _obj == 0 || _visible_flag == 0 )
        return DR_RET_OK;

    _obj->Update();

    drMatrix44 mat;

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        drMatrix44Multiply( &mat, &_obj_seq[i].mat, &_mat_parent );

        _obj->SetMatrixParent( &mat );

        _obj->RenderSubset( i );
    }

    return DR_RET_OK;
}

DR_RESULT drBoundingSphere::Clone( const drBoundingSphere* src )
{
    if( src->IsValidObject() == 0 )
        return DR_RET_OK;

    _obj_num = src->_obj_num;
    _obj_seq = DR_NEW( drBoundingSphereInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &src->_obj_seq[ 0 ], sizeof( drBoundingSphereInfo ) * _obj_num );

    _res_mgr = src->_res_mgr;
    _visible_flag = src->_visible_flag;
    
    if(src->_obj)
    {
        src->_obj->Clone(&_obj);
    }

    return DR_RET_OK;
}

drBoundingSphereInfo* drBoundingSphere::GetDataInfoWithID( DWORD obj_id )
{
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        if( _obj_seq[ i ].id == obj_id )
            return &_obj_seq[ i ];
    }

    return NULL;
}

// drHelperMesh
DR_STD_ILELEMENTATION( drHelperMesh )

drHelperMesh::drHelperMesh()
: _obj_seq(0), _obj_num(0), _obj(0)
{
}

drHelperMesh::~drHelperMesh()
{
    DR_SAFE_DELETE_A( _obj_seq );
    DR_IF_RELEASE(_obj);
}

void drHelperMesh::SetDataInfo( const drHelperMeshInfo* obj_seq, DWORD obj_num )
{
    _obj_num = obj_num;
    _obj_seq = DR_NEW( drHelperMeshInfo[ _obj_num ] );

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        _obj_seq[ i ].Copy( &obj_seq[ i ] );
    }
}
DR_RESULT drHelperMesh::CreateInstance()
{
    if( _obj_num == 0 )
        return DR_RET_FAILED;


    _res_mgr->CreatePrimitive( &_obj );

    DWORD i, j;

    drMeshInfo info;

    DWORD vert_num = 0;
    DWORD index_num = 0;

    for( i = 0; i < _obj_num; i++ )
    {
        vert_num += _obj_seq[ i ].vertex_num;
        index_num += _obj_seq[ i ].face_num * 3;
    }

    info.fvf = FVF_XYZDIFFUSE;
    info.pt_type = D3DPT_TRIANGLELIST;
    info.vertex_num = vert_num;
    info.index_num = index_num;
    info.subset_num = _obj_num;
    info.vertex_seq = DR_NEW( drVector3[ info.vertex_num ] );
    info.vercol_seq = DR_NEW( DWORD[ info.vertex_num ] );
    info.index_seq = DR_NEW( DWORD[ info.index_num ] );
    info.subset_seq = DR_NEW(drSubsetInfo[info.subset_num]);


    info.subset_seq[ 0 ].min_index = 0;
    info.subset_seq[ 0 ].start_index = 0;
    info.subset_seq[ 0 ].vertex_num = _obj_seq[ 0 ].vertex_num;
    info.subset_seq[ 0 ].primitive_num = _obj_seq[ 0 ].face_num;

    vert_num = _obj_seq[ 0 ].vertex_num;
    index_num = _obj_seq[ 0 ].face_num * 3;

    for( i = 1; i < _obj_num; i++ )
    {
        info.subset_seq[ i ].min_index = vert_num;
        info.subset_seq[ i ].start_index = index_num;
        info.subset_seq[ i ].vertex_num = _obj_seq[ i ].vertex_num;
        info.subset_seq[ i ].primitive_num = _obj_seq[ i ].face_num;

        vert_num += _obj_seq[ i ].vertex_num;
        index_num += _obj_seq[ i ].face_num * 3;

    }

    vert_num = 0;
    for( i = 0; i < _obj_num; i++ )
    {
        memcpy( &info.vertex_seq[ vert_num ], &_obj_seq[ i ].vertex_seq[ 0 ], sizeof( drVector3 ) * _obj_seq[ i ].vertex_num );
        vert_num += _obj_seq[ i ].vertex_num;
    }
        

    drHelperMeshInfo* hmi;
    DWORD* index_ptr = info.index_seq;

    vert_num = 0;

    for( j = 0; j < _obj_num; j++ )
    {
        hmi = &_obj_seq[ j ];

        for( i = 0; i < hmi->face_num; i++ )
        {
            *( index_ptr++ ) = hmi->face_seq[ i ].vertex[ 0 ] + vert_num;
            *( index_ptr++ ) = hmi->face_seq[ i ].vertex[ 1 ] + vert_num;
            *( index_ptr++ ) = hmi->face_seq[ i ].vertex[ 2 ] + vert_num;
        }

        vert_num += hmi->vertex_num;
    }

    DWORD c = 0xff0000ff;
    for( i = 0; i < info.vertex_num; i++ )
    {
        info.vercol_seq[ i ] = c;
    }


    RSA_VALUE(&info.rs_set[0], D3DRS_LIGHTING, FALSE);
    RSA_VALUE(&info.rs_set[1], D3DRS_FILLMODE, D3DFILL_WIREFRAME );

    if( DR_FAILED( _obj->LoadMesh( &info ) ) )
        return DR_RET_FAILED;

    for( i = 0; i < _obj_num; i++ )
    {
        drMtlTexInfo mti;
        drMaterial mtl;

        //memset( &mti, 0, sizeof( mti ) );
        memset( &mtl, 0, sizeof( mtl ) );
        mtl.amb.a = mtl.amb.r = mtl.amb.g = mtl.amb.b = 1.0f;

        mti.mtl = mtl;

        _obj->LoadMtlTex( i, &mti, NULL );
    }

    drRenderCtrlCreateInfo rcci;
    drRenderCtrlCreateInfo_Construct( &rcci );
    rcci.ctrl_id = RENDERCTRL_VS_FIXEDFUNCTION;

    _obj->LoadRenderCtrl(&rcci);

    //drIRenderCtrl* render_ctrl;
    //_res_mgr->RequestRenderCtrl( &render_ctrl, RENDERCTRL_VS_FIXEDFUNCTION );
    //_obj->GetRenderCtrlAgent()->SetRenderCtrl(render_ctrl);
    

    return DR_RET_OK;
}

// return value:
// DR_RET_FAILED_2: no valid helper mesh
// DR_RET_FAILED: hit test failed
// DR_RET_OK: hit test succeeded
DR_RESULT drHelperMesh::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent, const char* type_name )
{
//#define USE_INVERSE_MAT
// 使用USE_INVERSE_MAT的代码是有问题的，某些点的hit test会返回失败
#ifdef USE_INVERSE_MAT
    //static int xx = 1;
    //float time_u, time_v;
    ////if(xx == 1)
    //{
    //drResetTick();

    if( _obj_num == 0 )
        return DR_RET_FAILED_2;

    drMatrix44 mat;
    drMatrix44 mat_inv;

    drVector3 org_inv, ray_inv;

    DWORD obj_id = DR_INVALID_INDEX;

    drPickInfo u,v;
    drVector3* v_seq[ 3 ];
    drHelperMeshInfo* hmi;

    v.obj_id = DR_INVALID_INDEX;


    DWORD type_obj = 0;

    for( DWORD k = 0; k < _obj_num; k++ )
    {
        if( type_name )
        {
            if( _tcscmp( _obj_seq[ k ].name, type_name ) )
                continue;
        }

        type_obj += 1;

        hmi = &_obj_seq[ k ];

        //drMatrix44Multiply( &mat, &hmi->mat, mat_parent );
        //drMatrix44Inverse( &mat_inv, &mat );
        D3DXMatrixMultiply( (D3DXMATRIX*)&mat, (D3DXMATRIX*)&hmi->mat, (D3DXMATRIX*)mat_parent );
        D3DXMatrixInverse( (D3DXMATRIX*)&mat_inv, NULL, (D3DXMATRIX*)&mat );

        org_inv = *org;
        drVec3Mat44Mul(&org_inv, &mat_inv);
        drMatrix44 mat_inv_ray(mat_inv);
        mat_inv_ray._41 = mat_inv_ray._42 = mat_inv_ray._43 = 0.0f;
        ray_inv = *ray;
        drVec3Mat44Mul(&ray_inv, &mat_inv_ray);


        for( DWORD i = 0; i < hmi->face_num; i++ )
        {
            v_seq[0] = &hmi->vertex_seq[hmi->face_seq[i].vertex[0]];
            v_seq[1] = &hmi->vertex_seq[hmi->face_seq[i].vertex[1]];
            v_seq[2] = &hmi->vertex_seq[hmi->face_seq[i].vertex[2]];

            drTriangle tri( *v_seq[0], *v_seq[1], *v_seq[2] );

            if( drIntersectRayTriangle( &u.pos, &u.dis, &org_inv, &ray_inv, &tri ) )
            {
                if( (v.obj_id == DR_INVALID_INDEX) || (v.dis > u.dis) )
                {
                    v = u;
                    v.obj_id = k;
                    v.data = hmi->id;
                    v.face_id = i;
                }
            }
        }

        if(v.obj_id != DR_INVALID_INDEX)
        {
            drVec3Mat44Mul(&v.pos, &mat);
        }

    }

    if( type_obj == 0 )
        return DR_RET_FAILED_2;

    if( v.obj_id == DR_INVALID_INDEX )
        return DR_RET_FAILED;

    *info = v;

    //time_u = drGetCurrentTickTime();

    return DR_RET_OK;
    //}

#else
    //else
    //{
        //drResetTick();

    if( _obj_num == 0 )
        return DR_RET_FAILED_2;

    drMatrix44 mat;

    DWORD obj_id = DR_INVALID_INDEX;

    drPickInfo u,v;
    drVector3 v_seq[ 3 ];
    drHelperMeshInfo* hmi;

    v.obj_id = DR_INVALID_INDEX;

    DWORD f;

    DWORD type_obj = 0;

    for( DWORD k = 0; k < _obj_num; k++ )
    {
        if( type_name )
        {
            if( _tcscmp( _obj_seq[ k ].name, type_name ) )
                continue;
        }

        type_obj += 1;

        hmi = &_obj_seq[ k ];

        drMatrix44Multiply( &mat, &hmi->mat, mat_parent );

        for( DWORD i = 0; i < hmi->face_num; i++ )
        {
            for( DWORD j = 0; j < 3; j++ )
            {
                v_seq[ j ] = hmi->vertex_seq[ hmi->face_seq[ i ].vertex[ j ] ];
                drVec3Mat44Mul( &v_seq[ j ], &mat );
            }

            drTriangle tri( v_seq[ 0 ], v_seq[ 1 ], v_seq[ 2 ] );

            if( drIntersectRayTriangle( &u.pos, &u.dis, org, ray, &tri ) )
            {
                if( (v.obj_id == DR_INVALID_INDEX) || (v.dis > u.dis) )
                {
                    v = u;
                    v.obj_id = k;
                    v.data = hmi->id;
                    v.face_id = i;
                    // debug var
                    f = hmi->face_num;
                }
            }
        }

    }

    if( type_obj == 0 )
        return DR_RET_FAILED_2;

    if( v.obj_id == DR_INVALID_INDEX )
        return DR_RET_FAILED;

    *info = v;

    //time_v = drGetCurrentTickTime();

    //LG( "iii", "face num:%d | %10.5f %10.5f\n", f, time_u, time_v );

    return DR_RET_OK;
    //}
#endif
}

DR_RESULT drHelperMesh::Render()
{
    if( _obj == 0 || _visible_flag == 0 )
        return DR_RET_OK;


    _obj->Update();

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        drMatrix44 mat( _obj_seq[ i ].mat );
        drMatrix44Multiply( &mat, &mat, &_mat_parent );

        _obj->SetMatrixParent( &mat );

        _obj->RenderSubset( i );
    }

    return DR_RET_OK;
}

DR_RESULT drHelperMesh::Clone( const drHelperMesh* src )
{
    if( src->IsValidObject() == 0 )
        return DR_RET_OK;

    _res_mgr = src->_res_mgr;
    _visible_flag = src->_visible_flag;
    
    if(src->_obj)
    {   
        src->_obj->Clone(&_obj);
    }

    _obj_num = src->_obj_num;
    _obj_seq = DR_NEW( drHelperMeshInfo[ _obj_num ] );

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        _obj_seq[ i ].Copy( &src->_obj_seq[ i ] );
    }

    return DR_RET_OK;
}

drHelperMeshInfo* drHelperMesh::GetDataInfoWithID( DWORD obj_id )
{
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        if( _obj_seq[ i ].id == obj_id )
            return &_obj_seq[ i ];
    }

    return NULL;

}

// drHelperBox
DR_STD_ILELEMENTATION( drHelperBox )

drHelperBox::drHelperBox()
: _obj_seq(0), _obj_num(0), _obj(0)
{
}
drHelperBox::~drHelperBox()
{
    DR_SAFE_DELETE_A( _obj_seq );
    DR_IF_RELEASE(_obj);
}

DR_RESULT drHelperBox::SetDataInfo( const drHelperBoxInfo* obj_seq, DWORD obj_num )
{
    DR_SAFE_DELETE_A( _obj_seq );

    _obj_num = obj_num;
    _obj_seq = DR_NEW( drHelperBoxInfo[ _obj_num ] );
    memcpy( &_obj_seq[ 0 ], &obj_seq[ 0 ], sizeof( drHelperBoxInfo ) * _obj_num );

    return DR_RET_OK;
}

DR_RESULT drHelperBox::CreateInstance()
{
    if( _obj_num == 0 )
        return DR_RET_FAILED;

    _res_mgr->CreatePrimitive( &_obj );

    DWORD vert_num = _obj_num * 24;
    drVector3* vert_buf = DR_NEW( drVector3[ vert_num ] );

    drSubsetInfo* subset_seq = DR_NEW( drSubsetInfo[ _obj_num ] );

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        subset_seq[ i ].vertex_num = 24;
        subset_seq[ i ].primitive_num = 12;
        subset_seq[ i ].min_index = i * 24;
        subset_seq[ i ].start_index = i * 24;

        drGetBoxVertLineList( &vert_buf[ i * 24 ], &_obj_seq[ i ].box );
    }
    
    DWORD c = 0xff0000ff;
    DWORD* color_buf = DR_NEW( DWORD[ vert_num ] );
    for( DWORD i = 0; i < vert_num; i++ )
    {
        color_buf[ i ] = c;
    }

    DR_RESULT ret = drLoadPrimitiveLineList( _obj, "HelperBox", vert_num, vert_buf, color_buf, subset_seq, _obj_num );

    DR_DELETE_A( vert_buf );
    DR_DELETE_A( color_buf );
    DR_DELETE_A( subset_seq );

    return ret;

}
DR_RESULT drHelperBox::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent, const char* type_name )
{
    DR_RESULT ret = DR_RET_FAILED;

    drMatrix44 mat;

    drPickInfo u,v;
    v.obj_id = DR_INVALID_INDEX;

    if( _obj_num == 0 )
        goto __ret;


    for( DWORD j = 0; j < _obj_num; j++ )
    {

        if( type_name )
        {
            if( _tcscmp( _obj_seq[ j ].name, type_name ) )
                continue;
        }

        drMatrix44Multiply( &mat, &_obj_seq[ j ].mat, mat_parent );

        if( DR_FAILED( drHitTestBox( &u, org, ray, &_obj_seq[ j ].box, &mat ) ) )
            continue;

        if( v.obj_id == DR_INVALID_INDEX || v.dis > u.dis )
        {
            v = u;
            v.obj_id = _obj_seq[ j ].id;
        }

    }


    if( v.obj_id == DR_INVALID_INDEX )
        goto __ret;

    *info = v;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drHelperBox::Render()
{
    if( _obj == 0 || _visible_flag == 0 )
        return DR_RET_OK;


    _obj->Update();

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        drMatrix44 mat( _obj_seq[ i ].mat );
        drMatrix44Multiply( &mat, &mat, &_mat_parent );

        _obj->SetMatrixParent( &mat );

        _obj->RenderSubset( i );
    }

    return DR_RET_OK;

}

drHelperBoxInfo* drHelperBox::GetDataInfoWithID( DWORD obj_id )
{
    for( DWORD i = 0; i < _obj_num; i++ )
    {
        if( _obj_seq[ i ].id == obj_id )
            return &_obj_seq[ i ];
    }

    return NULL;
}

DR_RESULT drHelperBox::Clone( const drHelperBox* src )
{
    if( src->IsValidObject() == 0 )
        return DR_RET_OK;

    _obj_num = src->_obj_num;
    _obj_seq = DR_NEW( drHelperBoxInfo[ _obj_num ] );

    for( DWORD i = 0; i < _obj_num; i++ )
    {
        _obj_seq[ i ].Copy( &src->_obj_seq[ i ] );
    }

    _res_mgr = src->_res_mgr;
    _visible_flag = src->_visible_flag;
    
    if(src->_obj)
    {
        src->_obj->Clone(&_obj);
    }


    return DR_RET_OK;

}


// drHelperObject
DR_STD_ILELEMENTATION( drHelperObject )

drHelperObject::drHelperObject( drIResourceMgr* mgr )
: _res_mgr( mgr ), _obj_dummy( 0 ), _obj_box( 0 ), _obj_mesh( 0 ), _obj_boundingbox( 0 ), _obj_boundingsphere( 0 )
{
}
drHelperObject::~drHelperObject()
{
    DR_SAFE_DELETE( _obj_dummy );
    DR_SAFE_DELETE( _obj_box );
    DR_SAFE_DELETE( _obj_mesh );
    DR_SAFE_DELETE( _obj_boundingbox );
    DR_SAFE_DELETE( _obj_boundingsphere );
}

DR_RESULT drHelperObject::LoadHelperInfo( const drHelperInfo* info, int create_instance_flag )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( info->type & HELPER_TYPE_DUMMY )
    {
        DR_SAFE_DELETE( _obj_dummy );

        _obj_dummy = DR_NEW( drHelperDummy );

        _obj_dummy->SetResourceMgr( _res_mgr );
        _obj_dummy->SetDataInfo( &info->dummy_seq[ 0 ], info->dummy_num );

        if( create_instance_flag )
        {
            if(DR_FAILED(_obj_dummy->CreateInstance()))
                goto __ret;
        }
    }

    if( info->type & HELPER_TYPE_BOX )
    {
        DR_SAFE_DELETE( _obj_box );

        _obj_box = DR_NEW( drHelperBox );

        _obj_box->SetResourceMgr( _res_mgr );
        _obj_box->SetDataInfo( &info->box_seq[ 0 ], info->box_num );

        if( create_instance_flag )
        {
            if(DR_FAILED(_obj_box->CreateInstance()))
                goto __ret;
        }
    }

    if( info->type & HELPER_TYPE_MESH )
    {
        DR_SAFE_DELETE( _obj_mesh );

        _obj_mesh = DR_NEW( drHelperMesh );

        _obj_mesh->SetResourceMgr( _res_mgr );
        _obj_mesh->SetDataInfo( &info->mesh_seq[ 0 ], info->mesh_num );

        if( create_instance_flag )
        {
            if(DR_FAILED(_obj_mesh->CreateInstance()))
                goto __ret;
        }
    }

    if( info->type & HELPER_TYPE_BOUNDINGBOX )
    {
        DR_SAFE_DELETE( _obj_boundingbox );

        _obj_boundingbox = DR_NEW( drBoundingBox );

        _obj_boundingbox->SetResourceMgr( _res_mgr );
        _obj_boundingbox->SetDataInfo( &info->bbox_seq[ 0 ], info->bbox_num );

        if( create_instance_flag )
        {
            if(DR_FAILED(_obj_boundingbox->CreateInstance()))
                goto __ret;
        }
    }

    if( info->type & HELPER_TYPE_BOUNDINGSPHERE )
    {
        DR_SAFE_DELETE( _obj_boundingsphere );

        _obj_boundingsphere = DR_NEW( drBoundingSphere );

        _obj_boundingsphere->SetResourceMgr( _res_mgr );
        _obj_boundingsphere->SetDataInfo( &info->bsphere_seq[ 0 ], info->bsphere_num );

        if( create_instance_flag )
        {
            if(DR_FAILED(_obj_boundingsphere->CreateInstance()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drHelperObject::Copy( const drIHelperObject* src )
{
    drHelperObject* s = (drHelperObject*)src;

    if( s->_obj_dummy )
    {
        _obj_dummy = DR_NEW( drHelperDummy );
        _obj_dummy->Clone( s->_obj_dummy );
    }
    if( s->_obj_box )
    {
        _obj_box = DR_NEW( drHelperBox );
        _obj_box->Clone( s->_obj_box );
    }
    if( s->_obj_mesh )
    {
        _obj_mesh = DR_NEW( drHelperMesh );
        _obj_mesh->Clone( s->_obj_mesh );
    }
    if( s->_obj_boundingbox )
    {
        _obj_boundingbox = DR_NEW( drBoundingBox );
        _obj_boundingbox->Clone( s->_obj_boundingbox );
    }
    if( s->_obj_boundingsphere )
    {
        _obj_boundingsphere = DR_NEW( drBoundingSphere );
        _obj_boundingsphere->Clone( s->_obj_boundingsphere );
    }

    return DR_RET_OK;
}

DR_RESULT drHelperObject::Clone(drIHelperObject** ret_obj)
{
    drIHelperObject* o;
    _res_mgr->CreateHelperObject(&o);
    o->Copy(this);
    *ret_obj = o;
    return DR_RET_OK;
}

void drHelperObject::SetParentMatrix(const drMatrix44* mat)
{   
    if( _obj_dummy )
    {
        _obj_dummy->SetMatrixParent(mat);
    }
    if( _obj_box )
    {
        _obj_box->SetMatrixParent(mat);
    }
    if( _obj_mesh )
    {
        _obj_mesh->SetMatrixParent(mat);
    }
    if( _obj_boundingbox )
    {
        _obj_boundingbox->SetMatrixParent(mat);
    }
    if( _obj_boundingsphere )
    {
        _obj_boundingsphere->SetMatrixParent(mat);
    }
}
DR_RESULT drHelperObject::Update()
{
    return DR_RET_OK;
}

DR_RESULT drHelperObject::Render()
{
    if( _obj_dummy )
    {
        _obj_dummy->Render();
    }
    if( _obj_box )
    {
        _obj_box->Render();
    }
    if( _obj_mesh )
    {
        _obj_mesh->Render();
    }
    if( _obj_boundingbox )
    {
        _obj_boundingbox->Render();
    }
    if( _obj_boundingsphere )
    {
        _obj_boundingsphere->Render();
    }

    return DR_RET_OK;
}

void drHelperObject::SetVisible( int flag )
{
    if( _obj_dummy )
    {
        _obj_dummy->SetVisible( flag );
    }
    if( _obj_box )
    {
        _obj_box->SetVisible( flag );
    }
    if( _obj_mesh )
    {
        _obj_mesh->SetVisible( flag );
    }
    if( _obj_boundingbox )
    {
        _obj_boundingbox->SetVisible( flag );
    }
    if( _obj_boundingsphere )
    {
        _obj_boundingsphere->SetVisible( flag );
    }
}

DR_RESULT drHelperObject::ExtractHelperInfo(drIHelperInfo* out_info)
{
    drHelperInfo* a = (drHelperInfo*)out_info;

    if(_obj_dummy)
    {
        a->type |= HELPER_TYPE_DUMMY;
        a->dummy_num = _obj_dummy->GetObjNum();
        a->dummy_seq = DR_NEW(drHelperDummyInfo[a->dummy_num]);
        memcpy(a->dummy_seq, _obj_dummy->GetDataInfo(0), sizeof(drHelperDummyInfo) * a->dummy_num);
    }
    if(_obj_box)
    {
        a->type |= HELPER_TYPE_BOX;
        a->box_num = _obj_box->GetObjNum();
        a->box_seq = DR_NEW(drHelperBoxInfo[a->box_num]);
        memcpy(a->box_seq, _obj_box->GetDataInfo(0), sizeof(drHelperBoxInfo) * a->box_num);
    }
    if(_obj_mesh)
    {
        a->type |= HELPER_TYPE_MESH;
        a->mesh_num = _obj_mesh->GetObjNum();
        a->mesh_seq = DR_NEW(drHelperMeshInfo[a->mesh_num]);
        for(DWORD i = 0; i < a->mesh_num; i++)
        {
            a->mesh_seq[i].Copy(_obj_mesh->GetDataInfo(i));
        }
    }
    if(_obj_boundingbox)
    {
        a->type |= HELPER_TYPE_BOUNDINGBOX;
        a->bbox_num = _obj_boundingbox->GetObjNum();
        a->bbox_seq = DR_NEW(drBoundingBoxInfo[a->bbox_num]);
        memcpy(a->bbox_seq, _obj_boundingbox->GetDataInfo(0), sizeof(drBoundingBoxInfo) * a->bbox_num);
    }
    if(_obj_boundingsphere)
    {
        a->type |= HELPER_TYPE_BOUNDINGSPHERE;
        a->bsphere_num = _obj_boundingsphere->GetObjNum();
        a->bsphere_seq = DR_NEW(drBoundingSphereInfo[a->bsphere_num]);
        memcpy(a->bsphere_seq, _obj_boundingsphere->GetDataInfo(0), sizeof(drBoundingSphereInfo) * a->bsphere_num);
    }

    return DR_RET_OK;

}


DR_END
