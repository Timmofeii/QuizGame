local Players = game:GetService("Players")
-- Update path to point directly to installed package
local ProfileService = require(
	game:GetService("ServerScriptService").ServerPackages.ProfileService)


local ProfileTemplate = {
	Coins = 0,
}

local ProfileStore = ProfileService.GetProfileStore("PlayerData", ProfileTemplate)

local ProfileManager = {}
local profiles = {}

-- Загрузка профиля
function ProfileManager:Load(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId, "ForceLoad")
	if not profile then
		player:Kick("Failed to load your data")
		return
	end

	profile:ListenToRelease(function()
		profiles[player] = nil
		player:Kick("Your data was released.")
	end)

	if player:IsDescendantOf(Players) then
		profiles[player] = profile
		player:SetAttribute("Coins", profile.Data.Coins)
	else
		profile:Release()
	end
end

-- Освобождение профиля
function ProfileManager:Release(player)
	local profile = profiles[player]
	if profile then
		profile:Release()
		profiles[player] = nil
	end
end

-- Получить профиль
function ProfileManager:Get(player)
	local profile = profiles[player]
	if profile and profile:IsActive() then
		return profile
	end
	return nil
end

-- Добавить монеты
function ProfileManager:AddCoins(player, amount)
	local profile = self:Get(player)
	if profile then
		profile.Data.Coins += amount
		player:SetAttribute("Coins", profile.Data.Coins)
	end
end

-- Принудительное сохранение
function ProfileManager:Save(player)
	local profile = self:Get(player)
	if profile then
		profile:Save()
	end
end
function ProfileManager:SetupLeaderstats(player)
	local profile = self:Get(player)
	if not profile then return end

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = profile.Data.Coins
	coins.Parent = leaderstats

	-- Слушаем изменения и обновляем профиль
	coins.Changed:Connect(function(newValue)
		local p = self:Get(player)
		if p and p.Data.Coins ~= newValue then
			p.Data.Coins = newValue
		end
	end)
end

return ProfileManager
