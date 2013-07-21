local player_mt = {x = 100, speed = 50, life = 100, score = 0, combo = 0, left = false}
local player = {}
--local kickdamage = 10--
--local punchdamage = 10--

player.all = {}
player.quad = {}
for i=1, 8 do
	table.insert (player.quad, love.graphics.newQuad(128*(i-1),0,128,128,1024,128))
end

player.cycles = {}
player.cycles.idle = {1}
player.cycles.walk = {2, 3, 4, 3}
player.cycles.punch = {5, 6}
player.cycles.kick = {7, 8}

frametime = 1/10

function player.new(number)
	local self = setmetatable({},{__index = player_mt})
	self.number = number
	self.image = love.graphics.newImage("resources/textures/jacksons/jackson"..number..".png")
	self.currentcycle = player.cycles.idle
	self.frame = 1
	self.curframe = 1
	self.dtime = 0
	self.timer = 0
	table.insert(player.all , self)
	return self
end

function player.update(dt)	
	--kevin purge
	local i = 1
	while i <= #player.all do
		local v = player.all[i]
		if v.purge then
			table.remove(player.all , i)
		else 
			v:update(dt)
			i = i + 1
		end
	end
end

-- Retourne un tableau : en première case (x) et en deuxième case (y)
function player_mt:getDirection()
	local abscisses = love.joystick.getAxis(self.number, 1)
	local ordonnees = love.joystick.getAxis(self.number, 2)	
	return {abscisses , ordonnees}
end

function player_mt:isAButtonPressed()
	return love.joystick.isDown(self.number, 1)
end

function player_mt:isXButtonPressed()
	return love.joystick.isDown(self.number, 3)
end

--function player_mt:setLife(x)
	--self.life = self.life + x
--end--

--function player_mt:punchAttack(player)
	--player:setLife(punchdamage)
--end--

--function player_mt:kickAttack(player)--
--	player:setLife(kickdamage)--
--end--

function player.draw()
	for i , v in ipairs(player.all) do
		v:draw()
	end
end

function player.joystickpressed(joystick, button)
	-- ici lancer l'animation correspondante au joueur
	if button == 3 then	
		players[joystick].currentcycle = player.cycles.punch
		players[joystick].curframe = 1
	end
	if button == 1 then
		players[joystick].currentcycle = player.cycles.kick
		players[joystick].curframe = 1
	end
end

function player.joystickreleased(joystick, button)
	-- ici arreter l'animation courante et mettre idle
	players[joystick].currentcycle = player.cycles.idle
	players[joystick].curframe = 1
end

function player_mt:update(dt)
	-- anim
	self.dtime = self.dtime + dt
	self.timer = self.timer+dt
	if self.timer>frametime then
		self.timer = self.timer - frametime
		self.curframe = self.curframe + 1
		if self.curframe > #self.currentcycle then
			self.curframe = 1
		end
	end	
	--deplacement
	local intensity = self:getDirection()
	local xintensity = intensity[1]
	local lastX = self.x	
	self.x = self.x + self.speed * xintensity * dt
	if xintensity < 0 then
		self.left = true
	else 
		self.left = false
	end 
	--print(lastX - self.x)
	--0.03 seuil empririque TODO passer en variable 
	if self.currentcycle == player.cycles.idle and ( lastX - self.x > 0.03 or lastX - self.x < -0.03) then
		self.currentcycle = player.cycles.walk
		self.curframe = 1
 	elseif self.currentcycle == player.cycles.walk then
		if lastX - self.x < 0.03 and lastX - self.x > -0.03 then
			self.currentcycle = player.cycles.idle
			self.curframe = 1
		end
	end
	if love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end		
end

function player_mt:draw()
	love.graphics.setColor(255,255,255)
	
	if self.left then
		love.graphics.drawq(self.image, player.quad[self.currentcycle[self.curframe]], self.x - 64, 400, 0, -1, 1, 64 , 64 )	
	else
		love.graphics.drawq(self.image, player.quad[self.currentcycle[self.curframe]], self.x, 400, 0, 1, 1, 64 , 64 )
	end
	if self.dtime>100 then 
		self.frame = self.frame + 1
		self.dtime = 0
	end
end

return player
