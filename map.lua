Map = class("Map")

---
-- Map:initialize
-- The base class for every map.
--
function Map:initialize()
    self.mapname = ""
    self.mapdata = {}
    self.maplogic = nil
end


---
-- Map:update
-- Calls map logic if it exists.
--
-- @param dt        Time passed since last frame
--
function Map:update(dt)

    if self.maplogic then

        self.maplogic:update(dt)

    end
    
end


---
-- Map:draw
-- Does nothing by default, override this in a subclass.
--
function Map:draw()
    
end


---
-- Map:loadData
-- Loads a map.
--
-- @param name      Name of the map
--
function Map:loadMap(pack, map, lua)

    self.mapname = map
    self.maplogic = nil

    game.objects = {}


    if love.filesystem.exists("content/" .. pack .. "/lua/" .. lua[1]) then

        local ok, chunk = pcall(love.filesystem.load, "content/" .. pack .. "/lua/" .. lua[1]) -- TODO: Support multiple lua files

        if not ok then

            return false

        end

        local ok, result = pcall(chunk)

        if not ok then

            return false

        end

        self.maplogic = result:new()

    end


    local str = love.filesystem.read("content/" .. pack .. "/maps/" .. map)
    self.mapdata = json.decode(str)

    for k,v in pairs(self.mapdata.mapdata) do

        local classname = v[1]
        if _G[classname] then
            table.insert(game.objects, _G[classname]:new(v[2]))
        end

    end

    return true

end
