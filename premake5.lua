------------------------------------------------------------------------------
-- Utilities
------------------------------------------------------------------------------
local function GetIOResult(cmd)
	local handle = io.popen(cmd)			-- Open a console and execute the command.
	local output = handle:read("*a")		-- Read the output.
	handle:close()							-- Close the handle.

	return output:match("^%s*(.-)%s*$")		-- Trim any trailing whitespace (such as newlines)
end

function GetOS()
	local osName = os.getenv("OS")

	if osName == "Windows_NT" then
		return "windows"
	else -- TODO: Check if works
		local uname = io.popen("uname"):read("*l")
		if uname == "Linux" then
			return "linux"
		elseif uname == "Darwin" then
			return "macosx"
		end
	end
	
	return "unknown-os"
end
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- LLVM
------------------------------------------------------------------------------
local function GetLibPrefix()
	if GetOS() == "windows" then
		return ""
	elseif GetOS() == "linux" then
		return "-l"
	elseif GetOS() == "macosx" then
		return "TODO"
	end

	return ""
end

LLVM_Prefix = GetIOResult("llvm-config --prefix")
LLVM_Flags = GetIOResult("llvm-config --cppflags")
LLVM_Libs = GetIOResult("llvm-config --libs")
LLVM_Libdir = GetIOResult("llvm-config --libdir")

-- Note: Adding lld (linker) libraries.
LLVM_Libs = LLVM_Libs .. " " .. GetLibPrefix() .. "lldCommon"
LLVM_Libs = LLVM_Libs .. " " .. GetLibPrefix() .. "lldELF"
LLVM_Libs = LLVM_Libs .. " " .. GetLibPrefix() .. "lldCOFF"
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Dependencies
------------------------------------------------------------------------------
MacOSVersion = "14.5"

Dependencies =
{

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

include "Starter"
------------------------------------------------------------------------------
