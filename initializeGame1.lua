--initializeGame1.lua

local t = {}
local physics = require("physics")

local sky = display.newImage( "bkg_clouds.png")
sky.x = 160
sky.y = 250

local ground = display.newImage( "ground.png")
ground.x = 160
ground.y = 500

physics.addBody( ground, "static", {friction=0.5, bounce=0.0} )

local leftBoundary = display.newRect( 0, display.contentCenterY, 5, display.actualContentHeight )
leftBoundary:setFillColor( 1,1,1 )
physics.addBody( leftBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local rightBoundary = display.newRect( display.contentWidth, display.contentCenterY, 5, display.actualContentHeight )
rightBoundary:setFillColor( 1,1,1  )
physics.addBody( rightBoundary, "static", {density=1, friction=0.2, bounce=0.4} )

local topBoundary = display.newRect( display.contentCenterX, -40, display.actualContentWidth, 5 )
topBoundary:setFillColor( 1,1,1  )
physics.addBody( topBoundary, "static", {density=1, friction=0.2, bounce=0.4} )



return t