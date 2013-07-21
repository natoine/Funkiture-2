local state = gstate.new()
local backgroundImageRatioX = 1
local imageRatio = 1
local imageScale = 1
local backgroundImages = {}

function state:init()
	
	backgroundImages[1] = love.graphics.newImage("resources/textures/scene.png")

	backgroundImageRatioX = love.graphics.getWidth() / backgroundImages[1]:getWidth()
	imageRatio = backgroundImages[1]:getWidth() / backgroundImages[1]:getHeight()
	
	
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
	love.graphics.draw(backgroundImages[1], love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, backgroundImageRatioX, backgroundImageRatioX, backgroundImages[1]:getWidth() / 2, backgroundImages[1]:getHeight() / 2)
	
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
