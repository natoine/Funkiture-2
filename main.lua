function love.load()
	gstate = require "gamestate"
	startScreen = require("states/startScreen")
	gstate.switch(startScreen)
end

function love.joystickpressed(joystick, button)
	gstate.joystickpressed(joystick, button)
end

function love.update(dt)
	gstate.update(dt)
end

function love.draw()
	gstate.draw()
end
