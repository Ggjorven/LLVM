------------------------------------------------------------------------------
-- LLVM
------------------------------------------------------------------------------
local handle = io.popen("llvm-config --prefix")		-- Open a console and execute the command.
local output = handle:read("*a")  					-- Read the output.
handle:close()										-- Close the handle.
LLVM_prefix = output:match("^%s*(.-)%s*$") 			-- Trim any trailing whitespace (such as newlines)

handle = io.popen("llvm-config --cppflags")			-- Open a console and execute the command.
output = handle:read("*a")  						-- Read the output.
handle:close()										-- Close the handle.
LLVM_flags = output:match("^%s*(.-)%s*$") 			-- Trim any trailing whitespace (such as newlines)

handle = io.popen("llvm-config --libs")			-- Open a console and execute the command.
output = handle:read("*a")  						-- Read the output.
handle:close()										-- Close the handle.
LLVM_libs = output:match("^%s*(.-)%s*$") 			-- Trim any trailing whitespace (such as newlines)

-- Prefix to add before each library
local prefix = "-l"

-- Split the string by spaces and add the prefix
local function add_prefix_to_libs(libs, prefix)
    local result = {}
    
    for lib in libs:gmatch("%S+") do
        table.insert(result, prefix .. lib)
    end
    
    return table.concat(result, " ")
end

-- Convert the string
local LLVM_libs = add_prefix_to_libs(LLVM_libs, prefix)

-- Output the result
print(converted_libs)

print(LLVM_flags)
print(LLVM_libs)
print(LLVM_libdir)

------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Dependencies
------------------------------------------------------------------------------
MacOSVersion = "14.5"

Dependencies = 
{
	-- Libraries
	LLVM = 
	{
		IncludeDir = LLVM_prefix .. "/include",
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

include "Starter"
------------------------------------------------------------------------------
