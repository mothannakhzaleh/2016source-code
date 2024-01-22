#ifndef LEEffectMath_H
#define LEEffectMath_H

#include "LightEngineAPI.h"

#include <string>
#include <math.h>

/// 前置声明
class LEDegree;

/** 给出的角度以弧度为单位的包装类.
@remarks
弧度值和角度值可以相互转换，而且转换会自动进行
*/
class LERadian
{
	float m_fRad;

public:
	explicit LERadian ( float r=0 ) : m_fRad(r) {}
	LERadian ( const LEDegree& d );
	const LERadian& operator = ( const float& f ) { m_fRad = f; return *this; }
	const LERadian& operator = ( const LERadian& r ) { m_fRad = r.m_fRad; return *this; }
	const LERadian& operator = ( const LEDegree& d );

	float valueDegrees() const; 
	float valueRadians() const { return m_fRad; }
	float valueAngleUnits() const;

	LERadian operator + ( const LERadian& r ) const { return LERadian ( m_fRad + r.m_fRad ); }
	LERadian operator + ( const LEDegree& d ) const ;
	LERadian& operator += ( const LERadian& r ) { m_fRad += r.m_fRad; return *this; }
	LERadian& operator += ( const LEDegree& d ) ;
	LERadian operator - () { return LERadian(-m_fRad); }
	LERadian operator - ( const LERadian& r ) const { return LERadian ( m_fRad - r.m_fRad ); }
	LERadian operator - ( const LEDegree& d ) const ;
	LERadian& operator -= ( const LERadian& r ) { m_fRad -= r.m_fRad; return *this; }
	LERadian& operator -= ( const LEDegree& d ) ;
	LERadian operator * ( float f ) const { return LERadian ( m_fRad * f ); }
	LERadian operator * ( const LERadian& f ) const { return LERadian ( m_fRad * f.m_fRad ); }
	LERadian& operator *= ( float f ) { m_fRad *= f; return *this; }
	LERadian operator / ( float f ) const { return LERadian ( m_fRad / f ); }
	LERadian& operator /= ( float f ) { m_fRad /= f; return *this; }

	bool operator <  ( const LERadian& r ) const { return m_fRad <  r.m_fRad; }
	bool operator <= ( const LERadian& r ) const { return m_fRad <= r.m_fRad; }
	bool operator == ( const LERadian& r ) const { return m_fRad == r.m_fRad; }
	bool operator != ( const LERadian& r ) const { return m_fRad != r.m_fRad; }
	bool operator >= ( const LERadian& r ) const { return m_fRad >= r.m_fRad; }
	bool operator >  ( const LERadian& r ) const { return m_fRad >  r.m_fRad; }
};

/** 给出的角度以角度为单位的包装类.
@remarks
弧度值和角度值可以相互转换，而且转换会自动进行
*/
class LEDegree
{
	float m_fDeg; // if you get an error here - make sure to define/typedef 'Real' first

public:
	explicit LEDegree ( float d=0 ) : m_fDeg(d) {}
	LEDegree ( const LERadian& r ) : m_fDeg(r.valueDegrees()) {}
	const LEDegree& operator = ( const float& f ) { m_fDeg = f; return *this; }
	const LEDegree& operator = ( const LEDegree& d ) { m_fDeg = d.m_fDeg; return *this; }
	const LEDegree& operator = ( const LERadian& r ) { m_fDeg = r.valueDegrees(); return *this; }

	float valueDegrees() const { return m_fDeg; }
	float valueRadians() const; 
	float valueAngleUnits() const;

	LEDegree operator + ( const LEDegree& d ) const { return LEDegree ( m_fDeg + d.m_fDeg ); }
	LEDegree operator + ( const LERadian& r ) const { return LEDegree ( m_fDeg + r.valueDegrees() ); }
	LEDegree& operator += ( const LEDegree& d ) { m_fDeg += d.m_fDeg; return *this; }
	LEDegree& operator += ( const LERadian& r ) { m_fDeg += r.valueDegrees(); return *this; }
	LEDegree operator - () { return LEDegree(-m_fDeg); }
	LEDegree operator - ( const LEDegree& d ) const { return LEDegree ( m_fDeg - d.m_fDeg ); }
	LEDegree operator - ( const LERadian& r ) const { return LEDegree ( m_fDeg - r.valueDegrees() ); }
	LEDegree& operator -= ( const LEDegree& d ) { m_fDeg -= d.m_fDeg; return *this; }
	LEDegree& operator -= ( const LERadian& r ) { m_fDeg -= r.valueDegrees(); return *this; }
	LEDegree operator * ( float f ) const { return LEDegree ( m_fDeg * f ); }
	LEDegree operator * ( const LEDegree& f ) const { return LEDegree ( m_fDeg * f.m_fDeg ); }
	LEDegree& operator *= ( float f ) { m_fDeg *= f; return *this; }
	LEDegree operator / ( float f ) const { return LEDegree ( m_fDeg / f ); }
	LEDegree& operator /= ( float f ) { m_fDeg /= f; return *this; }

