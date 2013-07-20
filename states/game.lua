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
	-- game	
	player.draw()
	-- hud
	if players[1] then 
		huds[1]:draw(20,70)
	end
	if players[2] then
		huds[2]:draw(210,70)
	end
	if players[3] then 
		huds[3]:draw(400,70)
	end
	if players[4] then 
		huds[4]:draw(590,70)
	end
end

return state
