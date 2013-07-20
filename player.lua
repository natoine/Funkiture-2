local player_mt = {x = 100, speed = 10, life = 100, score = 0, combo = 0}
local player = {}

player.all = {}

function player.new(number)
	local self = setmetatable({},{__index = player_mt})
	self.number = number
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
end

function player.joystickreleased(joystick, button)
	-- ici arreter l'animation courante et mettre idle
end

function player_mt:update(dt)
	if love.keyboard.isDown("left") then
		self.x = self.x - self.speed * dt
	end
	
	if love.keyboard.isDown("right") then
		self.x = self.x + self.speed * dt
	end		
end

function player_mt:draw()
	--penser à centrer en faisant pos X - hauteur / 2, pos Y - largeur /2
	love.graphics.rectangle("fill", self.x - 50 / 2, 100 - 50 / 2, 50, 50)
	
end

return player
