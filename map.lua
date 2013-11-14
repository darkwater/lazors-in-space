Map = class("Map")

---
-- Map:initialize
-- The base class for every map.
--
function Map:initialize()
    self.mapname = ""
    self.mapdata = {}
end


---
-- Map:update
-- Does nothing by default, override this in a subclass.
--
-- @param dt        Time passed since last frame
--
function Map:update()
    
end


---
-- Map:loadData
-- Does nothing by default, override this in a subclass.
--
-- @param dt        Time passed since last frame
--
function Map:loadMap(name)

    self.mapname = name

    game.objects = {}

    local str = love.filesystem.read("maps/" .. name)
    self.mapdata = json.decode(str)

    for k,v in pairs(self.mapdata.mapdata) do
        local classname = v[1]
        if _G[classname] then
            table.insert(game.objects, _G[classname]:new(v[2]))
        end
    end

end
