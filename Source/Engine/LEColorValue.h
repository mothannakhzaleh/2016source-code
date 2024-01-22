#ifndef LEColorValue_H
#define LEColorValue_H

#include "LightEngineAPI.h"
#include <assert.h>

typedef unsigned int RGBA;
typedef unsigned int ARGB;
typedef unsigned int ABGR;

/** 表示颜色的类.
@remarks
	颜色由4个成员组成，每一个成员都是由0.0到1.0的浮点数组成
*/
class LIGHTENGINE_API LEColorValue
{
public:
	static LEColorValue Black;
	static LEColorValue White;
	static LEColorValue Red;
	static LEColorValue Green;
	static LEColorValue Blue;

	explicit LEColorValue(float red = 1.0f, float green = 1.0f,
						  float blue = 1.0f,float alpha = 1.0f ) 
		: r(red), g(green), b(blue), a(alpha)
	{ }

	bool operator==(const LEColorValue& rhs) const;
	bool operator!=(const LEColorValue& rhs) const;

	union {
		struct {
			float r,g,b,a;
		};
		float val[4];
	};

	/** 以RGBA形式返回颜色.
	*/
	RGBA getAsRGBA(void) const;

	/** 以ARGB形式返回颜色.
	*/
	ARGB getAsARGB(void) const;

	/** 以ABGR形式返回颜色 */
	ABGR getAsABGR(void) const;

	/** 以RGBA形式设置颜色.
	*/
	void setAsRGBA(const RGBA val);

	/** 以ARGB形式设置颜色.
	*/
	void setAsARGB(const ARGB val);

	/** 以ABGR形式设置颜色.
	*/
	void setAsABGR(const ABGR val);

	// 一元数学操作
	inline LEColorValue& operator += ( const LEColorValue& rkVector )
	{
		r += rkVector.r;
		g += rkVector.g;
		b += rkVector.b;
		a += rkVector.a;

		return *this;
	}

	inline LEColorValue& operator -= ( const LEColorValue& rkVector )
	{
		r -= rkVector.r;
		g -= rkVector.g;
		b -= rkVector.b;
		a -= rkVector.a;

		return *this;
	}

	inline LEColorValue& operator *= (const float fScalar )
	{
		r *= fScalar;
		g *= fScalar;
		b *= fScalar;
		a *= fScalar;
		return *this;
	}

	inline LEColorValue& operator /= (const float fScalar )
	{
		assert( fScalar != 0.0f );

		float fInv = 1.0f / fScalar;

		r *= fInv;
		g *= fInv;
		b *= fInv;
		a *= fInv;

		return *this;
	}

	inline LEColorValue& operator /= (const LEColorValue& rkVector )
	{
		r /= rkVector.r;
		g /= rkVector.g;
		b /= rkVector.b;
		a /= rkVector.a;

		return *this;
	}
};

//=============================================================================
// 二元数学操作
//=============================================================================
inline const LEColorValue operator +(const LEColorValue& lhs, const LEColorValue& rhs)
{
	LEColorValue kSum;

	kSum.r = lhs.r + rhs.r;
	kSum.g = lhs.g + rhs.g;
	kSum.b = lhs.b + rhs.b;
	kSum.a = lhs.a + rhs.a;

	return kSum;
}
//-----------------------------------------------------------------------------
inline const LEColorValue operator -(const LEColorValue& lhs, const LEColorValue& rhs)
{
	LEColorValue kDiff;

	kDiff.r = lhs.r - rhs.r;
	kDiff.g = lhs.g - rhs.g;
	kDiff.b = lhs.b - rhs.b;
	kDiff.a = lhs.a - rhs.a;

	return kDiff;
}
//-----------------------------------------------------------------------------
inline const LEColorValue operator *(const float fScalar, const LEColorValue& rhs)
{
	LEColorValue kProd;

	kProd.r = fScalar*rhs.r;
	kProd.g = fScalar*rhs.g;
	kProd.b = fScalar*rhs.b;
	kProd.a = fScalar*rhs.a;

	return kProd;
}
//-----------------------------------------------------------------------------
inline const LEColorValue operator *(const LEColorValue& lhs, const float fScalar)
{
	return (fScalar * lhs);
}
//-----------------------------------------------------------------------------
inline const LEColorValue operator *(const LEColorValue& lhs, const LEColorValue& rhs)
{
	LEColorValue kProd;

	kProd.r = lhs.r * rhs.r;
	kProd.g = lhs.g * rhs.g;
	kProd.b = lhs.b * rhs.b;
	kProd.a = lhs.a * rhs.a;

	return kProd;
}
//-----------------------------------------------------------------------------
inline const LEColorValue operator /(const LEColorValue& lhs, const LEColorValue& rhs)
{
	LEColorValue kProd;

	kProd.r = lhs.r / rhs.r;
	kProd.g = lhs.g / rhs.g;
	kProd.b = lhs.b / rhs.b;
	kProd.a = lhs.a / rhs.a;

	return kProd;
}
//-----------------------------------------------------------------------------
inline LEColorValue operator /(const LEColorValue& lhs, const float fScalar )
{
	assert( fScalar != 0.0f );

	LEColorValue kDiv;

	float fInv = 1.0f / fScalar;
	kDiv.r = lhs.r * fInv;
	kDiv.g = lhs.g * fInv;
	kDiv.b = lhs.b * fInv;
	kDiv.a = lhs.a * fInv;

	return kDiv;
}

#endif