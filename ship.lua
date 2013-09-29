Ship = class("Ship", CircleEntity)

---
-- Ship:initialize
-- The main ship which can be controller by the player.
--
-- @param x         X position
-- @param y         Y position
--
-- @returns nil     Nothing
function Ship:initialize(x, y)
    Entity.initialize(self, x, y, "dynamic", love.physics.newCircleShape(15))
    self.speed = 500
    -- self.turnSspeed = 500
    self.body:setLinearDamping(10)
    self.body:setAngularDamping(1)

    self.fixture:setGroupIndex(colgroup.PLAYER)

    self.nextFire = 0
    self.fireInterval = 0.1
end


---
-- Ship:update
-- Updates the ship.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function Ship:update(dt)
    local mx, my = 0, 0
    my = my + (love.keyboard.isDown("w") and -1 or 0)
    my = my + (love.keyboard.isDown("s") and  1 or 0)
    mx = mx + (love.keyboard.isDown("a") and -1 or 0)
    mx = mx + (love.keyboard.isDown("d") and  1 or 0)

    if mx ~= 0 or my ~= 0 then
        local ang = math.atan2(my, mx)
        self:moveInDirection(ang, 1)
    end


    if love.window.hasMouseFocus() then
        local dx = love.mouse.getX() - self.body:getX()
        local dy = love.mouse.getY() - self.body:getY()
        self:aimInDirection(math.atan2(dy, dx))
    end


    if love.mouse.isDown("l") and self.nextFire <= love.timer.getTime() then
        self.nextFire = love.timer.getTime() + self.fireInterval

        Bullet:new(self.body:getX(), self.body:getY(), self.body:getAngle(), 20, colgroup.PLAYER)
    end
end


---
-- Ship:draw
-- Draws the ship.
--
-- @returns nil     Nothing
function Ship:draw()
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
    love.graphics.line(self.body:getX(), self.body:getY(), self.body:getWorldPoint(15, 0))
end


---
-- Ship:moveInDirection
-- Move the ship into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param speedMul  Speed multiplayer, 1 is normal speed
--
-- @returns nil     Nothing
function Ship:moveInDirection(ang, speedMul)
    if not speedMul then speedMul = 1 end

    self.body:applyForce(math.cos(ang) * self.speed * speedMul, math.sin(ang) * self.speed * speedMul)
end


---
-- Ship:aimInDirection
-- Aims the ship into a specific direction
--
-- @param ang       The angle of the direction (radians)
--
-- @returns nil     Nothing
function Ship:aimInDirection(ang)
    self.body:setAngle(ang)
end
