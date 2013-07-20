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
		huds[1]:draw(100,500)
	end
	if players[2] then
		huds[2]:draw(300,500)
	end
	if players[3] then 
		huds[3]:draw(500,500)
	end
	if players[4] then 
		huds[4]:draw(700,500)
	end
end

return state
