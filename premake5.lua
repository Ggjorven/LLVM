------------------------------------------------------------------------------
-- Dependencies
------------------------------------------------------------------------------
MacOSVersion = "14.5"

Dependencies = 
{
	-- Libraries
	LLVM = 
	{
		IncludeDir = "%{wks.location}/vendor/llvm/include",
		LibName = "LLVM"
	},
}
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Solution
------------------------------------------------------------------------------
outputdir = "%{cfg.buildcfg}-%{cfg.system}"

workspace "LLVM"
	architecture "x86_64"
	startproject "Starter"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

	flags
	{
		"MultiProcessorCompile"
	}

group "Dependencies"
	include "vendor/llvm"
group ""

include "Starter"
------------------------------------------------------------------------------
