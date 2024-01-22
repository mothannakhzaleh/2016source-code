//
#include "drObjectMethod.h"


DR_BEGIN

drMatrixCtrl::drMatrixCtrl()
:
_mat_ptr( 0 ),
_angle_yaw( D3DX_PI ),
_angle_pitch( 0.0f ),
_angle_roll( 0.0f ),

_scale( 1.f, 1.f, 1.f )
{
}

void drMatrixCtrl::SetScale( const drVector3 &scale )
{
	_scale = scale;
}

void drMatrixCtrl::SetPos( float* pos )
{
	drMatrix44Translate( _mat_ptr, pos[0], pos[1], pos[2], OP_MATRIX_REPLACE );
}

void drMatrixCtrl::SetYaw( float yaw )
{
	_angle_yaw = yaw;
}
void drMatrixCtrl::SetPitch( float pitch )
{
	_angle_pitch = pitch;
}
void drMatrixCtrl::SetRoll( float roll )
{
    _angle_roll = roll;
}
void drMatrixCtrl::UpdateYawPitchRoll()
{
    drMatrix44 m( drMatrix44_Identity );

    drMatrix44 m_yaw = drMatrix44RotateZ( -_angle_yaw + DR_PI );
    drMatrix44 m_pitch = drMatrix44RotateY( - _angle_pitch );
    drMatrix44 m_roll = drMatrix44RotateX( - _angle_roll );
    drMatrix44 m_scale = drMatrix44Scale(_scale.x, _scale.y, _scale.z);

    drMatrix44Multiply( &m, &m_yaw, &m_pitch );
    drMatrix44Multiply( &m, &m, &m_roll );
    drMatrix44Multiply( &m, &m, &m_scale);


    memcpy( _mat_ptr, &m, sizeof(float) * 12 );
}

DR_END
