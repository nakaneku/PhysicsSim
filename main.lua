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
physics.start()
local cup = require("cup")
local init =  require("initializeGame1")
local scoreboard = require("scoreboard")

local ballList = {}

local removeBall = function( event )
	event.target:removeSelf( )
	ballList[event.target] = nil
	event.target = nil

end

local function spawnBall()
	local x = math.random(40,290)
	local y = 0
	local ball = display.newCircle( x, y, 10)
	ball:setFillColor( 1,0,0 )
	ball.rotation = math.random(0,360)
	physics.addBody( ball, {density=0.1, friction=0.5, bounce=0.2} )
	ball:addEventListener( "touch", ballDrag) --switch from removeBall
	ballList[ball] = ball
end

local function deleteAllBalls()
	for k, v in pairs(ballList) do
		if (k ~= nil ) then
			k:removeSelf( )
			k = nil
			table.remove(ballList, k)
		end
	end
	ballList = nil
	ballList = {}
end

-- Creating a Cup

local cupX = 100
local cupY = 100
local cupHeight = 50
local cupWidth = 40

local cup1 = cup.new(cupX, cupY, cupWidth, cupHeight, physics)
scoreboard.setCupArea(cupX, cupY, cupHeight, cupWidth)

local force = function(event)
	local xforce = math.random(20,50);
	local yforce = math.random(20,50);
	for k, v in pairs(ballList) do
		if(k ~= nil) then
			if(xforce %2 == 0)then
				xforce = -xforce
			end
			k:applyForce( xforce, -yforce, k.x, k.y)		
		end
	end

end


local function updateScore(event)
	scoreboard.updateScore(ballList)
end

timer.performWithDelay( 20, updateScore, 0 )

local function onTouch(event)
     print("POS.X = " .. event.x, "POS.Y = ".. event.y);
end


local addBox = display.newRect( 50, 500, 50, 50 )
local destroyBox = display.newRect(120,500,50,50)
local forceBox = display.newRect(190, 500, 50, 50)

--Runtime:addEventListener("tap",onTouch);

forceBox:setFillColor(1,1,1 )
forceBox:addEventListener( "tap", force )

addBox:setFillColor( 0,1,0) 
addBox:addEventListener( "touch", spawnBall )

destroyBox:setFillColor(1,0,0)
destroyBox:addEventListener( "tap", deleteAllBalls )


--Adding individual ball force
local initX
local initY
function ballDrag( event )

	if (event.phase == "began") then
		initX = event.x
		initY = event.y		
	elseif (event.phase == "moved") then
		local newX = event.x
		local newY = event.y
		event.target:applyForce( newX - initX , newY - initY, event.target.x, event.target.y)
	end

end

