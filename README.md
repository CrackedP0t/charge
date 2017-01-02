Charge
==
An argument type-checking library for Lua

Examples:

    local charge = require("charge")

	local function appendSum(number1, number2, text)
		-- Will throw an error if any argument is not valid
    	charge(number1, "number", number2, "number", text, "string")

		return text .. tostring(number1 + number2)
	end

    print(appendSum(2, 3, "Five -> ")) -- Prints "Five -> 5"

	print(appendSum(2, {}, "Five -> ")) -- Throws an error:
	bad argument #2 to 'appendSum' (number expected; got table)
	
Variables can also have multiple correct types:

    local charge = require("charge")

	local function basicTypeToString(thing)
		-- Will also accept tables of types
		charge(thing, {"number", "boolean"})

		return tostring(thing)
	end

	print(basicTypeToString(true)) -- Prints "true"
	print(basicTypeToString(12)) -- Prints "12"

	print(basicTypeToString(function() end)) -- Throws an error:
	-- Bad argument #1 to 'basicTypeToString' (any of number, boolean expected; got function)
