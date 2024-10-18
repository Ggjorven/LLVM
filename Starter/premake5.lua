MacOSVersion = MacOSVersion or "14.5"

project "Starter"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "Off"

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
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS",
		"_SILENCE_ALL_MS_EXT_DEPRECATION_WARNINGS"
	}

	buildoptions
	{
		LLVM_Flags,
	}

	linkoptions
	{
		LLVM_Libs,
	}

    libdirs
    {
        LLVM_Libdir,
    }

	--------------------------------------
	-- Platforms
	--------------------------------------
	filter "system:windows"
		defines "APP_PLATFORM_WINDOWS"
		systemversion "latest"

		links
		{
			"ntdll.lib"
		}

	filter "system:linux"
		defines "APP_PLATFORM_LINUX"
		systemversion "latest"

        buildoptions
        {
            "-fPIC"
        }

        linkoptions
        {
            "-no-pie",

            "-lz",
            "-lzstd"
        }

    filter "system:macosx"
		defines "APP_PLATFORM_MACOS"
		systemversion(MacOSVersion)

	filter "action:xcode*"
		-- Note: If we don't add the header files to the externalincludedirs
		-- we can't use <angled> brackets to include files.
		externalincludedirs
		{
			"src",
		}

	--------------------------------------
	-- Configurations
	--------------------------------------
	filter "configurations:Debug"
		defines "APP_CONFIG_DEBUG"
		runtime "Release" -- Note: LLVM's binaries are release, so this is necessary
		symbols "on"

	filter "configurations:Release"
		defines "APP_CONFIG_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "APP_CONFIG_DIST"
		runtime "Release"
		optimize "Full"