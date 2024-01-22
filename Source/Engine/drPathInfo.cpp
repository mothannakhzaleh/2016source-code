//
#include "drPathInfo.h"
#include "drStdInc.h"

DR_BEGIN

DR_STD_ILELEMENTATION( drPathInfo )

drPathInfo::drPathInfo()
{
    memset( _path_buf, 0, sizeof( char ) * PATH_TYPE_NUM * DR_MAX_PATH );
}

char* drPathInfo::SetPath( DWORD type, const char* path )
{
    _tcsncpy_s( _path_buf[ type ], path, _TRUNCATE );
	return _path_buf[type];
}

char* drPathInfo::GetPath( DWORD type )
{
    return _path_buf[ type ];
}

// drOptionMgr
DR_STD_ILELEMENTATION(drOptionMgr)

drOptionMgr::drOptionMgr()
{
    memset(_byte_flag_seq, 0, sizeof(_byte_flag_seq));

    _ignore_model_tex_flag = 0;
}
drOptionMgr::~drOptionMgr()
{
}



DR_END
