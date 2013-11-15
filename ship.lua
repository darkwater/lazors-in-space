Ship = class("Ship", CircleEntity)

---
-- Ship:initialize
-- The main ship which can be controller by the player.
--
-- @param x         X position
-- @param y         Y position
--
function Ship:initialize(x, y)
    Entity.initialize(self, x, y, "dynamic", love.physics.newCircleShape(15))
    self.speed = 500
    -- self.turnSspeed = 500
    self.body:setLinearDamping(10)
    self.body:setAngularDamping(1)

    self.fixture:setGroupIndex(colgroup.PLAYER)

    self.nextFire = 0
    self.fireInterval = 0.08
    self.fireSpread = false -- to toggle between double/single shot
    self.spread = 0.1 -- TODO: change spread according to distance of mouse?

    self.damage = 5

    self.shield = Shield:new(self.body, 22, 10)
end


---
-- Ship:update
-- Updates the ship.
--
-- @param dt        Time passed since last frame
--
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
        local dx = game.mousex - self.body:getX()
        local dy = game.mousey - self.body:getY()
        self:aimInDirection(math.atan2(dy, dx))
    end


    if love.mouse.isDown("l") and self.nextFire <= love.timer.getTime() then
        self.nextFire = love.timer.getTime() + self.fireInterval

        if self.fireSpread then
            self:shoot(self.body:getAngle() + self.spread)
            self:shoot(self.body:getAngle() - self.spread)
        else
            self:shoot(self.body:getAngle())
        end
        self.fireSpread = not self.fireSpread

        sounds.play("player_shoot")
    end


    self.shield:update(dt)
end


---
-- Ship:impact
-- Gets called whenever there's a collision with another entity.
--
-- @param ent       The entity collided with
-- @param contact   The contact object of the collision
--
function Ship:impact(ent, contact)
    local hp = ent.damage or 0

    if hp > 0 then
        sounds.play("player_hit")

        if not self.shield:isEmpty() then
            self.shield:takeDamage(hp)
        else
            game.over = true
        end
    end
end


---
-- Ship:draw
-- Draws the ship.
--
function Ship:draw()
    love.graphics.setColor(255, 50, 50) -- temporary
    love.graphics.circle("line", self.body:getX(), self.body:getY(), self.shape:getRadius(), self.shape:getRadius())
    love.graphics.line(self.body:getX(), self.body:getY(), self.body:getWorldPoint(15, 0))
    self.shield:draw()
end


---
-- Ship:moveInDirection
-- Move the ship into a specific direction
--
-- @param ang       The angle of the direction (radians)
-- @param speedMul  Speed multiplier, 1 is normal speed
--
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
function Ship:aimInDirection(ang)
    self.body:setAngle(ang)
end


---
-- Ship:shoot
-- Shoots a bullet
--
-- @param ang       The direction of the bullet (radians)
--
function Ship:shoot(ang)
    local dx = math.cos(ang) * 15
    local dy = math.sin(ang) * 15
    Bullet:new(self.body:getX() + dx, self.body:getY() + dy, ang, 12, colgroup.PLAYER)
end
