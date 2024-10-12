MacOSVersion = MacOSVersion or "14.5"

project "LLVM"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    warnings "Off"
    staticruntime "On"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files 
    {
        "src/**.c",
        "src/**.cpp",
    }

    includedirs
    {
        "include"
    }

    -- Platform-specific defines for various targets
    filter "system:windows"
        defines "LLVM_PLATFORM_WINDOWS"
        systemversion "latest"

    filter "system:linux"
        defines "LLVM_PLATFORM_LINUX"
        systemversion "latest"

    filter "system:macosx"
        defines "LLVM_PLATFORM_MACOS"
        systemversion(MacOSVersion)

    filter "action:xcode*"
        -- Note: If we don't add the header files to the externalincludedirs
        -- we can't use <angled> brackets to include files.
        externalincludedirs 
		{
            "include",
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "Full"
