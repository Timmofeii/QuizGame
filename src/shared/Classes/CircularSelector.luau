--!strict
-- ...existing code...

--- Circular selector utility
--- @class CircularSelector<T>
--- @field list T[]
--- @field index number
local CircularSelector = {}
CircularSelector.__index = CircularSelector

--- Create a new CircularSelector
--- @generic T
--- @param list T[] list of items
--- @return CircularSelector<T>
function CircularSelector.new(list)
    local self = setmetatable({ list = list, index = 1 }, CircularSelector) :: any
    
    self.index = #list > 0 and 1 or 0
    return self :: any
end

-- ...existing code...
--- @param self CircularSelector<T>
--- @param n number?
function CircularSelector:step(n: number?)
    local step: number = (n or 1) :: number
    local len = #self.list
    if len == 0 then
        return nil
    end
    self.index = ((self.index - 1 + step) % len) + 1
    return self.list[self.index]
end

-- ...existing code...

return CircularSelector
-- ...existing code...
-- ...existing code...