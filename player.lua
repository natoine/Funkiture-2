local player_mt = {x = 100, speed = 10, life = 100, score = 0, combo = 0}
local player = {}

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

dtime = 0
timer = 0
frametime = 1/10

function player.new(number)
	local self = setmetatable({},{__index = player_mt})
	self.number = number
	self.image = love.graphics.newImage("resources/textures/jackson"..number..".png")
	self.currentcycle = player.cycles.idle
	self.frame = 1
	self.curframe = 1
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
	local abscisses = love.joystick.getAxis(self.number, 1);
	local ordonnees = love.joystick.getAxis(self.number, 2);	
end

function player_mt:isAButtonPressed()
	return love.joystick.isDown(self.number, 1)
end

function player_mt:isXButtonPressed()
	return love.joystick.isDown(self.number, 3)
end

function player.draw()
	for i , v in ipairs(player.all) do
		v:draw()
	end
end

function player.joystickpressed(joystick, button)
	-- ici lancer l'animation correspondante au joueur
	if button == 3 then	
		players[joystick].currentcycle = player.cycles.punch
	end
	if button == 1 then
		players[joystick].currentcycle = player.cycles.kick
	end
end

function player.joystickreleased(joystick, button)
	-- ici arreter l'animation courante et mettre idle
	players[joystick].currentcycle = player.cycles.idle
	players[joystick].curframe = 1
end

function player_mt:update(dt)
	-- anim
	dtime = dtime + dt
	timer = timer+dt
	if timer>frametime then
		timer = timer - frametime
		self.curframe = self.curframe + 1
		if self.curframe > #self.currentcycle then
			self.curframe = 1
		end
	end	

	--etat / cycle
	

	--deplacement
	if love.keyboard.isDown("left") then
		self.x = self.x - self.speed * dt
	end
	
	if love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end		
end

function player_mt:draw()
	love.graphics.drawq(self.image,player.quad[self.currentcycle[self.curframe]],self.x,100)
	if dtime>100 then 
		self.frame = self.frame + 1
		dtime = 0
	end
end

return player
