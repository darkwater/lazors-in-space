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
    self.speed = math.random(5, 10)
    -- self.turnSspeed = 500
    self.body:setLinearDamping(0.1)
    self.fixture:setRestitution(1)

    self.nextFire = 0
    self.fireInterval = {100, 500}

    self.nextMove = 0
    self.moveInterval = {10, 200}

    self.moveOffset = math.random(-20, 20) / 180 * math.pi

    self:pushInDirection(utils.randomAngle(), 10)

    self.shield = Shield:new(self.body, 15, 2)

    self.points = 15
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

    if self.nextMove <= love.timer.getTime() then
        self.nextMove = love.timer.getTime() + math.random(unpack(self.moveInterval)) / 100

        self:pushInDirection(utils.randomAngle(), self.speed)
    end


    if self.nextFire <= love.timer.getTime() then
        self.nextFire = love.timer.getTime() + math.random(unpack(self.fireInterval)) / 100

        Bullet:new(self.body:getX(), self.body:getY(), self.body:getAngle(), 8, colgroup.ENEMY)
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