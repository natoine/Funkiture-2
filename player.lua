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
	--player 1
	direction1 = love.joystick.getAxis( 1, 1 )
	direction2 = love.joystick.getAxis( 1, 2 )
	direction3 = love.joystick.getAxis( 1, 3 )
	direction4 = love.joystick.getAxis( 1, 4 )
	direction5 = love.joystick.getAxis( 1, 5 )
	direction6 = love.joystick.getAxis( 1, 6 )
	--print("direction1 : "..direction1.." direction2 : "..direction2.." direction3 : "..direction3)
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

function player.draw()
	love.graphics.print("direction3 : "..direction3, 100, 100)
	love.graphics.print("direction4 : "..direction4, 100, 200)
	love.graphics.print("direction5 : "..direction5, 100, 300)
	love.graphics.print("direction6 : "..direction6, 100, 400)
	for i , v in ipairs(player.all) do
		v:draw()
	end
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
