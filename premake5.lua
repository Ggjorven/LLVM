------------------------------------------------------------------------------
-- LLVM
------------------------------------------------------------------------------
local function GetIOResult(cmd)
	local handle = io.popen(cmd)			-- Open a console and execute the command.
	local output = handle:read("*a")		-- Read the output.
	handle:close()							-- Close the handle.

	return output:match("^%s*(.-)%s*$")		-- Trim any trailing whitespace (such as newlines)
end

-- Note: Split by ' '
local function AddPrefix(str, prefix)
	local result = {}

	for part in str:gmatch("%S+") do
        table.insert(result, prefix .. part)
    end
    
    return table.concat(result, " ")
end

LLVM_Prefix = GetIOResult("llvm-config --prefix")
LLVM_Flags = GetIOResult("llvm-config --cppflags")
LLVM_Libs = GetIOResult("llvm-config --libs")

local libSuffix = ".lib"
LLVM_Libs = LLVM_Libs .. " " .. LLVM_Prefix .. "/lib/lldCommon" .. libSuffix
LLVM_Libs = LLVM_Libs .. " " .. LLVM_Prefix .. "/lib/lldELF" .. libSuffix
LLVM_Libs = LLVM_Libs .. " " .. LLVM_Prefix .. "/lib/lldCOFF" .. libSuffix
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
