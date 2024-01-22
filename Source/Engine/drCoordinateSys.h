//
#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drClassDecl.h"

DR_BEGIN

struct drCoordInfo
{
    DWORD type;
    drMatrix44 mat;
};

enum drCoordIndex
{
    COORDSYS_0 =            0,
    COORDSYS_1 =            1,
    COORDSYS_2 =            2,
    COORDSYS_3 =            3,
    COORDSYS_4 =            4,
    COORDSYS_5 =            5,
    COORDSYS_6 =            6,
    COORDSYS_7 =            7,

    COORD_SEQ_SIZE =        8,
};

class drCoordinateSys : public drICoordinateSys
{
    DR_STD_DECLARATION();

private:
    DWORD _active_id;
    drMatrix44 _coord_mat_seq[COORD_SEQ_SIZE];

public:
    drCoordinateSys();

    DR_RESULT SetActiveCoordSys(DWORD id);
    DR_RESULT SetCoordSysMatrix(DWORD id, const drMatrix44* mat);
    DR_RESULT GetCoordSysMatrix(DWORD id, drMatrix44* mat);
    DR_RESULT GetCurCoordSysMatrix(drMatrix44* mat);
    DR_RESULT GetActiveCoordSys(DWORD* id);
};


DR_END
