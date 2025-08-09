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

project "Hazra"
	location "Hazra"
	kind "SharedLib"
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
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
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
		symbols "On"

	filter "configurations:Release"
		defines { "HZ_RELEASE" }
		optimize "On"

	filter "configurations:Dist"
		defines { "HZ_DIST" }
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
		staticruntime "On"
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