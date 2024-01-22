//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterfaceExt.h"
#include "drExpObj.h"

DR_BEGIN

class DR_FRONT_API drEfxTrack
{
private:
    drAnimDataMatrix* _data;

public:
    drEfxTrack();
    ~drEfxTrack();

    void SetData(drAnimDataMatrix* data) { _data = data; }
    drAnimDataMatrix* GetData() { return _data; }

    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file);
};

DR_END
