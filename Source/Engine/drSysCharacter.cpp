//
#include "drSysCharacter.h"
#include "drPhysique.h"

DR_BEGIN

drSysCharacter::drSysCharacter()
{
    _pool_skeleton = DR_NEW( drObjectPoolSkeleton );
    _pool_skinmesh = DR_NEW( drObjectPoolSkin );
}

drSysCharacter::~drSysCharacter()
{
    DR_SAFE_DELETE( _pool_skeleton );
    DR_SAFE_DELETE( _pool_skinmesh );
}


DR_RESULT drSysCharacter::QuerySkeleton( DWORD* ret_id, const char* file )
{
    //DWORD pool_num = drObjectPoolSkeleton::POOL_SIZE;
    //drSkeleton* sk;
    //for( int i = 0; i < drObjectPoolSkeleton::POOL_SIZE; i++ )
    //{
    //    if( _pool_skeleton->GetObj( i ) 
    //}
    //if( param.id != DR_INVALID_INDEX )
    //{
    //    *ret_id = param.id;
    //}
    //else
    //{
    //}

    return DR_RET_OK;
}

DR_END
