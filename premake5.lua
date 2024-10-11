MacOSVersion = MacOSVersion or "14.5"

project "LLVM"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    warnings "Off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "llvm/lib/**.c",
        "llvm/lib/**.cpp",
    }

    includedirs {
        "llvm/include",
        "lld/include"
    }

    defines {
        "TODO"  -- Define your custom defines here
    }

    -- Add the common defines from llvm-config.h
    defines
	{
        -- "LLVM_ENABLE_DUMP",
        "LLVM_PLATFORM_X86",
    }

    -- Platform-specific defines for various targets
    filter "system:windows"
        defines "LLVM_PLATFORM_WINDOWS"
        systemversion "latest"
        staticruntime "on"

    filter "system:linux"
        defines "LLVM_PLATFORM_LINUX"
        systemversion "latest"
        staticruntime "on"

    filter "system:macosx"
        defines "LLVM_PLATFORM_MACOS"
        systemversion(MacOSVersion)
        staticruntime "on"

    filter "action:xcode*"
        -- Note: If we don't add the header files to the externalincludedirs
        -- we can't use <angled> brackets to include files.
        externalincludedirs 
		{
            "llvm",
            "lld"
        }

    -- Add architecture-specific target defines
    -- defines 
	-- {
    --     "LLVM_HAS_AARCH64_TARGET=1",
    --     "LLVM_HAS_AMDGPU_TARGET=0",
    --     "LLVM_HAS_ARC_TARGET=0",
    --     "LLVM_HAS_ARM_TARGET=1",
    --     "LLVM_HAS_AVR_TARGET=0",
    --     "LLVM_HAS_BPF_TARGET=1",
    --     "LLVM_HAS_CSKY_TARGET=0",
    --     "LLVM_HAS_DIRECTX_TARGET=0",
    --     "LLVM_HAS_HEXAGON_TARGET=0",
    --     "LLVM_HAS_LANAI_TARGET=0",
    --     "LLVM_HAS_LOONGARCH_TARGET=0",
    --     "LLVM_HAS_M68K_TARGET=0",
    --     "LLVM_HAS_MIPS_TARGET=0",
    --     "LLVM_HAS_MSP430_TARGET=0",
    --     "LLVM_HAS_NVPTX_TARGET=1",
    --     "LLVM_HAS_POWERPC_TARGET=0",
    --     "LLVM_HAS_RISCV_TARGET=1",
    --     "LLVM_HAS_SPARC_TARGET=0",
    --     "LLVM_HAS_SPIRV_TARGET=1",
    --     "LLVM_HAS_SYSTEMZ_TARGET=0",
    --     "LLVM_HAS_VE_TARGET=0",
    --     "LLVM_HAS_WEBASSEMBLY_TARGET=1",
    --     "LLVM_HAS_XCORE_TARGET=0",
    --     "LLVM_HAS_XTENSA_TARGET=0"
    -- }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter "configurations:Release"
        runtime "Release"
        optimize "on"

    filter "configurations:Dist"
        runtime "Release"
        optimize "Speed"
