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

punchDistance = 70
kickDistance = 90
punchDamage = 4
kickDamage = 2

nbEnemyGenerated = 0

--pour gerer la distance au spawn et la distance au player
distanceBtwEnemies = 60

function enemy.new(number, enemytype)
	local self = setmetatable({},{__index = enemy_mt})
	self.number = number
	self.image = love.graphics.newImage("resources/textures/villagepeople/"..enemytype..".png")
	self.currentcycle = enemy.cycles.walk
	self.frame = 1
	self.curframe = 1
	self.dtime = 0
	self.timer = 0
	table.insert(enemy.all , self)
	table.insert(persos, self)
	return self
end

function enemy.update(dt)	
	-- gestion de la generation d'ennemis	
	if #enemy.all < 1 then
		local newnbenemies = math.floor(math.random(2))
		print("nb enemies : "..#enemy.all.." new nbenemies : "..newnbenemies)
		for i = 1, newnbenemies do
			nbEnemyGenerated = nbEnemyGenerated + 1
			local newenemytype = math.ceil(math.random(1 , #enemyTypes))		
			local newenemy = enemy.new(nbEnemyGenerated , enemyTypes[newenemytype])
			--right or left of the screen
			local testLR = math.random(1)
			if testLR > 0.5 then
				-- tout à gauche 0
				newenemy.x = 0 - distanceBtwEnemies * i
			else
			-- tout à droite love.graphics.getWidth() et du coup left = true
				newenemy.x = love.graphics.getWidth() + distanceBtwEnemies * i
				newenemy.left  = true
			end
		end
	end
	--purge enemies
	local i = 1
	while i <= #enemy.all do
		local v = enemy.all[i]
		if v.purge then
			print("purge "..v.number)
			table.remove(enemy.all , i)
		else 
			v:update(dt)
			i = i + 1
		end
	end
	--purge persos
	i = 1
	while i <= #persos do
		local w = persos[i]
		if w.purge then
			print("purge "..w.number)
			table.remove(persos , i)
		else 
			w:update(dt)
			i = i + 1
		end
	end
end

function enemy.draw()
	for i , v in ipairs(enemy.all) do
		v:draw()
	end
end

function enemy_mt:update(dt)
	
	local nearestPlayerInfo = self:seekNearestPlayer()
	--tapera ou tapera pas
	if self.currentcycle == enemy.cycles.walk or self.currentcycle == enemy.cycles.idle then
		--print("distance :"..nearestPlayerInfo[2])
		if nearestPlayerInfo[2] < distanceBtwEnemies then
			if ( nearestPlayerInfo[1] == 1 and self.left) or (nearestPlayerInfo[1] == -1 and not self.left) then
				local testKick = math.random(1)
				if testKick > 0.5 then 
					self.currentcycle = enemy.cycles.kick
					self.curframe = 1
				else 
					self.currentcycle = enemy.cycles.punch
					self.curframe = 1
				end
			end
		else self.currentcycle = enemy.cycles.walk
		end
	end
	-- anim
	self.dtime = self.dtime + dt
	self.timer = self.timer+dt
	if self.timer>frametime then
		self.timer = self.timer - frametime
		self.curframe = self.curframe + 1
		-- calcul des coups TODO state machines
		if self.currentcycle == enemy.cycles.kick then
			if self.curframe == 2 then
				self:kick()
			end
		elseif self.currentcycle == enemy.cycles.punch then
			if self.curframe == 2 then
				self:punch()
			end
		end
			if self.curframe > #self.currentcycle then
				if not(self.currentcycle == enemy.cycles.walk) then
					self.currentcycle = enemy.cycles.walk	
				end			
				self.curframe = 1
			end
		end
		
	--deplacement
	local lastX = self.x
	if self.x >= love.graphics.getWidth() then
		self.left = true
	elseif self.x <= 0 then
		self.left = false
	end
	if nearestPlayerInfo[2] > distanceBtwEnemies then
		local intensity = self:getDirection()
		local xintensity = intensity[1]	
		self.x = self.x + self.speed * xintensity * dt
		if xintensity < 0 then
			self.left = true
		else 
			self.left = false
		end
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
end

-- Retourne un tableau : en première case (x) et en deuxième case (y)
function enemy_mt:getDirection()
	local abscisses = self:seekNearestPlayer()[1]
	local ordonnees = love.joystick.getAxis(self.number, 2)	
	return {abscisses , ordonnees}
end

--Retourne la direction [1] si 1 vers la gauche, -1 vers la droite et la distance[2] a l'ennemi le plus proche
function enemy_mt:seekNearestPlayer()
	local nearestDistance = love.graphics.getWidth()
	local direction = 1
	if self.left then direction = -1 end
	for i , v in ipairs(player.all) do
		local distance = math.abs(self.x - v.x)
		if distance < nearestDistance then
			nearestDistance = distance
			if self.x - v.x > 0 then direction = -1
			else direction = 1
			end
		end
	end
	return {direction , nearestDistance}
end

function enemy_mt:draw()
	love.graphics.setColor(255,255,255)
	
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

function enemy_mt:looseLife(lesslife)
	self.life = self.life - lesslife
	print(self.number.."remaining life"..self.life)
	if self.life <= 0 then
		self.purge = true
	end
end

function enemy_mt:isInGoodDirection(x)
	if self.left then
		if x < self.x then return true
		else return false
		end
	else 
		if x > self.x then return true
		else return false
		end
	end
end

function enemy_mt:punch()
	--print("punch")
	for i , v in ipairs(persos) do
	--	print(v.number)
		if not ( v == self ) then
			local distance = math.abs(self.x - v.x)
	--		print(distance)
			if distance < punchDistance and self:isInGoodDirection(v.x) then
				v:looseLife(punchDamage)
			end
		end
	end
end

function enemy_mt:kick()
	--print("kick")
	for i , v in ipairs(persos) do
	--	print(v.number)
		if not ( v == self ) then
			local distance = math.abs(self.x - v.x)
	--		print(distance)
			if distance < kickDistance and self:isInGoodDirection(v.x) then
				v:looseLife(kickDamage)
			end
		end
	end
end

return enemy
