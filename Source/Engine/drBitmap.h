//
#pragma once

#include "drStdInc.h"
#include "drGraphicsUtil.h"

DR_BEGIN


class DR_FRONT_API drBitmap
{
public:
	BITMAPINFOHEADER _bmih;
	drColorValue4b* _buf;

private:
	int _GetData8( BYTE* buf );
    int _GetData16( BYTE* buf );
    int _GetData24( BYTE* buf );
    int _GetData32( BYTE* buf );
	void _SetAlphaChannel( DWORD colorkey_type, drColorValue4b* colorkey );
public:
	drBitmap() :_buf(0) {}
	~drBitmap() { DR_SAFE_DELETE( _buf ); }

	int Load( const char* file, DWORD colorkey_type, drColorValue4b* colorkey );
	drColorValue4b* Detach();
};

DR_END
