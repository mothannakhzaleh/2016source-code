//


#include "drCoordinateSys.h"

DR_BEGIN

DR_STD_ILELEMENTATION(drCoordinateSys)

drCoordinateSys::drCoordinateSys()
{
    _active_id = 0;

    for(DWORD i = 0; i < COORD_SEQ_SIZE; i++)
    {
        drMatrix44Identity(&_coord_mat_seq[i]);
    }
}


DR_RESULT drCoordinateSys::SetActiveCoordSys(DWORD id)
{
    if(id >= COORD_SEQ_SIZE)
        return DR_RET_FAILED;

    _active_id = id;

    return DR_RET_OK;
}

DR_RESULT drCoordinateSys::SetCoordSysMatrix(DWORD id, const drMatrix44* mat)
{
    if(id >= COORD_SEQ_SIZE || mat == 0)
        return DR_RET_FAILED;

    _coord_mat_seq[id] = *mat;

    return DR_RET_OK;
}

DR_RESULT drCoordinateSys::GetCoordSysMatrix(DWORD id, drMatrix44* mat)
{
    if(id >= COORD_SEQ_SIZE || mat == 0)
        return DR_RET_FAILED;

    *mat = _coord_mat_seq[id];

    return DR_RET_OK;
}
DR_RESULT drCoordinateSys::GetCurCoordSysMatrix(drMatrix44* mat)
{
    *mat = _coord_mat_seq[_active_id];
    return DR_RET_OK;
}
DR_RESULT drCoordinateSys::GetActiveCoordSys(DWORD* id)
{
    *id = _active_id;
    return DR_RET_OK;
}

DR_END
