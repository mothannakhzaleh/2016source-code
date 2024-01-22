//
#pragma once

/////////
#if(defined LIGHTENGINE_USE_DLL || defined USE_LIGHTENGINE)

#include "LightEngineAPI.h"
#define DR_FRONT_API LIGHTENGINE_API

#else
//////////////
#ifdef DR_FRONT_USE_DLL

#ifdef DR_FRONT_EXPORTS
	#define DR_FRONT_API __declspec(dllexport)
#else
	#define DR_FRONT_API __declspec(dllimport)
#endif

#else

#define DR_FRONT_API

#endif

#endif