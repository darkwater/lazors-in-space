Bullet = class("Bullet", Entity)

---
-- Bullet:initialize
-- Creates an basic bullet.
--
-- @param x         X position
-- @param y         Y position
-- @param ang       Angle at which the bullet is travelling
-- @param force     Force of the bullet
-- @param colgroup  Collision group of the bullet
-- @param shape     Optional Shape of the bullet
--
function Bullet:initialize(x, y, ang, force, colgroup, shape)

    Entity.initialize(self, x, y, "dynamic", shape or love.physics.newPolygonShape(-8,-2 , 8,-2, 8,2 , -8,2))
    self.body:setAngle(ang)
    self.body:setBullet(true)

    self.xforce = math.cos(ang) * force
    self.yforce = math.sin(ang) * force
    self.body:applyLinearImpulse(self.xforce, self.yforce)

    self.fixture:setGroupIndex(colgroup)

    self.isBullet = true
    self.damage = 1

end


---
-- Bullet:impact
-- Gets called on impact. This will destroy the bullet.
--
function Bullet:impact()

    BulletImpact:new(self.body:getX(), self.body:getY())
    sounds.play("bullet_hit")
    self:destroy()

end


---
-- Bullet:update
-- Updates the bullet.
--
function Bullet:update()

    -- self.body:applyForce(self.xspeed, self.yspeed)

end


---
-- Bullet:draw
-- Draws the bullet.
--
function Bullet:draw()

    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))

end
