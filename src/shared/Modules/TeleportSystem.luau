local module = {}


local function TeleportSingle(ToPart:Part,humanoidRootPart:Part)
    
    humanoidRootPart.CFrame = ToPart.CFrame + Vector3.new(0, 5, 0)
    
end


function module.Teleport(ToPart: Part, player)
	local character = player.Character
	if not character then return end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	TeleportSingle(ToPart, hrp)
end

function module.TeleportBatch(ToPart: Part, players: {Player})
	for _, player in ipairs(players) do
		module.Teleport(ToPart, player)
	end
end

return module
