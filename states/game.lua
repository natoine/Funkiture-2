local state = gstate.new()
local backgroundImageRatioX = 1
local imageRatio = 1
local imageScale = 1
local backgroundImages = {}
local deltaTimeChangeBackground = 0
local currentIndexBackground = 0

function state:init()
	
	backgroundImages[1] = love.graphics.newImage("resources/textures/club/scene1.png")
	backgroundImages[2] = love.graphics.newImage("resources/textures/club/scene3.png")
	backgroundImages[3] = love.graphics.newImage("resources/textures/club/scene4.png")
	backgroundImages[4] = love.graphics.newImage("resources/textures/club/scene2.png")
	
	deltaTimeChangeBackground = love.timer.getDelta()

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
	enemy.update(dt)
end


function state:draw()
	-- background
	if deltaTimeChangeBackground >= 0.250 then
		deltaTimeChangeBackground = 0
		currentIndexBackground = (currentIndexBackground + 1) % #backgroundImages
	end
	
	love.graphics.draw(backgroundImages[currentIndexBackground + 1], love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, backgroundImageRatioX, backgroundImageRatioX, backgroundImages[1]:getWidth() / 2, backgroundImages[1]:getHeight() / 2)
	
	-- game	
	player.draw()
	enemy.draw()
	-- hud
	if players[1] then 
		huds[1]:drawplayer(((love.graphics.getWidth()/4)-150)/2,70)
	end
	if players[2] then
		huds[2]:drawplayer((((love.graphics.getWidth()/4)-150)*3/2)+150,70)
	end
	if players[3] then 
		huds[3]:drawplayer((((love.graphics.getWidth()/4)-150)*5/2)+2*150,70)
	end
	if players[4] then 
		huds[4]:drawplayer((((love.graphics.getWidth()/4)-150)*7/2)+3*150,70)
	end
	
	deltaTimeChangeBackground = deltaTimeChangeBackground + love.timer.getDelta()
	-- hudenemies--
	
	for i, v in ipairs(enemy.all) do
		hudenemies[i] : drawenemy(i*50)
	end
	
end

return state
