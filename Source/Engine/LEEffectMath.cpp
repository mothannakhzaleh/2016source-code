#include "LEEffectMath.h"

#include <math.h>
#include <limits>
#include "LEEffectAsmMath.h"

//=============================================================================
// LERadian
//-----------------------------------------------------------------------------
float LERadian::valueDegrees() const
{
	return LEEffectMath::RadiansToDegrees (m_fRad);
}
//-------------------------------------------------------------------------
float LERadian::valueAngleUnits() const
{
	return LEEffectMath::RadiansToAngleUnits (m_fRad);

}
//=============================================================================
// LEDegree
//-----------------------------------------------------------------------------
float LEDegree::valueRadians() const
{
	return LEEffectMath::DegreesToRadians(m_fDeg);
}
//-------------------------------------------------------------------------
float LEDegree::valueAngleUnits() const
{
	return LEEffectMath::DegreesToAngleUnits(m_fDeg);
}
//=============================================================================
// LEEffectMath
//-----------------------------------------------------------------------------
const float LEEffectMath::POS_INFINITY = std::numeric_limits<float>::infinity();
const float LEEffectMath::NEG_INFINITY = -std::numeric_limits<float>::infinity();
const float LEEffectMath::PI = float( 4.0 * atan( 1.0 ) );
const float LEEffectMath::TWO_PI = float( 2.0 * PI );
const float LEEffectMath::HALF_PI = float( 0.5 * PI );
const float LEEffectMath::fDeg2Rad = PI / float(180.0);
const float LEEffectMath::fRad2Deg = float(180.0) / PI;

int LEEffectMath::m_TrigTableSize;
LEEffectMath::AngleUnit LEEffectMath::m_sAngleUnit;

float  LEEffectMath::m_TrigTableFactor;
float *LEEffectMath::m_SinTable = 0;
float *LEEffectMath::m_TanTable = 0;

//-----------------------------------------------------------------------------
LEEffectMath::LEEffectMath( unsigned int trigTableSize )
{
	m_sAngleUnit = AU_DEGREE;

	m_TrigTableSize = trigTableSize;
	m_TrigTableFactor = m_TrigTableSize / LEEffectMath::TWO_PI;

	m_SinTable = new float[m_TrigTableSize];
	m_TanTable = new float[m_TrigTableSize];

	buildTrigTables();
}
//-----------------------------------------------------------------------------
LEEffectMath::~LEEffectMath()
{
	delete[] m_SinTable;
	delete[] m_TanTable;
}
//-----------------------------------------------------------------------------
void LEEffectMath::buildTrigTables(void)
{
	// 构建查找表
	float angle;
	for (int i = 0; i < m_TrigTableSize; ++i)
	{
		angle = LEEffectMath::TWO_PI * i / m_TrigTableSize;
		m_SinTable[i] = sin(angle);
		m_TanTable[i] = tan(angle);
	}
}
//-----------------------------------------------------------------------------
float LEEffectMath::SinTable (float fValue)
{
	// Convert range to index values, wrap if required
	int idx;
	if (fValue >= 0)
	{
		idx = int(fValue * m_TrigTableFactor) % m_TrigTableSize;
	}
	else
	{
		idx = m_TrigTableSize - (int(-fValue * m_TrigTableFactor) % m_TrigTableSize) - 1;
	}

	return m_SinTable[idx];
}
//-----------------------------------------------------------------------------
float LEEffectMath::TanTable (float fValue)
{
	int idx = int(fValue * m_TrigTableFactor) % m_TrigTableSize;
	return m_TanTable[idx];
}
//-----------------------------------------------------------------------------
void LEEffectMath::setAngleUnit(AngleUnit unit)
{
	m_sAngleUnit = unit;
}
//-----------------------------------------------------------------------------
LEEffectMath::AngleUnit LEEffectMath::getAngleUnit(void)
{
	return m_sAngleUnit;
}
//-----------------------------------------------------------------------------
float LEEffectMath::AngleUnitsToRadians(float units)
{
	if (m_sAngleUnit == AU_DEGREE)
		return DegreesToRadians(units);
	else
		return units;
}
//-----------------------------------------------------------------------------
float LEEffectMath::RadiansToAngleUnits(float radians)
{
	if (m_sAngleUnit == AU_DEGREE)
		return RadiansToDegrees(radians);
	else
		return radians;
}
//-----------------------------------------------------------------------------
float LEEffectMath::AngleUnitsToDegrees(float units)
{
	if (m_sAngleUnit == AU_DEGREE)
		return units;
	else
		return RadiansToDegrees(units);
}
//-----------------------------------------------------------------------------
float LEEffectMath::DegreesToAngleUnits(float degrees)
{
	if (m_sAngleUnit == AU_DEGREE)
		return degrees;
	else
		return DegreesToRadians(degrees);
}
//-----------------------------------------------------------------------------
float LEEffectMath::UnitRandom ()
{
	return asm_rand() / asm_rand_max();
}
//-----------------------------------------------------------------------------
float LEEffectMath::RangeRandom (float fLow, float fHigh)
{
	return (fHigh - fLow) * UnitRandom() + fLow;
}
//-----------------------------------------------------------------------------
