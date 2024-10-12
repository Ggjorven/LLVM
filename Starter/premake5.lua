MacOSVersion = MacOSVersion or "14.5"

project "Starter"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "On"

	architecture "x86_64"

	debugdir ("%{wks.location}")
	debugargs { "" }

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	--------------------------------------
	-- Files & Options
	--------------------------------------
	files
	{
		"src/**.h",
		"src/**.hpp",
		"src/**.cpp",
	}

	includedirs
	{
		"src",

		"%{Dependencies.LLVM.IncludeDir}",
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"_SILENCE_ALL_MS_EXT_DEPRECATION_WARNINGS"
	}

	links
	{
		"%{Dependencies.LLVM.LibName}",
	}

	--------------------------------------
	-- Platforms
	--------------------------------------
	filter "system:windows"
		defines "APP_PLATFORM_WINDOWS"
		systemversion "latest"

	filter "system:linux"
		defines "APP_PLATFORM_LINUX"
		systemversion "latest"

    filter "system:macosx"
		defines "APP_PLATFORM_MACOS"
		systemversion(MacOSVersion)

	filter "action:xcode*"
		-- Note: XCode needs the full pch header path
		pchheader "src/Dynamite/dypch.h"

		-- Note: If we don't add the header files to the externalincludedirs
		-- we can't use <angled> brackets to include files.
		externalincludedirs
		{
			"src",
			"src/Dynamite",

			"%{Dependencies.LLVM.LibName}",
		}

	--------------------------------------
	-- Configurations
	--------------------------------------
	filter "configurations:Debug"
		defines "APP_CONFIG_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "APP_CONFIG_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "APP_CONFIG_DIST"
		runtime "Release"
		optimize "Full"
