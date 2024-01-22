#include "Color.h"

// Conversion to 16Bit color
ASINLINE WORD __stdcall RGB32TORGB555(DWORD color)
{
	BYTE r = (BYTE)((color>>16) & 0xff);
	BYTE g = (BYTE)((color>>8) & 0xff);
	BYTE b = (BYTE)((color) & 0xff);

	return ((r & 0xf8)<<7) | ((g & 0xf8)<<2) | ((b & 0xf8)>>3);
}

ASINLINE WORD __stdcall RGB32TORGB565(DWORD color)
{
	BYTE r = (BYTE)((color>>16) & 0xff);
	BYTE g = (BYTE)((color>>8) & 0xff);
	BYTE b = (BYTE)((color) & 0xff);

	return ((r & 0xf8)<<8) | ((g & 0xfc)<<3) | ((b & 0xf8)>>3);
}

// Conversion to 32Bit color
ASINLINE DWORD __stdcall MakeARGB(BYTE a, BYTE r, BYTE g, BYTE b)
{
	return (DWORD)((a<<24) | (r<<16) | (g<<8) | b);
}

ASINLINE DWORD __stdcall RGB555TORGB32(WORD color)
{
	BYTE r = (BYTE)((color>>7)&0xf8);
	BYTE g = (BYTE)((color>>2)&0xf8);
	BYTE b = (BYTE)((color<<3)&0xf8);

	return (DWORD)(0xff000000 | (r<<16) | (g<<8) | b);
}

ASINLINE DWORD __stdcall RGB565TORGB32(WORD color)
{
	BYTE r = (BYTE)((color>>8)&0xf8);
	BYTE g = (BYTE)((color>>3)&0xf8);
	BYTE b = (BYTE)((color<<3)&0xf8);

	return (DWORD)(0xff000000 | (r<<16) | (g<<8) | b);
}

// Conversion between COLORREF and 32Bit color
ASINLINE DWORD __stdcall MakeARGB(BYTE a, COLORREF color)
{
	return (a<<24)|(((BYTE)(color))<<16)|(color & 0x0000ff00)|((BYTE)(color>>16));
}

ASINLINE COLORREF __stdcall TORGB(DWORD color)
{
	return (color & 0x0000ff00)|(((BYTE)(color))<<16)|((BYTE)(color>>16));
}

ASINLINE DWORD __stdcall InVertColor(DWORD color)
{
	return SetA((0xffffffff - color), 0xff);
}
