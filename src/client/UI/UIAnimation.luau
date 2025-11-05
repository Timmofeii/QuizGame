local module = {}
local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local positions = {
	up = UDim2.new(0.5, 0, 0.5, 0),
	down = UDim2.new(0.5, 0, 0.9, 0),
}

local function playTween(frame: Frame, targetPosition: UDim2)
	if not frame or not frame:IsA("GuiObject") then
		warn("UIAnimation: invalid frame")
	end
	local tween = TweenService:Create(frame, tweenInfo, { Position = targetPosition })
	tween:Play()
	return tween
end

function module.Up(frame: Frame)
	return playTween(frame, positions.up)
end

function module.Down(frame: Frame)
	return playTween(frame, positions.down)
end

--!strict
-- Типизация для функции
---@param label TextLabel -- UI элемент, в котором отображаются очки
---@param currentPoints number -- начальное значение очков
---@param finalPoints number -- конечное значение очков
---@param duration number -- длительность анимации в секундах
---@return nil
function module.animationPoints(label: TextLabel, currentPoints: number, finalPoints: number, duration: number)
	local steps = 60
	local delay = duration / steps
	for i = 1, steps do
		currentPoints = math.floor(finalPoints * (i / steps))
		label.Text = tostring(currentPoints)
		task.wait(delay)
	end
	label.Text = tostring(finalPoints)
end
return module
