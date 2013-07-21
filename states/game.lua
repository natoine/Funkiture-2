local state = gstate.new()
local quad = nil

function state:init()
	quad = love.graphics.newQuad(0, 0, 1024, 600, 512, 256)
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
	player.joystickpressed(joystick, button)
end


function state:joystickreleased(joystick, button)
	player.joystickreleased(joystick, button)
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
	-- background
	love.graphics.drawq(love.graphics.newImage("resources/textures/scene.png"), quad, 0, 0)
	
	-- game	
	player.draw()
	-- hud
	if players[1] then 
		huds[1]:draw(((love.graphics.getWidth()/4)-150)/2,70)
	end
	if players[2] then
		huds[2]:draw((((love.graphics.getWidth()/4)-150)*3/2)+150,70)
	end
	if players[3] then 
		huds[3]:draw((((love.graphics.getWidth()/4)-150)*5/2)+2*150,70)
	end
	if players[4] then 
		huds[4]:draw((((love.graphics.getWidth()/4)-150)*7/2)+3*150,70)
	end
end

return state
