local PlacesManager = {}
PlacesManager.__index =PlacesManager
function PlacesManager.new(places)
    local self = setmetatable({
        places = places,
        free_places = places,
        bussy_places = {}
    })
end



-- надо дописать, получение игровой зоны и разширение,или сделать количество площадок под игроков,
-- 
-- 
function PlacesManager.getFreePlace(self)
    if #self.free_places >= 1 then
        return self.free_places[1]
        
    else
        print("not have free places")
        return nil
    end 

end 

function  PlacesManager.setBussyPlace(self)
    local freePlace = self.getFreePlace()
    table.insert(self.bussy_places.insert, freePlace)
    table.remove(self.free_places.remove,1)
end 


function PlacesManager.PlaceToFree(self)
    print("to do free bussy place")
end 

return PlacesManager