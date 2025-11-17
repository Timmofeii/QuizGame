local CharacteristicManager = {}
CharacteristicManager.__index = CharacteristicManager

-- Accepts an array of items. Each item may be a string (characteristic text)
-- or a table { id = number, characteristic = string }.
function CharacteristicManager.new(items)
    local self = setmetatable({
        list = {},
        byId = {},
    }, CharacteristicManager)

    if not items then
        return self
    end

    -- Normalize input into tables with numeric ids
    local nextId = 0
    for i, v in ipairs(items) do
        if type(v) == "table" and type(v.id) == "number" then
            if v.id > nextId then
                nextId = v.id
            end
            table.insert(self.list, v)
            self.byId[v.id] = v
        elseif type(v) == "string" then
            local id = i
            local item = { id = id, characteristic = v }
            if id > nextId then
                nextId = id
            end
            table.insert(self.list, item)
            self.byId[id] = item
        else
            -- ignore invalid entries
        end
    end

    self._nextId = nextId + 1
    return self
end

function CharacteristicManager:GetAll()
    return self.list
end

function CharacteristicManager:GetById(id)
    return self.byId[id]
end

function CharacteristicManager:GetIndexById(id)
    for i, v in ipairs(self.list) do
        if v.id == id then
            return i
        end
    end
    return nil
end

function CharacteristicManager:FindByText(text)
    if not text then
        return nil
    end
    local needle = tostring(text):lower()
    for _, v in ipairs(self.list) do
        if type(v.characteristic) == "string" and v.characteristic:lower():find(needle, 1, true) then
            return v
        end
    end
    return nil
end

function CharacteristicManager:Add(characteristic, id)
    assert(characteristic and characteristic ~= "", "characteristic required")
    local newId = id
    if newId == nil then
        newId = self._nextId
        self._nextId = self._nextId + 1
    else
        -- ensure we don't clash
        if self.byId[newId] then
            error("id already exists: " .. tostring(newId))
        end
        if newId >= self._nextId then
            self._nextId = newId + 1
        end
    end
    local item = { id = newId, characteristic = characteristic }
    table.insert(self.list, item)
    self.byId[newId] = item
    return item
end

function CharacteristicManager:RemoveById(id)
    local idx = self:GetIndexById(id)
    if not idx then
        return false
    end
    table.remove(self.list, idx)
    self.byId[id] = nil
    return true
end

function CharacteristicManager:UpdateById(id, patch)
    local item = self.byId[id]
    if not item then
        return nil
    end
    for k, v in pairs(patch) do
        item[k] = v
    end
    return item
end

function CharacteristicManager:ToArray()
    -- return shallow copy of array to avoid accidental mutation
    local out = {}
    for i, v in ipairs(self.list) do
        out[i] = v
    end
    return out
end

return CharacteristicManager
