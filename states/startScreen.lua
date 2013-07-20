local state = gstate.new()

image = love.graphics.newImage("resources/textures/menu.png")
imagebutton = love.graphics.newImage("resources/textures/press_start.png")
timer = 0
frametime = 1/10
angle = 0

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
		countPlayers = 1
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
	timer = timer+dt
	if timer > frametime then
		angle = angle + 1
		timer = timer - frametime
	end
end

function state:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	love.graphics.draw(image,love.graphics.getWidth()/2,love.graphics.getHeight()/2,angle*math.pi*1/24,1.5,1.5,250,174)
	love.graphics.draw(imagebutton,(love.graphics.getWidth()+10)/2,(love.graphics.getHeight()+30)/2,0,1,1,50,50)
end

return state
