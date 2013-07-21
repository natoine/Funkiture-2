local hud_mt = {}
local hud = {}
imagelife = love.graphics.newImage("resources/textures/hud/life.png")
quad3 = love.graphics.newQuad(11, 12, 50, 37, 1024,128)
--quad = {}
--table.insert(quad, love.graphics.newQuad(0,0,128,32,128,64))
--table.insert(quad, love.graphics.newQuad(0,32,128,32,128,64))--
quad1 = love.graphics.newQuad(0,32,128,32,128,64)

function hud.newplayer(player)
	local self = setmetatable({},{__index = hud_mt})
	self.player = player
	return self
end

function hud.newenemy(enemy)
	local self = setmetatable({},{__index = hud_mt})
	self.enemy = enemy
	return self
end

function hud_mt:drawplayer(x,y)
	--love.graphics.print("player "..self.player.number.." : ".. self.player.life  , x, y)--
	love.graphics.setColor(255,255,255,200)
	love.graphics.drawq(imagelife, quad1,x + 10 + imagelife:getWidth()/2,y + imagelife:getHeight()/4,0,1,1,imagelife:getWidth()/2,imagelife:getHeight()/4)
	if self.player.life > 0 then
		local quad2 = love.graphics.newQuad(0,0,128*self.player.life/100,32,128,64)
		love.graphics.drawq(imagelife, quad2,x+ 10 + imagelife:getWidth()/2,y + imagelife:getHeight()/4,0,1,1,imagelife:getWidth()/2,imagelife:getHeight()/4)
	end
	love.graphics.setColor(0,0,0,200)
	love.graphics.print("player "..self.player.number,x+50,y-40)
	love.graphics.print("score : "..self.player.score,x+50,y+40)
end

function hud_mt : drawenemy (y)	
	love.graphics.setColor(255,255,255,200)
	love.graphics.drawq(imagelife, quad1,800 + imagelife:getWidth()/2,y + 100 + imagelife:getHeight()/2,0,1,1,imagelife:getWidth()/2,imagelife:getHeight()/4)
	if self.enemy.life > 0 then
		local quad2 = love.graphics.newQuad(0,0,128*self.enemy.life/100,32,128,64)
		love.graphics.drawq(imagelife, quad2,800+ imagelife:getWidth()/2, y + 100 + imagelife:getHeight()/2,0,1,1,imagelife:getWidth()/2,imagelife:getHeight()/4)
		love.graphics.drawq(self.enemy.image, quad3, 800 - 24, y + 100 + imagelife:getHeight()/2,0,1,1, 36, 30 )
	end
end

return hud
