local charge = require("init")

require 'busted.runner'()

insulate("Is a bug-free arg-checking library", function()

			 describe("Errors with incorrect arguments to the actual `charge` function", function()
						  it("Errors at no arguments", function()
								 assert.has.errors(function()
										 charge()
								 end)
						  end)
						  it("Errors at an odd number of arguments", function()
								 assert.has.errors(function()
										 charge(1, "number", 2)
								 end)
						  end)

						  it("Errors when the type is neither a string nor a table", function()
								 assert.errors(function()
										 charge(1, function() end)
								 end)
						  end)
			 end)

			 describe("Checks that each argument is correctly typed", function()
						  it("Checks arguments with one correct type", function()
								 assert._not.errors(function()
										 charge(
											 1, "number",
											 "a", "string",
											 {}, "table",
											 function() end, "function",
											 io.stdin, "userdata",
											 coroutine.create(function() end), "thread"
										 )
								 end)

								 assert.errors(function()
										 charge(1, "string")
								 end)
						  end)

						  it("Checks arguments with multiple correct types", function()
								 assert._not.errors(function()
										 charge(
											 1, {"number", "string"},
											 "a", {"table", "string"},
											 {}, {"table", "function"},
											 function() end, {"userdata", "function"},
											 io.stdin, {"userdata", "thread"},
											 coroutine.create(function() end), {"number", "thread"}
										 )
								 end)

								 assert.errors(function()
										 charge(
											 1, {"string", "userdata"}
										 )
								 end)
						  end)
			 end)

			 it("Returns arguments when successful", function()
					local arg1, arg2, arg3 = 1, "a", {}
					local type1, type2, type3 = "number", {"string", "thread"}, "table"

					local ret1, ret2, ret3 = charge(arg1, type1, arg2, type2, arg3, type3)

					assert.equal(arg1, ret1)
					assert.equal(arg2, ret2)
					assert.equal(arg3, ret3)
			 end)
end)
