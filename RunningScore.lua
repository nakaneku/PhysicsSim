local t = {}
t.score = 0

local options1 = 
{
    text = "Score = " .. t.score,
    y = -10,
    x = 100,
    width = 200, 
    font = native.systemFont,
    fontSize = 18
}

local scoreBoard = display.newText( options1)
scoreBoard:setFillColor( 1, 1, 1 )

function incrementScore()
	t.score = t.score + 1
	scoreBoard.text = "Score = " .. t.score

end

return t
