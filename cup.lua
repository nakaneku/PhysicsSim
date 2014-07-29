--cup.lua
--Will become the basket for the cup game

local cup = {}
local cup_mt = {__index = cup}

--Public Functions

local function onBallCupCollision(self, event)
	local phase = event.phase
	if(phase == "began") then
		incrementScore()
		event.other:removeSelf()
		ballList[event.other] = nil

	elseif (phase == "ended") then

	end

end


function cup.new(cupX, cupY, cupWidth, cupHeight, physics)
	local cupRailWidth = 5
	local newCup = {
			physics = physics,
			cupLeftWall = display.newRect(cupX + cupWidth/2, cupY, cupRailWidth, cupHeight),
			cupRightWall= display.newRect(cupX - cupWidth/2, cupY, cupRailWidth, cupHeight),
			cupBase 	= display.newRect(cupX , cupY + cupHeight/2, cupWidth+cupRailWidth,5),
			cupScoreWall = display.newRect(cupX, cupY+cupHeight/2 - cupRailWidth, cupWidth-cupRailWidth, 5  )
	}

	newCup.cupLeftWall:setFillColor("black")
	newCup.cupRightWall:setFillColor("black")
	newCup.cupBase:setFillColor( "black" )
	newCup.physics.addBody(newCup.cupLeftWall, "kinematic", {density=1, friction=0.2, bounce=0.4})
	newCup.physics.addBody(newCup.cupRightWall, "kinematic", {density=1, friction=0.2, bounce=0.4})
	newCup.physics.addBody(newCup.cupBase, "kinematic", {density=1, friction=0.2, bounce=0.4})
	newCup.physics.addBody(newCup.cupScoreWall, "kinematic", {density=1, friction=0.2, bounce=0.0})
	newCup.collision = onBallCupCollision
	newCup.cupScoreWall:addEventListener("collision", newCup)
	return setmetatable( newCup, cup_mt )
end

function cup:move(speed)
	self.cupLeftWall:setLinearVelocity(speed)
	self.cupRightWall:setLinearVelocity(speed)
	self.cupBase:setLinearVelocity(speed)
	self.cupScoreWall:setLinearVelocity(speed)
end







return cup