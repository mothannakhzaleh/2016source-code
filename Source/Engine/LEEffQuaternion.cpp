#include "LEEffQuaternion.h"

#include "LEEffectMath.h"
#include "LEEffVector3.h"
//-----------------------------------------------------------------------------
void LEEffQuaternion::FromAngleAxis(const LERadian& rfAngle, const LEEffVector3& rkAxis)
{
	// 假设:  旋转轴是单位向量
	//
	// 这个旋转的四元数是
	//   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)

	LERadian fHalfAngle(rfAngle * 0.5);
	float fSin = LEEffectMath::Sin(fHalfAngle);
	m_qSelf.w = LEEffectMath::Cos(fHalfAngle);
	m_qSelf.x = fSin*rkAxis.m_vSelf.x;
	m_qSelf.y = fSin*rkAxis.m_vSelf.y;
	m_qSelf.z = fSin*rkAxis.m_vSelf.z;
}
//-----------------------------------------------------------------------------
LEEffVector3 LEEffQuaternion::operator*(const LEEffVector3& v) const
{
	// 根据nVidia SDK 实现
	LEEffVector3 uv, uuv; 
	LEEffVector3 qvec(m_qSelf.x, m_qSelf.y, m_qSelf.z);
	uv = qvec.crossProduct(v); 
	uuv = qvec.crossProduct(uv); 
	uv *= (2.0f * m_qSelf.w); 
	uuv *= 2.0f; 

	return v + uv + uuv;
}

