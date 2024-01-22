#ifndef __LIGHTENGINE_API_H
#define __LIGHTENGINE_API_H
/////////

////////////
#ifdef LIGHTENGINE_USE_DLL

#ifdef LIGHTENGINE_EXPORTS
	#define LIGHTENGINE_API __declspec(dllexport)
#else
	#define LIGHTENGINE_API __declspec(dllimport)
#endif

#else

#define LIGHTENGINE_API

#endif

#endif
