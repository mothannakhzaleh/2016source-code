//
#include "stdafx.h"
#include "ItemLitAnim.h"

lwLitAnimProc __lit_proc[__lit_anim_num] =
	{
		NULL,
		lwLitAnimTexCoord0,
		lwLitAnimTexCoord1,
		lwLitAnimTexCoord2,
		lwLitAnimTexCoord360posv,
		lwLitAnimTexCoord360posuv,
		lwLitAnimTexCoord3,
		lwLitAnimTexCoord_360_pos_rot_neg,
		lwLitAnimTexCoord4,
};

DR_RESULT lwLitAnimTexCoord0(drIAnimKeySetPRS* ctrl)
{
  // rotation
  {
	drVector3 axis(0.0f, 0.0f, 1.0f);

	drKeyQuaternion buf[3];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
	buf[1].key		  = 60;
	buf[1].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);
	buf[2].key		  = 119;
	buf[2].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);

	ctrl->AddKeyRotation(0, buf, 3);
  }

  return DR_RET_OK;
}

DR_RESULT lwLitAnimTexCoord1(drIAnimKeySetPRS* ctrl)
{
  drKeyVector3 buf[2];
  buf[0].key		= 0;
  buf[0].slerp_type = AKST_LINEAR;
  buf[0].data		= drVector3(0.0f, 0.0f, 0.0f);
  buf[1].key		= 119;
  buf[1].slerp_type = AKST_LINEAR;
  buf[1].data		= drVector3(1.0f, 1.0f, 0.0f);

  ctrl->AddKeyPosition(0, buf, 2);

  return DR_RET_OK;
}
DR_RESULT lwLitAnimTexCoord2(drIAnimKeySetPRS* ctrl)
{
  // position
  {
	drKeyVector3 buf[2];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	buf[0].data		  = drVector3(0.0f, 0.0f, 0.0f);
	buf[1].key		  = 359;
	buf[1].slerp_type = AKST_LINEAR;
	buf[1].data		  = drVector3(0.0f, 1.0f, 0.0f);

	ctrl->AddKeyPosition(0, buf, 2);
  }

  return DR_RET_OK;
}
DR_RESULT lwLitAnimTexCoord360posv(drIAnimKeySetPRS* ctrl)
{
  // position
  {
	drKeyVector3 buf[2];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	buf[0].data		  = drVector3(0.0f, 0.0f, 0.0f);
	buf[1].key		  = 359;
	buf[1].slerp_type = AKST_LINEAR;
	buf[1].data		  = drVector3(1.0f, 0.0f, 0.0f);

	ctrl->AddKeyPosition(0, buf, 2);
  }

  return DR_RET_OK;
}
DR_RESULT lwLitAnimTexCoord360posuv(drIAnimKeySetPRS* ctrl)
{
  // position
  {
	drKeyVector3 buf[2];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	buf[0].data		  = drVector3(0.0f, 0.0f, 0.0f);
	buf[1].key		  = 359;
	buf[1].slerp_type = AKST_LINEAR;
	buf[1].data		  = drVector3(1.0f, 1.0f, 0.0f);

	ctrl->AddKeyPosition(0, buf, 2);
  }

  return DR_RET_OK;
}

DR_RESULT lwLitAnimTexCoord3(drIAnimKeySetPRS* ctrl)
{
  // position
  {
	drKeyVector3 buf[2];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	buf[0].data		  = drVector3(0.0f, 0.0f, 0.0f);
	buf[1].key		  = 359;
	buf[1].slerp_type = AKST_LINEAR;
	buf[1].data		  = drVector3(1.0f, 1.0f, 0.0f);

	ctrl->AddKeyPosition(0, buf, 2);
  }

  // rotation
  {
	drVector3 axis(0.0f, 0.0f, 1.0f);

	drKeyQuaternion buf[3];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
	buf[1].key		  = 180;
	buf[1].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);
	buf[2].key		  = 359;
	buf[2].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);

	ctrl->AddKeyRotation(0, buf, 3);
  }

  return DR_RET_OK;
}
// 360f-pos/rot-neg
DR_RESULT lwLitAnimTexCoord_360_pos_rot_neg(drIAnimKeySetPRS* ctrl)
{
  // position
  {
	drKeyVector3 buf[2];
	buf[0].key		  = 0;
	buf[0].slerp_type = AKST_LINEAR;
	buf[0].data		  = drVector3(0.0f, 0.0f, 0.0f);
	buf[1].key		  = 359;
	buf[1].slerp_type = AKST_LINEAR;
	buf[1].data		  = drVector3(1.0f, 1.0f, 0.0f);

	ctrl->AddKeyPosition(0, buf, 2);
  }

  // rotation
  {
	drVector3 axis(0.0f, 0.0f, 1.0f);

	drKeyQuaternion buf[3];
	buf[0].key		  = 359;
	buf[0].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
	buf[1].key		  = 180;
	buf[1].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);
	buf[2].key		  = 0;
	buf[2].slerp_type = AKST_LINEAR;
	drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);

	ctrl->AddKeyRotation(0, buf, 3);
  }

  return DR_RET_OK;
}

DR_RESULT lwLitAnimTexCoord4(drIAnimKeySetPRS* ctrl)
{
  // rotation
  drVector3 axis(0.0f, 0.0f, 1.0f);

  drKeyQuaternion buf[3];
  buf[0].key		= 0;
  buf[0].slerp_type = AKST_LINEAR;
  drQuaternionRotationAxis(&buf[0].data, &axis, 0.0f);
  buf[1].key		= 360;
  buf[1].slerp_type = AKST_LINEAR;
  drQuaternionRotationAxis(&buf[1].data, &axis, DR_PI);
  buf[2].key		= 719;
  buf[2].slerp_type = AKST_LINEAR;
  drQuaternionRotationAxis(&buf[2].data, &axis, DR_2_PI);

  ctrl->AddKeyRotation(0, buf, 3);

  return DR_RET_OK;
}
