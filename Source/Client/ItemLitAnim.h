//
#pragma once

#include "stdafx.h"

typedef DR_RESULT (*lwLitAnimProc)(drIAnimKeySetPRS* ctrl);

// 120f-rot
DR_RESULT lwLitAnimTexCoord0(drIAnimKeySetPRS* ctrl);
// 120f-pos
DR_RESULT lwLitAnimTexCoord1(drIAnimKeySetPRS* ctrl);
// 360f-pos-u
DR_RESULT lwLitAnimTexCoord2(drIAnimKeySetPRS* ctrl);
// 360f-pos-v
DR_RESULT lwLitAnimTexCoord360posv(drIAnimKeySetPRS* ctrl);
// 360f-pos-uv
DR_RESULT lwLitAnimTexCoord360posuv(drIAnimKeySetPRS* ctrl);
// 360f-pos/rot
DR_RESULT lwLitAnimTexCoord3(drIAnimKeySetPRS* ctrl);
// 360f-pos/rot-neg
DR_RESULT lwLitAnimTexCoord_360_pos_rot_neg(drIAnimKeySetPRS* ctrl);
// 720f-rot
DR_RESULT lwLitAnimTexCoord4(drIAnimKeySetPRS* ctrl);

static const char* __lit_anim_type[] =
	{
		"Anim Type NULL",
		"Anim Type 120-rot",
		"Anim Type 120-pos",
		"Anim Type 360-pos-u",
		"Anim Type 360-pos-v",
		"Anim Type 360-pos-uv",
		"Anim Type 360-pos/rot",
		"Anim Type 360-pos/rot-neg",
		"Anim Type 720-rot",
};

const DWORD __lit_anim_num = DR_ARRAY_LENGTH(__lit_anim_type);

extern lwLitAnimProc __lit_proc[__lit_anim_num];
