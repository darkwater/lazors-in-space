Arena = class("Arena", Map)

---
-- Arena:initialize
-- The base class for every map.
--
-- @returns nil     Nothing
function Arena:initialize()
    MapBoundary:new({-500,0 , 0,-500 , 500,0 , 0,500}) -- Map boundary

    StaticDebris:new({-200,-100 ,-200, 100 ,-300, 0}) -- Left deflector
    StaticDebris:new({-100,-200 , 100,-200 , 0,-300}) -- Top deflector
    StaticDebris:new({ 200,-100 , 200, 100 , 300, 0}) -- Right deflector
    StaticDebris:new({-100, 200 , 100, 200 , 0, 300}) -- Bottom deflector
end


---
-- Arena:update
-- Does the logic.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function Arena:update(dt)
    if math.random(1, 4000) == 1 then
        BaseAI:new(0, 400)
    end
    if math.random(1, 4000) == 1 then
        BaseAI:new(0, -400)
    end
    if math.random(1, 4000) == 1 then
        BaseAI:new(400, 0)
    end
    if math.random(1, 4000) == 1 then
        BaseAI:new(-400, 0)
    end
end
