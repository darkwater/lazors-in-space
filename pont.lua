Pont = class("Pont", BaseAI)

---
-- Pont:initialize
-- An enemy that follows you around.
--
-- @param x         X position
-- @param y         Y position
--
function Pont:initialize(x, y)
    BaseAI.initialize(self, x, y)
    self.speed = math.random(50, 65)
    -- self.turnSspeed = 500
    self.body:setLinearDamping(3)
    self.fixture:setRestitution(1)

    self.moveOffset = math.random(-20, 20) / 180 * math.pi

    local ang = math.random(1, 360) / 180 * math.pi
    self.body:applyLinearImpulse(math.cos(ang) * 10, math.sin(ang) * 10)

    self.shield = Shield:new(self.body, 15, 1)

    self.points = 5
end


---
-- Pont:update
-- Updates the Pont.
--
-- @param dt        Time passed since last frame
--
function Pont:update(dt)
    local dx = game.ship.body:getX() - self.body:getX()
    local dy = game.ship.body:getY() - self.body:getY()
    local ang = math.atan2(dy, dx) + self.moveOffset

    self:moveInDirection(ang, self.speed)


    self.shield:update(dt)
end


---
-- Pont:draw
-- Draws the Pont.
--
function Pont:draw()
    if self.shield:isEmpty() then
        love.graphics.setColor(200, 200, 200)
    else
        love.graphics.setColor(200, 200, 240)
    end
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
end
