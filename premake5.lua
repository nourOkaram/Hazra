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
IncludeDir["Glad"] =	"Hazra/vendor/Glad/include"
IncludeDir["ImGui"] =	"Hazra/vendor/imgui"

include "Hazra/vendor/GLFW"
include "Hazra/vendor/Glad"
include "Hazra/vendor/imgui"

project "Hazra"
	location "Hazra"
	kind "SharedLib"
	language "C++"
	staticruntime "off"

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
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		buildoptions { "/utf-8" } 

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands {
			"{MKDIR} ../bin/" .. outputdir .. "/Sandbox",
		    "{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox"
		}


	filter "configurations:Debug"
		defines { "HZ_DEBUG" }
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines { "HZ_RELEASE" }
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines { "HZ_DIST" }
		runtime "Release"
		optimize "On"



project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{IncludeDir.spdlog}",
		"Hazra/src"
	}

	links
	{
		"Hazra"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
		buildoptions { "/utf-8" } 

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines { "HZ_DEBUG" }
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines { "HZ_RELEASE" }
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines { "HZ_DIST" }
		runtime "Release"
		optimize "On"