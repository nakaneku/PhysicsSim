--scoreboard.lua

local t = {}
t.score = 0

-- Create first multi-line text object
local options1 = 
{
    text = "Balls in Cup = " .. t.score,
    y = -10,
    x = 230,
    width = 200, 
    font = native.systemFont,
    fontSize = 18
}

local scoreBoard = display.newText( options1)
scoreBoard:setFillColor( 1, 1, 1 )

t.setCupArea = function (cupX, cupY, cupHeight, cupWidth)
	t.cupX = cupX
	t.cupY = cupY
	t.cupHeight = cupHeight
	t.cupWidth = cupWidth
end

t.updateScore = function(ballList)
	local count = 0
    for ball, v in pairs(ballList) do
    	if(ballWithinArea(ball, t.cupX-t.cupWidth/2, t.cupX+t.cupWidth/2, t.cupY-t.cupHeight/2, t.cupY+t.cupHeight/2))then
    		count = count +1
    	end
    end
    t.score = count
    scoreBoard.text = "Balls in Cup = " .. count 
end

--Figure out how to not make this global.
function ballWithinArea(ball, xLow, xHigh, yLow, yHigh)
	if (ball.x <= xHigh and ball.x >= xLow and ball.y >= yLow and ball.y <= yHigh) then
		return true
	end
	return false
end

return t