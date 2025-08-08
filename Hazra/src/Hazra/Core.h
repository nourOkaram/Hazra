#pragma once

#ifdef HAZRA_PLATFORM_WINDOWS
	#ifdef HAZRA_BUILD_DLL
		#define HAZRA_API __declspec(dllexport)
	#else
		#define HAZRA_API __declspec(dllimport)
	#endif
#else
#error Hazra only supports Windows!
#endif