//
#pragma once

#define DR_NAMESPACE            LightEngine
#define DR_BEGIN                namespace DR_NAMESPACE {
#define DR_END                  }
#define DR_USING                using namespace DR_NAMESPACE;


#define DR_MAX_PATH             260
#define DR_MAX_FILE             128
#define DR_MAX_NAME             64
#define DR_MAX_STRING           256
#define DR_CHAR_16              16
#define DR_CHAR_32              32

#define DR_MALLOC(obj)          _ALLOC(obj)
#define DR_REALLOC(p, obj)      realloc(p, obj)
#define DR_FREE(obj)            _FREE(obj)
#define DR_NEW(obj)             new obj
#define DR_DELETE(obj)          delete obj
#define DR_DELETE_A(obj)        delete [] obj
#define DR_RELEASE(obj)         (obj)->Release()

#ifndef DR_SAFE_FREE
#define DR_SAFE_FREE(obj) \
    { \
    if(obj) { \
        DR_FREE(obj); \
        obj = 0; \
    } \
    }
#endif

#ifndef DR_IF_FREE
#define DR_IF_FREE(obj) \
    if(obj) { \
        DR_FREE(obj); \
    }
#endif


#ifndef DR_SAFE_DELETE
#define DR_SAFE_DELETE(obj) \
    if( obj ) { \
        DR_DELETE(obj); \
        obj = 0; \
    }
#endif

#ifndef DR_IF_DELETE
#define DR_IF_DELETE(obj) \
    if(obj) { \
        DR_DELETE(obj); \
    }
#endif

#ifndef DR_SAFE_DELETE_A
#define DR_SAFE_DELETE_A(obj) \
    if( obj ) { \
        DR_DELETE_A(obj); \
        obj = 0; \
    }
#endif

#ifndef DR_IF_DELETE_A
#define DR_IF_DELETE_A(obj) \
    if(obj) { \
        DR_DELETE_A(obj); \
    }
#endif

#ifndef DR_SAFE_RELEASE
#define DR_SAFE_RELEASE(obj) \
    { \
    if(obj) { \
        DR_RELEASE(obj); \
        obj = 0; \
    } \
    }
#endif

#ifndef DR_IF_RELEASE
#define DR_IF_RELEASE(obj) \
    if(obj) { \
        DR_RELEASE(obj); \
    }
#endif

#define DR_SIMPLE_IF_GET(dst, src) if(dst) { *dst = src; }

#define DR_SUCCEEDED_RET(code) if(DR_SUCCEEDED(code)) { goto __ret; }
#define DR_FAILED_RET(code) if(DR_FAILED(code)) { goto __ret; }
#define DR_ZERO_RET(code) if((code) == 0) { goto __ret; }


#define DR_INVALID_INDEX		0xffffffff
#define DR_INVALID_HANDLE       DR_INVALID_INDEX

typedef void DR_VOID;
typedef char DR_CHAR;
typedef int DR_BOOL;
typedef long DR_LONG;
typedef unsigned long DR_ULONG;
typedef __int64 DR_INT64;
typedef DR_LONG DR_RESULT;
typedef DR_ULONG DR_DWORD;
typedef DR_ULONG DR_HANDLE;

// ===================
typedef char lxi8;
typedef short lxi16;
typedef int lxi32;
typedef __int64 lxi64;
typedef unsigned char lxu8;
typedef unsigned short lxu16;
typedef unsigned int lxu32;
typedef unsigned __int64 lxu64; // ???
typedef float lxf32;
typedef double lxf64;
typedef void lxvoid;
typedef lxu32 lxdword;
typedef lxi32 lxresult;
typedef lxi32 lxhandle;
// end

#define DR_INLINE __forceinline
#define DR_DECLSPEC_NOVTABLE __declspec( novtable )
#define PURE_METHOD = 0
//#define DR_DECLSPEC_NOVTABLE

#define DR_NULL                 0
#define DR_MAKEINT64( l, h ) ( (DR_INT64)( ((DR_DWORD)l) | (((DR_DWORD)h) << 32)) )
#define DR_LODWORD( i ) ( (DR_DWORD)( ((DR_INT64)i) & 0x0000ffff ) )
#define DR_HIDWORD( i ) ( (DR_DWORD)( (DR_DWORD)(((DR_INT64)i) >> 32) & 0xffff) )

#define DR_ALIGN(adrs, bytes) (((UINT)adrs + ((bytes)-1)) & (~((bytes)-1)))
#define DR_ARRAY_LENGTH(buf) (sizeof(buf) / sizeof(buf[0]))

#define DR_RET_OK           0
#define DR_RET_FAILED       -1

#pragma warning(disable: 4293)
