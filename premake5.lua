workspace "Hazra"
	architecture "x64"
	startproject "Sandbox"
	
	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["spdlog"] =	"Hazra/vendor/spdlog/include"
IncludeDir["GLFW"] =	"Hazra/vendor/GLFW/include"

include "Hazra/vendor/GLFW"

project "Hazra"
	location "Hazra"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "Hazra/src/hzpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{IncludeDir.spdlog}",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "off"
		systemversion "latest"
		buildoptions { "/utf-8" } 

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}

		postbuildcommands {
			"{MKDIR} ../bin/" .. outputdir .. "/Sandbox",
		    "{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox"
		}


	filter "configurations:Debug"
		defines { "HZ_DEBUG" }
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines { "HZ_RELEASE" }
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines { "HZ_DIST" }
		buildoptions "/MD"
		optimize "On"



project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hazra/vendor/spdlog/include",
		"Hazra/src"
	}

	links
	{
		"Hazra"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "off"
		systemversion "latest"
		buildoptions { "/utf-8" } 

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines { "HZ_DEBUG" }
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines { "HZ_RELEASE" }
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Dist"
		defines { "HZ_DIST" }
		buildoptions "/MD"
		optimize "On"