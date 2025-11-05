local module = {}



local function Teleport(ToPart:Part,humanoidRootPart:Part)
    
    humanoidRootPart.CFrame = ToPart.CFrame + Vector3.new(0, 5, 0)
    
end



function module.Teleport(ToPart:Part,player)
   local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    Teleport(ToPart,humanoidRootPart)   
end 


return module
