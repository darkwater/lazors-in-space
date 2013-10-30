CircleEntity = class("CircleEntity", Entity)

---
-- CircleEntity:initialize
-- The base class for every entity that should behave like a circle.
--
-- @param x         X position
-- @param y         Y position
-- @param bodyType  "statis", "dynamic" or "kinematic"
-- @param radius    The size of the circle
--
function CircleEntity:initialize(x, y, bodyType, radius)
    Entity.initialize(self, x, y, bodyType, love.physics.newCircleShape(radius))
end


---
-- CircleEntity:draw
-- Draws an outlined circle, you should override this in a subclass.
--
function CircleEntity:draw()
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
end
