local hud_mt = {}
local hud = {}

function hud.new(player)
	local self = setmetatable({},{__index = hud_mt})
	self.player = player
	return self
end

function hud_mt:draw(x,y)
	love.graphics.print("player "..self.player.number.." : ".. self.player.life  , x, y)
end

return hud
