#ifndef LEQuaternion_H
#define LEQuaternion_H

#include "LightEngineAPI.h"
#include "drDirectX.h"

class LEEffVector3;
class LERadian;

class LEEffQuaternion
{
public:
	D3DXQUATERNION m_qSelf;
public:
	LEEffQuaternion() : m_qSelf(0, 0, 0, 0) {}
	LEEffQuaternion(float w, float x, float y, float z) 
		: m_qSelf(w, x, y, z) {}
	LEEffQuaternion(const D3DXQUATERNION& dxQ) : m_qSelf(dxQ) {}
	LEEffQuaternion(const LEEffQuaternion& q) : m_qSelf(q.m_qSelf) {}

	D3DXQUATERNION& GetDXValue() { return m_qSelf; }

	// 根据这个四元数旋转这个向量
	LEEffVector3 operator* (const LEEffVector3& rkVector) const;


	void FromAngleAxis (const LERadian& rfAngle, const LEEffVector3& rkAxis);

};
#endif 