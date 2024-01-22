//
#pragma once

#include "drHeader.h"
#include "drErrorCode.h"

#include "drFrontAPI.h"

DR_BEGIN

//struct drGUID
//{
//    union {
//        struct {
//            DR_DWORD id;
//            DR_DWORD data;
//        };
//
//        DR_INT64 guid;
//    };
//};
typedef DR_INT64 drGUID;

DR_FRONT_API DR_RESULT drGUIDCreateObject(DR_VOID** obj, drGUID guid);
#define drCreateObjectGUID drGUIDCreateObject

const drGUID DR_GUID_SYSTEM =               DR_MAKEINT64(0, 1);
const drGUID DR_GUID_SYSGRAPHICS =          DR_MAKEINT64(1, 0);
const drGUID DR_GUID_DEVICEOBJECT =         DR_MAKEINT64(2, 0);
const drGUID DR_GUID_RESOURCEMGR =          DR_MAKEINT64(3, 0);
const drGUID DR_GUID_DYNAMICSTREAMMGR =     DR_MAKEINT64(4, 1);

const drGUID DR_GUID_ANIMCTRLBONE =         DR_MAKEINT64(10, 0);
const drGUID DR_GUID_PATHINFO =             DR_MAKEINT64(11, 0);
const drGUID DR_GUID_POSECTRL =             DR_MAKEINT64(12, 0);
const drGUID DR_GUID_ANIMDATABONE =         DR_MAKEINT64(13, 0);
const drGUID DR_GUID_ANIMDATAMATRIX =       DR_MAKEINT64(14, 0);
const drGUID DR_GUID_HELPERDUMMY =          DR_MAKEINT64(15, 0);
const drGUID DR_GUID_HELPERBOX =            DR_MAKEINT64(16, 0);
const drGUID DR_GUID_HELPERMESH =           DR_MAKEINT64(17, 0);
const drGUID DR_GUID_ACTIONSMITH =          DR_MAKEINT64(21, 0);
const drGUID DR_GUID_ANIMDATATEXUV =        DR_MAKEINT64(22, 0);
const drGUID DR_GUID_MESHINFO =             DR_MAKEINT64(23, 0);
const drGUID DR_GUID_OPTIONMGR =            DR_MAKEINT64(24, 0);
const drGUID DR_GUID_ANIMKEYSETPRS =        DR_MAKEINT64(25, 0);
const drGUID DR_GUID_ANIMKEYSETFLOAT =      DR_MAKEINT64(26, 0);
const drGUID DR_GUID_TREENODE =             DR_MAKEINT64(27, 0);
const drGUID DR_GUID_RENDERSTATEATOMSET =   DR_MAKEINT64(28, 0);
const drGUID DR_GUID_TIMER =                DR_MAKEINT64(29, 0);
const drGUID DR_GUID_TIMERTHREAD =          DR_MAKEINT64(30, 0);
const drGUID DR_GUID_TIMERPERIOD =          DR_MAKEINT64(31, 0);
const drGUID DR_GUID_FILE =                 DR_MAKEINT64(32, 0);
const drGUID DR_GUID_FILEDIALOG =           DR_MAKEINT64(33, 0);
const drGUID DR_GUID_FILESTREAM =           DR_MAKEINT64(34, 0);
const drGUID DR_GUID_DDSFILE =              DR_MAKEINT64(35, 0);
const drGUID DR_GUID_DIRECTORYBROWSER =     DR_MAKEINT64(36, 0);
const drGUID DR_GUID_CONSOLE =              DR_MAKEINT64(37, 0);
const drGUID DR_GUID_THREADPOOL =           DR_MAKEINT64(38, 0);
const drGUID DR_GUID_TEXTFILELOADER =       DR_MAKEINT64(39, 0);
const drGUID DR_GUID_GEOMOBJINFO =          DR_MAKEINT64(40, 0);
const drGUID DR_GUID_MODELOBJINFO =         DR_MAKEINT64(41, 0);
const drGUID DR_GUID_SYSTEMINFO =           DR_MAKEINT64(42, 0);
const drGUID DR_GUID_BUFFER =               DR_MAKEINT64(43, 0);
const drGUID DR_GUID_HEAP =                 DR_MAKEINT64(44, 0);



const DR_DWORD DR_GUID_NUM = 99;

DR_END
