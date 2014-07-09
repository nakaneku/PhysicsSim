-- Abstract: HelloPhysics project
--
-- Demonstrates creating phyiscs bodies
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.
--
--	Supports Graphics 2.0
---------------------------------------------------------------------------------------

local physics = require("physics")
local cup = require("cup")
physics.start()

local init =  require("initializeGame1")



local crateList = {}

local removeCrate = function( event )
	event.target:removeSelf( )
	crateList[event.target] = nil
	event.target = nil

end

local function spawnCrate()
	local x = math.random(40,290)
	local y = 0
	local crate = display.newCircle( x, y, 4)
	crate:setFillColor( 1,0,0 )
	crate.rotation = math.random(0,360)
	physics.addBody( crate, {density=0.1, friction=0.5, bounce=0.2} )
	crate:addEventListener( "touch", removeCrate)
	crateList[crate] = crate
end

local function deleteAllCrates()
	for k, v in pairs(crateList) do
		if (k ~= nil ) then
			k:removeSelf( )
			k = nil
			table.remove(crateList, k)

		end
	end
	crateList = nil
	crateList = {}
end

-- Creating a Cup

local cupX = 100
local cupY = 100
local cupHeight = 50
local cupWidth = 40


--ScoreBoard
 
local score = 0

-- Create first multi-line text object
local options1 = 
{
    text = "Balls in Cup = " .. score,
    y = -10,
    x = 230,
    width = 200,     --required for multi-line and alignment
    font = native.systemFont,
    fontSize = 18
}



local scoreBoard = display.newText( options1)
scoreBoard:setFillColor( 1, 1, 1 )

--EndScoreBoard

local addBox = display.newRect( 50, 500, 50, 50 )
local destroyBox = display.newRect(120,500,50,50)
local forceBox = display.newRect(190, 500, 50, 50)

local force = function(event)
	local xforce = math.random(20,50);
	local yforce = math.random(20,50);
	for k, v in pairs(crateList) do
		if(k ~= nil) then
			if(xforce %2 == 0)then
				xforce = -xforce
			end
			k:applyForce( xforce, -yforce, k.x, k.y)		
		end
	end

end

local function ballWithinArea(ball, xLow, xHigh, yLow, yHigh)
	if (ball.x <= xHigh and ball.x >= xLow and ball.y >= yLow and ball.y <= yHigh) then
		return true
	end
	return false
end


local function updateScore( event )
	local count = 0
    for k, v in pairs(crateList) do
    	if(ballWithinArea(k, cupX-cupWidth/2, cupX+cupWidth/2, cupY-cupHeight/2, cupY+cupHeight/2))then
    		count = count +1
    	end
    end
    score = count
    scoreBoard.text = "Balls in Cup = " .. score

end

timer.performWithDelay( 20, updateScore, 0 )

local function onTouch(event)
     print("POS.X = " .. event.x, "POS.Y = ".. event.y);
end

--Runtime:addEventListener("tap",onTouch);

forceBox:setFillColor(1,1,1 )
forceBox:addEventListener( "tap", force )

addBox:setFillColor( 0,1,0) 
addBox:addEventListener( "touch", spawnCrate )

destroyBox:setFillColor(1,0,0)
destroyBox:addEventListener( "tap", deleteAllCrates )


local cup1 = cup.new(cupX, cupY, cupWidth, cupHeight, physics)



-- 132, 186, 416, 460