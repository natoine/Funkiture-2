local hud_mt = {}
local hud = {}

function hud.new(player)
	local self = setmetatable({},{__index = hud_mt})
	self.player = player
	return self
end

function hud_mt:draw(x,y)
	--love.graphics.print("player "..self.player.number.." : ".. self.player.life  , x, y)--
	love.graphics.setColor(255,255,255,200)
	love.graphics.rectangle("fill",x,y,150,20)
	love.graphics.setColor(255,0,0,200)
	love.graphics.rectangle("fill",x+5,y+5,140,10)
	love.graphics.setColor(51,255,51,200)
	love.graphics.rectangle("fill",x+5,y+5,140*self.player.life*0.01,10)
	love.graphics.setColor(255,255,255,255)
	love.graphics.print("player "..self.player.number,x+50,y-40)
end

return hud
