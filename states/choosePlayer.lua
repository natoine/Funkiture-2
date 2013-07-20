local state = gstate.new()
local j1Ready = false
local j2Ready = false
local j3Ready = false
local j4Ready = false


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
	-- gérer le joueur qui presse start pour entrer dans le jeu Button 8 == start
	if button == 8 then
		if joystick == 1 and not player1 then
			player1 = true
			countPlayers = countPlayers + 1
		end
		if joystick == 2 and not player2  then
			player2 = true
			countPlayers = countPlayers + 1
		end
		if joystick == 3 and not player3  then
			player3 = true
			countPlayers = countPlayers + 1
		end
		if joystick == 4 and not player4  then
			player4 = true
			countPlayers = countPlayers + 1
		end
	end
	-- gérer le joueur qui a fait son choix et est prêt à jouer Button 1 == A
	-- créer les joueurs aussi
	if button == 1 then
		if player1 and joystick == 1 then
			j1Ready = true
			players[1] = player.new(1)
			huds[1] = hud.new(players[1])
		end
		if player2 and joystick == 2 then
			j2Ready = true
			players[2] = player.new(2)
			huds[2] = hud.new(players[2])
		end
		if player3 and joystick == 3 then
			j3Ready = true
			players[3] = player.new(3)
			huds[3] = hud.new(players[3])
		end
		if player4 and joystick == 4 then
			j4Ready = true
			players[4] = player.new(4)
			huds[4] = hud.new(players[4])
		end
	end
	-- Tester si tous les joueurs sont prêts pour lancer la partie
	local playerReady = 0
	if j1Ready then
		playerReady = playerReady + 1
	end
	if j2Ready then
		playerReady = playerReady + 1
	end
	if j3Ready then
		playerReady = playerReady + 1
	end
	if j4Ready then
		playerReady = playerReady + 1
	end
	if playerReady > 0 and playerReady == countPlayers then
		gstate.switch(game)
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
	if player1 then
		if j1Ready then
			love.graphics.print("Player 1 Ready !", 100, 500)
		else
			love.graphics.print("Choose Your Character.", 100, 300)
			love.graphics.print("When ready press A.", 100, 350)
		end
	else
		love.graphics.print("Press Start Button", 100, 300)
	end
	if player2 then
		if j2Ready then
			love.graphics.print("Player 2 Ready !", 300, 500)
		else
			love.graphics.print("Choose Your Character.", 300, 300)
			love.graphics.print("When ready press A.", 300, 350)
		end
	else
		love.graphics.print("Press Start Button", 300, 300)
	end
	if player3 then
		if j3Ready then
			love.graphics.print("Player 3 Ready !", 500, 500)
		else
			love.graphics.print("Choose Your Character.", 500, 300)
			love.graphics.print("When ready press A.", 500, 350)
		end
	else
		love.graphics.print("Press Start Button", 500, 300)
	end
	if player4 then
		if j4Ready then
			love.graphics.print("Player 4 Ready !", 700, 500)
		else
			love.graphics.print("Choose Your Character.", 700, 300)
			love.graphics.print("When ready press A.", 700, 350)
		end
	else
		love.graphics.print("Press Start Button", 700, 300)
	end
end

return state
