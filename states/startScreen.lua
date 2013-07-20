local state = gstate.new()
image = love.graphics.newImage("resources/textures/jackson1.png")
quad = {}
for i=1, 8 do
	table.insert (quad, love.graphics.newQuad(128*(i-1),0,128,128,image:getWidth(),image:getHeight()))
end
cycles = {}
cycles.idle = {1}
cycles.walk = {2, 3, 4, 3}
cycles.punch = {5, 6}
cycles.kick = {7, 8}
currentcycle = cycles.walk
curframe = 1
timer = 0
frametime = 1/10
dtime = 0
frame = 1

function state:init()

end


function state:enter()

end


function state:focus()

end


function state:mousepressed(x, y, btn)

end


function state:mousereleased(x, y, btn)

end


function state:joystickpressed(joystick, button)
	-- Button 8 == start	
	if button == 8 then
		if joystick == 1 then
			player1 = true
		end
		if joystick == 2 then
			player2 = true
		end
		if joystick == 3 then
			player3 = true
		end
		if joystick == 4 then
			player4 = true
		end
		countPlayers = 1
		gstate.switch(choosePlayer)
	end
end


function state:joystickreleased(joystick, button)

end


function state:quit()

end


function state:keypressed(key, uni)
	
end


function state:keyreleased(key, uni)

end


function state:update(dt)
	dtime = dtime + dt
	timer = timer+dt
	if timer>frametime then
		timer = timer - frametime
		curframe = curframe + 1
		if curframe > #currentcycle then
			curframe = 1
		end
	end
		
end


function state:draw()
	love.graphics.setBackgroundColor(255,255,255)
	love.graphics.setColor(0,0,0)
	love.graphics.print("Press Start Button", 400, 300)
	love.graphics.drawq(image,quad[currentcycle[curframe]],134,168)
	if dtime>100 then 
		frame = frame + 1
		dtime = 0
	end
end
return state