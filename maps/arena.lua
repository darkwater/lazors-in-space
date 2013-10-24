Arena = class("Arena", Map)

---
-- Arena:initialize
-- The base class for every map.
--
-- @returns nil     Nothing
function Arena:initialize()
    self:loadData([=[

        // Format:
        //     { ObjectClass: parameter1, parameter2, ..., parameterN }
        
        { MapBoundary: -500,0 , 0,-500 , 500,0 , 0,500 }
    
        { StaticDebris: -200,-100 ,-200, 100 ,-300, 0 }  // Left deflector
        { StaticDebris: -100,-200 , 100,-200 , 0,-300 }  // Top deflector
        { StaticDebris:  200,-100 , 200, 100 , 300, 0 }  // Right deflector
        { StaticDebris: -100, 200 , 100, 200 , 0, 300 }  // Bottom deflector

        { EntitySpawner: -400, 0, BaseAI, 0, [1, 12], [1, 4] }  // Left spawner
        { EntitySpawner:  0,-400, BaseAI, 0, [1, 12], [1, 4] }  // Top spawner
        { EntitySpawner:  400, 0, BaseAI, 0, [1, 12], [1, 4] }  // Right spawner
        { EntitySpawner:  0, 400, BaseAI, 0, [1, 12], [1, 4] }  // Bottom spawner
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

end
