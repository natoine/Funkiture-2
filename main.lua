function love.load()
	gstate = require "gamestate"
	--imports des states rq de Kevin ça peut s'automatiser donc TODO improve here
	startScreen = require("states/startScreen")
	choosePlayer = require("states/choosePlayer")
	game = require("states/game")
	gstate.switch(startScreen)

	--import de player
	player = require("player")
	--import de hud--
	hud = require("hud")

	-- variables pour savoir qui va jouer
	player1 = false
	player2 = false
	player3 = false
	player4 = false
	-- variable pour connaître le nombre de joueurs
	countPlayers = 0
	--tableau des joueurs
	players = {}
	--tableau des huds--
	huds = {}
	
	-- musiques
	musics = {}
	currentMusicIndex = 1
	musics[1] = love.audio.newSource("resources/Sounds/music1.mp3", "stream")
	musics[2] = love.audio.newSource("resources/Sounds/music2.mp3", "stream")
	musics[3] = love.audio.newSource("resources/Sounds/music3.mp3", "stream")
	musics[4] = love.audio.newSource("resources/Sounds/music4.mp3", "stream")
	urrentMusicIndex = math.round(math.random(1, 4))
	
	love.audio.play(musics[currentMusicIndex])
end

function love.joystickpressed(joystick, button)
	gstate.joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	gstate.joystickreleased(joystick, button)
end

function love.update(dt)
	gstate.update(dt)
	if(musics[currentMusicIndex]:isStopped()) then
		musics[currentMusicIndex]:rewind()
		currentMusicIndex = math.round(math.random(1, 5))
		love.audio.play(musics[currentMusicIndex])
	end
end

function love.draw()
	gstate.draw()
end

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
