StaticDebris = class("StaticDebris", Entity)

---
-- StaticDebris:initialize
-- Creates an immobile polygon shape.
--
-- @param vertices  A table of vertices
--
function StaticDebris:initialize(data)
    self.vertices = data.points

    Entity.initialize(self, 0, 0, "static", love.physics.newChainShape(true, unpack(self.vertices)))
end


---
-- StaticDebris:update
-- Updates the StaticDebris, currently does nothing.
--
-- @param dt        Delta time
--
function StaticDebris:update(dt)

end


---
-- StaticDebris:draw
-- Draws an outlined polygon.
--
function StaticDebris:draw()
    love.graphics.polygon("line", self.vertices)
end
