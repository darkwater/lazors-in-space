BaseAI = class("BaseAI", CircleEntity)

---
-- BaseAI:initialize
-- The main BaseAI which can be controller by the player.
--
-- @param x         X position
-- @param y         Y position
--
-- @returns nil     Nothing
function BaseAI:initialize(x, y)
    Entity.initialize(self, x, y, "dynamic", love.physics.newCircleShape(15))
    self.speed = 50
    -- self.turnSspeed = 500
    self.fixture:setRestitution(1)

    self.fixture:setGroupIndex(colgroup.ENEMY)

    self.nextFire = 0
    self.fireInterval = 0.1

    self.damage = 1

    local ang = math.random(1, 360) / 180 * math.pi
    self.body:applyLinearImpulse(math.cos(ang) * self.speed, math.sin(ang) * self.speed)
end


---
-- BaseAI:update
-- Updates the BaseAI.
--
-- @param dt        Time passed since last frame
--
-- @returns nil     Nothing
function BaseAI:update(dt)
    local dx = game.ship.body:getX() - self.body:getX()
    local dy = game.ship.body:getY() - self.body:getY()
    self:aimInDirection(math.atan2(dy, dx))


    if self.nextFire <= love.timer.getTime() and math.random(1,200) == 1 then
        self.nextFire = love.timer.getTime() + self.fireInterval

        Bullet:new(self.body:getX(), self.body:getY(), self.body:getAngle(), 20, colgroup.ENEMY)
    end
end


---
-- BaseAI:draw
-- Draws the BaseAI.
--
-- @returns nil     Nothing
function BaseAI:draw()
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
    love.graphics.line(self.body:getX(), self.body:getY(), self.body:getWorldPoint(15, 0))
end


---
-- BaseAI:impact
-- Gets called whenever there's a collision with another entity.
--
-- @param ent       The entity collided with
-- @param contact   The contact object of the collision
--
-- @returns nil     Nothing
function BaseAI:impact(ent, contact)
    local hp = ent.damage or 0
    if hp > 0 then
    -- self.shield:takeDamage(hp)
        self:destroy()
    end
end


---
-- BaseAI:moveInDirection
-- Move the BaseAI into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param speedMul  Speed multiplier, 1 is normal speed
--
-- @returns nil     Nothing
function BaseAI:moveInDirection(ang, speedMul)
    if not speedMul then speedMul = 1 end

    self.body:applyForce(math.cos(ang) * self.speed * speedMul, math.sin(ang) * self.speed * speedMul)
end


---
-- BaseAI:aimInDirection
-- Aims the BaseAI into a specific direction
--
-- @param ang       The angle of the direction (radians)
--
-- @returns nil     Nothing
function BaseAI:aimInDirection(ang)
    self.body:setAngle(ang)
end
