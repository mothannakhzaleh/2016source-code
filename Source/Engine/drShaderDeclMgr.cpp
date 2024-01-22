#include "drShaderDeclMgr.h"

DR_BEGIN

//
DR_STD_ILELEMENTATION( drShaderDeclMgr )


drShaderDeclMgr::drShaderDeclMgr( drIShaderMgr* shader_mgr )
: _shader_mgr( shader_mgr )
{
    memset( _decl_set, 0, sizeof( drShaderDeclSet* ) * SHADER_DECL_NUM );
}

drShaderDeclMgr::~drShaderDeclMgr()
{
    for( DWORD i = 0; i < SHADER_DECL_NUM; i++ )
    {
        DR_SAFE_DELETE( _decl_set[ i ] );
    }
}


DR_RESULT drShaderDeclMgr::CreateShaderDeclSet( DWORD decl_type, DWORD buf_size )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( decl_type < 0 || decl_type >= SHADER_DECL_NUM )
        goto __ret;

    if( _decl_set[ decl_type ] )
        goto __ret;

    _decl_set[ decl_type ] = DR_NEW( drShaderDeclSet( decl_type, buf_size ) );

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drShaderDeclMgr::SetShaderDeclInfo( drShaderDeclCreateInfo* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( info->decl_type < 0 || info->decl_type >= SHADER_DECL_NUM )
        goto __ret;

    if( _decl_set[ info->decl_type ] == NULL )
        goto __ret;

    drShaderDeclSet* s = _decl_set[ info->decl_type ];

	DWORD i = 0;
    for(  i = 0; i < s->decl_num; i++ )
    {
        if( s->decl_seq[ i ].shader_id == DR_INVALID_INDEX )
            break;
    }

    if( i == s->decl_num )
        goto __ret;

    drShaderDeclInfo* d = &s->decl_seq[ i ];
    d->shader_id = info->shader_id;
    d->light_type = info->light_type;
    d->anim_type = info->anim_type;
    _tcsncpy_s( d->file, info->file, _TRUNCATE );

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drShaderDeclMgr::QueryShaderHandle( DWORD* shader_handle, const drShaderDeclQueryInfo* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( info->decl_type < 0 || info->decl_type >= SHADER_DECL_NUM )
        goto __ret;

    if( _decl_set[ info->decl_type ] == NULL )
        goto __ret;

    drShaderDeclInfo* d;
    drShaderDeclSet* s = _decl_set[ info->decl_type ];

	DWORD i = 0;
    for(  i = 0; i < s->decl_num; i++ )
    {
        d = &s->decl_seq[ i ];
        if( (d->light_type == info->light_type) && (d->anim_type == info->anim_type) )
            break;
    }

    if( i == s->decl_num )
        goto __ret;

    *shader_handle = d->shader_id;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_END
