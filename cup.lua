--cup.lua
--Will become the basket for the cup game

local cup = {}
local cup_mt = {__index = cup}

--Public Functions

function cup.new(cupX, cupY, cupWidth, cupHeight, physics)
	local cupRailWidth = 5
	local newCup = {
			physics = physics,
			cupLeftWall = display.newRect(cupX + cupWidth/2, cupY, cupRailWidth, cupHeight),
			cupRightWall= display.newRect(cupX - cupWidth/2, cupY, cupRailWidth, cupHeight),
			cupBase 	= display.newRect(cupX , cupY + cupHeight/2, cupWidth+cupRailWidth,5)

	}

	newCup.cupLeftWall:setFillColor("black")
	newCup.cupRightWall:setFillColor("black")
	newCup.cupBase:setFillColor( "black" )
	newCup.physics.addBody(newCup.cupLeftWall, "static", {density=1, friction=0.2, bounce=0.4})
	newCup.physics.addBody(newCup.cupRightWall, "static", {density=1, friction=0.2, bounce=0.4})
	newCup.physics.addBody(newCup.cupBase, "static", {density=1, friction=0.2, bounce=0.4})
	return setmetatable( newCup, cup_mt )
end



return cup