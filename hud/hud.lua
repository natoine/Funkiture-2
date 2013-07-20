local hud_mt = {}
local hud = {}

function hud.new(player)
	local self = setmetatable({},{__index = hud_mt})
	self.player = player
end
