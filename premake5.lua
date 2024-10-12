MacOSVersion = MacOSVersion or "14.5"

project "LLVM"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    warnings "Off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files 
    {
        "LLVM/src/lib.cpp",
    }

    -- Platform-specific defines for various targets
    filter "system:windows"
        defines "LLVM_PLATFORM_WINDOWS"
        systemversion "latest"
        staticruntime "on"

        links
        {
            "LLVM/lib/windows/lldCommon.lib",
            
            "LLVM/lib/windows/LLVMCodeGen.lib",
            "LLVM/lib/windows/LLVMCore.lib",
            "LLVM/lib/windows/LLVMLinker.lib",
        }

    filter "system:linux"
        defines "LLVM_PLATFORM_LINUX"
        systemversion "latest"
        staticruntime "on"

        links
        {
            -- TODO
        }

    filter "system:macosx"
        defines "LLVM_PLATFORM_MACOS"
        systemversion(MacOSVersion)
        staticruntime "on"

        links
        {
            -- TODO
        }

    filter "action:xcode*"
        -- Note: If we don't add the header files to the externalincludedirs
        -- we can't use <angled> brackets to include files.
        externalincludedirs 
		{
            "llvm",
            "lld"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "Speed"
