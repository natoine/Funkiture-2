local state = gstate.new()

function state:init()
end


function state:enter()

end


function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)

end


function state:joystickpressed(joystick, button)

end


function state:joystickreleased(joystick, button)

end


function state:quit()

end


function state:keypressed(key, uni)
	
end


function state:keyreleased(key, uni)

end


function state:update(dt)
	player.update(dt)
end


function state:draw()
	love.graphics.print("Game !!!", 400, 300)
	if players[1] then 
		love.graphics.print("player 1 : ".. players[1].life , 100, 500);
	end
	if players[2] then
		love.graphics.print("player 2 : ".. players[2].life  , 300, 500);
	end
	if players[3] then 
		love.graphics.print("player 3 : ".. players[3].life  , 500, 500);
	end
	if players[4] then 
		love.graphics.print("player 4 : ".. players[4].life  , 700, 500);
	end
end

return state