	bool operator <  ( const LEDegree& d ) const { return m_fDeg <  d.m_fDeg; }
	bool operator <= ( const LEDegree& d ) const { return m_fDeg <= d.m_fDeg; }
	bool operator == ( const LEDegree& d ) const { return m_fDeg == d.m_fDeg; }
	bool operator != ( const LEDegree& d ) const { return m_fDeg != d.m_fDeg; }
	bool operator >= ( const LEDegree& d ) const { return m_fDeg >= d.m_fDeg; }
	bool operator >  ( const LEDegree& d ) const { return m_fDeg >  d.m_fDeg; }
};

// 这些函数不能在LERadian类内定义，因为这些函数需要LEDegree类的定义
inline LERadian::LERadian(const LEDegree& d) : m_fRad(d.valueRadians()) {
}
inline const LERadian& LERadian::operator =(const LEDegree& d) { 
	m_fRad = d.valueRadians(); return *this; 
}
inline LERadian LERadian::operator +(const LEDegree& d) const {
	return LERadian ( m_fRad + d.valueRadians() ); 
}
inline LERadian& LERadian::operator +=(const LEDegree& d) {
	m_fRad += d.valueRadians(); return *this; 
}
inline LERadian LERadian::operator -(const LEDegree& d) const {
	return LERadian ( m_fRad - d.valueRadians() ); 
}
inline LERadian& LERadian::operator -=(const LEDegree& d) { 
	m_fRad -= d.valueRadians(); return *this; 
}


/** 这个类提供公共数学函数的访问.
@remarks
大多数数学函数都是C运行时库函数的别名。这里用别名使将来会提供更
优化的函数成为可能，或根据更快的运行时库或其他自定义数学库
@note
<br>这里是根据MgcMath.h摘自
<a href="http://www.magic-software.com">Wild Magic</a>.
*/
class LIGHTENGINE_API LEEffectMath
{
public:
	/** 角度单位. 这个功能使角度单位能够同时使用上面的角度和弧度制.
	当解析文件时，这个功能将会自动使用。这些用法可查看Angle类
	*/
	enum AngleUnit
	{
		AU_DEGREE,
		AU_RADIAN
	};

protected:
	// API内部使用的角度单位
	static AngleUnit m_sAngleUnit;

	/// 三角函数表由构造函数决定.
	static int m_TrigTableSize;

	/// 弧度值 -> 三角函数表中最小表示弧度 ( m_TrigTableSize / 2 * PI )
	static float m_TrigTableFactor;
	static float* m_SinTable;
	static float* m_TanTable;

	/** 构建三角函数表 （私有）*/
	void buildTrigTables();

	static float SinTable (float fValue);
	static float TanTable (float fValue);

public:        
	/** 默认构造函数.
	@param
		trigTableSize 设置内部使用三角函数表的大小（可选参数）
	*/
	LEEffectMath(unsigned int trigTableSize = 4096);

	/** 默认析构函数.
	*/
	~LEEffectMath();

	static const float POS_INFINITY;
	static const float NEG_INFINITY;
	static const float PI;
	static const float TWO_PI;
	static const float HALF_PI;
	static const float fDeg2Rad;
	static const float fRad2Deg;

/// 角度弧度相关
	static inline float DegreesToRadians(float degrees) { return degrees * fDeg2Rad; }
	static inline float RadiansToDegrees(float radians) { return radians * fRad2Deg; }
	/** 这个函数用于设置整个API使用的角度单位（弧度或角度）	*/
	static void setAngleUnit(AngleUnit unit);
	/** 得到整个API正在使用的角度单位. */
	static AngleUnit getAngleUnit(void);

	/** 将当前的角度单位转换乘弧度. */
	static float AngleUnitsToRadians(float units);
	/** 将弧度转换成当前的角度单位. */
	static float RadiansToAngleUnits(float radians);
	/** 将当前的角度单位转换乘角度. */
	static float AngleUnitsToDegrees(float units);
	/** 将角度转换成当前的角度单位. */
	static float DegreesToAngleUnits(float degrees);

/// 随机数相关
	static float UnitRandom ();  // [0,1]
	static float RangeRandom (float fLow, float fHigh);  // in [fLow,fHigh]

/// 三角函数相关
	/** Sine 函数.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Sin (const LERadian& fValue, bool useTables = false) {
		return (!useTables) ? float(sin(fValue.valueRadians())) : SinTable(fValue.valueRadians());
	}
	/** Sine 函数.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Sin (float fValue, bool useTables = false) {
		return (!useTables) ? float(sin(fValue)) : SinTable(fValue);
	}
	/** Cosine 函数.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Cos (const LERadian& fValue, bool useTables = false) {
		return (!useTables) ? float(cos(fValue.valueRadians())) : SinTable(fValue.valueRadians() + HALF_PI);
	}
	/** Cosine function.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Cos (float fValue, bool useTables = false) {
		return (!useTables) ? float(cos(fValue)) : SinTable(fValue + HALF_PI);
	}
	/** Tangent 函数.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Tan (const LERadian& fValue, bool useTables = false) {
		return (!useTables) ? float(tan(fValue.valueRadians())) : TanTable(fValue.valueRadians());
	}
	/** Tangent function.
	@param
		fValue 角的弧度值
	@param
		useTables 如果为真, 使用查表而不是通过计算，这样会更快但精度降低.
	*/
	static inline float Tan (float fValue, bool useTables = false) {
		return (!useTables) ? float(tan(fValue)) : TanTable(fValue);
	}



};
#endif
