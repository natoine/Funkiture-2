local enemy_mt = {x = 100, speed = 50, life = 100, score = 0, combo = 0, left = false}
local enemy = {}
--local kickdamage = 10--
--local punchdamage = 10--

enemy.all = {}
enemy.quad = {}
for i=1, 8 do
	table.insert (enemy.quad, love.graphics.newQuad(128*(i-1),0,128,128,1024,128))
end

enemy.cycles = {}
enemy.cycles.idle = {1}
enemy.cycles.walk = {2, 3, 4, 3}
enemy.cycles.punch = {5, 6}
enemy.cycles.kick = {7, 8}

frametime = 1/10

enemy.type = {"indian" , "worker", "cowboy"}

function enemy.new()
	local self = setmetatable({},{__index = enemy_mt})
	local typeNb = math.floor(math.random(#enemy.type))
	self.image = love.graphics.newImage("resources/textures/enemies/"..enemy.type[typeNb]..".png")
	self.currentcycle = enemy.cycles.idle
	self.frame = 1
	self.curframe = 1
	self.dtime = 0
	self.timer = 0
	table.insert(enemy.all , self)
	table.insert(persos, self)
	return self
end

function enemy.update(dt)	
	--kevin purge
	local i = 1
	while i <= #enemy.all do
		local v = enemy.all[i]
		if v.purge then
			table.remove(enemy.all , i)
		else 
			v:update(dt)
			i = i + 1
		end
	end
end

-- Retourne un tableau : en première case (x) et en deuxième case (y)
function enemy_mt:getDirection()
	local abscisses = love.joystick.getAxis(self.number, 1)
	local ordonnees = love.joystick.getAxis(self.number, 2)	
	return {abscisses , ordonnees}
end

function enemy_mt:isAButtonPressed()
	return love.joystick.isDown(self.number, 1)
end

function enemy_mt:isXButtonPressed()
	return love.joystick.isDown(self.number, 3)
end

--function enemy_mt:setLife(x)
	--self.life = self.life + x
--end--

--function enemy_mt:punchAttack(enemy)
	--enemy:setLife(punchdamage)
--end--

--function enemy_mt:kickAttack(enemy)--
--	enemy:setLife(kickdamage)--
--end--

function enemy.draw()
	for i , v in ipairs(enemy.all) do
		v:draw()
	end
end

function enemy.joystickpressed(joystick, button)
	-- ici lancer l'animation correspondante au joueur
	if button == 3 then	
		enemys[joystick].currentcycle = enemy.cycles.punch
		enemys[joystick].curframe = 1
	end
	if button == 1 then
		enemys[joystick].currentcycle = enemy.cycles.kick
		enemys[joystick].curframe = 1
	end
end

function enemy.joystickreleased(joystick, button)
	-- ici arreter l'animation courante et mettre idle
	enemys[joystick].currentcycle = enemy.cycles.idle
	enemys[joystick].curframe = 1
end

function enemy_mt:update(dt)
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
	if self.currentcycle == enemy.cycles.idle and ( lastX - self.x > 0.03 or lastX - self.x < -0.03) then
		self.currentcycle = enemy.cycles.walk
		self.curframe = 1
 	elseif self.currentcycle == enemy.cycles.walk then
		if lastX - self.x < 0.03 and lastX - self.x > -0.03 then
			self.currentcycle = enemy.cycles.idle
			self.curframe = 1
		end
	end
	if love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end		
end

function enemy_mt:draw()

	if self.left then
		love.graphics.drawq(self.image, enemy.quad[self.currentcycle[self.curframe]], self.x - 64, 400, 0, -1, 1, 64 , 64 )	
	else
		love.graphics.drawq(self.image, enemy.quad[self.currentcycle[self.curframe]], self.x, 400, 0, 1, 1, 64 , 64 )
	end
	if self.dtime>100 then 
		self.frame = self.frame + 1
		self.dtime = 0
	end
end

return enemy
