MapBoundary = class("MapBoundary", Entity)

---
-- MapBoundary:initialize
-- A map boundary -- every map should have exactly one.
--
-- @param vertices  A table of vertices
--
-- @returns nil     Nothing
function MapBoundary:initialize(...)
    local vertices = {...}
    
    self.vertices = vertices
    Entity.initialize(self, 0, 0, "static", love.physics.newChainShape(true, unpack(vertices)))
end


---
-- MapBoundary:draw
-- Draws an outlined polygon.
--
-- @returns nil     Nothing
function MapBoundary:draw()
    love.graphics.polygon("line", unpack(self.vertices))
end
