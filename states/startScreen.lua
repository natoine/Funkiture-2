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
	-- Button 8 == start	
	if button == 8 then
		if joystick == 1 then
			player1 = true
		end
		if joystick == 2 then
			player2 = true
		end
		if joystick == 3 then
			player3 = true
		end
		if joystick == 4 then
			player4 = true
		end
		gstate.switch(choosePlayer)
	end
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
	
end


function state:draw()
	love.graphics.print("Press Start Button", 400, 300)
end

return state
