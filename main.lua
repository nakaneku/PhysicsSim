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

local sky = display.newImage( "bkg_clouds.png")
sky.x = 160
sky.y = 195

local ground = display.newImage( "ground.png")
ground.x = 160
ground.y = 445

physics.addBody( ground, "static", {friction=0.5, bounce=0.0} )

local crateList = {}

local removeCrate = function( event )
	event.target:removeSelf( )
	event.target = nil
end

local function spawnCrate()
	local x = math.random(40,290)
	local y = 0
	local crate = display.newCircle( x, y, 10 )
	crate:setFillColor( 1,0,0 )
	crate.rotation = math.random(0,360)
	physics.addBody( crate, {density=3.0, friction=0.5, bounce=0.2} )
	crate:addEventListener( "touch", removeCrate)
	crateList[#crateList +1] = crate
end

local function deleteAllCrates()
	for k, v in ipairs(crateList) do
		if (v ~= nil ) then
			v:removeSelf( )
			v = nil
		end
	end
	crateList = nil
	crateList = {}
end

local leftBoundary = display.newRect( 20, 300, 5, 960 )
leftBoundary:setFillColor( "black" )
physics.addBody( leftBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local rightBoundary = display.newRect( 300, 300, 5, 960 )
rightBoundary:setFillColor( "black" )
physics.addBody( rightBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local addBox = display.newRect( 100, 500, 50, 50 )
local destroyBox = display.newRect(200,500,50,50)
local forceBox = display.newRect(300, 500, 50, 50)

local force = function(event)
	local xforce = math.random(100,200);
	local yforce = math.random(100,200);
	for k, v in ipairs(crateList) do
		v:applyForce( 100, 200)		
	end

end

forceBox:setFillColor(1,1,1 )
forceBox:addEventListener( "tap", force )

addBox:setFillColor( 0,1,0) 
addBox:addEventListener( "touch", spawnCrate )

destroyBox:setFillColor(1,0,0)
destroyBox:addEventListener( "tap", deleteAllCrates )


