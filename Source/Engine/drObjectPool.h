//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"

DR_BEGIN

enum
{
    ERR_DRIOBJECTPOOL_POOL_FULL = -2,
    ERR_DRIOBJECTPOOL_INVALID_ID = -3,
    ERR_DRIOBJECTPOOL_EXISTED_ID = -4,
};

template< typename Tp, DWORD size >
class drObjectPool
{
    struct ObjRef 
    {
        Tp obj;
        DWORD ref;
    };

public:
    enum {
        POOL_SIZE = size
    };

protected:
	ObjRef _pool_seq[ POOL_SIZE ];
	DWORD _obj_num;
    DWORD _next_id;

public:
    inline drObjectPool()
        : _obj_num( 0 ), _next_id( 0 )
    {
        memset( _pool_seq, 0, sizeof(ObjRef) * POOL_SIZE );
    }
    inline ~drObjectPool() 
    {}

    DR_RESULT Register( DWORD* ret_id, Tp obj );
	DR_RESULT Register( Tp obj, DWORD id );
	DR_RESULT Unregister( Tp* ret_obj, DWORD id );
    DR_RESULT AddRef( DWORD id, DWORD ref_cnt );
    DR_RESULT GetObj( Tp* ret_obj, DWORD id );
    Tp QueryObj( DWORD id );
    DWORD GetRef( DWORD id );

    DWORD FindObject( Tp obj );
    inline void Clear() 
    { 
        memset(_pool_seq, 0, sizeof(ObjRef) * POOL_SIZE);
        _obj_num = 0;
        _next_id = 0;
    }


    inline int GetObjNum() { return _obj_num; }

};

template< typename Tp, DWORD size >
DR_RESULT drObjectPool< Tp, size>::Register( DWORD* ret_id, Tp obj )
{
    if( _obj_num == POOL_SIZE )
        return ERR_DRIOBJECTPOOL_POOL_FULL;

	for( ; _pool_seq[ _next_id ].ref != 0; _next_id++ ) 
    {
		if( _next_id >= POOL_SIZE )
        {
			_next_id = _next_id % POOL_SIZE;
        }
	}

	DWORD id = _next_id;

	if( ++_next_id == POOL_SIZE )
		_next_id = 0;

	_pool_seq[ id ].obj = obj;
    _pool_seq[ id ].ref = 1;

	_obj_num += 1;

    *ret_id = id;

    return DR_RET_OK;
}

template< typename Tp, DWORD size >
DR_RESULT drObjectPool< Tp, size >::Register( Tp obj, DWORD id )
{
	if( id < 0 || id >= POOL_SIZE )
		return ERR_DRIOBJECTPOOL_INVALID_ID;

	if( _pool_seq[ id ].ref > 0 )
		return ERR_DRIOBJECTPOOL_EXISTED_ID;

	_pool_seq[ id ].obj = obj;
    _pool_seq[ id ].ref = 1;

	_obj_num += 1;

	return 1;
}

template< typename Tp, DWORD size >
DR_RESULT drObjectPool< Tp, size >::Unregister( Tp* ret_obj, DWORD id )
{
    DR_RESULT ret = DR_RET_OK;

	if( id < 0 || id >= POOL_SIZE )
    {
		ret = ERR_DRIOBJECTPOOL_INVALID_ID;
        goto __ret;
    }

    ObjRef* o = &_pool_seq[ id ];

    if( o->ref == 0 ) 
    {
        ret = ERR_DRIOBJECTPOOL_INVALID_ID;
        goto __ret;
    }

	o->ref -= 1;

    if( o->ref == 0 )
    {
        if( ret_obj )
        {
            *ret_obj = o->obj;
        }
        //o->obj = 0;
        _obj_num -= 1;
        _next_id = id;

        ret = DR_RET_OK_1;
    }

__ret:
	return ret;
}

template< typename Tp, DWORD size >
DR_RESULT drObjectPool< Tp, size >::AddRef( DWORD id, DWORD ref_cnt )
{
	if( id < 0 || id >= POOL_SIZE )
		return ERR_DRIOBJECTPOOL_INVALID_ID;

    ObjRef* o = &_pool_seq[ id ];
    if( o->ref == 0 )
        return ERR_DRIOBJECTPOOL_INVALID_ID;

    o->ref += 1;

    return DR_RET_OK;

}

template< typename Tp, DWORD size >
DR_RESULT drObjectPool< Tp, size >::GetObj( Tp* ret_obj, DWORD id )
{
    if( id < 0 || id >= POOL_SIZE )
        return ERR_DRIOBJECTPOOL_INVALID_ID;

    ObjRef* o = &_pool_seq[ id ];

    if( o->ref == 0 )
        return ERR_DRIOBJECTPOOL_INVALID_ID;

    *ret_obj = o->obj;

    return DR_RET_OK;
}

template< typename Tp, DWORD size >
Tp drObjectPool< Tp, size >::QueryObj( DWORD id )
{
    if( id < 0 || id >= POOL_SIZE )
        return ERR_DRIOBJECTPOOL_INVALID_ID;

    ObjRef* o = &_pool_seq[ id ];

    return o->obj;
}


template< typename Tp, DWORD size >
DWORD drObjectPool< Tp, size >::GetRef( DWORD id )
{
	//if( id < 0 || id >= POOL_SIZE )
	//	return ERR_DRIOBJECTPOOL_INVALID_ID;

    return _pool_seq[ id ].ref;

}

template< typename Tp, DWORD size >
DWORD drObjectPool< Tp, size >::FindObject( Tp obj )
{
    for( DWORD i = 0; i < POOL_SIZE; i++ ) 
    {
        if( _pool_seq[ i ].obj == obj ) 
        {
            return i;
        }
    }

    return DR_INVALID_INDEX;
}

typedef drObjectPool< void*, 1024 > drObjectPoolVoidPtr1024;
typedef drObjectPool< void*, 4096 > drObjectPoolVoidPtr4096;
typedef drObjectPool< void*, 10240 > drObjectPoolVoidPtr10240;
typedef drObjectPool< void*, 40960 > drObjectPoolVoidPtr40960;

DR_END
