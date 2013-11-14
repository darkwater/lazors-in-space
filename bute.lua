Bute = class("Bute", BaseAI)

---
-- Bute:initialize
-- An enemy that tries to shoot you.
--
-- @param x         X position
-- @param y         Y position
--
function Bute:initialize(x, y)
    BaseAI.initialize(self, x, y)
    self.speed = math.random(2, 5)
    -- self.turnSspeed = 500
    self.body:setLinearDamping(3)
    self.fixture:setRestitution(1)

    self.nextFire = 0
    self.fireInterval = 0.1

    self.moveOffset = math.random(-20, 20) / 180 * math.pi

    self:pushInDirection(utils.randomAngle(), 10)

    self.shield = Shield:new(self.body, 15, 2)
end


---
-- Bute:update
-- Updates the Bute.
--
-- @param dt        Time passed since last frame
--
function Bute:update(dt)
    local dx = game.ship.body:getX() - self.body:getX()
    local dy = game.ship.body:getY() - self.body:getY()
    local ang = math.atan2(dy, dx) + self.moveOffset

    self:aimInDirection(ang)

    if math.random(1, 600) > 500 + dt * 100 then
        self:pushInDirection(utils.randomAngle(), self.speed)
    end


    if self.nextFire <= love.timer.getTime() and math.random(1,200) == 1 then
        self.nextFire = love.timer.getTime() + self.fireInterval

        Bullet:new(self.body:getX(), self.body:getY(), self.body:getAngle(), 20, colgroup.ENEMY)
    end


    self.shield:update(dt)
end


---
-- Bute:draw
-- Draws the Bute.
--
function Bute:draw()
    if self.shield:isEmpty() then
        love.graphics.setColor(200, 200, 200)
    else
        love.graphics.setColor(200, 200, 240)
    end
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())

    self.shield:draw()
end
