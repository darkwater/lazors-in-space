StaticDebris = class("StaticDebris", Entity)

---
-- StaticDebris:initialize
-- Creates an immobile polygon shape.
--
-- @param vertices  A table of vertices
--
-- @returns nil     Nothing
function StaticDebris:initialize(vertices)
    Entity.initialize(self, 0, 0, "static", love.physics.newPolygonShape(unpack(vertices)))
end


---
-- StaticDebris:draw
-- Draws an outlined polygon.
--
-- @returns nil     Nothing
function StaticDebris:draw()
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end
