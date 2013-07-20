local player_mt = {y = 100, life = 100, score = 0, combo = 0}
local player = {}

player.all = {}

function player.new(number)
	local self = setmetatable({},{__index = player_mt})
	self.number = number
	table.insert(player.all , self)
	return self
end

function player.update(dt)
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
	for i , v in ipairs(player.all) do
		v:draw()
	end
end

function player_mt:update(dt)
	if love.keyboard.isDown("left") then
		self.x = self.x - speed * dt
	end
	if love.keyboard.isDown("right") then
		self.x = self.x + speed * dt
	end
	if love.keyboard.isDown("up") then
		self.y = self.y - speed * dt
	end
	if love.keyboard.isDown("down") then
		self.y = self.y + speed * dt
	end
end

function player_mt:draw()
	--penser à centrer en faisant pos X - hauteur / 2, pos Y - largeur /2
	love.graphics.rectangle("fill", self.x - 50 / 2, self.y - 50 / 2, 50, 50)
end

return player
