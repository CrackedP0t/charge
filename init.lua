local charge = function(...)
	local args = {...}
	local retArgs = {}

	if #args % 2 ~= 0 then
		error(("bad argument #%i to '%s' (any of string, table expected; got nil)")
				:format(#args + 1, debug.getinfo(1, "n").name or "unknown"), 2)
	end

	for i = 1, math.max(1, #args), 2 do
		local val, cType = args[i], args[i + 1]
		local valType, cTypeType = type(val), type(cType)

		if cTypeType == "table" then
			local shouldError = true
			local typeList = ""

			for j, v in ipairs(cType) do
				shouldError = shouldError and valType ~= v
				typeList = typeList .. ", " .. v
			end

			if shouldError then
				error(("bad argument #%i to '%s' (any of %s expected; got %s)")
						:format(math.ceil(i / 2)
								, debug.getinfo(2, "n").name or "unknown"
								, typeList:sub(3, -1)
								, valType)
					, 3)
			end
		elseif cTypeType ~= "string" then
			error(("bad argument #%i to '%s' (any of string, table expected; got %s)")
					:format(i + 1, debug.getinfo(1, "n").name or "unknown", cTypeType), 2)
		elseif valType ~= cType then
			error(("bad argument #%i to '%s' (%s expected; got %s)")
					:format(math.ceil(i / 2), debug.getinfo(2, "n").name or "unknown", cType, valType), 3)
		end

		retArgs[#retArgs + 1] = val
	end

	return (unpack and unpack or table.unpack)(retArgs)
end

return charge
