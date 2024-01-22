#pragma once

#include "drHeader.h"
#include "drMath.h"
#include <set>


DR_BEGIN

class DR_FRONT_API drMatrixCtrl
{
protected:
    float _angle_yaw;
    float _angle_pitch;
    float _angle_roll;
    //float _scale;
	drVector3 _scale;

    drMatrix44* _mat_ptr;

public:
    drMatrixCtrl();

    void BindMatrix( drMatrix44* mat ) { _mat_ptr = mat; }

    drMatrix44* GetMatrix() { return _mat_ptr; }
    void SetMatrix( const drMatrix44* mat ) { *_mat_ptr = *mat; }

    void SetPos( float* pos );
    void SetYaw( float yaw );
    void SetPitch( float pitch );
    void SetRoll( float roll );
    void SetScale( const drVector3 &scale );
    void UpdateYawPitchRoll();
    float GetYaw() const { return _angle_yaw; }
    float GetPitch() const { return _angle_pitch; }
    float GetRoll() const { return _angle_roll; }
    const drVector3& GetScale() const { return _scale; }

    void GetFaceDir( drVector3* dir ) 
    {   
        dir->x = _mat_ptr->_21;
        dir->y = _mat_ptr->_22;
        dir->z = _mat_ptr->_23;
    }
    void GetRightDir( drVector3* dir ) 
    { 
        dir->x = -_mat_ptr->_11; 
        dir->y = -_mat_ptr->_12;
        dir->z = -_mat_ptr->_13;
    }

    void GetUpDir( drVector3* dir )
    {
        dir->x = _mat_ptr->_31;
        dir->y = _mat_ptr->_32;
        dir->z = _mat_ptr->_33;
    }
};

DR_END
