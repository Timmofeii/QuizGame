local module = {}
--local objs = quithCube:GetChildren()

function module.rotateGradient(gradient)
	while task.wait(0.05) do
		gradient.Rotation = gradient.Rotation + 5
	end
end

--for _, obj in ipairs(objs) do
--    if obj:IsA("SurfaceGui") then
--        local textlabel = obj.TextLabel

--        local gradient = textlabel.UIGradient
--        task.spawn(function()
--            rotateGradient(gradient)
--            end)
--    end
--end

function module.rotatePart(part, step)
	while task.wait(0.05) do
		part.CFrame = part.CFrame * CFrame.Angles(math.rad(step), math.rad(step), 0)
	end
end

return module
