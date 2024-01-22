#ifndef _COLOR_
#define _COLOR_

#include "StdHeader.h"

#define ARGB(a,r,g,b) ((DWORD)(((BYTE)(b)|((WORD)((BYTE)(g))<<8))|(((DWORD)(BYTE)(r))<<16)|(((DWORD)(BYTE)(a))<<24)))
#define ARGBNORMAL(a, r, g, b)	(((DWORD)(a*255.0f)<<24)|((DWORD)(r*255.0f)<<16)|((DWORD)(g*255.0f)<<8)|((BYTE)(b*255.0f)))

#define GetB(argb)      ((BYTE)(argb))
#define GetG(argb)      ((BYTE)(((WORD)(argb))>>8))
#define GetR(argb)      ((BYTE)((((DWORD)(argb))>>16) & 0xff))
#define GetA(argb)		((BYTE)(((DWORD)(argb))>>24))

#define NormalValue(a)	(a/255.0f)

#define SetA(argb, a)	((argb & 0x00ffffff)|(((DWORD)(BYTE)(a))<<24))
#define SetB(argb, b)	((argb & 0xffffff00)|((BYTE)(b)))
#define SetG(argb, g)	((argb & 0xffff00ff)|(((BYTE)(g))<<8))
#define SetR(argb, r)	((argb & 0xff00ffff)|(((DWORD)(BYTE)(r))<<16))

#define Alpha(a)		(0x00ffffff | ((BYTE)(a))<<24)

#ifdef __cplusplus
extern "C"
{
#endif

ASE_DLL DWORD __stdcall InVertColor(DWORD color);

// Conversion to 16Bit color
#define RGB555(r, g, b) (((BYTE)(r)>>3)|(((BYTE)(g)>>3)<<5)|(((BYTE)(b)>>3)<<10))
#define RGB565(r, g, b) (((BYTE)(r)>>3)|(((BYTE)(g)>>2)<<5)|(((BYTE)(b)>>3)<<11))
ASE_DLL WORD __stdcall RGB32TORGB555(DWORD color);
ASE_DLL WORD __stdcall RGB32TORGB565(DWORD color);

// Conversion to 32Bit color
ASE_DLL DWORD __stdcall MakeARGB(BYTE a, BYTE r, BYTE g, BYTE b);
ASE_DLL DWORD __stdcall RGB555TORGB32(WORD color);
ASE_DLL DWORD __stdcall RGB565TORGB32(WORD color);

#ifdef __cplusplus
}
#endif

// Conversion between COLORREF and 32Bit color
ASE_DLL DWORD __stdcall MakeARGB(BYTE a, COLORREF color);
ASE_DLL COLORREF __stdcall TORGB(DWORD color);

#endif // _COLOR

