--cup.lua
--Will become the basket for the cup game

local cup = {}
local cup_mt = {__index = cup}

--Public Functions

function cup.new(n, s)
	local newCup = {
			name = n,
			size = s 
	}

	return setmetatable( newCup, cup_mt )

end

function cup:addWater(water)
	self.size = self.size + water
end

function cup:printWater()
	print(self.name .. "has " .. self.size)
end

return cup