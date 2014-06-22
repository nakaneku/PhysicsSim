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
sky.y = 250

local ground = display.newImage( "ground.png")
ground.x = 160
ground.y = 500

physics.addBody( ground, "static", {friction=0.5, bounce=0.0} )

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

local leftBoundary = display.newRect( 0, display.contentCenterY, 5, display.actualContentHeight )
leftBoundary:setFillColor( 1,1,1 )
physics.addBody( leftBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local rightBoundary = display.newRect( display.contentWidth, display.contentCenterY, 5, display.actualContentHeight )
rightBoundary:setFillColor( 1,1,1  )
physics.addBody( rightBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local topBoundary = display.newRect( display.contentCenterX, -40, display.actualContentWidth, 5 )
topBoundary:setFillColor( 1,1,1  )
physics.addBody( topBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

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

forceBox:setFillColor(1,1,1 )
forceBox:addEventListener( "tap", force )

addBox:setFillColor( 0,1,0) 
addBox:addEventListener( "touch", spawnCrate )

destroyBox:setFillColor(1,0,0)
destroyBox:addEventListener( "tap", deleteAllCrates )


