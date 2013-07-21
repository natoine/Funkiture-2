local state = gstate.new()
local j1Ready = false
local j2Ready = false
local j3Ready = false
local j4Ready = false
local playerQuads = {}
local j1Image = nil
local j2Image = nil
local j3Image = nil
local j4Image = nil
local deltaTimeChangeImagePlayer = 0
local currentImageIndex = 0

function state:init()

	playerQuads[1] = love.graphics.newQuad(0, 0, 128, 128, 1152, 128)
	playerQuads[2] = love.graphics.newQuad(128 * 8, 0, 128, 128, 1152, 128)
	
	j1Image =  love.graphics.newImage("resources/textures/jacksons/jackson1.png")
	j2Image =  love.graphics.newImage("resources/textures/jacksons/jackson2.png")
	j3Image =  love.graphics.newImage("resources/textures/jacksons/jackson3.png")
	j4Image =  love.graphics.newImage("resources/textures/jacksons/jackson4.png")
end


function state:enter()

end


function state:focus()

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
			huds[1] = hud.newplayer(players[1])
		end
		if player2 and joystick == 2 then
			j2Ready = true
			players[2] = player.new(2)
			huds[2] = hud.newplayer(players[2])
		end
		if player3 and joystick == 3 then
			j3Ready = true
			players[3] = player.new(3)
			huds[3] = hud.newplayer(players[3])
		end
		if player4 and joystick == 4 then
			j4Ready = true
			players[4] = player.new(4)
			huds[4] = hud.newplayer(players[4])
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
	love.graphics.setColor(0, 0, 0)

	if player1 then
	
		if j1Ready then
			--sentences are set to an abscisse in accordance with the screen's length--
			love.graphics.print("Player 1 Ready !", ((love.graphics.getWidth()/4)-100)/2, 500)
			
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j1Image, playerQuads[currentImageIndex + 1], 180, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j1Image, playerQuads[1], 180, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			--love.graphics.print("Choose Your Character.", ((love.graphics.getWidth()/4)-100)/2, 300)
			love.graphics.print("When ready press A.", ((love.graphics.getWidth()/4)-100)/2, 350)
		end
	else
		love.graphics.print("Press Start Button",((love.graphics.getWidth()/4)-100)/2, 300)
	end
	if player2 then
		
		if j2Ready then
		
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j2Image, playerQuads[currentImageIndex + 1], 430, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
		
			love.graphics.print("Player 2 Ready !", (((love.graphics.getWidth()/4)-100)*3/2)+100, 500)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j2Image, playerQuads[1], 430, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			--love.graphics.print("Choose Your Character.", (((love.graphics.getWidth()/4)-100)*3/2)+100, 300)
			love.graphics.print("When ready press A.", (((love.graphics.getWidth()/4)-100)*3/2)+100, 350)
		end
	else
		love.graphics.print("Press Start Button",(((love.graphics.getWidth()/4)-100)*3/2)+100, 300)
	end
	if player3 then
		
		if j3Ready then
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j3Image, playerQuads[currentImageIndex + 1], 680, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
		
			love.graphics.print("Player 3 Ready !", (((love.graphics.getWidth()/4)-100)*5/2)+2*100, 500)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j3Image, playerQuads[1], 680, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			--love.graphics.print("Choose Your Character.", (((love.graphics.getWidth()/4)-100)*5/2)+2*100, 300)
			love.graphics.print("When ready press A.", (((love.graphics.getWidth()/4)-100)*5/2)+2*100, 350)
		end
	else
		love.graphics.print("Press Start Button",(((love.graphics.getWidth()/4)-100)*5/2)+2*100, 300)
	end
	if player4 then
		
		if j4Ready then
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j4Image, playerQuads[currentImageIndex + 1], 930, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			
			love.graphics.print("Player 4 Ready !", (((love.graphics.getWidth()/4)-100)*7/2)+3*100, 500)
		else
			love.graphics.setColor(255, 255, 255)
			love.graphics.drawq(j4Image, playerQuads[1], 930, 200, 0, 1, 1, 64, 64)
			love.graphics.setColor(0, 0, 0)
			--love.graphics.print("Choose Your Character.", (((love.graphics.getWidth()/4)-100)*7/2)+3*100, 300)
			love.graphics.print("When ready press A.", (((love.graphics.getWidth()/4)-100)*7/2)+3*100, 350)
		end
	else
		love.graphics.print("Press Start Button", (((love.graphics.getWidth()/4)-100)*7/2)+3*100, 300)
	end
	
	if deltaTimeChangeImagePlayer > 0.2 then
		deltaTimeChangeImagePlayer = 0
		currentImageIndex = (currentImageIndex + 1) % 2
	end
	
	deltaTimeChangeImagePlayer = deltaTimeChangeImagePlayer + love.timer.getDelta()
end

return state
