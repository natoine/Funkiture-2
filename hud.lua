local hud_mt = {}
local hud = {}
imagelife = love.graphics.newImage("resources/textures/hud/life.png")
quad = {}
table.insert(quad, love.graphics.newQuad(0,0,128,32,128,64))
table.insert(quad, love.graphics.newQuad(0,32,128,32,128,64))

function hud.new(player)
	local self = setmetatable({},{__index = hud_mt})
	self.player = player
	return self
end

function hud_mt:draw(x,y)
	--love.graphics.print("player "..self.player.number.." : ".. self.player.life  , x, y)--
	--love.graphics.setColor(255,255,255,200)
	--love.graphics.rectangle("fill",x,y,150,20)
	--love.graphics.setColor(255,0,0,200)
	--love.graphics.rectangle("fill",x+5,y+5,140,10)--
	love.graphics.drawq(imagelife, quad[1],x,y,0,1,1,imagelife:getWidth()/2,imagelife:getHeight()/4)
	love.graphics.drawq(imagelife, quad[2],x,y,0,self.player.life/100,imagelife:getWidth()/2,3*imagelife:getHeight()/4)
	love.graphics.setColor(51,255,51,200)
	if self.player.life > 0 then
		love.graphics.rectangle("fill",x+5,y+5,140*self.player.life*0.01,10)
	end
	love.graphics.setColor(0,0,0,200)
	love.graphics.print("player "..self.player.number,x+50,y-40)
	love.graphics.print("score : "..self.player.score,x+50,y+40)
end

return hud
