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
ballList = {}
local cup = require("cup")
local init =  require("initializeGame1")
local scoreboard = require("scoreboard")
local totalScore = require("RunningScore")
local selectedBall


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

local speed = -50
local function moveCup()
	cup1:move(-speed)
	speed = -speed
end

timer.performWithDelay(3000, moveCup, 0)

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

local initTouchX
local initTouchY
local drawLine = nil
local function onTouch(event)
     print("POS.X = " .. event.x, "POS.Y = ".. event.y);
     if (event.phase == "began") then
     	print("began hit")
     	initTouchX = event.x
     	initTouchY = event.y

     elseif(event.phase == "moved") then
     	drawLine = nil
     	drawLine = display.newLine( initTouchX, initTouchY, event.x, event.y )
     	drawLine:setStrokeColor(0.7,0,0.7)
     	drawLine.strokeWidth = 3

     elseif(event.phase == "ended") then

     end

end


local addBox = display.newRect( 50, 500, 50, 50 )
local destroyBox = display.newRect(120,500,50,50)
local forceBox = display.newRect(190, 500, 50, 50)

Runtime:addEventListener("touch",onTouch);



forceBox:setFillColor(1,1,1 )
forceBox:addEventListener( "tap", force )

addBox:setFillColor( 0,1,0) 
addBox:addEventListener( "touch", spawnBall )

destroyBox:setFillColor(1,0,0)
destroyBox:addEventListener( "tap", deleteAllBalls )


local initX =0
local initY =0

--Adding individual ball force
function ballDrag( event )
	local phase = event.phase

	if (phase == "began") then
		print("began")
		initX = event.x
		initY = event.y	
		display.getCurrentStage( ):setFocus( event.target)	
	elseif(phase == "moved") then

	elseif (phase == "ended") then
		print("ended")
		local newX = event.x
		local newY = event.y
		event.target:applyForce( newX - initX , newY - initY, event.target.x, event.target.y)
		display.getCurrentStage( ):setFocus( nil )
	end

end

