local state = gstate.new()
local backgroundImageRatioX = 1
local imageRatio = 1
local imageScale = 1
local backgroundImages = {}
local deltaTimeChangeBackground = 0
local currentIndexBackground = 0
local bigBafflesImages = {}
local smallBafflesImages = {}
local currentBafflesQuad = 0
local deltaTimeChangeBaffle = 0
local bigBafflesQuads = {}
local imageGameOver = nil

function state:init()
	
	backgroundImages[1] = love.graphics.newImage("resources/textures/club/scene1.png")
	backgroundImages[2] = love.graphics.newImage("resources/textures/club/scene3.png")
	backgroundImages[3] = love.graphics.newImage("resources/textures/club/scene4.png")
	backgroundImages[4] = love.graphics.newImage("resources/textures/club/scene2.png")
	
	bigBafflesImages[1] = love.graphics.newImage("resources/textures/club/bafflebig.png")

	smallBafflesImages[1] = love.graphics.newImage("resources/textures/club/bafflesmall.png")
	
	imageGameOver = love.graphics.newImage("resources/textures/hud/gameover.png")
	
	deltaTimeChangeBackground = love.timer.getDelta()
	deltaTimeChangeBaffles = love.timer.getDelta()
	
	for i=1, 3 do
		table.insert (bigBafflesQuads, love.graphics.newQuad((i-1) * 96, 0, 96, 140, 288, 140))
	end

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
	
	if deltaTimeChangeBaffles >= 0.2 then
		deltaTimeChangeBaffles = 0
		currentBafflesQuad = (currentBafflesQuad + 1) % 2
	end
	
	love.graphics.setColor(255, 255, 255)
	
	-- dessin du background
	love.graphics.draw(backgroundImages[currentIndexBackground + 1], love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 0, backgroundImageRatioX, backgroundImageRatioX, backgroundImages[1]:getWidth() / 2, backgroundImages[1]:getHeight() / 2)
	
	-- dessin des baffles
	love.graphics.drawq(bigBafflesImages[1], bigBafflesQuads[currentBafflesQuad + 1], 100, 300, 0, 1, 1, 64, 64)
	love.graphics.drawq(bigBafflesImages[1], bigBafflesQuads[currentBafflesQuad + 1], 900, 300, 0, 1, 1, 64, 64)
	
	
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
	
	love.graphics.setColor(255, 0, 0)
	
	if #player.all == 0 then
		love.graphics.draw(imageGameOver, (love.graphics.getWidth() / 2) - (512 / 2), (love.graphics.getHeight() / 2) - (256 / 2), 0, 1, 1, 0, 0)
	end
	
	deltaTimeChangeBackground = deltaTimeChangeBackground + love.timer.getDelta()
	deltaTimeChangeBaffles = deltaTimeChangeBaffles + love.timer.getDelta()
	
	-- hudenemies--
	
	for i, v in ipairs(enemy.all) do
		hudenemies[i] : drawenemy(i*50)
	end
end

return state
