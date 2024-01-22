//

#include "drEfxTrack.h"

DR_BEGIN

drEfxTrack::drEfxTrack()
{
    _data = 0;
}
drEfxTrack::~drEfxTrack()
{
    DR_SAFE_RELEASE(_data);
}


DR_RESULT drEfxTrack::Load(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp ==NULL)
        return DR_RET_FAILED;

    _data = DR_NEW(drAnimDataMatrix());
    _data->Load(fp, 0);

    fclose(fp);

    return DR_RET_OK;
}
DR_RESULT drEfxTrack::Save(const char* file)
{
    FILE* fp;
	fopen_s( &fp, file, "wb");
    if(fp ==NULL)
        return DR_RET_FAILED;

    _data->Save(fp);

    fclose(fp);

    return DR_RET_OK;
}

DR_END
