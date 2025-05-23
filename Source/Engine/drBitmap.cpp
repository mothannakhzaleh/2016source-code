//
#include "drBitmap.h"

DR_BEGIN

int drBitmap::Load( const char* file, DWORD colorkey_type, drColorValue4b* colorkey )
{

	// load data
    FILE *fp;
	fopen_s( &fp, file, "rb" );
    if( fp == 0 )
        return 0;
    
    fseek( fp, 0, SEEK_END );
    long size = ftell( fp );
    BYTE* buf = DR_NEW( BYTE[ size ] );

	fseek( fp, 0, SEEK_SET );
	fread( buf, size, 1, fp );

    fclose( fp );

	// .    
    memcpy( &_bmih, buf + sizeof(BITMAPFILEHEADER), sizeof(BITMAPINFOHEADER) );

	if( _bmih.biBitCount < 8 )
		return 0;    

	_buf = DR_NEW( drColorValue4b[ _bmih.biWidth * _bmih.biHeight ] );

	switch( _bmih.biBitCount ) {
	case 8:
		_GetData8( buf );
		break;
	case 16:
        _GetData16( buf );
		break;
	case 24:
        _GetData24( buf );
		break;
	case 32:
        _GetData32( buf );
		break;
	}

    _SetAlphaChannel( colorkey_type, colorkey );

	DR_DELETE_A( buf );

	return 1;
}

drColorValue4b* drBitmap::Detach()
{
	drColorValue4b* ret = _buf;
	_buf = 0;

	return ret;
}

int drBitmap::_GetData8( BYTE* buf )
{
	BITMAPFILEHEADER *bfi = (BITMAPFILEHEADER*)buf;

	BYTE* data = buf + bfi->bfOffBits;

	BYTE* plane = buf + sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

    drColorValue4b* dst;
	for( int i=0; i<_bmih.biHeight; i++ ) 
    {
		for( int j=0; j<_bmih.biWidth; j++ ) 
        {
			int src_index = ( _bmih.biHeight - i - 1 ) * _bmih.biWidth + j;
			int dst_index = i * _bmih.biWidth + j;
			int plane_id = 4 * data[ src_index ];

            dst = &_buf[dst_index];
			dst->b = plane[ plane_id ];
			dst->g = plane[ plane_id + 1 ];
			dst->r = plane[ plane_id + 2 ];
            dst->a = 255;
		}
	}

	
	return 1;
}

int drBitmap::_GetData16( BYTE* buf )
{
	BITMAPFILEHEADER* bfi = (BITMAPFILEHEADER*)buf;

	WORD* data = (WORD*)(buf + bfi->bfOffBits);
    WORD v;

    int g_bit = 5;
    // check rgb mode 555 or 565
    if( _bmih.biCompression == BI_RGB )
        g_bit = 5;
    else if( _bmih.biCompression == BI_BITFIELDS ) 
    {
        g_bit = 5;
    }
        
    drColorValue4b* dst;
	for( int i=0; i<_bmih.biHeight; i++ ) 
    {
		for( int j=0; j<_bmih.biWidth; j++ ) 
        {
			int src_index = ( _bmih.biHeight - i - 1 ) * _bmih.biWidth + j;
			int dst_index = i * _bmih.biWidth + j;

            v = data[src_index];

            dst = &_buf[dst_index];

            if( g_bit == 5 ) 
            {
                dst->b = DR_RGB555_B( v );
                dst->g = DR_RGB555_G( v );
                dst->r = DR_RGB555_R( v );
            }
            else 
            {
                dst->b = DR_RGB565_B( v );
                dst->g = DR_RGB565_G( v );
                dst->r = DR_RGB565_R( v );
            }

            dst->a = 255;
		}
	}

    return 1;
}
int drBitmap::_GetData24( BYTE* buf )
{
	BITMAPFILEHEADER* bfi = (BITMAPFILEHEADER*)buf;

	BYTE* data = buf + bfi->bfOffBits;

    drColorValue4b* dst;

	for( int i=0; i<_bmih.biHeight; i++ ) 
    {
		for( int j=0; j<_bmih.biWidth; j++ ) 
        {
			int src_index = 3 * (( _bmih.biHeight - i - 1 ) * _bmih.biWidth + j);
			int dst_index = i * _bmih.biWidth + j;

            dst = &_buf[dst_index];
            dst->b = data[src_index];
            dst->g = data[src_index+1];
            dst->r = data[src_index+2];
            dst->a = 255;
		}
	}

    return 1;
}

int drBitmap::_GetData32( BYTE* buf )
{
	BITMAPFILEHEADER* bfi = (BITMAPFILEHEADER*)buf;

	DWORD* data = (DWORD*)(buf + bfi->bfOffBits);
    DWORD v;

    drColorValue4b* dst;

	for( int i=0; i<_bmih.biHeight; i++ ) 
    {
		for( int j=0; j<_bmih.biWidth; j++ ) 
        {
			int src_index = ( _bmih.biHeight - i - 1 ) * _bmih.biWidth + j;
			int dst_index = i * _bmih.biWidth + j;

            v = data[src_index];

            dst = &_buf[dst_index];
            dst->b = (BYTE)(v & 0xff);
            dst->g = (BYTE)((v & 0xff00) >> 8);
            dst->r = (BYTE)((v & 0xff0000) >> 16);
            dst->a = 255;
		}
	}

    return 1;
}

void drBitmap::_SetAlphaChannel( DWORD colorkey_type, drColorValue4b* colorkey )
{
    if(colorkey_type == COLORKEY_TYPE_NONE)
        return;

    DWORD buf_num = _bmih.biWidth * _bmih.biHeight;

    drColorValue4b* dst;

    for( DWORD i = 0; i < buf_num; i++ )
    {
        dst = &_buf[i];

        if(colorkey_type == COLORKEY_TYPE_COLOR)
        {
            if(dst->r == colorkey->r && dst->g == colorkey->g && dst->b == colorkey->b)
            {
                dst->color = 0x00000000;
            }
        }
        else if(colorkey_type == COLORKEY_TYPE_PIXEL)
        {
            if(dst->r == _buf->r && dst->g == _buf->g && dst->b == _buf->b) 
            {
                dst->color = 0x00000000;
            }
        }
    }
}


DR_END
