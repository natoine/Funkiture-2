function love.load()
	gstate = require "gamestate"
	--imports des states rq de Kevin ça peut s'automatiser donc TODO improve here
	startScreen = require("states/startScreen")
	choosePlayer = require("states/choosePlayer")
	game = require("states/game")
	gstate.switch(startScreen)

	-- variables pour savoir qui va jouer
	player1 = false
	player2 = false
	player3 = false
	player4 = false
	-- variable pour connaître le nombre de joueurs
	countPlayers = 0
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
