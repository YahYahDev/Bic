local parse = require("src.modules.String.Parse")

---@class log
local log = {
	-- used for setting custom path to a log
	path = "",
    
    name = "Log",
---@param msg string
	Add = function (self, msg)
		local file = io.open(self.path .. self.name..".log", "a+")
		if file == nil then
			print("Log: Failed to Log Message <<"..msg..">>")
			return
		end

		local lines = parse.GetLines(file:read("a"))

		if lines[#lines] ~= "[Log]:     " .. msg and lines[#lines] ~= "[Log]:     " .. msg .. "..." then
			file:write("[Log]:     " .. msg .. "\n")
		elseif lines[#lines] == "[Log]:     " .. msg .. "..." then
			-- Do nothing so you dont make duplicate loging
		else
			file:write("[Log]:     " .. msg.. "...\n")
		end

		file:close()
	end,

	Error = function (self, msg)
		local file = io.open(self.path .. self.name .. ".log", "a+")
		if file == nil then
			print("Error: Failed to Log Message <<"..msg..">>")
			return
		end

		local lines = parse.GetLines(file:read("a"))

		if lines[#lines] ~= "[Error]:   " .. msg and lines[#lines] ~= "[Error]:   " .. msg .. "..." then
			file:write("[Error]:   " .. msg .. "\n")
		elseif lines[#lines] == "[Error]:   " .. msg .. "..." then
			-- Do nothing so you dont make duplicate loging
		else
			file:write("[Error]:   " .. msg.. "...\n")
		end
		file:close()
	end,
    
    Trip = function (self, item, msg)
        if item == nil then
            self:Error(msg)
        
        end
    end,

}

return log
