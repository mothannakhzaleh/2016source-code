//
#pragma once

#include <tchar.h>
#include <shlobj.h>
#include <olectl.h>
//#include <windows.h>

#include "drutilsexp.h"
///////////////////////////////////

/////////////////

DRUTILS_API char* drGetModuleFilePath( char* buf ); // buf size need be more than 256 byte
DRUTILS_API char* drGetModuleBaseFileName( char* buf ); // exclude extension

DRUTILS_API char* drGetPathFileName( char* buf, const char* path );
DRUTILS_API char* drGetPathFileNameBase( char* buf, const char* path); // return name exclude ext name
DRUTILS_API char* drGetPathFileNameExt( char* buf,const char* path); // return extension name of file name

DRUTILS_API char* drGetPathFilePath( char* buf, const char* path );
DRUTILS_API char* drGetPathSubPath( char* sub_path, const char* path, const char* compare_path );

// get sub_name of indexed file(et. test00 -->sub_name : test )
// pri_name[out]: return value, file[in]: name, id_len[in]: index character length(test00 id_len = 2)
DRUTILS_API char* drGetIndexFileName( char* pri_name, const char* file, int id_len ); 

int DRUTILS_API drGetOpenFileName(HWND hwnd,
                               char* buf,int num,
                               const char* dir,
                               const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0",
                               int flag = OFN_PATHMUSTEXIST | 
                               OFN_EXPLORER 
                               //OFN_FILEMUSTEXIST | 
                               //OFN_ALLOWMULTISELECT |
                               //OFN_HIDEREADONLY
                               );

int DRUTILS_API drGetSaveFileName(HWND hwnd,char* buf,int num,
                               const char* dir,
                               const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0",
                               const char* ext = 0,
                               int flag = OFN_PATHMUSTEXIST | 
                               OFN_EXPLORER 
                               //OFN_FILEMUSTEXIST | 
                               //OFN_ALLOWMULTISELECT |
                               //OFN_HIDEREADONLY
                               );

int DRUTILS_API drGetFolderName(char *folder, HWND hwnd,const char *title,LPITEMIDLIST pid_root=0);

HBITMAP DRUTILS_API LoadBitmapFile(const char* file);
OLE_HANDLE DRUTILS_API LoadImageFile(const char* file);


//