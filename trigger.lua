Trigger = class("Trigger", Entity)

---
-- Trigger:initialize
-- Creates an immobile polygon shape.
--
-- @param vertices  A table of vertices
--
function Trigger:initialize(data)
    self.vertices = data.points

    self.id    = data.id or ""
    self.solid = data.solid or false

    self.triggerAnim = 0

    Entity.initialize(self, 0, 0, "static", love.physics.newChainShape(true, unpack(self.vertices)))
    self.fixture:setSensor(not self.solid)
end


---
-- Trigger:update
-- Updates the Trigger.
--
-- @param dt        Delta time
--
function Trigger:update(dt)

    if self.triggerAnim > 0 then
        self.triggerAnim = self.triggerAnim - dt * 2
    end

    if self.triggerAnim < 0 then
        self.triggerAnim = 0
    end
    
end


---
-- Trigger:impact
-- Gets called when something collides with the Trigger.
--
-- @param ent       Entity collided with
-- @param contact   Contact object of the collision
--
function Trigger:impact(ent, contact)

    self.triggerAnim = 1

    event.call("trigger", {
        trigger = self
    })

end


---
-- Trigger:draw
-- Draws an outlined polygon.
--
function Trigger:draw()

    if self.solid then

        love.graphics.setLineWidth(1 + self.triggerAnim * 3)
        love.graphics.setColor(100 + self.triggerAnim * 155, 180, 255 - self.triggerAnim * 155)
        love.graphics.polygon("line", self.vertices)

    else

        love.graphics.setColor(90, 90, 90, 90)
        love.graphics.polygon("fill", self.vertices)

    end

end
