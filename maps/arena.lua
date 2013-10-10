Arena = class("Arena", Map)

---
-- Arena:initialize
-- The base class for every map.
--
-- @returns nil     Nothing
function Arena:initialize()
    self:loadData([=[
        Everything outside brackets will be ignored, as with everything between
        brackets that's not a number, minus sign, or comma. Remember: No decimals.
        
        The first object is always the map's boundary:
        { -500,0 , 0,-500 , 500,0 , 0,500 }
    
        The rest will be StaticDebris. If you want something else, put it in the lua source.
    
        { -200,-100 ,-200, 100 ,-300, 0 }  Left deflector
        { -100,-200 , 100,-200 , 0,-300 }  Top deflector
        {  200,-100 , 200, 100 , 300, 0 }  Right deflector
        { -100, 200 , 100, 200 , 0, 300 }  Bottom deflector
    ]=])
end


---
-- Arena:update
-- Does the logic.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function Arena:update(dt)
    if editor.active then return end
    
    if math.random(1, 2000) == 1 then
        for i=1, math.random(1, 4) do
            BaseAI:new(0, 400)
        end
    end
    if math.random(1, 2000) == 1 then
        for i=1, math.random(1, 4) do
            BaseAI:new(0, -400)
        end
    end
    if math.random(1, 2000) == 1 then
        for i=1, math.random(1, 4) do
            BaseAI:new(400, 0)
        end
    end
    if math.random(1, 2000) == 1 then
        for i=1, math.random(1, 4) do
            BaseAI:new(-400, 0)
        end
    end
end
