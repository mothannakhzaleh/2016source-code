#include "LEColorValue.h"

//-----------------------------------------------------------------------------
LEColorValue LEColorValue::Black = LEColorValue(0.0,0.0,0.0);
LEColorValue LEColorValue::White = LEColorValue(1.0,1.0,1.0);
LEColorValue LEColorValue::Red = LEColorValue(1.0,0.0,0.0);
LEColorValue LEColorValue::Green = LEColorValue(0.0,1.0,0.0);
LEColorValue LEColorValue::Blue = LEColorValue(0.0,0.0,1.0);
//-----------------------------------------------------------------------------
RGBA LEColorValue::getAsRGBA(void) const
{
	unsigned char val8;
	unsigned int  val32 = 0;

	// 转换成32位模式
	// (RGBA = 8888)

	// Red
	val8 = static_cast<unsigned char>(r * 255);
	val32 = val8 << 24;

	// Green
	val8 = static_cast<unsigned char>(g * 255);
	val32 += val8 << 16;

	// Blue
	val8 = static_cast<unsigned char>(b * 255);
	val32 += val8 << 8;

	// Alpha
	val8 = static_cast<unsigned char>(a * 255);
	val32 += val8;

	return val32;
}
//-----------------------------------------------------------------------------
ARGB LEColorValue::getAsARGB(void) const
{
	unsigned char val8;
	unsigned int val32 = 0;

	// 转换成32位模式
	// (ARGB = 8888)

	// Alpha
	val8 = static_cast<unsigned char>(a * 255);
	val32 = val8 << 24;

	// Red
	val8 = static_cast<unsigned char>(r * 255);
	val32 += val8 << 16;

	// Green
	val8 = static_cast<unsigned char>(g * 255);
	val32 += val8 << 8;

	// Blue
	val8 = static_cast<unsigned char>(b * 255);
	val32 += val8;


	return val32;
}
//-----------------------------------------------------------------------------
ABGR LEColorValue::getAsABGR(void) const
{
	unsigned char val8;
	unsigned int  val32 = 0;

	// 转换成32位模式
	// (ABRG = 8888)

	// Alpha
	val8 = static_cast<unsigned char>(a * 255);
	val32 = val8 << 24;

	// Blue
	val8 = static_cast<unsigned char>(b * 255);
	val32 += val8 << 16;

	// Green
	val8 = static_cast<unsigned char>(g * 255);
	val32 += val8 << 8;

	// Red
	val8 = static_cast<unsigned char>(r * 255);
	val32 += val8;


	return val32;
}
//-----------------------------------------------------------------------------
void LEColorValue::setAsRGBA(const RGBA val)
{
	unsigned int val32 = val;

	// 从32位模式转换回来
	// (RGBA = 8888)

	// Red
	r = static_cast<unsigned char>(val32 >> 24) / 255.0f;

	// Green
	g = static_cast<unsigned char>(val32 >> 16) / 255.0f;

	// Blue
	b = static_cast<unsigned char>(val32 >> 8) / 255.0f;

	// Alpha
	a = static_cast<unsigned char>(val32) / 255.0f;
}
//-----------------------------------------------------------------------------
void LEColorValue::setAsARGB(const ARGB val)
{
	unsigned int val32 = val;

	// 从32位模式转换回来
	// (ARGB = 8888)

	// Alpha
	a = static_cast<unsigned char>(val32 >> 24) / 255.0f;

	// Red
	r = static_cast<unsigned char>(val32 >> 16) / 255.0f;

	// Green
	g = static_cast<unsigned char>(val32 >> 8) / 255.0f;

	// Blue
	b = static_cast<unsigned char>(val32) / 255.0f;
}
//-----------------------------------------------------------------------------
void LEColorValue::setAsABGR(const ABGR val)
{
	unsigned int val32 = val;

	// 从32位模式转换回来
	// (ABGR = 8888)

	// Alpha
	a = static_cast<unsigned char>(val32 >> 24) / 255.0f;

	// Blue
	b = static_cast<unsigned char>(val32 >> 16) / 255.0f;

	// Green
	g = static_cast<unsigned char>(val32 >> 8) / 255.0f;

	// Red
	r = static_cast<unsigned char>(val32) / 255.0f;
}
//-----------------------------------------------------------------------------
bool LEColorValue::operator==(const LEColorValue& rhs) const
{
	return (r == rhs.r &&
		g == rhs.g &&
		b == rhs.b &&
		a == rhs.a);
}
//-----------------------------------------------------------------------------
bool LEColorValue::operator!=(const LEColorValue& rhs) const
{
	return !(*this == rhs);
}

